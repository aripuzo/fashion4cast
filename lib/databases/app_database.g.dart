// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Place extends DataClass implements Insertable<Place> {
  final int id;
  final String name;
  final String description;
  final double lat;
  final double lng;
  final String external_id;
  Place(
      {@required this.id,
      @required this.name,
      this.description,
      @required this.lat,
      @required this.lng,
      this.external_id});
  factory Place.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Place(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      lat: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat']),
      lng: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lng']),
      external_id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}external_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lng != null) {
      map['lng'] = Variable<double>(lng);
    }
    if (!nullToAbsent || external_id != null) {
      map['external_id'] = Variable<String>(external_id);
    }
    return map;
  }

  PlacesCompanion toCompanion(bool nullToAbsent) {
    return PlacesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lng: lng == null && nullToAbsent ? const Value.absent() : Value(lng),
      external_id: external_id == null && nullToAbsent
          ? const Value.absent()
          : Value(external_id),
    );
  }

  factory Place.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Place(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      external_id: serializer.fromJson<String>(json['external_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'external_id': serializer.toJson<String>(external_id),
    };
  }

  Place copyWith(
          {int id,
          String name,
          String description,
          double lat,
          double lng,
          String external_id}) =>
      Place(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        external_id: external_id ?? this.external_id,
      );
  @override
  String toString() {
    return (StringBuffer('Place(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('external_id: $external_id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(
                  lat.hashCode, $mrjc(lng.hashCode, external_id.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Place &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.external_id == this.external_id);
}

class PlacesCompanion extends UpdateCompanion<Place> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<double> lat;
  final Value<double> lng;
  final Value<String> external_id;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.external_id = const Value.absent(),
  });
  PlacesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.description = const Value.absent(),
    @required double lat,
    @required double lng,
    this.external_id = const Value.absent(),
  })  : name = Value(name),
        lat = Value(lat),
        lng = Value(lng);
  static Insertable<Place> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<double> lat,
    Expression<double> lng,
    Expression<String> external_id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (external_id != null) 'external_id': external_id,
    });
  }

  PlacesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<double> lat,
      Value<double> lng,
      Value<String> external_id}) {
    return PlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      external_id: external_id ?? this.external_id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (external_id.present) {
      map['external_id'] = Variable<String>(external_id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('external_id: $external_id')
          ..write(')'))
        .toString();
  }
}

