import 'dart:convert';
import 'package:http/http.dart' as http;
import 'card_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/cards';

  Future<List<CardModel>> fetchCards() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => CardModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load cards: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetch cards error: $e');
      throw e; // Propagate the error further
    }
  }

  Future<CardModel> createCard(CardModel card) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'question': card.question,
          'answer': card.answer,
        }),
      );

      if (response.statusCode == 201) {
        return CardModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create card: ${response.statusCode}');
      }
    } catch (e) {
      print('Create card error: $e');
      throw e; // Propagate the error further
    }
  }

  Future<void> deleteCard(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 204) {
        // Successfully deleted
        print('Deleted card with ID: $id');
      } else {
        throw Exception('Failed to delete card: ${response.statusCode}');
      }
    } catch (e) {
      print('Delete card error: $e');
      throw e; // Propagate the error further
    }
  }
}
