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
              DbHelper helper = DbHelper();
              // helper.insertUserData(UserModel(
              //   name: "flutter",
              //   number: "569825330",
              //   date: DateTime.now().toString(),
              //   password: "123456",
              // ));
              // helper.deleteUserData(1);
              Get.to(AddBudgetPage());
            },
          ),
        );
      }),
    );
  }
}

class Incomes extends StatelessWidget {
  List list = [];

  Incomes({super.key});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Center(child: Text("No Data Found"));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Income"),
        );
      },
    );
  }
}

class Expanse extends StatelessWidget {
  const Expanse({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Expanse"),
        );
      },
    );
  }
}
