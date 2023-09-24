import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:media_player/controller/Audio_Controller.dart';
import 'package:media_player/controller/BottomButtonController.dart';
import 'package:media_player/controller/CarouselController.dart';
import 'package:media_player/controller/DateTimeController.dart';
import 'package:media_player/controller/FavouriteSong_Controller.dart';
import 'package:provider/provider.dart';

import '../../controller/PageController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double w = s.width;
    double height = s.height;
    return FeatureDiscovery(
      recordStepsInSharedPreferences: true,
      child: Consumer<Page_Controller>(
        builder: (context, pro, _) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            FeatureDiscovery.discoverFeatures(context, <String>['feature1']);
          });
          return Scaffold(
            appBar: (pro.getIndex == 2 || pro.getIndex == 4)
                ? null
                : AppBar(
                    title: Consumer<DateTimeController>(
                      builder: (context, p, _) {
                        return (pro.getIndex == 1)
                            ? Text(
                                "Audio song",
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              )
                            : Text(
                                p.greetings[p.getIndex],
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              );
                      },
                    ),
                  ),
            body: Center(
              child: pro.allPages[pro.getIndex],
            ),
            bottomNavigationBar: Container(
              width: w,
              height: 80,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: pro.getIndex == 2 || pro.getIndex == 4
                      ? Colors.black
                      : Colors.transparent),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //home
                  GestureDetector(
                    onTap: () {
                      pro.changePage(0);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.music_house_fill,
                            color: (pro.getIndex == 0)
                                ? Colors.white
                                : Colors.grey,
                          ),
                          Gap(5),
                          Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 12,
                              color: (pro.getIndex == 0)
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // // audio
                  GestureDetector(
                    onTap: () {
                      pro.changePage(1);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.music_note_2,
                            color: (pro.getIndex == 1)
                                ? Colors.white
                                : Colors.grey,
                          ),
                          Gap(5),
                          Text(
                            "Audio",
                            style: TextStyle(
                              fontSize: 12,
                              color: (pro.getIndex == 1)
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Round Button
                  DescribedFeatureOverlay(
                    featureId: 'feature1',
                    tapTarget: Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffF56D6F),
                            Color(0xffD5405D),
                          ],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                        ),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 30,
                      ),
                    ),
                    targetColor: Colors.white,
                    textColor: Colors.white,
                    backgroundColor: Color(0xffD5405D),
                    contentLocation: ContentLocation.above,
                    description: Center(
                        child: Text(
                      "Click here\nto start listening",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                    pulseDuration: Duration(seconds: 1),
                    enablePulsingAnimation: true,
                    backgroundDismissible: false,
                    overflowMode: OverflowMode.clipContent,
                    openDuration: Duration(seconds: 1),
                    child: Consumer<AudioController>(builder: (context, p, _) {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<BottomButtonController>(context,
                                  listen: false)
                              .setIsCheck();
                          if (pro.getIndex != 0) {
                            pro.changePage(2);
                            p.changeStatus();
                            p.setStatus();
                            // p.refreshUI();
                          } else {
                            pro.changePage(2);
                          }
                        },
                        child: Consumer<Carousel_Controller>(
                            builder: (context, provider, _) {
                          return Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: ((pro.getIndex != 2) &&
                                      Provider.of<BottomButtonController>(
                                              context,
                                              listen: false)
                                          .getISCheck)
                                  ? DecorationImage(
                                      image: (!FavouriteController.isTappaed)
                                          ? NetworkImage(
                                              provider
                                                  .getAllSongs[
                                                      provider.getCurrentIndex]
                                                  .image,
                                            )
                                          : NetworkImage(
                                              provider
                                                  .getallFavouriteSong[
                                                      provider.getfavCurrent]
                                                  .image,
                                            ),
                                      fit: BoxFit.cover)
                                  : null,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffF56D6F),
                                  Color(0xffD5405D),
                                ],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Consumer<AudioController>(
                                builder: (context, p, _) {
                              return Stack(
                                children: [
                                  StreamBuilder(
                                    stream: Provider.of<AudioController>(
                                            context,
                                            listen: false)
                                        .assetsAudioPlayer
                                        .isPlaying,
                                    builder: (context, snapshot) {
                                      bool isPlaying = snapshot.data ?? false;
                                      return (pro.getIndex == 2) ||
                                              (!Provider.of<
                                                          BottomButtonController>(
                                                      context,
                                                      listen: false)
                                                  .getISCheck)
                                          ? Icon(
                                              isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow_rounded,
                                              size: 35,
                                            )
                                          : Center(
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/music.gif',
                                                  ),
                                                )),
                                              ),
                                            );
                                    },
                                  ),
                                  Visibility(
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1.8,
                                        child: CircularProgressIndicator(
                                          color: Colors.white.withOpacity(0.5),
                                          value: 1,
                                          strokeWidth: 1.5,
                                        ),
                                      ),
                                    ),
                                    visible: pro.getIndex != 2 &&
                                        Provider.of<BottomButtonController>(
                                                context,
                                                listen: false)
                                            .getISCheck,
                                  ),
                                  Visibility(
                                    child: Center(
                                      child: StreamBuilder(
                                        stream:
                                            p.assetsAudioPlayer.currentPosition,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Transform.scale(
                                              scale: 1.8,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 1.5,
                                                value: (snapshot.data!.inSeconds
                                                            .toDouble() /
                                                        p.totalDuration) ??
                                                    0,
                                              ),
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        },
                                      ),
                                    ),
                                    visible: pro.getIndex != 2 &&
                                        Provider.of<BottomButtonController>(
                                                context,
                                                listen: false)
                                            .getISCheck,
                                  ),
                                ],
                              );
                            }),
                          );
                        }),
                      );
                    }),
                  ),

                  // //  video
                  GestureDetector(
                    onTap: () {
                      pro.changePage(3);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.video_camera_solid,
                            color: (pro.getIndex == 3)
                                ? Colors.white
                                : Colors.grey,
                          ),
                          Gap(5),
                          Text(
                            "Video",
                            style: TextStyle(
                              fontSize: 12,
                              color: (pro.getIndex == 3)
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //  like
                  GestureDetector(
                    onTap: () {
                      pro.changePage(4);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.heart_solid,
                            color: (pro.getIndex == 4)
                                ? Colors.white
                                : Colors.grey,
                          ),
                          Gap(5),
                          Text(
                            "Favourite",
                            style: TextStyle(
                              fontSize: 12,
                              color: (pro.getIndex == 4)
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// F56D6F
// D5405D

// BottomNavigationBar(
//   currentIndex: pro.getIndex,
//   showUnselectedLabels: true,
//   unselectedItemColor: Colors.grey,
//   selectedItemColor: Colors.white,
//   onTap: (index) {
//     pro.changePage(index);
//   },
//   items: [
//     BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.music_house_fill), label: "Home"),
//     BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.music_note_2), label: "Audio"),
//     BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.video_camera_solid),
//         label: "Video"),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.settings), label: "Settings")
//   ],
// ),
