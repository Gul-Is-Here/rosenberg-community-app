import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerTask extends BackgroundAudioTask {
  final _player = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    // Your code to start playing audio
    await _player.setUrl(params?['url'] ?? '');
    _player.play();
    AudioServiceBackground.setState(
      controls: [
        MediaControl.play,
        MediaControl.pause,
        MediaControl.stop,
        MediaControl.skipToNext,
        MediaControl.skipToPrevious
      ],
      systemActions: [
        MediaAction.seek,
        MediaAction.play,
        MediaAction.pause,
      ],
      playing: _player.playing,
      position: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    );
  }

  @override
  Future<void> onPlay() async {
    await _player.play();
    AudioServiceBackground.setState(
      playing: true,
      position: _player.position,
    );
  }

  @override
  Future<void> onPause() async {
    await _player.pause();
    AudioServiceBackground.setState(
      playing: false,
      position: _player.position,
    );
  }

  @override
  Future<void> onStop() async {
    await _player.stop();
    await super.onStop();
  }
}
