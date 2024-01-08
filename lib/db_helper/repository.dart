import 'package:sqflite/sqflite.dart';
import 'package:sqlflite/db_helper/database_connection.dart';

class Repository {
  late DatabaseConnnection _databaseConnnection;
  Repositry() {
    _databaseConnnection = DatabaseConnnection();
  }

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnnection.setDatabase();
      return _database;
    }
  }
  //Insert user

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // Read a Single Record By ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'Id=?', whereArgs: [itemId]);
  }

  //Update user
  updateData(table, itemId) async {
    var connction = await database;
    return await connction?.rawDelete("delete from $table where id=$itemId");
  }

  //delete user
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
