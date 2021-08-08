import 'package:flutter/material.dart';

class DropDownUI extends StatefulWidget {
  const DropDownUI({Key? key}) : super(key: key);

  @override
  _DropDownUIState createState() => _DropDownUIState();
}

class _DropDownUIState extends State<DropDownUI> {
  bool enableList = false;
  int? _selectedIndex;
  _onhandleTap() {
    setState(() {
      enableList = !enableList;
    });
  }

  List<Map> _testList = [
    {'no': 1, 'keyword': '아침'},
    {'no': 2, 'keyword': '점심'},
    {'no': 3, 'keyword': '저녁'},
  ];

  _onChanged(int position) {
    setState(() {
      _selectedIndex = position;
      enableList = !enableList;
    });
  }

  Widget _buildSearchList() => Center(
        child: Container(
          // color: Colors.orange,
          width: 150,
          height: 150.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          margin: EdgeInsets.only(top: 5.0),
          child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: _testList.length,
              itemBuilder: (context, position) {
                return InkWell(
                  onTap: () {
                    _onChanged(position);
                  },
                  child: Container(
                      // color: Colors.red,
                      // padding: widget.padding,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: position == _selectedIndex
                              ? Colors.grey[100]
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      child: Text(
                        _testList[position]['keyword'],
                        style: TextStyle(color: Colors.black),
                      )),
                );
              }),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: _onhandleTap,
              child: Container(
                // color: Colors.blue,
                width: 120, //// 여기만 바꿔서 크기 조정
                decoration: BoxDecoration(
                  border: Border.all(
                      color: enableList ? Colors.black : Colors.grey,
                      width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 48.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _selectedIndex != null
                          ? _testList[_selectedIndex!]['keyword']
                          : "시간 선택",
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    )),
                    Icon(Icons.expand_more,
                        size: 24.0, color: Color(0XFFbbbbbb)),
                  ],
                ),
              ),
            ),
            enableList ? _buildSearchList() : Container(),
          ],
        ),
      ),
    );
  }
}
