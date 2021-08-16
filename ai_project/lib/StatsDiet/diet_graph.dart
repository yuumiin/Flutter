import 'dart:io';

import 'package:ai_project/CheckDiet/add_diet.dart';
import 'package:ai_project/MemberInfo/management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../CheckDiet/menu_button_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class DietGraph extends StatefulWidget {
  const DietGraph({Key? key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<DietGraph> {
  late List<Series<MyNutrition, String>> seriesList;
  static List<Series<MyNutrition, String>> _createRandomData() {
    final random = Random();

    final TanData = [
      MyNutrition('8/13', random.nextInt(10)),
      MyNutrition('8/14', random.nextInt(10)),
      MyNutrition('8/15', random.nextInt(10)),
    ];

    final DanData = [
      MyNutrition('8/13', random.nextInt(10)),
      MyNutrition('8/14', random.nextInt(10)),
      MyNutrition('8/15', random.nextInt(10)),
    ];

    final JiData = [
      MyNutrition('8/13', random.nextInt(50)),
      MyNutrition('8/14', random.nextInt(50)),
      MyNutrition('8/15', random.nextInt(50)),
    ];

    return [
      Series<MyNutrition, String>(
        id: 'Nutrition',
        domainFn: (MyNutrition nut, _) => nut.date,
        measureFn: (MyNutrition nut, _) => nut.nutrition,
        data: TanData,
        fillColorFn: (MyNutrition nut, _) {
          return MaterialPalette.red.shadeDefault;
        },
      ),
      Series<MyNutrition, String>(
        id: 'Nutrition',
        domainFn: (MyNutrition nut, _) => nut.date,
        measureFn: (MyNutrition nut, _) => nut.nutrition,
        data: DanData,
        fillColorFn: (MyNutrition nut, _) {
          return MaterialPalette.blue.shadeDefault;
        },
      ),
      Series<MyNutrition, String>(
        id: 'Nutrition',
        domainFn: (MyNutrition nut, _) => nut.date,
        measureFn: (MyNutrition nut, _) => nut.nutrition,
        data: JiData,
        fillColorFn: (MyNutrition nut, _) {
          return MaterialPalette.green.shadeDefault;
        },
      )
    ];
  }

  barChart() {
    return BarChart(
      seriesList,
      animate: true,
      vertical: true,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('식단통계'),
        // backgroundColor: Color(0xFF151026),
        centerTitle: true,
        elevation: 0.0, // 그림자생김
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),

        child: barChart(),
        // child: Column(
        //   children: [
        //     SizedBox(
        //       height: 60.0,
        //     ),
        //     Text(
        //       '섭취량 트렌드',
        //     ),
        //     SizedBox(
        //       //height: 40.0,
        //     ),

        //   ],
        // )
      ),
    );
  }
}

class MyNutrition {
  final String date;
  final int nutrition;

  MyNutrition(this.date, this.nutrition);
}
