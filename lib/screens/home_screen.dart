import 'package:flutter/material.dart';

import '../models/question.dart';
import '../utils/app_colors.dart';
import 'loading_screen.dart';
import 'question_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screening Obstructive Sleep Apnea',
      theme: ThemeData(
        primarySwatch: AppColors.kPrimaryColor,
      ),
      routes: {

      },
      home: Scaffold(
        backgroundColor: AppColors.kBackground,
        appBar: AppBar(
          title: Text(
            "Sceening Obstructive Sleep Apnea",
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.kBackground,
        ),

        body: FutureBuilder(
          future: Question.getQuestionList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No questions available'));
            }

            return QuestionScreen(questionList: snapshot.data!);
          }
        )
        
      )
    );
  }
}