import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/controller/progress_indicator_controller.dart';
import 'package:myapp/services/authentication_service/authentication_service.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_text_field.dart';
import 'package:myapp/widgets/our_toast.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String images = "";

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  Future<String> pickImages() async {
    String image = "";
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (files != null && files.files.isNotEmpty) {
        image = files.files[0].path!;
        // images.add(File(files.files[i].path!));
      } else {}
    } catch (e) {
      print(e);
      print("Error occured");
    }
    return image;
  }

  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _phone_controller = TextEditingController();
  final TextEditingController _company_name = TextEditingController();

  final FocusNode _email_node = FocusNode();
  final FocusNode _password_node = FocusNode();
  final FocusNode _phone_node = FocusNode();
  final FocusNode _company_node = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: Get.find<ProgressIndicatorController>().index.value,
        progressIndicator: SpinKitDoubleBounce(
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
        child: Scaffold(
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(5),
                vertical: ScreenUtil().setSp(5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Signup to continue",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        color: darkLogoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    OurSizedBox(),
                    images.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              selectImages();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setSp(5),
                              ),
                              child: DottedBorder(
                                color: Colors.black,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(
                                  ScreenUtil().setSp(15),
                                ),
                                dashPattern: [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  padding: EdgeInsets.all(
                                    ScreenUtil().setSp(20),
                                  ),
                                  width: double.infinity,
                                  height: ScreenUtil().setSp(140),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtil().setSp(15),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: ScreenUtil().setSp(35),
                                        color: darkLogoColor,
                                      ),
                                      OurSizedBox(),
                                      Text(
                                        "Select Company's logo",
                                        style: TextStyle(
                                          color: darkLogoColor,
                                          fontSize: ScreenUtil().setSp(
                                            17.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Image.file(
                            File(images),
                            height: ScreenUtil().setSp(250),
                            width: double.infinity,
                          ),
                    OurSizedBox(),
                    CustomTextField(
                      icon: Icons.email,
                      start: _company_node,
                      end: _phone_node,
                      controller: _company_name,
                      validator: (value) {},
                      title: "Company's Name",
                      type: TextInputType.name,
                      number: 0,
                    ),
                    OurSizedBox(),
                    CustomTextField(
                      icon: Icons.phone,
                      start: _phone_node,
                      end: _email_node,
                      controller: _phone_controller,
                      validator: (value) {},
                      title: "Phone",
                      type: TextInputType.number,
                      number: 0,
                    ),
                    OurSizedBox(),
                    CustomTextField(
                      icon: Icons.email,
                      start: _email_node,
                      end: _password_node,
                      controller: _email_controller,
                      validator: (value) {},
                      title: "Email",
                      type: TextInputType.emailAddress,
                      number: 0,
                    ),
                    OurSizedBox(),
                    PasswordForm(
                      start: _password_node,
                      onchangeeed: (value) {},
                      controller: _password_controller,
                      title: "Password",
                      validator: (value) {},
                      number: 1,
                    ),
                    OurSizedBox(),
                    OurElevatedButton(
                      title: "SIGN UP",
                      function: () {
                        if (_company_name.text.trim().isEmpty ||
                            _password_controller.text.trim().isEmpty ||
                            _email_controller.text.trim().isEmpty ||
                            _password_controller.text.trim().isEmpty) {
                          OurToast().showErrorToast("Fields can't be empty");
                        } else if (images.isEmpty) {
                          OurToast().showErrorToast("Please select image");
                        } else {
                          Get.find<ProgressIndicatorController>()
                              .changeValue(true);
                          Auth().createAccount(
                            _company_name.text.trim(),
                            _phone_controller.text.trim(),
                            _email_controller.text.trim(),
                            _password_controller.text.trim(),
                            File(images),
                            context,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            // color: Colors.white,
            height: ScreenUtil().setSp(35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Sign In ",
                    style: TextStyle(
                      color: darkLogoColor,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(17.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
