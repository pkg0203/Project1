import 'package:flutter/material.dart';
import 'package:get/get.dart';
//
import 'landingpage.dart';
import 'package:firebase_core/firebase_core.dart';

bool isFirebaseReady = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().catchError((e) {
    isFirebaseReady = false;
    print(e);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(

      home: LandingPage(),
    );
  }
}
