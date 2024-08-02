import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import '../../model/quran_audio_model.dart';

class AudioController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  var currentAudio = Rxn<AudioFile>();
  var isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.stopped || state == PlayerState.completed) {
        isPlaying.value = false;
      }
    });
  }

  void playOrPauseAudio(AudioFile audio) async {
    if (currentAudio.value != null) {
      if (currentAudio.value!.id == audio.id) {
        if (isPlaying.value) {
          await audioPlayer.pause();
          isPlaying.value = false;
        } else {
          await audioPlayer.resume();
          isPlaying.value = true;
        }
        return;
      } else {
        await audioPlayer.stop();
      }
    }

    if (audio.audioUrl.isNotEmpty) {
      await audioPlayer.play(UrlSource(audio.audioUrl));
      currentAudio.value = audio;
      isPlaying.value = true;
    }
  }

  void stopAudio() async {
    await audioPlayer.stop();
    isPlaying.value = false;
    currentAudio.value = null;
  }
}
