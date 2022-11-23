import 'package:get/get.dart';

class ProgressIndicatorController extends GetxController{
  var index = false.obs;
  initialize(){
    index.value = false;
  }

  changeValue(bool data){
    index.value =  data;
  }
}