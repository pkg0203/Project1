//


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ku_q/loginpage.dart';

class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class EmailAuthenticationPage extends StatefulWidget {

  String email;
  String password;

  EmailAuthenticationPage({super.key, required this.email, required this.password});

  @override
  State<EmailAuthenticationPage> createState() => _EmailAuthenticationPageState();
}

class _EmailAuthenticationPageState extends State<EmailAuthenticationPage> {

  FirebaseAuth fireAuth = FirebaseAuth.instance;

  TextEditingController checkNumController = TextEditingController();

  String checkNum = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {Get.back();},
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.black)
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              child: ScrollConfiguration(
                  behavior: ScrollBehaviorWithoutGlow(),
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(width: double.infinity, child: Text("이메일 인증", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                          const SizedBox(height: 20),
                          const SizedBox(width: double.infinity, child: Text("KU Q&A의 서비스를 이용하기 위해서는 우선 이메일 인증이 필요합니다\n메일로 전송된 링크를 클릭하여 인증을 완료해주세요", style: TextStyle(fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 130),
                          SizedBox(
                              width: double.infinity,
                              height: 25,
                              child: Text("${widget.email}로 인증 링크를 발송합니다", style: const TextStyle(fontWeight: FontWeight.bold))
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: RawMaterialButton(
                                  onPressed: () {
                                    fireAuth.currentUser?.sendEmailVerification();
                                    fireAuth.signOut();
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Text('${widget.email}로 인증 링크를 발송했습니다. 인증을 마친 후 다시 로그인해주세요'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.offAll(const LogInPage()),
                                            child: const Text('로그인 페이지로 돌아가기')
                                          )
                                        ]
                                      );
                                    });
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  fillColor: const Color(0xFFFC896F),
                                  child: const Text("인증 링크 발송", overflow: TextOverflow.clip, textAlign: TextAlign.center,)
                              )
                          ),
                        ],
                      )
                  )
              )
          )
      ),
    );
  }
}
