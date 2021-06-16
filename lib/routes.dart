import 'package:flutter/material.dart';
import 'package:mmc/screens/home_screen.dart';
import 'package:mmc/screens/settings_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.route: (ctx) => HomeScreen(),
  SettingsScreen.route: (ctx) => SettingsScreen(),
};
