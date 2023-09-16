


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ku_q/question_answer_page.dart';
import 'package:intl/intl.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot> (
      future: widget.docData['writerRef'].get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RawMaterialButton(
            onPressed: () {
              widget.docData.reference.get().then(
                  (freshSnapshot) => Get.to(() => QuestionAndAnswerPage(docData: freshSnapshot, userInfo: snapshot.data!))
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
                  color: Colors.black12,
                ),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                height: 110,
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
                              Expanded(
                                flex: 2,
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 15),
                                            // color: Colors.yellow,
                                            child: Text(
                                              widget.docData['title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          DateFormat('yyyy.MM.dd  HH:mm')
                                              .format(DateTime.parse(
                                              widget.docData['writeDate']
                                                  .toDate()
                                                  .toString())),
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      )
                                    ]
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.docData['content'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
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
