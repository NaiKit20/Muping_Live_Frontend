import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipro/page/admin.dart';
import 'package:minipro/page/customer.dart';
import 'package:minipro/page/login.dart';
import 'package:minipro/povider/appdata.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Appdata(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 168, 128, 196),
          useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/customer': (context) => CustomerPage(),
        '/admin': (context) => AdminPage(),
      },
    );
  }
}
