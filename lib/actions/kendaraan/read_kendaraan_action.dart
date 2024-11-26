import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Kendaraan>> readKendaraan(String id, BuildContext context) async {
  print('readKendaraan triggered');
  var token = await Session.getToken();

  if (token == null) {
    Session.unset();
    context.go('login');
    throw Exception('Unauthorized');
  }

  final response = await App.api.get(
      apiBaseURl.resolve('/tempats/$id/kendaraans'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Kendaraan> kendaraans =
        data.map((item) => Kendaraan.fromJson(item)).toList();

    return kendaraans;
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else {
    throw Exception(
        'Failed to get kendaraan. Is internet connection available?');
  }
}
