import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_islamic_app/controllers/audio_controller.dart';
import 'package:community_islamic_app/controllers/quran_controller.dart';
import 'package:community_islamic_app/model/surah_detail_model.dart';
import 'package:community_islamic_app/widgets/audio_player_bar_widget.dart';
import 'package:quran/surah_data.dart';

import '../../model/quran_audio_model.dart';
import '../../model/surah_english_model.dart';

class SurahDetailsScreen extends StatefulWidget {
  final int surahNumber;
  final Surah surahM;
  final String surahName;
  final int surahVerseCount;
  final String verse;
  final String englishVerse;
  final AudioFile audioPlayerUrl;
  final List<Ayah> surahVerse;
  final List<Result> surahVerseEng;

  SurahDetailsScreen({
    Key? key,
    required this.surahM,
    required this.surahVerseEng,
    required this.surahVerse,
    required this.audioPlayerUrl,
    required this.surahName,
    required this.surahNumber,
    required this.surahVerseCount,
    required this.englishVerse,
    required this.verse,
  }) : super(key: key);

  @override
  _SurahDetailsScreenState createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  late AudioPlayerController audioController;
  late QuranController quranController;
  int currentIndex = 1; // To track the current Ayah index

  @override
  void initState() {
    super.initState();
    audioController = Get.find();
    quranController = Get.find();
    playCurrentAyahAudio();
  }

  void playCurrentAyahAudio() {
    final ayah = widget.surahVerse[currentIndex];
    final audioFile = quranController.audioFiles.firstWhere(
      (audio) => audio.chapterId == widget.surahNumber,
      // You can add specific logic here if you have separate audio files for each Ayah
      orElse: () {
        print(
            'Audio file not found for Ayah ${ayah.numberInSurah} in Surah ${widget.surahNumber}');
        return AudioFile(
          id: 0,
          chapterId: widget.surahNumber,
          fileSize: 0,
          format: Format.MP3,
          audioUrl: '',
        );
      },
    );

    if (audioFile.audioUrl.isNotEmpty) {
      audioController.playOrPauseAudio(audioFile);
    }
  }

  void playNextAyah() {
    if (currentIndex < widget.surahM.number - 1) {
      print(currentIndex);
      setState(() {
        currentIndex++;
        playCurrentAyahAudio();
      });
    }
  }

  void playPreviousAyah() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        playCurrentAyahAudio();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          '${widget.surahNumber}. ${widget.surahName}',
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
                    '${widget.surahVerseCount} verses | ${widget.englishVerse}',
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xFF0F6467)),
                  ),
                  const Divider(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.surahVerse.length,
                      itemBuilder: (context, index) {
                        final ayah = widget.surahVerse[index];
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
              totalVerseCount: 'Verses ${widget.surahVerse.length}',
              audioPlayerController: audioController,
              isPlaying: audioController.isPlaying.value,
              currentAudio: audioController.currentAudio.value,
              onPlayPause: () {
                final audioFile = quranController.audioFiles.firstWhere(
                  (audio) => audio.chapterId == widget.surahNumber,
                  orElse: () {
                    print(
                        "Audio file not found for Surah number ${widget.surahNumber}");
                    return AudioFile(
                      id: 0,
                      chapterId: widget.surahNumber,
                      fileSize: 0,
                      format: Format.MP3,
                      audioUrl: '',
                    );
                  },
                );

                if (audioFile.audioUrl.isNotEmpty) {
                  audioController.playOrPauseAudio(audioFile);
                }
              },
              onStop: audioController.stopAudio,
              onNext: playNextAyah,
              onPrevious: playPreviousAyah,
            );
          }),
        ],
      ),
    );
  }
}
