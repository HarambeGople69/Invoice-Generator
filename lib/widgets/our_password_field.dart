import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/utils/colors.dart';

class PasswordForm extends StatefulWidget {
  bool see = true;
  final FocusNode? start;
  final FocusNode? end;
  final Function(String)? onchangeeed;
  final String title;
  final Function(String)? validator;
  final int number;

  final TextEditingController controller;

  PasswordForm(
    {
    Key? key,
   required this.onchangeeed,
    required this.controller,
    required this.title,
    required this.validator,
    this.start,
    this.end,
    required this.number,
  }) : super(key: key);

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setSp(15),
      ),
      height: ScreenUtil().setSp(40),
      child: TextFormField(
        cursorColor: darkLogoColor,
        focusNode: widget.start,
        onEditingComplete: () {
          if (widget.number == 0) {
            FocusScope.of(context).requestFocus(
              widget.end,
            );
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        onChanged:  (String? value) => widget.onchangeeed!(value!),
        validator: (String? value) => widget.validator!(value!),
        style: TextStyle(
          fontSize: ScreenUtil().setSp(15),
          color: darkLogoColor,
        ),
        controller: widget.controller,
        obscureText: widget.see,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: lightLogoColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: lightLogoColor,
            ),
          ),

          // focusedBorder: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setSp(10),
            horizontal: ScreenUtil().setSp(2),
          ),
          hintStyle: TextStyle(
            color: darkLogoColor,
            fontSize: ScreenUtil().setSp(
              17.5,
            ),
          ),

          isDense: true,
          prefixIcon: Icon(
            Icons.lock,
            color: darkLogoColor,
            size: ScreenUtil().setSp(20),
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                widget.see = !widget.see;
              });
            },
            child: widget.see
                ? Icon(
                    Icons.visibility_off,
                    color: darkLogoColor,
                    size: ScreenUtil().setSp(20),
                  )
                : (Icon(
                    Icons.visibility,
                    color: darkLogoColor,
                    size: ScreenUtil().setSp(20),
                  )),
          ),
          hintText: widget.title,

          errorStyle: TextStyle(
            fontSize: ScreenUtil().setSp(
              13.5,
            ),
          ),
        ),
      ),
    );
  }
}
