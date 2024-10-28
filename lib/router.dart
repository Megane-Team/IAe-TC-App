import 'package:go_router/go_router.dart';
import 'package:inventara/page/login.dart';

final appRouter = GoRouter(initialLocation: '/login', routes: [
  GoRoute(path: '/login', builder: (context, state) => const Login()),
]);
