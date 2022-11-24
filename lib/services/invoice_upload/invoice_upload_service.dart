import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/progress_indicator_controller.dart';
import 'package:myapp/services/firestore_service/invoice_detail_service.dart';
import 'package:myapp/widgets/our_toast.dart';

class InvoiceUploadService {
  uploadInvoice(File invoiceFile) async {
    print("INSIDE UPLOAD INVOICE");
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    String fileName = invoiceFile.path.split("/").last;
    try {
      final uploadTask =
          await firebaseStorage.ref("$fileName").putFile(invoiceFile);

      if (uploadTask.state == TaskState.success) {
        String downloadUrl =
            await firebaseStorage.ref("$fileName").getDownloadURL();
        print("Utsav");
        print(fileName);
        print(downloadUrl);
        InvoiceDetailService().uploadInvoice(
          fileName,
          downloadUrl,
        );
        print("Shrestha");
      }
    } on FirebaseException catch (e) {
      OurToast().showErrorToast(e.message!);
      Get.find<ProgressIndicatorController>().changeValue(false);
    }
  }
}
