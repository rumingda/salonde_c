import 'package:flutter/material.dart';
import 'package:salondec/menu/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:salondec/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Salon de Chungdam",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'Abhaya Libre',
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
            iconTheme: IconThemeData(color: Colors.black),
          )),
      home: const LoginScreen(),
      //home: MainPage(title: "home",),
    );
  }
}
