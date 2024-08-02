import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import '../model/quran_audio_model.dart'; // Ensure this import path is correct

class AudioPlayerController extends GetxController {
  var isPlaying = false.obs;
  var currentAudio = Rxn<AudioFile>();
  var progress = 0.0.obs;
  var duration = 0.0.obs;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.onPositionChanged.listen((position) {
      progress.value = position.inMilliseconds.toDouble();
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      this.duration.value = duration.inMilliseconds.toDouble();
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });
  }

  void playOrPauseAudio(AudioFile audio) async {
    if (isPlaying.value && currentAudio.value?.id == audio.id) {
      // If the same audio is playing, pause it
      await _audioPlayer.pause();
      isPlaying.value = false;
    } else {
      // If a different audio is playing or no audio is playing, play the new one
      currentAudio.value = audio;
      // Stop any current playback before setting a new source
      await _audioPlayer.stop();
      await _audioPlayer.setSourceUrl(audio.audioUrl);
      await _audioPlayer.resume();
      isPlaying.value = true;
    }
  }

  void stopAudio() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
    currentAudio.value = null;
  }
}
