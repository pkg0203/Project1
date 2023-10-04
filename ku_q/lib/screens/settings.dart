import 'dart:ffi';
//
import 'package:flutter/material.dart';
import 'package:ku_q/screens/alarm_setting.dart';
import 'package:ku_q/notification.dart';
import 'package:ku_q/screens/mypagescreen.dart';
//import 'package:ku_q/screens/alarm_setting.dart';
import 'package:get/get.dart';
//import 'package:ku_q/icons/my_flutter_app_icons.dart';
import 'package:ku_q/cards/charactercard.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettings();
}

class _UserSettings extends State<UserSettings> {

  @override
  void initState() {
    // 초기화
    FlutterLocalNotification.init();

    // 3초 후 권한 요청
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.backspace_outlined, color: Colors.black,),
        ),
        title: Text(
          '설정',
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
                Square(),
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

class Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      margin: EdgeInsets.all(10.0),
      //height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: TextButton(
                  onPressed: () => FlutterLocalNotification.showNotification(),
                  child: const Text("알림 보내기"),
                ),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Icon(
                    Icons.person_pin,
                    size: 50,
                    color: Colors.black54,
                  ) //나중에는 여기에 프로필 이미지 넣기
              ),
              SizedBox(width: 10,),
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'dajulie',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '김다빈 / 환경생태공학부',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(thickness: 1, height: 1, color: Colors.black26),
          SizedBox(
            height: 10,
          ),
          Text(
            '계정 정보',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: null,
                child: Text(
                  '이메일  ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Text('dajulie@korea.ac.kr'),
              TextButton(
                onPressed: null,
                child: const Text(
                  ">",
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: null,
                child: Text(
                  '내 정보 관리',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: null,
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: null,
                child: const Text(
                  ">",
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
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
            '앱 설정',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '개인 / 보안',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: null,
                child: Text(
                  '테마 설정      ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Text('시스템 기본 값'),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                child: const Text('시스템 기본 값', style: TextStyle(color: Colors.black),),
                                onPressed: () {
                                  //화면 테마 변경
                                  //Navigator.of(context).pop();
                                },
                              ),
                              Divider(thickness: 1, height: 1, color: Colors.black26),
                              TextButton(
                                child: const Text('라이트 모드', style: TextStyle(color: Colors.black),),
                                onPressed: () {
                                  //화면 테마 변경
                                  //Navigator.of(context).pop();
                                },
                              ),
                              Divider(thickness: 1, height: 1, color: Colors.black26),
                              TextButton(
                                child: const Text('다크 모드', style: TextStyle(color: Colors.black),),
                                onPressed: () {
                                  //화면 테마 변경
                                  //Navigator.of(context).pop();
                                },
                              ),
                              Divider(thickness: 1, height: 1, color: Colors.black26),
                              TextButton(
                                child: const Text('취소', style: TextStyle(color: Colors.black),),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                          insetPadding: const  EdgeInsets.fromLTRB(100,250,100,250),
                          /*
                          actions: [
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          */
                        );
                      }
                  );
                },
                icon: Icon(Icons.keyboard_arrow_right),
              )
              /*
              TextButton(
                onPressed: null,
                child: const Text(
                  ">",
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              */
            ],
          ),
          TextButton(
            onPressed: (){

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlarmSettings()));

            },
            child: Text(
              '알림 설정',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '기타     ',
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
            '이용 안내',
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
              '앱 버전',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '커뮤니티 이용규칙',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '이용약관',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '개인정보 처리방침',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '고객센터',
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
            '기타',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '서비스 이용 동의',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '이용제한 내역',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              '회원탈퇴',
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
