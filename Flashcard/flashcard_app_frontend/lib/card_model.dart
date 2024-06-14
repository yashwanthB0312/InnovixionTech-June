class CardModel {
  String id;
  String question;
  String answer;

  CardModel({required this.id, required this.question, required this.answer});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }
}
