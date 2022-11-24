import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:myapp/screens/dashboard_screen/history_screen.dart';
import 'package:myapp/screens/dashboard_screen/home_screen.dart';
import 'package:myapp/screens/dashboard_screen/setting_screen.dart';
import 'package:myapp/services/authentication_service/authentication_service.dart';
import 'package:myapp/widgets/our_elevated_button.dart';

import '../../controller/dashboard_index_controller.dart';
import '../../db/db_helper.dart';
import '../../services/network_connection/network_connection.dart';
import '../../utils/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<CheckConnectivity>().initialize();
  }

  var widgetList = <Widget>[
    HomeScreen(),
    HistoryScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx((() => GestureDetector(
          onHorizontalDragEnd: (dragDetail) {
            if (dragDetail.velocity.pixelsPerSecond.dx < 1) {
              if (Get.find<DashboardIndexController>().index.value < 2) {
                print(Get.find<DashboardIndexController>().index.value);
                print("Right swipe");
                Get.find<DashboardIndexController>().changeIndex(
                    Get.find<DashboardIndexController>().index.value + 1);
              }
            } else {
              if (Get.find<DashboardIndexController>().index.value > 0) {
                print(Get.find<DashboardIndexController>().index.value);
                print("Left swipe");
                Get.find<DashboardIndexController>().changeIndex(
                    Get.find<DashboardIndexController>().index.value - 1);
              }
            }
          },
          child: Scaffold(
            body: widgetList[Get.find<DashboardIndexController>().index.value],
            // Center(
            //   child: OurElevatedButton(title: "Logout", function: (){
            //     Auth().logout();
            //   }),
            // ),
            bottomNavigationBar: SnakeNavigationBar.color(
              height: ScreenUtil().setSp(50),
              behaviour: SnakeBarBehaviour.floating,
              snakeShape: SnakeShape.circle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    ScreenUtil().setSp(20),
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(20),
                vertical: ScreenUtil().setSp(10),
              ),
              snakeViewColor: lightLogoColor.withOpacity(0.3),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.blueGrey,
              showUnselectedLabels: false,
              showSelectedLabels: true,
              currentIndex: Get.find<DashboardIndexController>().index.value,
              onTap: (index) {
                Get.find<DashboardIndexController>().changeIndex(index);
                // Get.find<DashboardController>().changeIndexs(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: darkLogoColor,
                    size: ScreenUtil().setSp(22.5),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    // MdiIcons.decimalIncrease,
                    color: darkLogoColor,
                    size: ScreenUtil().setSp(22.5),
                  ),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: darkLogoColor,
                      size: ScreenUtil().setSp(22.5),
                    ),
                    label: 'Profile')
              ],
              selectedLabelStyle: const TextStyle(fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
            ),
          ),
        )));
  }
}
