import 'package:budget_tracker/main.dart';
import 'package:budget_tracker/module/add_budget/budget_model.dart';
import 'package:budget_tracker/module/database/db_helper.dart';
import 'package:budget_tracker/module/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController {
  Rx<BudgetModel> bm = BudgetModel().obs;
  RxList<BudgetModel> bmList = <BudgetModel>[].obs;

  RxInt i = 0.obs;
  RxString s = "".obs;

  RxString type = "Income".obs;
  RxString category = "".obs;

  @override
  void onInit() {
    initVal();
    super.onInit();
  }

  void initVal() {
    if (type.value == "Income") {
      category.value = inCategory.first;
    } else {
      category.value = exCategory.first;
    }
  }

  void submit() async{
    DbHelper db = DbHelper();
    await db.insertBudget(
      BudgetModel(
        date: DateTime.now().toString(),
        type: type.value,
        amount: double.tryParse(price.text)??0,
        category: category.value,
        userId:userId.val,
      ),
    );
    price.clear();
  }

  TextEditingController price = TextEditingController();
}
