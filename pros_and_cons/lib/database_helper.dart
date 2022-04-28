import 'package:path/path.dart';
import 'package:pros_and_cons/models/decision.dart';
import 'package:sqflite/sqflite.dart';

import 'models/argument.dart';

class DatabaseHelper {
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'pros_and_cons_database'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE decisions(id INTEGER PRIMARY KEY, title TEXT)",
        );
        await db.execute(
          "CREATE TABLE arguments(id INTEGER PRIMARY KEY, decisionId INTEGER, title TEXT, value INTEGER, isPro INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertDecision(Decision decision) async {
    int decisionId = 0;

    Database _db = await getDatabase();
    await _db
        .insert('decisions', decision.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      decisionId = value;
    });

    return decisionId;
  }

  Future<void> insertArgument(Argument argument) async {
    Database _db = await getDatabase();
    await _db.insert('arguments', argument.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateDecision(int id, String title) async {
    Database _db = await getDatabase();
    await _db.update('decisions', Decision(id: id, title: title).toMap(),
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateArgument(
      int id, int decisionId, String title, int value, int isPro) async {
    Database _db = await getDatabase();
    await _db.update(
        'arguments',
        Argument(
          id: id,
          decisionId: decisionId,
          title: title,
          value: value,
          isPro: isPro,
        ).toMap(),
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<List<Decision>> getAllDecisions() async {
    Database _db = await getDatabase();
    List<Map<String, dynamic>> decisionMap = await _db.query('decisions');

    return List.generate(decisionMap.length, (index) {
      return Decision(
        id: decisionMap[index]['id'],
        title: decisionMap[index]['title'],
      );
    });
  }

  Future<List<Argument>> getArgumentsForDecision(int decisionId) async {
    Database _db = await getDatabase();
    List<Map<String, dynamic>> argumentsMap = await _db
        .query('arguments', where: 'decisionId = ?', whereArgs: [decisionId]);

    return List.generate(argumentsMap.length, (index) {
      return Argument(
        id: argumentsMap[index]['id'],
        decisionId: argumentsMap[index]['decisionId'],
        title: argumentsMap[index]['title'],
        value: argumentsMap[index]['value'],
        isPro: argumentsMap[index]['isPro'],
      );
    });
  }

  Future<void> deleteDecision(int id) async {
    Database _db = await getDatabase();
    _db.delete(
      'decisions',
      where: 'id = ?',
      whereArgs: [id],
    );
    deleteArguments(id);
  }

  Future<void> deleteArgument(int id) async {
    Database _db = await getDatabase();
    _db.delete(
      'arguments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteArguments(int decisionId) async {
    Database _db = await getDatabase();
    _db.delete(
      'arguments',
      where: 'decisionId = ?',
      whereArgs: [decisionId],
    );
  }
}
