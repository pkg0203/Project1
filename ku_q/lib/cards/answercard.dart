


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
            child:
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.account_circle_rounded, color: Colors.black, size: 38),
                        onPressed: () => print("아이콘 클릭"),
                      ),
                      Text(snapshot.data['nickName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                      Text(
                          DateFormat('   yyyy.MM.dd  HH:mm').format(DateTime.parse(widget.docData['writeDate'].toDate().toString())),
                          style: const TextStyle(fontSize: 12, color: Colors.black)
                      ),
                      const Spacer(),
                      const Icon(Icons.local_fire_department_sharp, color: Colors.red),
                      IconButton(
                        icon: const Icon(Icons.thumb_up),
                        onPressed: () => print("공감 클릭"),
                      )
                    ]
                  ),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12), width: double.infinity, child: Text(widget.docData['content'])),
                  Container(
                    height: 20,
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_vert, size: 20),
                      itemBuilder: widget.postWriterUid == fireAuth.currentUser?.uid ? (context) => [
                        const PopupMenuItem(value: 1, child: Text("채택하기")),
                        const PopupMenuItem(value: 0, child: Text("신고하기")),
                      ] :
                          (context) => [
                        const PopupMenuItem(value: 0, child: Text("신고하기")),
                      ],
                      onSelected: (v) {
                        switch (v) {
                          case 0: {
                            print("신고하기");
                          }
                          case 1: {
                            _SelectAnswer();
                          }
                        }
                      },
                    )
                  )
                ],
              ),
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
