import 'package:flutter/foundation.dart';

class Movie_Modal {
  String movie;
  String title;
  List<String> singer;
  String image;
  String path;

  Movie_Modal(
      {required this.movie,
      required this.title,
      required this.singer,
      required this.image,
      required this.path});

  factory Movie_Modal.fromMap({required Map data}) {
    return Movie_Modal(
      movie: data['movie'],
      title: data['title'],
      singer: data['singers'],
      image: data['image'],
      path: data['path'],
    );
  }
}
