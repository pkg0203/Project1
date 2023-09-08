


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

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  FirebaseAuth fireAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwCheckController = TextEditingController();

  String email = '';
  String pw = '';
  String pwCheck = '';

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
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ScrollConfiguration(
              behavior: ScrollBehaviorWithoutGlow(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(width: double.infinity, child: Text("KU Q&A 회원가입", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 30),
                    const SizedBox(width: double.infinity, child: Text("설명글....................................................................................................................................................................................", style: TextStyle(fontWeight: FontWeight.bold),)),
                    const SizedBox(height: 70),
                    const SizedBox(
                      width: double.infinity,
                      height: 25,
                      child: Text("사용하실 학교 메일을 입력해주세요", style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: emailController,
                              onChanged: (value) {
                                setState(() {
                                  email = value;
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
                                labelText: "메일주소"
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
                              child: const Text("중복확인", overflow: TextOverflow.clip, textAlign: TextAlign.center,)
                            )
                          )
                        )
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Text("✓사용할 수 있는 계정입니다!", style: TextStyle(color: Colors.green))
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(
                        width: double.infinity,
                        height: 25,
                        child: Text("사용하실 비밀번호를 입력해주세요", style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                    SizedBox(
                        height: 40,
                        child: TextField(
                          controller: pwController,
                          onChanged: (value) {
                            setState(() {
                              pw = value;
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
                              labelText: "비밀번호"
                          ),
                        )
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                        width: double.infinity,
                        height: 25,
                        child: Text("비밀번호 확인", style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                    SizedBox(
                        height: 40,
                        child: TextField(
                          controller: pwCheckController,
                          onChanged: (value) {
                            setState(() {
                              pwCheck = value;
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
                              labelText: "비밀번호 확인"
                          ),
                        )
                    ),
                    const SizedBox(height: 50),
                    const SizedBox(
                      width: double.infinity,
                      child: Text("약관 동의", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                    ),
                    Container(
                      // color: Colors.blue,
                      height: 150,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      width: double.infinity,
                      child: RawMaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          fillColor: const Color(0xFFFC896F),
                          child: const Text("이메일 인증하기", overflow: TextOverflow.clip, textAlign: TextAlign.center,)
                      ),
                    )
                  ],
                )
              )
            )
          )
        )
      ),
    );
  }
}
