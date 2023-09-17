import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ku_q/cards/surveyoption.dart';

class SurveyPost extends StatefulWidget {
  final String title;
  final num option_number;
  final QuerySnapshot option;

  const SurveyPost({required this.title, required this.option_number, required this.option});

  @override
  State<SurveyPost> createState() => _SurveyPostState();
}

class _SurveyPostState extends State<SurveyPost>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 25,
            ),
              //Option 만들기
              SurveyOption(widget.option,widget.option_number, context),
            //결과 보기
            Container(
              height: 45,
              width: 120,
              color: Colors.orange,
              child: TextButton(
                onPressed: () {
                  // 버튼이 클릭될 때 실행할 코드를 여기에 작성
                },
                style: TextButton.styleFrom(
                  primary: Colors.black, // 텍스트 색상을 검은색으로 지정
                ),
                child: Text('결과보기',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                // 버튼에 표시될 텍스트 // 버튼에 표시될 텍스트
              ),
            ),
            SizedBox(height: 13.0),
            Container(
              height: 45,
              width: 120,
              color: Colors.orange,
              child: TextButton(
                onPressed: () {
                  // 버튼이 클릭될 때 실행할 코드를 여기에 작성
                },
                style: TextButton.styleFrom(
                  primary: Colors.black, // 텍스트 색상을 검은색으로 지정
                ),
                child: Text('댓글',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)), // 버튼에 표시될 텍스트
              )
              ,
            )
          ],
        ),
      ),
    );
  }
}
