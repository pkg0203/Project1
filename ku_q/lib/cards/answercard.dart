


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class AnswerCard extends StatefulWidget {

  DocumentSnapshot<Object?> docData;
  DocumentReference postRef;
  String postWriterUid;
  String selectedAnswerKey;

  AnswerCard({super.key, required this.docData, required this.postWriterUid, required this.postRef, required this.selectedAnswerKey});

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Answer 컬렉션 내 writerUid의 값을 이용해 해당 유저의 정보를 받아오는 메소드
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
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: ExpansionTile(
                        title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  width: 40,
                                  height: 50
                              ),
                              Text(snapshot.data['nickName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Text(
                                  DateFormat('   yyyy.MM.dd  HH:mm').format(DateTime.parse(widget.docData['writeDate'].toDate().toString())),
                                  style: const TextStyle(fontSize: 12)
                              ),
                            ]
                        ),
                        trailing: const SizedBox(width: 0),
                        subtitle: Text(widget.docData['content']),
                        children: [
                          SizedBox(
                              height: 50,
                              child: Row(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Container()
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: SizedBox(
                                          height: 35,
                                          child: widget.postWriterUid == fireAuth.currentUser?.uid ? RawMaterialButton(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90), side: BorderSide()),
                                            onPressed: () async {
                                              _SelectAnswer();
                                            },
                                            child: const Text("채택하기", style: TextStyle(fontWeight: FontWeight.w900))
                                          ) :
                                              Container(),
                                        )
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: Container(
                                          //color: Colors.blue,
                                        )
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: PopupMenuButton(
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(Icons.more_vert, color: Colors.black, size: 23),
                                          itemBuilder: (BuildContext context) => [const PopupMenuItem(value: 0, child: Text("신고하기"))],
                                          onSelected: (v) async {
                                            print("신고하기");
                                          },
                                        )
                                    )
                                  ]
                              )
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 5,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 40,
                          onPressed: () => print('check'),
                          icon: const Icon(Icons.account_circle_rounded)
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department_rounded, color: Colors.red),
                          IconButton(
                            onPressed: () => print('check'),
                            icon: const Icon(Icons.thumb_up_alt)
                          ),
                        ],
                      )
                    ),
                  ]
              ),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  void _SelectAnswer() async {
    if (widget.selectedAnswerKey != "not_yet") {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
            title: Text("이미 채택된 답변이 있습니다.")
        );
      });
    }
    else {
      await fireStore.runTransaction((transaction) async {
        final snapshot = await transaction.get(widget.postRef);
        if (snapshot.get('selectedAnswer') != "not_yet") {
          widget.selectedAnswerKey = snapshot.get('selectedAnswer');
          showDialog(context: context, builder: (context) {
            return const AlertDialog(
                title: Text("이미 채택된 답변이 있습니다.")
            );
          });
        }
        else {
          transaction.update(widget.postRef, {'selectedAnswer': widget.docData.id});
          showDialog(context: context, builder: (context) {
            return const AlertDialog(
                title: Text("이 답변을 채택했습니다.")
            );
          });
        }
      }).then(
              (value) => print("성공"),
          onError: (e) => print("에러코드 : $e")
      );
    }
  }
}