import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({required this.videoUrl, super.key});
  final String videoUrl;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController _controller;
  late final Uri vidUrl;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    vidUrl = Uri.parse(widget.videoUrl);
    unawaited(_initVideoContoller());
    // _controller = VideoPlayerController.networkUrl(vidUrl)
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _controller.play();
    //     _startPositionUpdater();
    //   });
  }

  Future<void> _initVideoContoller() {
    _controller = VideoPlayerController.networkUrl(vidUrl);
    return _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
      _startPositionUpdater();
    });
  }

  void _startPositionUpdater() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_controller.value.isInitialized && mounted) {
        setState(() {});
      }
    });
  }

  Future<void> _seekToPosition(double value) async {
    final position = Duration(seconds: value.toInt());
    await _controller.seekTo(position);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child:
                  _controller.value.isInitialized
                      ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                      : const CircularProgressIndicator(),
            ),
          ),
          if (_controller.value.isInitialized)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_controller.value.position)),
                      Text(_formatDuration(_controller.value.duration)),
                    ],
                  ),
                ),
                Slider(
                  value: _controller.value.position.inSeconds.toDouble(),
                  max: _controller.value.duration.inSeconds.toDouble(),
                  onChanged: (value) async => _seekToPosition(value),
                ),
              ],
            )
          else
            const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_10),
                onPressed: () async {
                  final position =
                      _controller.value.position - const Duration(seconds: 10);
                  await _controller.seekTo(position);
                },
              ),
              FloatingActionButton(
                onPressed: () async {
                  _controller.value.isPlaying
                      ? await _controller.pause()
                      : await _controller.play();
                  setState(() {});
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.forward_10),
                onPressed: () async {
                  final position =
                      _controller.value.position + const Duration(seconds: 10);
                  await _controller.seekTo(position);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    var twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    var twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  void dispose() {
    unawaited(_controller.dispose());
    _timer.cancel();
    super.dispose();
  }
}
