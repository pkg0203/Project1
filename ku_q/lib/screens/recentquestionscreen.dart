


import 'package:flutter/material.dart';
import 'package:ku_q/screens/makequestionscreen.dart';
import 'package:get/get.dart';

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
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.red,
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // color: Colors.purple,
              width: double.infinity,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFC896F)),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFFC896F)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        //side: BorderSide(color: Colors.red) // border line color
                      )),
                ),
                child: const Text("질문하기", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
          )
        ]
      )
    );
  }
}
