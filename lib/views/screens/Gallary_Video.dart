import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/Video_Controller.dart';

class GallaryVideo extends StatelessWidget {
  const GallaryVideo({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Consumer<VideoController>(builder: (context, pro, _) {
      pro.gallaryVideoPlay();
      return Scaffold(
          body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: pro.videoPlayerController1!.value.aspectRatio,
              child: pro.chewieController1 != null
                  ? Chewie(
                      controller: pro.chewieController1!,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        ),
      ));
    });
  }
}
