


import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ku_q/screens/makequestionscreen.dart';
import 'cards/answercard.dart';


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

  bool isBookmarked = false;
  int bookmarkCount = 0;

  bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    docRef = widget.docData.reference;
    fireStore.collection('UserInfo').doc(fireAuth.currentUser?.uid)
        .collection('Bookmark').doc(widget.docData['key']).get().then(
            (bookmarkedPost) =>
        isBookmarked = bookmarkedPost.exists
    );
    fireStore.collection('UserInfo').doc(fireAuth.currentUser?.uid)
        .collection('Like').doc(widget.docData['key']).get().then(
            (likedPost) =>
        isLiked = likedPost.exists
    );
    bookmarkCount = widget.docData['bookmarkCount'];
    likeCount = widget.docData['likeCount'];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("최신 Q&A 게시판", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
              fontSize: 25)),
          centerTitle: true,
          leading: IconButton(icon: const Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              if (answerController.text.isEmpty){
                Get.back();
                dispose();
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

        body: Center(
          child: Stack(
            children: [
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
                            var cards = docs.map((e) => AnswerCard(docData: e));
                            return Column(
                              children: [
                                Container(
                                  // height: 300,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
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
                                          Container(
                                              width: double.infinity,
                                              height: 150,
                                              color: Colors.red,
                                              margin: const EdgeInsets.symmetric(vertical: 20),
                                              child: Center(child: Text("사진(있는 경우)", style: TextStyle(fontSize: 40)))
                                          ),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          final like = fireStore.collection('UserInfo').doc(fireAuth.currentUser?.uid)
                                                              .collection('Like').doc(widget.docData['key']);
                                                          like.get().then(
                                                                  (likedPost) =>
                                                              likedPost.exists ?
                                                              like.delete():
                                                              like.set({})
                                                          );
                                                          setState(() {
                                                            isLiked = !isLiked;
                                                            docRef.update({'likeCount' : FieldValue.increment(isLiked ? 1 : -1)});
                                                            docRef.get().then(
                                                                    (snapshot) =>
                                                                likeCount = snapshot['likeCount']
                                                            );
                                                          });
                                                        },
                                                        icon: Icon(isLiked ? Icons.thumb_up : Icons.thumb_up_outlined, color: Colors.black),
                                                        splashRadius: 20,
                                                        iconSize: 30,
                                                      ),
                                                      Text(likeCount.toString()),
                                                      const SizedBox(width: 10),
                                                      const Icon(Icons.message, color: Colors.black, size: 30),
                                                      Text(docs.length.toString()),
                                                      const SizedBox(width: 10),
                                                    ]
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        final book = fireStore.collection('UserInfo').doc(fireAuth.currentUser?.uid)
                                                            .collection('Bookmark').doc(widget.docData['key']);
                                                        book.get().then(
                                                            (bookmarkedPost) =>
                                                                bookmarkedPost.exists ?
                                                                  book.delete():
                                                                  book.set({})
                                                        );
                                                        setState(() {
                                                          isBookmarked = !isBookmarked;
                                                          docRef.update({'bookmarkCount' : FieldValue.increment(isBookmarked ? 1 : -1)});
                                                          docRef.get().then(
                                                              (snapshot) =>
                                                                  bookmarkCount = snapshot['bookmarkCount']
                                                          );
                                                        });
                                                      },
                                                      icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border, color: Colors.black),
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
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 40, 0, 150),
                                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black26),
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

              /* 이 밑으로 답변 작성 관련 부분 */
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: 30,
                  child: TextField(
                    controller: answerController,
                    onChanged: (value) {
                      answer = value;
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
            ],
          ),
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
                                  onPressed: () {
                                    String postKey = getRandomString(20);
                                    DateTime now = DateTime.now();
                                    int currentMilliSeconds =
                                        now.millisecondsSinceEpoch;
                                    DateTime date =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            currentMilliSeconds);


                                    docRef
                                        .collection("Answer")
                                        .doc(postKey)
                                        .set({
                                      "key": postKey,
                                      "content": answer,
                                      "writerUid": fireAuth.currentUser?.uid,
                                      "writeDate": date,
                                    });
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

  @override
  void dispose() {
    fireStore.disableNetwork();
    answerController.dispose();
    super.dispose();
  }
}
