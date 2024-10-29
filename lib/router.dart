import 'package:go_router/go_router.dart';
import 'package:inventara/page/beranda.dart';
import 'package:inventara/page/login.dart';

final appRouter = GoRouter(initialLocation: '/beranda', routes: [
  GoRoute(path: '/beranda', builder: (context, state) => const Beranda()),
]);
