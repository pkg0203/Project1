import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ku_q/screens/survey_post_screen.dart';


class SurveyCard extends StatefulWidget {
  DocumentSnapshot<Object?> docData;
  SurveyCard({super.key, required this.docData});

  @override
  State<SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
 late String title;
 late bool state;
 late num option_number;
 late QuerySnapshot option;
 //변수 초기화
 @override
  void initState(){
   title = widget.docData['title'];
   state = widget.docData['state'];
   option_number = widget.docData['Option_number'];
   widget.docData.reference.collection('Options').get().then(
       (snapshot) => option = snapshot
   );
   super.initState();
 }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurveyPost(title: title, option_number: option_number, option : option),
          ),
        );
      },

      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.only(bottom: 15),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: state ? Colors.orange : Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  state?   "<진행 중>": "<종료>",
                  style: TextStyle(fontSize: 12.0,color: Colors.grey[800]),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
