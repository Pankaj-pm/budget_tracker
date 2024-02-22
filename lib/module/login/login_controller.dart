import 'package:budget_tracker/module/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{


  TextEditingController name=TextEditingController();
  TextEditingController pass=TextEditingController();

  void gotoHome(){
    Get.off(()=>HomePage());
  }

}