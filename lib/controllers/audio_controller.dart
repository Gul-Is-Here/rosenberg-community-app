// audio_controller.dart

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../model/quran_audio_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AudioPlayerController extends GetxController {
  var isPlaying = false.obs;
  var progress = 0.0.obs;
  var duration = 1.0.obs;
  var playbackSpeed = 1.0.obs;
  var isRepeating = false.obs;
  var currentAudio = Rxn<AudioFile>();

  final AudioPlayer audioPlayer = AudioPlayer();
  // var audioFiles = <AudioFile>[].obs;

  final List<double> speedOptions = [0.5, 1.0, 1.5, 2.0];

  @override
  void onInit() {
    super.onInit();

    audioPlayer.positionStream.listen((Duration p) {
      progress.value = p.inMilliseconds.toDouble();
    });

    audioPlayer.durationStream.listen((Duration? d) {
      if (d != null) {
        duration.value = d.inMilliseconds.toDouble();
      }
    });

    audioPlayer.playerStateStream.listen((PlayerState state) {
      isPlaying.value = state.playing;
    });
  }

  // Future<void> fetchAudioFiles() async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('https://api.quran.com/api/v4/chapter_recitations/2'));

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       audioFiles.value = (jsonData['audio_file'] as List)
  //           .map((item) => AudioFile.fromJson(item))
  //           .toList();
  //     } else {
  //       throw Exception('Failed to load audio files');
  //     }
  //   } catch (e) {
  //     // Handle error (e.g., show a message to the user)
  //     print('Error fetching audio files: $e');
  //   }
  // }

  Future<void> playOrPauseAudio(AudioFile audio) async {
    try {
      if (currentAudio.value?.id == audio.id && isPlaying.value) {
        await audioPlayer.pause();
        isPlaying.value = false;
      } else {
        await audioPlayer.setUrl(audio.audioUrl);
        await audioPlayer.setSpeed(playbackSpeed.value);
        await audioPlayer.play();
        currentAudio.value = audio;
        isPlaying.value = true;
      }
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      print('Error playing or pausing audio: $e');
    }
  }

  Future<void> stopAudio() async {
    try {
      await audioPlayer.stop();
      currentAudio.value = null;
      isPlaying.value = false;
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      print('Error stopping audio: $e');
    }
  }

  Future<void> playNextAudio(RxList<AudioFile> audioFiles) async {
    if (currentAudio.value == null) return;

    int currentIndex =
        audioFiles.indexWhere((audio) => audio.id == currentAudio.value!.id);
    if (currentIndex == -1 || currentIndex == audioFiles.length - 1) return;

    AudioFile nextAudio = audioFiles[currentIndex + 1];
    await playOrPauseAudio(nextAudio);
  }

  Future<void> playPreviousAudio(RxList<AudioFile> audioFiles) async {
    if (currentAudio.value == null) return;

    int currentIndex =
        audioFiles.indexWhere((audio) => audio.id == currentAudio.value!.id);
    if (currentIndex <= 0) return;

    AudioFile previousAudio = audioFiles[currentIndex - 1];
    await playOrPauseAudio(previousAudio);
  }

  Future<void> setPlaybackSpeed(double speed) async {
    try {
      playbackSpeed.value = speed;
      if (isPlaying.value) {
        await audioPlayer.setSpeed(speed);
      }
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      print('Error setting playback speed: $e');
    }
  }

  void toggleSpeed() {
    int currentIndex = speedOptions.indexOf(playbackSpeed.value);
    int nextIndex = (currentIndex + 1) % speedOptions.length;
    setPlaybackSpeed(speedOptions[nextIndex]);
  }

  void toggleRepeat() {
    isRepeating.value = !isRepeating.value;
    audioPlayer.setLoopMode(isRepeating.value ? LoopMode.one : LoopMode.off);
  }
}
