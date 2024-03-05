import 'package:budget_tracker/module/add_budget/budget_controller.dart';
import 'package:budget_tracker/module/add_budget/budget_model.dart';
import 'package:budget_tracker/module/home/home_controller.dart';
import 'package:budget_tracker/module/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddBudgetPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  BudgetController controller = Get.put(BudgetController());
  int i = 0;

  AddBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: controller.price,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          Obx(
            () => DropdownButton(
              value: controller.type.value,
              isExpanded: true,
              items: [
                DropdownMenuItem(child: Text("Income"), value: "Income"),
                DropdownMenuItem(
                  child: Text("Expanse"),
                  value: "Expanse",
                ),
              ],
              onChanged: (value) {
                controller.type.value = value ?? "";
                controller.initVal();
              },
            ),
          ),
          Obx(
            () {
              List<String> category=[];
              if(controller.type.value=="Income"){
                category=inCategory;
              }else{
                category=exCategory;
              }

              return DropdownButton(
              isExpanded: true,
              value: controller.category.value,
              hint: Text("Select Category"),
              items: category
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text(e)),
                  )
                  .toList(),
              onChanged: (value) {
                controller.category.value=value??"";
              },
            );
            },
          ),
          ElevatedButton(
              onPressed: controller.submit,
              child: const Text("Submit")),
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
                  setState(() {});
                },
                child: Text("Click $i"),
              );
            },
          ),
          ValueBuilder<bool?>(
            initialValue: false,
            builder: (value, updateFn) => Switch(
              value: value ?? false,
              onChanged: (value) {
                updateFn(value);
              }, // same signature! you could use ( newValue ) => updateFn( newValue )
            ),
            // if you need to call something outside the builder method.
            onUpdate: (value) => print("Value updated: $value"),
            onDispose: () => print("Widget unmounted"),
          ),
          ObxValue(
              (value) => Switch(
                    value: value.value,
                    onChanged: (val) {
                      value.value = val;
                    }, // same signature! you could use ( newValue ) => updateFn( newValue )
                  ),
              false.obs),
          Expanded(
              child: Obx(
            () => ListView.builder(
              itemCount: controller.bmList.length,
              itemBuilder: (context, index) {
                var bmList = controller.bmList[index];
                return Text("${bmList.type}  ${bmList.amount}");
              },
            ),
          ))
        ],
      ),
    );
  }
}
