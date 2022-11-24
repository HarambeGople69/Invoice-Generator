import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/widgets/our_toast.dart';

import '../../controller/progress_indicator_controller.dart';

class CompanyFirestore {
  addCompanyDetail(
    String companyName,
    String phone,
    String email,
    String url,
    String address,
  ) async {
    print("Inside add company detail");
    try {
      await FirebaseFirestore.instance
          .collection("Company")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "email": email,
        "phone": phone,
        "name": companyName,
        "url": url,
        "address":address,
        "createdAt": Timestamp.now(),
      }).then((value) {
        // Get.find<ProgressIndicatorController>().changeValue(false);
       // OurToast().showSuccessToast("Added");
      });
    } catch (e) {
      Get.find<ProgressIndicatorController>().changeValue(false);
      print(e);
    }
  }
}
