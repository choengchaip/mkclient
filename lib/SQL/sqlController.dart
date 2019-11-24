import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:synchronized/synchronized.dart';

class DatabaseHelper{
  static Database _db;
  DatabaseHelper.internal();
  final _lock = new Lock();

  String sqlCreateTable = '''CREATE TABLE IF NOT EXISTS orders(
	  order_id varchar(50) PRIMARY KEY,
    order_type varchar(50),
    order_num INTEGER,
    order_name varchar(50),
    order_price INTEGER
    )''';

  Future<Database> getDb()async{
    if(_db == null){
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'mkClient.db');
      await _lock.synchronized(()async{
        if(_db == null){
          _db = await openDatabase(path, version: 1);
        }
      });

    }
    return _db;
  }
  Future initDatabase()async{
    var dbClient = await getDb();
    await dbClient.rawQuery("DROP TABLE orders;");
    await dbClient.rawQuery(sqlCreateTable);
    print("Table is created");
  }

  Future addToCart(String id, String type, int num,String name,int price)async{
    var dbClient = await getDb();
    String sql = "INSERT INTO orders(order_id,order_type,order_num,order_name, order_price) VALUES('${id}','${type}',${num},'${name}',${price}) ON CONFLICT(order_id) DO UPDATE SET order_num = order_num + ${num};";
    print(sql);
    await dbClient.rawQuery(sql);
  }

  Future clearCart()async{
    var dbClient = await getDb();
    String sql = "delete from orders";
    dbClient.rawQuery(sql);
  }

  Future getCart()async{
    var dbClient = await getDb();
    String sql = '''select * from orders''';
    return await dbClient.rawQuery(sql);
  }

}