import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'user.db');

    // Open/create the database at a given path
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the 'user' table
        await db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT, password TEXT, phone TEXT, email TEXT, address TEXT)',
        );
      },
    );
  }

  Future<User> getUser() async {
    Database dbClient = await database;
    List<Map<String, dynamic>> result = await dbClient.query('user');
    Map<String, dynamic> userData = result.first;
    return User.fromMap(userData);
  }
}

class User {
  final int id;
  final String username;
  final String password;
  final String phone;
  final String email;
  final String address;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.phone,
    required this.email,
    required this.address,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
    );
  }
}