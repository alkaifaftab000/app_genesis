import 'package:app_genesis/models/Questions/answer_fetch_model.dart';

class QuestionFetchModel {
  final int id;
  final String questionText;
  final String questionType;
  final String description;
  final double marks;
  final bool isPublic;
  final int course;
  final int createdBy;
  final AnswerFetchModel answer;

  QuestionFetchModel({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.description,
    required this.marks,
    required this.isPublic,
    required this.course,
    required this.createdBy,
    required this.answer,
  });

  factory QuestionFetchModel.fromJson(Map<String, dynamic> json) {
    AnswerFetchModel answer;

    switch (json['question_type']) {
      case 'FIBL':
        answer = FillUpsAnswerModel.fromJson(json['fill_in_the_blank_question'] ?? {});
        break;
      case 'TF':
        answer = TFAnswerModel.fromJson(json['true_or_false_question'] ?? {});
        break;
      case 'MCQ':
        answer = SingleChoiceAnswerModel.fromJson(json['multiple_choice_question'] ?? {});
        break;
      case 'MAMCQ':
        answer = MultipleChoiceAnswerModel.fromJson(json['multiple_choice_question'] ?? {});
        break;
      case 'MTF':
        answer = MatchAnswerModel.fromJson(json['match_the_following_question'] ?? {});
        break;
      default:
        throw FormatException('Unknown question type: ${json['question_type']}');
    }

    return QuestionFetchModel(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_text': questionText,
      'question_type': questionType,
      'description': description,
      'marks': marks,
      'is_public': isPublic,
      'course': course,
      'created_by': createdBy,
      'answer': answer.toJson(),
    };
  }
}