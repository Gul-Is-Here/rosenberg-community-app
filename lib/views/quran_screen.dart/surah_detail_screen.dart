import 'package:community_islamic_app/controllers/audio_controller.dart';
import 'package:community_islamic_app/controllers/quran_controller.dart';
import 'package:community_islamic_app/model/surah_detail_model.dart';
import 'package:community_islamic_app/widgets/audio_player_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/quran_audio_model.dart';
import '../../model/surah_english_model.dart';

class SurahDetailsScreen extends StatelessWidget {
  final int surahNumber;
  final String surahName;
  final int surahVerseCount;
  final String verse;
  final String englishVerse;
  final String audioPlayerUrl;
  final List<Ayah> surahVerse;
  final List<Result> surahVerseEng;

  const SurahDetailsScreen({
    super.key,
    required this.surahVerseEng,
    required this.surahVerse,
    required this.audioPlayerUrl,
    required this.surahName,
    required this.surahNumber,
    required this.surahVerseCount,
    required this.englishVerse,
    required this.verse,
    required int surahverseCount,
  });

  @override
  Widget build(BuildContext context) {
    final AudioPlayerController audioController = Get.find();
    final QuranController quranController = Get.find();
    final AudioFile audioFile = AudioFile(
      id: 0,
      chapterId: surahNumber,
      fileSize: 0,
      format: Format.MP3,
      audioUrl: audioPlayerUrl,
    );

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
          style: const TextStyle(color: Colors.white, fontSize: 18),
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$surahVerseCount verses | $englishVerse',
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xFF0F6467)),
                  ),
                  const Divider(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: surahVerse.length,
                      itemBuilder: (context, index) {
                        final ayah = surahVerse[index];
                        final translation =
                            quranController.translationData.firstWhere(
                          (t) => t.aya == ayah.numberInSurah.toString(),
                          orElse: () => Result(
                            id: '',
                            sura: '',
                            aya: '',
                            arabicText: '',
                            translation: 'Translation not available',
                            footnotes: '',
                          ),
                        );

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ayah ${ayah.numberInSurah}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    ayah.text,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    translation.translation,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return AudioPlayerBar(
              totalVerseCount: 'Verses ${surahVerse.length} ',
              audioPlayerController: audioController,
              isPlaying: audioController.isPlaying.value,
              currentAudio: audioController.currentAudio.value,
              onPlayPause: () {
                if (audioController.currentAudio.value != null) {
                  audioController
                      .playOrPauseAudio(audioController.currentAudio.value!);
                }
              },
              onStop: audioController.stopAudio,
              onNext: () {
                audioController.playNextAudio(quranController.audioFiles);
              },
              onPrevious: () {
                audioController.playPreviousAudio(quranController.audioFiles);
              },
            );
          }),
        ],
      ),
    );
  }
}
