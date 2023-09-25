import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee/marquee.dart';
import 'package:media_player/controller/CarouselController.dart';
import 'package:media_player/controller/FavouriteSong_Controller.dart';
import 'package:provider/provider.dart';
import '../controller/Audio_Controller.dart';
import '../controller/BottomButtonController.dart';

class CurrentPlaySongs extends StatelessWidget {
  const CurrentPlaySongs({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return (!FavouriteController.isTappaed)
        ? Consumer<Carousel_Controller>(
            builder: (context, pro, _) {
              Provider.of<BottomButtonController>(context, listen: false)
                  .setIsCheck();
              String MovieName = pro.getSelectedMovieName;
              if (MovieName == '') {
                MovieName = 'Bramhastra';
                pro.setAllSong(movie: MovieName);
                Provider.of<AudioController>(context, listen: false)
                    .openSongs(path: pro.getAllSongs[0].path);
                pro.setSelectedMovieName(movieName: 'Bramhastra');
              }
              pro.setAllSong(movie: MovieName);
              if (pro.getAlbumSongName != '') {
                pro.getAllSongs.forEach((e) {
                  if (e.title == pro.getAlbumSongName) {
                    pro.setCurrentIndex(pro.getAllSongs.indexOf(e));
                    pro.setAlbumSongName(name: '');
                  }
                });
              }
              print(
                  '================================================${pro.getIsAllSong}');
              if (pro.getIsAllSong) {
                print(
                    "Entered.......................................................................................");
                pro.setAllOverSongs();
                // pro.setIsAllSong(false);
              }
              return SizedBox(
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
                    // Container(
                    //   height: h,
                    //   width: w,
                    //   color: Colors.black54.withOpacity(0.5),
                    // ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 3,
                          sigmaY: 3,
                        ),
                        child: Container(
                          width: w,
                          height: h,
                        ),
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
                                    path: pro
                                        .getAllSongs[pro.getCurrentIndex].path);
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
                                    child: Image.network(
                                        pro.getAllSongs[pro.getCurrentIndex]
                                            .image,
                                        fit: BoxFit.fill),
                                  ),
                                  const SizedBox(height: 20),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: pro.getCurrentIndex == index
                                        ? 1.0
                                        : 0.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child:
                          Consumer<AudioController>(builder: (context, p, _) {
                        return Container(
                          // color: Colors.pink,
                          width: w,
                          height: 150 + 33,
                          padding: EdgeInsets.only(left: 18, right: 18),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<FavouriteController>(
                                builder: (context, fp, _) {
                                  return LikeButton(
                                    onTap: (isLiked) async {
                                      fp.addFavouriteSong(
                                          title:
                                              '${pro.getAllSongs[pro.getCurrentIndex].title}');
                                      return await !isLiked;
                                    },
                                    isLiked: fp.checkFavouriteSong(
                                        title:
                                            '${pro.getAllSongs[pro.getCurrentIndex].title}'),
                                  );
                                },
                              ),
                              Gap(15),
                              Text(
                                '${pro.getAllSongs[pro.getCurrentIndex].title}(From "${pro.getAllSongs[pro.getCurrentIndex].movie}")',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                width: w,
                                height: 18,
                                child: Marquee(
                                  text:
                                      'Artist - ${pro.setSinger(name: pro.getAllSongs[pro.getCurrentIndex].singer)}',
                                  scrollAxis: Axis.horizontal,
                                  blankSpace: 20.0,
                                  startPadding: 10.0,
                                  accelerationDuration: Duration(seconds: 3),
                                ),
                              ),
                              SizedBox(
                                height: 25,
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
                                            activeColor: Color(0xffD5405D),
                                          ),
                                        ),
                                        Text(
                                            "${(p.totalDuration.toInt() ~/ 60).toString().padLeft(2, '0')}:${(p.totalDuration.toInt() % 60).toString().padLeft(2, '0')}"),
                                      ],
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                ),
              );
            },
          )
        : Consumer<Carousel_Controller>(
            builder: (context, pro, _) {
              Provider.of<BottomButtonController>(context, listen: false)
                  .setIsCheck();
              // String MovieName = pro.getSelectedMovieName;
              // if (MovieName == '') {
              //   MovieName = 'Bramhastra';
              //   pro.setAllSong(movie: MovieName);
              //   Provider.of<AudioController>(context, listen: false)
              //       .openSongs(path: pro.getAllSongs[0].path);
              //   pro.setSelectedMovieName(movieName: 'Bramhastra');
              // }
              pro.setAllFavouriteSong();
              // Provider.of<AudioController>(context).openSongs(
              //     path: pro.getallFavouriteSong[pro.getfavCurrent].path);
              // pro.setAllSong(movie: MovieName);
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: w,
                child: Stack(
                  children: [
                    Container(
                      height: h,
                      width: w,
                      child: Image.network(
                        '${pro.getallFavouriteSong[pro.getfavCurrent].image}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 3,
                          sigmaY: 3,
                        ),
                        child: Container(
                          width: w,
                          height: h,
                        ),
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
                            pro.setfavCurrent(index: index);

                            Provider.of<AudioController>(context, listen: false)
                                .openSongs(
                                    path: pro
                                        .getallFavouriteSong[pro.getfavCurrent]
                                        .path);
                          },
                        ),
                        carouselController: pro.getController,
                        items: List.generate(
                          pro.getallFavouriteSong.length,
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
                                    child: Image.network(
                                        pro
                                            .getallFavouriteSong[
                                                pro.getfavCurrent]
                                            .image,
                                        fit: BoxFit.fill),
                                  ),
                                  const SizedBox(height: 20),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity:
                                        pro.getfavCurrent == index ? 1.0 : 0.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child:
                          Consumer<AudioController>(builder: (context, p, _) {
                        return Container(
                          // color: Colors.pink,
                          width: w,
                          height: 150 + 33,
                          padding: EdgeInsets.only(left: 18, right: 18),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<FavouriteController>(
                                builder: (context, fp, _) {
                                  return LikeButton(
                                    onTap: (isLiked) async {
                                      fp.addFavouriteSong(
                                          title:
                                              '${pro.getallFavouriteSong[pro.getfavCurrent].title}');
                                      return await !isLiked;
                                    },
                                    isLiked: fp.checkFavouriteSong(
                                        title:
                                            '${pro.getallFavouriteSong[pro.getfavCurrent].title}'),
                                  );
                                },
                              ),
                              Gap(15),
                              Text(
                                '${pro.getallFavouriteSong[pro.getfavCurrent].title}(From ${pro.getallFavouriteSong[pro.getfavCurrent].movie})',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                width: w,
                                height: 18,
                                child: Marquee(
                                  text:
                                      'Artist - ${pro.setSinger(name: pro.getallFavouriteSong[pro.getfavCurrent].singer)}',
                                  scrollAxis: Axis.horizontal,
                                  blankSpace: 20.0,
                                  startPadding: 10.0,
                                  accelerationDuration: Duration(seconds: 3),
                                ),
                              ),
                              SizedBox(
                                height: 25,
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
                                            activeColor: Color(0xffD5405D),
                                          ),
                                        ),
                                        Text(
                                            "${(p.totalDuration.toInt() ~/ 60).toString().padLeft(2, '0')}:${(p.totalDuration.toInt() % 60).toString().padLeft(2, '0')}"),
                                      ],
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                ),
              );
            },
          );
  }
}
