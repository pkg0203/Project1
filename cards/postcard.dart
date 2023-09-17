


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {

  DocumentSnapshot<Object?> docData;

  PostCard({super.key, required this.docData});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xD0D0D0D0),
          width: 2,
        ),
        color: const Color(0xEBEBEBEB),
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 2, child: Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                )),
                Expanded(flex: 1, child: Text(widget.docData['writerName'], overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10)))
              ]
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.only(top: 15),
                          // color: Colors.yellow,
                          child: Text(
                            widget.docData['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          )
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // color: Colors.orange,
                          child: Text(
                            "N 시간 전",
                            style: TextStyle(fontSize: 10),
                          )
                        ),
                      )
                    ]
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.docData['content'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ]
            ),
          )
        ]
      )
    );
  }
}
