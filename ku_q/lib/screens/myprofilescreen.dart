import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ku_q/cards/userprofile.dart';

class MyProfileScreen extends StatefulWidget {
  //const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

CollectionReference users = FirebaseFirestore.instance.collection('UserInfo');

Future<void> updateUser(nicknamechange) {
  return users
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .update({'nickName': nicknamechange})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //dynamic data;
/*
  Future<dynamic> getData() async {

    final document = fireStore.collection("UserInfo").doc('p2iuraG7h5Z77GLyTyIDOmxXpAo2').get();

    await document.then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
  }
  */
  Future getUserInfo() async {
    final info = await fireStore.collection('UserInfo').doc(FirebaseAuth.instance.currentUser?.uid).get();
    return info;
  }

  TextEditingController nickController = TextEditingController();
  String nicknamechange = "";

  TextEditingController introController = TextEditingController();
  String introchange = "";

  @override
  void initState() {

    super.initState();
    getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            '프로필 수정',
            style:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("변경하시겠습니까?"),
                        insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                        actions: [
                          TextButton(
                            child: const Text('확인'),
                            onPressed: () {
                              updateUser(nicknamechange);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                );
              },
              child: Text(
                '완료',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: FutureBuilder(
                    future: getUserInfo(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                        ),
                                        color: Colors.black26,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /*
                                        OutlinedButton.icon(
                                          onPressed: null,
                                          icon: Text(
                                            '캐릭터 변경',
                                            style: TextStyle(fontSize: 13, color: Colors.blue),
                                          ),
                                          label: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 10,
                                            color: Colors.blue,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(20))),
                                              side: BorderSide(color: Colors.blue)),
                                        )
                                        */
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '이름',
                                        style: TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsetsDirectional.only(top: 5),
                                        width: 300,
                                        height: 50,
                                        child: Text(
                                          snapshot.data['name'],
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black12),
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '닉네임',
                                        style: TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsetsDirectional.only(top: 5),
                                        width: 200,
                                        height: 50,
                                        child: TextField(
                                          controller: nickController,
                                          onChanged: (value) {
                                            setState(() {
                                              nicknamechange = value;
                                            });
                                          },
                                          textAlign: TextAlign.left,
                                          textAlignVertical: TextAlignVertical.center,
                                          style: const TextStyle(fontSize: 15),
                                          decoration: InputDecoration(
                                              hintText: snapshot.data['nickName'],
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding: const EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                  borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black)
                                              )
                                          ),
                                        ),
                                        /*
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        */
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      OutlinedButton(
                                        onPressed: null,
                                        child: Text(
                                          '중복 확인',
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.black12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '대학',
                                        style: TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsetsDirectional.only(top: 5),
                                        width: 300,
                                        height: 50,
                                        child: Text(
                                          '고려대학교',
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black12),
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '학과/전공',
                                        style: TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsetsDirectional.only(top: 5),
                                        width: 300,
                                        height: 50,
                                        child: Text(
                                          snapshot.data['major'],
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black12),
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '한줄 소개',
                                        style: TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsetsDirectional.only(top: 5),
                                        width: 300,
                                        height: 50,
                                        child: TextField(
                                          controller: introController,
                                          onChanged: (value) {
                                            setState(() {
                                              introchange = value;
                                            });
                                          },
                                          textAlign: TextAlign.left,
                                          textAlignVertical: TextAlignVertical.center,
                                          style: const TextStyle(fontSize: 15),
                                          decoration: InputDecoration(
                                              hintText: snapshot.data['intro'],
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding: const EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                  borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black)
                                              )
                                          ),
                                        ),
                                        /*
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        */
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        /*
        Column(
          children: [
            Text('이름'),
            Container(
              color: Colors.black12,
              child: Text('김다빈'),
            )
          ],
        ),
        */
      ),
    );
  }
}

class OutlineCircleButton extends StatelessWidget {
  OutlineCircleButton({
    Key? key,
    this.onTap,
    this.borderSize = 0.5,
    this.radius = 20.0,
    this.borderColor = Colors.black26,
    this.foregroundColor = Colors.black26,
    this.child,
  }) : super(key: key);

  final onTap;
  final radius;
  final borderSize;
  final borderColor;
  final foregroundColor;
  final child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderSize),
          color: foregroundColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              child: child ?? SizedBox(),
              onTap: () async {
                if (onTap != null) {
                  onTap();
                }
              }),
        ),
      ),
    );
  }
}
