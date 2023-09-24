import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player/controller/VideoCarousel.dart';
import 'package:media_player/utils/Video_Song.dart';
import 'package:provider/provider.dart';

import '../controller/CarouselController.dart';
import '../controller/Video_Controller.dart';
import '../utils/My_Routes.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Consumer<VideoCarousel>(builder: (context, p, _) {
          return CarouselSlider(
            items: List.generate(
                videos.length,
                (index) => GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                videoImages[index],
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                    )),
            carouselController: p.getController,
            options: CarouselOptions(
              animateToClosest: true,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                p.setCurrentIndex(index);
              },
            ),
          );
        }),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            videos.length,
            (index) {
              return Consumer<VideoCarousel>(builder: (context, pro, _) {
                return Container(
                  height: 10,
                  width: 10,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: (index == pro.getCurrentIndex)
                        ? Colors.white
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              });
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18, right: 10),
          child: Text(
            "New Releases Videos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: w,
          height: 353,
          padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: GridView.builder(
            itemCount: Video_Song.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) =>
                Consumer<Carousel_Controller>(builder: (context, pro, _) {
              return GestureDetector(
                onTap: () {
                  Provider.of<VideoController>(context, listen: false)
                      .initVideo(path: Video_Song[index]['path']);
                  Navigator.of(context).pushNamed(
                    MyRoutes.allVideoPage,
                    arguments: Video_Song[index],
                  );
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:
                                      NetworkImage(Video_Song[index]['image']),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        Video_Song[index]['title'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
