import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:travelactivity/core/database/constants/db_strings.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DBStrings.dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) async {
        if (kDebugMode) {
          print('Database opened');
        }
        // Removed the redundant _onCreate call
      },
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (kDebugMode) {
      print('Upgrading database from version $oldVersion to $newVersion');
    }

    // Future migrations can be handled here
  }

  Future<String> loadSQLFile(String fileName) async {
    return await rootBundle.loadString('lib/core/database/sql/$fileName');
  }

  Future<void> _onCreate(Database db, int version) async {
    if (kDebugMode) {
      print('Creating database --->');
    }
    DateTime now = DateTime.now();
    String createDBSQL = await loadSQLFile('create_db.sql');
    await _executeSQLFile(db, createDBSQL);

    if (kDebugMode) {
      print(
        'Database created in ---> ${DateTime.now().difference(now).inMilliseconds}ms',
      );
    }
  }

  Future<void> _executeSQLFile(Database db, String sql) async {
    List<String> statements = sql.split(';');

    for (String statement in statements) {
      statement = statement.trim();
      if (statement.isNotEmpty) {
        await db.execute(statement);
      }
    }
  }
}
