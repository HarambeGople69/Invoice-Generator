import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:myapp/widgets/our_toast.dart';
import 'package:uuid/uuid.dart';
import '../../controller/progress_indicator_controller.dart';
import '../../db/db_helper.dart';
import '../../models/product_model.dart';

class InvoiceDetailService {
  uploadInvoice(String fileName, String downloadUrl) async {
    var uid = Uuid().v4();
    try {
      await FirebaseFirestore.instance
          .collection("Invoices")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("My_Invoices")
          .doc(uid)
          .set({
        "uid": uid,
        "downloadUrl": downloadUrl,
        "addedon": Timestamp.now(),
        "name": fileName,
      }).then((value) async {
        Hive.box<ProductModel>("productDetails").clear();
        await Hive.box<double>(DatabaseHelper.priceDB).put("price", 0.0);

        // await Hive.openBox<ProductModel>("productDetails");

        Get.find<ProgressIndicatorController>().changeValue(false);
        OurToast().showSuccessToast("Invoice saved");
      });
    } catch (e) {
      Get.find<ProgressIndicatorController>().changeValue(false);
      OurToast().showErrorToast(e.toString());
    }
  }
}
