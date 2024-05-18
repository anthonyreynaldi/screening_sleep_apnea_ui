import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:screening_sleep_apnea/main.dart';
import 'package:screening_sleep_apnea/widgets/buttons/custom_button.dart';
import 'package:screening_sleep_apnea/widgets/questions/question_number.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/question.dart';
import '../widgets/buttons/next_button.dart';
import '../widgets/buttons/prev_button.dart';
import '../widgets/questions/question_card.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/buttons/skip_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

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

  Future<void> submitFormData() async {
    
    print("ke sumbit");
    const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    print(supabaseUrl.isEmpty);
    print(supabaseUrl);

    //save data to supabase 
    try {
      var response = await supabase
          .from('sleep')
          .insert({"data": formData});
      
      print(response);

    } catch (e) {
      print(e.toString());
    }

    //get result from AI

  }


  @override
  Widget build(BuildContext context) {

    isNextButtonEnable = formData[questionList[_currentPageIndex].name] == null ? false : true;

    return Scaffold(
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
                setState(() {
                  _currentPageIndex = index;
                });
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
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
                  : CustomButton(
                    onPressed: () async { submitFormData(); }, 
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 8.0,),
                          Text("SUBMIT"),
                        ],
                      ),
                    )
                  
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


List<Question> questionList = [
  Question(
      image: AppAssets.kOnboardingFirst,
      name: "berat_badan",
      title: 'Berat Badan',
      question: 'Berapa berat badan Anda?',
      input: {
        'type': 'number',
        'unit': 'Kg',
        'min': 0,
        'max': 100,
        'init': 50
      }),
  Question(
      image: AppAssets.kOnboardingFirst,
      name: "tinggi_badan",
      title: 'Tinggi Badan',
      question: 'Berapa tinggi badan Anda?',
      input: {
        'type': 'number',
        'unit': 'cm',
        'min': 0,
        'max': 200,
        'init': 150
      }),
  Question(
      image: AppAssets.kOnboardingSecond,
      name: "jenis_kelamin",
      title: 'Jenis Kelamin',
      question: 'Apa jenis kelamin Anda?',
      input: {
        'type': 'select',
        'options': [
          'Laki - laki',
          'Perempuan'
        ]
      }),
  Question(
      image: AppAssets.kOnboardingThird,
      name: "kondisi_menyertai",
      title: 'Kondisi yang menyertai',
      question: 'Centang kondisi yang sedang terjadi pada Anda',
      input: {
        'type': 'checkbox',
        'options': [
          'Diabetes',
          'Hipertensi',
          'Hyperkolesterol',
          'Hidung tersumbat',
        ]
      })
];