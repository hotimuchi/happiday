import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happiday/features/birthdays/domain/usecase/get_all_birthdays_usecase.dart';

import '../../domain/entities/birthday.dart';
import '../../domain/usecase/add_birthday_usecase.dart';
import '../../domain/usecase/delete_birthday_usecase.dart';
import '../../domain/usecase/update_birthday_usecase.dart';
import 'package:happiday/core/notifications/local_notification_service.dart';
import 'package:happiday/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart';

part 'birthdays_event.dart';
part 'birthdays_state.dart';

class BirthdaysBloc extends Bloc<BirthdaysEvent, BirthdaysState> {
  final AddBirthdayUseCase addBirthdayUseCase;
  final GetAllBirthdaysUseCase getAllBirthdaysUsecase;
  final UpdateBirthdayUseCase updateBirthdayUseCase;
  final DeleteBirthdayUseCase deleteBirthdayUseCase;
  final LocalNotificationService notificationService;
  final SettingsRepository settingsRepository;

  BirthdaysBloc(
    this.addBirthdayUseCase,
    this.getAllBirthdaysUsecase,
    this.updateBirthdayUseCase,
    this.deleteBirthdayUseCase,
    this.notificationService,
    this.settingsRepository,
  ) : super(BirthdaysInitial()) {
    on<LoadBirthdays>((event, emit) async {
      emit(BirthdaysLoading());
      try {
        final list = await getAllBirthdaysUsecase();
        emit(BirthdaysLoaded(list));
      } catch (e) {
        emit(BirthdaysError(e.toString()));
      }
    });

    on<AddBirthday>((event, emit) async {
      if (state is BirthdaysLoaded) {
        await addBirthdayUseCase(event.birthday);
        // Получить время уведомления из настроек
        final notifTime =
            await settingsRepository.getNotificationTime() ??
            const TimeOfDay(hour: 9, minute: 0);
        await notificationService.scheduleBirthdayNotifications(
          eventId: event.birthday.id,
          name: event.birthday.name,
          date: event.birthday.birthday,
          time: notifTime,
        );
        add(LoadBirthdays());
      }
    });

    on<SearchBirthdays>((event, emit) async {
      emit(BirthdaysLoading());
      try {
        final all = await getAllBirthdaysUsecase();
        final filtered =
            all
                .where(
                  (b) =>
                      b.name.toLowerCase().contains(event.query.toLowerCase()),
                )
                .toList();
        emit(BirthdaysLoaded(filtered));
      } catch (e) {
        emit(BirthdaysError(e.toString()));
      }
    });

    on<UpdateBirthday>((event, emit) async {
      if (state is BirthdaysLoaded) {
        await updateBirthdayUseCase(event.birthday);
        final notifTime =
            await settingsRepository.getNotificationTime() ??
            const TimeOfDay(hour: 9, minute: 0);
        await notificationService.scheduleBirthdayNotifications(
          eventId: event.birthday.id,
          name: event.birthday.name,
          date: event.birthday.birthday,
          time: notifTime,
        );
        add(LoadBirthdays());
      }
    });

    on<DeleteBirthday>((event, emit) async {
      if (state is BirthdaysLoaded) {
        await notificationService.cancelBirthdayNotifications(event.id);
        await deleteBirthdayUseCase(event.id);
        add(LoadBirthdays());
      }
    });
  }
}