class $PlacesTable extends Places with TableInfo<$PlacesTable, Place> {
  final GeneratedDatabase _db;
  final String _alias;
  $PlacesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'UNIQUE');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      _name ??= GeneratedColumn<String>('name', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description =>
      _description ??= GeneratedColumn<String>('description', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  GeneratedColumn<double> _lat;
  @override
  GeneratedColumn<double> get lat =>
      _lat ??= GeneratedColumn<double>('lat', aliasedName, false,
          typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  GeneratedColumn<double> _lng;
  @override
  GeneratedColumn<double> get lng =>
      _lng ??= GeneratedColumn<double>('lng', aliasedName, false,
          typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _external_idMeta =
      const VerificationMeta('external_id');
  GeneratedColumn<String> _external_id;
  @override
  GeneratedColumn<String> get external_id =>
      _external_id ??= GeneratedColumn<String>('external_id', aliasedName, true,
          typeName: 'TEXT',
          requiredDuringInsert: false,
          $customConstraints: 'UNIQUE');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, lat, lng, external_id];
  @override
  String get aliasedName => _alias ?? 'places';
  @override
  String get actualTableName => 'places';
  @override
  VerificationContext validateIntegrity(Insertable<Place> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat'], _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng'], _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('external_id')) {
      context.handle(
          _external_idMeta,
          external_id.isAcceptableOrUnknown(
              data['external_id'], _external_idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Place map(Map<String, dynamic> data, {String tablePrefix}) {
    return Place.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(_db, alias);
  }
}

class Weather extends DataClass implements Insertable<Weather> {
  final String id;
  final int placeId;
  final String description;
  final String summery;
  final String icon;
  final int timestamp;
  final double min_temp;
  final double max_temp;
  final bool is_today;
  final String day;
  final String date;
  Weather(
      {@required this.id,
      this.placeId,
      this.description,
      this.summery,
      this.icon,
      this.timestamp,
      this.min_temp,
      this.max_temp,
      this.is_today,
      this.day,
      this.date});
  factory Weather.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Weather(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      placeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_id']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      summery: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}summery']),
      icon: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}icon']),
      timestamp: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
      min_temp: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}min_temp']),
      max_temp: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_temp']),
      is_today: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_today']),
      day: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}day']),
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || placeId != null) {
      map['place_id'] = Variable<int>(placeId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || summery != null) {
      map['summery'] = Variable<String>(summery);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    if (!nullToAbsent || min_temp != null) {
      map['min_temp'] = Variable<double>(min_temp);
    }
    if (!nullToAbsent || max_temp != null) {
      map['max_temp'] = Variable<double>(max_temp);
    }
    if (!nullToAbsent || is_today != null) {
      map['is_today'] = Variable<bool>(is_today);
    }
    if (!nullToAbsent || day != null) {
      map['day'] = Variable<String>(day);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    return map;
  }

  WeathersCompanion toCompanion(bool nullToAbsent) {
    return WeathersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      summery: summery == null && nullToAbsent
          ? const Value.absent()
          : Value(summery),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      min_temp: min_temp == null && nullToAbsent
          ? const Value.absent()
          : Value(min_temp),
      max_temp: max_temp == null && nullToAbsent
          ? const Value.absent()
          : Value(max_temp),
      is_today: is_today == null && nullToAbsent
          ? const Value.absent()
          : Value(is_today),
      day: day == null && nullToAbsent ? const Value.absent() : Value(day),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory Weather.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Weather(
      id: serializer.fromJson<String>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      description: serializer.fromJson<String>(json['description']),
      summery: serializer.fromJson<String>(json['summery']),
      icon: serializer.fromJson<String>(json['icon']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      min_temp: serializer.fromJson<double>(json['min_temp']),
      max_temp: serializer.fromJson<double>(json['max_temp']),
      is_today: serializer.fromJson<bool>(json['is_today']),
      day: serializer.fromJson<String>(json['day']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'placeId': serializer.toJson<int>(placeId),
      'description': serializer.toJson<String>(description),
      'summery': serializer.toJson<String>(summery),
      'icon': serializer.toJson<String>(icon),
      'timestamp': serializer.toJson<int>(timestamp),
      'min_temp': serializer.toJson<double>(min_temp),
      'max_temp': serializer.toJson<double>(max_temp),
      'is_today': serializer.toJson<bool>(is_today),
      'day': serializer.toJson<String>(day),
      'date': serializer.toJson<String>(date),
    };
  }

  Weather copyWith(
          {String id,
          int placeId,
          String description,
          String summery,
          String icon,
          int timestamp,
          double min_temp,
          double max_temp,
          bool is_today,
          String day,
          String date}) =>
      Weather(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        description: description ?? this.description,
        summery: summery ?? this.summery,
        icon: icon ?? this.icon,
        timestamp: timestamp ?? this.timestamp,
        min_temp: min_temp ?? this.min_temp,
        max_temp: max_temp ?? this.max_temp,
        is_today: is_today ?? this.is_today,
        day: day ?? this.day,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Weather(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('description: $description, ')
          ..write('summery: $summery, ')
          ..write('icon: $icon, ')
          ..write('timestamp: $timestamp, ')
          ..write('min_temp: $min_temp, ')
          ..write('max_temp: $max_temp, ')
          ..write('is_today: $is_today, ')
          ..write('day: $day, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          placeId.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(
                  summery.hashCode,
                  $mrjc(
                      icon.hashCode,
                      $mrjc(
                          timestamp.hashCode,
                          $mrjc(
                              min_temp.hashCode,
                              $mrjc(
                                  max_temp.hashCode,
                                  $mrjc(
                                      is_today.hashCode,
                                      $mrjc(day.hashCode,
                                          date.hashCode)))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weather &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.description == this.description &&
          other.summery == this.summery &&
          other.icon == this.icon &&
          other.timestamp == this.timestamp &&
          other.min_temp == this.min_temp &&
          other.max_temp == this.max_temp &&
          other.is_today == this.is_today &&
          other.day == this.day &&
          other.date == this.date);
}

class WeathersCompanion extends UpdateCompanion<Weather> {
  final Value<String> id;
  final Value<int> placeId;
  final Value<String> description;
  final Value<String> summery;
  final Value<String> icon;
  final Value<int> timestamp;
  final Value<double> min_temp;
  final Value<double> max_temp;
  final Value<bool> is_today;
  final Value<String> day;
  final Value<String> date;
  const WeathersCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.description = const Value.absent(),
    this.summery = const Value.absent(),
    this.icon = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.min_temp = const Value.absent(),
    this.max_temp = const Value.absent(),
    this.is_today = const Value.absent(),
    this.day = const Value.absent(),
    this.date = const Value.absent(),
  });
  WeathersCompanion.insert({
    @required String id,
    this.placeId = const Value.absent(),
    this.description = const Value.absent(),
    this.summery = const Value.absent(),
    this.icon = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.min_temp = const Value.absent(),
    this.max_temp = const Value.absent(),
    this.is_today = const Value.absent(),
    this.day = const Value.absent(),
    this.date = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Weather> custom({
    Expression<String> id,
    Expression<int> placeId,
    Expression<String> description,
    Expression<String> summery,
    Expression<String> icon,
    Expression<int> timestamp,
    Expression<double> min_temp,
    Expression<double> max_temp,
    Expression<bool> is_today,
    Expression<String> day,
    Expression<String> date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (description != null) 'description': description,
      if (summery != null) 'summery': summery,
      if (icon != null) 'icon': icon,
      if (timestamp != null) 'timestamp': timestamp,
      if (min_temp != null) 'min_temp': min_temp,
      if (max_temp != null) 'max_temp': max_temp,
      if (is_today != null) 'is_today': is_today,
      if (day != null) 'day': day,
      if (date != null) 'date': date,
    });
  }

  WeathersCompanion copyWith(
      {Value<String> id,
      Value<int> placeId,
      Value<String> description,
      Value<String> summery,
      Value<String> icon,
      Value<int> timestamp,
      Value<double> min_temp,
      Value<double> max_temp,
      Value<bool> is_today,
      Value<String> day,
      Value<String> date}) {
    return WeathersCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      description: description ?? this.description,
      summery: summery ?? this.summery,
      icon: icon ?? this.icon,
      timestamp: timestamp ?? this.timestamp,
      min_temp: min_temp ?? this.min_temp,
      max_temp: max_temp ?? this.max_temp,
      is_today: is_today ?? this.is_today,
      day: day ?? this.day,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (summery.present) {
      map['summery'] = Variable<String>(summery.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (min_temp.present) {
      map['min_temp'] = Variable<double>(min_temp.value);
    }
    if (max_temp.present) {
      map['max_temp'] = Variable<double>(max_temp.value);
    }
    if (is_today.present) {
      map['is_today'] = Variable<bool>(is_today.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeathersCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('description: $description, ')
          ..write('summery: $summery, ')
          ..write('icon: $icon, ')
          ..write('timestamp: $timestamp, ')
          ..write('min_temp: $min_temp, ')
          ..write('max_temp: $max_temp, ')
          ..write('is_today: $is_today, ')
          ..write('day: $day, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $WeathersTable extends Weathers with TableInfo<$WeathersTable, Weather> {
  final GeneratedDatabase _db;
  final String _alias;
  $WeathersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<String> _id;
  @override
  GeneratedColumn<String> get id =>
      _id ??= GeneratedColumn<String>('id', aliasedName, false,
          typeName: 'TEXT',
          requiredDuringInsert: true,
          $customConstraints: 'UNIQUE');
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  GeneratedColumn<int> _placeId;
  @override
  GeneratedColumn<int> get placeId =>
      _placeId ??= GeneratedColumn<int>('place_id', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description =>
      _description ??= GeneratedColumn<String>('description', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _summeryMeta = const VerificationMeta('summery');
  GeneratedColumn<String> _summery;
  @override
  GeneratedColumn<String> get summery =>
      _summery ??= GeneratedColumn<String>('summery', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _iconMeta = const VerificationMeta('icon');
  GeneratedColumn<String> _icon;
  @override
  GeneratedColumn<String> get icon =>
      _icon ??= GeneratedColumn<String>('icon', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedColumn<int> _timestamp;
  @override
  GeneratedColumn<int> get timestamp =>
      _timestamp ??= GeneratedColumn<int>('timestamp', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _min_tempMeta = const VerificationMeta('min_temp');
  GeneratedColumn<double> _min_temp;
  @override
  GeneratedColumn<double> get min_temp =>
      _min_temp ??= GeneratedColumn<double>('min_temp', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _max_tempMeta = const VerificationMeta('max_temp');
  GeneratedColumn<double> _max_temp;
  @override
  GeneratedColumn<double> get max_temp =>
      _max_temp ??= GeneratedColumn<double>('max_temp', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _is_todayMeta = const VerificationMeta('is_today');
  GeneratedColumn<bool> _is_today;
  @override
  GeneratedColumn<bool> get is_today =>
      _is_today ??= GeneratedColumn<bool>('is_today', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'CHECK (is_today IN (0, 1))');
  final VerificationMeta _dayMeta = const VerificationMeta('day');
  GeneratedColumn<String> _day;
  @override
  GeneratedColumn<String> get day =>
      _day ??= GeneratedColumn<String>('day', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedColumn<String> _date;
  @override
  GeneratedColumn<String> get date =>
      _date ??= GeneratedColumn<String>('date', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        placeId,
        description,
        summery,
        icon,
        timestamp,
        min_temp,
        max_temp,
        is_today,
        day,
        date
      ];
  @override
  String get aliasedName => _alias ?? 'weathers';
  @override
  String get actualTableName => 'weathers';
  @override
  VerificationContext validateIntegrity(Insertable<Weather> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id'], _placeIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('summery')) {
      context.handle(_summeryMeta,
          summery.isAcceptableOrUnknown(data['summery'], _summeryMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon'], _iconMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
    }
    if (data.containsKey('min_temp')) {
      context.handle(_min_tempMeta,
          min_temp.isAcceptableOrUnknown(data['min_temp'], _min_tempMeta));
    }
    if (data.containsKey('max_temp')) {
      context.handle(_max_tempMeta,
          max_temp.isAcceptableOrUnknown(data['max_temp'], _max_tempMeta));
    }
    if (data.containsKey('is_today')) {
      context.handle(_is_todayMeta,
          is_today.isAcceptableOrUnknown(data['is_today'], _is_todayMeta));
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day'], _dayMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Weather map(Map<String, dynamic> data, {String tablePrefix}) {
    return Weather.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WeathersTable createAlias(String alias) {
    return $WeathersTable(_db, alias);
  }
}

class CurrentWeather extends DataClass implements Insertable<CurrentWeather> {
  final int placeId;
  final String description;
  final String summery;
  final String icon;
  final double pressure;
  final double temperature;
  final double humidity;
  final double pressure_daily;
  final double chance_of_rain;
  final int wind_direction;
  final String external_id;
  final String background;
  final bool alert;
  final double min_temp;
  final double wind_speed;
  final double max_temp;
  final bool is_today;
  final String day;
  final String date;
  CurrentWeather(
      {this.placeId,
      this.description,
      this.summery,
      this.icon,
      this.pressure,
      this.temperature,
      this.humidity,
      this.pressure_daily,
      this.chance_of_rain,
      this.wind_direction,
      this.external_id,
      this.background,
      this.alert,
      this.min_temp,
      this.wind_speed,
      this.max_temp,
      this.is_today,
      this.day,
      this.date});
  factory CurrentWeather.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return CurrentWeather(
      placeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_id']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      summery: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}summery']),
      icon: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}icon']),
      pressure: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pressure']),
      temperature: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}temperature']),
      humidity: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}humidity']),
      pressure_daily: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pressure_daily']),
      chance_of_rain: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}chance_of_rain']),
      wind_direction: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}wind_direction']),
      external_id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}external_id']),
      background: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}background']),
      alert: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}alert']),
      min_temp: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}min_temp']),
      wind_speed: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}wind_speed']),
      max_temp: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_temp']),
      is_today: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_today']),
      day: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}day']),
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || placeId != null) {
      map['place_id'] = Variable<int>(placeId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || summery != null) {
      map['summery'] = Variable<String>(summery);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || pressure != null) {
      map['pressure'] = Variable<double>(pressure);
    }
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    if (!nullToAbsent || humidity != null) {
      map['humidity'] = Variable<double>(humidity);
    }
    if (!nullToAbsent || pressure_daily != null) {
      map['pressure_daily'] = Variable<double>(pressure_daily);
    }
    if (!nullToAbsent || chance_of_rain != null) {
      map['chance_of_rain'] = Variable<double>(chance_of_rain);
    }
    if (!nullToAbsent || wind_direction != null) {
      map['wind_direction'] = Variable<int>(wind_direction);
    }
    if (!nullToAbsent || external_id != null) {
      map['external_id'] = Variable<String>(external_id);
    }
    if (!nullToAbsent || background != null) {
      map['background'] = Variable<String>(background);
    }
    if (!nullToAbsent || alert != null) {
      map['alert'] = Variable<bool>(alert);
    }
    if (!nullToAbsent || min_temp != null) {
      map['min_temp'] = Variable<double>(min_temp);
    }
    if (!nullToAbsent || wind_speed != null) {
      map['wind_speed'] = Variable<double>(wind_speed);
    }
    if (!nullToAbsent || max_temp != null) {
      map['max_temp'] = Variable<double>(max_temp);
    }
    if (!nullToAbsent || is_today != null) {
      map['is_today'] = Variable<bool>(is_today);
    }
    if (!nullToAbsent || day != null) {
      map['day'] = Variable<String>(day);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    return map;
  }

  CurrentWeathersCompanion toCompanion(bool nullToAbsent) {
    return CurrentWeathersCompanion(
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      summery: summery == null && nullToAbsent
          ? const Value.absent()
          : Value(summery),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      pressure: pressure == null && nullToAbsent
          ? const Value.absent()
          : Value(pressure),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      humidity: humidity == null && nullToAbsent
          ? const Value.absent()
          : Value(humidity),
      pressure_daily: pressure_daily == null && nullToAbsent
          ? const Value.absent()
          : Value(pressure_daily),
      chance_of_rain: chance_of_rain == null && nullToAbsent
          ? const Value.absent()
          : Value(chance_of_rain),
      wind_direction: wind_direction == null && nullToAbsent
          ? const Value.absent()
          : Value(wind_direction),
      external_id: external_id == null && nullToAbsent
          ? const Value.absent()
          : Value(external_id),
      background: background == null && nullToAbsent
          ? const Value.absent()
          : Value(background),
      alert:
          alert == null && nullToAbsent ? const Value.absent() : Value(alert),
      min_temp: min_temp == null && nullToAbsent
          ? const Value.absent()
          : Value(min_temp),
      wind_speed: wind_speed == null && nullToAbsent
          ? const Value.absent()
          : Value(wind_speed),
      max_temp: max_temp == null && nullToAbsent
          ? const Value.absent()
          : Value(max_temp),
      is_today: is_today == null && nullToAbsent
          ? const Value.absent()
          : Value(is_today),
      day: day == null && nullToAbsent ? const Value.absent() : Value(day),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory CurrentWeather.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CurrentWeather(
      placeId: serializer.fromJson<int>(json['placeId']),
      description: serializer.fromJson<String>(json['description']),
      summery: serializer.fromJson<String>(json['summery']),
      icon: serializer.fromJson<String>(json['icon']),
      pressure: serializer.fromJson<double>(json['pressure']),
      temperature: serializer.fromJson<double>(json['temperature']),
      humidity: serializer.fromJson<double>(json['humidity']),
      pressure_daily: serializer.fromJson<double>(json['pressure_daily']),
      chance_of_rain: serializer.fromJson<double>(json['chance_of_rain']),
      wind_direction: serializer.fromJson<int>(json['wind_direction']),
      external_id: serializer.fromJson<String>(json['external_id']),
      background: serializer.fromJson<String>(json['background']),
      alert: serializer.fromJson<bool>(json['alert']),
      min_temp: serializer.fromJson<double>(json['min_temp']),
      wind_speed: serializer.fromJson<double>(json['wind_speed']),
      max_temp: serializer.fromJson<double>(json['max_temp']),
      is_today: serializer.fromJson<bool>(json['is_today']),
      day: serializer.fromJson<String>(json['day']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'placeId': serializer.toJson<int>(placeId),
      'description': serializer.toJson<String>(description),
      'summery': serializer.toJson<String>(summery),
      'icon': serializer.toJson<String>(icon),
      'pressure': serializer.toJson<double>(pressure),
      'temperature': serializer.toJson<double>(temperature),
      'humidity': serializer.toJson<double>(humidity),
      'pressure_daily': serializer.toJson<double>(pressure_daily),
      'chance_of_rain': serializer.toJson<double>(chance_of_rain),
      'wind_direction': serializer.toJson<int>(wind_direction),
      'external_id': serializer.toJson<String>(external_id),
      'background': serializer.toJson<String>(background),
      'alert': serializer.toJson<bool>(alert),
      'min_temp': serializer.toJson<double>(min_temp),
      'wind_speed': serializer.toJson<double>(wind_speed),
      'max_temp': serializer.toJson<double>(max_temp),
      'is_today': serializer.toJson<bool>(is_today),
      'day': serializer.toJson<String>(day),
      'date': serializer.toJson<String>(date),
    };
  }

  CurrentWeather copyWith(
          {int placeId,
          String description,
          String summery,
          String icon,
          double pressure,
          double temperature,
          double humidity,
          double pressure_daily,
          double chance_of_rain,
          int wind_direction,
          String external_id,
          String background,
          bool alert,
          double min_temp,
          double wind_speed,
          double max_temp,
          bool is_today,
          String day,
          String date}) =>
      CurrentWeather(
        placeId: placeId ?? this.placeId,
        description: description ?? this.description,
        summery: summery ?? this.summery,
        icon: icon ?? this.icon,
        pressure: pressure ?? this.pressure,
        temperature: temperature ?? this.temperature,
        humidity: humidity ?? this.humidity,
        pressure_daily: pressure_daily ?? this.pressure_daily,
        chance_of_rain: chance_of_rain ?? this.chance_of_rain,
        wind_direction: wind_direction ?? this.wind_direction,
        external_id: external_id ?? this.external_id,
        background: background ?? this.background,
        alert: alert ?? this.alert,
        min_temp: min_temp ?? this.min_temp,
        wind_speed: wind_speed ?? this.wind_speed,
        max_temp: max_temp ?? this.max_temp,
        is_today: is_today ?? this.is_today,
        day: day ?? this.day,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('CurrentWeather(')
          ..write('placeId: $placeId, ')
          ..write('description: $description, ')
          ..write('summery: $summery, ')
          ..write('icon: $icon, ')
          ..write('pressure: $pressure, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('pressure_daily: $pressure_daily, ')
          ..write('chance_of_rain: $chance_of_rain, ')
          ..write('wind_direction: $wind_direction, ')
          ..write('external_id: $external_id, ')
          ..write('background: $background, ')
          ..write('alert: $alert, ')
          ..write('min_temp: $min_temp, ')
          ..write('wind_speed: $wind_speed, ')
          ..write('max_temp: $max_temp, ')
          ..write('is_today: $is_today, ')
          ..write('day: $day, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      placeId.hashCode,
      $mrjc(
          description.hashCode,
          $mrjc(
              summery.hashCode,
              $mrjc(
                  icon.hashCode,
                  $mrjc(
                      pressure.hashCode,
                      $mrjc(
                          temperature.hashCode,
                          $mrjc(
                              humidity.hashCode,
                              $mrjc(
                                  pressure_daily.hashCode,
                                  $mrjc(
                                      chance_of_rain.hashCode,
                                      $mrjc(
                                          wind_direction.hashCode,
                                          $mrjc(
                                              external_id.hashCode,
                                              $mrjc(
                                                  background.hashCode,
                                                  $mrjc(
                                                      alert.hashCode,
                                                      $mrjc(
                                                          min_temp.hashCode,
                                                          $mrjc(
                                                              wind_speed
                                                                  .hashCode,
                                                              $mrjc(
                                                                  max_temp
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      is_today
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          day.hashCode,
                                                                          date.hashCode)))))))))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrentWeather &&
          other.placeId == this.placeId &&
          other.description == this.description &&
          other.summery == this.summery &&
          other.icon == this.icon &&
          other.pressure == this.pressure &&
          other.temperature == this.temperature &&
          other.humidity == this.humidity &&
          other.pressure_daily == this.pressure_daily &&
          other.chance_of_rain == this.chance_of_rain &&
          other.wind_direction == this.wind_direction &&
          other.external_id == this.external_id &&
          other.background == this.background &&
          other.alert == this.alert &&
          other.min_temp == this.min_temp &&
          other.wind_speed == this.wind_speed &&
          other.max_temp == this.max_temp &&
          other.is_today == this.is_today &&
          other.day == this.day &&
          other.date == this.date);
}

class CurrentWeathersCompanion extends UpdateCompanion<CurrentWeather> {
  final Value<int> placeId;
  final Value<String> description;
  final Value<String> summery;
  final Value<String> icon;
  final Value<double> pressure;
  final Value<double> temperature;
  final Value<double> humidity;
  final Value<double> pressure_daily;
  final Value<double> chance_of_rain;
  final Value<int> wind_direction;
  final Value<String> external_id;
  final Value<String> background;
  final Value<bool> alert;
  final Value<double> min_temp;
  final Value<double> wind_speed;
  final Value<double> max_temp;
  final Value<bool> is_today;
  final Value<String> day;
  final Value<String> date;
  const CurrentWeathersCompanion({
    this.placeId = const Value.absent(),
    this.description = const Value.absent(),
    this.summery = const Value.absent(),
    this.icon = const Value.absent(),
    this.pressure = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.pressure_daily = const Value.absent(),
    this.chance_of_rain = const Value.absent(),
    this.wind_direction = const Value.absent(),
    this.external_id = const Value.absent(),
    this.background = const Value.absent(),
    this.alert = const Value.absent(),
    this.min_temp = const Value.absent(),
    this.wind_speed = const Value.absent(),
    this.max_temp = const Value.absent(),
    this.is_today = const Value.absent(),
    this.day = const Value.absent(),
    this.date = const Value.absent(),
  });
  CurrentWeathersCompanion.insert({
    this.placeId = const Value.absent(),
    this.description = const Value.absent(),
    this.summery = const Value.absent(),
    this.icon = const Value.absent(),
    this.pressure = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.pressure_daily = const Value.absent(),
    this.chance_of_rain = const Value.absent(),
    this.wind_direction = const Value.absent(),
    this.external_id = const Value.absent(),
    this.background = const Value.absent(),
    this.alert = const Value.absent(),
    this.min_temp = const Value.absent(),
    this.wind_speed = const Value.absent(),
    this.max_temp = const Value.absent(),
    this.is_today = const Value.absent(),
    this.day = const Value.absent(),
    this.date = const Value.absent(),
  });
  static Insertable<CurrentWeather> custom({
    Expression<int> placeId,
    Expression<String> description,
    Expression<String> summery,
    Expression<String> icon,
    Expression<double> pressure,
    Expression<double> temperature,
    Expression<double> humidity,
    Expression<double> pressure_daily,
    Expression<double> chance_of_rain,
    Expression<int> wind_direction,
    Expression<String> external_id,
    Expression<String> background,
    Expression<bool> alert,
    Expression<double> min_temp,
    Expression<double> wind_speed,
    Expression<double> max_temp,
    Expression<bool> is_today,
    Expression<String> day,
    Expression<String> date,
  }) {
    return RawValuesInsertable({
      if (placeId != null) 'place_id': placeId,
      if (description != null) 'description': description,
      if (summery != null) 'summery': summery,
      if (icon != null) 'icon': icon,
      if (pressure != null) 'pressure': pressure,
      if (temperature != null) 'temperature': temperature,
      if (humidity != null) 'humidity': humidity,
      if (pressure_daily != null) 'pressure_daily': pressure_daily,
      if (chance_of_rain != null) 'chance_of_rain': chance_of_rain,
      if (wind_direction != null) 'wind_direction': wind_direction,
      if (external_id != null) 'external_id': external_id,
      if (background != null) 'background': background,
      if (alert != null) 'alert': alert,
      if (min_temp != null) 'min_temp': min_temp,
      if (wind_speed != null) 'wind_speed': wind_speed,
      if (max_temp != null) 'max_temp': max_temp,
      if (is_today != null) 'is_today': is_today,
      if (day != null) 'day': day,
      if (date != null) 'date': date,
    });
  }

  CurrentWeathersCompanion copyWith(
      {Value<int> placeId,
      Value<String> description,
      Value<String> summery,
      Value<String> icon,
      Value<double> pressure,
      Value<double> temperature,
      Value<double> humidity,
      Value<double> pressure_daily,
      Value<double> chance_of_rain,
      Value<int> wind_direction,
      Value<String> external_id,
      Value<String> background,
      Value<bool> alert,
      Value<double> min_temp,
      Value<double> wind_speed,
      Value<double> max_temp,
      Value<bool> is_today,
      Value<String> day,
      Value<String> date}) {
    return CurrentWeathersCompanion(
      placeId: placeId ?? this.placeId,
      description: description ?? this.description,
      summery: summery ?? this.summery,
      icon: icon ?? this.icon,
      pressure: pressure ?? this.pressure,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      pressure_daily: pressure_daily ?? this.pressure_daily,
      chance_of_rain: chance_of_rain ?? this.chance_of_rain,
      wind_direction: wind_direction ?? this.wind_direction,
      external_id: external_id ?? this.external_id,
      background: background ?? this.background,
      alert: alert ?? this.alert,
      min_temp: min_temp ?? this.min_temp,
      wind_speed: wind_speed ?? this.wind_speed,
      max_temp: max_temp ?? this.max_temp,
      is_today: is_today ?? this.is_today,
      day: day ?? this.day,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (summery.present) {
      map['summery'] = Variable<String>(summery.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (pressure.present) {
      map['pressure'] = Variable<double>(pressure.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<double>(humidity.value);
    }
    if (pressure_daily.present) {
      map['pressure_daily'] = Variable<double>(pressure_daily.value);
    }
    if (chance_of_rain.present) {
      map['chance_of_rain'] = Variable<double>(chance_of_rain.value);
    }
    if (wind_direction.present) {
      map['wind_direction'] = Variable<int>(wind_direction.value);
    }
    if (external_id.present) {
      map['external_id'] = Variable<String>(external_id.value);
    }
    if (background.present) {
      map['background'] = Variable<String>(background.value);
    }
    if (alert.present) {
      map['alert'] = Variable<bool>(alert.value);
    }
    if (min_temp.present) {
      map['min_temp'] = Variable<double>(min_temp.value);
    }
    if (wind_speed.present) {
      map['wind_speed'] = Variable<double>(wind_speed.value);
    }
    if (max_temp.present) {
      map['max_temp'] = Variable<double>(max_temp.value);
    }
    if (is_today.present) {
      map['is_today'] = Variable<bool>(is_today.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrentWeathersCompanion(')
          ..write('placeId: $placeId, ')
          ..write('description: $description, ')
          ..write('summery: $summery, ')
          ..write('icon: $icon, ')
          ..write('pressure: $pressure, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('pressure_daily: $pressure_daily, ')
          ..write('chance_of_rain: $chance_of_rain, ')
          ..write('wind_direction: $wind_direction, ')
          ..write('external_id: $external_id, ')
          ..write('background: $background, ')
          ..write('alert: $alert, ')
          ..write('min_temp: $min_temp, ')
          ..write('wind_speed: $wind_speed, ')
          ..write('max_temp: $max_temp, ')
          ..write('is_today: $is_today, ')
          ..write('day: $day, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $CurrentWeathersTable extends CurrentWeathers
    with TableInfo<$CurrentWeathersTable, CurrentWeather> {
  final GeneratedDatabase _db;
  final String _alias;
  $CurrentWeathersTable(this._db, [this._alias]);
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  GeneratedColumn<int> _placeId;
  @override
  GeneratedColumn<int> get placeId =>
      _placeId ??= GeneratedColumn<int>('place_id', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'UNIQUE');
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description =>
      _description ??= GeneratedColumn<String>('description', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _summeryMeta = const VerificationMeta('summery');
  GeneratedColumn<String> _summery;
  @override
  GeneratedColumn<String> get summery =>
      _summery ??= GeneratedColumn<String>('summery', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _iconMeta = const VerificationMeta('icon');
  GeneratedColumn<String> _icon;
  @override
  GeneratedColumn<String> get icon =>
      _icon ??= GeneratedColumn<String>('icon', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _pressureMeta = const VerificationMeta('pressure');
  GeneratedColumn<double> _pressure;
  @override
  GeneratedColumn<double> get pressure =>
      _pressure ??= GeneratedColumn<double>('pressure', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  GeneratedColumn<double> _temperature;
  @override
  GeneratedColumn<double> get temperature =>
      _temperature ??= GeneratedColumn<double>('temperature', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _humidityMeta = const VerificationMeta('humidity');
  GeneratedColumn<double> _humidity;
  @override
  GeneratedColumn<double> get humidity =>
      _humidity ??= GeneratedColumn<double>('humidity', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _pressure_dailyMeta =
      const VerificationMeta('pressure_daily');
  GeneratedColumn<double> _pressure_daily;
  @override
  GeneratedColumn<double> get pressure_daily => _pressure_daily ??=
      GeneratedColumn<double>('pressure_daily', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _chance_of_rainMeta =
      const VerificationMeta('chance_of_rain');
  GeneratedColumn<double> _chance_of_rain;
  @override
  GeneratedColumn<double> get chance_of_rain => _chance_of_rain ??=
      GeneratedColumn<double>('chance_of_rain', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _wind_directionMeta =
      const VerificationMeta('wind_direction');
  GeneratedColumn<int> _wind_direction;
  @override
  GeneratedColumn<int> get wind_direction => _wind_direction ??=
      GeneratedColumn<int>('wind_direction', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _external_idMeta =
      const VerificationMeta('external_id');
  GeneratedColumn<String> _external_id;
  @override
  GeneratedColumn<String> get external_id =>
      _external_id ??= GeneratedColumn<String>('external_id', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _backgroundMeta = const VerificationMeta('background');
  GeneratedColumn<String> _background;
  @override
  GeneratedColumn<String> get background =>
      _background ??= GeneratedColumn<String>('background', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _alertMeta = const VerificationMeta('alert');
  GeneratedColumn<bool> _alert;
  @override
  GeneratedColumn<bool> get alert =>
      _alert ??= GeneratedColumn<bool>('alert', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'CHECK (alert IN (0, 1))');
  final VerificationMeta _min_tempMeta = const VerificationMeta('min_temp');
  GeneratedColumn<double> _min_temp;
  @override
  GeneratedColumn<double> get min_temp =>
      _min_temp ??= GeneratedColumn<double>('min_temp', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _wind_speedMeta = const VerificationMeta('wind_speed');
  GeneratedColumn<double> _wind_speed;
  @override
  GeneratedColumn<double> get wind_speed =>
      _wind_speed ??= GeneratedColumn<double>('wind_speed', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _max_tempMeta = const VerificationMeta('max_temp');
  GeneratedColumn<double> _max_temp;
  @override
  GeneratedColumn<double> get max_temp =>
      _max_temp ??= GeneratedColumn<double>('max_temp', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _is_todayMeta = const VerificationMeta('is_today');
  GeneratedColumn<bool> _is_today;
  @override
  GeneratedColumn<bool> get is_today =>
      _is_today ??= GeneratedColumn<bool>('is_today', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'CHECK (is_today IN (0, 1))');
  final VerificationMeta _dayMeta = const VerificationMeta('day');
  GeneratedColumn<String> _day;
  @override
  GeneratedColumn<String> get day =>
      _day ??= GeneratedColumn<String>('day', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedColumn<String> _date;
  @override
  GeneratedColumn<String> get date =>
      _date ??= GeneratedColumn<String>('date', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        placeId,
        description,
        summery,
        icon,
        pressure,
        temperature,
        humidity,
        pressure_daily,
        chance_of_rain,
        wind_direction,
        external_id,
        background,
        alert,
        min_temp,
        wind_speed,
        max_temp,
        is_today,
        day,
        date
      ];
  @override
  String get aliasedName => _alias ?? 'current_weathers';
  @override
  String get actualTableName => 'current_weathers';
  @override
  VerificationContext validateIntegrity(Insertable<CurrentWeather> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id'], _placeIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('summery')) {
      context.handle(_summeryMeta,
          summery.isAcceptableOrUnknown(data['summery'], _summeryMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon'], _iconMeta));
    }
    if (data.containsKey('pressure')) {
      context.handle(_pressureMeta,
          pressure.isAcceptableOrUnknown(data['pressure'], _pressureMeta));
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature'], _temperatureMeta));
    }
    if (data.containsKey('humidity')) {
      context.handle(_humidityMeta,
          humidity.isAcceptableOrUnknown(data['humidity'], _humidityMeta));
    }
    if (data.containsKey('pressure_daily')) {
      context.handle(
          _pressure_dailyMeta,
          pressure_daily.isAcceptableOrUnknown(
              data['pressure_daily'], _pressure_dailyMeta));
    }
    if (data.containsKey('chance_of_rain')) {
      context.handle(
          _chance_of_rainMeta,
          chance_of_rain.isAcceptableOrUnknown(
              data['chance_of_rain'], _chance_of_rainMeta));
    }
    if (data.containsKey('wind_direction')) {
      context.handle(
          _wind_directionMeta,
          wind_direction.isAcceptableOrUnknown(
              data['wind_direction'], _wind_directionMeta));
    }
    if (data.containsKey('external_id')) {
      context.handle(
          _external_idMeta,
          external_id.isAcceptableOrUnknown(
              data['external_id'], _external_idMeta));
    }
    if (data.containsKey('background')) {
      context.handle(
          _backgroundMeta,
          background.isAcceptableOrUnknown(
              data['background'], _backgroundMeta));
    }
    if (data.containsKey('alert')) {
      context.handle(
          _alertMeta, alert.isAcceptableOrUnknown(data['alert'], _alertMeta));
    }
    if (data.containsKey('min_temp')) {
      context.handle(_min_tempMeta,
          min_temp.isAcceptableOrUnknown(data['min_temp'], _min_tempMeta));
    }
    if (data.containsKey('wind_speed')) {
      context.handle(
          _wind_speedMeta,
          wind_speed.isAcceptableOrUnknown(
              data['wind_speed'], _wind_speedMeta));
    }
    if (data.containsKey('max_temp')) {
      context.handle(_max_tempMeta,
          max_temp.isAcceptableOrUnknown(data['max_temp'], _max_tempMeta));
    }
    if (data.containsKey('is_today')) {
      context.handle(_is_todayMeta,
          is_today.isAcceptableOrUnknown(data['is_today'], _is_todayMeta));
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day'], _dayMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {placeId};
  @override
  CurrentWeather map(Map<String, dynamic> data, {String tablePrefix}) {
    return CurrentWeather.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CurrentWeathersTable createAlias(String alias) {
    return $CurrentWeathersTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PlacesTable _places;
  $PlacesTable get places => _places ??= $PlacesTable(this);
  $WeathersTable _weathers;
  $WeathersTable get weathers => _weathers ??= $WeathersTable(this);
  $CurrentWeathersTable _currentWeathers;
  $CurrentWeathersTable get currentWeathers =>
      _currentWeathers ??= $CurrentWeathersTable(this);
  PlaceDao _placeDao;
  PlaceDao get placeDao => _placeDao ??= PlaceDao(this as AppDatabase);
  WeatherDao _weatherDao;
  WeatherDao get weatherDao => _weatherDao ??= WeatherDao(this as AppDatabase);
  CurrentWeatherDao _currentWeatherDao;
  CurrentWeatherDao get currentWeatherDao =>
      _currentWeatherDao ??= CurrentWeatherDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [places, weathers, currentWeathers];
}
