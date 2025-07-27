import 'package:happiday/core/utils/extensions/drift_birthday.dart';

import '../../../../core/db/app_database.dart';
import '../../domain/entities/birthday.dart';
import '../../domain/repositories/birthday_repository.dart';

class BirthdayRepositoryImpl implements BirthdayRepository {
  final AppDatabase db;

  BirthdayRepositoryImpl(this.db);

  @override
  Future<List<Birthday>> getAllBirthdays() async {
    final list = await db.getAllBirthdays();
    return list.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> addBirthday(Birthday birthday) async {
    await db.insertBirthday(birthday.toDatabase());
  }

  @override
  Future<void> updateBirthday(Birthday birthday) async {
    await db.updateBirthday(birthday.toDatabase());
  }

  @override
  Future<void> deleteBirthday(String id) {
    return db.deleteBirthday(id);
  }
}
