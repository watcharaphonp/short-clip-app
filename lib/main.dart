import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/screens/TTSplashScreen.dart';

late List<CameraDescription> cameras;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TTSplashScreen(),
    );
  }
}
