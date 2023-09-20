

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cards/bookmarked_post_card.dart';

class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class BookmarkedPostsPage extends StatefulWidget {

  List bookmarkedPostKeys;

  BookmarkedPostsPage({super.key, required this.bookmarkedPostKeys});

  @override
  State<BookmarkedPostsPage> createState() => _BookmarkedPostsPageState();
}

class _BookmarkedPostsPageState extends State<BookmarkedPostsPage> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("내가 스크랩한 글"),
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
          children: widget.bookmarkedPostKeys.map((e) => BookmarkedPostCard(docKey: e)).toList(),
        )
      )
    );
  }
}
