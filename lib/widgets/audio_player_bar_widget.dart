import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/quran_controller.dart';
import '../model/quran_audio_model.dart';

class AudioPlayerBar extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final AudioFile? currentAudio;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onStop;
  final QuranController quranController;

  const AudioPlayerBar({
    required this.quranController,
    required this.audioPlayer,
    required this.currentAudio,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onStop,
    Key? key,
  }) : super(key: key);

  @override
  _AudioPlayerBarState createState() => _AudioPlayerBarState();
}

class _AudioPlayerBarState extends State<AudioPlayerBar> {
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.onPositionChanged.listen((duration) {
      setState(() {
        _currentPosition = duration;
      });
    });
    widget.audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return widget.currentAudio == null
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0F6467),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://via.placeholder.com/50', // Placeholder image URL
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Surah ${widget.quranController.chapters[widget.currentAudio!.chapterId - 1].nameArabic}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Chapter ${widget.currentAudio!.chapterId}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        widget.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: widget.onPlayPause,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.stop_circle,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: widget.onStop,
                    ),
                  ],
                ),
                Slider(
                  value: _currentPosition.inSeconds.toDouble(),
                  max: _totalDuration.inSeconds.toDouble(),
                  onChanged: (value) async {
                    await widget.audioPlayer
                        .seek(Duration(seconds: value.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white54,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_currentPosition),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      _formatDuration(_totalDuration),
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
