import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../model/quran_audio_model.dart';
// import '../views/quran_screen.dart/audio_hanadler.dart';

class AudioPlayerController extends GetxController {
  var isPlaying = false.obs;
  var progress = 0.0.obs;
  var duration = 1.0.obs;
  var playbackSpeed = 1.0.obs;
  var isRepeating = false.obs;
  var currentAudio = Rxn<AudioFile>();

  final AudioPlayer audioPlayer = AudioPlayer();
  List<AudioFile> audioFiles = [];

  final List<double> speedOptions = [0.5, 1.0, 1.5, 2.0];

  @override
  void onInit() {
    super.onInit();

    audioPlayer.positionStream.listen((Duration p) {
      progress.value = p.inMilliseconds.toDouble();
    });

    audioPlayer.durationStream.listen((Duration? d) {
      if (d != null) {
        duration.value = d.inMilliseconds.toDouble();
      }
    });

    audioPlayer.playerStateStream.listen((PlayerState state) {
      isPlaying.value = state.playing;
    });
  }

  Future<void> playOrPauseAudio(AudioFile audio) async {
    if (currentAudio.value?.id == audio.id && isPlaying.value) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.setUrl(audio.audioUrl);
      await audioPlayer.setSpeed(playbackSpeed.value);
      await audioPlayer.play();
      currentAudio.value = audio;
    }
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    isPlaying.value = false;
  }

  Future<void> playNextAudio(List<AudioFile> audioFiles) async {
    this.audioFiles = audioFiles;
    if (currentAudio.value == null) return;

    int currentIndex =
        audioFiles.indexWhere((audio) => audio.id == currentAudio.value!.id);
    if (currentIndex == -1 || currentIndex == audioFiles.length - 1) return;

    AudioFile nextAudio = audioFiles[currentIndex + 1];
    await playOrPauseAudio(nextAudio);
  }

  Future<void> playPreviousAudio(List<AudioFile> audioFiles) async {
    this.audioFiles = audioFiles;
    if (currentAudio.value == null) return;

    int currentIndex =
        audioFiles.indexWhere((audio) => audio.id == currentAudio.value!.id);
    if (currentIndex <= 0) return;

    AudioFile previousAudio = audioFiles[currentIndex - 1];
    await playOrPauseAudio(previousAudio);
  }

  Future<void> setPlaybackSpeed(double speed) async {
    playbackSpeed.value = speed;
    if (isPlaying.value) {
      await audioPlayer.setSpeed(speed);
    }
  }

  void toggleSpeed() {
    int currentIndex = speedOptions.indexOf(playbackSpeed.value);
    int nextIndex = (currentIndex + 1) % speedOptions.length;
    setPlaybackSpeed(speedOptions[nextIndex]);
  }

  void toggleRepeat() {
    isRepeating.value = !isRepeating.value;
    audioPlayer.setLoopMode(isRepeating.value ? LoopMode.one : LoopMode.off);
  }
}
