
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:ku_q/question_answer_page.dart';

class UserProfile extends StatefulWidget {

  DocumentSnapshot<Object?> docData;

  UserProfile({super.key, required this.docData});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Post 컬렉션 내 writerUid의 값을 이용해 해당 유저의 정보를 받아오는 메소드
  // 닉네임 변경 가능성 때문에 uid(불변)를 이용해 닉네임을 매번 받아와야 함
  // 조금 비효율적인 방식같음... 후에 개선 여지

  @override
  Widget build(BuildContext context) {
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
                      '김다빈',
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
                    child: Text(
                      'dajulie',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
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
                      '환경생태공학부',
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
                    child: Text(
                      '안녕하세요, 저는 다빈입니다!',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}