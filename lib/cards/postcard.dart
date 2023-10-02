
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ku_q/question_answer_page.dart';
//
class PostCard extends StatefulWidget {

  DocumentSnapshot<Object?> docData;

  PostCard({super.key, required this.docData});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Post 컬렉션 내 writerUid의 값을 이용해 해당 유저의 정보를 받아오는 메소드
  // 닉네임 변경 가능성 때문에 uid(불변)를 이용해 닉네임을 매번 받아와야 함
  // 조금 비효율적인 방식같음... 후에 개선 여지
  Future getWriterInfo() async {
    final info = await fireStore.collection('UserInfo').doc(widget.docData['writerUid']).get();
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
        future: getWriterInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var today = DateTime.now();
            String date = widget.docData['writeDate'].toDate().toString();

            String diffFromNow = '';
            int difference = int.parse(
                today.difference(DateTime.parse(date)).inDays.toString());
            if (difference > 1) {
              diffFromNow = '$difference일 전';
            }
            else if (difference == 1) {
              diffFromNow = '하루 전';
            }
            else {
              difference = int.parse(
                  today.difference(DateTime.parse(date)).inHours.toString());
              diffFromNow = '$difference시간 전';
              if (difference < 1) {
                difference = int.parse(
                    today.difference(DateTime.parse(date)).inMinutes.toString());
                diffFromNow = '$difference분 전';
              }
            }
            return RawMaterialButton(
              onPressed: () async {
                widget.docData.reference.get().then(
                    (freshSnapshot) {
                      Get.to(() => QuestionAndAnswerPage(docData: freshSnapshot, userInfo: snapshot.data));
                    }
                );
              },
              child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 10
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xD0D0D0D0),
                      width: 2,
                    ),
                    color: Color(0xFFE2E2E2),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  height: 124,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.red,
                                    width: 60,
                                    height: 60,
                                  ),
                                  Text(snapshot.data['nickName'],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 10))
                                ]
                            )
                        ),
                        Expanded(
                          flex: 7,
                          child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              // color: Colors.yellow,
                                              child: Text(
                                                widget.docData['title'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                  fontSize: 16
                                                ),
                                              )
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              diffFromNow,
                                              style: const TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        )
                                      ]
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.docData['content'],
                                      maxLines: 3,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                  child: Row(
                                    children:[
                                      const Spacer(),
                                      const Icon(Icons.thumb_up, size: 15),
                                      Text(widget.docData['likeCount'].toString()),
                                      const Icon(Icons.message, size: 15),
                                      Text(widget.docData['answerCount'].toString()),
                                      const Icon(Icons.bookmark, size: 15),
                                      Text(widget.docData['bookmarkCount'].toString())
                                    ]
                                  )
                                )
                              ]
                          ),
                        )
                      ]
                  )
              ),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}