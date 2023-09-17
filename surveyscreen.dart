import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ku_q/cards/surveycard.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();

}

class _SurveyScreenState extends State<SurveyScreen> {
  FirebaseFirestore firestore= FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설문조사'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // 검색 창
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '검색어를 입력하세요',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0), // 검색창과 검색하기의 여백
                // '만들기' 버튼
                ElevatedButton(
                  onPressed: () {
                    // '만들기' 버튼을 눌렀을 때의 동작을 정의
                  },
                  child: Text('검색하기'),
                ),
              ],
            ),
            SizedBox(height: 25.0), // 검색 창과 버튼 사이 간격 조절

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[450],
              ),
              padding: EdgeInsets.all(20.0),
              child: FirestoreListView<Map<String,dynamic>>(
                pageSize: 5,
                query: firestore.collection('Survey').orderBy('write_date'),
                itemBuilder: (context,snapshot){
                  return SurveyCard(docData: snapshot);
                }
              )
            ),
            ElevatedButton(
              onPressed: () {
                // '만들기' 버튼을 눌렀을 때의 동작을 정의
              },
              child: Text('설문 작성(N냥)'),
            ),
            // 나머지 컨텐츠들을 추가하는 부분
          ],
        ),
      ),
    );
  }
}






