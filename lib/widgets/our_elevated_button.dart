import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/utils/colors.dart';

class OurElevatedButton extends StatefulWidget {
  final String title;
  final Function function;
  const OurElevatedButton(
      {Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  State<OurElevatedButton> createState() => _OurElevatedButtonState();
}

class _OurElevatedButtonState extends State<OurElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setSp(37.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ScreenUtil().setSp(
            12,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            lightLogoColor,
            lightLogoColor,
          ],
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(10),
              vertical: ScreenUtil().setSp(5),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            Colors.transparent,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(
                  12,
                ),
              ),
            ),
          ),
        ),
        onPressed: () {
          widget.function();
        },
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            letterSpacing: 1.25,
          ),
        ),
      ),
    );
  }
}
