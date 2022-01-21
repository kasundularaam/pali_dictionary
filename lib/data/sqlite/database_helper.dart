import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pali_dictionary/data/models/word_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "data.sqlite";

  static const table = 'dictionary_Sheet1';

  static const columnPali = 'pali';
  static const columnMeaning = 'meaning';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);
      if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
        ByteData data = await rootBundle.load(join('assets', _databaseName));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes);
      }
      Database database = await openDatabase(path);
      return database;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<WordModel>> searchWord(
      {required String searchText, required bool isSanskrit}) async {
    try {
      final db = await database;

      String searchColumn = isSanskrit ? columnPali : columnMeaning;

      List<Map<String, dynamic>> results = await db!.query(table,
          where: "$searchColumn LIKE ?", whereArgs: ["%$searchText%"]);

      List<WordModel> wordModels = [];

      for (var result in results) {
        WordModel wordModel = WordModel.fromMap(result);
        wordModels.add(wordModel);
      }
      print(wordModels);
      return wordModels;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<WordModel>> getAllWords({required bool isSanskrit}) async {
    try {
      final db = await database;
      final String searchColumn = isSanskrit ? columnPali : columnMeaning;
      List<Map<String, dynamic>> results =
          await db!.query(table, orderBy: "$searchColumn ASC");
      List<WordModel> wordModels = [];
      for (var result in results) {
        WordModel wordModel = WordModel.fromMap(result);
        wordModels.add(wordModel);
      }
      return wordModels;
    } catch (e) {
      throw e.toString();
    }
  }
}
