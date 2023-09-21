import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioController extends ChangeNotifier {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  double totalDuration = 0;

  openSongs({required String path}) {
    assetsAudioPlayer
        .open(
      Audio(path),
      autoStart: false,
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
