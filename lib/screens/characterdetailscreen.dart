import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ku_q/screens/pointshopcharacterscreen.dart';
import 'package:get/get.dart';
//import 'package:ku_q/icons/my_flutter_app_icons.dart';
import 'package:ku_q/cards/charactercard.dart';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({super.key});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
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
                  SizedBox(
                    width: 30,
                  ),
                  /*
                  IconButton(
                    onPressed: () {
                      Get.back();
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
        body: Column(
          children: [
            /*
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              color: Colors.red,
            ),
            */

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0xD0D0D0D0),
                  width: 0,
                ),
                color: const Color(0xEBEBEBEB),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.black26,
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                          ),
                          /*
                Expanded(flex: 1, child: Text(widget.docData['name'], overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10)))
                 */
                        ]),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  //color: Colors.red,
                                  //padding: const EdgeInsets.only(left: 15),
                                  // color: Colors.yellow,
                                  child: Text(
                                    '니니',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  //color: Colors.orange,
                                  child: Row(
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: null,
                                        icon: Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 15,
                                        ),
                                        label: Text(
                                          '대표',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: Colors.black87,
                                          side: const BorderSide(
                                              width: 0, color: Colors.white),
                                          //minimumSize: Size(40, 25),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: null,
                                        child: Text(
                                          '보유중',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: Colors.purple,
                                          side: const BorderSide(
                                              width: 0, color: Colors.white),
                                          //minimumSize: Size(40, 25),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    //color: Colors.black26,
                                    child: Text(
                                      '니니는 어려운 문제를 해결하는 것을 좋아하고, 남을 도와주는 것에는 언제나 진심이랍니다.',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black87),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Get.to(PointShopCharacterScreen(),
                                          transition: Transition.downToUp);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                    label: Text(
                                      '전체 캐릭터 보기',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          width: 1, color: Colors.black26),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            Column(
              children: <Widget>[
                // construct the profile details widget here
                /*
                SizedBox(
                  height: 150,
                  child: Center(
                    child: Text(
                      'Profile Details Goes here',
                    ),
                  ),
                ),
                */

                // the tab bar with two items
                SizedBox(
                  height: 80,
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.stars_outlined,
                            color: Colors.black,
                          ),
                          child: Text(
                            '추천',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.color_lens_outlined,
                            color: Colors.black,
                          ),
                          child: Text(
                            '피부색',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.black,
                          ),
                          child: Text(
                            '안경',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.headphones_outlined,
                            color: Colors.black,
                          ),
                          child: Text(
                            '모자',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.diamond_outlined,
                            color: Colors.black,
                          ),
                          child: Text(
                            '악세서리',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.emoji_objects_outlined,
                            color: Colors.black,
                          ),
                          child: Text(
                            '이펙트',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // second tab bar view widget
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        '피부색 목록',
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.orange,
                    child: Center(
                      child: Text(
                        'what?',
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.blue,
                  ),

                  Container(
                    color: Colors.yellow,
                  ),

                  Container(
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            /*
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.stars_outlined),
                        ),
                        Text('추천'),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.color_lens_outlined),
                        ),
                        Text('피부색'),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.remove_red_eye_outlined),
                        ),
                        Text('안경'),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.headphones_outlined),
                        ),
                        Text(
                          '모자',
                          style: TextStyle(fontFamily: 'Nanum'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.diamond_outlined),
                        ),
                        Text('악세사리'),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.emoji_objects_outlined),
                        ),
                        Text('이펙트'),
                      ],
                    ),
                  )
                ],
              ),
            ),
                  */
          ],
        ),
      ),
    );
  }
}
