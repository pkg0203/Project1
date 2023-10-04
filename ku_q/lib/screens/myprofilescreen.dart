import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black54,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
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
                onPressed: null,
                child: Text(
                  '완료',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          body: Column(
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
          )
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
