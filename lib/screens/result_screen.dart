import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/screens/home_screen.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';
import 'package:screening_sleep_apnea/widgets/buttons/circle_reveal_button.dart';
import 'package:screening_sleep_apnea/widgets/buttons/reset_button.dart';

class ResultScreen extends StatefulWidget {
  final Map formData;
  const ResultScreen({super.key, required this.formData});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("result here"),
              ResetButton(
                onPressed: (){}, 
                targetPage: HomeScreen(), 
              )
            ],
          ),
        ),
      ),
    );
  }
}