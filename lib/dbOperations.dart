import 'dart:io';
import 'package:sqflite/sqlite_api.dart';

final String createDb = 'CREATE TABLE IF NOT EXISTS JOURNAL(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, review TEXT, rating INTEGER, entryDate TEXT)';
final String getAllDb = 'SELECT * FROM JOURNAL';
final String insertIntoDb = 'INSERT INTO JOURNAL(title, review, rating, entryDate) VALUES(?,?,?,?)';
final String getEntry = 'SELECT * FROM JOURNAL WHERE id=';