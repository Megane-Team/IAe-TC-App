import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Barang>> readBarang(String id, BuildContext context) async {
  var token = await Session.getToken();

  if (token == null) {
    Session.unset();
    context.go('login');
    throw Exception('Unauthorized');
  }

  final response = await App.api.get(
      apiBaseURl.resolve('/barangs/$id'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Barang> barangs =
    data.map((item) => Barang.fromJson(item)).toList();

    return barangs;
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to get barang. Is internet connection available?');
  }
}

Future<List<Barang>> readBarangFromRuanganId(String id, BuildContext context) async {
  var token = await Session.getToken();

  if (token == null) {
    Session.unset();
    context.go('login');
    throw Exception('Unauthorized');
  }

  final response = await App.api.get(
      apiBaseURl.resolve('/ruangans/$id/barangs'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Barang> barangs =
        data.map((item) => Barang.fromJson(item)).toList();

    return barangs;
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to get barang. Is internet connection available?');
  }
}
