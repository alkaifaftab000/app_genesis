abstract class FilteredAnswerModel {
  Map<String, dynamic> toJson();
}

class FilteredFillUpsAnswerModel extends FilteredAnswerModel {
  final String answer;

  FilteredFillUpsAnswerModel({required this.answer});

  factory FilteredFillUpsAnswerModel.fromJson(Map<String, dynamic> json) {
    return FilteredFillUpsAnswerModel(answer: json['answer']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
    };
  }
}

class FilteredTFAnswerModel extends FilteredAnswerModel {
  final bool correctAnswer;

  FilteredTFAnswerModel({required this.correctAnswer});

  factory FilteredTFAnswerModel.fromJson(Map<String, dynamic> json) {
    return FilteredTFAnswerModel(correctAnswer: json['correct_answer']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'correct_answer': correctAnswer,
    };
  }
}

class FilteredMultipleChoiceAnswerModel extends FilteredAnswerModel {
  final Map<String, String> choices;
  final List<String> correctAnswers;

  FilteredMultipleChoiceAnswerModel(
      {required this.choices, required this.correctAnswers});

  factory FilteredMultipleChoiceAnswerModel.fromJson(
      Map<String, dynamic> json) {
    return FilteredMultipleChoiceAnswerModel(
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

class FilteredMatchAnswerModel extends FilteredAnswerModel {
  final Map<String, String> pairs;

  FilteredMatchAnswerModel({required this.pairs});

  factory FilteredMatchAnswerModel.fromJson(Map<String, dynamic> json) {
    return FilteredMatchAnswerModel(
        pairs: Map<String, String>.from(json['pairs']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pairs': pairs,
    };
  }
}

class FilteredSingleChoiceAnswerModel extends FilteredAnswerModel {
  final Map<String, String> choices;
  final String correctAnswer;

  FilteredSingleChoiceAnswerModel(
      {required this.choices, required this.correctAnswer});

  factory FilteredSingleChoiceAnswerModel.fromJson(Map<String, dynamic> json) {
    return FilteredSingleChoiceAnswerModel(
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
