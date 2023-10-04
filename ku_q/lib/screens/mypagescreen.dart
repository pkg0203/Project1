import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ku_q/bookmarked_posts_page.dart';
import 'package:ku_q/cards/userprofile.dart';
import 'package:ku_q/mainpage.dart';
import 'package:ku_q/screens/myprofilescreen.dart';
import 'package:ku_q/screens/settings.dart';
import 'package:get/get.dart';

//import 'package:ku_q/my_flutter_app_icons.dart';
//
class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //static const int _pageSize = 2;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            '마이페이지',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserSettings()));
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black12,
                      width: 0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          OutlineCircleButton(
                              child: Icon(
                                Icons.person_outline,
                                size: 120,
                              ),
                              radius: 120.0,
                              borderSize: 0.5,
                              onTap: null),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 25,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyProfileScreen()));
                              },
                              icon: Text(
                                '내 프로필 관리',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              label: Icon(
                                Icons.arrow_right_alt,
                                color: Colors.black,
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                    width: 2, color: Colors.white),
                                //minimumSize: Size(100, 20),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            margin: EdgeInsets.only(top: 3),
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white,
                                width: 0,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '닉네임',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                Text(
                                  '전공',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            margin: const EdgeInsets.symmetric(vertical: 0),
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white,
                                width: 0,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '나의 포인트',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'NNN냥',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                /*
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 25,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      //Get.offAll(() => _MainPage);
                                      //Get.to(MainPage(), arguments: 0);
                                      //Get.offAll(() => PointShopScreen());
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => PointShopScreen()));
                                    },
                                    icon: Text(
                                      '포인트샵 가기',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    label: Icon(
                                      Icons.arrow_right_alt,
                                      color: Colors.black,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      backgroundColor: Color(0xFFFC896F),
                                      side: const BorderSide(
                                          width: 0, color: Colors.black26),
                                      minimumSize: Size(100, 20),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                */
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "나의 등급",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: null,
                        child: Icon(
                          Icons.question_mark_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black12,
                      width: 0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '등급',
                            style: TextStyle(fontSize: 12),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 40,
                            child: OutlinedButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.check,
                                color: Color(0xFFFC896F),
                              ),
                              label: Text(
                                '고양이 %d 마리',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                    width: 2, color: Colors.white),
                                minimumSize: Size(140, 40),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '누적 채택 수',
                            style: TextStyle(fontSize: 12),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 40,
                            child: OutlinedButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.touch_app_outlined,
                                color: Color(0xFFFC896F),
                              ),
                              label: Text(
                                '채택 N회',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                    width: 2, color: Colors.white),
                                minimumSize: Size(140, 40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: null,
                        icon: Icon(
                          Icons.star_border_rounded,
                          color: Colors.black,
                        ),
                        label: Text(
                          "나의 질문",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TextButton(
                        onPressed: null,
                        child: const Text(">",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: null,
                        icon: Icon(
                          Icons.question_mark,
                          color: Colors.black,
                        ),
                        label: Text(
                          "나의 답변",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TextButton(
                        onPressed: null,
                        child: const Text(">",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarkedPostsPage(bookmarkedPostKeys: bookmarkedPostKeys)));
                        },
                        icon: Icon(
                          Icons.question_answer_outlined,
                          color: Colors.black,
                        ),
                        label: Text(
                          "내가 스크랩한 글",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TextButton(
                        onPressed: null,
                        child: const Text(">",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: null,
                        icon: Icon(
                          Icons.person_add_alt_1_outlined,
                          color: Colors.black,
                        ),
                        label: Text(
                          "친구 초대",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TextButton(
                        onPressed: null,
                        child: const Text(">",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      )
                    ],
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ),
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
