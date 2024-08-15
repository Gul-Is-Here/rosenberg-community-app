import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AzanoverlayScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;

  AzanoverlayScreen({required this.audioPlayer});

  @override
  _AzanoverlayScreenState createState() => _AzanoverlayScreenState();
}

class _AzanoverlayScreenState extends State<AzanoverlayScreen> {
  @override
  void initState() {
    super.initState();

    // Listen to audio player state changes
    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        // Optionally handle playback completion
        print("Azan playback completed");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Azan Playback',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (widget.audioPlayer.state == PlayerState.playing) {
                    await widget.audioPlayer.pause();
                  } else {
                    await widget.audioPlayer.play(AssetSource("azan1.wav"));
                  }
                },
                child: Text(
                  widget.audioPlayer.state == PlayerState.playing
                      ? 'Pause'
                      : 'Play',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await widget.audioPlayer.stop();
                },
                child: Text('Stop'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the overlay
                },
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Ensure to stop the audio player if not needed
    widget.audioPlayer.dispose();
    super.dispose();
  }
}
