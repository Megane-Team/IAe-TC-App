import 'dart:convert';

import 'package:inventara/constants/variables.dart';
import 'package:inventara/main.dart';
import 'package:inventara/utils/sessions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<bool> loginAction(String email, String password) async {
  final fcmToken = await FirebaseMessaging.instance.getToken();

  final response = await App.api.post(apiBaseURl.resolve('/users/login'),
      body: jsonEncode({'email': email, 'password': password, 'deviceToken': fcmToken}),);

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    var responseBody = jsonDecode(response.body);
    // Use the response here

    await Session.set(responseBody['token']);

    return true;
  } else if (response.statusCode == 400) {
    return false;
  } else {
    // If the server returns an unexpected response, throw an error.
    throw Exception('Failed to login. Is internet connection available?');
  }
}
