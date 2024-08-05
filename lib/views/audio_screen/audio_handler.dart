import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';


class AudioHandler extends BaseAudioHandler {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioHandler() {
    _audioPlayer.positionStream.listen((position) {
      if (position != null) {
        playbackState.add(playbackState.value.copyWith(
          updatePosition: position,
          bufferedPosition: _audioPlayer.bufferedPosition,
          speed: _audioPlayer.speed,
          playing: _audioPlayer.playing,
        ));
      }
    });
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        playbackState.add(playbackState.value.copyWith(
          bufferedPosition: duration,
        ));
      }
    });
  }

  @override
  Future<void> play() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  @override
  Future<void> setMediaItem(MediaItem? mediaItem) async {
    if (mediaItem != null) {
      await _audioPlayer.setUrl(mediaItem.id);
    }
  }

  @override
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _audioPlayer.setSpeed(speed);
  }
}
