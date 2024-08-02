import 'package:community_islamic_app/controllers/quran_controller.dart';
import 'package:community_islamic_app/views/quran_screen.dart/surah_detail_screen.dart';
import 'package:community_islamic_app/widgets/customized_surah_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/image_constants.dart';
import '../../controllers/audio_controller.dart';
import '../../model/quran_audio_model.dart';

import '../../widgets/audio_player_bar_widget.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

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
      body: Column(
        children: [
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
                          image: AssetImage(qiblaTopBg),
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
          Expanded(
            child: Obx(() {
              if (quranController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (quranController.chapters.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  itemCount: quranController.chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = quranController.chapters[index];
                    final audio = quranController.audioFiles.firstWhere(
                        (audio) => audio.chapterId == chapter.id,
                        orElse: () => AudioFile(
                            id: 0,
                            chapterId: 0,
                            fileSize: 0,
                            format: Format.MP3,
                            audioUrl: ''));

                    return SizedBox(
                      height: 70,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomizedSurahWidget(
                            onTap1: () {},
                            onTap2: () {
                              audioController.playOrPauseAudio(audio);
                            },
                            surahOnTap: () {
                              Get.to(() => SurahDetailsScreen(
                                    audioPlayerUrl: audio.audioUrl,
                                    surahName: chapter.nameArabic,
                                    surahNumber: chapter.id,
                                    surahverseCount: chapter.versesCount,
                                    englishVerse: chapter.nameArabic,
                                    verse: chapter.nameSimple,
                                  ));
                            },
                            firstIcon: Icons.book,
                            secondIcon: audioController.isPlaying.value &&
                                    audioController.currentAudio.value?.id ==
                                        audio.id
                                ? Icons.pause
                                : Icons.play_arrow,
                            surahTxet: chapter.nameArabic,
                            thirdIcon: kabbaIcon,
                            surahNumber: chapter.id,
                            onTapNavigation: () {
                              Get.to(() => SurahDetailsScreen(
                                    audioPlayerUrl: audio.audioUrl,
                                    surahName: chapter.nameArabic,
                                    surahNumber: chapter.id,
                                    surahverseCount: chapter.versesCount,
                                    englishVerse: chapter.nameComplex,
                                    verse: chapter.nameComplex,
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
          Obx(() {
            return AudioPlayerBar(
              audioPlayerController: audioController,
              isPlaying: audioController.isPlaying.value,
              currentAudio: audioController.currentAudio.value,
              onPlayPause: () {
                if (audioController.currentAudio.value != null) {
                  audioController
                      .playOrPauseAudio(audioController.currentAudio.value!);
                }
              },
              onStop: audioController.stopAudio, onNext: () {  }, onPrevious: () {  },
            );
          }),
          100.heightBox
        ],
      ),
    );
  }
}
