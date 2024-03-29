import 'dart:io';

import 'package:budget_tracker/module/add_budget/budget_model.dart';
import 'package:budget_tracker/module/database/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static final DbHelper _obj=DbHelper._helper();

  DbHelper._helper();
  final dbName="budget_new.db";

  factory DbHelper(){
    return _obj;
  }

  static DbHelper get instance=>_obj;

  final String userTableName="user";
  final String balanceTableName="balance";

  Database? database;

  Future initDb()async {
    database= await openDatabase(
      dbName,
      version: 1,
      onCreate: (db, version) async{
        await db.execute(
          'CREATE TABLE $userTableName (id INTEGER NOT NULL,name TEXT NOT NULL,number	TEXT NOT NULL UNIQUE,date TEXT NOT NULL,password TEXT NOT NULL,PRIMARY KEY(id AUTOINCREMENT))',
        );

        await db.execute(
          '''CREATE TABLE $balanceTableName ("id"	INTEGER NOT NULL,"type"	TEXT NOT NULL,"amount"	NUMERIC NOT NULL DEFAULT 0,"date"	TEXT NOT NULL,"note"	TEXT,"user_id" INTEGER NOT NULL,"category" TEXT NOT NULL,PRIMARY KEY("id" AUTOINCREMENT))''',
        );
      },
      singleInstance: true,
    );
  }

  Future insertUserData(UserModel userModel) async{
    var database = await openDatabase(dbName);

    database.insert("user", userModel.toJson());
    // await database.execute('INSERT INTO "user"("name","number","date","password") VALUES ("abc","8869964","${DateTime.now()}","123456")');
    database.close();
  }

  Future insertBudget(BudgetModel budgetModel) async{
    var database = await openDatabase(dbName);

    database.insert("balance", budgetModel.toJson());
    // await database.execute('INSERT INTO "user"("name","number","date","password") VALUES ("abc","8869964","${DateTime.now()}","123456")');
    database.close();
  }

  Future updateBudget(BudgetModel budgetModel) async{
    var database = await openDatabase(dbName);

    database.update("balance", budgetModel.toJson(),where: "id = ?",whereArgs: [budgetModel.id]);

    database.close();
  }

  Future deleteUserData(int id) async{
    var database = await openDatabase(dbName);

    database.delete("user", where: "id = ?",whereArgs: [id]);
    // await database.execute('DELETE FROM "user" WHERE id = $id');
    database.close();
  }

  Future<List<Map<String,Object?>>?> getUser(String number,String pass) async{
    var database = await openDatabase(dbName);
    return await database.rawQuery("select * from $userTableName where number = $number and password = $pass");
  }

  Future<List<Map<String,Object?>>?> getBalance({bool income=false,String search=""}) async{
    var database = await openDatabase(dbName);
    var type=income?'Income':'Expanse';

    if(search.isEmpty){
      return await database.rawQuery("select * from $balanceTableName where type='$type'");
    }else{
      return await database.rawQuery("select * from $balanceTableName where type='$type' and category like '%$search%'");
    }

  }
}