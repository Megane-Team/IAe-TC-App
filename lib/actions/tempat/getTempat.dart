import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/tempat.dart';

Future<List<Tempat>> getTempat(String token) async {
  final response = await App.api.get(apiBaseURl.resolve('/tempats'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    final List<Tempat> tempatList = data.map((item) => Tempat.fromJson(item)).toList();
    return tempatList;
  } else {
    throw Exception('Failed to get tempat. Is internet connection available?');
  }
}
