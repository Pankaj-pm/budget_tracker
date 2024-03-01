import 'package:budget_tracker/module/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController controller = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: controller.number,
                decoration: const InputDecoration(hintText: "number", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.pass,
                decoration: const InputDecoration(hintText: "Password", border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.login,
                      child: Text("Login"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.reg,
                      child: Text("Register"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
