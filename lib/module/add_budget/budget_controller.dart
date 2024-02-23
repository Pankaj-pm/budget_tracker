import 'package:budget_tracker/module/add_budget/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController{
  Rx<BudgetModel> bm = BudgetModel().obs;
  RxList<BudgetModel> bmList = <BudgetModel>[].obs;

  RxInt i=0.obs;
  RxString s="".obs;


  TextEditingController price=TextEditingController();

}