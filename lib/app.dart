import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:minhttp/minhttp.dart';
import 'package:mmc/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmc/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpClient.initialize('https://api.openweathermap.org/data/2.5');
    return MaterialApp(
      title: 'MMC',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.roboto().fontFamily,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: HomeScreen.route,
      routes: routes,
    );
  }
}
