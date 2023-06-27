import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdb/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        title: 'TMDB to apply',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        routes: {
          'home': (context) => const HomePage(),
        },
        initialRoute: 'home',
      );
    });
  }
}

