import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minhttp/models/one_call.dart';
import '../common/utilities.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onecall = Provider.of<OneCall>(context);
    return Card(
      margin: EdgeInsets.all(8),
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  onecall.cityName ?? 'Loading',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        onecall.current == null
                            ? 'assets/images/01.png'
                            : 'assets/images/${onecall.current.weather[0].icon.substring(0, 2)}.png',
                        width: 112,
                        height: 112,
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        onecall.current == null
                            ? '-'
                            : onecall.current.weather[0].main.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        onecall.current == null
                            ? '-'
                            : DateFormat('d-MMM-y E', context.locale.toString())
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                    onecall.current.dt * 1000)),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        onecall.current == null
                            ? '-'
                            : DateFormat('h:mm:ss a', context.locale.toString())
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                    onecall.current.dt * 1000)),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Column(
                        children: [
                          Text(
                            '${onecall.current == null ? "-" : onecall.current.temp.getTempWithUnit(onecall.getTempUnit())}'
                                .switchMMNumber(context),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${"weather_high".tr()} ${onecall.daily == null ? "-" : onecall.daily[0].temp.max.getTempWithUnit(onecall.getTempUnit())}'
                                        .switchMMNumber(context),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${"weather_low".tr()} ${onecall.daily == null ? "-" : onecall.daily[0].temp.min.getTempWithUnit(onecall.getTempUnit())}'
                                        .switchMMNumber(context),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${"weather_real_feel".tr()} ${onecall.current == null ? "-" : onecall.current.feelsLike.getTempWithUnit(onecall.getTempUnit())}'
                                        .switchMMNumber(context),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${"weather_wind".tr()} ${onecall.current == null ? "-" : onecall.current.windSpeed} km/h'
                                        .switchMMNumber(context),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${"weather_pressure".tr()} ${onecall.current == null ? "-" : onecall.current.pressure} MB'
                                        .switchMMNumber(context),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${"weather_humidity".tr()} ${onecall.current == null ? "-" : onecall.current.humidity}%'
                                        .switchMMNumber(context),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${"weather_sunrise".tr()} ${(onecall.current == null || onecall.current.sunrise == null) ? "-" : DateFormat("h:mm a", context.locale.toString()).format(DateTime.fromMillisecondsSinceEpoch(onecall.current.sunrise * 1000))}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${"weather_sunset".tr()} ${(onecall.current == null || onecall.current.sunset == null) ? "-" : DateFormat("h:mm a", context.locale.toString()).format(DateTime.fromMillisecondsSinceEpoch(onecall.current.sunset * 1000))}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
