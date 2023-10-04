import 'dart:ffi';
//
import 'package:flutter/material.dart';
import 'package:ku_q/screens/mypagescreen.dart';
import 'package:get/get.dart';
//import 'package:ku_q/icons/my_flutter_app_icons.dart';
import 'package:ku_q/cards/charactercard.dart';

class AlarmSettings extends StatefulWidget {
  const AlarmSettings({super.key});

  @override
  State<AlarmSettings> createState() => _AlarmSettings();
}

class _AlarmSettings extends State<AlarmSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.backspace_outlined, color: Colors.black,),
        ),
        title: Text(
          '알림 설정',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Square1(),
                Square2(),
                Square3(),
                Square4(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class Square1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      margin: EdgeInsets.all(10.0),
      //height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '기본 알림',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '답변이 등록되었을 때',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '등록된 답변이 수정되었을 때',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '답변이 채택되었을 때',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Square2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      margin: EdgeInsets.all(10.0),
      //height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1:1 질문',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '1:1 질문이 신청되었을 때',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '1:1 질문에 대한 답변이 등록되었을 때',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '1:1 질문이 반려되었을 때',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Square3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      margin: EdgeInsets.all(10.0),
      //height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '등급/명예의 전당',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '등급이 변경되었을 때',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '명예의 전당에 등극했을 때',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Square4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      margin: EdgeInsets.all(10.0),
      //height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '스페셜 알림',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '공지사항',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '이번주 꿀팁 모음 알림',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '이벤트/포인트샵 알림',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '로그아웃',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
