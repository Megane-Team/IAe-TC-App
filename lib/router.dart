import 'package:go_router/go_router.dart';
import 'package:inventara/page/gedung.dart';
import 'package:inventara/page/beranda.dart';
import 'package:inventara/page/login.dart';
import 'package:inventara/page/ruangan.dart';
import 'package:inventara/page/keranjang.dart';
import 'package:inventara/page/riwayat.dart';
import 'package:inventara/page/notifikasi.dart';

final appRouter = GoRouter(initialLocation: '/Login', routes: [
  GoRoute(path: '/Login', builder: (context, state) => const Login()),
  GoRoute(path: '/Beranda', builder: (context, state) => const Beranda()),
  GoRoute(path: '/Riwayat', builder: (context, state) => const Riwayat()),
  GoRoute(path: '/Notifikasi', builder: (context, state) => const Notifikasi()),
  GoRoute(
      path: '/Gedung',
      builder: (context, state) => Gedung(
            name: state.uri.queryParameters['name'] ?? '',
            id: state.uri.queryParameters['id'] ?? '',
          )),
  GoRoute(
      path: '/Ruangan',
      builder: (context, state) => Ruangan(
            name: state.uri.queryParameters['name'] ?? '',
            id: state.uri.queryParameters['id'] ?? '',
          )),
  GoRoute(path: '/Keranjang', builder: (context, state) => const Keranjang()),
]);
