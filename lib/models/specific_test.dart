import 'package:app_genesis/models/question_fetch.dart';

class TestData {
  final int id;
  final String title;
  final String topic;
  final String description;
  final String duration;
  final List<QuestionFetch> questions;
  final int createdBy;
  final DateTime createdOn;
  final DateTime updatedAt;

  TestData({
    required this.id,
    required this.title,
    required this.topic,
    required this.description,
    required this.duration,
    required this.questions,
    required this.createdBy,
    required this.createdOn,
    required this.updatedAt,
  });

  factory TestData.fromJson(Map<String, dynamic> json) {
    return TestData(
      id: json['id'],
      title: json['title'],
      topic: json['topic'],
      description: json['description'],
      duration: json['duration'],
      questions: (json['questions'] as List<dynamic>)
          .map((question) => QuestionFetch.fromJson(question))
          .toList(),
      createdBy: json['created_by'],
      createdOn: DateTime.parse(json['created_on']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'topic': topic,
      'description': description,
      'duration': duration,
      'questions': questions.map((question) => question.toJson()).toList(),
      'created_by': createdBy,
      'created_on': createdOn.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
