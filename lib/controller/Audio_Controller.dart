import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioController extends ChangeNotifier {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  double totalDuration = 0;
  bool _isPlaying = false;

  openSongs({required String path}) {
    assetsAudioPlayer
        .open(
      Audio(path),
      autoStart: true,
      showNotification: true,
    )
        .then(
      (value) {
        totalDuration = assetsAudioPlayer
            .current.value!.audio.duration.inSeconds
            .toDouble();
        notifyListeners();
      },
    );
  }

  pause() {
    assetsAudioPlayer.pause();
    notifyListeners();
  }

  play() {
    assetsAudioPlayer.play();
    notifyListeners();
  }

  setStatus() {
    _isPlaying = (assetsAudioPlayer.isPlaying.value) ? false : true;
    // _isPlaying = (assetsAudioPlayer.isPlaying.value) ? true : false;
    print("Status : ${_isPlaying}");
    notifyListeners();
  }

  bool get getStatus {
    return _isPlaying;
  }

  changeStatus() {
    (assetsAudioPlayer.isPlaying.value) ? pause() : play();
  }

  refreshUI() {
    notifyListeners();
  }

  seek({required int seconds}) {
    assetsAudioPlayer.seek(
      Duration(seconds: seconds),
    );
    notifyListeners();
  }

  close() {
    assetsAudioPlayer.stopped;
    notifyListeners();
  }
}

// String _currentPlaysongTitle = 'h';
// String _currentSwipesongTitle = '';
// String _path = '';
//
// setPath({required String path}) {
//   _path = path;
//   notifyListeners();
// }
//
// get getPath {
//   return _path;
// }
//
// setSwipeSongTitle({required String title}) {
//   _currentSwipesongTitle = title;
//   notifyListeners();
// }
//
// get getcurretSwipeSong {
//   return _currentSwipesongTitle;
// }
//
// setplaySongTitle({required String songtitle}) {
//   _currentPlaysongTitle = songtitle;
//   notifyListeners();
// }
//
// get getSongTitle {
//   return _currentPlaysongTitle;
// }
