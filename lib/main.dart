import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VlcPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {}

  @override
  void initState() {
    super.initState();

    try {
      _videoPlayerController = VlcPlayerController.network(
        'http://list.serveftp.net:8880/movie/fullip/adgptww/2852058.mkv',
        hwAcc: HwAcc.full,
        autoPlay: true,
        options: VlcPlayerOptions(),
      );
    } catch (e, s) {
      log('Error on video player: $e, $s');
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
