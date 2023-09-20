


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ku_q/cards/postcard.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KU Q&A🐯", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
      ),
      body: Scrollbar(
        thickness: 8,
        radius: const Radius.circular(90),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  color: const Color(0xD0D0D0D0),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text("이번 주 꿀팁 모음", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold
                  ))
                ),
                Container(
                  //color: Colors.blue,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("🏆️명예의 전당",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          TextButton(
                            onPressed: () {print(FirebaseAuth.instance.currentUser?.uid.toString());},
                            child: const Text("더보기>", style: TextStyle(color: Colors.black)),
                          )
                        ],
                      )
                    ]
                  )
                ),
                Container(
                  //color: Colors.cyan,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                SizedBox(
                    //color: Colors.blue,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("🔥실시간 핫게시물",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              )
                            ],
                          )
                        ]
                    )
                ),
                SizedBox(
                    //color: Colors.orange,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: FutureBuilder<QuerySnapshot> (
                        future: FirebaseFirestore.instance.collection('Post').orderBy('likeCount', descending: true).limit(3).get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<DocumentSnapshot> docs= snapshot.data!.docs;
                            var cards = docs.map((e) => PostCard(docData: e));
                            return Column (
                              children: cards.toList()
                            );
                          }
                          else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                    )
                ),  // 게시물 리스트 뷰
              ],
            ),
          ]
        ),
      ),
    );
  }
}
