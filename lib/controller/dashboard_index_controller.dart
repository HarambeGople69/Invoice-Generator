import 'package:get/get.dart';

class DashboardIndexController extends GetxController{
  var index = 0.obs;
  void changeIndex(int value){
    index.value = value;
  }
}