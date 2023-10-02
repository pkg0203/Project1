


import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ku_q/make_question_page.dart';
import 'cards/answercard.dart';
import 'cards/selected_answer_card.dart';


class QuestionAndAnswerPage extends StatefulWidget {

  DocumentSnapshot docData;
  DocumentSnapshot userInfo;
  QuestionAndAnswerPage({super.key, required this.docData, required this.userInfo});

  @override
  State<QuestionAndAnswerPage> createState() => _QuestionAndAnswerPageState();
}

class _QuestionAndAnswerPageState extends State<QuestionAndAnswerPage> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  late DocumentReference docRef;

  TextEditingController answerController = TextEditingController();
  String answer = "";

  final String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  bool isLiked = false;
  int likeCount = 0;

  bool isBookmarked = false;
  int bookmarkCount = 0;

  @override
  void initState() {
    setState(() {
      docRef = widget.docData.reference;
      likeCount = widget.docData['likeCount'];
      isLiked = widget.docData['likedBy'].contains(fireAuth.currentUser?.uid);
      bookmarkCount = widget.docData['bookmarkCount'];
      fireStore.collection('UserInfo').doc(fireAuth.currentUser?.uid).get().then(
          (snapshot) {
            isBookmarked = snapshot['bookmarkedPosts'].contains(widget.docData['key']);
          }
      );
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("최신 Q&A 게시판", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,
              fontSize: 25)),
          centerTitle: true,
          leading: IconButton(icon: const Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              if (answerController.text.isEmpty){
                Get.back();
              }
              else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text("답변 작성을 중단하시겠습니까? 작성 중인 내용은 저장되지 않습니다"),
                          actions: [
                            TextButton(onPressed: () {Get.back(); }, child: const Text("계속 작성")),
                            TextButton(onPressed: () {Get.back(); Get.back(); dispose();}, child: const Text("중단하기"))
                          ]
                      );
                    });
              }
            },),
          backgroundColor: Colors.white,
          elevation: 0,
        ),

        body: Stack(
          children: [
            Center(
              child:
              /* 질문글 내용 보여주기 */
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ScrollConfiguration(
                  behavior: ScrollBehaviorWithoutGlow(),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: 80,
                              child: Row(
                                  children: [
                                    SizedBox.square(dimension: 80, child: IconButton(icon: const Icon(Icons.account_circle_rounded, size: 60), onPressed: () {},)),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(widget.userInfo['nickName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                          Text(DateFormat('yyyy.MM.dd  HH:mm').format(DateTime.parse(widget.docData['writeDate'].toDate().toString()))),
                                        ]
                                    )
                                  ]
                              )
                          ),

                          FutureBuilder<QuerySnapshot> (
                              future: docRef.collection('Answer').orderBy('writeDate').get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<DocumentSnapshot> docs = snapshot.data!.docs;
                                  var selected = null;
                                  for (DocumentSnapshot doc in docs) {
                                    if (doc.id == widget.docData['selectedAnswer']) {
                                      selected = doc;
                                    }
                                  }
                                  var cards = docs.map((e) => AnswerCard(docData: e, postWriterUid: widget.userInfo.id, postRef: widget.docData.reference, selectedAnswerKey: widget.docData['selectedAnswer'],));
                                  return Column(
                                    children: [
                                      Container(
                                        // height: 300,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFE2E2E2),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: double.infinity,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Colors.white,
                                                    ),
                                                    alignment: Alignment.centerLeft,
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text(widget.docData['title'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  // height: 200,
                                                  margin: const EdgeInsets.only(top: 15),
                                                  padding: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(widget.docData['content'], style: const TextStyle(fontSize: 16)),
                                                ),
                                                /*Container(
                                                    width: double.infinity,
                                                    height: 150,
                                                    color: Colors.red,
                                                    margin: const EdgeInsets.symmetric(vertical: 20),
                                                    child: const Center(child: Text("사진(있는 경우)", style: TextStyle(fontSize: 40)))
                                                ),*/
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () async {
                                                                if (!isLiked) {
                                                                  IncLikes();
                                                                  setState(() {
                                                                    isLiked = true;
                                                                    likeCount += 1;
                                                                  });
                                                                }
                                                                else {
                                                                  DecLikes();
                                                                  setState(() {
                                                                    isLiked = false;
                                                                    likeCount -= 1;
                                                                  });
                                                                }
                                                              },
                                                              icon: Icon(isLiked ? Icons.thumb_up : Icons.thumb_up_outlined, color: const Color(0xFFF42C50)),
                                                              splashRadius: 20,
                                                              iconSize: 30,
                                                            ),
                                                            Text(likeCount.toString()),
                                                            const SizedBox(width: 10),
                                                            const Icon(Icons.message, color: Color(0xFF4194AE), size: 30),
                                                            Text(docs.length.toString()),
                                                            const SizedBox(width: 10),
                                                          ]
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () async {
                                                              if (!isBookmarked) {
                                                                AddBookmark();
                                                                setState(() {
                                                                  isBookmarked = true;
                                                                  bookmarkCount += 1;
                                                                });
                                                              }
                                                              else {
                                                                DeleteBookmark();
                                                                setState(() {
                                                                  isBookmarked = false;
                                                                  bookmarkCount -= 1;
                                                                });
                                                              }
                                                            },
                                                            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border, color: const Color(0xFFFEC860)),
                                                            splashRadius: 20,
                                                            iconSize: 30,
                                                          ),
                                                          Text(bookmarkCount.toString()),
                                                        ],
                                                      ),
                                                    ]
                                                )
                                              ]
                                          )
                                      ),

                                      widget.docData['selectedAnswer'] == "not_yet" ?
                                          const SizedBox():
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black26),
                                        child: Column(
                                          children: [
                                            const SizedBox(width: double.infinity, child: Text("📌 호랑이의 선택!", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),)),
                                            const SizedBox(height: 10),
                                            SelectedAnswerCard(docData: selected, postWriterUid: widget.userInfo.id, postRef: widget.docData.reference, selectedAnswerKey: widget.docData['selectedAnswer'],),
                                          ],
                                        ),
                                      ),

                                      /* 답변 리스트 보여주기 */
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 150),
                                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black12),
                                        child: Column(
                                          children: cards.toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                else {return const Center(child: CircularProgressIndicator());}
                              }
                          )
                        ]
                    ),
                  ),
                ),
              ),
            ),
            /* 이 밑으로 답변 작성 관련 부분 */
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.05,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: 30,
                  child: TextField(
                    controller: answerController,
                    onChanged: (value) {
                      setState(() {
                        answer = value;
                      });
                    },
                    maxLines: null,
                    maxLength: 500,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      // contentPadding: const EdgeInsets.only(top: 8, left: 8),
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "답변을 입력해주세요",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90),
                            borderSide: const BorderSide(width: 10, style: BorderStyle.none)
                        )
                    ),
                  ),
                )
            )
          ]
        ),

        /* 답변하기 버튼 */
        floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 40,
            child: FloatingActionButton.extended(
              backgroundColor: const Color(0xFFFC896F),
              label: const Text("답변하기", style: TextStyle(fontSize: 22, color: Colors.white)),
              onPressed: () {
                if (answerController.text.isNotEmpty){
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("답변을 작성하시겠습니까?"),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("취소")),
                              TextButton(
                                  onPressed: () async {
                                    String postKey = getRandomString(20);
                                    DateTime now = DateTime.now();
                                    int currentMilliSeconds =
                                        now.millisecondsSinceEpoch;
                                    DateTime date =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        currentMilliSeconds);


                                    await fireStore.runTransaction((transaction) async {
                                      transaction.set(docRef.collection('Answer').doc(postKey),
                                          {
                                            "content": answer,
                                            "writerUid": fireAuth.currentUser?.uid,
                                            "writeDate": date,
                                          }
                                      );
                                      transaction.update(docRef, {'answerCount' : FieldValue.increment(1)});
                                    }).then(
                                        (value) => print("댓글 작성 성공"),
                                      onError: (e) => print("에러코드 : $e")
                                    );
                                    answerController.text = "";
                                    answer = "";
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    Get.back();
                                    setState(() {});
                                  },
                                  child: const Text("확인"))
                            ]);
                      });
                }
              },
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void IncLikes() async {
    await fireStore.runTransaction((transaction) async {
      /*final snapshot = await transaction.get(docRef);
      // Note: this could be done without a transaction
      //       by updating the population using FieldValue.increment()
      final newLike = snapshot.get("likeCount") + 1;*/
      transaction.update(docRef, {"likeCount": FieldValue.increment(1)});
      transaction.update(docRef, {"likedBy": FieldValue.arrayUnion([fireAuth.currentUser?.uid])});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }

  void DecLikes() async {
    await fireStore.runTransaction((transaction) async {
      /*final snapshot = await transaction.get(docRef);
      // Note: this could be done without a transaction
      //       by updating the population using FieldValue.increment()
      final newLike = snapshot.get("likeCount") - 1;*/
      transaction.update(docRef, {"likeCount": FieldValue.increment(-1)});
      transaction.update(docRef, {"likedBy": FieldValue.arrayRemove([fireAuth.currentUser?.uid])});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }

  void AddBookmark() async {
    await fireStore.runTransaction((transaction) async {
      transaction.update(docRef, {"bookmarkCount": FieldValue.increment(1)});
      transaction.update(widget.userInfo.reference, {"bookmarkedPosts": FieldValue.arrayUnion([widget.docData['key']])});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }

  void DeleteBookmark() async {
    await fireStore.runTransaction((transaction) async {
      transaction.update(docRef, {"bookmarkCount": FieldValue.increment(-1)});
      transaction.update(widget.userInfo.reference, {"bookmarkedPosts": FieldValue.arrayRemove([widget.docData['key']])});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }
}