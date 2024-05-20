import 'dart:convert';

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
}