import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MyAudio extends ChangeNotifier {
  Duration totalDuration;
  Duration position;
  String audioState;
  MyAudio() {
    initAudio();
  }

  AudioPlayer _audioPlayer = AudioPlayer();

  initAudio() {
    _audioPlayer.onDurationChanged.listen((event) {
      totalDuration = event;
      notifyListeners();
    });

    _audioPlayer.onAudioPositionChanged.listen((event) {
      position = event;
      notifyListeners();
    });

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) audioState = "Playing";
      if (event == AudioPlayerState.PAUSED) audioState = "Paused";
      if (event == AudioPlayerState.STOPPED) audioState = "Stopped";
    });
  }

  playAudio() {
    _audioPlayer.play(
        "https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4");
  }

  pauseAudio() {
    _audioPlayer.pause();
  }

  stopAudio() {
    _audioPlayer.stop();
  }

  seekAudio(Duration durationToSeek) {
    _audioPlayer.seek(durationToSeek);
  }
}
