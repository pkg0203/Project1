


import 'package:flutter/material.dart';
import 'package:ku_q/screens/makequestionscreen.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecentQuestionScreen extends StatefulWidget {
  const RecentQuestionScreen({super.key});

  @override
  State<RecentQuestionScreen> createState() => _RecentQuestionScreenState();
}

class _RecentQuestionScreenState extends State<RecentQuestionScreen> {


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
      
      body: Container(
        color: Colors.red,
      ),
      
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () {Get.to(MakeQuestionScreen(), transition: Transition.downToUp);},
          backgroundColor: const Color(0xFFFC896F),
          icon: const Icon(Icons.add),
          label: const Text("질문하기", style: TextStyle(fontSize: 22, color: Colors.white)),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

