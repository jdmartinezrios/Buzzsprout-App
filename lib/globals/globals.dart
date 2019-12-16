library buzzsprout_podcast.globals;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:media_player/media_player.dart';
import 'package:media_player/data_sources.dart';

Widget content;

int curIndex;

AudioPlayer audioPlayer = AudioPlayer();
MediaPlayer player;
MediaFile currentSong;

Duration duration = Duration();
Duration position = Duration();

bool statusPlay = false;
bool songStatus = false;
bool statusPlaylist = false;
