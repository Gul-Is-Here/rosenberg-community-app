import 'package:community_islamic_app/controllers/audio_controller.dart';
import 'package:community_islamic_app/widgets/audio_player_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/quran_audio_model.dart';

class SurahDetailsScreen extends StatelessWidget {
  final int surahNumber;
  final String surahName;
  final int surahverseCount;
  final String verse;
  final String englishVerse;
  final String audioPlayerUrl;

  const SurahDetailsScreen({
    super.key,
    required this.audioPlayerUrl,
    required this.surahName,
    required this.surahNumber,
    required this.surahverseCount,
    required this.englishVerse,
    required this.verse,
  });

  @override
  Widget build(BuildContext context) {
    final AudioPlayerController audioController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: const Color(0xFF0F6467),
        title: Text(
          '$surahNumber. $surahName',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Implement download functionality if needed
            },
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$surahverseCount verses | $verse',
                style: const TextStyle(fontSize: 16, color: Color(0xFF0F6467)),
              ),
              const Divider(),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                color: Colors.red,
                height: 200,
                width: double.infinity,
                child: Text('Ayat Container'),
              ),
              // Add widgets to display individual Ayats if needed
              const SizedBox(height: 20),
              Obx(() {
                return AudioPlayerBar(
                  audioPlayerController: audioController,
                  isPlaying: audioController.isPlaying.value,
                  currentAudio: audioController.currentAudio.value,
                  onPlayPause: () {
                    final audioFile = AudioFile(
                      id: 0,
                      chapterId: surahNumber,
                      fileSize: 0,
                      format: Format.MP3,
                      audioUrl: audioPlayerUrl,
                    );
                    audioController.playOrPauseAudio(audioFile);
                  },
                  onStop: audioController.stopAudio, onNext: () {  }, onPrevious: () {  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
