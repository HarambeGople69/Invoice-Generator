// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/models/product_model.dart';
import 'package:myapp/services/add_items/add_item_services.dart';

TableRow CustomTableRow({required ProductModel item}) {
  return TableRow(
    children: <Widget>[
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(
            item.name,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w400,
            ),
          ),
          // CustomText(
          //   text: (item != null) ? item.name : "null",
          //   fontSize: 13,
          // ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Text(
              "${item.cost}",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w400,
              ),
            )
            //  CustomText(
            //   text: (item != null) ? "\$${item.price.toStringAsFixed(2)}" : "-",
            //   fontSize: 13,
            // ),
            ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(
            item.qty.toString(),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w400,
            ),
          ),
          // CustomText(
          //   text: (item != null) ? "${item.qty}" : "-",
          //   fontSize: 13,
          // ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     color: AppColors.kPrimaryColor,
              //   ),
              //   alignment: Alignment.center,
              //   height: 30,
              //   width: 30,
              //   child: IconButton(
              //     splashRadius: 18,
              //     padding: const EdgeInsets.all(0),
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.edit_sharp,
              //       color: AppColors.kSecondaryColor,
              //     ),
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                height: 30,
                width: 30,
                child: IconButton(
                  splashRadius: 18,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    ItemService().deleteItem(item);
                    // (item != null)
                    //     ? controller.remove_item(item: item)
                    //     : print("null");
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: ScreenUtil().setSp(25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
