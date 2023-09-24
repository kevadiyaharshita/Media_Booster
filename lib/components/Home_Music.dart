import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_player/controller/FavouriteSong_Controller.dart';
import 'package:media_player/controller/Video_Controller.dart';
import 'package:media_player/utils/Audio_Songs.dart';
import 'package:media_player/controller/PageController.dart';
import 'package:media_player/utils/Movie_Modal.dart';
import 'package:media_player/utils/My_Routes.dart';
import 'package:media_player/utils/Video_Song.dart';
import 'package:provider/provider.dart';
import '../controller/Audio_Controller.dart';
import '../controller/CarouselController.dart';

class HomeMusic extends StatelessWidget {
  const HomeMusic({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New realseded for you",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: Movies.map((e) {
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
                        height: 180,
                        width: 160,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: AssetImage(Images_Movies[e]),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                e,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Indie Music Videos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(Video_Song.length, (index) {
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
                      height: 180,
                      width: 160,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        Video_Song[index]['image']),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text(
                              Video_Song[index]['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Today's Biggest Hits Audio's",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(Audio_Songs.length, (index) {
                  return (Audio_Songs[index]['movie'] == 'Album Songs')
                      ? Consumer<Carousel_Controller>(
                          builder: (context, pro, _) {
                          return GestureDetector(
                            onTap: () {
                              // pro.setCurrentIndex(0);
                              pro.setAllSong(movie: 'Album Songs');
                              pro.setAlbumSongName(
                                  name: Audio_Songs[index]['title']);
                              Provider.of<AudioController>(context,
                                      listen: false)
                                  .openSongs(path: Audio_Songs[index]['path']);

                              Provider.of<AudioController>(context,
                                      listen: false)
                                  .setStatus();

                              pro.setSelectedMovieName(
                                  movieName: 'Album Songs');

                              Provider.of<Page_Controller>(context,
                                      listen: false)
                                  .changePage(2);
                              FavouriteController.isTappaed = false;
                            },
                            child: Container(
                              height: 180,
                              width: 160,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Audio_Songs[index]['image']),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    child: Text(
                                      Audio_Songs[index]['title'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      : SizedBox();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ElevatedButton(
//   onPressed: () {
//     ImagePicker picker = ImagePicker();
//     XFile? file;
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Pick Video"),
//         content: Text("Choose the sourse for your Video"),
//         actions: [
//           Consumer<VideoController>(builder: (context, p, _) {
//             return ElevatedButton(
//               onPressed: () async {
//                 file = await picker.pickVideo(
//                     source: ImageSource.gallery);
//
//                 if (file != null) {
//                   p.setVideoFromGallary(video: File(file!.path));
//                 }
//
//                 Navigator.of(context)
//                     .pushNamed(MyRoutes.gallaryVideo);
//               },
//               child: Text("Gallary"),
//             );
//           }),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Camara"),
//           ),
//         ],
//       ),
//     );
//   },
//   child: Text("Choose Video"),
// ),
