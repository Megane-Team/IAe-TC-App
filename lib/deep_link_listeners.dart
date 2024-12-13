import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/barang/read_barang_action.dart';
import 'package:inventara/actions/kendaraan/read_kendaraan_action.dart';
import 'package:inventara/actions/ruangan/read_ruangan_action.dart';
import 'package:inventara/actions/tempat/read_tempat_action.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/utils/sessions.dart';

class DeepLinkListener extends StatefulWidget {
  final Widget child;
  const DeepLinkListener({super.key, required this.child});

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  bool _initialLinkHandled = false;

  @override
  void initState() {
    super.initState();
    final appLinks = AppLinks();

    // Handle initial deep link
    appLinks.getInitialLink().then((uri) {
      if (uri != null && !_initialLinkHandled) {
        _handleDeepLink(uri);
        _initialLinkHandled = true;
      }
    });

    // Listen for deep link changes
    appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) async {
    log('Received deep link: ${uri.toString()}');
    final category = uri.pathSegments.firstOrNull;
    if (mounted) {
      var user = await Session.refresh();
      if (user != null) {
        context.go('/beranda');
      }
    }
    if (category == 'barang') {
      var id = uri.pathSegments.lastOrNull;
      if (id != null && mounted) {
        Barang barang = await readBarangbyId(id);
        Ruangans ruangan = await readRuanganbyId(barang.ruanganId, context);
        Tempat tempat = await readTempatbyId(ruangan.tempatId, context);
        int tempatId = tempat.id;
        if (mounted) {
          context.push('/gedung?id=$tempatId&rId=${ruangan.id}');
          if (ruangan.status != true) {
            if (mounted) {
              context
                  .push('/ruangan?id=${ruangan.id}&category=ruangan&index=$id');
            }
          }
        }
      }
    }
    if (category == 'kendaraan') {
      final id = uri.pathSegments.lastOrNull;
      if (id != null && mounted) {
        Kendaraan kendaraan = await readKendaraanbyId(id);
        Tempat tempat = await readTempatbyId(kendaraan.tempatId, context);
        int tempatId = tempat.id;
        if (mounted) {
          context.push('/ruangan?id=$tempatId&category=kendaraan&index=$id');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
