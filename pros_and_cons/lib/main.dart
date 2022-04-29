import 'package:flutter/material.dart';
import 'package:pros_and_cons/screens/home_page.dart';
import 'package:pros_and_cons/widgets/scroll_behaviour_widget.dart';

void main() {
  runApp(const ProsAndConsApp());
}

class ProsAndConsApp extends StatelessWidget {
  const ProsAndConsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollBehaviorWidget(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
