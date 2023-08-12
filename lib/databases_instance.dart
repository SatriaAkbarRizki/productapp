import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:productapp/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabasesInstance {
  final String _databasesName = 'my_databases.db';
  final int _databasesVersion = 1;

  final String nameTable = 'product';
  final String id = 'id';
  final String name = 'name';
  final String category = 'category';
  final String createAt = 'create_at';
  final String updateAt = 'update_at';

  Database? _database;

  // Untuk mengecek databases nya ada apa tidak, kalau ada tinggal pakai
  Future<Database> checkDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabases();
    return _database!;
  }

  Future _initDatabases() async {
    // Mencari dan menggabungkan databases
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databasesName);

    return openDatabase(path, version: _databasesVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'create table $nameTable($id integer primary key, $name text null, $category text null, $createAt text null, $updateAt text null)');
  }

//  Method yang dimana databases memiliki data di table atau lebih tepatnya temppat kumpulan data di table
  Future<List<ProductModel>> all() async {
    // await checkDatabase(); // Ensure database is initialized
    final data = await _database!.query(nameTable);
    List<ProductModel> result =
        data.map((e) => ProductModel.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {

    final query = await _database!.insert(nameTable, row);
    return query;
  }

  Future<int> update(int idParam, Map<String, dynamic> row) async {
    final query = await _database!
        .update(nameTable, row, where: '${id} = ?', whereArgs: [idParam]);
    return query;
  }

  Future delete(int idParam) async {
    await _database!
        .delete(nameTable, where: '${id} = ?', whereArgs: [idParam]);
  }
}
