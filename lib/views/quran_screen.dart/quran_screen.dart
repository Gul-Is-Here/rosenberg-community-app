import 'package:community_islamic_app/controllers/quran_controller.dart';
import 'package:community_islamic_app/widgets/customized_surah_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/image_constants.dart';
import '../../controllers/audio_controller.dart';
import '../../model/quran_audio_model.dart';
import '../../model/quran_model.dart';
import 'surah_detail_screen.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.put(QuranController());
    final AudioPlayerController audioController =
        Get.put(AudioPlayerController());
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Obx(() {
        if (quranController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (quranController.chapters.isEmpty) {
          return const Center(child: Text('No chapters available'));
        }

        return Column(
          children: [
            // Header Section
            SizedBox(
              height: screenHeight * .25,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        height: screenHeight * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(qiblaTopBg), // Background image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.01,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            maxRadius: 35,
                            minRadius: 10,
                            backgroundColor: Colors.white,
                            child: Icon(
                              size: 60,
                              Icons.person,
                              color: Colors.amber,
                            ),
                          ),
                          20.widthBox,
                          const Text(
                            'Assalamualaikum \nGul Faraz',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.13,
                    left: screenHeight * 0.18,
                    child: Text(
                      'Quran',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // List of Surahs
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: quranController.chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = quranController.chapters[index];
                    final surah =
                        quranController.getSurahByChapterId(chapter.id);

                    final audio = quranController.audioFiles.firstWhere(
                      (audio) => audio.chapterId == chapter.id,
                      orElse: () => AudioFile(
                          id: 0,
                          chapterId: 0,
                          fileSize: 0,
                          format: Format.MP3,
                          audioUrl: ''),
                    );

                    return SizedBox(
                      height: 70,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomizedSurahWidget(
                            onTap1: () {
                              print('----Surah-------');
                              print(surah);
                            },
                            onTap2: () {
                              if (audio.audioUrl.isNotEmpty) {
                                audioController.playOrPauseAudio(audio);
                              } else {
                                print(
                                    'Audio file not found for chapter ${chapter.id}');
                              }
                            },
                            surahOnTap: () async {
                              if (surah != null) {
                                // Stop any currently playing audio
                                // audioController.stopAudio();

                                // Fetch translation data and navigate to SurahDetailsScreen
                                await quranController
                                    .fetchTranslationData(chapter.id);
                                Get.to(() => SurahDetailsScreen(
                                      surahM: surah,
                                      surahVerseCount: surah.ayahs.length,
                                      surahVerseEng:
                                          quranController.translationData,
                                      audioPlayerUrl: audio,
                                      surahName: surah.name,
                                      surahNumber: surah.number,
                                      englishVerse: surah.englishName,
                                      verse: surah.name,
                                      surahVerse: surah.ayahs,
                                    ));
                              }
                            },
                            firstIcon: Icons.book,
                            secondIcon: audioController.isPlaying.value &&
                                    audioController.currentAudio.value?.id ==
                                        audio.id
                                ? Icons.pause
                                : Icons.play_arrow,
                            surahTxet: surah?.name ?? 'Surah not found',
                            thirdIcon: chapter.revelationPlace ==
                                    RevelationPlace.MAKKAH
                                ? kabbaIcon
                                : masjidIcon,
                            surahNumber: chapter.id,
                            onTapNavigation: () async {
                              if (surah != null) {
                                await quranController
                                    .fetchTranslationData(chapter.id);
                                Get.to(() => SurahDetailsScreen(
                                      surahM: surah,
                                      surahVerseCount: surah.ayahs.length,
                                      surahVerseEng:
                                          quranController.translationData,
                                      audioPlayerUrl: audio,
                                      surahName: surah.name,
                                      surahNumber: surah.number,
                                      englishVerse: surah.englishName,
                                      verse: surah.name,
                                      surahVerse: surah.ayahs,
                                    ));
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
