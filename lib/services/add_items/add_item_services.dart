import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:myapp/widgets/our_toast.dart';

import '../../db/db_helper.dart';
import '../../models/product_model.dart';

class ItemService {
  addItem(ProductModel productModel, BuildContext context) {
    double price = Hive.box<double>(DatabaseHelper.priceDB).get("price")!;
    // print(price);
    try {
      var box = Hive.box<ProductModel>("productDetails");
      box.add(productModel);
      Hive.box<double>(DatabaseHelper.priceDB)
          .put("price", price + productModel.cost * productModel.qty);
      OurToast().showSuccessToast("Item Added");
      Navigator.pop(context);
    } catch (e) {
      print("============");
      print(e);
      print("============");
    }
  }

  deleteItem(ProductModel productModel) {
    try {
      double price = Hive.box<double>(DatabaseHelper.priceDB).get("price")!;
      Hive.box<double>(DatabaseHelper.priceDB)
          .put("price", price - productModel.cost * productModel.qty);

      productModel.delete();
      OurToast().showErrorToast("Item deleted");
    } catch (e) {
      print("============");
      print(e);
      print("============");
    }
  }
}
