import 'package:budget_tracker/module/add_budget/budget_controller.dart';
import 'package:budget_tracker/module/add_budget/budget_model.dart';
import 'package:budget_tracker/module/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBudgetPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  BudgetController controller = Get.put(BudgetController());

  AddBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: controller.price,
          ),
          ElevatedButton(
              onPressed: () {
                controller.bmList.add(BudgetModel(type: "Income", price: double.tryParse(controller.price.text)));
              },
              child: const Text("Income")),
          ElevatedButton(
              onPressed: () {
                controller.bmList.add(BudgetModel(type: "Expanse", price: double.tryParse(controller.price.text)));
              },
              child: const Text("Expanse")),
          Expanded(
              child: Obx(
            () => ListView.builder(
              itemCount: controller.bmList.length,
              itemBuilder: (context, index) {
                var bmList = controller.bmList[index];
                return Text("${bmList.type}  ${bmList.price}");
              },
            ),
          ))
        ],
      ),
    );
  }
}
