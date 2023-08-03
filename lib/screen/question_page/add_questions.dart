import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController correctAnswerController = TextEditingController();

  // void submitQuestion() {
  //   final String category = categoryController.text;
  //   final String question = questionController.text;
  //   final List<String> options =
  //       optionControllers.map((controller) => controller.text).toList();
  //   final String correctAnswer = correctAnswerController.text;

  //   // Perform the necessary operations to save the question and category to your backend or database

  //   categoryController.clear();
  //   questionController.clear();
  //   optionControllers.forEach((controller) => controller.clear());
  //   correctAnswerController.clear();
  // }

  void submitQuestion() async {
    final String category = categoryController.text;
    final String question = questionController.text;
    final List<String> options =
        optionControllers.map((controller) => controller.text).toList();
    final String correctAnswer = correctAnswerController.text;

    // Prepare data to be stored in Firestore
    Map<String, dynamic> questionData = {
      'category': category,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
    };

    // Add the question data to the Firestore collection
    await FirebaseFirestore.instance.collection('questions').add(questionData);

    // Clear text fields after submitting
    categoryController.clear();
    questionController.clear();
    optionControllers.forEach((controller) => controller.clear());
    correctAnswerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: questionController,
                decoration: InputDecoration(labelText: 'Question'),
              ),
              SizedBox(height: 16),
              for (int i = 0; i < 4; i++)
                TextField(
                  controller: optionControllers[i],
                  decoration: InputDecoration(labelText: 'Option ${i + 1}'),
                ),
              SizedBox(height: 16),
              TextField(
                controller: correctAnswerController,
                decoration: InputDecoration(labelText: 'Correct Answer'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: submitQuestion,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
