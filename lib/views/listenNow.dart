import 'package:buzzsprout_podcast/views/playMusic.dart';
import 'package:flutter/material.dart';
import 'package:buzzsprout_podcast/services/api.dart';
import 'package:transparent_image/transparent_image.dart';

var blueColor = Color(0xFF78b044);

class ListenNow extends StatefulWidget {
  final songTitle;
  final albumTitle;
  final imageSong;
  final songUrl;
  final description;
  final artist;

  ListenNow(
      {this.songTitle,
      this.albumTitle,
      this.imageSong,
      this.songUrl,
      this.description,
      this.artist});

  @override
  _ListenNowState createState() => _ListenNowState();
}

class _ListenNowState extends State<ListenNow> {
  @override
  Widget build(BuildContext context) {
    return
        // child:
        Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 420.0,
              width: double.infinity,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: widget.imageSong,
                    child: Image.network(
                      widget.imageSong,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 350.0,
                    ),
                  ),
                  Container(
                      height: 350.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0x00000000),
                            const Color(0xD9333333)
                          ],
                          stops: [
                            0.0,
                            0.9,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(0.0, 1.0),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 25.0,
                            left: 20.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 25.0,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                widget.songTitle,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: "SF-Pro-Display-Bold"),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 130.0,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Hero(
                                tag: 'play',
                                child: GestureDetector(
                                  onTap: () {
                                    print('clik in play');
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PlayMusic(
                                                  title: widget.songTitle,
                                                  artist: widget.artist,
                                                  image: widget.imageSong,
                                                  songUrl: widget.songUrl,
                                                  albumTitle: widget.albumTitle,
                                                )));
                                  },
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 50.0,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width *
                                    14 /
                                    100,
                                left: MediaQuery.of(context).size.width *
                                    14 /
                                    100,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'The Redimi2:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontFamily: "SF-Pro-Display-Bold",
                                    ),
                                  ),
                                  Text(
                                    widget.albumTitle,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35.0,
                                      fontFamily: "SF-Pro-Display-Bold",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 320.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal:
                            MediaQuery.of(context).size.width * 14 / 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Album info',
                          style: TextStyle(
                            fontFamily: 'SF-Pro-Display-Bold',
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          removeAllHtmlTags(widget.description),
                          style: TextStyle(
                            fontFamily: 'SF-Pro-Display-Bold',
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          'More songs',
                          style: TextStyle(
                            fontFamily: 'SF-Pro-Display-Bold',
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  // top: 150.0,
                  // left: MediaQuery.of(context).size.width * 14 / 100,
                  // child:
                  ListenNowBottomPart(),
                  //   ],
                  // ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}

class ListenNowBottomPart extends StatefulWidget {
  @override
  ListenNowBottomPartState createState() => ListenNowBottomPartState();
}

class ListenNowBottomPartState extends State<ListenNowBottomPart> {
  ApiRest buzzsproutbuzz = ApiRest();

  final GlobalKey<ListenNowBottomPartState> _key =
      new GlobalKey<ListenNowBottomPartState>();

  List<String> images = [
    "https://i.ytimg.com/vi/bLMZw5AC62A/maxresdefault.jpg",
    "https://reggaetonsinlimite.b-cdn.net/wp-content/uploads/2019/05/Filipenses-1-6.jpg",
    "https://i.ytimg.com/vi/X5sqhB6Gxb4/maxresdefault.jpg"
  ];

  List<String> titles = ["Gravy", "Filipenses 1:13", "Alegria"];

  List<Widget> movies() {
    List<Widget> movieList = new List();

    for (int i = 0; i < 3; i++) {
      var movieitem = Padding(
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 12.0),
        child: Container(
          height: 220.0,
          width: 135.0,
          margin: i == 0
              ? EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 10 / 100)
              : EdgeInsets.only(left: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0))
              ]),
          child: GestureDetector(
            onTap: () {
              print('tap in song');
              // setState(() {
              // globals.content = new ProfilePage();
              // ListenNow(
              //   songTitle: titles[i],
              //   albumTitle: 'Trapstornadores',
              //   imageSong: images[i],
              // );
              // });
              Navigator.of(_key.currentContext).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListenNow(
                        songTitle: titles[i],
                        albumTitle: 'Trapstornadores',
                        imageSong: images[i],
                      )));
            },
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  child: Stack(
                    children: <Widget>[
                      // Hero(
                      //   tag: images[i],
                      // child:
                      Image.network(
                        images[i],
                        width: double.infinity,
                        height: 130.0,
                        fit: BoxFit.cover,
                      ),
                      // ),
                      Container(
                        height: 130.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x00000000),
                              const Color(0xD9333333)
                            ],
                            stops: [
                              0.0,
                              0.9,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
                  child: Text(titles[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontFamily: "SF-Pro-Display-Bold")),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.0),
                  child: Text("Trapstornadores"
                      // i == 0 ? "Trapstornadores" : ""
                      ),
                ),
              ],
            ),
          ),
        ),
      );
      movieList.add(movieitem);
    }
    return movieList;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      key: _key,
      height: 260.0,
      margin: EdgeInsets.only(top: 210.0),
      //  left: MediaQuery.of(context).size.width * 10 / 100,
      child: Column(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text(
          //         "Listen now",
          //         style: TextStyle(
          //             fontSize: 22.0, fontFamily: "SF-Pro-Display-Bold"),
          //       ),
          //       FlatButton(
          //         child: Text("Listen more"),
          //         onPressed: () {},
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 250.0,
          //   child: ListView(
          //     // shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     children: movies(),
          //   ),
          // )
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
                return Container(
                  height: 250.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: songs.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 12.0),
                        child: Container(
                          height: 220.0,
                          width: 135.0,
                          margin: i == 0
                              ? EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      10 /
                                      100)
                              : EdgeInsets.only(left: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 10.0))
                              ]),
                          child: GestureDetector(
                            onTap: () {
                              print('tap in song');
                              // setState(() {
                              // globals.content = new ProfilePage();
                              // ListenNow(
                              //   songTitle: titles[i],
                              //   albumTitle: 'Trapstornadores',
                              //   imageSong: images[i],
                              // );
                              // });
                              Navigator.of(_key.currentContext).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ListenNow(
                                            songTitle:
                                                songs[i]['title'].toString(),
                                            albumTitle:
                                                songs[i]['tags'].toString(),
                                            imageSong: songs[i]['artwork_url']
                                                .toString(),
                                            songUrl: songs[i]['audio_url']
                                                .toString(),
                                            description: songs[i]['description']
                                                .toString(),
                                            artist:
                                                songs[i]['artist'].toString(),
                                          )));
                            },
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      // Hero(
                                      //   tag: images[i],
                                      // child:
                                      FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: songs[i]['artwork_url']
                                              .toString(),
                                          width: double.infinity,
                                          height: 130.0,
                                          fit: BoxFit.cover,
                                        ),
                                      // Image.network(
                                      //   songs[i]['artwork_url'].toString(),
                                      //   width: double.infinity,
                                      //   height: 130.0,
                                      //   fit: BoxFit.cover,
                                      // ),
                                      // ),
                                      Container(
                                        height: 130.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              const Color(0x00000000),
                                              const Color(0xD9333333)
                                            ],
                                            stops: [
                                              0.0,
                                              0.9,
                                            ],
                                            begin: FractionalOffset(0.0, 0.0),
                                            end: FractionalOffset(0.0, 1.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 8.0, right: 8.0),
                                  child: Text(songs[i]['title'].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: "SF-Pro-Display-Bold")),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3.0),
                                  child: Text(songs[i]['tags'].toString()
                                      // i == 0 ? "Trapstornadores" : ""
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
        ],
      ),
    );
  }
}
