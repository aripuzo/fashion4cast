import 'dart:async';

import 'package:drift/drift.dart';
import '../app_database.dart';

part 'place_dao.g.dart';

@DriftAccessor(tables: [Places])
class PlaceDao extends DatabaseAccessor<MyDatabase> with _$PlaceDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  PlaceDao(MyDatabase db) : super(db);

  final String tableTodo = 'places';
  final String columnId = 'id';
  final String columnDescription = 'description';
  final String columnName = 'name';
  final String columnLat = 'lat';
  final String columnLng = 'lng';
  final String columnMap = 'map';
  final String columnExternalId = 'externalId';

  @override
  Future < int > updatePlace(Place usr) {
    return into(places)
        .insertOnConflictUpdate(usr);
  }

  Future insertMore(List<Place> places) async {
    for (int i = 0; i < places.length; i++) {
      updatePlace(places[i]);
    }
  }

  Future<Place> getPlace(int id) async {
    return (select(places)..where((place) => place.id.equals(id))).getSingle();
  }

  Stream<List<Place>> watchPlaces() {
    return (select(places)).watch();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<List<Place>> getPlaces() async {
    return select(places).get();
  }
}