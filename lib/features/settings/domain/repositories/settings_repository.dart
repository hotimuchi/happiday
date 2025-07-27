import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<void> deleteAllBirthdays();

  Future<void> saveNotificationTime(TimeOfDay time);
  Future<TimeOfDay?> getNotificationTime();
}
