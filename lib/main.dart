import 'package:flutter/material.dart';
import 'package:udemy_free_courses/modules/welcome_screen/welcome.dart';
import 'package:udemy_free_courses/shared/styles/themes.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      title: "udemy free corse app",
      home: WelcomeScreen(),
    );
  }
}