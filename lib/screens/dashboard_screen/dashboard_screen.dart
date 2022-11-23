import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:myapp/services/authentication_service/authentication_service.dart';
import 'package:myapp/widgets/our_elevated_button.dart';

import '../../db/db_helper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OurElevatedButton(
          title: "Logout",
          function: () async {
            Auth().logout();
          },
        ),
      ),
    );
  }
}
