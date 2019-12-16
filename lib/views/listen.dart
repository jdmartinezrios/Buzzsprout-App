import 'package:buzzsprout_podcast/views/playMusic.dart';
import 'package:flutter/material.dart';
import 'package:buzzsprout_podcast/services/api.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:buzzsprout_podcast/globals/globals.dart' as globals;

var blueColor = Color(0xFF78b044);

class ListenPage extends StatefulWidget {
  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  
  ApiRest buzzsproutbuzz = ApiRest();
  List<String> _songs = ['Alegria', 'Gravy', 'Filipense 1:13'];
  List<String> _images = [
    "https://i.ytimg.com/vi/bLMZw5AC62A/maxresdefault.jpg",
    "https://reggaetonsinlimite.b-cdn.net/wp-content/uploads/2019/05/Filipenses-1-6.jpg",
    "https://i.ytimg.com/vi/X5sqhB6Gxb4/maxresdefault.jpg"
  ];
  List<Widget> songs() {
    List<Widget> songList = new List();

    for (int i = 0; i < 3; i++) {
      var songItems = GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PlayMusic(
                    title: _songs[i],
                    artist: 'Redimi2',
                    image: _images[i],
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 26.0),
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 80.0,
                    width: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        _images[i],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                      height: 80.0,
                      width: 80.0,
                      child: Icon(
                        Icons.play_circle_filled,
                        color: Colors.white.withOpacity(0.7),
                        size: 42.0,
                      ))
                ],
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _songs[i],
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "SF-Pro-Display-Bold",
                        fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Redimi2',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16.0,
                      fontFamily: "SF-Pro-Display-Bold",
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.more_horiz,
                color: Colors.white.withOpacity(0.6),
                size: 32.0,
              )
            ],
          ),
        ),
      );
      songList.add(songItems);
    }
    return songList;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globals.statusPlaylist = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          // Colors.black12.withOpacity(0.9),
          // blueColor.withOpacity(0.9),
          // blueColor
          Color(0xFFEEEEEE),
          Color(0xFFEEEEEE),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child:
          // ListView(
          //   children: songs(),
          // ),
          FutureBuilder(
        future: buzzsproutbuzz.getPlayList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.data != null) {
            var songs = snapshot.data;
            return Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    'PLAYLIST',
                    style: TextStyle(
                        // color: Colors.white,
                        color: Colors.black12.withOpacity(0.6),
                        fontFamily: 'SF-Pro-Display-Bold',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  // height: 250.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: songs.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => PlayMusic(
                                    title: songs[i]['title'].toString(),
                                    artist: songs[i]['artist'].toString(),
                                    image: songs[i]['artwork_url'].toString(),
                                    songUrl: songs[i]['audio_url'].toString(),
                                    albumTitle: songs[i]['tags'].toString(),
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 26.0),
                          child: Row(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 80.0,
                                    width: 80.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image:
                                            songs[i]['artwork_url'].toString(),
                                        fit: BoxFit.cover,
                                      ),
                                      // Image.network(
                                      //  songs[i]['artwork_url'].toString(),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                  ),
                                  Container(
                                      height: 80.0,
                                      width: 80.0,
                                      child: Icon(
                                        Icons.play_circle_filled,
                                        color: Colors.white.withOpacity(0.7),
                                        size: 42.0,
                                      ))
                                ],
                              ),
                              SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    songs[i]['title'].toString(),
                                    style: TextStyle(
                                        // color: Colors.white,
                                        color: Colors.black12.withOpacity(0.9),
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: "SF-Pro-Display-Bold",
                                        fontSize: 18.0),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    songs[i]['artist'].toString(),
                                    style: TextStyle(
                                      // color: Colors.white.withOpacity(0.5),
                                      color: Colors.black12.withOpacity(0.6),
                                      fontSize: 16.0,
                                      fontFamily: "SF-Pro-Display-Bold",
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.more_horiz,
                                color: Colors.black12.withOpacity(0.3),
                                size: 32.0,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );

            // _buildListView(songs);
          } else {
            return Container(
              height: 250.0,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: blueColor,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
