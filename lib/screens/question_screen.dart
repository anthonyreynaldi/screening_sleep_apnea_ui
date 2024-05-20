import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:screening_sleep_apnea/main.dart';
import 'package:screening_sleep_apnea/screens/loading_screen.dart';
import 'package:screening_sleep_apnea/screens/result_screen.dart';
import 'package:screening_sleep_apnea/widgets/buttons/custom_button.dart';
import 'package:screening_sleep_apnea/widgets/buttons/submit_button.dart';
import 'package:screening_sleep_apnea/widgets/questions/question_number.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../models/question.dart';
import '../widgets/buttons/next_button.dart';
import '../widgets/buttons/prev_button.dart';
import '../widgets/questions/question_card.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/buttons/skip_button.dart';

class QuestionScreen extends StatefulWidget {
  List<Question> questionList;

  QuestionScreen({Key? key, required this.questionList}) : super(key: key);

  @override
  QuestionScreenState createState() => QuestionScreenState();
}

class QuestionScreenState extends State<QuestionScreen> {
  int _currentPageIndex = 0;
  final _pageController = PageController();
  var formData = {};
  bool isNextButtonEnable = false;

  updateFormData(String name, dynamic value){
    setState(() {
      formData[name] = value;
      print(formData);
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Question> questionList = widget.questionList;
    isNextButtonEnable = formData[questionList[_currentPageIndex].name] == null ? false : true;

    return Scaffold(
      body: Column(
          children: [
            Expanded(
                child: PageView.builder(
              itemCount: questionList.length,
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return QuestionCard(
                  playAnimation: true,
                  question: questionList[index],
                  sessionValue: formData[questionList[index].name],
                  updateFormData: (value) => {updateFormData(questionList[index].name, value)},
                );
              },
            )),
    
            SmoothPageIndicator(
                controller: _pageController,
                count: questionList.length,
                effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: AppColors.kPrimary.withOpacity(0.2)),
                onDotClicked: (index) {
                  // setState(() {
                  //   _currentPageIndex = index;
                  // });
                  // _pageController.animateToPage(
                  //   index,
                  //   duration: const Duration(milliseconds: 500),
                  //   curve: Curves.easeInOut,
                  // );
                }),
    
            const SizedBox(height: 30),
    
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (_currentPageIndex > 0)
                    ? PrevButton(onTap: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          })
                    : SizedBox(),
    
                (_currentPageIndex > 0)
                    ? SizedBox(width: 20)
                    : SizedBox(),
    
                (_currentPageIndex < questionList.length - 1)
                    ? NextButton(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        isEnable: isNextButtonEnable,
                      )
                    : SubmitButton(
                      onPressed: (){ Question.saveAnswerSupabase(formData); }, 
                      targetPage: ResultScreen(formData: formData,)
                    )
                    
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
    );
  }
}