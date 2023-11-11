import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prova_flutter/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prova Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 46, 146, 138)),
        //modelagem de design baseada no materialApp 3
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
