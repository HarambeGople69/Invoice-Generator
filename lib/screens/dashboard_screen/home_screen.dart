import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/services/add_items/add_item_services.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_text_field.dart';

import '../../db/db_helper.dart';
import '../../models/product_model.dart';
import '../../widgets/custom_tablerow.dart';
import '../../widgets/our_sized_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkLogoColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Invoice Generator",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(25),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(10),
            vertical: ScreenUtil().setSp(10),
          ),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable:
                    Hive.box<ProductModel>("productDetails").listenable(),
                builder: (context, Box<ProductModel> productList, child) {
                  // ignore: non_constant_identifier_names
                  List<int> Keys = productList.keys.cast<int>().toList();

                  return Keys.isNotEmpty
                      ? Column(
                          children: [
                            Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                  children: <Widget>[
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "Name",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "Item cost",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "Quantity",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "Actions",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ...Keys.map((itemx) => CustomTableRow(
                                      item: productList.get(itemx)!,
                                    )).toList(),
                              ],
                            ),
                            OurSizedBox(),
                            OurSizedBox(),
                            ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<double>(DatabaseHelper.priceDB)
                                      .listenable(),
                              builder: (context, Box<double> price, child) {
                                double value =
                                    price.get("price", defaultValue: 0.0)!;
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sub Total",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${value}",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(16.5),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "VAT 13%",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${13 / 100 * value}",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(16.5),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total:",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(17.5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${(13 / 100 * value) + value}",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(16.5),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              },
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
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
                                "No Item added",
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
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkLogoColor,
        onPressed: () {
          addPrductSheet(context);
        },
        child: Icon(
          Icons.add,
          size: ScreenUtil().setSp(30),
          color: Colors.white,
        ),
      ),
    );
  }

  void addPrductSheet(context) {
    final TextEditingController _name_controller = TextEditingController();
    final TextEditingController _cost_controller = TextEditingController();
    final TextEditingController _quantity_controller = TextEditingController();

    final FocusNode _name_node = FocusNode();
    final FocusNode _cost_node = FocusNode();
    final FocusNode _quantity_Node = FocusNode();

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color.fromARGB(255, 249, 221, 215),
            height: MediaQuery.of(context).size.height * 0.75,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(20),
              vertical: ScreenUtil().setSp(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Items",
                  style: TextStyle(
                    color: darkLogoColor,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(
                  color: darkLogoColor,
                ),
                const OurSizedBox(),
                CustomTextField(
                  start: _name_node,
                  end: _cost_node,
                  controller: _name_controller,
                  validator: (value) {},
                  title: "Item name",
                  type: TextInputType.name,
                  number: 0,
                ),
                OurSizedBox(),
                CustomTextField(
                  start: _cost_node,
                  end: _quantity_Node,
                  controller: _cost_controller,
                  validator: (value) {},
                  title: "Item cost",
                  type: TextInputType.number,
                  number: 0,
                ),
                OurSizedBox(),
                CustomTextField(
                  start: _quantity_Node,
                  controller: _quantity_controller,
                  validator: (value) {},
                  title: "Quantity",
                  type: TextInputType.number,
                  number: 1,
                ),
                OurSizedBox(),
                OurElevatedButton(
                  title: "Add",
                  function: () {
                    ProductModel productModel = ProductModel(
                      name: _name_controller.text.trim(),
                      cost: double.parse(_cost_controller.text.trim()),
                      qty: int.parse(
                        _quantity_controller.text.trim(),
                      ),
                    );
                    print(
                      productModel.toJson(),
                    );
                    ItemService().addItem(
                      productModel,
                      context,
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
