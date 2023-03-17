import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tiktok/model/TTModel.dart';
import 'package:tiktok/screens/TTStoryScreen.dart';
import 'package:tiktok/utils/TTDataProvider.dart';
import 'package:tiktok/utils/TTWidgets.dart';

class TTProfileComponent extends StatefulWidget {
  static String tag = '/TTProfileComponent';

  @override
  TTProfileComponentState createState() => TTProfileComponentState();
}

class TTProfileComponentState extends State<TTProfileComponent> {
  List<TTAccountModel> mAccountList = getAccount();

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
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: mAccountList.length,
      padding: EdgeInsets.only(bottom: 50),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            TTStoryScreen().launch(context);
          },
          child: Stack(
            children: [
              Container(
                height: 150,
                child: FittedBox(
                  child: commonCacheImageWidget(mAccountList[index].post),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8, left: 8),
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [Icon(Icons.favorite_border, color: white, size: 16), 4.width, Text(mAccountList[index].like, style: primaryTextStyle(color: white))],
                ),
              ),
            ],
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
    );
  }
}
