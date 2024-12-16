import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/barang.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Barang>> readBarang(BuildContext context) async {
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

  final response = await App.api.get(apiBaseURl.resolve('/barangs'),
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

Future<Barang?> readBarangbyId(String id) async {
  var token = await Session.getToken();

  final response = await App.api.get(apiBaseURl.resolve('/barangs/$id'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return Barang.fromJson(data);
  } else if (response.statusCode == 404) {
    return null;
  } else {
    throw Exception('Failed to get barang. Is internet connection available?');
  }
}

Future<List<Barang>> readBarangbyRuanganId(
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
