import 'package:flutter/material.dart';

var blueColor = Color(0xFFEEEEEE);

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [blueColor, blueColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Center(
        child:
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(100),
            //   child:
            Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
                'https://direct.rhapsody.com/imageserver/images/alb.303439154/500x500.jpg'),
          ),
        ),
      ),
      // ),
    );
  }
}
