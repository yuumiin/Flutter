import 'package:ai_project/Login/kakao_login.dart';
import 'package:ai_project/MemberInfo/input_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Management extends StatefulWidget {
  const Management({Key? key}) : super(key: key);

  @override
  _ManagementState createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    KakaoLogin log = KakaoLogin();

    return Scaffold(
      appBar: AppBar(
        // leading: Builder(
        //   builder: (context) => IconButton(
        //     icon: Icon(Icons.menu_rounded),
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //   ),
        // ),
        title: Text('식단관리앱'),
        backgroundColor: Color(0xFF151026),
        centerTitle: true,
        elevation: 0.0, // 그림자생김
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.person, size: 30),
            padding: EdgeInsets.only(right: 15, left: 15),
            // 왼쪽도 패딩을 같이 줘야 터치반응액션이 아이콘 중앙에 있게됨
          ),
        ], // 1개 이상의 위젯 리스트를 가짐
      ),
      body: Container(
        // color: Colors.red,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8, left: 8),
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  '회원 정보 수정',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'NanumSquare',
                      fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 1.5, color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // <-- Radius
                  ),
                ),
              ),
            ),
            Container(
                child: RaisedButton(
              child: Text("Logout"),
              onPressed: () {
                storage.delete(key: "login");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => KakaoLogin()),
                // );
                log.logOutTalk();
              },
            ))
          ],
        ),
      ),
    );
  }
}
