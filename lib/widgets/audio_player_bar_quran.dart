import 'package:community_islamic_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/audio_controller.dart';
import '../model/quran_audio_model.dart';

class AudioPlayerBar2 extends StatelessWidget {
  final AudioPlayerController audioPlayerController;
  final bool isPlaying;
  final AudioFile? currentAudio;
  final VoidCallback onPlayPause;
  final VoidCallback onStop;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const AudioPlayerBar2({
    super.key,
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
      final isRepeating = audioPlayerController.isRepeating.value;
      final playbackSpeed = audioPlayerController.playbackSpeed.value;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 10),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Text(
                        '$playbackSpeed x',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: audioPlayerController.toggleSpeed,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(Icons.skip_previous, onPrevious),
                _buildIconButton(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  onPlayPause,
                  size: 60,
                ),
                _buildIconButton(Icons.stop, onStop),
                _buildIconButton(Icons.skip_next, onNext),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 5.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: (1 - (progress / duration)) *
                        MediaQuery.of(context).size.width,
                    child: Container(
                      height: 5.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(Duration(milliseconds: progress.toInt())),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  formatDuration(Duration(milliseconds: duration.toInt())),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  isRepeating ? Icons.repeat_one : Icons.repeat_one_outlined,
                  color: Colors.white,
                ),
                onPressed: audioPlayerController.toggleRepeat,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed,
      {double size = 50}) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: size),
      onPressed: onPressed,
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
