import 'package:flutter/material.dart';
import 'package:kakao_login/kakao_login_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_login/main.dart';

class test extends StatelessWidget {
  static final storage = FlutterSecureStorage();
  final String info;

  const test(this.info);

  @override
  Widget build(BuildContext context) {
    KakaoLoginButton logout = KakaoLoginButton();

    return Scaffold(
      appBar: AppBar(
        title: Text("page"),
      ),
      body: Column(
        children: [
          Text(info),
          RaisedButton(
            child: Text("Logout"),
            onPressed: () {
              storage.delete(key: "login");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
              logout.logOutTalk();
            },
          )
        ],
      ),
    );
  }
}
