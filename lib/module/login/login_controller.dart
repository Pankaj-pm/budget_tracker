import 'package:budget_tracker/module/database/db_helper.dart';
import 'package:budget_tracker/module/database/user_model.dart';
import 'package:budget_tracker/module/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController number = TextEditingController();

  // TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    DbHelper helper = DbHelper();

    var userFound = await helper.getUser(number.text, pass.text);
    if (userFound?.isEmpty ?? false) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: "User Not found",
        ),
      );
    } else {
      Get.off(() => HomePage());
    }
  }

  Future reg() async {
    DbHelper helper = DbHelper();

    var userFound = await helper.getUser(number.text, pass.text);
    if (userFound?.isEmpty ?? false) {
      await helper.insertUserData(
          UserModel(number: number.text, password: pass.text, name: "", date: DateTime.now().toString()));
      Get.off(() => HomePage());
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: "Error",
        message: "User Already Exist",
      ));
    }
  }
}
