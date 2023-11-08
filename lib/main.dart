import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setAudioSource(AudioSource.uri(
      Uri.parse('http://s29.myradiostream.com:11940/;'),
      tag: MediaItem(
        // Specify a unique ID for each media item:
        id: '1',
        // Metadata to display in the notification:
        album: "Music Ahmed",
        title: "Eltesht 2aly",
        artUri: Uri.parse('https://example.com/albumart.jpg'),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: IconButton(
              onPressed: () async {
                setState(() {
                  player.playerState.playing ? player.pause() : player.play();
                });
              },
              icon: Icon(
                  player.playerState.playing ? Icons.pause : Icons.play_arrow)),
        ),
      ),
    );
  }
}
