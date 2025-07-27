import 'package:get_it/get_it.dart';
import 'package:happiday/core/db/app_database.dart';

import '../../features/birthdays/data/repositories/birthday_repository_impl.dart';
import '../../features/birthdays/domain/repositories/birthday_repository.dart';
import '../../features/birthdays/domain/usecase/add_birthday_usecase.dart';
import '../../features/birthdays/domain/usecase/delete_birthday_usecase.dart';
import '../../features/birthdays/domain/usecase/get_all_birthdays_usecase.dart';
import '../../features/birthdays/domain/usecase/update_birthday_usecase.dart';
import '../../features/birthdays/presentation/bloc/birthdays_bloc.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecase/delete_all_birthdays_usecase.dart';
import '../../features/settings/presentation/cubit/delete_birthdays_cubit/delete_birthdays_cubit.dart';
import '../notifications/local_notification_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  sl.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(),
  );

  sl.registerLazySingleton<BirthdayRepository>(
    () => BirthdayRepositoryImpl(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<AddBirthdayUseCase>(
    () => AddBirthdayUseCase(sl<BirthdayRepository>()),
  );

  sl.registerLazySingleton<GetAllBirthdaysUseCase>(
    () => GetAllBirthdaysUseCase(sl<BirthdayRepository>()),
  );

  sl.registerLazySingleton<UpdateBirthdayUseCase>(
    () => UpdateBirthdayUseCase(sl<BirthdayRepository>()),
  );

  sl.registerLazySingleton<DeleteBirthdayUseCase>(
    () => DeleteBirthdayUseCase(sl<BirthdayRepository>()),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<DeleteAllBirthdaysUseCase>(
    () => DeleteAllBirthdaysUseCase(sl<SettingsRepository>()),
  );

  sl.registerFactory(
    () => DeleteBirthdaysCubit(sl<DeleteAllBirthdaysUseCase>()),
  );

  sl.registerFactory(
    () => BirthdaysBloc(
      sl<AddBirthdayUseCase>(),
      sl<GetAllBirthdaysUseCase>(),
      sl<UpdateBirthdayUseCase>(),
      sl<DeleteBirthdayUseCase>(),
      sl<LocalNotificationService>(),
      sl<SettingsRepository>(),
    ),
  );
}
