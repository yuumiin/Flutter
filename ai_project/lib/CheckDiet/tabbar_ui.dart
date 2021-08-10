import 'package:ai_project/CheckDiet/check_diet.dart';
import 'package:ai_project/MemberInfo/input_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarUI extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: TabBarWidget(),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(Icons.restaurant_rounded)),
      // BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded)),
      BottomNavigationBarItem(icon: Icon(Icons.thumb_down_alt_rounded)),
      BottomNavigationBarItem(icon: Icon(Icons.add_chart_rounded)),
    ];

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: items),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CheckDiet();
            case 1:
              return InputInfo();
            case 2:
              return Container(
                child: Text('통계'),
              );
            default:
              return CheckDiet();
          }
        });
  }
}
