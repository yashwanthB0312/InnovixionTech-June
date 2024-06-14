import 'package:flutter/material.dart';

import 'add_page.dart';
import 'api_service.dart';
import 'card_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CardModel>> _cardsFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  Future<void> _fetchCards() async {
    setState(() {
      _cardsFuture = _apiService.fetchCards();
    });
  }

  Future<void> _deleteCard(String id) async {
    try {
      await _apiService.deleteCard(id);
      // Refresh card list after deletion
      _fetchCards();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed to delete card'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard App'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: FutureBuilder<List<CardModel>>(
        future: _cardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching cards: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cards available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final card = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    _showAnswerDialog(card.answer);
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(card.question),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteCard(card.id); // Delete card when delete button is pressed
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          ).then((_) {
            // Refresh the cards when returning from AddPage
            _fetchCards();
          });
        },
        backgroundColor: Colors.grey,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAnswerDialog(String answer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Answer'),
          content: Text(answer),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
