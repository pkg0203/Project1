import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ScrollBehaviorWithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class SurveyOption extends StatefulWidget {
  DocumentSnapshot<Object?> docData;

  bool isDuplicated;
  String Superkey;
  SurveyOption({super.key, required this.docData,required this.isDuplicated,required this.Superkey});

  @override
  State<SurveyOption> createState() => _SurveyOptionState();
}

class _SurveyOptionState extends State<SurveyOption> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  late bool participated;
  bool isSelected = false;
  late String option;
  late bool Duplicate_survey;
  late DocumentReference docRef;
  late DocumentReference Superior_collection;



  @override
  void initState() {
    option = widget.docData['title'];
    Duplicate_survey = widget.isDuplicated;
    docRef = widget.docData.reference;
    Superior_collection=fireStore.collection('Survey').doc(widget.Superkey);
    isSelected = widget.docData['VotedUser'].contains(fireAuth.currentUser?.uid);
    // initState 내에서 초기화
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  async{
        //중복 선택 투표
        if (Duplicate_survey) {
          if (!isSelected) {
            Plus_TVN();
            Plus_VN_UI();
            setState(() {
              isSelected = true;
            });
          }
          //선택된 것(빨간색)을 선택하는 경우
          else if (isSelected) {
            Min_TVN();
            Min_VN_UI();
            setState(() {
              isSelected = false;
            });
          }
        }
        //단일 선택 투표
        else if(!Duplicate_survey){
          final snapshot = await Superior_collection.get();
          participated = snapshot['VotedUser'].contains(fireAuth.currentUser?.uid);
          if(participated) {
            if(!isSelected){
              showDialog(context: context, builder: (context) {
                return const AlertDialog(
                    title: Text("이미 투표하셨습니다.\n취소 후 선택해주세요.")
                );
              });
            }
              if(isSelected){
                Min_TVN();
                Min_VN_UI();
                S_Min_UI();
                setState(() {
                  isSelected = false;
                });
              }
          }
          //참여하지 않은 사람
          else{
            if(!isSelected){
              Plus_TVN();
              Plus_VN_UI();
              S_Plus_UI();
              setState(() {
                isSelected = true;
              });
            }
            else{
              //참여하지 않았는데 빨간 버튼으로 표시될 수 없다.
            }
          }
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 30,
              margin: const EdgeInsets.only(bottom: 5, top: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // 테두리 색상을 검은색으로 설정
                  width: 2.0, // 테두리 두께를 조절 (원하는 두께로 변경)
                ),
                color: isSelected ? Color(0xffFFD2A9) : Colors.white,
              ),
              child: Center(
                child: Text(option, style: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void Plus_VN_UI() {
    fireStore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      // ignore: non_constant_identifier_names
      final Updated = snapshot.get("VotedNumber") + 1;
      transaction.update(docRef, {"VotedNumber": Updated});
      transaction.update(docRef, {"VotedUser": FieldValue.arrayUnion([fireAuth.currentUser?.uid])});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }
  void Min_VN_UI() {
    fireStore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      // ignore: non_constant_identifier_names
      final Updated = snapshot.get("VotedNumber") - 1;
      transaction.update(docRef, {"VotedNumber": Updated});
      transaction.update(docRef, {"VotedUser": FieldValue.arrayRemove([fireAuth.currentUser?.uid])});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }
  void Plus_TVN() {
    fireStore.runTransaction((transaction) async {
      final snapshot = await transaction.get(Superior_collection);
      final Updated = snapshot.get("TVN") + 1;
      transaction.update(Superior_collection, {"TVN": Updated});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }
  void Min_TVN() {
    fireStore.runTransaction((transaction) async {
      final snapshot = await transaction.get(Superior_collection);
      final Updated = snapshot.get("TVN") - 1;
      transaction.update(Superior_collection, {"TVN": Updated});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }

  void S_Min_UI() {
    fireStore.runTransaction((transaction) async {
      transaction.update(Superior_collection, {"VotedUser": FieldValue.arrayRemove([fireAuth.currentUser?.uid])});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }
  void S_Plus_UI() {
    fireStore.runTransaction((transaction) async {
      transaction.update(Superior_collection, {"VotedUser": FieldValue.arrayUnion([fireAuth.currentUser?.uid])});
    }).then(
          (value) => {print("success")},
      onError: (e) => {print(e)},
    );
  }
}




