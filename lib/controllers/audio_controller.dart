import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../model/quran_audio_model.dart';
import 'package:audio_service/audio_service.dart';
import '../views/audio_screen/audio_handler.dart';

class AudioPlayerController extends GetxController {
  var isPlaying = false.obs;
  var progress = 0.0.obs;
  var duration = 1.0.obs;
  var playbackSpeed = 1.0.obs;
  var isRepeating = false.obs;
  var currentAudio = Rxn<AudioFile>();

  AudioPlayerHandler? _audioHandler;
  final List<double> speedOptions = [0.5, 1.0, 1.5, 2.0];
  var isAudioHandlerInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initAudioService();
  }

  @override
  void onClose() {
    _disposeAudioService();
    super.onClose();
  }

  Future<void> _initAudioService() async {
    try {
      // Ensure any existing audio service is stopped
      await AudioService.stop();

      // Initialize AudioService
      _audioHandler = await AudioService.init(
        builder: () => AudioPlayerHandler(),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.community.islamic.app',
          androidNotificationChannelName: 'adhan_channel',
          androidNotificationOngoing: true,
        ),
      );

      isAudioHandlerInitialized.value = true;

      // Set up listeners for playback state and media item changes
      _audioHandler?.playbackState.listen((playbackState) {
        isPlaying.value = playbackState.playing;
        progress.value = playbackState.position.inMilliseconds.toDouble();
        duration.value =
            playbackState.bufferedPosition.inMilliseconds.toDouble();
        playbackSpeed.value = playbackState.speed;
      });

      _audioHandler?.mediaItem.listen((mediaItem) {
        if (mediaItem != null) {
          currentAudio.value = AudioFile(
            id: mediaItem.hashCode,
            audioUrl: mediaItem.id,
            chapterId: mediaItem.hashCode,
            fileSize: 1122,
            format: Format.MP3,
          );
        }
      });
    } catch (e) {
      // Handle initialization errors
      print('Error initializing audio service: $e');
    }
  }

  Future<void> _disposeAudioService() async {
    if (_audioHandler != null) {
      await _audioHandler!.stop();
      _audioHandler = null;
      isAudioHandlerInitialized.value = false;
    }
  }

  Future<void> playOrPauseAudio(AudioFile audio) async {
    if (!isAudioHandlerInitialized.value) {
      print('AudioHandler is not initialized yet');
      return;
    }

    try {
      if (currentAudio.value?.id == audio.id && isPlaying.value) {
        await _audioHandler!.pause();
      } else {
        // Ensure the player is stopped and reset before playing a new file
        await _audioHandler!.stop();
        await _audioHandler!.setAudioFile(audio);
        await _audioHandler!.play();
        currentAudio.value = audio;
      }
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      print('Error playing or pausing audio: $e');
    }
  }

  Future<void> stopAudio() async {
    if (!isAudioHandlerInitialized.value) {
      print('AudioHandler is not initialized yet');
      return;
    }

    try {
      await _audioHandler!.stop();
      currentAudio.value = null;
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      print('Error stopping audio: $e');
    }
  }

  Future<void> playNextAudio(RxList<AudioFile> audioFiles) async {
    if (currentAudio.value == null) return;

    int currentIndex =
        audioFiles.indexWhere((audio) => audio.id == currentAudio.value!.id);
    if (currentIndex == -1 || currentIndex == audioFiles.length - 1) return;

    AudioFile nextAudio = audioFiles[currentIndex + 1];
    await playOrPauseAudio(nextAudio);
  }

  Future<void> playPreviousAudio(RxList<AudioFile> audioFiles) async {
    if (currentAudio.value == null) return;

    int currentIndex =
        audioFiles.indexWhere((audio) => audio.id == currentAudio.value!.id);
    if (currentIndex <= 0) return;

    AudioFile previousAudio = audioFiles[currentIndex - 1];
    await playOrPauseAudio(previousAudio);
  }

  Future<void> setPlaybackSpeed(double speed) async {
    try {
      playbackSpeed.value = speed;
      if (isPlaying.value && _audioHandler != null) {
        await _audioHandler!.setSpeed(speed);
      }
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      print('Error setting playback speed: $e');
    }
  }

  void toggleSpeed() {
    int currentIndex = speedOptions.indexOf(playbackSpeed.value);
    int nextIndex = (currentIndex + 1) % speedOptions.length;
    setPlaybackSpeed(speedOptions[nextIndex]);
  }

  void toggleRepeat() {
    isRepeating.value = !isRepeating.value;
    if (_audioHandler != null) {
      _audioHandler!.setRepeatMode(
        (isRepeating.value ? LoopMode.one : LoopMode.off)
            as AudioServiceRepeatMode,
      );
    }
  }
}
