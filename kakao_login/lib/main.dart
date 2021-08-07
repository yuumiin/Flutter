import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/link.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'kakao_login_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'page.dart';

void main() {
  KakaoContext.clientId = '29ee70f50723021973ddf4f7aca15436';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kakao login',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userInfo = '';
  static final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    userInfo = (await storage.read(key: 'login'))!;
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(userInfo);

    if (userInfo != null) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => test(userInfo),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('kakao login'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: deviceSize.width * 0.9,
                child: KakaoLoginButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
