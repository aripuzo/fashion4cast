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
  final String body;
  Place(
      {@required this.id,
        @required this.name,
        this.description,
        @required this.lat,
        @required this.lng,
        @required this.external_id,
        this.body});
  factory Place.fromData(Map<String, dynamic> data, {String prefix}) {
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
      body: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}map']),
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
    if (!nullToAbsent || body != null) {
      map['map'] = Variable<String>(body);
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
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
    );
  }

  factory Place.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Place(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      external_id: serializer.fromJson<String>(json['external_id']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'external_id': serializer.toJson<String>(external_id),
      'body': serializer.toJson<String>(body),
    };
  }

  Place copyWith(
      {int id,
        String name,
        String description,
        double lat,
        double lng,
        String external_id,
        String body}) =>
      Place(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        external_id: external_id ?? this.external_id,
        body: body ?? this.body,
      );
  @override
  String toString() {
    return (StringBuffer('Place(')
      ..write('id: $id, ')
      ..write('name: $name, ')
      ..write('description: $description, ')
      ..write('lat: $lat, ')
      ..write('lng: $lng, ')
      ..write('external_id: $external_id, ')
      ..write('body: $body')
      ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, lat, lng, external_id, body);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Place &&
              other.id == this.id &&
              other.name == this.name &&
              other.description == this.description &&
              other.lat == this.lat &&
              other.lng == this.lng &&
              other.external_id == this.external_id &&
              other.body == this.body);
}

class PlacesCompanion extends UpdateCompanion<Place> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<double> lat;
  final Value<double> lng;
  final Value<String> external_id;
  final Value<String> body;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.external_id = const Value.absent(),
    this.body = const Value.absent(),
  });
  PlacesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.description = const Value.absent(),
    @required double lat,
    @required double lng,
    @required String external_id,
    this.body = const Value.absent(),
  })  : name = Value(name),
        lat = Value(lat),
        lng = Value(lng),
        external_id = Value(external_id);
  static Insertable<Place> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<double> lat,
    Expression<double> lng,
    Expression<String> external_id,
    Expression<String> body,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (external_id != null) 'external_id': external_id,
      if (body != null) 'map': body,
    });
  }

  PlacesCompanion copyWith(
      {Value<int> id,
        Value<String> name,
        Value<String> description,
        Value<double> lat,
        Value<double> lng,
        Value<String> external_id,
        Value<String> body}) {
    return PlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      external_id: external_id ?? this.external_id,
      body: body ?? this.body,
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
    if (body.present) {
      map['map'] = Variable<String>(body.value);
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
      ..write('external_id: $external_id, ')
      ..write('body: $body')
      ..write(')'))
        .toString();
  }
}

