import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:media_player/controller/CarouselController.dart';
import 'package:media_player/utils/Audio_Songs.dart';
import 'package:media_player/controller/Audio_Controller.dart';
import 'package:provider/provider.dart';

import '../../utils/My_Routes.dart';

class MovieAudioPage extends StatelessWidget {
  const MovieAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    String MovieName = ModalRoute.of(context)!.settings.arguments as String;

    return Consumer<Carousel_Controller>(builder: (context, pro, _) {
      pro.setAllSong(movie: MovieName);

      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: w,
          child: Stack(
            children: [
              Container(
                height: h,
                width: w,
                child: Image.network(
                  '${pro.getAllSongs[pro.getCurrentIndex].image}',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black54.withOpacity(1),
                        Colors.black54.withOpacity(1),
                        Colors.black54.withOpacity(0.9),
                        Colors.black54.withOpacity(0.5),
                        Colors.black54.withOpacity(0.0),
                        Colors.grey.shade50.withOpacity(0.0),
                        Colors.grey.shade50.withOpacity(0.0),
                        Colors.grey.shade50.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.70,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      pro.setCurrentIndex(index);
                      Provider.of<AudioController>(context, listen: false)
                          .openSongs(
                              path: pro.getAllSongs[pro.getCurrentIndex].path);
                    },
                  ),
                  carouselController: pro.getController,
                  items: List.generate(
                    pro.getAllSongs.length,
                    (index) => Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              width: 180,
                              margin: const EdgeInsets.only(top: 40),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.network(pro.getAllSongs[index].image,
                                  fit: BoxFit.fill),
                            ),
                            const SizedBox(height: 20),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: pro.getCurrentIndex == index ? 1.0 : 0.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Consumer<AudioController>(builder: (context, p, _) {
                  return Container(
                    // color: Colors.pink,
                    width: w,
                    padding: EdgeInsets.only(left: 18, right: 18),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${pro.getAllSongs[pro.getCurrentIndex].title}(From "${MovieName}")',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: w,
                          height: 15,
                          child: Marquee(
                            text:
                                'Artist - ${pro.setSinger(name: pro.getAllSongs[pro.getCurrentIndex].singer)}',
                            scrollAxis: Axis.horizontal,
                            blankSpace: 20.0,
                            startPadding: 10.0,
                          ),
                        ),
                        StreamBuilder(
                            stream: p.assetsAudioPlayer.currentPosition,
                            builder: (context, snapShot) {
                              if (snapShot.hasData) {
                                return Row(
                                  children: [
                                    Text(
                                        "${(snapShot.data!.inMinutes).toString().padLeft(2, '0')}:${(snapShot.data!.inSeconds % 60).toString().padLeft(2, '0')}"),
                                    Expanded(
                                      child: Slider(
                                        value: snapShot.data?.inSeconds
                                                .toDouble() ??
                                            0,
                                        onChanged: (val) {
                                          p.seek(seconds: val.toInt());
                                        },
                                        min: 0,
                                        max: p.totalDuration,
                                      ),
                                    ),
                                    Text(
                                        "${(p.totalDuration.toInt() ~/ 60).toString().padLeft(2, '0')}:${(p.totalDuration.toInt() % 60).toString().padLeft(2, '0')}"),
                                  ],
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  p.play();
                                },
                                icon: Icon(Icons.play_circle)),
                            IconButton(
                                onPressed: () {
                                  p.pause();
                                },
                                icon: Icon(Icons.pause)),
                          ],
                        )
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );
    });
  }
}

// children: Audio_Songs.map(
//   (e) {
//     return (MovieName == e['movie']
//         ? Card(
//             child: Consumer<AudioController>(
//               builder: (context, pro, _) {
//                 return ListTile(
//                   onTap: () {
//                     pro.openSongs(path: e['path']);
//                   },
//                   title: Text(e['title']),
//                   trailing: IconButton(
//                     icon: Icon(Icons.pause),
//                     onPressed: () {
//                       pro.pause();
//                     },
//                   ),
//                 );
//               },
//             ),
//           )
//         : SizedBox());
//   },
// ).toList(),
