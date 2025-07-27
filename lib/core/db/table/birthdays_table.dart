import 'package:drift/drift.dart';

class BirthdaysTable extends Table {
  TextColumn get id => text()(); // uuid
  TextColumn get name => text()();
  DateTimeColumn get birthday => dateTime()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get relation => text().nullable()();
  BoolColumn get isFavorite => boolean().nullable()();
  TextColumn get timezone => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
