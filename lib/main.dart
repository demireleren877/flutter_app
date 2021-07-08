import 'package:deneme/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KayitUygulama(),
      themeMode: ThemeMode.system,
      theme: ThemeData(brightness: Brightness.light, accentColor: Colors.blue),
      darkTheme: ThemeData(
          brightness: Brightness.dark, accentColor: Colors.amber[700]),
    ),
  );
}

class KayitUygulama extends StatelessWidget {
  const KayitUygulama({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return loginpage();
  }
}
