import 'package:flutter/material.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설문조사'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // 검색 창
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '검색어를 입력하세요',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0), // 스페이스바 한 칸 정도의 간격
                // '만들기' 버튼
                ElevatedButton(
                  onPressed: () {
                    // '만들기' 버튼을 눌렀을 때의 동작을 정의
                  },
                  child: Text('검색하기'),
                ),
              ],
            ),
            SizedBox(height: 16.0), // 검색 창과 버튼 사이 간격 조절

            // 큰 사각형 안에 작은 사각형 4개를 1X4 형태로 배열
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
                children: [
                  _buildSmallRectangle('제목 1', '<진행 중>', Colors.deepOrange, context),
                  SizedBox(height: 8.0),
                  _buildSmallRectangle('제목 2', '<진행 중>', Colors.deepOrange, context),
                  SizedBox(height: 8.0),
                  _buildSmallRectangle('제목 3', '<종료>', Colors.grey, context),
                  SizedBox(height: 8.0),
                  _buildSmallRectangle('제목 4', '<진행 중>', Colors.deepOrange, context),
                ],
              ),
            ),
            SizedBox(width: 8.0)
            // 나머지 컨텐츠들을 추가하는 부분
            // ...
          ],
        ),
      ),
    );
  }

  Widget _buildSmallRectangle(String title, String subText, Color backgroundColor, BuildContext context) {
    return GestureDetector( // GestureDetector 추가
      onTap: () {
        // 화살표를 클릭했을 때의 동작을 정의
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InnerPostScreen(title: title, subText: subText),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: backgroundColor, // 배경색 변경
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft, // 좌측 정렬
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(subText, style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InnerPostScreen extends StatelessWidget {
  final String title;
  final String subText;

  const InnerPostScreen({required this.title, required this.subText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              subText,
              style: TextStyle(fontSize: 18.0),
            ),
            // 여기에 내부 게시글 컨텐츠를 추가할 수 있음
          ],
        ),
      ),
    );
  }
}
