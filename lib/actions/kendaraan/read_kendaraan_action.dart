import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/kendaraan.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Kendaraan>> readKendaraan(BuildContext context) async {
  var token = await Session.getToken();

  if (token == null) {
    Session.unset();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go('login');
      }
    });
    throw Exception('Unauthorized');
  }

  final response = await App.api.get(apiBaseURl.resolve('/kendaraans'),
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

Future<Kendaraan?> readKendaraanbyId(String id) async {
  var token = await Session.getToken();

  final response = await App.api.get(apiBaseURl.resolve('/kendaraans/$id'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return Kendaraan.fromJson(data);
  } else if (response.statusCode == 404) {
    return null;
  } else {
    throw Exception(
        'Failed to get kendaraan. Is internet connection available?');
  }
}

Future<List<Kendaraan>> readKendaraanByGedungId(
    String id, BuildContext context) async {
  var token = await Session.getToken();

  if (token == null) {
    Session.unset();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go('login');
      }
    });
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
