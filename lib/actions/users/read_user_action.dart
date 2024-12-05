import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/structures/user.dart';
import 'package:inventara/utils/sessions.dart';

Future<User?> readUser(String token) async {
  final response = await App.api.get(apiBaseURl.resolve('/users'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, then parse the JSON.
    return User.fromJson(jsonDecode(response.body)['data']);
  } else if (response.statusCode == 403 || response.statusCode == 404) {
    return null;
  } else {
    // If the server returns an unexpected response, throw an error.
    throw Exception('Failed to login');
  }
}

Future<User> readUserById(String id) async {
  var token = await Session.getToken();
  var response = await App.api.get(apiBaseURl.resolve('/users/$id'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    return User.fromJson(data);
  } else {
    throw Exception('Failed to get user. Is internet connection available?');
  }
}
