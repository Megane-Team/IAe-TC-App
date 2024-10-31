import 'package:go_router/go_router.dart';
import 'package:inventara/page/gedung.dart';
import 'package:inventara/page/login.dart';

final appRouter = GoRouter(initialLocation: '/gedung', routes: [
  GoRoute(path: '/gedung', builder: (context, state) => const Gedung()),
]);
