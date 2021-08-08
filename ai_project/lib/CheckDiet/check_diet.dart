import 'package:ai_project/CheckDiet/dropdown_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
// import 'package:share/share.dart';
// import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CheckDiet extends StatefulWidget {
  const CheckDiet({Key? key}) : super(key: key);

  @override
  _CheckDietState createState() => _CheckDietState();
}

class _CheckDietState extends State<CheckDiet> {
  // DateTime? _selectedDate;
  String _date = "날짜 선택";
  final _valueList = ['아침', '점심', '저녁'];
  var _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('식단관리앱'),
        centerTitle: true,
        elevation: 0.0, // 그림자생김
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print('shopping_cart button is clicked');
            },
            icon: Icon(Icons.person, size: 30),
            padding: EdgeInsets.only(right: 15, left: 15),
            // 왼쪽도 패딩을 같이 줘야 터치반응액션이 아이콘 중앙에 있게됨
          ),
        ], // 1개 이상의 위젯 리스트를 가짐
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 8,
              ),
              Container(
                child: Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      datePicker(context);
                    },
                    icon: Icon(
                      Icons.date_range,
                      color: Colors.black,
                      size: 30,
                    ),
                    label: Text(
                      _date,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1.5, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              // DropDownUI(),
              // Expanded(child: DropDownUI()),
              SizedBox(
                width: 8,
              ),
              RaisedButton(
                child: Text(
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
              SizedBox(
                width: 8,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 1.5,
            width: MediaQuery.of(context).size.width - 40,
            color: Colors.grey[350],
          ),
          Expanded(child: DropDownUI()),
        ],
      ),
    );
  }

  datePicker(context) {
    // String _date = "Date of Birth";
    String _textfield_date = "";
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2030), onConfirm: (date) {
      print('confirm $date');
      _date = '${date.year}/${date.day}/${date.month}';
      setState(() {
        Text(_date);
      });
    }, currentTime: DateTime.now(), locale: LocaleType.ko);
    return _date;
  }
}
