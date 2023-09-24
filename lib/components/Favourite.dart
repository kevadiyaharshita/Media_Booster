import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:media_player/controller/Audio_Controller.dart';
import 'package:media_player/controller/CarouselController.dart';
import 'package:media_player/controller/FavouriteSong_Controller.dart';
import 'package:media_player/utils/Audio_Songs.dart';
import 'package:media_player/utils/ColorUtils.dart';
import 'package:provider/provider.dart';

import '../controller/PageController.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: w,
      child: Stack(
        children: [
          Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/564x/31/03/60/310360323979ac62d5bb05e0ad563896.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              height: h,
              width: w,
              color: Colors.black54,
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
                    Colors.black54.withOpacity(0.9),
                    Colors.black54.withOpacity(0.5),
                    Colors.grey.shade50.withOpacity(0.0),
                    Colors.grey.shade50.withOpacity(0.0),
                    Colors.grey.shade50.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: h,
            child: Column(
              children: [
                Gap(100),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Liked Songs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                Gap(270),
                Consumer<FavouriteController>(builder: (context, pro, _) {
                  return Container(
                    height: 310,
                    // color: Colors.pink,
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          pro.allSongs.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                FavouriteController.isTappaed = true;
                                Provider.of<Page_Controller>(context,
                                        listen: false)
                                    .changePage(2);
                                Provider.of<Carousel_Controller>(context,
                                        listen: false)
                                    .setfavCurrent(index: index);
                                Provider.of<AudioController>(context,
                                        listen: false)
                                    .openSongs(path: pro.allSongs[index].path);
                              },
                              child: Container(
                                width: w,
                                height: 70,
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            pro.allSongs[index].image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Gap(20),
                                    Container(
                                      width: 220,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Spacer(),
                                          Text(pro.allSongs[index].title),
                                          Text(
                                            '${pro.allSongs[index].singer}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.play_circle,
                                      color: theme2,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
