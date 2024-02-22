import 'dart:convert';

class Preguntas {
    int responseCode;
    List<Result> results;

    Preguntas({
        required this.responseCode,
        required this.results,
    });

    factory Preguntas.fromJson(String str) => Preguntas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Preguntas.fromMap(Map<String, dynamic> json) => Preguntas(
        responseCode: json["response_code"],
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "response_code": responseCode,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}

class Result {
    String type;
    String difficulty;
    String category;
    String question;
    String correctAnswer;
    List<String> incorrectAnswers;

    Result({
        required this.type,
        required this.difficulty,
        required this.category,
        required this.question,
        required this.correctAnswer,
        required this.incorrectAnswers,
    });

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        type: json["type"],
        difficulty: json["difficulty"],
        category: json["category"],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers: List<String>.from(json["incorrect_answers"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "difficulty": difficulty,
        "category": category,
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
    };
}
