import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tiktok/components/TTStoryComponent.dart';
import 'package:tiktok/components/TTStoryHeaderComponent.dart';
import 'package:tiktok/model/TTModel.dart';
import 'package:tiktok/utils/TTColors.dart';
import 'package:tiktok/utils/TTDataProvider.dart';

class TTStoryScreen extends StatefulWidget {
  static String tag = '/TTStoryScreen';

  @override
  TTStoryScreenState createState() => TTStoryScreenState();
}

class TTStoryScreenState extends State<TTStoryScreen> with SingleTickerProviderStateMixin {
  var mStoryList = getStoryData();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
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
            return TTStoryComponent(model: data, pos: index);
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
