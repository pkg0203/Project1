


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ku_q/create_account_page.dart';
import 'package:ku_q/email_authentication_page.dart';

import 'mainpage.dart';

class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  String email = '';
  String pw = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {FocusManager.instance.primaryFocus?.unfocus();},
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ScrollConfiguration(
            behavior: ScrollBehaviorWithoutGlow(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: const Center(child: Text("로고", style: TextStyle(fontSize: 30)))
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: 35,
                        margin: const EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: emailController,
                          maxLength: 16,
                          maxLines: 1,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            counterText: "",
                            labelText: "이메일을 입력해주세요"
                          ),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          }
                        )
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 35,
                        child: const Center(child: Text("@korea.ac.kr", style: TextStyle(fontSize: 16)))
                      )
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 35,
                      margin: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: pwController,
                        maxLength: 16,
                        maxLines: 1,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                            ),
                          counterText: "",
                          labelText: "비밀번호를 입력해주세요"
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            pw = value;
                          });
                        }
                      )
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 35,
                      margin: const EdgeInsets.only(top: 20),
                      child: RawMaterialButton(
                        onPressed: () {
                          if (emailController.text.isEmpty) {
                            showDialog(context: context, builder: (context) {return const AlertDialog(title: Text("이메일을 입력해주세요"));});
                          }
                          else if (pwController.text.isEmpty) {
                            showDialog(context: context, builder: (context) {return const AlertDialog(title: Text("비밀번호를 입력해주세요"));});
                          }
                          else {
                            _login();
                          }
                        },
                        fillColor: const Color(0xFFFC896F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text("로그인", style: TextStyle(fontSize: 20))
                      )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {Get.to(() => const CreateAccountPage(), transition: Transition.rightToLeft);},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black
                          ),
                          child: const Text("회원가입 >"),
                        ),
                        TextButton(
                          onPressed: () {  },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black
                          ),
                          child: const Text("ID/PW 찾기 >")
                        )
                      ]
                    ),
                  )
                ]
              ),
            ),
          ),
        )
      ),
    );
  }

  _login() async {
    try{
      await fireAuth.signInWithEmailAndPassword(
        email: '${emailController.text}@korea.ac.kr',
        password: pwController.text
      );

      if (fireAuth.currentUser!.emailVerified) {
        Get.offAll(const MainPage());
      }
      else {
        Get.to(() => EmailAuthenticationPage(email: email, password: pw));
      }
    }
    on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = '등록되지 않은 이메일입니다.';
      } else if (e.code == 'wrong-password') {
        message = '비밀번호가 일치하지 않습니다.';
      } else if (e.code == 'invalid-email') {
        message = '유효하지 않은 이메일입니다';
      }
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text(message)
        );
      });
    }
  }

}
