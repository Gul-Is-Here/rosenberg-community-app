// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:audioplayers/audioplayers.dart';
// import '../../controllers/audio_controller.dart';
// import '../../controllers/quran_controller.dart';
// import '../../model/quran_model.dart';
// import '../../model/surah_detail_model.dart';

// class SurahDetailsScreen extends StatelessWidget {
//   final Surah surah;

//   SurahDetailsScreen({required this.surah});

//   @override
//   Widget build(BuildContext context) {
//     final QuranController quranController = Get.find();
//     final AudioPlayerController audioController =
//         Get.put(AudioPlayerController());

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(surah.name),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               surah.englishName,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Surah Number: ${surah.number}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Verse Count: ${surah.ayahs.length}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Revelation Type: ${surah.revelationType.toString().split('.').last}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 // itemCount: surah.ayahs.length,
//                 itemBuilder: (context, index) {
//                   final ayah = surah.ayahs[index];
//                   return ListTile(
//                     title: Text(ayah.text),
//                     subtitle: Text('Ayah ${ayah.numberInSurah}'),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // audioController.playOrPauseAudio(
//                 //   quranController.audioFiles
//                 //     .firstWhere(
//                 //         (audio) => audio.id == surah.number)
//                 //     .audioUrl);
//               },
//               child: Obx(() {
//                 return Text(
//                   audioController.isPlaying.value
//                       ? 'Pause Audio'
//                       : 'Play Audio',
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//             Obx(() {
//               return audioController.isPlaying.value
//                   ? Column(
//                       children: [
//                         LinearProgressIndicator(
//                           value: audioController.progress.value,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('${audioController.progress.value}'),
//                             Text('${audioController.progress.value}'),
//                           ],
//                         ),
//                       ],
//                     )
//                   : SizedBox.shrink();
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
