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
      Uri.parse('https://n06.radiojar.com/8s5u5tpdtwzuv'),
      tag: MediaItem(
        // Specify a unique ID for each media item:
        id: '1',
        // Metadata to display in the notification:
        album: "القران الكريم",
        title: "اذاعة القران الكريم من القاهرة",
        artUri: Uri.parse(
            'https://yt3.googleusercontent.com/4Vm0-Cpqiumoi1LcdJiAov3JAWAdNJ9VQc9KWCSGYx3zfj7j7LgBlHdOyX82UUtPpG7cx0Sz=s900-c-k-c0x00ffffff-no-rj'),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                          'https://yt3.googleusercontent.com/4Vm0-Cpqiumoi1LcdJiAov3JAWAdNJ9VQc9KWCSGYx3zfj7j7LgBlHdOyX82UUtPpG7cx0Sz=s900-c-k-c0x00ffffff-no-rj'))),
            ),
            IconButton(
                onPressed: () async {
                  setState(() {
                    player.playerState.playing ? player.pause() : player.play();
                  });
                },
                icon: Icon(
                  player.playerState.playing
                      ? Icons.pause_circle_filled
                      : Icons.play_arrow_rounded,
                  size: 50,
                )),
          ],
        ),
      ),
    );
  }
}
