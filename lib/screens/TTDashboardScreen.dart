import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tiktok/screens/TTAddPostScreen.dart';
import 'package:tiktok/screens/TTHomeScreen.dart';
import 'package:tiktok/utils/TTColors.dart';

import 'TTNotificationScreen.dart';
import 'TTProfileScreen.dart';
import 'TTSearchScreen.dart';

class TTDashboardScreen extends StatefulWidget {
  static String tag = '/TTDashboardScreen';

  @override
  TTDashboardScreenState createState() => TTDashboardScreenState();
}

class TTDashboardScreenState extends State<TTDashboardScreen> {
  var selectedIndex = 0;

  var pages = [
    TTHomeScreen(),
    TTSearchScreen(),
    TTAddPostScreen(),
    TTNotificationScreen(),
    TTProfileScreen(isUser: true),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mBottomItem(var icon, var pos) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _onItemTapped(pos);
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selectedIndex == pos ? white : white.withOpacity(0.7), size: 30).center(),
            4.height,
            selectedIndex == pos ? Container(decoration: boxDecorationWithShadow(borderRadius: radius(10), backgroundColor: white), height: 3, width: 25) : SizedBox()
          ],
        ),
      );
    }

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: selectedIndex != 2
          ? Container(
              height: 60,
              color: black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  mBottomItem(Icons.home, 0),
                  mBottomItem(Icons.search, 1),
                  btnAdd(2),
                  mBottomItem(Icons.notifications, 3),
                  mBottomItem(Icons.person, 4),
                ],
              ))
          : SizedBox(),
    );
  }

  btnAdd(var pos) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(pos);
        print("Pos" + pos.toString());
      },
      child: Container(
        width: 40,
        height: 30,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 28,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)), color: TTColorSerpent),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 28,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: TTColorRed),
              ),
            ),
            Center(
              child: Container(
                width: 28,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: white),
                child: Center(child: Icon(Icons.add, color: black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
