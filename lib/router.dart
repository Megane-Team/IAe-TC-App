import 'package:go_router/go_router.dart';
import 'package:inventara/page/beranda.dart';
import 'package:inventara/page/login.dart';

final appRouter = GoRouter(initialLocation: '/Login', routes: [
  GoRoute(path: '/Login', builder: (context, state) => const Login()),
  GoRoute(path: '/Beranda', builder: (context, state) => const Beranda()),
]);
