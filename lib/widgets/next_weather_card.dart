import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minhttp/minhttp.dart';
import 'package:provider/provider.dart';
import '../common/utilities.dart';

class NextWeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onecall = Provider.of<OneCall>(context);
    // final Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(8),
      color: Colors.transparent,
      child: Container(
        height: 170,
        padding: EdgeInsets.all(8),
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return getDay(onecall.daily[index], onecall, context);
            },
            itemCount: onecall.daily == null ? 0 : onecall.daily.length,
          ),
        ),
      ),
    );
  }

  Widget getDay(Daily daily, OneCall oneCall, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${DateFormat("E", context.locale.toString()).format(DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000))}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            '${DateFormat("MMM d", context.locale.toString()).format(DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000))}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Image.asset(
            'assets/images/${daily.weather[0].icon.substring(0, 2)}.png',
            width: 48,
            height: 48,
            color: Colors.white,
          ),
          Text(
            '${daily.temp.day.getTempWithUnit(oneCall.getTempUnit())}'
                .switchMMNumber(context),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
