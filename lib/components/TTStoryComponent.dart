import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tiktok/model/TTModel.dart';
import 'package:tiktok/screens/TTProfileScreen.dart';
import 'package:tiktok/screens/TTSoundScreen.dart';
import 'package:tiktok/utils/TTColors.dart';
import 'package:tiktok/utils/TTWidgets.dart';
import 'package:video_player/video_player.dart';

class TTStoryComponent extends StatefulWidget {
  static String tag = '/TTStoryComponent';

  @override
  TTStoryComponentState createState() => TTStoryComponentState();

  TTStoryModel? model;

  TTStoryComponent({TTStoryModel? model, int? pos}) {
    this.model = model;
  }
}

class TTStoryComponentState extends State<TTStoryComponent> with SingleTickerProviderStateMixin {
  bool play = true;
  late VideoPlayerController _controller;
  late AnimationController animationController;
  PageController pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  PageController mController = new PageController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 5));
    animationController.repeat();
    _controller = VideoPlayerController.network(widget.model!.videoPath)
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    print("dispose");
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget _bottomContent() {
      return Container(
        alignment: Alignment.topLeft,
        width: context.width() - 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(widget.model!.name, style: primaryTextStyle(color: white)),
            8.height,
            Text(widget.model!.message + " " + widget.model!.tag, style: primaryTextStyle(color: white)),
            8.height,
            Container(
              width: context.width() - 60,
              child: Row(
                children: <Widget>[
                  Icon(Icons.music_note, color: white),
                  Container(
                    height: 20,
                    width: 80,
                    child: Marquee(
                      textDirection: TextDirection.ltr,
                      child: Text('Original Sound' + " " + widget.model!.sound, style: primaryTextStyle(color: white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).paddingOnly(left: 16, bottom: 16),
      );
    }

    Widget _rightContent() {
      return Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) _controller.pause();
                TTProfileScreen(isUser: false).launch(context);
              },
              child: Container(
                width: 45,
                height: 50,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: black, border: Border.all(color: white, width: 1)),
                      child: CircleAvatar(radius: 20, backgroundColor: black, backgroundImage: AssetImage(widget.model!.profile)),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: TTColorRed, border: Border.all(color: TTColorRed, width: 1)), child: Center(child: Icon(Icons.add, size: 16, color: white))),
                    )
                  ],
                ),
              ),
            ),
            16.height,
            IconButton(
                icon: Icon(Icons.favorite, size: 35, color: widget.model!.isFavourite ? TTColorRed : white),
                onPressed: () {
                  setState(() {
                    widget.model!.isFavourite = !widget.model!.isFavourite;
                  });
                }),
            Text(widget.model!.like, style: primaryTextStyle(color: white)),
            10.height,
            Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.reply, size: 35, color: white)).onTap(() {
              setState(() {
                onShareTap(context);
              });
            }),
            Text(widget.model!.share, style: primaryTextStyle(color: white)),
            10.height,
            AnimatedBuilder(
              animation: animationController,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: black),
                width: 45,
                height: 45,
                padding: EdgeInsets.all(8),
                child: CircleAvatar(radius: 16, backgroundImage: AssetImage(widget.model!.musicImg)),
              ).onTap(() {
                if (_controller.value.isPlaying) _controller.pause();
                TTSoundScreen().launch(context);
              }),
              builder: (context, _widget) {
                return Transform.rotate(angle: animationController.value * 6.3, child: _widget);
              },
            )
          ],
        ).paddingOnly(right: 10, bottom: 10),
      );
    }

    Widget mBody() {
      return Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                setState(() {
                  if (play) {
                    _controller.pause();
                    play = !play;
                  } else {
                    _controller.play();
                    play = !play;
                  }
                });
              },
              child: Container(
                width: context.width(),
                height: context.height(),
                child: VideoPlayer(_controller),
              )),
          _rightContent(),
          _bottomContent(),
        ],
      );
    }

    return mBody();
  }
}
