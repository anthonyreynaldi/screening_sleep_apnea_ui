import 'package:screening_sleep_apnea/main.dart';

import '../utils/app_assets.dart';

class Question {
  String image;
  String name;
  String title;
  String question;
  Map input;
  int order;

Question(
      {required this.image, required this.name, required this.title, required this.question, required this.input, required this.order});

  factory Question.fromJson(Map<String, dynamic> json) {

    if(json['input']['options'] != null){
      json['input'].update(
        'options', (value) => List<String>.from(value)
      );
    }

    return Question(
      image: json['image'],
      name: json['name'],
      title: json['title'],
      question: json['question'],
      input: json['input'],
      order: json['order']
    );
  }

  static Future<List<Question>> getQuestionList() async {
    try {
      print("get data");
      List<dynamic> response = await supabase
          .from('questions')
          .select()
          .order('order', ascending: true);
      
      print(response);
      return response.map((item) => Question.fromJson(item)).toList();

    } catch (e) {
      print(e.toString());
    }

    return [];
  }

  static Future<void> saveAnswerSupabase(Map formData) async {
    
    print("ke sumbit");

    //save data to supabase 
    try {
      var response = await supabase
          .from('sleep')
          .insert({"data": formData});
      
      print(response);

    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Question>> getDummyFutureQuestionList() async {
    await Future.delayed(const Duration(seconds: 3));

    return getDummyQuestionList();
  }

  static List<Question> getDummyQuestionList() {
    
    return [
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
          },
          order: 1),
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
          },
          order: 2),
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
          },
          order: 3),
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
          },
          order: 4)
    ];
  }
}