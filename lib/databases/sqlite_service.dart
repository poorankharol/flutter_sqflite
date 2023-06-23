import 'package:flutter_sqflite/model/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await createTables(database);
      },
      version: 1,
    );
  }

  static Future<void> createTables(Database database) async {
    await database.execute("CREATE TABLE Notes (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,description TEXT NOT NULL)");
  }

  //Add Item
  static Future<int> createItem(Note note) async {
    final Database db = await initializeDB();
    final id = await db.insert('Notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateUser(Note note) async {
    final Database db = await initializeDB();
    int result = await db.update(
      'Notes',
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
    return result;
  }

  // Read all notes
  static Future<List<Note>> getItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Notes');
    return queryResult.map((e) => Note.fromMap(e)).toList();
  }

  //Add Item
  static Future<void> deleteItem(int id) async {
    final Database db = await initializeDB();
    db.delete('Notes', where: "id = ?", whereArgs: [id]);
  }
}
