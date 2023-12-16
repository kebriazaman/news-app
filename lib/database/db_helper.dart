import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database _database;

  Future<void> closeDatabase() async {
    if (_database.isOpen) {
      await _database.close();
    }
  }
}
