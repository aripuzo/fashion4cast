import 'package:fashion4cast/databases/tables/places_table.dart';
import 'package:moor/moor.dart';

import '../app_database.dart';

part 'place_dao.g.dart';

@UseDao(tables: [Places])
class PlaceDao extends DatabaseAccessor<AppDatabase> with _$PlaceDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  PlaceDao(this.db) : super(db);

  Future<List<Place>> getPlaces() => select(places).get();

  Stream<List<Place>> watchAllPlaces() => select(places).watch();

  Future insertPlace(Place place) => into(places).insert(place);

  Future updatePlace(Place place) => update(places).replace(place);

  Future deletePlace(Place place) => delete(places).delete(place);

  Future<void> insertPlaces(List<Place> qs) async{
    await batch((batch) {
      batch.insertAll(places, qs);
    });
  }

  Future<void> deleteAllPlaces() async{
    var places = await getPlaces();
    if(places != null)
    for(int i = 0; i < places.length; i++){
      deletePlace(places[i]);
    }
  }

  Future<void> replacePlaces(List<Place> places) async {
    await deleteAllPlaces();
    await insertPlaces(places);
  }
}