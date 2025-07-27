import 'package:go_router/go_router.dart';

import '../features/birthdays/presentation/pages/birthdays_page.dart';

final GoRouter appRoutes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const BirthdaysPage()),
    GoRoute(
      path: '/birthdays',
      builder: (context, state) => const BirthdaysPage(),
    ),
  ],
);
