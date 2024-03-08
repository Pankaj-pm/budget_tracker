import 'package:budget_tracker/module/add_budget/add_budget.dart';
import 'package:budget_tracker/module/add_budget/budget_model.dart';
import 'package:budget_tracker/module/database/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString name = "".obs;
  RxString searchText = "".obs;
  RxInt count = 0.obs;
  TextEditingController searchController=TextEditingController();
  TextEditingController searchController2=TextEditingController();
  PageController pageController = PageController();
  RxList<BudgetModel> budgetList=<BudgetModel>[].obs;
  RxList<BudgetModel> expBudgetList=<BudgetModel>[].obs;

  @override
  void onInit() {
    fetchBudgetData(true);
    fetchBudgetData(false);
    super.onInit();
  }

  void fetchBudgetData(bool isIncome,{String search=""}) async {
    DbHelper helper = DbHelper();
    var data = await helper.getBalance(income: isIncome,search: search);

    if(isIncome){
      budgetList.value=data?.map((e) {
        return BudgetModel.fromJson(e);
      }).toList()??[];
    }else{
      expBudgetList.value=data?.map((e) {
        return BudgetModel.fromJson(e);
      }).toList()??[];
    }
    print(data);
  }

  void gotoAddBudget() {
    Get.to(() => AddBudgetPage());
  }
}
