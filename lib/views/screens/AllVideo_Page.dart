import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:media_player/controller/Video_Controller.dart';
import 'package:media_player/utils/Video_Song.dart';
import 'package:provider/provider.dart';

class AllVideoPage extends StatelessWidget {
  const AllVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    return Consumer<VideoController>(
      builder: (context, pro, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Indie Videos"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.black54,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: pro.videoPlayerController!.value.aspectRatio,
                    child: pro.chewieController != null
                        ? Chewie(
                            controller: pro.chewieController!,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 5),
                  child: Text(
                    data['title'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
                  child: Wrap(
                    children: List.generate(
                      data['singers'].length,
                      (index) => Text(
                        '${data['singers'][index]}  ',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // Text("hello"),
                Container(
                  height: 430,
                  // margin: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        Video_Song.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              Provider.of<VideoController>(context,
                                      listen: false)
                                  .initVideo(
                                path: Video_Song[index]['path'],
                              );
                            },
                            child: Container(
                              height: 110,
                              width: w,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black54,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 160,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            Video_Song[index]['image']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Column(
                                    children: [
                                      // Spacer(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 190,
                                        child: Text(
                                          Video_Song[index]['title'],
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Gap(3),
                                      Container(
                                        width: 190,
                                        child: Text(
                                          '${Video_Song[index]['singers'][0]}  ${Video_Song[index]['singers'][1]}',
                                          style: TextStyle(color: Colors.grey),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Gap(3),
                                      Container(
                                        width: 190,
                                        child: Text(
                                          'Duration: ${Video_Song[index]['duration']}',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
