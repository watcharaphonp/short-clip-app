import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tiktok/components/TTProfileComponent.dart';
import 'package:tiktok/screens/TTEditProfileScreen.dart';
import 'package:tiktok/screens/TTFollowingListScreen.dart';
import 'package:tiktok/screens/TTSettingScreen.dart';
import 'package:tiktok/utils/TTColors.dart';
import 'package:tiktok/utils/TTImages.dart';
import 'package:tiktok/utils/TTWidgets.dart';

import 'TTFanListScreen.dart';

class TTProfileScreen extends StatefulWidget {
  static String tag = '/TTProfileScreen';
  bool? isUser;

  TTProfileScreen({bool? isUser}) {
    this.isUser = isUser;
  }

  @override
  TTProfileScreenState createState() => TTProfileScreenState();
}

class TTProfileScreenState extends State<TTProfileScreen> {
  var isSelected = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(black);

    Widget mOption(var value, var label) {
      return Column(
        children: [
          Text(value, style: boldTextStyle(size: 18, color: white)),
          4.height,
          Text(label, style: secondaryTextStyle(color: white)),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        appBar: ttAppBar(context, "Lee Smith", showBack: false, actions: [
          PopupMenuButton(
            color: Colors.grey.shade200,
            icon: Icon(
              Icons.more_horiz,
              color: white,
            ),
            onSelected: (dynamic value) {
              if (value == "setting") {
                TTSettingScreen().launch(context);
              } else {
                TTEditProfileScreen().launch(context);
              }
            },
            itemBuilder: (context) {
              List<PopupMenuEntry<Object>> list = [];
              list.add(PopupMenuItem(child: Text("Settings", style: primaryTextStyle()), value: 'setting'));
              list.add(PopupMenuItem(child: Text("Edit Profile", style: primaryTextStyle()), value: 'profile'));
              return list;
            },
          )
        ]) as PreferredSizeWidget?,
        body: Responsive(
            mobile: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 320.0,
                  floating: true,
                  backgroundColor: black,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    indicatorColor: Colors.blueAccent,
                    tabs: [Tab(icon: Icon(Icons.grid_on, color: white)), Tab(icon: Icon(Icons.favorite_border, color: white))],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                      child: Column(
                        children: <Widget>[
                          8.height,
                          CircleAvatar(backgroundImage: AssetImage(TT_ic_guest8), radius: 35).center(),
                          10.height,
                          Text("@Lee_", style: boldTextStyle(size: 18, color: white)),
                          20.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              mOption("100", "Following").onTap(() {
                                TTFollowingListScreen().launch(context);
                              }),
                              mOption("1K", "Fans").onTap(() {
                                TTFanListScreen().launch(context);
                              }),
                              mOption("50K", "Like"),
                            ],
                          ),
                          20.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.isUser!
                                  ? Container(
                                      padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                                      decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
                                      child: Text("Message", style: primaryTextStyle(color: white)),
                                    )
                                  : MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          isSelected = !isSelected;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      color: isSelected ? Colors.grey : TTColorRed,
                                      child: Text(isSelected ? 'Following' : 'Follow', style: primaryTextStyle(color: white, size: 14)),
                                    ),
                              8.width,
                              widget.isUser! ? Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(border: Border.all(color: Colors.white24)), child: Icon(Icons.person_add_rounded, color: white)) : SizedBox(),
                              8.width,
                              widget.isUser! ? Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(border: Border.all(color: Colors.white24)), child: Icon(Icons.videocam_rounded, color: white)) : SizedBox()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [TTProfileComponent(), TTProfileComponent()],
            ),
          ),
        )),
      ),
    );
  }
}
