import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ku_q/screens/characterdetailscreen.dart';
import 'package:get/get.dart';

class CharacterCard extends StatefulWidget {
  DocumentSnapshot<Object?> docData;

  CharacterCard({super.key, required this.docData});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          widget.docData['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
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
                                    fontSize: 12, color: Colors.white),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.black87,
                                side: const BorderSide(
                                    width: 0, color: Colors.white),
                                minimumSize: Size(40, 25),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: null,
                              child: Text(
                                widget.docData['states'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.purple,
                                side: const BorderSide(
                                    width: 0, color: Colors.white),
                                minimumSize: Size(40, 25),
                              ),
                            ),
                            /*
                              TextButton(
                                onPressed: null,
                                child: Text(
                                  widget.docData['states'],
                                  //maxLines: 1,
                                  //overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12, color: Colors.black),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor: Colors.black12,
                                  side: const BorderSide(width: 0, color: Colors.white),
                                  minimumSize: Size(50, 30),
                                ),
                              ),
                              */
                          ],
                        )

                            /*
                          Text(
                            "N 시간 전",
                            style: TextStyle(fontSize: 10),
                          )
                              */
                            ),
                      )
                    ]),
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
                              widget.docData['description'],
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
                              Get.to(CharacterDetailScreen(),
                                  transition: Transition.downToUp);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 15,
                            ),
                            label: Text(
                              '꾸미기',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 1, color: Colors.black26),
                              minimumSize: Size(200, 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]),
          )
        ]));
  }
}
