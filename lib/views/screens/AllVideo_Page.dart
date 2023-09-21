import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_player/controller/Video_Controller.dart';
import 'package:provider/provider.dart';

class AllVideoPage extends StatelessWidget {
  const AllVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Consumer<VideoController>(builder: (context, pro, _) {
      return Scaffold(
          body: Column(
        children: [
          AspectRatio(
            aspectRatio: pro.videoPlayerController!.value.aspectRatio,
            child: pro.chewieController != null
                ? Chewie(
                    controller: pro.chewieController!,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        ],
      ));
    });
  }
}
