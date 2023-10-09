import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ku_q/cards/surveycard.dart';
import 'package:ku_q/make_survey_page.dart';
import 'package:get/get.dart';


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
  // ignore: non_constant_identifier_names
  final double floating_size=40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🔍︎설문조사"),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ScrollConfiguration(
          behavior: ScrollBehaviorWithoutGlow(),
          child: FirestoreListView<Map<String, dynamic>>(
            pageSize: _pageSize,
            query: firestore.collection('Survey').orderBy('write_date', descending: true),
            itemBuilder: (context, snapshot) {
              return SurveyCard(docData: snapshot);
            },
          ),
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end, // 하단 정렬
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: floating_size,
            child: FloatingActionButton.extended(
              heroTag: 'search',
              onPressed: () {
                // 첫 번째 버튼을 눌렀을 때의 동작을 정의
              },
              backgroundColor: const Color(0xFFFC896F),
              icon: const Icon(Icons.search),
              label: const Text("검색하기(미구현)", style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 8),//여백
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: floating_size,
            child: FloatingActionButton.extended(
              heroTag: 'write',
              onPressed: () {
                Get.to(const MakeSurveyPage(), transition: Transition.downToUp);
              },
              backgroundColor: const Color(0xFFFC896F),
              icon: const Icon(Icons.add),
              label: const Text("설문 작성(NNN냥)", style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}





