import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tiktok/screens/TTOTPScreen.dart';
import 'package:tiktok/utils/TTColors.dart';

class TTSignINScreen extends StatefulWidget {
  static String tag = '/TTSignINScreen';

  @override
  TTSignINScreenState createState() => TTSignINScreenState();
}

class TTSignINScreenState extends State<TTSignINScreen> {
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
      backgroundColor: black,
      body: Responsive(
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your mobile number', style: boldTextStyle(color: white, size: 18)),
            16.height,
            Container(
                decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: black, border: Border.all(color: Colors.white24, width: 1)),
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    CountryCodePicker(onChanged: print, padding: EdgeInsets.all(0), textStyle: primaryTextStyle(color: white)),
                    Container(height: 30.0, width: 1.0, color: Colors.white24, margin: const EdgeInsets.only(left: 10.0, right: 10.0)),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        style: primaryTextStyle(),
                        decoration: InputDecoration(
                            counterText: "", contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0), hintText: "Mobile number", hintStyle: primaryTextStyle(color: white), labelStyle: primaryTextStyle(color: white), border: InputBorder.none),
                      ),
                    )
                  ],
                )),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: MaterialButton(
                  onPressed: () {
                    TTOtpScreen().launch(context);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  color: TTColorRed,
                  child: Text('Send OTP', style: primaryTextStyle(color: white))),
            ),
          ],
        ).center(),
      ),
    );
  }
}
