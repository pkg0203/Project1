


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnswerCard extends StatefulWidget {

  DocumentSnapshot<Object?> docData;

  AnswerCard({super.key, required this.docData});

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

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
            // width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
                        height: 50,
                        child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.account_circle_rounded),
                                iconSize: 40,
                                onPressed: () {},
                              ),
                              Text(snapshot.data['nickName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  DateFormat('   yyyy.MM.dd  HH:mm').format(DateTime.parse(widget.docData['writeDate'].toDate().toString())),
                                  style: const TextStyle(fontSize: 11)
                              ),
                              const Spacer(),
                              const Icon(Icons.local_fire_department, color: Colors.red),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up, color: Colors.black), splashRadius: 1,),
                            ]
                        )
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        child: Text(widget.docData['content'])
                    )
                  ]
              )
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
