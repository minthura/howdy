import 'package:flutter/material.dart';
import 'package:mmc/screens/settings_screen.dart';
import 'package:mmc/widgets/current_weather_card.dart';
import 'package:mmc/widgets/hourly_weather_card.dart';
import 'package:mmc/widgets/line_chart_sample1.dart';
import 'package:mmc/widgets/next_weather_card.dart';
import 'package:minhttp/models/one_call.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<OneCall>(context, listen: false).getData((e) {
        print('error OneCall');
        print(e.error);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text('app_title'.tr()),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.route);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.jpeg',
            width: size.width,
            fit: BoxFit.cover,
            height: size.height,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FadeInLeft(child: CurrentWeatherCard()),
                  FadeInRight(child: NextWeatherCard()),
                  FadeInLeft(child: LineChartSample1()),
                  FadeInRight(child: HourlyWeatherCard()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void callApi(BuildContext context) {
    final onecall = Provider.of<OneCall>(context, listen: false);
    if (onecall.getTempUnit() == TempUnit.C)
      onecall.updateUnit(TempUnit.F);
    else
      onecall.updateUnit(TempUnit.C);
  }
}
