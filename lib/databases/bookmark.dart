import 'package:restawurant/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkDatabase {
  static const String _database = 'restaurant.db';
  static const String _table = 'bookmarks';
  static const int _version = 1;

  Future<Database> _init() async {
    return await openDatabase(
      _database,
      version: _version,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $_table (
            id VARCHAR(255) PRIMARY KEY,
            name VARCHAR(255),
            description TEXT,
            pictureId CHAR(2),
            city VARCHAR(255),
            rating REAL
          )
        ''');
      },
    );
  }

  Future<List<Restaurant>> list() async {
    final db = await _init();
    final List<Map<String, dynamic>> maps = await db.query(_table);
    return List.generate(maps.length, (i) => Restaurant.fromJson(maps[i]));
  }

  Future<Restaurant?> detail(String id) async {
    final db = await _init();
    final List<Map<String, dynamic>> maps = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Restaurant.fromJson(maps.first) : null;
  }

  Future<int> add(Restaurant restaurant) async {
    final db = await _init();
    return await db.insert(
      _table,
      restaurant.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> remove(String id) async {
    final db = await _init();
    return await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
