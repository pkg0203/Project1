


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WrittenPostCard extends StatefulWidget {

  dynamic docKey;

  WrittenPostCard({super.key, required this.docKey});

  @override
  State<WrittenPostCard> createState() => _WrittenPostCardState();
}

class _WrittenPostCardState extends State<WrittenPostCard> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fireStore.collection('Post').doc(widget.docKey).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot docData = snapshot.data!;
            var today = DateTime.now();
            String date = docData['writeDate'].toDate().toString();

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
            return Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black12,
                ),
                child: Column(
                    children: [
                      SizedBox(
                          height: 25,
                          child: Row(
                              children:[
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(docData['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), overflow: TextOverflow.ellipsis, maxLines: 1,)
                                    )
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(diffFromNow),
                                    )
                                )
                              ]
                          )
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 55,
                          alignment: Alignment.topLeft,
                          child: Text(docData['content'], overflow: TextOverflow.fade, maxLines: 3,)
                      ),
                      SizedBox(
                          height: 25,
                          child: Row(
                              children:[
                                Spacer(),
                                Icon(Icons.thumb_up, size: 20),
                                Text("${docData['likeCount']}  "),
                                Icon(Icons.message, size: 20, ),
                                Text("${docData['answerCount']}")
                              ]
                          )
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
