
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Post 컬렉션 내 writerUid의 값을 이용해 해당 유저의 정보를 받아오는 메소드
  // 닉네임 변경 가능성 때문에 uid(불변)를 이용해 닉네임을 매번 받아와야 함
  // 조금 비효율적인 방식같음... 후에 개선 여지

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.docData['name'], style: TextStyle(color: Colors.black),),
    );
  }
}