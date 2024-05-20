import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/models/result.dart';
import 'package:screening_sleep_apnea/screens/home_screen.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';
import 'package:screening_sleep_apnea/widgets/buttons/circle_reveal_button.dart';
import 'package:screening_sleep_apnea/widgets/buttons/reset_button.dart';
import 'package:screening_sleep_apnea/widgets/custom_accordion.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  const ResultScreen({super.key, required this.formData});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: FutureBuilder(
        future: Result.getResult(widget.formData),
        builder: (context, snapshot) {
          return Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 1500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _buildContent(context, snapshot),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, AsyncSnapshot<Result> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator(key: ValueKey<int>(0), color: Colors.white, );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}', key: ValueKey<int>(1), style: TextStyle(color: Colors.white),);
    } else if (!snapshot.hasData) {
      return Text('No result available', key: ValueKey<int>(2), style: TextStyle(color: Colors.white),);
    }

    Result result = snapshot.data!;

    return SingleChildScrollView(
      key: ValueKey<int>(3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              result.image,
              width: MediaQuery.of(context).size.width / 2,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 12),

            Text(
              result.label,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),

            Text(
              result.description,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomAccordion(data: [{"title": "Data Skrining", "items": widget.formData}, {"title": "Data Skrining", "items": widget.formData}]),
            ),
            SizedBox(height: 12),

            ResetButton(
              onPressed: () {},
              targetPage: HomeScreen(),
            )
          ],
        ),
      ),
    );
  }
}
