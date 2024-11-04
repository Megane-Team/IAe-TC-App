import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:inventara/constants/variables.dart';

Future<bool> loginAction(String email, String password) async {
  final response = await http.post(
    Uri.parse('$apiBaseURl/auth/login'),
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final token = data['data']['token'];
    final user = data['data']['user'];

    const storageToken = FlutterSecureStorage();
    const storageUser = FlutterSecureStorage();

    await storageToken.write(key: 'token', value: token);
    await storageUser.write(key: 'user', value: jsonEncode(user));

    return true;
  } else if (response.statusCode == 401) {
    return false;
  } else {
    throw Exception('Failed to login. Is internet connection available?');
  }
}