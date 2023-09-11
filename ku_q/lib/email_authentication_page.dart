


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  String nickName;

  EmailAuthenticationPage({super.key, required this.email, required this.password, required this.nickName});

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
                          const SizedBox(height: 150),
                          SizedBox(
                              width: double.infinity,
                              height: 25,
                              child: Text("${widget.email}로 인증번호를 발송합니다", style: const TextStyle(fontWeight: FontWeight.bold))
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: RawMaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  fillColor: const Color(0xFFFC896F),
                                  child: const Text("인증번호 발송", overflow: TextOverflow.clip, textAlign: TextAlign.center,)
                              )
                          ),
                          const SizedBox(height: 80),
                          const SizedBox(
                              width: double.infinity,
                              height: 25,
                              child: Text("인증번호를 입력해주세요", style: TextStyle(fontWeight: FontWeight.bold))
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                      height: 40,
                                      child: TextField(
                                        controller: checkNumController,
                                        onChanged: (value) {
                                          setState(() {
                                            checkNum = value;
                                          });
                                        },
                                        cursorHeight: 20,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.black12,
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(15),
                                                borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                            ),
                                            labelText: "인증번호"
                                        ),
                                      )
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 40,
                                      child: RawMaterialButton(
                                          onPressed: () {},
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                          fillColor: const Color(0xFFFC896F),
                                          child: const Text("인증하기", overflow: TextOverflow.clip, textAlign: TextAlign.center,)
                                      )
                                  )
                              )
                            ],
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
