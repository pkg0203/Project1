

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ku_q/cards/written_post_card.dart';

import 'cards/bookmarked_post_card.dart';

class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class WrittenPostsPage extends StatefulWidget {

  List writtenPostKeys;

  WrittenPostsPage({super.key, required this.writtenPostKeys});

  @override
  State<WrittenPostsPage> createState() => _WrittenPostsPageState();
}

class _WrittenPostsPageState extends State<WrittenPostsPage> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            title: const Text("나의 질문"),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            leading: IconButton(
              icon: const Icon(Icons.clear, color: Colors.black),
              onPressed: () => {Get.back()},
            )
        ),

        body: ScrollConfiguration(
            behavior: ScrollBehaviorWithoutGlow(),
            child: ListView(
              children: widget.writtenPostKeys.map((e) => WrittenPostCard(docKey: e)).toList(),
            )
        )
    );
  }
}
