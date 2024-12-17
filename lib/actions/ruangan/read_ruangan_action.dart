import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Ruangans>> readRuangan(BuildContext context) async {
  final token = await Session.getToken();

  if (token == null) {
    Session.unset();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go('login');
      }
    });
    throw Exception('Unauthorized');
  }

  final response = await App.api.get(apiBaseURl.resolve('/ruangans'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Ruangans> ruangans =
        data.map((item) => Ruangans.fromJson(item)).toList();

    return ruangans;
  } else {
    throw Exception('Failed to get ruangan. Is internet connection available?');
  }
}

Future<List<Ruangans>> readRuanganbyGedungId(
    String id, BuildContext context) async {
  final token = await Session.getToken();

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
      apiBaseURl.resolve('/tempats/$id/ruangans'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Ruangans> ruangans =
        data.map((item) => Ruangans.fromJson(item)).toList();

    return ruangans;
  } else {
    throw Exception('Failed to get ruangan. Is internet connection available?');
  }
}

Future<Ruangans?> readRuanganbyId(int id, BuildContext context) async {
  final token = await Session.getToken();

  if (token == null) {
    Session.unset();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go('login');
      }
    });
    throw Exception('Unauthorized');
  }

  final response = await App.api.get(apiBaseURl.resolve('/ruangans/$id'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return Ruangans.fromJson(data);
  } else if (response.statusCode == 404) {
    return null;
  } else {
    throw Exception('Failed to get ruangan. Is internet connection available?');
  }
}
