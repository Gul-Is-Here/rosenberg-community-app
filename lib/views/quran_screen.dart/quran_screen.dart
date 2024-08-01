import 'package:audioplayers/audioplayers.dart';
import 'package:community_islamic_app/controllers/quran_controller.dart';
import 'package:community_islamic_app/widgets/customized_surah_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/image_constants.dart';
import '../../model/quran_audio_model.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  AudioFile? _currentAudio;
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playOrStopAudio(AudioFile audio) async {
    if (_currentAudio != null) {
      if (_currentAudio!.id == audio.id) {
        // Toggle playback
        if (_isPlaying) {
          await _audioPlayer.stop();
          setState(() {
            _isPlaying = false;
          });
        } else {
          await _audioPlayer.play(UrlSource(audio.audioUrl));
          setState(() {
            _isPlaying = true;
          });
        }
        return;
      } else {
        // Stop previous audio
        await _audioPlayer.stop();
      }
    }

    // Play new audio
    if (audio.audioUrl.isNotEmpty) {
      await _audioPlayer.play(UrlSource(audio.audioUrl));
      setState(() {
        _currentAudio = audio;
        _isPlaying = true;
      });
    } else {
      print('Audio not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    var quranController = Get.put(QuranController());
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
                              _playOrStopAudio(audio);
                            },
                            surahOnTap: () {},
                            firstIcon: Icons.book,
                            secondIcon: Icons.play_arrow,
                            surahTxet: chapter.nameArabic,
                            thirdIcon: kabbaIcon,
                            surahNumber: chapter.id,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
