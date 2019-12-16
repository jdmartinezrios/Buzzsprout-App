import 'package:buzzsprout_podcast/views/listen.dart';
import 'package:buzzsprout_podcast/views/listenNow.dart';
import 'package:buzzsprout_podcast/views/profile.dart';
import 'package:buzzsprout_podcast/views/search.dart';
import 'package:buzzsprout_podcast/globals/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:buzzsprout_podcast/services/api.dart';
import 'package:transparent_image/transparent_image.dart';

var blueColor = Color(0xFF78b044);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _curIndex = 0;
  ApiRest buzzsproutbuzz = ApiRest();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllSongs();

    if (globals.curIndex == null) {
      globals.curIndex = 0;
      globals.content = Column(
        children: <Widget>[
          HomeTopPart(),
          HomeBottomPart(),
        ],
      );
    } else {
      switch (globals.curIndex) {
        case 2:
          globals.content = ListenPage();
          break;
        default:
      }
    }
  }

  getAllSongs() async {
    final songBuzz = await buzzsproutbuzz.getPlayList();
    print(songBuzz.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SingleChildScrollView(child: globals.content),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: globals.curIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: globals.curIndex == 0 ? Color(0xFF78b044) : Colors.grey,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                color: globals.curIndex == 0 ? Color(0xFF78b044) : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: globals.curIndex == 1 ? Color(0xFF78b044) : Colors.grey,
            ),
            title: Text(
              "Search",
              style: TextStyle(
                color: globals.curIndex == 1 ? Color(0xFF78b044) : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.music_note,
                color: globals.curIndex == 2 ? Color(0xFF78b044) : Colors.grey,
              ),
              title: Text(
                "Listen",
                style: TextStyle(
                  color:
                      globals.curIndex == 2 ? Color(0xFF78b044) : Colors.grey,
                ),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: globals.curIndex == 3 ? Color(0xFF78b044) : Colors.grey,
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                color: globals.curIndex == 3 ? Color(0xFF78b044) : Colors.grey,
              ),
            ),
          )
        ],
        onTap: (index) {
          setState(() {
            globals.curIndex = index;
            switch (globals.curIndex) {
              case 0:
                globals.content = Column(
                  children: <Widget>[
                    HomeTopPart(),
                    HomeBottomPart(),
                  ],
                );
                break;
              case 1:
                globals.content = SearchPage();
                break;
              case 2:
                globals.content = ListenPage();
                break;
              case 3:
                globals.content = ProfilePage();
                break;
            }
          });
        },
      ),
    );
  }
}

class HomeTopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: Mclipper(),
            child: Container(
              height: 370.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image:
                        'https://direct.rhapsody.com/imageserver/images/alb.303439154/500x500.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  // Image.network(
                  //   'https://direct.rhapsody.com/imageserver/images/alb.303439154/500x500.jpg',
                  //   fit: BoxFit.cover,
                  //   width: double.infinity,
                  // ),
                  Container(
                    height: double.infinity,
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
                    child: Padding(
                      padding: EdgeInsets.only(top: 120.0, left: 95.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'LISTEN BEFORE EVERYONE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: "SF-Pro-Display-Bold",
                            ),
                          ),
                          Text(
                            'The Redimi2: Trapstorno',
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
              ),
            ),
          ),
          Positioned(
            top: 370.0,
            right: -20.0,
            child: FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: Row(
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                      color: Color(0xFF78b044),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Hero(
                      tag:
                          'https://direct.rhapsody.com/imageserver/images/alb.303439154/500x500.jpg',
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => ListenNow(
                                    songTitle: 'Redimi2',
                                    albumTitle: 'Trapstorno',
                                    imageSong:
                                        'https://direct.rhapsody.com/imageserver/images/alb.303439154/500x500.jpg',
                                    songUrl:
                                        'https://www.buzzsprout.com/759992/2264513-alegria.mp3',
                                    description:
                                        'It is the twelfth album and tenth studio album of the Dominican Christian music singer Redimi2. It was released on July 20, 2018. Within the album, the singles stand out: «Trapstorno», «For a like», «Who against me», «Asina Nona» and «La fiesta».',
                                    artist: 'Redimi2',
                                  )));
                        },
                        color: Color(0xFF78b044),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 80.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Listen Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "SF-Pro-Display-Bold",
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.arrow_back,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeBottomPart extends StatefulWidget {
  @override
  HomeBottomPartState createState() => HomeBottomPartState();
}

