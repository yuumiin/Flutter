import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

import 'CheckDiet/check_diet.dart';
import 'MemberInfo/input_info.dart';

class SubMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubMain();
  }
}

class _SubMain extends State<SubMain> with TickerProviderStateMixin {
  // CupertinoTabBar? tabBar;

  // @override
  // void initState() {
  //   super.initState();
  //   tabBar = CupertinoTabBar(items: <BottomNavigationBarItem>[
  //     BottomNavigationBarItem(icon: Icon(Icons.restaurant_rounded)),
  //     BottomNavigationBarItem(icon: Icon(Icons.thumb_up_alt_rounded)),
  //     BottomNavigationBarItem(icon: Icon(Icons.add_chart_rounded)),
  //   ]);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoApp(
  //     localizationsDelegates: [
  //       DefaultMaterialLocalizations.delegate,
  //       DefaultCupertinoLocalizations.delegate,
  //       DefaultWidgetsLocalizations.delegate,
  //     ],
  //     home: CupertinoTabScaffold(
  //         tabBar: tabBar!,
  //         tabBuilder: (context, value) {
  //           switch (value) {
  //             case 0:
  //               return CheckDiet();
  //             case 1:
  //               return InputInfo();
  //             case 2:
  //               return Container(
  //                 child: Text('통계'),
  //               );
  //             default:
  //               return CheckDiet();
  //           }
  //         }),
  //   );
  // }

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "식단조회",
        labels: const ["식단조회", "식단추천", "식단통계"],
        icons: const [
          Icons.restaurant_rounded,
          Icons.thumb_up_alt_rounded,
          Icons.add_chart_rounded,
        ],
        // badges: [
        //   Container(
        //     child: const MotionBadgeWidget(
        //       textColor: Colors.red, // optional, default to Colors.white
        //       color: Colors.red, // optional, default to Colors.red
        //       size: 18, // optional, default to 18
        //     ),
        //   ),
        //   Container(
        //     child: const MotionBadgeWidget(
        //       textColor: Colors.white, // optional, default to Colors.white
        //       color: Colors.red, // optional, default to Colors.red
        //       size: 18, // optional, default to 18
        //     ),
        //   ),
        //   Container(
        //     child: const MotionBadgeWidget(
        //       textColor: Colors.white, // optional, default to Colors.white
        //       color: Colors.red, // optional, default to Colors.red
        //       size: 18, // optional, default to 18
        //     ),
        //   )
        // ],
        tabSize: 50, // 탭바 버튼 눌렀을 때 동그라미 크기
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontFamily: 'NanumSquare',
          fontWeight: FontWeight.w800,
        ),
        tabIconColor: Color(0xFF151026),
        tabIconSize: 28.0,

        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.grey[300],
        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
      body: TabBarView(
        dragStartBehavior: DragStartBehavior.start,
        physics:
            const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const CheckDiet(),
          const Center(
            child: Text("식단추천"),
          ),
          const Center(
            child: Text("통계"),
          ),
        ],
      ),
    );
  }
}
