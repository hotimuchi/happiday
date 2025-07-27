// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BirthdaysTableTable extends BirthdaysTable
    with TableInfo<$BirthdaysTableTable, BirthdaysTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BirthdaysTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthdayMeta = const VerificationMeta(
    'birthday',
  );
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
    'birthday',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relationMeta = const VerificationMeta(
    'relation',
  );
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
    'relation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    birthday,
    photoUrl,
    phone,
    email,
    note,
    relation,
    isFavorite,
    timezone,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'birthdays_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BirthdaysTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(
        _birthdayMeta,
        birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta),
      );
    } else if (isInserting) {
      context.missing(_birthdayMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('relation')) {
      context.handle(
        _relationMeta,
        relation.isAcceptableOrUnknown(data['relation']!, _relationMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BirthdaysTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BirthdaysTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      birthday:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}birthday'],
          )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      relation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      ),
    );
  }

  @override
  $BirthdaysTableTable createAlias(String alias) {
    return $BirthdaysTableTable(attachedDatabase, alias);
  }
}

class BirthdaysTableData extends DataClass
    implements Insertable<BirthdaysTableData> {
  final String id;
  final String name;
  final DateTime birthday;
  final String? photoUrl;
  final String? phone;
  final String? email;
  final String? note;
  final String? relation;
  final bool? isFavorite;
  final String? timezone;
  const BirthdaysTableData({
    required this.id,
    required this.name,
    required this.birthday,
    this.photoUrl,
    this.phone,
    this.email,
    this.note,
    this.relation,
    this.isFavorite,
    this.timezone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['birthday'] = Variable<DateTime>(birthday);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || relation != null) {
      map['relation'] = Variable<String>(relation);
    }
    if (!nullToAbsent || isFavorite != null) {
      map['is_favorite'] = Variable<bool>(isFavorite);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    return map;
  }

  BirthdaysTableCompanion toCompanion(bool nullToAbsent) {
    return BirthdaysTableCompanion(
      id: Value(id),
      name: Value(name),
      birthday: Value(birthday),
      photoUrl:
          photoUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(photoUrl),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      relation:
          relation == null && nullToAbsent
              ? const Value.absent()
              : Value(relation),
      isFavorite:
          isFavorite == null && nullToAbsent
              ? const Value.absent()
              : Value(isFavorite),
      timezone:
          timezone == null && nullToAbsent
              ? const Value.absent()
              : Value(timezone),
    );
  }

  factory BirthdaysTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BirthdaysTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      birthday: serializer.fromJson<DateTime>(json['birthday']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      note: serializer.fromJson<String?>(json['note']),
      relation: serializer.fromJson<String?>(json['relation']),
      isFavorite: serializer.fromJson<bool?>(json['isFavorite']),
      timezone: serializer.fromJson<String?>(json['timezone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'birthday': serializer.toJson<DateTime>(birthday),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'note': serializer.toJson<String?>(note),
      'relation': serializer.toJson<String?>(relation),
      'isFavorite': serializer.toJson<bool?>(isFavorite),
      'timezone': serializer.toJson<String?>(timezone),
    };
  }

  BirthdaysTableData copyWith({
    String? id,
    String? name,
    DateTime? birthday,
    Value<String?> photoUrl = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> relation = const Value.absent(),
    Value<bool?> isFavorite = const Value.absent(),
    Value<String?> timezone = const Value.absent(),
  }) => BirthdaysTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    birthday: birthday ?? this.birthday,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    note: note.present ? note.value : this.note,
    relation: relation.present ? relation.value : this.relation,
    isFavorite: isFavorite.present ? isFavorite.value : this.isFavorite,
    timezone: timezone.present ? timezone.value : this.timezone,
  );
  BirthdaysTableData copyWithCompanion(BirthdaysTableCompanion data) {
    return BirthdaysTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      note: data.note.present ? data.note.value : this.note,
      relation: data.relation.present ? data.relation.value : this.relation,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BirthdaysTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('birthday: $birthday, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('note: $note, ')
          ..write('relation: $relation, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('timezone: $timezone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    birthday,
    photoUrl,
    phone,
    email,
    note,
    relation,
    isFavorite,
    timezone,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BirthdaysTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.birthday == this.birthday &&
          other.photoUrl == this.photoUrl &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.note == this.note &&
          other.relation == this.relation &&
          other.isFavorite == this.isFavorite &&
          other.timezone == this.timezone);
}

class BirthdaysTableCompanion extends UpdateCompanion<BirthdaysTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> birthday;
  final Value<String?> photoUrl;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> note;
  final Value<String?> relation;
  final Value<bool?> isFavorite;
  final Value<String?> timezone;
  final Value<int> rowid;
  const BirthdaysTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.birthday = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.note = const Value.absent(),
    this.relation = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BirthdaysTableCompanion.insert({
    required String id,
    required String name,
    required DateTime birthday,
    this.photoUrl = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.note = const Value.absent(),
    this.relation = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       birthday = Value(birthday);
  static Insertable<BirthdaysTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? birthday,
    Expression<String>? photoUrl,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? note,
    Expression<String>? relation,
    Expression<bool>? isFavorite,
    Expression<String>? timezone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (birthday != null) 'birthday': birthday,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (note != null) 'note': note,
      if (relation != null) 'relation': relation,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (timezone != null) 'timezone': timezone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BirthdaysTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? birthday,
    Value<String?>? photoUrl,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? note,
    Value<String?>? relation,
    Value<bool?>? isFavorite,
    Value<String?>? timezone,
    Value<int>? rowid,
  }) {
    return BirthdaysTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      photoUrl: photoUrl ?? this.photoUrl,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      note: note ?? this.note,
      relation: relation ?? this.relation,
      isFavorite: isFavorite ?? this.isFavorite,
      timezone: timezone ?? this.timezone,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (relation.present) {
      map['relation'] = Variable<String>(relation.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BirthdaysTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('birthday: $birthday, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('note: $note, ')
          ..write('relation: $relation, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('timezone: $timezone, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BirthdaysTableTable birthdaysTable = $BirthdaysTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [birthdaysTable];
}

typedef $$BirthdaysTableTableCreateCompanionBuilder =
    BirthdaysTableCompanion Function({
      required String id,
      required String name,
      required DateTime birthday,
      Value<String?> photoUrl,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> note,
      Value<String?> relation,
      Value<bool?> isFavorite,
      Value<String?> timezone,
      Value<int> rowid,
    });
typedef $$BirthdaysTableTableUpdateCompanionBuilder =
    BirthdaysTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> birthday,
      Value<String?> photoUrl,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> note,
      Value<String?> relation,
      Value<bool?> isFavorite,
      Value<String?> timezone,
      Value<int> rowid,
    });

class $$BirthdaysTableTableFilterComposer
    extends Composer<_$AppDatabase, $BirthdaysTableTable> {
  $$BirthdaysTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BirthdaysTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BirthdaysTableTable> {
  $$BirthdaysTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BirthdaysTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BirthdaysTableTable> {
  $$BirthdaysTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get relation =>
      $composableBuilder(column: $table.relation, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);
}

class $$BirthdaysTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BirthdaysTableTable,
          BirthdaysTableData,
          $$BirthdaysTableTableFilterComposer,
          $$BirthdaysTableTableOrderingComposer,
          $$BirthdaysTableTableAnnotationComposer,
          $$BirthdaysTableTableCreateCompanionBuilder,
          $$BirthdaysTableTableUpdateCompanionBuilder,
          (
            BirthdaysTableData,
            BaseReferences<
              _$AppDatabase,
              $BirthdaysTableTable,
              BirthdaysTableData
            >,
          ),
          BirthdaysTableData,
          PrefetchHooks Function()
        > {
  $$BirthdaysTableTableTableManager(
    _$AppDatabase db,
    $BirthdaysTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BirthdaysTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$BirthdaysTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BirthdaysTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> birthday = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> relation = const Value.absent(),
                Value<bool?> isFavorite = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BirthdaysTableCompanion(
                id: id,
                name: name,
                birthday: birthday,
                photoUrl: photoUrl,
                phone: phone,
                email: email,
                note: note,
                relation: relation,
                isFavorite: isFavorite,
                timezone: timezone,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required DateTime birthday,
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> relation = const Value.absent(),
                Value<bool?> isFavorite = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BirthdaysTableCompanion.insert(
                id: id,
                name: name,
                birthday: birthday,
                photoUrl: photoUrl,
                phone: phone,
                email: email,
                note: note,
                relation: relation,
                isFavorite: isFavorite,
                timezone: timezone,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BirthdaysTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BirthdaysTableTable,
      BirthdaysTableData,
      $$BirthdaysTableTableFilterComposer,
      $$BirthdaysTableTableOrderingComposer,
      $$BirthdaysTableTableAnnotationComposer,
      $$BirthdaysTableTableCreateCompanionBuilder,
      $$BirthdaysTableTableUpdateCompanionBuilder,
      (
        BirthdaysTableData,
        BaseReferences<_$AppDatabase, $BirthdaysTableTable, BirthdaysTableData>,
      ),
      BirthdaysTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BirthdaysTableTableTableManager get birthdaysTable =>
      $$BirthdaysTableTableTableManager(_db, _db.birthdaysTable);
}
