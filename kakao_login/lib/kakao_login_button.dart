import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'login_result_page.dart';
import 'package:flutter/cupertino.dart';
import 'page.dart';

class KakaoLoginButton extends StatefulWidget {
  const KakaoLoginButton({Key? key}) : super(key: key);

  get logOutTalk => null;

  @override
  _KakaoLoginButtonState createState() => _KakaoLoginButtonState();
}

class _KakaoLoginButtonState extends State<KakaoLoginButton> {
  // String userInfo = '';
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

  _checkAccessToken() async {
    var token = await AccessTokenStore.instance.fromStore();
    debugPrint(token.toString());
  }

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
    print(
        "=========================[kakao account]=================================");
    print(user.kakaoAccount.toString());
    print(user.toString());

    print(
        "=========================[kakao account]=================================");
    // user.kakaoAccount!.email!;
    return user.kakaoAccount!.email.toString();
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      var userId = await _getUserId();
      var userEmail = await _getUserEmail();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login(userId, userEmail)),
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
    var deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        RaisedButton(
          onPressed: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
          color: Colors.yellow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'image/kakao_login.png',
                width: deviceSize.width * 0.1,
              ),
              SizedBox(
                width: deviceSize.width * 0.1,
              ),
              Text('KaKao Login'),
            ],
          ),
        ),
        RaisedButton(
          child: Text("Logout"),
          onPressed: logOutTalk,
        )
      ],
    );
  }
}
