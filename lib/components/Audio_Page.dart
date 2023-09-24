import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player/controller/Audio_carousel.dart';
import 'package:media_player/utils/Audio_Songs.dart';
import 'package:provider/provider.dart';

import '../controller/Audio_Controller.dart';
import '../controller/CarouselController.dart';
import '../controller/FavouriteSong_Controller.dart';
import '../controller/PageController.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

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
        Consumer<AudioCarousel>(
          builder: (context, p, _) {
            return CarouselSlider(
              items: Movies.map(
                (e) {
                  return Consumer<Carousel_Controller>(
                      builder: (context, pro, _) {
                    return GestureDetector(
                      onTap: () {
                        pro.setCurrentIndex(0);
                        pro.setAllSong(movie: e);
                        Provider.of<AudioController>(context, listen: false)
                            .openSongs(path: pro.getAllSongs[0].path);

                        Provider.of<AudioController>(context, listen: false)
                            .setStatus();

                        pro.setSelectedMovieName(movieName: e);

                        Provider.of<Page_Controller>(context, listen: false)
                            .changePage(2);
                        FavouriteController.isTappaed = false;
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                Images_Movies[e],
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                    );
                  });
                },
              ).toList(),
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
          },
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            Movies.length,
            (index) {
              return Consumer<AudioCarousel>(builder: (context, pro, _) {
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
            "India's Best",
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
            itemCount: Audio_Songs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) =>
                Consumer<Carousel_Controller>(builder: (context, pro, _) {
              return GestureDetector(
                onTap: () {
                  pro.setCurrentIndex(0);
                  pro.setAllOverSongs();
                  Provider.of<AudioController>(context, listen: false)
                      .openSongs(path: pro.getAllSongs[0].path);

                  Provider.of<AudioController>(context, listen: false)
                      .setStatus();
                  pro.setIsAllSong(true);
                  // pro.setSelectedMovieName(movieName: e);

                  Provider.of<Page_Controller>(context, listen: false)
                      .changePage(2);
                  FavouriteController.isTappaed = false;
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
                                      NetworkImage(Audio_Songs[index]['image']),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        Audio_Songs[index]['title'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
