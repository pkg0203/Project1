


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class SelectedAnswerCard extends StatefulWidget {

  DocumentSnapshot<Object?> docData;
  DocumentReference postRef;
  String postWriterUid;
  String selectedAnswerKey;

  SelectedAnswerCard({super.key, required this.docData, required this.postWriterUid, required this.postRef, required this.selectedAnswerKey});

  @override
  State<SelectedAnswerCard> createState() => _SelectedAnswerCardState();
}

class _SelectedAnswerCardState extends State<SelectedAnswerCard> {

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
                              Text(snapshot.data['nickName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                              Text(
                                  DateFormat('   yyyy.MM.dd  HH:mm').format(DateTime.parse(widget.docData['writeDate'].toDate().toString())),
                                  style: const TextStyle(fontSize: 12, color: Colors.black)
                              ),
                            ]
                        ),
                        trailing: const SizedBox(width: 0),
                        subtitle: Text(widget.docData['content'], style: const TextStyle(color: Colors.black)),
                        children: const [],
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
                    )
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
}
