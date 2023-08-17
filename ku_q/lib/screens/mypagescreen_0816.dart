import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              '마이페이지',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            actions: [IconButton(onPressed: null, icon: Icon(Icons.settings))],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    OutlineCircleButton(
                        child: Icon(Icons.people_alt),
                        radius: 100.0,
                        borderSize: 0.5,
                        onTap: () async {}),
                    SizedBox(
                      width: 50,
                    ),
                    OutlinedButton(onPressed: null, child: Text('닉네임 \n 전공'))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton.icon(
                      onPressed: null,
                      icon: Text(
                        '내 캐릭터 관리',
                        style: TextStyle(color: Colors.black),
                      ),
                      label: Icon(Icons.arrow_right_alt),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(width: 2, color: Colors.black),
                        minimumSize: Size(100, 40),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton.icon(
                      onPressed: null,
                      icon: Text(
                        '포인트샵 가기',
                        style: TextStyle(color: Colors.black),
                      ),
                      label: Icon(Icons.arrow_right_alt),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(width: 2, color: Colors.black),
                        minimumSize: Size(100, 40),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "나의 등급",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    TextButton(
                      onPressed: null,
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('등급'),
                    Text('누적 채택 수'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.catching_pokemon,
                        color: Colors.orange,
                      ),
                      label: Text(
                        '고양이 %d 마리',
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(width: 2, color: Colors.black),
                        minimumSize: Size(100, 40),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.gamepad,
                        color: Colors.red,
                      ),
                      label: Text(
                        '채택 N회',
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(width: 2, color: Colors.black),
                        minimumSize: Size(100, 40),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.star_border_rounded,
                        color: Colors.black,
                      ),
                      label: Text(
                        "나의 질문",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    TextButton(
                      onPressed: null,
                      child: const Text(">",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.question_mark,
                        color: Colors.black,
                      ),
                      label: Text(
                        "나의 답변",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    TextButton(
                      onPressed: null,
                      child: const Text(">",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.question_answer_outlined,
                        color: Colors.black,
                      ),
                      label: Text(
                        "내가 스크랩한 글",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    TextButton(
                      onPressed: null,
                      child: const Text(">",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class OutlineCircleButton extends StatelessWidget {
  OutlineCircleButton({
    Key? key,
    this.onTap,
    this.borderSize = 0.5,
    this.radius = 20.0,
    this.borderColor = Colors.white,
    this.foregroundColor = Colors.white,
    this.child,
  }) : super(key: key);

  final onTap;
  final radius;
  final borderSize;
  final borderColor;
  final foregroundColor;
  final child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderSize),
          color: foregroundColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              child: child ?? SizedBox(),
              onTap: () async {
                if (onTap != null) {
                  onTap();
                }
              }),
        ),
      ),
    );
  }
}
