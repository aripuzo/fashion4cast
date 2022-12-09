import 'dart:async';

import 'package:drift/drift.dart';
import '../app_database.dart';

part 'place_dao.g.dart';

@DriftAccessor(tables: [Places])
class PlaceDao extends DatabaseAccessor<MyDatabase> with _$PlaceDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  PlaceDao(MyDatabase db) : super(db);

  @override
  Future < int > updatePlace(Place usr) {
    return into(db.places)
        .insertOnConflictUpdate(usr);
  }

  Future insertMore(List<Place> places) async {
    for (int i = 0; i < places.length; i++) {
      updatePlace(places[i]);
    }
  }

  Future<Place> getPlace(int id) async {
    return (select(db.places)..where((place) => place.id.equals(id))).getSingle();
  }

  Stream<List<Place>> watchPlaces() {
    return (select(db.places)).watch();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<List<Place>> getPlaces() async {
    return select(db.places).get();
  }
}