abstract class QuestionAnswer {
  Map<String, dynamic> toJson();
}

class FillInTheBlankAnswer extends QuestionAnswer {
  final String answer;

  FillInTheBlankAnswer({required this.answer});

  factory FillInTheBlankAnswer.fromJson(Map<String, dynamic> json) {
    return FillInTheBlankAnswer(answer: json['answer']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
    };
  }
}

class TrueFalseAnswer extends QuestionAnswer {
  final bool correctAnswer;

  TrueFalseAnswer({required this.correctAnswer});

  factory TrueFalseAnswer.fromJson(Map<String, dynamic> json) {
    return TrueFalseAnswer(correctAnswer: json['correct_answer']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'correct_answer': correctAnswer,
    };
  }
}

class MultipleChoiceAnswer extends QuestionAnswer {
  final Map<String, String> choices;
  final List<String> correctAnswers;

  MultipleChoiceAnswer({required this.choices, required this.correctAnswers});

  factory MultipleChoiceAnswer.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceAnswer(
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

class MatchTheFollowingAnswer extends QuestionAnswer {
  final Map<String, String> pairs;

  MatchTheFollowingAnswer({required this.pairs});

  factory MatchTheFollowingAnswer.fromJson(Map<String, dynamic> json) {
    return MatchTheFollowingAnswer(pairs: Map<String, String>.from(json['pairs']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pairs': pairs,
    };
  }
}

class SingleChoiceAnswer extends QuestionAnswer {
  final Map<String, String> choices;
  final String correctAnswer;

  SingleChoiceAnswer({required this.choices, required this.correctAnswer});

  factory SingleChoiceAnswer.fromJson(Map<String, dynamic> json) {
    return SingleChoiceAnswer(
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