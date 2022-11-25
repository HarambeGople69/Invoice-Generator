import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/controller/history_switch_controller.dart';
import 'package:myapp/models/invoice_model.dart';
import 'package:myapp/screens/dashboard_screen/pdf_viewer_screen.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/colors.dart';
import '../../widgets/our_sized_box.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> imagePaths = [];
  Future<String> createFolder(String cow) async {
    final folderName = cow;
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.request();
    try {
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if (status.isPermanentlyDenied) {
        AppSettings.openAppSettings();
        print("=========================");
      }
      if ((await path.exists())) {
        Hive.box<int>("StoragePermission").put("given", 1);
        print("Folder exists");
        try {
          Directory dir = new Directory(path.path);
          List<FileSystemEntity> files = dir.listSync();
          files.forEach((element) {
            // print(element.path);
            imagePaths.add(element.path);
          }); // return files;
        } catch (e) {
          print(e);
        }
        return path.path;
      } else {
        path.create();
        print("Folder created");
        Hive.box<int>("StoragePermission").put("given", 1);
        try {
          Directory dir = new Directory(path.path);
          List<FileSystemEntity> files = dir.listSync();
          files.forEach((element) {
            // print(element.path);
            imagePaths.add(element.path);
          }); // return files;
        } catch (e) {
          print(e);
        }
        setState(() {});
        return path.path;
      }
    } catch (e) {
      print("Permission Error:");
      print(e);
      return "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createFolder("Invoice Generator");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkLogoColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "History",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(25),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(10),
          vertical: ScreenUtil().setSp(10),
        ),
        child: Column(
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.find<HistorySwitchController>().changeIndex(0);
                    },
                    child: Container(
                      height: ScreenUtil().setSp(45),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            Get.find<HistorySwitchController>().index.value == 0
                                ? darkLogoColor
                                : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "Server",
                          style: TextStyle(
                            color: Get.find<HistorySwitchController>()
                                        .index
                                        .value ==
                                    0
                                ? Colors.black
                                : darkLogoColor,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(17.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.find<HistorySwitchController>().changeIndex(1);
                    },
                    child: Container(
                      height: ScreenUtil().setSp(45),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            Get.find<HistorySwitchController>().index.value == 1
                                ? darkLogoColor
                                : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "Local",
                          style: TextStyle(
                            color: Get.find<HistorySwitchController>()
                                        .index
                                        .value ==
                                    1
                                ? Colors.black
                                : darkLogoColor,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(17.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            OurSizedBox(),
            Obx(() => Container(
                  child: Get.find<HistorySwitchController>().index.value == 0
                      ? Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Invoices")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("My_Invoices")
                                .orderBy(
                                  "addedon",
                                  descending: true,
                                )
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.length > 0) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        InvoiceModel invoiceModel =
                                            InvoiceModel.fromMap(
                                                snapshot.data!.docs[index]);
                                        return InkWell(
                                          onTap: () {
                                            // print("Button Pressed");
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                child: PDFviewerScreen(
                                                  value: true,
                                                  url: invoiceModel.downloadUrl,
                                                  file: File("ad"),
                                                ),
                                                type: PageTransitionType
                                                    .leftToRight,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: ScreenUtil().setSp(7.5),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.picture_as_pdf,
                                                  color: darkLogoColor,
                                                  size: ScreenUtil().setSp(35),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setSp(25),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      invoiceModel.name,
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(17.5),
                                                        color: darkLogoColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      invoiceModel.timestamp
                                                          .toDate()
                                                          .toString()
                                                          .split(".")[0],
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(13.5),
                                                        color: darkLogoColor,
                                                      ),
                                                    ),
                                                    //        userModel.createdAt
                                                    // .toDate()
                                                    // .toString()
                                                    // .split(".")[0],
                                                  ],
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                      ),
                                      ClipRRect(
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
                                      OurSizedBox(),
                                      Center(
                                        child: Text(
                                          "No History",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(
                                              22.5,
                                            ),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      // Spacer(),
                                    ],
                                  );
                                }
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitDoubleBounce(
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
                                );
                              } else {
                                return SpinKitDoubleBounce(
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
                                );
                              }
                            },
                          ),
                        )
                      : ValueListenableBuilder(
                          valueListenable:
                              Hive.box<int>("StoragePermission").listenable(),
                          builder: (context, Box<int> boxs, child) {
                            int value = boxs.get("given", defaultValue: 0)!;
                            print("===========");
                            print(value);
                            print("===========");
                            return value == 0
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                      ),
                                      ClipRRect(
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
                                      OurSizedBox(),

                                      Center(
                                        child: OurElevatedButton(
                                            title: "Give Storage Permission",
                                            function: () async {
                                              String value = await createFolder(
                                                  "Invoice Generator");
                                              print("Utsav");
                                              print(value);
                                              try {
                                                Directory dir =
                                                    new Directory(value);
                                                List<FileSystemEntity> files =
                                                    dir.listSync();
                                                files.forEach((element) {
                                                  print(element.path);
                                                }); // return files;
                                              } catch (e) {
                                                print(e);
                                              }
                                              print("Shrestha");
                                            }
                                            // },
                                            ),
                                      )
                                      // Spacer(),
                                    ],
                                  )
                                : Center(
                                    child:
                                        //    OurElevatedButton(
                                        //       title: "Give Storage Permission",
                                        //       function: () async {
                                        //         String value = await createFolder(
                                        //             "Invoice Generator");
                                        //         print("Utsav");
                                        //         print(value);
                                        //         try {
                                        //           Directory dir =
                                        //               new Directory(value);
                                        //           List<FileSystemEntity> files =
                                        //               dir.listSync();
                                        //           files.forEach((element) {
                                        //             print(element.path);
                                        //           }); // return files;
                                        //         } catch (e) {
                                        //           print(e);
                                        //         }
                                        //         print("Shrestha");
                                        //       }
                                        //       // },
                                        //       ),
                                        // );
                                        imagePaths.length == 0
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      ScreenUtil().setSp(45),
                                                    ),
                                                    child: Image.asset(
                                                      "assets/images/logo.png",
                                                      height: ScreenUtil()
                                                          .setSp(225),
                                                      width: ScreenUtil()
                                                          .setSp(225),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  OurSizedBox(),
                                                  Center(
                                                    child: Text(
                                                      "No History",
                                                      style: TextStyle(
                                                        fontSize:
                                                            ScreenUtil().setSp(
                                                          22.5,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                ],
                                              )
                                            : ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: imagePaths.length,
                                                itemBuilder: (context, index) {
                                                  // return Text(
                                                  // imagePaths[index]
                                                  //     .split("/")
                                                  //     .last,
                                                  // );
                                                  return InkWell(
                                                    onTap: () {
                                                      // print("Button Pressed");
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          child:
                                                              PDFviewerScreen(
                                                            value: false,
                                                            url: "",
                                                            file: File(
                                                              imagePaths[index],
                                                            ),
                                                          ),
                                                          type:
                                                              PageTransitionType
                                                                  .leftToRight,
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        vertical: ScreenUtil()
                                                            .setSp(7.5),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .picture_as_pdf,
                                                            color:
                                                                darkLogoColor,
                                                            size: ScreenUtil()
                                                                .setSp(35),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil()
                                                                .setSp(25),
                                                          ),
                                                          Text(
                                                            imagePaths[index]
                                                                .split("/")
                                                                .last,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          17.5),
                                                              color:
                                                                  darkLogoColor,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }));
                          },
                        ),
                  // Center(
                  //     child: OurElevatedButton(
                  //         title: "Locally",
                  //         function: () async {
                  //           String value =
                  //               await createFolder("Invoice Generator");
                  //           print("Utsav");
                  //           print(value);
                  //           try {
                  //             Directory dir = new Directory(value);
                  //             List<FileSystemEntity> files = dir.listSync();
                  //             files.forEach((element) {
                  //               print(element.path);
                  //             }); // return files;
                  //           } catch (e) {
                  //             print(e);
                  //           }
                  //           print("Shrestha");
                  //         }
                  //         // },
                  //         ),
                  //   ),
                ))
          ],
        ),
      ),
    );
  }
}
