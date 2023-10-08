


import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ku_q/cards/image_preview_card.dart';

class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}


class MakeQuestionPage extends StatefulWidget {
  String nickName;
  int myPoint;
  MakeQuestionPage({super.key, required this.nickName, required this.myPoint});

  @override
  State<MakeQuestionPage> createState() => _MakeQuestionPageState();
}

class _MakeQuestionPageState extends State<MakeQuestionPage> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController additionalPointController = TextEditingController(text: "0");

  String postTitle = "";
  String postContent = "";
  int additionalPoint = 0;

  List<XFile> selectedImages = [];

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
                if (titleController.text.isNotEmpty || contentController.text.isNotEmpty || selectedImages.isNotEmpty){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("글쓰기를 중단하시겠습니까?\n작성한 내용은 저장되지 않습니다"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("취소"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  Get.back();
                                },
                                child: const Text("중단"),
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
                            //height: selectedImages.isEmpty ? 300 : 435,
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
                                          child: TextField(
                                            controller: titleController,
                                            onChanged: (value) {
                                              setState(() {
                                                postTitle = value;
                                              });
                                            },
                                            textAlign: TextAlign.left,
                                            textAlignVertical: TextAlignVertical.center,
                                            style: const TextStyle(fontSize: 17),
                                            decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.only(top: 8, left: 8),
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
                                      SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: RawMaterialButton(
                                              onPressed: () async {
                                                try {
                                                  final List<XFile> pickedImages = await ImagePicker().pickMultiImage(imageQuality: 50);
                                                  if (pickedImages.isNotEmpty){
                                                    if (pickedImages.length <= 5){
                                                      setState(() {
                                                        selectedImages =
                                                            pickedImages;
                                                      });
                                                    }
                                                    else {
                                                      showDialog(context: context, builder: (context) {
                                                        return const AlertDialog(title: Text("최대 5개의 이미지까지 선택할 수 있습니다."));
                                                      });
                                                    }
                                                  }
                                                }
                                                catch (e) {
                                                  print(e);
                                                }
                                              },
                                              fillColor: Colors.white,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(90),
                                              ),
                                              child: const Icon(Icons.camera_alt)
                                          )
                                      )
                                    ],
                                  ),
                                  Container(
                                      height: 200,
                                      // color: Colors.white,
                                      margin: const EdgeInsets.only(top: 15),
                                      padding: const EdgeInsets.all(0),
                                      child: TextField(
                                        controller: contentController,
                                        onChanged: (value) {
                                          setState(() {
                                            postContent = value;
                                          });
                                        },
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
                                  ),
                                  if (selectedImages.isNotEmpty)
                                    Scrollbar(
                                      child: Container(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        height: 135,
                                        child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: selectedImages.map((e) => ImagePreviewCardFileImage(file: e)).toList()
                                        ),
                                      ),
                                    ),
                                ]
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 40),
                            // color: Colors.blue,
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                    children: [
                                      Text("사용 포인트  ", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                                      Icon(Icons.help_outline, size: 22, color: Color(0xD0D0D0D0)),
                                    ]
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(widget.nickName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
                                    const Text("님의 잔여 포인트 :", style: TextStyle(fontSize: 13)),
                                    Text("${widget.myPoint.toString()}냥 ", style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
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
                                                      child: TextField(
                                                          maxLength: 7,
                                                          textAlign: TextAlign.center,
                                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                                          keyboardType: const TextInputType.numberWithOptions(),
                                                          decoration: const InputDecoration(
                                                            counterText: '',
                                                          ),
                                                          controller: additionalPointController,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              additionalPoint = int.parse(value);
                                                            });
                                                          }
                                                      ),
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
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text("   총 사용 포인트", style: TextStyle(fontWeight: FontWeight.bold)),
                                                      Text('${(additionalPoint + 100).toString()} 냥  ', style: const TextStyle(fontWeight: FontWeight.w900,
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
                                      if (titleController.text.isEmpty) {
                                        return const AlertDialog(
                                            title: Text("질문 제목을 입력해주세요!"),
                                        );  // 질문 제목을 입력하지 않았을 시
                                      }
                                      else if (contentController.text.isEmpty) {
                                        return const AlertDialog(
                                            title: Text("질문 내용을 입력해주세요!"),
                                        );  // 질문 내용을 입력하지 않았을 시
                                      }
                                      else if (additionalPointController.text.isEmpty) {
                                        return const AlertDialog(
                                            title: Text("추가 사용 포인트를 입력해주세요! (최소 0)"),
                                        );
                                      }
                                      else if (widget.myPoint < additionalPoint + 100) {
                                        return const AlertDialog(
                                            title: Text("보유 포인트가 부족합니다!"),
                                        );
                                      }
                                      else {
                                        return AlertDialog(
                                            insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                                            title: const Text("질문을 게시하시겠습니까?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("취소"),
                                                onPressed: () {Get.back();},
                                              ),
                                              TextButton(
                                                child: const Text("확인"),
                                                onPressed: () async {

                                                  String postKey = getRandomString(20);
                                                  DateTime now = DateTime.now();
                                                  int currentMilliSeconds = now.millisecondsSinceEpoch;
                                                  DateTime date = DateTime.fromMillisecondsSinceEpoch(currentMilliSeconds);

                                                  List imagesRef = [];
                                                  if (selectedImages.isNotEmpty) {
                                                    try {
                                                      var storageRef = FirebaseStorage.instance.ref();
                                                      for (int i = 0; i < selectedImages.length; i++) {
                                                        final imageRef = storageRef.child('images/post/${date.year}_${date.month}/${postKey}_$i');
                                                        File file = File(selectedImages[i].path);
                                                        await imageRef.putFile(file);
                                                        final imageURL = await imageRef.getDownloadURL();
                                                        imagesRef.add(imageURL);
                                                      }
                                                    } on FirebaseException catch (e) {
                                                      print(e.code);
                                                    }
                                                  }

                                                  await fireStore.runTransaction((transaction) async {
                                                    transaction.set(fireStore.collection("Post").doc(postKey),
                                                        {

                                                        "key": postKey,
                                                        "title": postTitle,
                                                        "content": postContent,
                                                        "point": additionalPoint + 100,
                                                        "writerUid": fireAuth.currentUser?.uid,
                                                        "writeDate": date,
                                                        "bookmarkCount": 0,
                                                        "likeCount": 0,
                                                        "likedBy": [],
                                                        "answerCount": 0,
                                                        "selectedAnswer": "not_yet",
                                                        "images": imagesRef

                                                        }
                                                    );
                                                    transaction.update(fireStore.collection('UserInfo').doc(fireAuth.currentUser?.uid),
                                                      {
                                                          "writtenPosts":
                                                      FieldValue.arrayUnion(
                                                          [postKey])
                                                      });
                                                    transaction.update(fireStore.collection('UserInfo').doc(fireAuth.currentUser?.uid),
                                                        {
                                                          "point":
                                                          FieldValue.increment(-(additionalPoint + 100))
                                                        });

                                                  });
                                                  Get.back();
                                                  Get.back();
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