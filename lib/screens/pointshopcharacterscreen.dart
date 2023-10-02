import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
//import 'package:ku_q/icons/my_flutter_app_icons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ku_q/cards/charactercard.dart';
//import 'package:ku_q/screens/characterdetailscreen.dart';
//
class PointShopCharacterScreen extends StatefulWidget {
  const PointShopCharacterScreen({super.key});

  @override
  State<PointShopCharacterScreen> createState() =>
      _PointShopCharacterScreenState();
}

class _PointShopCharacterScreenState extends State<PointShopCharacterScreen> {
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
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            /*IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.black,
                )),
             */
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
          /*
            child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                color: Colors.black12,
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Container(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('니니', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              SizedBox(width: 20,),
                              OutlinedButton(
                                onPressed: null,
                                child: Text(
                                  '보유중',
                                  style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(width: 2, color: Colors.white),
                                  minimumSize: Size(100, 20),
                                ),
                              ),
                            ],
                          ),
                          Text('니니는 용맹한 아이입니다!'),
                          OutlinedButton.icon(
                            onPressed: null,
                            icon: Text(
                              '전체 캐릭터 보기',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            label: Icon(Icons.arrow_right_alt),
                            style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.white,
                              side: const BorderSide(width: 2, color: Colors.white),
                              minimumSize: Size(100, 20),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
            */
        ),
      ),
    );
  }
}
