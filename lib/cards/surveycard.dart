import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:ku_q/cards/surveyoption.dart';

class SurveyCard extends StatefulWidget {
  DocumentSnapshot<Object?> docData;
  SurveyCard({super.key, required this.docData});

  @override
  State<SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final int _pageSize = 5;
  final double container_size = 150;
  // ignore: non_constant_identifier_names
  //late double Option_number=3;
  late String title;
  late bool state;
  late bool isDuplicated;
  late String Superkey;

  //변수 초기화
  @override
  void initState() {
    title = widget.docData['title'];
    state = widget.docData['state'];
    isDuplicated = widget.docData['duplicate'];
    Superkey = widget.docData['Superkey'];
    //Option_number = widget.docData['Option_number'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: state ? Colors.orange : Colors.grey,
            ),
            child: Text(
              state ? "<진행 중>" : "<종료>",
              style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
      children: [
        //바깥쪽 흰색 사각형
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          color: Colors.white,
          child: ScrollConfiguration(
            behavior: ScrollBehaviorWithoutGlow(),
            child: Center(
              //70%의 테두리 없는 사각형
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: container_size,
                child: FirestoreListView<Map<String, dynamic>>(
                  pageSize: _pageSize,
                  query: firestore.collection('Survey').doc(Superkey).collection('Options'),
                  itemBuilder: (context, snapshot) {
                    return SurveyOption(docData: snapshot, isDuplicated: isDuplicated, Superkey: Superkey);
                  },
                  //itemExtent: 40,
                ),
              ),
            ),
          ),
        ),

        FilledButton(
          onPressed: () {
            // 버튼이 눌렸을 때 수행할 작업을 여기에 추가합니다.
            // 예를 들어 결과를 보여주는 화면으로 이동하거나 다른 동작을 수행할 수 있습니다.
          },
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xffFFD2A9),
            fixedSize: Size(160, 30), // 너비와 높이를 원하는 값으로 설정하세요.
          ),
          child: Text(
            '결과보기',
            style: TextStyle(
              color: Colors.black, // 글씨 색상을 검정색으로 설정
              fontWeight: FontWeight.bold, // 굵은 글꼴로 설정
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

/*Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: container_size,
                child: FirestoreListView<Map<String, dynamic>>(
                  pageSize: _pageSize,
                  query: firestore.collection('Survey').doc(Superkey).collection('Options'),
                  itemBuilder: (context, snapshot) {
                    return SurveyOption(docData: snapshot, isDuplicated: isDuplicated, Superkey: Superkey);
                  },
                  //itemExtent: 40,
                ),
              ),*/
