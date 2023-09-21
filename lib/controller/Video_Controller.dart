import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoController extends ChangeNotifier {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  ChewieController? chewieController1;
  VideoPlayerController? videoPlayerController1;
  File? video;

  VideoController() {
    videoPlayerController = VideoPlayerController.asset(
      'assets/video/khalasi.mp4',
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((value) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          aspectRatio: videoPlayerController!.value.aspectRatio,
          autoPlay: true,
        );
        notifyListeners();
      });
  }

  initVideo() {
    videoPlayerController = VideoPlayerController.asset(
      'assets/video/khalasi.mp4',
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((value) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          aspectRatio: videoPlayerController!.value.aspectRatio,
          autoPlay: true,
        );
        notifyListeners();
      });
  }

  setVideoFromGallary({required File video}) {
    this.video = video;
    notifyListeners();
  }

  gallaryVideoPlay() {
    videoPlayerController1 = VideoPlayerController.file(
      video!,
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((value) {
        chewieController1 = ChewieController(
          videoPlayerController: videoPlayerController1!,
          aspectRatio: videoPlayerController1!.value.aspectRatio,
          autoPlay: true,
        );
        notifyListeners();
      });
  }
}
