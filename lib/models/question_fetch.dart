import 'package:app_genesis/models/answer_model.dart';

class QuestionFetch {
  final int id;
  final String questionText;
  final String questionType;
  final String description;
  final double marks;
  final bool isPublic;
  final int course;
  final int createdBy;
  final QuestionAnswer answer;

  QuestionFetch({
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

  factory QuestionFetch.fromJson(Map<String, dynamic> json) {
    QuestionAnswer answer;

    switch (json['question_type']) {
      case 'FIBL':
        answer = FillInTheBlankAnswer.fromJson(json['fill_in_the_blank_question']);
        break;
      case 'TF':
        answer = TrueFalseAnswer.fromJson(json['true_or_false_question']);
        break;
      case 'MCQ':
        answer = SingleChoiceAnswer.fromJson(json['multiple_choice_question']);
        break;
      case 'MAMCQ':
        answer = MultipleChoiceAnswer.fromJson(json['multiple_choice_question']);
        break;
      case 'MTF':
        answer = MatchTheFollowingAnswer.fromJson(json['match_the_following_question']);
        break;
      default:
        throw FormatException('Unknown question type: ${json['question_type']}');
    }

    return QuestionFetch(
      id: json['id'],
      questionText: json['question_text'],
      questionType: json['question_type'],
      description: json['description'],
      marks: json['marks'].toDouble(),
      isPublic: json['is_public'],
      course: json['course'],
      createdBy: json['created_by'],
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
