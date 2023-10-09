
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ku_q/mainpage.dart';

class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}


class MakeSurveyPage extends StatefulWidget {
  const MakeSurveyPage({super.key});

  @override
  State<MakeSurveyPage> createState() => _MakeSurveyPageState();
}

class _MakeSurveyPageState extends State<MakeSurveyPage> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  TextEditingController titleController = TextEditingController();
  List<TextEditingController> OptionController = List.generate(5, (index) => TextEditingController(),);

  String SurveyTitle = "";
  List<String> OptionContent = List.generate(5, (index) => '');
  int additionalPoint = 0;
  //int RadioValue=0; // 0 은 일주일, 1은 200명
  double Option_number=2;
  bool isDuplicate=false;


  final String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,

          appBar: AppBar(
            title: const Text("설문 작성하기", style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
            centerTitle: true,
            //elevation: 0, //그림자 효과
            leading: IconButton(
              icon: const Icon(Icons.clear, color: Colors.black),
              onPressed: () {
                if (titleController.text.isNotEmpty || OptionController.sublist(0, Option_number.toInt()).any((controller) => controller.text.isNotEmpty)){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("설문 작성을 중단하시겠습니까?\n작성한 내용은 저장되지 않습니다"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("계속 작성하기"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  Get.back();
                                },
                                child: const Text("작성 중단하기"),
                              ),
                            ]
                        );
                      }
                  );
                } else {Get.back();}
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
                            height: 100 + 45 * Option_number,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                                          width: MediaQuery.of(context).size.width *0.75-40,
                                          height: 35,
                                          child: TextField(
                                            controller: titleController,
                                            onChanged: (value) {
                                              setState(() {
                                                SurveyTitle = value;
                                              });
                                            },
                                            textAlign: TextAlign.left,
                                            textAlignVertical: TextAlignVertical.center,
                                            style: const TextStyle(fontSize: 17),
                                            decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.only(top: 8, left: 8),
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText: "설문 제목을 입력해주세요",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                                )
                                            ),
                                          )
                                      ),
                                      DropdownButton(
                                        value: Option_number,
                                        items: [2, 3, 4, 5].map((int e) {
                                          return DropdownMenuItem(
                                            value: e.toDouble(), // 선택 시 onChanged를 통해 반환할 double value
                                            child: Text(e.toString()), // int를 String으로 변환
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            Option_number = value as double;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  for(int i=0;i<Option_number;i++)
                                  Container(
                                      height: 35,
                                      // color: Colors.white,
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.all(0),
                                      child: TextField(
                                        controller: OptionController[i],
                                        onChanged: (value) {
                                          setState(() {
                                            OptionContent[i] = value;
                                          });
                                        },
                                        maxLines: 2,
                                        style: const TextStyle(fontSize: 17),
                                        decoration: InputDecoration(
                                            hintText: "선택지를 입력해주세요",
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

                        Row(
                          children: [Checkbox(
                            value: isDuplicate,
                            onChanged: (value) {
                              setState(() {
                                isDuplicate = value!;
                              });
                              if(isDuplicate){additionalPoint+=20;}
                              else{additionalPoint-=20;}
                            },
                          ),
                            const Text("중복 선택 가능",style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                          ],
                        ),
                    //일주일 동안 진행하는 것을 Default로 하는게 나을 것 같음
                    /*Column(
                      children: [
                        ListTile(
                          title: Text('일주일 동안 진행'),
                          leading: Radio(
                            value: 1,
                            groupValue: RadioValue,
                            onChanged: (value) {
                              setState(() {
                                RadioValue = value as int;
                                
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('200명이 참여할 때까지 진행'),
                          leading: Radio(
                            value: 2,
                            groupValue: RadioValue,
                            onChanged: (value) {
                              setState(() {
                                RadioValue = value as int;
                              });
                            },
                          ),
                        ),
                      ],
                    ),*/

                        Container(
                            margin: const EdgeInsets.only(top: 20),
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
                                                      child: const Center(child: Text("50 냥", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
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
                                                    child: Center( // 텍스트를 가운데 정렬
                                                      child: Text('$additionalPoint 냥  ', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                    ),
                                                  ),
                                                ],
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
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text("   총 사용 포인트", style: TextStyle(fontWeight: FontWeight.w500)),
                                                      Text('${(additionalPoint + 50).toString()} 냥  ', style: const TextStyle(fontWeight: FontWeight.bold,
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
                                backgroundColor: const Color(0xFFFC896F),
                              ),
                              child: const Text("작성 완료", style: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w600)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      bool isNotEmpty = OptionController.sublist(0, Option_number.toInt()).every((controller) => controller.text.isNotEmpty);

                                      if (titleController.text.isEmpty) {
                                        return AlertDialog(
                                            title: const Text("질문 제목을 입력해주세요"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {Get.back();},
                                                child: const Text("확인"),
                                              )
                                            ]
                                        );  // 질문 제목을 입력하지 않았을 시
                                      }
                                        if (!isNotEmpty) {
                                          return AlertDialog(
                                              title: const Text(
                                                  "비어있는 항목이 있습니다."),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text("확인"),
                                                )
                                              ]
                                          ); // 질문 내용을 입력하지 않았을 시
                                        }

                                      else {
                                        return AlertDialog(
                                            insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                                            title: const Text("설문을 게시하시겠습니까?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("계속 작성하기"),
                                                onPressed: () {Get.back();},
                                              ),
                                              //here
                                              TextButton(
                                                child: const Text("게시하기"),
                                                onPressed: () async {
                                                  String Superkey = getRandomString(20);
                                                  DateTime now = DateTime.now();
                                                  int currentMilliSeconds = now.millisecondsSinceEpoch;
                                                  DateTime date = DateTime.fromMillisecondsSinceEpoch(currentMilliSeconds);

                                                  await fireStore.runTransaction((transaction) async {
                                                    transaction.set(fireStore.collection("Survey").doc(Superkey),
                                                        {
                                                          "Option_number":Option_number,
                                                          "Superkey": Superkey,
                                                          "TVN": 0,
                                                          "duplicate":isDuplicate,
                                                          "title": SurveyTitle,
                                                          "state" :true,
                                                          "writerUid": fireAuth.currentUser?.uid,
                                                          "write_date": date,
                                                          //duplicate == F인 경우만 사용하게됨
                                                          "VotedUser": []
                                                        }
                                                    );
                                                    for(int i = 0; i <Option_number; i++){
                                                      String SubSuperkey = '${i+1} ${getRandomString(19)}';
                                                      transaction.set(fireStore.collection("Survey").doc(Superkey).collection("Options").doc(SubSuperkey),
                                                          {
                                                            "title": OptionContent[i],
                                                            "VotedUser": [],
                                                            "VotedNumber" : 0
                                                          }
                                                      );
                                                    }
                                                    transaction.update(fireStore.collection('UserInfo').doc(fireAuth.currentUser?.uid),
                                                        {
                                                          "writtenSurvey":
                                                          FieldValue.arrayUnion(
                                                              [Superkey])
                                                        });
                                                  });
                                                },
                                              ),
                                            ]
                                        );
                                      }
                                    }
                                );
                              },
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

  @override
  void dispose() {
    super.dispose();
  }
}