import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Budget Tracker")),
      body: Column(
        children: [
          Obx(
            () {
              return Text(
                "${controller.name.value} ${controller.count.value}",
                style: TextStyle(fontSize: 30),
              );
            },
          ),
          ElevatedButton(onPressed: () {
            controller.count.value++;
          }, child: Text("+")),
          ElevatedButton(onPressed: () {
            controller.count.value--;
          }, child: Text("-")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          controller.name.value = "Hey";

          // print(Theme.of(context).brightness==  Brightness.dark);
          // // Get.isDarkMode
          // if(Get.isDarkMode){
          //   Get.changeThemeMode(ThemeMode.light);
          // }else{
          //   Get.changeThemeMode(ThemeMode.dark);
          // }

          controller.gotoAddBudget();
        },
      ),
    );
  }
}
