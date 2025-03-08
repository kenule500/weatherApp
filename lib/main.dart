import 'package:flutter/material.dart';

import 'weather_screen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(appBarTheme: AppBarTheme()),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}