class $PlacesTable extends Places with TableInfo<$PlacesTable, Place> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $PlacesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name => _name ??= GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
      GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
  const VerificationMeta('description');
  GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description =>
      _description ??= GeneratedColumn<String>('description', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  GeneratedColumn<double> _lat;
  @override
  GeneratedColumn<double> get lat =>
      _lat ??= GeneratedColumn<double>('lat', aliasedName, false,
          type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  GeneratedColumn<double> _lng;
  @override
  GeneratedColumn<double> get lng =>
      _lng ??= GeneratedColumn<double>('lng', aliasedName, false,
          type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _external_idMeta =
  const VerificationMeta('external_id');
  GeneratedColumn<String> _external_id;
  @override
  GeneratedColumn<String> get external_id => _external_id ??=
      GeneratedColumn<String>('external_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedColumn<String> _body;
  @override
  GeneratedColumn<String> get body =>
      _body ??= GeneratedColumn<String>('map', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, lat, lng, external_id, body];
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
    } else if (isInserting) {
      context.missing(_external_idMeta);
    }
    if (data.containsKey('map')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['map'], _bodyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Place map(Map<String, dynamic> data, {String tablePrefix}) {
    return Place.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(attachedDatabase, alias);
  }
}

class Weather extends DataClass implements Insertable<Weather> {
  final int id;
  final String day;
  final double minTemp;
  final double maxTemp;
  final String date;
  final String icon;
  final String timestamp;
  final bool isToday;
  Weather(
      {@required this.id,
        this.day,
        this.minTemp,
        this.maxTemp,
        this.date,
        this.icon,
        this.timestamp,
        this.isToday});
  factory Weather.fromData(Map<String, dynamic> data, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Weather(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      day: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}day']),
      minTemp: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}min_temp']),
      maxTemp: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_temp']),
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      icon: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}icon']),
      timestamp: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
      isToday: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_today']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || day != null) {
      map['day'] = Variable<String>(day);
    }
    if (!nullToAbsent || minTemp != null) {
      map['min_temp'] = Variable<double>(minTemp);
    }
    if (!nullToAbsent || maxTemp != null) {
      map['max_temp'] = Variable<double>(maxTemp);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<String>(timestamp);
    }
    if (!nullToAbsent || isToday != null) {
      map['is_today'] = Variable<bool>(isToday);
    }
    return map;
  }

  WeathersCompanion toCompanion(bool nullToAbsent) {
    return WeathersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      day: day == null && nullToAbsent ? const Value.absent() : Value(day),
      minTemp: minTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(minTemp),
      maxTemp: maxTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(maxTemp),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      isToday: isToday == null && nullToAbsent
          ? const Value.absent()
          : Value(isToday),
    );
  }

  factory Weather.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weather(
      id: serializer.fromJson<int>(json['id']),
      day: serializer.fromJson<String>(json['day']),
      minTemp: serializer.fromJson<double>(json['minTemp']),
      maxTemp: serializer.fromJson<double>(json['maxTemp']),
      date: serializer.fromJson<String>(json['date']),
      icon: serializer.fromJson<String>(json['icon']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
      isToday: serializer.fromJson<bool>(json['isToday']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'day': serializer.toJson<String>(day),
      'minTemp': serializer.toJson<double>(minTemp),
      'maxTemp': serializer.toJson<double>(maxTemp),
      'date': serializer.toJson<String>(date),
      'icon': serializer.toJson<String>(icon),
      'timestamp': serializer.toJson<String>(timestamp),
      'isToday': serializer.toJson<bool>(isToday),
    };
  }

  Weather copyWith(
      {int id,
        String day,
        double minTemp,
        double maxTemp,
        String date,
        String icon,
        String timestamp,
        bool isToday}) =>
      Weather(
        id: id ?? this.id,
        day: day ?? this.day,
        minTemp: minTemp ?? this.minTemp,
        maxTemp: maxTemp ?? this.maxTemp,
        date: date ?? this.date,
        icon: icon ?? this.icon,
        timestamp: timestamp ?? this.timestamp,
        isToday: isToday ?? this.isToday,
      );
  @override
  String toString() {
    return (StringBuffer('Weather(')
      ..write('id: $id, ')
      ..write('day: $day, ')
      ..write('minTemp: $minTemp, ')
      ..write('maxTemp: $maxTemp, ')
      ..write('date: $date, ')
      ..write('icon: $icon, ')
      ..write('timestamp: $timestamp, ')
      ..write('isToday: $isToday')
      ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, day, minTemp, maxTemp, date, icon, timestamp, isToday);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Weather &&
              other.id == this.id &&
              other.day == this.day &&
              other.minTemp == this.minTemp &&
              other.maxTemp == this.maxTemp &&
              other.date == this.date &&
              other.icon == this.icon &&
              other.timestamp == this.timestamp &&
              other.isToday == this.isToday);
}

