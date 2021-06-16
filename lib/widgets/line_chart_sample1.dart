import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:minhttp/models/one_call.dart';
import 'package:provider/provider.dart';
import '../common/utilities.dart';

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    final onecall = Provider.of<OneCall>(context);
    final List<Current> list =
        onecall.hourly == null ? [] : onecall.hourly.sublist(0, 8);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(8),
        color: Colors.transparent,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              'weather_hourly_temp'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            AspectRatio(
              aspectRatio: size.width / 150,
              child: list.length == 0
                  ? null
                  : LineChart(
                      sampleData1(list, onecall),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1(List<Current> list, OneCall onecall) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black.withOpacity(0.5),
          getTooltipItems: (touchedSpots) {
            List<LineTooltipItem> data = [];
            data.add(LineTooltipItem(
                '${touchedSpots[0].y.getTempWithUnit(onecall.getTempUnit())}'
                    .switchMMNumber(context),
                TextStyle(
                  color: Colors.white,
                )));
            return data;
          },
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
          margin: 10,
          getTitles: (value) {
            if (value == -1 || value == list.length) return '';
            return DateFormat('h:mm a\nMMM d', context.locale.toString())
                .format(DateTime.fromMillisecondsSinceEpoch(
                    list[value.toInt()].dt * 1000));
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: -1,
      maxX: list.length.toDouble(),
      maxY: list.map((e) => e.temp).toList().reduce(max) + 2,
      minY: list.map((e) => e.temp).toList().reduce(min) - 2,
      lineBarsData: linesBarData1(list),
    );
  }

  List<LineChartBarData> linesBarData1(List<Current> list) {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      // spots: [
      //   FlSpot(1, 28),
      //   FlSpot(2, 30),
      //   FlSpot(3, 32),
      //   FlSpot(4, 34),
      //   FlSpot(5, 30),
      //   FlSpot(6, 26),
      //   FlSpot(7, 25),
      // ],
      spots: list
          .asMap()
          .map(
              (key, value) => MapEntry(key, FlSpot(key.toDouble(), value.temp)))
          .values
          .toList(),
      isCurved: true,
      colors: [
        Colors.white,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
    ];
  }
}
