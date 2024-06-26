import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:screening_sleep_apnea/main.dart';
import "package:http/http.dart" as http;

const String base_url = String.fromEnvironment('API_AI_ENDPOINT');
const String sheet_endpoint = String.fromEnvironment('API_SHEET_ENDPOINT');

class Result {
  String image;
  String name;
  String label;
  String description;
  Map label_detail;

  Result(
      {required this.image, required this.name, required this.label, required this.description, required this.label_detail});

  factory Result.fromJson(Map<String, dynamic> json, Map AIResult) {

    return Result(
      image: json['image'],
      name: json['name'],
      label: json['label'],
      description: json['description'],
      label_detail: AIResult['label_detail'],
    );
  }

  static Future<Result> getResult(Map formData) async {
    // await Future.delayed(const Duration(seconds: 1));

    // print("get result");

    Map AIResult = await getAIResult(formData);

    await saveResultToSheet(formData, AIResult);

    return await getDetailResult(AIResult);
  }

  static Future<Map> getAIResult(Map formData) async {
    // await Future.delayed(const Duration(seconds: 1));

    String body = jsonEncode(formData);

    String endpoint = base_url + "/predict";

    Response response = await http.post(Uri.parse(endpoint), headers: {"Content-Type": "application/json"}, body: body);

    // print("hit api data predict");
    // print(response.body);

    return jsonDecode(response.body);
  }

  static Future<Result> getDetailResult(Map AIResult) async {
    try {
      // print("get result data");
      Map<String, dynamic> response = await supabase
          .from('result')
          .select()
          .eq('name', AIResult['name'])
          .single();
      
      // print(response);
      
      return Result.fromJson(response, AIResult);

    } catch (e) {
      // print(e.toString());
    }

    return Result(image: "", name: "", label: "", description: "", label_detail: {});
  }

  static Future<void> saveResultToSheet(Map formData, Map AIResult) async {

    String body = jsonEncode({...formData, ...AIResult});   //combine input data and result data

    String endpoint = sheet_endpoint;

    try {
      Response response = await http.post(Uri.parse(endpoint), headers: {"Content-Type": "text/plain"}, body: body);

      // print("hit api save sheet");
      // print(response.body);

    } catch (e) {
    }
  }

  static Map getDummyResult(){
    return {
      "name": "normal",
      "label": "NORMAL",
      "description_result": "Tidak ada kemungkinan Anda mengalami OSA. Pertahankan kesehatan Anda",
      "label_detail": {
        "SVM": "BERAT",
        "KNN": "SEDANG",
        "Linear Regression": "Ringan",
      }
    };
  }
}