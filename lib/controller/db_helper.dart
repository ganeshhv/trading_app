import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trading_app/models/order_model.dart';
import 'package:trading_app/models/user_model.dart';

class DbHelper
{
  static Database _db;
  static final int version = 1;
  static final String tableNameUser = 'users';
  static final String tableNameOrder = 'orders';
  static final String databaseName = 'market.db';
  // user
  static final String ID1 = 'id';
  static final String USER_ID = 'userId';
  static final String USER_NAME = 'name';
  static final String EMAIL = 'email';
  static final String ADDRESS = 'address';
  static final String PHONE_NO = 'phone';
  static final String TS1 = 'ts';

  // orders
  static final String ID2 = 'id';
  static final String NAME = 'name';
  static final String PRICE = 'price';
  static final String QUANTITY = 'quantity';
  static final String ORDER_TYPE = 'order_type';
  static final String EXCHANGE = 'exchange';
  static final String TS2 = 'order_ts';

  Future<Database> initDb() async{
    String path = await getDatabasesPath();
    print(await getDatabasesPath());
    print(await databaseExists(path));
    print('db path :${path}/${databaseName}');
    return openDatabase(
        '${path}/${databaseName}',
      version: version,
      onCreate: (db, version) async
        {
          await db.execute(
            "CREATE TABLE $tableNameUser($ID1 INTEGER PRIMARY KEY AUTOINCREMENT,"
                "$USER_NAME STRING NOT NULL,"
                "$USER_ID STRING ,"
                "$EMAIL STRING ,"
                "$ADDRESS String, "
                "$PHONE_NO String, "
                "$TS1 INTEGER"
                ")"
          );
          await db.execute(
              "CREATE TABLE $tableNameOrder($ID2 INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "$NAME STRING NOT NULL,"
                  "$PRICE STRING ,"
                  "$QUANTITY String, "
                  "$ORDER_TYPE String, "
                  "$EXCHANGE STRING,"
                  "$TS2 INTEGER"
                  ")"
          );
        }
    );
  }

  //ADD USER DATA
  saveUser(UserModel model) async
  {
    final Database db = await initDb();
    print('insert called ${model.toJson()}');
    var res = await db.insert(tableNameUser, model.toJson());
    print('dbhelper save result: $res');
    return res;
  }

  // add generated qr
  saveOrders(model) async
  {
    final Database db = await initDb();
    print('generate qr called');
    var res = await db.insert(tableNameOrder, model.toJson());
    print('saveOrders result: $res');
  }

  getUser() async{
    final Database db = await initDb();
    print('getUser data called');
    var res = await db.query(tableNameUser);
    print('dbhelper getUser result: $res');
    if(res.isNotEmpty) return res;
    else return [];
  }

  getOrdersList() async{
    final Database db = await initDb();
    print('getOrdersList called');
    var res = await db.query(tableNameOrder);
    print('getOrdersList result: $res');
    if(res.isNotEmpty) return res;
    else return [];
  }

  // Future removeList(List<int> id) async{
  //   var ids;
  //   var abc;
  //   _db = await initDb();
  //   ids = id.join(",");
  //   abc = await _db.rawDelete('DELETE FROM $tableNameScan WHERE ID IN ($ids)');
  //   print(ids);
  //   print('delete called: $abc');
  // }
  //
  // removeGeneratedQrList(List<int> id) async{
  //   print('removeGeneratedQrList');
  //   var ids;
  //   var abc;
  //   _db = await initDb();
  //   ids = id.join(",");
  //   abc = await _db.rawDelete('DELETE FROM $tableNameGenerate WHERE ID IN ($ids)');
  //   print(ids);
  //   print('removeGeneratedQrList delete called: $abc');
  // }

  Future<void> updateUser(UserModel user) async {
    // Get a reference to the database.
    _db = await initDb();

    // Update the given Dog.
    await _db.update(
      '$tableNameUser',
      user.toJson(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }

  Future<void> updateOrders(OrderModel orders) async {
    // Get a reference to the database.
    _db = await initDb();

    // Update the given Dog.
    await _db.update(
      '$tableNameOrder',
      orders.toJson(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [orders.id],
    );
  }

}

