import 'package:budget_tracker/module/add_budget/add_budget.dart';
import 'package:budget_tracker/module/add_budget/budget_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString name = "".obs;
  RxInt count = 0.obs;
  PageController pageController=PageController();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void gotoAddBudget() {
    Get.to(() => AddBudgetPage());
  }
}
