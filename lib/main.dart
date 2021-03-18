import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'albumart.dart';
import 'navbar.dart';
import 'playerControls.dart';
import 'models/myaudio.dart';
import 'colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (_) => MyAudio(),
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double sliderValue = 2;
  Map audioData = {
    'image':
        'https://thegrowingdeveloper.org/thumbs/1000x1000r/audios/quiet-time-photo.jpg',
    'url':
        'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'
  };
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavigationBar(),
          Container(
            margin: EdgeInsets.only(left: 40),
            height: height / 2.5,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return AlbumArt();
              },
              itemCount: 1,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Text(
            'Gidget',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: darkPrimaryColor,
            ),
          ),
          Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: 5,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)),
                child: Consumer<MyAudio>(
                  builder: (_, myAudioModel, child) => Slider(
                    value: myAudioModel.position == null
                        ? 0
                        : myAudioModel.position.inMilliseconds.toDouble(),
                    activeColor: darkPrimaryColor,
                    inactiveColor: darkPrimaryColor.withOpacity(0.3),
                    onChanged: (value) {
                      myAudioModel
                          .seekAudio(Duration(milliseconds: value.toInt()));
                    },
                    min: 0,
                    max: myAudioModel.totalDuration == null
                        ? 100
                        : myAudioModel.totalDuration.inMilliseconds.toDouble(),
                  ),
                ),
              )
            ],
          ),
          PlayerControls(),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
