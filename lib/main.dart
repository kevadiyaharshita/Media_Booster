import 'package:flutter/material.dart';
import 'package:media_player/controller/Audio_Controller.dart';
import 'package:media_player/controller/Audio_carousel.dart';
import 'package:media_player/controller/BottomButtonController.dart';
import 'package:media_player/controller/CarouselController.dart';
import 'package:media_player/controller/DateTimeController.dart';
import 'package:media_player/controller/FavouriteSong_Controller.dart';
import 'package:media_player/controller/VideoCarousel.dart';
import 'package:media_player/utils/My_Routes.dart';
import 'package:media_player/views/screens/AllVideo_Page.dart';
import 'package:media_player/views/screens/Gallary_Video.dart';
import 'package:media_player/views/screens/Home_page.dart';
import 'package:media_player/views/screens/Movie_AudioPage.dart';
import 'package:provider/provider.dart';

import 'controller/PageController.dart';
import 'controller/Video_Controller.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Page_Controller(),
      ),
      ChangeNotifierProvider(
        create: (context) => DateTimeController(),
      ),
      ChangeNotifierProvider(
        create: (context) => AudioController(),
      ),
      ChangeNotifierProvider(
        create: (context) => Carousel_Controller(),
      ),
      ChangeNotifierProvider(
        create: (context) => VideoController(),
      ),
      ChangeNotifierProvider(
        create: (context) => BottomButtonController(),
      ),
      ChangeNotifierProvider(
        create: (context) => FavouriteController(),
      ),
      ChangeNotifierProvider(
        create: (context) => AudioCarousel(),
      ),
      ChangeNotifierProvider(
        create: (context) => VideoCarousel(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      initialRoute: MyRoutes.home,
      routes: {
        MyRoutes.home: (context) => HomePage(),
        MyRoutes.MovieAudio: (context) => MovieAudioPage(),
        MyRoutes.allVideoPage: (context) => AllVideoPage(),
        // MyRoutes.gallaryVideo: (context) => GallaryVideo(),
      },
      // initialRoute: ,
    );
  }
}
