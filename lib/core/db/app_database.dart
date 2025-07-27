import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'table/birthdays_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [BirthdaysTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<BirthdaysTableData>> getAllBirthdays() async {
    final list = await select(birthdaysTable).get();
    return list;
  }

  Future<int> insertBirthday(BirthdaysTableData birthday) {
    return into(birthdaysTable).insert(birthday);
  }

  Future<bool> updateBirthday(BirthdaysTableData birthday) {
    return update(birthdaysTable).replace(birthday);
  }

  Future<int> deleteBirthday(String id) {
    return (delete(birthdaysTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllBirthdays() {
    return delete(birthdaysTable).go();
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'app.sqlite'));
      return NativeDatabase(file);
    });
  }
}
