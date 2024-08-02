import 'package:audioplayers/audioplayers.dart'; // Ensure you import the correct AudioPlayer package
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/audio_controller.dart';
import '../model/quran_audio_model.dart';

class AudioPlayerBar extends StatelessWidget {
  final AudioPlayerController audioPlayerController;
  final bool isPlaying;
  final AudioFile? currentAudio;
  final VoidCallback onPlayPause;
  final VoidCallback onStop;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const AudioPlayerBar({
    required this.audioPlayerController,
    required this.isPlaying,
    required this.currentAudio,
    required this.onPlayPause,
    required this.onStop,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final progress = audioPlayerController.progress.value;
      final duration = audioPlayerController.duration.value;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.black,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.skip_previous, color: Colors.white),
              onPressed: onPrevious,
            ),
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white),
              onPressed: onPlayPause,
            ),
            IconButton(
              icon: Icon(Icons.stop, color: Colors.white),
              onPressed: onStop,
            ),
            IconButton(
              icon: Icon(Icons.skip_next, color: Colors.white),
              onPressed: onNext,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 4.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      gradient: LinearGradient(
                        colors: [Colors.greenAccent, Colors.green],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: (1 - (progress / duration)) * 100,
                          child: Container(
                            height: 4.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(
                            Duration(milliseconds: progress.toInt())),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        formatDuration(
                            Duration(milliseconds: duration.toInt())),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
