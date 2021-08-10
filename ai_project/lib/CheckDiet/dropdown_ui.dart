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
    print(enableList);
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

  Widget _buildSearchList() => Container(
        // height: 40,
        // color: Colors.amber,
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
            // physics: const BouncingScrollPhysics(
            //     parent: AlwaysScrollableScrollPhysics()),
            itemCount: _testList.length,
            itemBuilder: (context, position) {
              return InkWell(
                onTap: () {
                  _onChanged(position);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: position == _selectedIndex
                            ? Colors.grey[100]
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0))),
                    child: Text(
                      _testList[position]['keyword'],
                      style: const TextStyle(color: Colors.black),
                    )),
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            // height: 40,
            child: InkWell(
              onTap: _onhandleTap, // enableList = true
              child: Container(
                // alignment: Alignment.,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: enableList ? Colors.black : Colors.grey,
                      width: 1.5),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0), // 화살표 패딩
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _selectedIndex != null
                          ? _testList[_selectedIndex!]['keyword']
                          : "시간 선택",
                      style: const TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    )),
                    const Icon(Icons.expand_more,
                        size: 24.0, color: Color(0XFFbbbbbb)),
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.grey, width: 1),
          //     borderRadius: BorderRadius.all(Radius.circular(5)),
          //     color: Colors.white,
          //   ),
          // )
          // _buildSearchList()
          enableList ? _buildSearchList() : Container(color: Colors.amber),
        ],
      ),
    );
  }
}
