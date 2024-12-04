import 'package:go_router/go_router.dart';
import 'package:inventara/page/gedung.dart';
import 'package:inventara/page/beranda.dart';
import 'package:inventara/page/konfirmasi_kendaraan.dart';
import 'package:inventara/page/login.dart';
import 'package:inventara/page/ruangan.dart';
import 'package:inventara/page/keranjang.dart';
import 'package:inventara/page/riwayat.dart';
import 'package:inventara/page/notifikasi.dart';
import 'package:inventara/page/konfirmasi_asset.dart';
import 'package:inventara/page/cari.dart';

final appRouter = GoRouter(initialLocation: '/Login', routes: [
  GoRoute(path: '/Login', builder: (context, state) => const Login()),
  GoRoute(path: '/Beranda', builder: (context, state) => const Beranda()),
  GoRoute(path: '/Riwayat', builder: (context, state) => const Riwayat()),
  GoRoute(path: '/Notifikasi', builder: (context, state) => const Notifikasi()),
  GoRoute(path: '/KonfA', builder: (context, state) => const Konfirmasiasset()),
  GoRoute(
      path: '/KonfK', builder: (context, state) => const Konfirmasikendaraan()),
  GoRoute(path: '/Cari', builder: (context, state) => const Cari()),
  GoRoute(path: '/Keranjang', builder: (context, state) => const Keranjang()),
  GoRoute(
      path: '/Gedung',
      builder: (context, state) => Gedung(
            id: state.uri.queryParameters['id'] ?? '',
          )),
  GoRoute(
      path: '/Ruangan',
      builder: (context, state) => Ruangan(
            id: state.uri.queryParameters['id'] ?? '',
            category: state.uri.queryParameters['category'] ?? '',
          )),
]);
