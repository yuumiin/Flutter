// ignore: file_names
import 'package:ai_project/CheckDiet/check_diet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../sub_main.dart';

class InputInfo extends StatefulWidget {
  const InputInfo({Key? key}) : super(key: key);

  @override
  _InputInfoState createState() => _InputInfoState();
}

class _InputInfoState extends State<InputInfo> {
  String? _chosenValue;
  int currentSegment = 0;

  TextEditingController member_height = TextEditingController();
  TextEditingController member_weight = TextEditingController();
  TextEditingController member_age = TextEditingController();

  final Map<int, Widget> segments = const <int, Widget>{
    0: Text('남자'),
    1: Text('여자'),
  };

  void text_print() {
    print('====================textfield 정보====================');
    print('키:' + member_height.value.text.toString());
    print('몸무게:' + member_weight.value.text.toString());
    print('나이:' + member_age.value.text.toString());
    print('성별:' + segments[currentSegment].toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원정보입력'),
        backgroundColor: Color(0xFF151026),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      // color: Colors.red,
                      margin: const EdgeInsets.all(50),
                      child: const Text(
                        '개인 맞춤 서비스를 위해\n신체 정보를 꼭 입력해주세요!',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NanumSquare',
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 1.5,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[350],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 40),
                      // alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '키',
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'NanumSquare'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: member_height,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                ),
                                labelText: 'cm'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '체중',
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'NanumSquare'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: member_weight,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                ),
                                labelText: 'kg'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '나이',
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'NanumSquare'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: member_age,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                ),
                                labelText: '세'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '성별',
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'NanumSquare'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Expanded(
                              child: CupertinoSlidingSegmentedControl<int>(
                                  padding: EdgeInsets.all(0),
                                  groupValue: currentSegment,
                                  children: segments,
                                  onValueChanged: (i) {
                                    setState(() {
                                      currentSegment = i!;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                // width: double.infinity,
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: FlatButton(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    // side: BorderSide(color: Color(0xFF151026), width: 5),
                  ),
                  onPressed: () {
                    text_print();
                    // Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: (context) => CheckDiet()));
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SubMain()));
                  },
                  child: Text(
                    '저장',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
