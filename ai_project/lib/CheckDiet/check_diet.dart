// import 'package:ai_project/CheckDiet/dropdown_ui.dart';
import 'dart:io';

import 'package:ai_project/CheckDiet/add_diet.dart';
import 'package:ai_project/MemberInfo/management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'menu_button_ui.dart';
import 'package:image_picker/image_picker.dart';

class CheckDiet extends StatefulWidget {
  // CheckDiet(this.image);
  // final File image;
  const CheckDiet({Key? key}) : super(key: key);
  @override
  _CheckDietState createState() => _CheckDietState();
}

class _CheckDietState extends State<CheckDiet>
    with AutomaticKeepAliveClientMixin {
  String _date = "날짜 선택";
  final _valueList = ['아침', '점심', '저녁'];
  var _selectedValue;
  CupertinoTabBar? tabBar;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final File returnImage = ModalRoute.of(context)!.settings.arguments as File;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('식단관리앱'),
        backgroundColor: Color(0xFF151026),
        centerTitle: true,
        elevation: 0.0, // 그림자생김
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print('shopping_cart button is clicked');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Management()));
            },
            icon: Icon(Icons.person, size: 30),
            padding: EdgeInsets.only(right: 15, left: 15),
            // 왼쪽도 패딩을 같이 줘야 터치반응액션이 아이콘 중앙에 있게됨
          ),
        ], // 1개 이상의 위젯 리스트를 가짐
      ),
      floatingActionButton: AddButton(),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        height: 42,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            datePicker(context);
                          },
                          icon: const Icon(
                            Icons.date_range,
                            color: Colors.black,
                            size: 25,
                          ),
                          label: Text(
                            _date,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 1.5, color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: NormalMenuButton(
                          theme: theme,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 42,
                      width: 70,
                      child: RaisedButton(
                        child: const Text(
                          '조회',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'NanumSquareRound',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.red[100],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              height: 1.5,
              width: MediaQuery.of(context).size.width - 20,
              color: Colors.grey[350],
            ),
            // Image.file(
            //   returnImage,
            //   fit: BoxFit.fill,
            // ),
          ],
        ),
      ),
    );
  }

  datePicker(context) {
    String _textfield_date = "";
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2030), onConfirm: (date) {
      print('confirm $date');
      _date = '${date.year}/${date.month}/${date.day}';
      setState(() {
        Text(_date);
      });
    }, currentTime: DateTime.now(), locale: LocaleType.ko);
    return _date;
  }
}
