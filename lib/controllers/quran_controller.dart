import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/quran_model.dart';
import '../model/quran_audio_model.dart';

class QuranController extends GetxController {
  var isLoading = false.obs;
  var chapters = <Chapter>[].obs;
  var audioFiles = <AudioFile>[].obs;

  var chapterId;
  @override
  void onInit() {
    fetchChapters();
    fetchAudioFiles();

    super.onInit();
  }

  /// Surah Chapter Method
  Future<void> fetchChapters() async {
    isLoading(true);
    try {
      final response =
          await http.get(Uri.parse('https://api.quran.com/api/v4/chapters'));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        chapters.value = List<Chapter>.from(
            result['chapters'].map((x) => Chapter.fromJson(x)));
      } else {
        throw Exception('Failed to load chapters');
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Surah Audio Method
  Future<void> fetchAudioFiles() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.quran.com/api/v4/chapter_recitations/2'));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        audioFiles.value = List<AudioFile>.from(
            result['audio_files'].map((x) => AudioFile.fromJson(x)));
      } else {
        throw Exception('Failed to load audio files');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
