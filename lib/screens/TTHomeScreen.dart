import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/widgets.dart';
import 'package:tiktok/components/TTStoryComponent.dart';
import 'package:tiktok/components/TTStoryHeaderComponent.dart';
import 'package:tiktok/model/TTModel.dart';
import 'package:tiktok/utils/TTColors.dart';
import 'package:tiktok/utils/TTDataProvider.dart';

class TTHomeScreen extends StatefulWidget {
  static String tag = '/TTHomeScreen';

  @override
  TTHomeScreenState createState() => TTHomeScreenState();
}

class TTHomeScreenState extends State<TTHomeScreen> {
  var mStoryList = getStoryData();
  var shortClipList;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final result = await getShortClipData();
    shortClipList = result;
    // print(shortClipList[0]);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 20,
          itemBuilder: (context, index) {
            TTStoryModel data = mStoryList[index % mStoryList.length];
            return TTStoryComponent(
              model: data,
              pos: index,
            );
          });
    }

    return Scaffold(
      backgroundColor: TTColorBlack,
      body: Stack(
        children: <Widget>[
          _body(),
          TTStoryHeaderComponent(),
        ],
      ),
    );
  }
}
