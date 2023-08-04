import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  bool isLoading = true; // Loading state variable
  int currentQuestionIndex = 0;
  int answered = 0;
  List<Map<String, dynamic>> questions = [];

  // Fetch questions from Firestore
  Future<void> fetchQuestions() async {
    setState(() {
      isLoading = true;
    });

    final snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('category', isEqualTo: 'general')
        .orderBy('timestamp',
            descending: true) // Order by timestamp in descending order
        .get();

    setState(() {
      questions = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  void checkAnswer(String selectedOptionIndex) {
    if (selectedOptionIndex ==
        questions[currentQuestionIndex]['correctAnswer']) {
      setState(() {
        answered = 1;
      });
      print('correct');
    } else {
      setState(() {
        answered = 2;
      });
      print('worng');
      // Handle wrong answer
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Handle quiz completion
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('General'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              isLoading
                  ? 'Loading...'
                  : '${currentQuestionIndex + 1}. ${questions[currentQuestionIndex]['question']}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          if (!isLoading)
            Column(
              children: List.generate(
                questions[currentQuestionIndex]['options'].length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: answered == 1
                            ? Colors.green
                            : answered == 2
                                ? Colors.red
                                : Colors.black38,
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                      ),
                      onPressed: () {
                        print(
                            questions[currentQuestionIndex]['options'][index]);
                        checkAnswer(
                            questions[currentQuestionIndex]['options'][index]);
                      },
                      child: Text(
                          questions[currentQuestionIndex]['options'][index]),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black87,
              onPrimary: Colors.white,
              minimumSize: Size(double.infinity, 48),
            ),
            onPressed: nextQuestion,
            child: Text('Next Question'),
          ),
        ),
      ),
    );
  }
}
