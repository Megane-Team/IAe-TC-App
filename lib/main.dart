import 'package:flutter/material.dart';
import 'package:inventara/constants/themes.dart';
import 'package:inventara/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Inventara',
      routerConfig: appRouter,
      theme: mainTheme,
    );
  }
}
