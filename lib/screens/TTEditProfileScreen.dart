import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tiktok/utils/TTColors.dart';
import 'package:tiktok/utils/TTImages.dart';
import 'package:tiktok/utils/TTWidgets.dart';

class TTEditProfileScreen extends StatefulWidget {
  static String tag = '/TTEditProfileScreen';

  @override
  TTEditProfileScreenState createState() => TTEditProfileScreenState();
}

class TTEditProfileScreenState extends State<TTEditProfileScreen> {
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
    return Scaffold(
      appBar: ttAppBar(context, "Profile", actions: [
        Text(
          "Save",
          style: primaryTextStyle(color: TTColorRed),
        ).center().paddingOnly(left: 16, right: 16).onTap(() {
          toast("Save");
          finish(context);
        })
      ]) as PreferredSizeWidget?,
      backgroundColor: black,
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              CircleAvatar(backgroundImage: AssetImage(TT_ic_guest2), radius: 45).center(),
              10.height,
              Text('Add Photo', style: boldTextStyle(color: TTColorRed, size: 18)).center(),
              TextFormField(
                style: primaryTextStyle(size: 14, color: white),
                cursorColor: white,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: white,
                  ),
                  hintText: 'Name',
                  hintStyle: primaryTextStyle(
                    color: white,
                    size: 14,
                  ),
                  labelStyle: primaryTextStyle(color: white),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                ),
              ),
              20.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.add, color: white),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('@lee', style: boldTextStyle(color: white, size: 16)),
                      8.height,
                      Text("Username is your unique identify on tiktok. Once you change it. you don\'t be able to change again within 30 days", style: secondaryTextStyle(color: white)),
                      8.height,
                      Divider(color: Colors.white54)
                    ],
                  ).expand()
                ],
              ),
              4.height,
              TextFormField(
                style: primaryTextStyle(size: 12, color: white),
                cursorColor: white,
                maxLength: 80,
                maxLines: 3,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.edit,
                    color: white,
                  ),
                  hintText: 'No bio yet',
                  hintStyle: primaryTextStyle(
                    color: white,
                    size: 14,
                  ),
                  labelStyle: primaryTextStyle(color: white),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
