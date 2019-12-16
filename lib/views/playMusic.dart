import 'package:buzzsprout_podcast/main.dart';
import 'package:buzzsprout_podcast/views/home.dart';
import 'package:buzzsprout_podcast/views/listen.dart';
import 'package:flutter/material.dart';
import 'package:buzzsprout_podcast/globals/globals.dart' as globals;
import 'package:audioplayers/audioplayers.dart';
import 'package:media_player/data_sources.dart';
import 'package:media_player/media_player.dart';

import 'dart:io' show Platform;
// import 'package:audioplayers/audio_cache.dart';

var blueColor = Color(0xFF78b044);
var pinkColor = Color(0xFFEEEEEE);

class PlayMusic extends StatefulWidget {
  final title;
  final artist;
  final image;
  final songUrl;
  final albumTitle;
  PlayMusic(
      {this.title, this.artist, this.image, this.songUrl, this.albumTitle});
  PlayMusicState createState() => PlayMusicState();
}

class PlayMusicState extends State<PlayMusic> {
  AudioPlayer audioPlayer;
  // AudioCache audioCache;

  Duration duration = Duration();
  Duration position = Duration();

  bool statusPlay, songStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statusPlay = false;
    songStatus = false;
    // audioPlayer = AudioPlayer();
    // audioCache = AudioCache(fixedPlayer: audioPlayer);

    // audioPlayer.onDurationChanged.listen((Duration d) {
    //   print('Max duration: $d');
    //   setState(() => duration = d);
    // });

    // audioPlayer.onAudioPositionChanged.listen((Duration p) {
    //   print('Current position: $p');
    //   setState(() => position = p);
    // });
    if (globals.songStatus && globals.statusPlaylist) {
      setState(() {
        stopMusic();
        stopVideo();
        globals.audioPlayer = AudioPlayer();
        playMusic();
        if (Platform.isAndroid) {
          globals.currentSong = MediaFile(
            title: widget.title,
            type: "audio",
            source: widget.songUrl,
            desc: widget.albumTitle,
          );
          globals.player = MediaPlayerPlugin.create(
              isBackground: true, showNotification: true);
          initVideo();
        }
        duration = Duration();
        position = Duration();

        globals.audioPlayer.onDurationChanged.listen((Duration d) {
          print('Max duration: $d');
          setState(() => duration = d);
        });

        globals.audioPlayer.onAudioPositionChanged.listen((Duration p) {
          print('Current position: $p');
          setState(() => position = p);
        });
      });
    } else {
      playMusic();
      if (Platform.isAndroid) {
        globals.currentSong = MediaFile(
          title: widget.title,
          type: "audio",
          source: widget.songUrl,
          desc: widget.albumTitle,
        );
        globals.player = MediaPlayerPlugin.create(
            isBackground: true, showNotification: true);
        initVideo();
      }
      globals.audioPlayer.onDurationChanged.listen((Duration d) {
        print('Max duration: $d');
        setState(() => duration = d);
      });

      globals.audioPlayer.onAudioPositionChanged.listen((Duration p) {
        print('Current position: $p');
        setState(() => position = p);
      });
    }
  }

  stopMusic() async {
    await globals.audioPlayer.stop();
  }

  playMusic() async {
    setState(() {
      statusPlay = !statusPlay;
      songStatus = true;
      globals.songStatus = true;
      globals.statusPlaylist = false;
    });
    await globals.audioPlayer.play(widget.songUrl);
    await globals.audioPlayer.setVolume(0.0);
  }

  void initVideo() async {
    await globals.player.initialize();
    await globals.player.setSource(globals.currentSong);
    globals.player.play();
    // globals.player.setVolume(0.0);
  }

  void stopVideo() async {
    globals.player.pause();
    await globals.player.initialize();
    await globals.player.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    globals.statusPlaylist = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: Column(
        children: <Widget>[
          Container(
            height: 400.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.black12.withOpacity(0.9),
                      blueColor.withOpacity(0.4),
                      blueColor
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: <Widget>[
                      // SizedBox(height: 52.0),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'PLAYLIST',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                              ),
                              Text(widget.albumTitle,
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              globals.curIndex = 2;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage()));
                            },
                            child: Icon(
                              Icons.playlist_add,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(widget.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32.0)),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        widget.artist,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18.0),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 42.0),
          Slider(
            value: position.inSeconds.toDouble(),
            max: duration.inSeconds.toDouble(),
            onChanged: (double seconds) {
              setState(() {
                globals.player.seek(seconds.toInt());
                globals.audioPlayer.seek(Duration(seconds: seconds.toInt()));
              });
            },
            activeColor: pinkColor,
            inactiveColor: Colors.white.withOpacity(0.6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  position.inSeconds.toDouble() != 0.0
                      ? _returnTimeMusic(position)
                      : '0:00',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Text(
                    duration.inSeconds.toDouble() != 0.0
                        ? duration.inMinutes.toString() +
                            ':' +
                            (duration.inSeconds - (duration.inMinutes * 60))
                                .toString()
                        : '0:00',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)))
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.fast_rewind,
                color: Colors.white54,
                size: 38.0,
              ),
              SizedBox(width: 32.0),
              GestureDetector(
                onTap: () async {
                  print(widget.songUrl);
                  setState(() {
                    statusPlay = !statusPlay;
                  });
                  // if (statusPlay &&
                  //     !songStatus &&
                  //     duration.inSeconds.toDouble() == 0.0) {
                  //   int result = await globals.audioPlayer.play(widget.songUrl);
                  //   // await audioPlayer.play(widget.songUrl);
                  //   if (result == 1) {
                  //     print('Reproduciendo');
                  //     songStatus = true;
                  //     globals.songStatus = true;
                  //     globals.statusPlaylist = false;
                  //   }
                  // } else {
                  if (songStatus) {
                    if (Platform.isAndroid) {
                      await globals.player.pause();
                    }
                    int result = await globals.audioPlayer.pause();
                    // await audioPlayer.pause();
                    if (result == 1) {
                      print('Paused');
                      songStatus = false;
                      globals.songStatus = false;
                    }
                  } else {
                    if (Platform.isAndroid) {
                      await globals.player.play();
                    }
                    int result = await globals.audioPlayer.resume();
                    // await audioPlayer.resume();
                    if (result == 1) {
                      print('Resume');
                      songStatus = true;
                      globals.songStatus = true;
                    }
                  }
                  // }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: pinkColor,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: 'play',
                        child: Icon(
                          !statusPlay ? Icons.play_arrow : Icons.pause,
                          size: 48.0,
                          color: blueColor,
                        ),
                      ),
                    )),
              ),
              SizedBox(width: 32.0),
              Icon(
                Icons.fast_forward,
                color: Colors.white54,
                size: 38.0,
              )
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.bookmark_border,
                color: pinkColor,
              ),
              Icon(
                Icons.shuffle,
                color: pinkColor,
              ),
              Icon(
                Icons.repeat,
                color: pinkColor,
              ),
            ],
          ),
          // SizedBox(height: 58.0),
          SizedBox(height: 18.0),
        ],
      ),
    );
  }

  String _returnTimeMusic(Duration time) {
    String seconds = (time.inMinutes >= 1
            ? ((time.inSeconds - time.inMinutes * 60))
            : time.inSeconds)
        .toString();

    if (time.inSeconds < 10) {
      seconds = '0' + seconds;
    }

    String timeSong = time.inMinutes.toString() + ':' + seconds;

    return timeSong;
  }
}
