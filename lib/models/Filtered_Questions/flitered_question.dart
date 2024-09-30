import 'package:app_genesis/models/Filtered_Questions/filtered_answer.dart';

class FilteredQuestionsResponse {
  final List<FilteredQuestionModel> filteredQuestions;

  FilteredQuestionsResponse({required this.filteredQuestions});

  factory FilteredQuestionsResponse.fromJson(Map<String, dynamic> json) {
    var questionsList = json['filtered_questions'] as List;
    List<FilteredQuestionModel> questions = questionsList
        .map((questionJson) => FilteredQuestionModel.fromJson(questionJson))
        .toList();

    return FilteredQuestionsResponse(filteredQuestions: questions);
  }
}

class FilteredQuestionModel {
  final int id;
  final String questionText;
  final String questionType;
  final String description;
  final double marks;
  final bool isPublic;
  final int course;
  final int createdBy;
  final FilteredAnswerModel? answer;

  FilteredQuestionModel({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.description,
    required this.marks,
    required this.isPublic,
    required this.course,
    required this.createdBy,
    this.answer,
  });

  factory FilteredQuestionModel.fromJson(Map<String, dynamic> json) {
    FilteredAnswerModel? answer;

    switch (json['question_type']) {
      case 'FIBL':
        if (json['fill_in_the_blank_question'] != null) {
          answer = FilteredFillUpsAnswerModel.fromJson(
              json['fill_in_the_blank_question']);
        }
        break;
        case 'TF':
        answer = FilteredTFAnswerModel.fromJson(json['true_or_false_question'] ?? {});
        break;
      case 'MCQ':
        answer = FilteredSingleChoiceAnswerModel.fromJson(json['multiple_choice_question'] ?? {});
        break;
      case 'MAMCQ':
        answer = FilteredMultipleChoiceAnswerModel.fromJson(json['multiple_choice_question'] ?? {});
        break;
      case 'MTF':
        answer = FilteredMatchAnswerModel.fromJson(json['match_the_following_question'] ?? {});
        break;
      default:
        print('Unknown question type: ${json['question_type']}');
    }

    return FilteredQuestionModel(
      id: json['id'] ?? 0,
      questionText: json['question_text'] ?? '',
      questionType: json['question_type'] ?? '',
      description: json['description'] ?? '',
      marks: (json['marks'] ?? 0).toDouble(),
      isPublic: json['is_public'] ?? false,
      course: json['course'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      answer: answer,
    );
  }
}