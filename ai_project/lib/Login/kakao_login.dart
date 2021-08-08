import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:ai_project/MemberInfo/input_info.dart';

class KakaoLogin extends StatefulWidget {
  const KakaoLogin({Key? key}) : super(key: key);
  get logOutTalk => null;

  @override
  _KakaoLoginState createState() => _KakaoLoginState();
}

class _KakaoLoginState extends State<KakaoLogin> {
  static final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao installed = $installed');
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  bool _isKakaoTalkInstalled = true;

  // _checkAccessToken() async {
  //   var token = await AccessTokenStore.instance.fromStore();
  //   debugPrint(token.toString());
  // }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      print('code:');
      print(code);
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _getUserId() async {
    User user = await UserApi.instance.me();
    return user.kakaoAccount!.profile!.nickname.toString();
  }

  _getUserEmail() async {
    User user = await UserApi.instance.me();
    return user.kakaoAccount!.email.toString();
  }

  _getUserInfo() async {
    User user = await UserApi.instance.me();
    print(
        "=========================[kakao account]=================================");
    print(user.kakaoAccount.toString());
    print(user.toString());
    print(
        "=========================[kakao account]=================================");
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      await _getUserInfo();
      var userId = await _getUserId();
      var userEmail = await _getUserEmail();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InputInfo()),
      );
      await storage.write(key: 'login', value: userEmail);
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  logOutTalk() async {
    print('호출됨!');
    try {
      var code = await UserApi.instance.logout();
      print('logOutTalk code=${code.toString()}');
    } catch (e) {
      print('logOutTalk error=${e.toString()}');
    }
  }

  unlinkTalk() async {
    try {
      var code = await UserApi.instance.unlink();
      print('unlinkTalk code=${code.toString()}');
    } catch (e) {
      print('unlinkTalk error=${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color(0xFF151026),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('식단관리 어플이 처음이라면?'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoButton(
                  onPressed:
                      _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
                  child: Image.asset(
                    'image/kakao_login_large_wide.png',
                    width: 300,
                    height: 50,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
