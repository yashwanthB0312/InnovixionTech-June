import 'package:flutter/material.dart';
import 'package:flashcard_app/api_service.dart';
import 'package:flashcard_app/card_model.dart';

class AddPage extends StatefulWidget {
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _questionsController = TextEditingController();
  final TextEditingController _answersController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _questionsController.dispose();
    _answersController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    String ques = _questionsController.text;
    String ans = _answersController.text;

    if (ques.isEmpty || ans.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Fields are empty'),
          );
        },
      );
      return;
    }

    try {
      final newCard = CardModel(question: ques, answer: ans, id: '');
      await _apiService.createCard(newCard);
      _questionsController.clear();
      _answersController.clear();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Added successfully'),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed to add card'),
            content: Text(e.toString()),
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 342,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                controller: _questionsController,
                decoration: InputDecoration(
                  hintText: "Question",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 100.0,
              width: 342.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _answersController,
                  decoration: InputDecoration(
                    hintText: "Answer",
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 342,
        child: FloatingActionButton(
          onPressed: _submitForm,
          backgroundColor: Colors.grey,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
