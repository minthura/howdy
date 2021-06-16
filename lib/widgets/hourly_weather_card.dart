import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minhttp/models/one_call.dart';
import 'package:provider/provider.dart';
import '../common/utilities.dart';

class HourlyWeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onecall = Provider.of<OneCall>(context);
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
              return getDay(onecall.hourly[index], onecall, context);
            },
            itemCount: onecall.hourly == null ? 0 : onecall.hourly.length,
          ),
        ),
      ),
    );
  }

  Widget getDay(Current hourly, OneCall onecall, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${DateFormat("MMM d", context.locale.toString()).format(DateTime.fromMillisecondsSinceEpoch(hourly.dt * 1000))}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '${DateFormat("h:mm a", context.locale.toString()).format(DateTime.fromMillisecondsSinceEpoch(hourly.dt * 1000))}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Image.asset(
            hourly.weather == null
                ? 'assets/images/01.png'
                : 'assets/images/${hourly.weather[0].icon.substring(0, 2)}.png',
            width: 48,
            height: 48,
            color: Colors.white,
          ),
          Text(
            '${hourly.temp.getTempWithUnit(onecall.getTempUnit())}'
                .switchMMNumber(context),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
