import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<List<Tempat>> readTempat() async {
  const secureStorage = FlutterSecureStorage();
  var token = await secureStorage.read(key: 'token');

  final response = await App.api.get(apiBaseURl.resolve('/tempats'),
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Tempat> tempats = data.map((item) => Tempat.fromJson(item)).toList();

    return tempats;
  } else {
    throw Exception('Failed to get tempat. Is internet connection available?');
  }
}