import 'package:flutter/material.dart';
import 'package:inventara/utils/assets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Positioned(child: Image.asset(Assets.logos('inventara')))
          ],
        ),
      )
    );
  }
}
