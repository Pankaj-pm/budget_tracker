import 'package:budget_tracker/module/add_budget/add_budget.dart';
import 'package:budget_tracker/module/database/db_helper.dart';
import 'package:budget_tracker/module/database/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Budget Tracker"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Income"),
                Tab(text: "Expanse"),
              ],
              onTap: (value) {
                controller.pageController.animateToPage(
                  value,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
          body: PageView(
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Incomes(),
              Expanse(),
            ],
            onPageChanged: (value) {
              // DefaultTabController.of(context).index=value;
              DefaultTabController.of(context).animateTo(value);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // DbHelper helper = DbHelper();
              // helper.insertUserData(UserModel(
              //   name: "flutter",
              //   number: "569825330",
              //   date: DateTime.now().toString(),
              //   password: "123456",
              // ));
              // helper.deleteUserData(1);
              await Get.to(()=>AddBudgetPage());
              controller.fetchBudgetData(true);
              controller.fetchBudgetData(false);
            },
          ),
        );
      }),
    );
  }
}

class Incomes extends StatelessWidget {
  List list = [];

  var homeController = Get.find<HomeController>();

  Incomes({super.key});

  @override
  Widget build(BuildContext context) {
    // if (list.isEmpty) {
    //   return Center(child: Text("No Data Found"));
    // }
    return Column(
      children: [
        TextFormField(
          controller: homeController.searchController,
          onChanged: (value) {
            homeController.searchText.value = value;
            homeController.fetchBudgetData(true,search: value);
            print("val $value");
          },
          decoration: InputDecoration(
            suffixIcon: Obx(
              () {
                if (homeController.searchText.value.isEmpty) {
                  return SizedBox.shrink();
                }
                return IconButton(
                  onPressed: () {
                    homeController.searchText.value = "";
                    homeController.searchController.clear();
                    homeController.fetchBudgetData(true);
                  },
                  icon: Icon(Icons.clear),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              homeController.fetchBudgetData(true);
            },
            child: Obx(
              () => ListView.builder(
                itemCount: homeController.budgetList.length,
                itemBuilder: (context, index) {
                  var budget = homeController.budgetList[index];
                  return ListTile(
                    title: Text(budget.category ?? ""),
                    trailing: Text("${budget.amount}"),
                    onTap: () async{
                      await Get.to(()=>AddBudgetPage(),arguments: budget);
                      homeController.fetchBudgetData(true,search: homeController.searchController.text);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Expanse extends StatelessWidget {
  List list = [];

  var homeController = Get.find<HomeController>();

  Expanse({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        homeController.fetchBudgetData(false);
      },
      child: Obx(
        () => ListView.builder(
          itemCount: homeController.expBudgetList.length,
          itemBuilder: (context, index) {
            var budget = homeController.expBudgetList[index];
            return ListTile(
              title: Text(budget.category ?? ""),
              onTap: () async{
                await Get.to(()=>AddBudgetPage(),arguments: budget);
                homeController.fetchBudgetData(false);
              },
              trailing: Text("${budget.amount}"),
            );
          },
        ),
      ),
    );
  }
}
