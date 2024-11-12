import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/tempat.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Tempat>> readTempat() async {
  final token = await Session.getToken();

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
