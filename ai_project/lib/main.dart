import 'dart:async';
// import 'package:ai_project/CheckDiet/check_diet.dart';
// import 'package:ai_project/MemberInfo/input_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/link.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'CheckDiet/check_diet.dart';
import 'CheckDiet/date_select.dart';
import 'Login/kakao_login.dart';
// import 'Login/Login.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  KakaoContext.clientId = '29ee70f50723021973ddf4f7aca15436';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),

      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('ko', 'KR'),
      // ],
      home: const MyHomePage(),
      // home: CheckDiet(),
      // initialRoute: '/',
      // routes: {
      // '/': (context) => MyHomePage(),
      // '/second': (context) =>
      // },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return StartPage();
    return CheckDiet();
    // return InputInfo();
    // return DateSelect();
  }
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String userInfo = '';
  static final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => KakaoLogin()),
      ),
    );
  }

  _asyncMethod() async {
    userInfo = (await storage.read(key: 'login'))!;
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(userInfo);

    // if (userInfo != null) {
    //   // 로그인한 값이 저장됐으면
    //   Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => CheckDiet(),
    //       ),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Center(
          child: Text(
            '인공지능\n식단관리앱',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 50),
          ),
        ),
      ),
    );
  }
}
