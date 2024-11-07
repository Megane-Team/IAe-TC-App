import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:http/http.dart' as http;

Future<List<Tempat>> getTempat(String token) async {
  final response = await http
      .get(Uri.parse('$apiBaseURl/tempats'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    final List<Tempat> tempatList = data.map((item) => Tempat.fromJson(item)).toList();
    return tempatList;
  } else {
    throw Exception('Failed to get tempat. Is internet connection available?');
  }
}
