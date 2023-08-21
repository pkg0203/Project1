


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ku_q/cards/postcard.dart';
import 'package:ku_q/screens/makequestionscreen.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecentQuestionScreen extends StatefulWidget {
  const RecentQuestionScreen({super.key});

  @override
  State<RecentQuestionScreen> createState() => _RecentQuestionScreenState();
}

class _RecentQuestionScreenState extends State<RecentQuestionScreen> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static const _pageSize = 10;
  final PagingController _pagingController = PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fireStore.collection('Post').orderBy("writeDate").startAt([pageKey]).limit(_pageSize).get();
      final isLastPage = newItems.docs.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.docs);
      } else {
        final nextPageKey = pageKey + newItems.docs.length;
        _pagingController.appendPage(newItems.docs, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("최신 Q&A 게시판"),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: PagedListView.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, dynamic item, index) {
              return PostCard(docData: item);
            }
          ),
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 5,
            color: Colors.grey,
          ),
        ),
      ),

      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 40,
          child: FloatingActionButton.extended(
            onPressed: () {Get.to(MakeQuestionScreen(), transition: Transition.downToUp);},
            backgroundColor: const Color(0xFFFC896F),
            icon: const Icon(Icons.add),
            label: const Text("질문하기", style: TextStyle(fontSize: 22, color: Colors.white)),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
