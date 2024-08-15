import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AzanoverlayScreen extends StatelessWidget {
  final AudioPlayer audioPlayer;

  AzanoverlayScreen({required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Azan is playing'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            audioPlayer.stop();
            audioPlayer.dispose();
            Navigator.of(context).pop();
          },
          child: Text('Stop Azan'),
        ),
      ),
    );
  }
}
