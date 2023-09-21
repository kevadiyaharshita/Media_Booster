import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_player/controller/DateTimeController.dart';
import 'package:provider/provider.dart';

import '../../controller/PageController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Page_Controller>(
      builder: (context, pro, _) {
        return Scaffold(
          appBar: AppBar(
            title: Consumer<DateTimeController>(builder: (context, p, _) {
              return Text(
                p.greetings[p.getIndex],
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              );
            }),
          ),
          body: Center(
            child: pro.allPages[pro.getIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: pro.getIndex,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            onTap: (index) {
              pro.changePage(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.music_house_fill), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.music_note_2), label: "Audio"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.video_camera_solid),
                  label: "Video"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings")
            ],
          ),
        );
      },
    );
  }
}
