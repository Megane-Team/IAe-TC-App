import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/structure/tempat.dart';
import 'package:http/http.dart' as http;

Future<Tempat?> getTempat(String Token) async {
  final response = await http.get(
    Uri.parse('$apiBaseURl/tempat'),
    // send a token as authorization bearer
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $Token',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final tempat = Tempat.fromJson(data);

    return tempat;
  } else {
    throw Exception('Failed to get tempat. Is internet connection available?');
  }
}