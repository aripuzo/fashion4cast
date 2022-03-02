import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'app/app.dart';

const USE_DATABASE_EMULATOR = true;
// The port we've set the Firebase Database emulator to run on via the
// `firebase.json` configuration file.
const emulatorPort = 9000;
// Android device emulators consider localhost of the host machine as 10.0.2.2
// so let's use that if running on Android.
final emulatorHost =
(!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
    ? '10.0.2.2'
    : 'localhost';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final database = openDatabase(
    join(await getDatabasesPath(), 'fashion4cast_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE places(id INTEGER PRIMARY KEY, name TEXT, description TEXT, lat DOUBLE, lng DOUBLE, map TEXT, externalId TEXT)',
      );
    },
    version: 1,
  );
  // database.then((value) => {
  //   value.execute("CREATE TABLE Employee(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, mobileno TEXT,emailId TEXT )")
  // });

  if (USE_DATABASE_EMULATOR) {
    FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, emulatorPort);
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {

    runApp(App());
  });
}
