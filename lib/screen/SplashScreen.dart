import 'dart:async';

import 'package:flutter/material.dart';
import 'package:network_sqflite/screen/screen1.dart';

class Splash extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return SplashState();
  }

}
class SplashState extends State<Splash>{
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
          ()=>Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) =>
              Employ(),
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      body: Center(
        child: Container(child: Text('Loading...'),
        ),
      ),
    );
  }

}