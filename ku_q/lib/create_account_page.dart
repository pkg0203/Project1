


import 'package:cloud_firestore/cloud_firestore.dart';
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

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwCheckController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();

  bool nickNameDupCheck = false;
  bool pwCheck = false;

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
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: emailController,
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
                        const Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                "@korea.ac.kr", style: TextStyle(fontSize: 18)
                              ),
                            )
                          )
                        )
                      ],
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
                          style: const TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w500),
                          controller: pwController,
                          cursorHeight: 20,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                              ),
                              labelText: "비밀번호"
                          ),
                          onChanged: (value) {
                            if (value == pwCheckController.text) {
                              setState(() {
                                pwCheck = true;
                              });
                            }
                            else {
                              setState(() {
                                pwCheck = false;
                              });
                            }
                          },
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
                          style: const TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w500),
                          controller: pwCheckController,
                          cursorHeight: 20,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                              ),
                              labelText: "비밀번호 확인"
                          ),
                          onChanged: (value) {
                            if (value == pwController.text) {
                              setState(() {
                                pwCheck = true;
                              });
                            }
                            else {
                              setState(() {
                                pwCheck = false;
                              });
                            }
                          },
                        )
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: pwCheck ? const Text("") : const Text("비밀번호가 일치하지 않습니다", style: TextStyle(color: Colors.red))
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                        width: double.infinity,
                        height: 25,
                        child: Text("사용하실 닉네임을 입력해주세요", style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                    SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: nickNameController,
                                onChanged: (value) {
                                  setState(() {
                                    nickNameDupCheck = false;
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
                                    labelText: "닉네임"
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RawMaterialButton(
                                onPressed: () {
                                  fireStore.collection('UserInfo').where('nickName', isEqualTo: nickNameController.text).get().then(
                                          (value) => value.docs.isNotEmpty ? {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {return const AlertDialog(title: Text("이미 사용 중인 닉네임입니다"));}),
                                                        setState(() {
                                                          nickNameDupCheck =
                                                              false;
                                                        })
                                                      }
                                                    : setState((){nickNameDupCheck = true;})
                                  );
                                },
                                fillColor: const Color(0xFFFC896F),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: const Center(child: Text("중복확인"))
                              )
                            )
                          ],
                        )
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: nickNameDupCheck ? const Text("✓사용 가능한 닉네임입니다!", style: TextStyle(color: Colors.green)) : const Text("ⓧ닉네임 중복 확인 해주세요!", style: TextStyle(color: Colors.red))
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
                          onPressed: () {
                            if (emailController.text.isEmpty) {
                              showDialog(context: context, builder: (context) {
                                return const AlertDialog(title: Text("메일 주소를 입력해주세요"));
                              });
                            }
                            else if (pwController.text.isEmpty) {
                              showDialog(context: context, builder: (context) {
                                return const AlertDialog(title: Text("사용하실 비밀번호를 입력해주세요"));
                              });
                            }
                            else if (!pwCheck) {
                              showDialog(context: context, builder: (context) {
                                return const AlertDialog(title: Text("비밀번호와 비밀번호 확인이 일치하지 않습니다"));
                              });
                            }
                            else if (nickNameController.text.isEmpty) {
                              showDialog(context: context, builder: (context) {
                                return const AlertDialog(title: Text("사용하실 닉네임을 입력해주세요"));
                              });
                            }
                            else if (!nickNameDupCheck) {
                              showDialog(context: context, builder: (context) {
                                return const AlertDialog(title: Text("닉네임 중복 확인해주세요!"));
                              });
                            }
                            else {_createUser('${emailController.text}@korea.ac.kr', pwController.text, nickNameController.text).then(
                                (msg) {
                                  if (msg == '회원가입에 성공했습니다! 이메일 인증 이후 원활한 앱 이용이 가능합니다') {
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
                                        actionsAlignment: MainAxisAlignment.center,
                                        title: Text(msg),
                                        actions: [SizedBox(
                                          width: double.infinity,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: const Color(0xFFFC896F),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                            ),
                                            child: const Text("로그인 화면으로 돌아가기", style: TextStyle(color: Colors.black)),
                                            onPressed: () {Get.offAll(() => const LogInPage());},
                                          ),
                                        )]
                                      );
                                    }, barrierDismissible: false);
                                  }
                                  else {
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                          title: Text(msg),
                                      );
                                    });
                                  }
                                }
                            );}
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          fillColor: const Color(0xFFFC896F),
                          child: const Text("회원 가입하기", overflow: TextOverflow.clip, textAlign: TextAlign.center,)
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

  Future<String> _createUser(String email, String pw, String nickName) async {
    String message = '';
    try {
      await fireAuth.createUserWithEmailAndPassword(email: email, password: pw).then(
          (newUser) {
            /* 가입 시 초기 설정 */
            newUser.user?.updateDisplayName(nickName);
            final newUserInfo = fireStore.collection('UserInfo').doc(newUser.user?.uid);
            newUserInfo.set({
              'nickName' : nickName,
              'point' : 300,
              'bookmarkedPosts' : []
            });
          }
      );
      message = '회원가입에 성공했습니다! 이메일 인증 이후 원활한 앱 이용이 가능합니다';
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        message = '이미 가입된 이메일입니다';
      }
      else if (e.code == 'invalid-email') {
        message = '적합하지 않은 이메일입니다';
      }
      else if (e.code == 'weak-password') {
        message = '비밀번호가 너무 약합니다';
      }
      else {
        message = '회원가입에 실패했습니다. error code: ${e.code}';
      }
    }
    return message;
  }
}
