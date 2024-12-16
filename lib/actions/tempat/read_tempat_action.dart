import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Tempat>> readTempat(BuildContext context) async {
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

  final response = await App.api.get(apiBaseURl.resolve('/tempats'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Tempat> tempats =
        data.map((item) => Tempat.fromJson(item)).toList();

    return tempats;
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to get tempat. Is internet connection available?');
  }
}

Future<Tempat?> readTempatbyId(int id, BuildContext context) async {
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

  final response = await App.api.get(apiBaseURl.resolve('/tempats/$id'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return Tempat.fromJson(data);
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else if (response.statusCode == 404) {
    return null;
  } else {
    throw Exception('Failed to get tempat. Is internet connection available?');
  }
}
