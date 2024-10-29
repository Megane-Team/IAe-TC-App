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
      child: Container(
        padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                (Assets.logos('inventara')),
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masuk',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Masuk untuk melanjutkan',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
            const SizedBox(height: 40),
            const Text('Email'),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                fillColor: Colors.black54,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  // change the textfields border color to black54
                  borderSide: BorderSide(color: Colors.green),
                ),
                hintText: 'Masukkan email',
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Password'),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.black54,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  // change the textfields border color to black54
                  borderSide: BorderSide(color: Colors.green),
                ),
                hintText: 'Masukkan password',
                hintStyle: const TextStyle(color: Colors.black54),
                suffixIcon:
                    Image.asset(Assets.icons('Pshow'), width: 16, height: 16),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.orange,
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
