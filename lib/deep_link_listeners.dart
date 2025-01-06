import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/barang/read_barang_action.dart';
import 'package:inventara/actions/kendaraan/read_kendaraan_action.dart';
import 'package:inventara/actions/peminjaman/read_detail_peminjaman_action.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/router.dart';
import 'package:inventara/utils/sessions.dart';
import 'dart:async';

class DeepLinkListener extends StatefulWidget {
  final Widget child;
  final AppLinks appLinks;

  const DeepLinkListener(
      {super.key, required this.child, required this.appLinks});

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  bool _initialLinkHandled = false;
  StreamSubscription<Uri>? _uriSubscription;

  @override
  void initState() {
    super.initState();
    final appLinks = AppLinks();
    fetchData();

    void handleDeepLink(Uri uri) async {
      var user = await Session.refresh();
      if (user == null) {
        appRouter.go('/login');
        return;
      }
      appRouter.go('/beranda');

      final category = uri.pathSegments.firstOrNull;
      if (!mounted) return;

      if (category == 'barang') {
        var id = uri.pathSegments.lastOrNull;
        if (id != null && mounted) {
          var barang = await readBarangbyId(id);
          var ruangan = await readRuanganbyId(barang!.ruanganId, context);
          var tempat = await readTempatbyId(ruangan!.tempatId, context);
          int tempatId = tempat!.id;
          if (mounted) {
            appRouter.push('/gedung?id=$tempatId&rId=${ruangan.id}');
            if (mounted) {
              appRouter
                  .push('/ruangan?id=${ruangan.id}&category=ruangan&index=$id');
            }
          }
        }
      }

      if (category == 'kendaraan') {
        final id = uri.pathSegments.lastOrNull;
        if (id != null && mounted) {
          var kendaraan = await readKendaraanbyId(id);
          var tempat = await readTempatbyId(kendaraan!.tempatId, context);
          int tempatId = tempat!.id;
          if (mounted) {
            appRouter
                .push('/ruangan?id=$tempatId&category=kendaraan&index=$id');
          }
        }
      }

      if (category == 'ruangan') {
        final id = uri.pathSegments.lastOrNull;
        if (id != null && mounted) {
          var ruangan = await readRuanganbyId(int.parse(id), context);
          var tempat = await readTempatbyId(ruangan!.tempatId, context);
          int tempatId = tempat!.id;
          if (mounted) {
            appRouter.push('/gedung?id=$tempatId&rId=${ruangan.id}');
            if (mounted) {
              appRouter.push('/ruangan?id=${ruangan.id}&category=ruangan');
            }
          }
        }
      }
    }

    appLinks.getInitialLink().then((uri) {
      if (uri != null && !_initialLinkHandled) {
        handleDeepLink(uri);
        _initialLinkHandled = true;
      }
    });

    _uriSubscription = appLinks.uriLinkStream.listen((uri) {
      if (mounted) {
        handleDeepLink(uri);
      }
    });
  }

  @override
  void dispose() {
    _uriSubscription?.cancel();
    super.dispose();
  }

  void fetchData() async {
    await checkDetailPeminjamanItemsStatus();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
