import 'package:budget_tracker/module/add_budget/budget_controller.dart';
import 'package:budget_tracker/module/add_budget/budget_model.dart';
import 'package:budget_tracker/module/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBudgetPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  BudgetController controller = Get.put(BudgetController());
  int i=0;

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
          GetBuilder(
            builder: (controller) {
              return Text("Hello ${controller.count}");
            },
            init: HomeController(),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return InkWell(
                onTap: () {
                  i++;
                  setState((){});
                },
                child: Text("Click $i"),
              );
            },
          ),
          ValueBuilder<bool?>(
            initialValue: false,
            builder: (value, updateFn) => Switch(
              value: value??false,
              onChanged: (value) {
                updateFn(value);
              }, // same signature! you could use ( newValue ) => updateFn( newValue )
            ),
            // if you need to call something outside the builder method.
            onUpdate: (value) => print("Value updated: $value"),
            onDispose: () => print("Widget unmounted"),
          ),
          ObxValue((value) => Switch(
            value: value.value,
            onChanged: (val) {
              value.value=val;
            }, // same signature! you could use ( newValue ) => updateFn( newValue )
          ), false.obs),
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
