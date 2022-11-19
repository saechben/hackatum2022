import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'camera.dart';
import 'map.dart';
import 'leaderboard.dart';

var cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const CupertinoTabBarApp());
}

class CupertinoTabBarApp extends StatelessWidget {
  const CupertinoTabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoTabBarExample(),
    );
  }
}

class CupertinoTabBarExample extends StatelessWidget {
  const CupertinoTabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.rosette),
            label: 'Leaderboard',
          ),
          // BottomNavigationBarItem for Camera
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.photo_camera),
            label: 'Camera',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return Center(
              child: showPage(index)
            );
          },
        );
      },
    );
  }
  
  showPage(int index){
     switch(index){
      case 0:
        return const MyApp();
      case 1:
        return const Leaderboard();
      case 2: {
        return MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
              // Pass the appropriate camera to the TakePictureScreen widget.
              camera: cameras.first,
        ));
      }
     }
  }
}
