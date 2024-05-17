import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/screens/question_screen.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Screening Obstructive Sleep Apnea',
      theme: ThemeData(
        primarySwatch: AppColors.kPrimaryColor,
      ),
      routes: {

      },
      home: QuestionScreen(),
    );
  }
}
