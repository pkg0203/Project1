


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
//import 'package:ku_q/icons/my_flutter_app_icons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ku_q/cards/charactercard.dart';
//import 'package:ku_q/screens/characterdetailscreen.dart';


class PointShopScreen extends StatefulWidget {
  const PointShopScreen({super.key});

  @override
  State<PointShopScreen> createState() => _PointShopScreenState();
}

class _PointShopScreenState extends State<PointShopScreen> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static const _pageSize = 5;
  final PagingController _pagingController = PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fireStore
          .collection('Character')
          .orderBy("name")
          .startAt([pageKey])
          .limit(_pageSize)
          .get();
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            '포인트샵',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          actions: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 13),
              child: Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: null,
                    icon: Icon(
                      Icons.alarm,
                      //MyFlutterApp.cat,
                      color: Color(0xFFFC896F),
                      size: 12,
                    ),
                    label: Text(
                      '고양이 d 마리',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.black12,
                      side: const BorderSide(width: 2, color: Colors.white),
                      //minimumSize: Size(100, 30),
                    ),
                  ),
                  TextButton(
                    onPressed: null,
                    child: Text(
                      'NNN 냥',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.black12,
                      side: const BorderSide(width: 2, color: Colors.white),
                      //minimumSize: Size(100, 30),
                    ),
                  ),
                  /*
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                  */
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PagedListView.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, dynamic item, index) {
                  return CharacterCard(docData: item);
                }),
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(
              height: 5,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
