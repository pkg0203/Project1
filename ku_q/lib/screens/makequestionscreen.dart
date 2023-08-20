


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}


class MakeQuestionScreen extends StatefulWidget {
  const MakeQuestionScreen({super.key});

  @override
  State<MakeQuestionScreen> createState() => _MakeQuestionScreenState();
}

class _MakeQuestionScreenState extends State<MakeQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          title: const Text("질문하기", style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          )),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.white,

        ),

        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ScrollConfiguration(
              behavior: ScrollBehaviorWithoutGlow(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75 - 35,
                                height: 35,
                                // color: Colors.white,
                                child: TextField(
                                  style: const TextStyle(fontSize: 17),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "질문제목을 입력해주세요",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                    )
                                  ),
                                )
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                child: const Center(child: Icon(Icons.camera_alt)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: Colors.white
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 200,
                            // color: Colors.white,
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.all(0),
                            child: TextField(
                              maxLines: 10,
                              style: const TextStyle(fontSize: 17),
                              decoration: InputDecoration(
                                hintText: "질문내용을 입력해주세요",
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.all(8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                )
                              ),
                            )
                          )
                        ]
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      // color: Colors.blue,
                      height: 30,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("사용 포인트  ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                              Icon(Icons.help_outline, size: 22, color: Color(0xD0D0D0D0)),
                            ]
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("OO님의 잔여 포인트 :", style: TextStyle(fontSize: 12)),
                              Text("NNN냥 ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 17),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xE7E7E7E7),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 65,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Text("기본 사용 포인트", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        height: 32,
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(90),
                                        ),
                                        child: const Center(child: Text("100 냥", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                                      )
                                    ]
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text("추가 사용 포인트", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          height: 32,
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(90),
                                          ),
                                          child: const Center(child: Text("NNN 냥", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                                        )
                                      ]
                                  ),
                                )
                              ]

                            )
                          ),
                          SizedBox(
                            height: 35,
                            // color: Colors.red,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  decoration: BoxDecoration(
                                    color: const Color(0xC0C0C0C0),
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("   총 사용 포인트", style: TextStyle(fontWeight: FontWeight.w500)),
                                      Text("MMM 냥   ", style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 22)),
                                    ]
                                  )
                                )
                              ]
                            )
                          )
                        ]
                      )
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFC896F),
                        ),
                        child: const Text("작성 완료", style: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w600)),
                        onPressed: () {},
                      )
                    ),
                    const SizedBox(height: 25)
                  ]
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