class HomeBottomPartState extends State<HomeBottomPart> {
  ApiRest buzzsproutbuzz = ApiRest();
  final GlobalKey<HomeBottomPartState> _key =
      new GlobalKey<HomeBottomPartState>();

  List<String> images = [
    "https://i.ytimg.com/vi/bLMZw5AC62A/maxresdefault.jpg",
    "https://reggaetonsinlimite.b-cdn.net/wp-content/uploads/2019/05/Filipenses-1-6.jpg",
    "https://i.ytimg.com/vi/X5sqhB6Gxb4/maxresdefault.jpg"
  ];

  List<String> titles = ["Gravy", "Filipenses 1:13", "Alegria"];

  // List<Widget>
  // Widget movies(List songs) {
  //   // List<Widget> movieList = new List();

  //   // for (int i = 0; i < 3; i++) {
  //   // var movieitem =
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 12.0),
  //     child: Container(
  //       height: 220.0,
  //       width: 135.0,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20.0),
  //           color: Colors.white,
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Colors.black12,
  //                 blurRadius: 10.0,
  //                 offset: Offset(0.0, 10.0))
  //           ]),
  //       child: GestureDetector(
  //         onTap: () {
  //           print('tap in song');
  //           // setState(() {
  //           // globals.content = new ProfilePage();
  //           // ListenNow(
  //           //   songTitle: titles[i],
  //           //   albumTitle: 'Trapstornadores',
  //           //   imageSong: images[i],
  //           // );
  //           // });
  //           Navigator.of(_key.currentContext).push(MaterialPageRoute(
  //               builder: (BuildContext context) => ListenNow(
  //                     songTitle: titles[i],
  //                     albumTitle: 'Trapstornadores',
  //                     imageSong: images[i],
  //                   )));
  //         },
  //         child: Column(
  //           children: <Widget>[
  //             ClipRRect(
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(20.0),
  //                   topRight: Radius.circular(20.0)),
  //               child: Stack(
  //                 children: <Widget>[
  //                   Hero(
  //                     tag: images[i],
  //                     child: Image.network(
  //                       images[i],
  //                       width: double.infinity,
  //                       height: 130.0,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   Container(
  //                     height: 130.0,
  //                     width: double.infinity,
  //                     decoration: BoxDecoration(
  //                       gradient: LinearGradient(
  //                         colors: [
  //                           const Color(0x00000000),
  //                           const Color(0xD9333333)
  //                         ],
  //                         stops: [
  //                           0.0,
  //                           0.9,
  //                         ],
  //                         begin: FractionalOffset(0.0, 0.0),
  //                         end: FractionalOffset(0.0, 1.0),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
  //               child: Text(titles[i],
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       fontSize: 16.0, fontFamily: "SF-Pro-Display-Bold")),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(top: 3.0),
  //               child: Text("Trapstornadores"
  //                   // i == 0 ? "Trapstornadores" : ""
  //                   ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //   //   movieList.add(movieitem);
  //   // }
  //   // return movieList;
  // }

  @override
  Widget build(BuildContext context) {
    return new Container(
      key: _key,
      height: 360.0,
      // margin: EdgeInsets.only(left: 65.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 85.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Listen now",
                  style: TextStyle(
                      fontSize: 22.0, fontFamily: "SF-Pro-Display-Bold"),
                ),
                FlatButton(
                  child: Text("Listen more"),
                  onPressed: () {},
                )
              ],
            ),
          ),
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
                              ? EdgeInsets.only(left: 65.0)
                              : EdgeInsets.only(left: 0.0),
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
                                      Hero(
                                        tag: songs[i]['artwork_url'].toString(),
                                        child: FadeInImage.memoryNetwork(
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
                                      ),
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

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 100.0);

    var controlpoint = Offset(35.0, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx, endpoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
