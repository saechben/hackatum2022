import 'package:flutter/cupertino.dart';
import 'map.dart';

void main() => runApp(const CupertinoTabBarApp());

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
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return const Center(
              child: MyApp(),
            );
          },
        );
      },
    );
  }
}
