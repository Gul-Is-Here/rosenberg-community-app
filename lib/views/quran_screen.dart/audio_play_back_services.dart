import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerTask extends BackgroundAudioTask {
  final _player = AudioPlayer();
  
  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    _player.playbackEventStream.listen((event) {
      if (event.processingState == AudioProcessingState.completed) {
        onStop();
      }
    });
    // Load and start playing audio
    await _player.setUrl(params?['url'] ?? '');
    _player.play();
  }

  @override
  Future<void> onStop() async {
    await _player.stop();
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    await _player.play();
  }

  @override
  Future<void> onPause() async {
    await _player.pause();
  }

  @override
  Future<void> onSeekTo(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> onSetSpeed(double speed) async {
    _player.setSpeed(speed);
  }
}
