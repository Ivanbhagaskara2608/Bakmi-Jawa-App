// ignore_for_file: avoid_print

import 'package:aplikasi_bakmi_jawa/models/user.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          user_id TEXT,
          nama TEXT, 
          noTelp TEXT, 
          tanggalLahir TEXT,
          point INTEGER)""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('bakmijawa.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print("creating table");
      await createTables(database);
    });
  }

  static Future<int> addUser(User user) async {
    final db = await DBHelper.db();
    final data = {
      'user_id': user.id,
      'nama': user.nama,
      'noTelp': user.noTelp,
      'tanggalLahir': user.tanggalLahir,
      'point': user.point
    };
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print(data);
    return id;
  }

  static Future<User?> getUser() async {
    final db = await DBHelper.db();
    List<Map<String, dynamic>> result =
        await db.query('users', orderBy: "id", limit: 1);

    if (result.isNotEmpty) {
      return User(
        id: result[0]['id'],
        nama: result[0]['nama'],
        noTelp: result[0]['noTelp'],
        tanggalLahir: result[0]['tanggalLahir'],
        point: result[0]['point'],
      );
    } else {
      return null;
    }
  }

  static Future<int> updateUser(User user) async {
    final db = await DBHelper.db();

    final data = {
      'user_id': user.id,
      'nama': user.nama,
      'noTelp': user.noTelp,
      'tanggalLahir': user.tanggalLahir,
      'point': user.point
    };

    final result = await db
        .update('users', data, where: "user_id = ?", whereArgs: [user.id]);
    return result;
  }

  static Future<void> deleteData() async {
    final db = await DBHelper.db();
    try {
      await db.delete('users');
    } catch (err) {
      debugPrint("Error : $err");
    }
  }
}
