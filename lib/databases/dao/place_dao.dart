import 'dart:async';

import 'package:fashion4cast/models/place.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlaceDao {
  static PlaceDao _instance =PlaceDao._internal();
  static Database _db;

  factory PlaceDao() {
    if (_instance == null) {
      _instance = PlaceDao._internal();
    }
    return _instance;
  }

  PlaceDao._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async{
    String path = join(await getDatabasesPath(), 'fashion4cast_database.db');

    var db = await openDatabase(path, version:  1, onCreate: _onCreate);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async{
    await db.execute('''
        CREATE TABLE $tableTodo ( 
        $columnId integer primary key autoincrement,
        $columnName text not null,
        $columnDescription text not null,
        $columnLat double not null,
        $columnLng double not null,
        $columnMap text not null,
        $columnExternalId text not null)"
    ''');
  }

  final String tableTodo = 'places';
  final String columnId = 'id';
  final String columnDescription = 'description';
  final String columnName = 'name';
  final String columnLat = 'lat';
  final String columnLng = 'lng';
  final String columnMap = 'map';
  final String columnExternalId = 'externalId';

  Future<Place> insert(Place place) async {
    var dbClient = await db;
    place.id = await dbClient.insert(tableTodo, place.toJson());
    return place;
  }

  Future insertMore(List<Place> places) async {
    for (int i = 0; i < places.length; i++) {
      insert(places[i]);
    }
  }

  Future<Place> getPlace(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableTodo,
        columns: [columnId, columnName, columnDescription, columnLat, columnLng, columnMap],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Place.fromJson(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Place place) async {
    var dbClient = await db;
    return await dbClient.update(tableTodo, place.toJson(),
        where: '$columnId = ?', whereArgs: [place.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<List<Place>> getPlaces() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM ' + tableTodo);
    List<Place> employees = [];
    for (int i = 0; i < list.length; i++) {
      employees.add(Place.fromJson(list.first));
    }
    return employees;
  }
}