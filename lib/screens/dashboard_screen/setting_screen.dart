import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:myapp/models/company_model.dart';
import 'package:myapp/services/authentication_service/authentication_service.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import '../../utils/colors.dart';
import '../../widgets/our_sized_box.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkLogoColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Setting",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(25),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(10),
            vertical: ScreenUtil().setSp(10),
          ),
          // child: Image.file(
          //   File(Hive.box<String>("filePath").get("filePath")!),
          // )
          // child: Text(
          //   Hive.box<String>("filePath").get("filePath")!,
          // ),
          child:
              //  Center(
              //   child: OurElevatedButton(
              //     title: "Logout",
              //     function: () async {
              //       await Auth().logout();
              //     },
              //   ),
              // ),
              // Image.file(File(Hive.box<String>("filePath").get("filePath")!)),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Company")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      CompanyModel userModel =
                          CompanyModel.fromMap(snapshot.data);
                      // if (snapshot.data!.docs.length>0) {
                      return Column(
                        children: [
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setSp(35),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: userModel.url,

                              // Image.network(
                              placeholder: (context, url) => Image.asset(
                                "assets/images/profile_holder.png",
                                width: double.infinity,
                                height: ScreenUtil().setSp(125),
                                fit: BoxFit.fitWidth,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/profile_holder.png",
                                width: double.infinity,
                                height: ScreenUtil().setSp(125),
                                fit: BoxFit.fitWidth,
                              ),
                              height: ScreenUtil().setSp(150),
                              width: ScreenUtil().setSp(150),
                              fit: BoxFit.cover,
                              //   )
                            ),
                            // Image.network(
                            //   userModel.url,
                            //   height: ScreenUtil().setSp(200),
                            //   width: ScreenUtil().setSp(200),
                            //   fit: BoxFit.contain,
                            // ),
                          ),
                          OurSizedBox(),
                          OurSizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Full name:",
                                  style: TextStyle(
                                    color: darkLogoColor,
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  userModel.name,
                                  style: TextStyle(
                                    color: darkLogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          OurSizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Phone no:",
                                  style: TextStyle(
                                    color: darkLogoColor,
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  userModel.phone,
                                  style: TextStyle(
                                    color: darkLogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          OurSizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Email:",
                                  style: TextStyle(
                                    color: darkLogoColor,
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  userModel.email,
                                  style: TextStyle(
                                    color: darkLogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          OurSizedBox(),
                          OurSizedBox(),
                          Center(
                            child: OurElevatedButton(
                              title: "Logout",
                              function: () async {
                                await Auth().logout();
                              },
                            ),
                          ),
                          Spacer(),
                        ],
                      );
                    } else {
                      return Text("");
                    }
                  }),
        ),
      ),
    );
  }
}
