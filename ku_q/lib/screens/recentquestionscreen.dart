


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ku_q/cards/postcard.dart';
import 'package:ku_q/make_question_page.dart';
import 'package:get/get.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class RecentQuestionScreen extends StatefulWidget {
  const RecentQuestionScreen({super.key});

  @override
  State<RecentQuestionScreen> createState() => _RecentQuestionScreenState();
}

class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _RecentQuestionScreenState extends State<RecentQuestionScreen> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static const int _pageSize = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("최신 Q&A 게시판"),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ScrollConfiguration(
          behavior: ScrollBehaviorWithoutGlow(),
          child: FirestoreListView<Map<String, dynamic>> (
            pageSize: _pageSize,
            query: fireStore.collection('Post').orderBy('writeDate', descending: true),
            itemBuilder: (context, snapshot) {
              return PostCard(docData: snapshot);
            },
          ),
        )

      ),

      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 40,
          child: FloatingActionButton.extended(
            onPressed: () {Get.to(const MakeQuestionPage(), transition: Transition.downToUp);},
            backgroundColor: const Color(0xFFFC896F),
            icon: const Icon(Icons.add),
            label: const Text("질문하기", style: TextStyle(fontSize: 22, color: Colors.white)),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

