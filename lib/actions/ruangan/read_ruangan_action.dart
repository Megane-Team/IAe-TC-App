import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/ruangan.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Ruangans>> readRuangan(String id) async {
  final token = await Session.getToken();

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

Future<List<Ruangans>> readRuanganbyId(String id) async {
  final token = await Session.getToken();

  final response = await App.api.get(
      apiBaseURl.resolve('/ruangans/$id'),
      headers: {'authorization': 'Bearer $token '});

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