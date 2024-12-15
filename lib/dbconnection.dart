import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBConnection {
  // Singleton instance
  static Database? _database;

  // Getter for the database
  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // Initialize the database if it hasn't been initialized yet
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    // Get the database path
    String path = join(await getDatabasesPath(), 'boarding_house.db');

    // Open the database
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Define the schema for User and Guardian tables
        db.execute(
          '''CREATE TABLE User(
              uid INTEGER PRIMARY KEY AUTOINCREMENT, 
              firstname TEXT, 
              lastname TEXT, 
              midname TEXT, 
              sex TEXT, 
              phone TEXT, 
              birth TEXT, 
              date TEXT, 
              roomnum INTEGER
          )''',
        );
        db.execute(
          '''CREATE TABLE Guardian(
              guid INTEGER PRIMARY KEY AUTOINCREMENT, 
              uid INTEGER, 
              l_name TEXT, 
              f_name TEXT, 
              m_name TEXT, 
              sex TEXT, 
              phone1 TEXT, 
              phone2 TEXT, 
              phone3 TEXT,
              FOREIGN KEY (uid) REFERENCES User(uid)
          )''',
        );
      },
    );

    // Enable foreign key constraints
    await db.execute('PRAGMA foreign_keys = ON;');
    return db;
  }
}
