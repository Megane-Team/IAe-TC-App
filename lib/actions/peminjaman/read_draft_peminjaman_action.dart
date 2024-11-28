import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/peminjaman.dart';
import 'package:inventara/utils/sessions.dart';

Future<List<Peminjaman>> readDraftPeminjaman() async {
  var token = await Session.getToken();

  var response = await App.api.get(apiBaseURl.resolve('/peminjaman/draft'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> data = responseData['data'];
    final List<Peminjaman> peminjaman =
        data.map((item) => Peminjaman.fromJson(item)).toList();

    return peminjaman;
  } else {
    throw Exception(
        'Failed to get draft peminjaman. Is internet connection available?');
  }
}
