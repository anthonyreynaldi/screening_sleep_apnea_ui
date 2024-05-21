import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:screening_sleep_apnea/models/question.dart';
import 'package:screening_sleep_apnea/models/result.dart';
import 'package:screening_sleep_apnea/screens/home_screen.dart';
import 'package:screening_sleep_apnea/screens/result_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      home: ResultScreen(formData: Question.getDummyFormData(),),
    );
  }
}
