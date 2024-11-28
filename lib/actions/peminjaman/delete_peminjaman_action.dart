import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/utils/sessions.dart';

Future<bool> deletePeminjaman(int id) async {
  var token = await Session.getToken();

  var response = await App.api.delete(
      apiBaseURl.resolve('/peminjaman'),
      body: jsonEncode(
          {'id': id}
      ),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception(
        'Failed to delete peminjaman. Is internet connection available?');
  }
}