import 'package:flutter/material.dart';
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
import 'package:inventara/page/detail_peminjaman.dart';

final appRouter = GoRouter(initialLocation: '/Login', routes: [
  GoRoute(path: '/Login', builder: (context, state) => const Login()),
  GoRoute(path: '/Beranda', builder: (context, state) => const Beranda()),
  GoRoute(path: '/Riwayat', builder: (context, state) => const Riwayat()),
  GoRoute(
      path: '/Notifikasi',
      builder: (context, state) {
        final refreshData = state.extra as VoidCallback;
        return Notifikasi(onRefresh: refreshData);
      }),
  GoRoute(
      path: '/DetailP',
      builder: (context, state) => DetailPeminjaman(
            dpId: int.parse(state.uri.queryParameters['id']!),
          )),
  GoRoute(
      path: '/KonfA',
      builder: (context, state) => Konfirmasiasset(
            id: state.uri.queryParameters['id']!,
            category: state.uri.queryParameters['category']!,
          )),
  GoRoute(
      path: '/KonfK',
      builder: (context, state) => Konfirmasikendaraan(
            id: state.uri.queryParameters['id']!,
            category: state.uri.queryParameters['category']!,
          )),
  GoRoute(
      path: '/Cari',
      builder: (context, state) => Cari(
            id: int.parse(state.uri.queryParameters['id']!),
            isRuangan: bool.parse(state.uri.queryParameters['isRuangan']!),
          )),
  GoRoute(path: '/Keranjang', builder: (context, state) => const Keranjang()),
  GoRoute(
      path: '/Gedung',
      builder: (context, state) => Gedung(
            id: state.uri.queryParameters['id']!,
            rId: int.parse(state.uri.queryParameters['rId'] ?? '0'),
          )),
  GoRoute(
      path: '/Ruangan',
      builder: (context, state) => Ruangan(
            id: state.uri.queryParameters['id']!,
            category: state.uri.queryParameters['category']!,
            index: int.parse(state.uri.queryParameters['index'] ?? '0'),
          )),
]);
