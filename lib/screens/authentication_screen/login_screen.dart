import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/screens/authentication_screen/signup_screen.dart';
import 'package:myapp/services/authentication_service/authentication_service.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_text_field.dart';
import 'package:myapp/widgets/our_toast.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/progress_indicator_controller.dart';
import '../../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();

  final FocusNode _email_node = FocusNode();
  final FocusNode _password_node = FocusNode();
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setSp(25),
                      ),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: ScreenUtil().setSp(185),
                        width: ScreenUtil().setSp(185),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "Login to continue",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        color: darkLogoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    OurSizedBox(),
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
                      title: "Login",
                      function: () {
                        if (_email_controller.text.trim().isEmpty ||
                            _password_controller.text.trim().isEmpty) {
                          OurToast().showErrorToast("Fields can't be empty");
                        } else {
                          Get.find<ProgressIndicatorController>()
                              .changeValue(true);
                          Auth().loginAccound(_email_controller.text.trim(),
                              _password_controller.text.trim());
                        }
                      },
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                  "Don't have an account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: SignUpScreen(),
                        type: PageTransitionType.leftToRight,
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up ",
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