class WeathersCompanion extends UpdateCompanion<Weather> {
  final Value<int> id;
  final Value<String> day;
  final Value<double> minTemp;
  final Value<double> maxTemp;
  final Value<String> date;
  final Value<String> icon;
  final Value<String> timestamp;
  final Value<bool> isToday;
  const WeathersCompanion({
    this.id = const Value.absent(),
    this.day = const Value.absent(),
    this.minTemp = const Value.absent(),
    this.maxTemp = const Value.absent(),
    this.date = const Value.absent(),
    this.icon = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isToday = const Value.absent(),
  });
  WeathersCompanion.insert({
    this.id = const Value.absent(),
    this.day = const Value.absent(),
    this.minTemp = const Value.absent(),
    this.maxTemp = const Value.absent(),
    this.date = const Value.absent(),
    this.icon = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isToday = const Value.absent(),
  });
  static Insertable<Weather> custom({
    Expression<int> id,
    Expression<String> day,
    Expression<double> minTemp,
    Expression<double> maxTemp,
    Expression<String> date,
    Expression<String> icon,
    Expression<String> timestamp,
    Expression<bool> isToday,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (day != null) 'day': day,
      if (minTemp != null) 'min_temp': minTemp,
      if (maxTemp != null) 'max_temp': maxTemp,
      if (date != null) 'date': date,
      if (icon != null) 'icon': icon,
      if (timestamp != null) 'timestamp': timestamp,
      if (isToday != null) 'is_today': isToday,
    });
  }

  WeathersCompanion copyWith(
      {Value<int> id,
        Value<String> day,
        Value<double> minTemp,
        Value<double> maxTemp,
        Value<String> date,
        Value<String> icon,
        Value<String> timestamp,
        Value<bool> isToday}) {
    return WeathersCompanion(
      id: id ?? this.id,
      day: day ?? this.day,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      date: date ?? this.date,
      icon: icon ?? this.icon,
      timestamp: timestamp ?? this.timestamp,
      isToday: isToday ?? this.isToday,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (minTemp.present) {
      map['min_temp'] = Variable<double>(minTemp.value);
    }
    if (maxTemp.present) {
      map['max_temp'] = Variable<double>(maxTemp.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    if (isToday.present) {
      map['is_today'] = Variable<bool>(isToday.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeathersCompanion(')
      ..write('id: $id, ')
      ..write('day: $day, ')
      ..write('minTemp: $minTemp, ')
      ..write('maxTemp: $maxTemp, ')
      ..write('date: $date, ')
      ..write('icon: $icon, ')
      ..write('timestamp: $timestamp, ')
      ..write('isToday: $isToday')
      ..write(')'))
        .toString();
  }
}

class $WeathersTable extends Weathers with TableInfo<$WeathersTable, Weather> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $WeathersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _dayMeta = const VerificationMeta('day');
  GeneratedColumn<String> _day;
  @override
  GeneratedColumn<String> get day =>
      _day ??= GeneratedColumn<String>('day', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _minTempMeta = const VerificationMeta('minTemp');
  GeneratedColumn<double> _minTemp;
  @override
  GeneratedColumn<double> get minTemp =>
      _minTemp ??= GeneratedColumn<double>('min_temp', aliasedName, true,
          type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _maxTempMeta = const VerificationMeta('maxTemp');
  GeneratedColumn<double> _maxTemp;
  @override
  GeneratedColumn<double> get maxTemp =>
      _maxTemp ??= GeneratedColumn<double>('max_temp', aliasedName, true,
          type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedColumn<String> _date;
  @override
  GeneratedColumn<String> get date =>
      _date ??= GeneratedColumn<String>('date', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _iconMeta = const VerificationMeta('icon');
  GeneratedColumn<String> _icon;
  @override
  GeneratedColumn<String> get icon =>
      _icon ??= GeneratedColumn<String>('icon', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedColumn<String> _timestamp;
  @override
  GeneratedColumn<String> get timestamp =>
      _timestamp ??= GeneratedColumn<String>('timestamp', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _isTodayMeta = const VerificationMeta('isToday');
  GeneratedColumn<bool> _isToday;
  @override
  GeneratedColumn<bool> get isToday =>
      _isToday ??= GeneratedColumn<bool>('is_today', aliasedName, true,
          type: const BoolType(),
          requiredDuringInsert: false,
          defaultConstraints: 'CHECK (is_today IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, day, minTemp, maxTemp, date, icon, timestamp, isToday];
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
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day'], _dayMeta));
    }
    if (data.containsKey('min_temp')) {
      context.handle(_minTempMeta,
          minTemp.isAcceptableOrUnknown(data['min_temp'], _minTempMeta));
    }
    if (data.containsKey('max_temp')) {
      context.handle(_maxTempMeta,
          maxTemp.isAcceptableOrUnknown(data['max_temp'], _maxTempMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon'], _iconMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
    }
    if (data.containsKey('is_today')) {
      context.handle(_isTodayMeta,
          isToday.isAcceptableOrUnknown(data['is_today'], _isTodayMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Weather map(Map<String, dynamic> data, {String tablePrefix}) {
    return Weather.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WeathersTable createAlias(String alias) {
    return $WeathersTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PlacesTable _places;
  $PlacesTable get places => _places ??= $PlacesTable(this);
  $WeathersTable _weathers;
  $WeathersTable get weathers => _weathers ??= $WeathersTable(this);
  PlaceDao _placeDao;
  PlaceDao get placeDao => _placeDao ??= PlaceDao(this as MyDatabase);
  WeatherDao _weatherDao;
  WeatherDao get weatherDao => _weatherDao ??= WeatherDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [places, weathers];
}