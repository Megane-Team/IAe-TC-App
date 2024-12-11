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
  void sessionChecker() async {
    var user = await Session.refresh();

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/login');
        }
      });
    }
  }

  @override
  void initState() {
    sessionChecker();

    final appLinks = AppLinks();

    appLinks.uriLinkStream.listen((uri) async {
      log('Received deep link: ${uri.toString()}');
      final category = uri.pathSegments.firstOrNull;
      if (mounted) {
        context.go('/beranda');
      }
      if (category == 'barang' && mounted) {
        var id = uri.pathSegments.lastOrNull;
        if (id != null && mounted) {
          Barang barang = await readBarangbyId(id);
          Ruangans ruangan = await readRuanganbyId(barang.ruanganId, context);
          Tempat tempat = await readTempatbyId(ruangan.tempatId, context);
          int tempatId = tempat.id;
          if (mounted) {
            context.push('/gedung?id=$tempatId');
            if(mounted) {
              context.push('/ruangan?id=$tempatId&category=ruangan&index=$id');
            }
          }
        }
      }
      if (category == 'kendaraan' && mounted){
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

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}