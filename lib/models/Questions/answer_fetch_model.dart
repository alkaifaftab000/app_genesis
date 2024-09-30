abstract class AnswerFetchModel {
  Map<String, dynamic> toJson();
}

class FillUpsAnswerModel extends AnswerFetchModel {
  final String answer;

  FillUpsAnswerModel({required this.answer});

  factory FillUpsAnswerModel.fromJson(Map<String, dynamic> json) {
    return FillUpsAnswerModel(answer: json['answer']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
    };
  }
}

class TFAnswerModel extends AnswerFetchModel {
  final bool correctAnswer;

  TFAnswerModel({required this.correctAnswer});

  factory TFAnswerModel.fromJson(Map<String, dynamic> json) {
    return TFAnswerModel(correctAnswer: json['correct_answer']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'correct_answer': correctAnswer,
    };
  }
}

class MultipleChoiceAnswerModel extends AnswerFetchModel {
  final Map<String, String> choices;
  final List<String> correctAnswers;

  MultipleChoiceAnswerModel(
      {required this.choices, required this.correctAnswers});

  factory MultipleChoiceAnswerModel.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceAnswerModel(
      choices: Map<String, String>.from(json['choices']),
      correctAnswers: List<String>.from(json['correct_answers']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'choices': choices,
      'correct_answers': correctAnswers,
    };
  }
}

class MatchAnswerModel extends AnswerFetchModel {
  final Map<String, String> pairs;

  MatchAnswerModel({required this.pairs});

  factory MatchAnswerModel.fromJson(Map<String, dynamic> json) {
    return MatchAnswerModel(pairs: Map<String, String>.from(json['pairs']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pairs': pairs,
    };
  }
}

class SingleChoiceAnswerModel extends AnswerFetchModel {
  final Map<String, String> choices;
  final String correctAnswer;

  SingleChoiceAnswerModel({required this.choices, required this.correctAnswer});

  factory SingleChoiceAnswerModel.fromJson(Map<String, dynamic> json) {
    return SingleChoiceAnswerModel(
      choices: Map<String, String>.from(json['choices']),
      correctAnswer: json['correct_answers'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'choices': choices,
      'correct_answer': correctAnswer,
    };
  }
}
