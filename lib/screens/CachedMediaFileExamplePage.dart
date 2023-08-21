import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:my_global_tools/screens/appinio_video_player/appinio_video_player.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:video_player/video_player.dart';

import 'Appinio_Video_Player/custom_video_player.dart';
import 'Appinio_Video_Player/custom_video_player_controller.dart';

class CachedMediaFileExamplePage extends StatefulWidget {
  const CachedMediaFileExamplePage({Key? key}) : super(key: key);

  @override
  State<CachedMediaFileExamplePage> createState() =>
      _CachedMediaFileExamplePageState();
}

class _CachedMediaFileExamplePageState
    extends State<CachedMediaFileExamplePage> {
  late DownloadMediaBuilderController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DownloadMediaBuilder(
            url:
                'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
            // 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            encryptionPassword: "this is another password",
            autoDownload: true,
            onInitialize: (controller) => this.controller = controller,
            onInitial: (snapshot) {
              return ElevatedButton(
                onPressed: controller.getFile,
                child: const Text("Load file"),
              );
            },
            onSuccess: (snapshot) {
              return MYCustomVideoPlayer(file: snapshot.filePath!);
            },
            onLoading: (snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: snapshot.progress,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.cancelDownload,
                    child: const Text('Cancel Download'),
                  ),
                ],
              );
            },
            onCancel: (snapshot) {
              return ElevatedButton(
                onPressed: controller.retry,
                child: const Text('Retry'),
              );
            },
            onDecrypting: (snapshot) {
              print(snapshot.progress);
              return const Center(
                child: Text('File is under decryption...'),
              );
            },
            onEncrypting: (snapshot) {
              return const Center(
                child: Text('File is under encryption...'),
              );
            },
            onError: (snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: Text('Error Occurred!')),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.retry,
                    child: const Text('Retry'),
                  ),
                ],
              );
            },
          ),
          Expanded(child: RandomAvatarPage()),
        ],
      ),
    );
  }
}

class MYCustomVideoPlayer extends StatefulWidget {
  const MYCustomVideoPlayer({super.key, required this.file});
  final String file;

  @override
  State<MYCustomVideoPlayer> createState() => _MYCustomVideoPlayerState();
}

class _MYCustomVideoPlayerState extends State<MYCustomVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  String videoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(File(widget.file))
      ..initialize().then((value) => setState(() {}));

    _customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoPlayerController);
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('widget.title')),
      child: SafeArea(
        child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController),
      ),
    );
  }
}

class RandomAvatarPage extends StatefulWidget {
  const RandomAvatarPage({Key? key}) : super(key: key);

  @override
  _RandomAvatarPageState createState() => _RandomAvatarPageState();
}

class _RandomAvatarPageState extends State<RandomAvatarPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Widget> _painters = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            FloatingActionButton(
              onPressed: () {
                String svg = RandomAvatarString(
                  DateTime.now().toIso8601String(),
                  trBackground: false,
                );
                logD(svg);

                _painters.add(
                  RandomAvatar(
                    DateTime.now().toIso8601String(),
                    height: 50,
                    width: 52,
                  ),
                );
                _controller.text = svg;
                setState(() {});
              },
              tooltip: 'Generate',
              child: const Icon(Icons.gesture),
            ),
            const SizedBox(height: 20),
            ..._painters,
          ],
        ),
      ),
    );
  }
}

