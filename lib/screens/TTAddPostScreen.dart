import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktok/screens/TTDashboardScreen.dart';
import 'package:tiktok/utils/TTColors.dart';
import 'package:tiktok/utils/TTImages.dart';
import 'package:tiktok/utils/TTStepProgressIndicator.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import 'TTPickSongScreen.dart';

class TTAddPostScreen extends StatefulWidget {
  static String tag = '/TTAddPostScreen';

  @override
  TTAddPostScreenState createState() => TTAddPostScreenState();
}

class TTAddPostScreenState extends State<TTAddPostScreen> {
  CameraController? controller;
  String? imagePath;
  late String videoPath;
  VideoPlayerController? videoController;
  late VoidCallback videoPlayerListener;
  bool enableAudio = true;
  bool isEffect = true;
  var mSong;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    initializeCamera(getCameDesc());
  }

  void initializeCamera(CameraDescription backCam) async {
    if (controller != null) {
      await controller?.dispose();
    }

    controller = CameraController(backCam, ResolutionPreset.medium);

    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  CameraDescription getCameDesc() {
    if (controller == null) {
      return cameras.firstWhere((element) => element.lensDirection.index == 1);
    }

    if (controller!.description.lensDirection.index == 0) {
      return cameras.firstWhere((element) => element.lensDirection.index == 1);
    } else {
      return cameras.firstWhere((element) => element.lensDirection.index == 0);
    }
  }

  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;

  String elapsedTime = '';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: _cameraPreviewWidget(),
          ),
          Container(alignment: Alignment.bottomCenter, child: _captureControlRowWidget()),
          _topContent(),
          _rightContent()
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    } else {
      return Transform.scale(
        scale: controller!.value.aspectRatio / deviceRatio,
        child: new AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: new CameraPreview(controller!),
        ),
      );
    }
  }

  Widget _topContent() {
    return SafeArea(
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(top: 10, left: 16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.close, color: white).onTap(() {
                  TTDashboardScreen().launch(context);
                }),
                16.width,
                TTStepProgressIndicator(totalSteps: 10, currentStep: 2, selectedColor: TTColorRed, unselectedColor: Colors.grey).expand(),
                16.width
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.music_note_outlined,
                  color: mSong == null ? white : Colors.yellow,
                  size: 16,
                ),
                8.width,
                Text(mSong == null ? 'Pick a Song' : mSong, textAlign: TextAlign.center, style: primaryTextStyle(color: mSong == null ? white : Colors.yellow))
              ],
            ).onTap(() {
              _navigateAndDisplaySelection(context);
            }),
          ],
        ),
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TTPickSongScreen()),
    );

    setState(() {
      mSong = result;
    });
  }

  Widget _rightContent() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 100, right: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(TT_ic_flash, width: 30, height: 30, color: Colors.grey),
          20.height,
          Image.asset(TT_ic_effect, width: 30, height: 30, color: isEffect ? white : Colors.yellow).onTap(() {
            setState(() {
              isEffect = !isEffect;
            });
          }),
          20.height,
          Image.asset(TT_ic_color, width: 30, height: 30, color: white).onTap(() {
            toast("Color Filter");
          }),
          20.height,
          Icon(Icons.timer, size: 35, color: white).onTap(() {
            _allowSheet(context);
          }),
          20.height,
          Image.asset(TT_ic_mask, width: 30, height: 30, color: white).onTap(() {
            toast("Effect");
          }),
          20.height,
          Image.asset(TT_ic_rotate_image, width: 30, height: 30, color: white).onTap(() async {
            initializeCamera(getCameDesc());
          }),
          20.height,
        ],
      ).paddingOnly(right: 10, bottom: 10),
    );
  }

  _allowSheet(BuildContext aContext) {
    RangeValues _currentRangeValues = const RangeValues(0, 20.9);

    showModalBottomSheet(
        context: aContext,
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Text("Drag to set stop point", style: secondaryTextStyle(color: white)),
                16.height,
                RangeSlider(
                  values: _currentRangeValues,
                  min: 0,
                  max: 100,
                  activeColor: TTColorSerpent,
                  divisions: 5,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
                20.height,
                Container(
                        width: context.width(),
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.only(top: 6, bottom: 6),
                        decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: TTColorRed),
                        child: Text('Set Countdown Timer', textAlign: TextAlign.center, style: primaryTextStyle(color: white)))
                    .onTap(() {
                  finish(context);
                })
              ],
            ),
          );
        });
  }

  Widget _captureControlRowWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(elapsedTime, style: primaryTextStyle(size: 16, color: white)),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            20.width,
            GestureDetector(
              onTap: () {
                if (controller != null && controller!.value.isInitialized && !controller!.value.isRecordingVideo) {
                  startVideoRecording().then((String? filePath) {
                    if (mounted) setState(() {});
                  });
                  startWatch();
                }
              },
              child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: white, border: Border.all(color: white, width: 1)), child: CircleAvatar(backgroundColor: TTColorRed, radius: 25)),
            ),
            20.width,
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: white, border: Border.all(color: TTColorRed, width: 1)),
              child: IconButton(
                icon: const Icon(Icons.stop),
                color: TTColorRed,
                onPressed: () {
                  if (controller != null && controller!.value.isInitialized && controller!.value.isRecordingVideo) {
                    stopVideoRecording().then((_) {
                      if (mounted) setState(() {});
                    });
                    stopWatch();
                  }
                },
              ),
            )
          ],
        ).paddingOnly(bottom: 20),
      ],
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void logError(String code, String? message) => print('Error: $code\nError Message: $message');

  Future<String?> startVideoRecording() async {
    if (!controller!.value.isInitialized) {
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      videoPath = filePath;
      await controller!.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
  }

  Future<void> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller!.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    await _startVideoPlayer();
  }

  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vcontroller = VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoController != null && videoController!.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController!.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        imagePath = null;
        videoController = vcontroller;
      });
    }
    await vcontroller.play();
  }
}
