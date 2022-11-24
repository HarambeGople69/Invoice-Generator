import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:myapp/services/network_connection/network_connection.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import '../../utils/colors.dart';
import '../outer_screen/outer_screen.dart';

class OurSplashScreen extends StatefulWidget {
  const OurSplashScreen({super.key});

  @override
  State<OurSplashScreen> createState() => _OurSplashScreenState();
}

class _OurSplashScreenState extends State<OurSplashScreen> {
  void completed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OuterLayerScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Container(
              height: 1,
              width: double.infinity,
            ),
            OurSizedBox(),
            Hero(
              tag: "splash-hero-tag",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setSp(45),
                ),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: ScreenUtil().setSp(225),
                  width: ScreenUtil().setSp(225),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            OurSizedBox(),
            OurSizedBox(),
            Text(
              "Invoice Generator",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(27.5),
                color: darkLogoColor,
                letterSpacing: 1.35,
                fontWeight: FontWeight.bold,
              ),
            ),
            OurSizedBox(),
            SpinKitDoubleBounce(
              size: ScreenUtil().setSp(35),
              duration: Duration(milliseconds: 1500),
              color: darkLogoColor,
              // itemBuilder: (BuildContext context, int index) {
              //   return DecoratedBox(
              //     decoration: BoxDecoration(
              //       color: index.isEven ? lightLogoColor : darkLogoColor,
              //     ),
              //   );
              // },
            ),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenUtil().setSp(40),
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(5),
          vertical: ScreenUtil().setSp(10),
        ),
        child: Center(
            child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: "Powered by ",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                  // style: paratext,
                  ),
              TextSpan(
                text: 'Harambe Gople Studio',
                style: TextStyle(
                  color: darkLogoColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(15),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
