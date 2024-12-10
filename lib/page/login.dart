import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventara/actions/login_action.dart';
import 'package:inventara/utils/assets.dart';
import 'package:inventara/utils/sessions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  late bool showPassword = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sessionChecker();
  }

  void sessionChecker() async {
    var user = await Session.refresh();

    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/beranda');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 32),
        child: Column(
          children: [
            Image.asset(
              Assets.logos('inventara'),
              height: 250,
              width: 250,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Masuk',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Masuk untuk melanjutkan',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 48),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.black54,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black54),
                            floatingLabelStyle:
                                TextStyle(color: Colors.black54),
                            hintText: 'Masukkan email',
                            hintStyle: TextStyle(color: Colors.black54),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _passwordController,
                          cursorColor: Colors.black54,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle:
                                  const TextStyle(color: Colors.black54),
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.black54),
                              hintText: 'Masukkan Password',
                              hintStyle: const TextStyle(color: Colors.black54),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var login = await loginAction(
                            _emailController.text, _passwordController.text);

                        if (login != true) {
                          AlertDialog(
                            title: const Text('Gagal'),
                            content: const Text('Email atau password salah'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text('OK'),
                              )
                            ],
                          );
                        } else {
                          context.go('/beranda');
                        }
                      }
                    },
                    child: const Text('Masuk',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
