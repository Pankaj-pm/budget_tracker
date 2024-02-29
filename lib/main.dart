import 'package:budget_tracker/module/database/db_helper.dart';
import 'package:budget_tracker/module/home/home_screen.dart';
import 'package:budget_tracker/module/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*CREATE TABLE "balance" (
	"id"	INTEGER NOT NULL,
	"type"	TEXT NOT NULL,
	"amount"	NUMERIC NOT NULL DEFAULT 0,
	"date"	TEXT NOT NULL,
	"note"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);*/

//INSERT INTO "user"("name","number","username","password") VALUES ("abc","8869964","abc","123456");
//UPDATE "user" SET "number"="123","name"="dipak" WHERE id = 1
//DELETE FROM "user" WHERE username = "abc"

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper().initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
    );
  }
}
