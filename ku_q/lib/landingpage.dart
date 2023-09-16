


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ku_q/loginpage.dart';

import 'mainpage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState() {

    Timer(const Duration(seconds: 1), () {
      Get.offAll(() => const LogInPage(), transition: Transition.fadeIn);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width*0.5,
          height: MediaQuery.of(context).size.width*0.5,
          child: const Center(child: Text("로고", textScaleFactor: 5,))
        )
      )

    );
  }
}
