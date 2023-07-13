import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:udemy_free_courses/bloc_observer/observer.dart';
import 'package:udemy_free_courses/modules/welcome_screen/welcome.dart';
import 'package:udemy_free_courses/shared/network/local/cashe_helper.dart';
import 'package:udemy_free_courses/shared/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await SharedHelper.init();
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