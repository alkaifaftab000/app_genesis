import 'dart:async';
import 'dart:convert';



import 'package:app_genesis/models/Filtered_Questions/flitered_question.dart';
import 'package:app_genesis/models/Questions/question_fetch_model.dart';
import 'package:app_genesis/models/specific_test.dart';
import 'package:app_genesis/models/test_fetch.dart';
import 'package:app_genesis/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class ApiController {

  Future<bool> addQuestion(dynamic data, BuildContext context) async {
    const String url = 'https://aravind10.pythonanywhere.com/Questions/create/';
    try {
      var ls = jsonEncode(data);
      // print('print $ls');
      final response = await http.post(Uri.parse(url), body: ls, headers: {
        'Content-Type':
        'application/json', // Set the content type to application/json
      });
      if (response.statusCode == 201) {
        if (context.mounted) {
          Utility.toastMessage('Question Added Successfully', context,
              ToastificationType.success, ToastificationStyle.flatColored);
        }
        return true;
      } else {
        if (kDebugMode) {
          print('${response.statusCode}: failed');
          print(data);
        }
        if (context.mounted) {
          Utility.toastMessage(
              'Error Adding The Question ${response.statusCode}',
              context,
              ToastificationType.warning,
              ToastificationStyle.fillColored);
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error Adding the Question : $e');
      }
      if (context.mounted) {
        Utility.toastMessage(e.toString(), context, ToastificationType.error,
            ToastificationStyle.fillColored);
      }
      return false;
    }
  }

  Future<List<QuestionFetchModel>> fetchQuestions() async {
    const String url = 'https://aravind10.pythonanywhere.com/Questions/list/';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<QuestionFetchModel> questions = [];

        for (var item in jsonData) {
          try {
            questions.add(QuestionFetchModel.fromJson(item));
          } catch (e) {
            debugPrint('Error parsing question: $e');
            debugPrint('Problematic JSON: ${json.encode(item)}');
          }
        }

        if (questions.isEmpty) {
          debugPrint('Warning: No valid questions parsed from the response');
        }

        return questions;
      } else {
        throw Exception('Failed to load questions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching questions: $e');
      if (e is http.ClientException) {
        debugPrint('Network error: ${e.message}');
      }
      return [];
    }
  }

  Future<List<TestModel>> fetchTest() async {
    const String url = "https://aravind10.pythonanywhere.com/Test/list/";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type':
        'application/json', // Set the content type to application/json
      });
      if (response.statusCode == 200) {
        debugPrint('Fetched Test : ${response.statusCode}');
        List<dynamic> jsonData = json.decode(response.body);
        return List<TestModel>.from(
            jsonData.map((item) => TestModel.fromJson(item)));
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      debugPrint('Error fetching questions: $e');
      return [];
    }
  }

  Future<bool> createTest(dynamic data,BuildContext context)async {
    const String url = 'https://aravind10.pythonanywhere.com/Test/create/';
    try {
      dynamic jsonData = jsonEncode(data);
      final response = await http.post(
          Uri.parse(url), body: jsonData, headers: {
        'Content-Type':
        'application/json', // Set the content type to application/json
      });
      if (response.statusCode == 201) {
        if (context.mounted) {
          Utility.toastMessage('Test Added Successfully', context,
              ToastificationType.success, ToastificationStyle.flatColored);
        }
        return true;
      } else {
        if (kDebugMode) {
          print('${response.statusCode}: failed');
          print(data);
        }
        if (context.mounted) {
          Utility.toastMessage(
              'Error Adding The Test ${response.statusCode}',
              context,
              ToastificationType.warning,
              ToastificationStyle.fillColored);
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error Adding the Test : $e');
      }
      if (context.mounted) {
        Utility.toastMessage(e.toString(), context, ToastificationType.error,
            ToastificationStyle.fillColored);
      }
      return false;
    }
  }

  Future<TestData?> fetchSpecificTest(int id, BuildContext context) async {
    String url = 'https://aravind10.pythonanywhere.com/Test/${id.toString()}/';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonData = json.decode(response.body);
        final testData = TestData.fromJson(jsonData); // Assuming TestData is your model

        if (context.mounted) {
          Utility.toastMessage('Specific Test Fetch Successfully: $id', context,
              ToastificationType.success, ToastificationStyle.flatColored);
        }
        return testData; // Return the parsed data
      } else {
        if (kDebugMode) {
          print('${response.statusCode}: failed');
        }
        if (context.mounted) {
          Utility.toastMessage(
              'Error Fetching The Specific Test: $id - ${response.statusCode}',
              context,
              ToastificationType.warning,
              ToastificationStyle.fillColored);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Fetching the Specific Test $id: $e');
      }
      if (context.mounted) {
        Utility.toastMessage(e.toString(), context, ToastificationType.error,
            ToastificationStyle.fillColored);
      }
    }
    return null; // Return null in case of error
  }
  Future<FilteredQuestionsResponse> fetchFilteredQuestions(String questionType) async {
    final String url = 'https://aravind10.pythonanywhere.com/Test/1/add-questions/?questions_type=$questionType';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return FilteredQuestionsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch filtered questions');
    }
  }

  Future<bool> addMoreQuestionToTest(List<int> addMoreQuestion, int testId,BuildContext context ) async {
    final String url = 'https://aravind10.pythonanywhere.com/Test/$testId/add-questions/';
    final Map<String,List<int>> data = {
      'question_ids' : addMoreQuestion
    };
    try{
      final response = await http.post(Uri.parse(url),body:jsonEncode(data),headers: {
        'Content-Type': 'application/json'});
      if(response.statusCode==200){
        if (context.mounted) {
          Utility.toastMessage('Questions Added Successfully: $testId , Response : ${response.statusCode}', context,
              ToastificationType.success, ToastificationStyle.flatColored);
        }
        return true;
      }else{
        if (context.mounted) {
          Utility.toastMessage('Question  Adding Failed: $testId , Response : ${response.statusCode}', context,
              ToastificationType.success, ToastificationStyle.flatColored);
        }
        return false;
      }
    }catch (e){
      debugPrint('Exception :$e');
      return false;
    }
  }
}
