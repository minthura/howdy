import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mmc/app.dart';
import 'package:provider/provider.dart';
import 'package:minhttp/models/one_call.dart';

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'assets/locales', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      startLocale: Locale('my', 'MM'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<OneCall>(create: (_) => OneCall()),
        ],
        child: MyApp(),
      ),
    ),
  );
}
