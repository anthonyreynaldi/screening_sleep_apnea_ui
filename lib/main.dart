import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:screening_sleep_apnea/screens/loading_screen.dart';
import 'package:screening_sleep_apnea/screens/question_screen.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'utils/question.dart';

Future<void> main() async {
  if (kIsWeb) {
    // Load environment variables from Dart defines for web
    const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  } else {
    // Load environment variables from .env file for mobile
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    await dotenv.load(fileName: isProduction ? ".env.production" : ".env.development");

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }

  runApp(MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    Future<List<Question>> getQuestionList() async {

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

  // This widget is the root of your application.
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
          future: getQuestionList(),
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
