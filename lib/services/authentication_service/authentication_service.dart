import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/models/company_model.dart';
import 'package:myapp/services/firestore_service/company_detail_service.dart';
import 'package:myapp/widgets/our_toast.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../controller/dashboard_index_controller.dart';
import '../../controller/progress_indicator_controller.dart';
import '../../db/db_helper.dart';
import '../../models/product_model.dart';
import '../addImages/profile_image..dart';

class Auth {
  createAccount(String companyName, String phone, String email, String password,
      File file, String address, BuildContext context) async {
    print("Inside create account screen");
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        String? url = await AddProfile().uploadImage(file);
        CompanyFirestore().addCompanyDetail(
          companyName,
          phone,
          email,
          url!,
          address,
        );
        var a = await FirebaseFirestore.instance
            .collection("Company")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        await Hive.box<double>(DatabaseHelper.priceDB).put("price", 0.0);

        CompanyModel companyModel = CompanyModel.fromMap(a);
        print(companyModel);
        Hive.box<CompanyModel>("companyDetails")
            .put("loggedUser", companyModel);
        var response = await http.get(
          Uri.parse(
            companyModel.url,
          ),
        );
        print("Hello World");
        var uniqueName = Uuid().v4();
        Directory? documentDirectory = await getExternalStorageDirectory();
        File filess = new File(
          join(
            documentDirectory!.path,
            'companyIcon$uniqueName.png',
          ),
        );
        print("+++++++++");
        print(filess.path);
        filess.writeAsBytes(response.bodyBytes);
        Hive.box<String>("filePath").put("filePath", filess.path);
        print("+++++++++");

        await Hive.box<int>(DatabaseHelper.authenticationDB).put("state", 1);
        Navigator.pop(context);
        OurToast().showSuccessToast("Welcome ${companyModel.name}");

        Get.find<ProgressIndicatorController>().changeValue(false);
      });
    } on FirebaseAuthException catch (e) {
      Get.find<ProgressIndicatorController>().changeValue(false);
      OurToast().showErrorToast(e.toString());
    }
  }

  loginAccound(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        var a = await FirebaseFirestore.instance
            .collection("Company")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        await Hive.box<double>(DatabaseHelper.priceDB).put("price", 0.0);

        CompanyModel companyModel = CompanyModel.fromMap(a);
        print("ABCD====");

        print(companyModel.toJson());
        print("ABCD====");
        Hive.box<CompanyModel>("companyDetails")
            .put("loggedUser", companyModel);
        var response = await http.get(
          Uri.parse(
            companyModel.url,
          ),
        );
        print("Utsav Shrestha");
        print(companyModel.url);
        print(response.body);
        var uniqueName = Uuid().v4();
        Directory? documentDirectory = await getExternalStorageDirectory();
        File filess = new File(
          join(
            documentDirectory!.path,
            'companyIcon$uniqueName.png',
          ),
        );
        print("+++++++++");
        print(filess.path);
        filess.writeAsBytes(response.bodyBytes);
        Hive.box<String>("filePath").put("filePath", filess.path);

        print("+++++++++");

        Get.find<ProgressIndicatorController>().changeValue(false);

        await Hive.box<int>(DatabaseHelper.authenticationDB).put("state", 1);

        OurToast().showSuccessToast("Welcome ${companyModel.name}");
      });
    } on FirebaseAuthException catch (e) {
      Get.find<ProgressIndicatorController>().changeValue(false);
      OurToast().showErrorToast(e.toString());
    }
  }

  logout() async {
    try {
      Hive.box<ProductModel>("productDetails").clear();
      await Hive.box<double>(DatabaseHelper.priceDB).put("price", 0.0);
      await Hive.box<int>(DatabaseHelper.authenticationDB).put("state", 0);
      Get.find<DashboardIndexController>().changeIndex(0);
      Hive.box<CompanyModel>("companyDetails").delete("companyDetails");
    } catch (e) {
      print(e);
    }
  }
}
