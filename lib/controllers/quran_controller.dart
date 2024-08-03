import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/quran_audio_model.dart';
import '../model/quran_model.dart';
import '../model/surah_detail_model.dart';
import '../model/surah_english_model.dart'; // Import your translation model

class QuranController extends GetxController {
  var isLoading = false.obs;
  var chapters = <Chapter>[].obs;
  var audioFiles = <AudioFile>[].obs;
  RxInt chapterId = 0.obs; // Updated naming
  var surahData = SurahModel(
    code: 0,
    status: '',
    data: Data(
      surahs: [],
      edition: Edition(
        identifier: '',
        language: '',
        name: '',
        englishName: '',
        format: '',
        type: '',
      ),
    ),
  ).obs;
  var translationData = <Result>[].obs; // Translation data

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading(true);
    await Future.wait([
      fetchChapters(),
      fetchAudioFiles(),
      fetchSurahData(),
    ]);
    isLoading(false);
  }

  Future<void> fetchChapters() async {
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
    }
  }

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

  Future<void> fetchSurahData() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.alquran.cloud/v1/quran/quran-uthmani'));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        surahData.value = SurahModel.fromJson(result);
      } else {
        throw Exception('Failed to load Surah data');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchTranslationData(int chapterId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://quranenc.com/api/v1/translation/sura/english_saheeh/$chapterId'));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var translation = SurahAyatEnglisModel.fromJson(result);
        translationData.value = translation.result;
      } else {
        throw Exception('Failed to load translation data');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Surah? getSurahByChapterId(int chapterId) {
    return surahData.value.data.surahs
        .firstWhereOrNull((surah) => surah.number == chapterId);
  }
}
