import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ku_q/screens/characterdetailscreen.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CharacterCard extends StatefulWidget {
  DocumentSnapshot<Object?> docData;

  CharacterCard({super.key, required this.docData});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  //StringBuffer imageurl = widget.docData['characpicurl'];
  //String imageurl = 'https://firebasestorage.googleapis.com/v0/b/ku-q-6124f.appspot.com/o/IMG_6193.JPG?alt=media&token=fb42cded-03a2-4730-bbd7-b8649de93b97';
  static Future<dynamic> loadFromStorage(
      BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

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
                  /*
                  Container(
                      color: Colors.orange,
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.docData['characpicurl']),
                              fit: BoxFit.cover)),
                      child:BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                            color: Colors.black.withOpacity(0.1)
                        ),
                      )
                  ),
                  */

                  Container(
                    color: Colors.orange,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    //child: Image.network(widget.docData['characpicurl']),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Image(
                        image: NetworkImage(widget.docData['characpicurl']),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                                  style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor: Colors.black87,
                                  side: const BorderSide(
                                      width: 0, color: Colors.white),
                                  minimumSize: Size(40, 30),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 30,
                                child: (() {
                                  if (widget.docData['states'] == '보유중') {
                                    return TextButton(
                                      onPressed: null,
                                      child: Text(
                                        '보유중',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        backgroundColor: Colors.purple,
                                        side: const BorderSide(
                                            width: 0, color: Colors.white),
                                        //minimumSize: Size(40, 15),
                                      ),
                                    );
                                  }
                                  else {
                                    return const Text('');
                                  }
                                })(),
                              ),
                            ],
                          )),
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => CharacterDetailScreen()));
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
