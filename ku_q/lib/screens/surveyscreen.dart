import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ku_q/cards/surveycard.dart';



class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}


class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();

}

class _SurveyScreenState extends State<SurveyScreen> {
  FirebaseFirestore firestore= FirebaseFirestore.instance;
  final int _pageSize = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설문조사'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("title"),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 400,
              child: ScrollConfiguration(
                behavior: ScrollBehaviorWithoutGlow(),
                child: FirestoreListView<Map<String, dynamic>> (
                  pageSize: _pageSize,
                  query: firestore.collection('Survey').orderBy('write_date', descending: true),
                  itemBuilder: (context, snapshot) {
                    return SurveyCard(docData: snapshot);
                  },
                ),
              ),
            ),
          ],
        ),
      )





      /*Container(
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // 검색 창
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '검색어를 입력하세요',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0), // 검색창과 검색하기의 여백
                // '만들기' 버튼
                ElevatedButton(
                  onPressed: () {
                    // '만들기' 버튼을 눌렀을 때의 동작을 정의
                  },
                  child: const Text('검색하기'),
                ),
              ],
            ),
            const SizedBox(height: 25.0), // 검색 창과 버튼 사이 간격 조절

            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ScrollConfiguration(
                  behavior: ScrollBehaviorWithoutGlow(),
                  child: FirestoreListView<Map<String, dynamic>> (
                    pageSize: 5,
                    query: firestore.collection('Survey').orderBy('write_date', descending: true),
                    itemBuilder: (context, snapshot) {
                      return SurveyCard(docData: snapshot);
                    },
                  ),
                )

            ),
            ElevatedButton(
              onPressed: () {
                // '만들기' 버튼을 눌렀을 때의 동작을 정의
              },
              child: const Text('설문 작성(N냥)'),
            ),
            // 나머지 컨텐츠들을 추가하는 부분
          ],
        ),
      ),*/
    );
  }
}






