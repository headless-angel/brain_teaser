import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class QuestionsPage extends StatefulWidget {
  final String category;

  const QuestionsPage({Key? key, required this.category}) : super(key: key);

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
    final category =
        widget.category; // Access the category using widget.category

    final snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('category', isEqualTo: category)
        .orderBy('timestamp',
            descending: true) // Order by timestamp in descending order
        .get();

    setState(() {
      questions = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      isLoading = false;
    });
    if (questions.isEmpty) {
      Fluttertoast.showToast(
          msg: 'There is no question right now. Try new category');
    }
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(selectedOptionIndex),
            content: Text('Congratulations! Your answer is correct.',
                style: TextStyle(color: Colors.green)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  print('ghcchcg');
                  nextQuestion();
                  Navigator.pop(context);
                },
                child: Text('Next', style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        },
      );
      print('correct');
    } else {
      setState(() {
        answered = 2;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(selectedOptionIndex),
            content: Text(
              'Opps! Your answer is incorrect. Try again!',
              style: TextStyle(color: Colors.red),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.black)),
              ),
              TextButton(
                onPressed: () {
                  nextQuestion();
                  Navigator.pop(context);
                },
                child: Text('Next', style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        },
      );
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
      Fluttertoast.showToast(msg: 'There is no more question right now');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.category),
      ),
      body: questions.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    isLoading
                        ? ''
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
                              primary: Colors.black38,
                              onPrimary: Colors.white,
                              minimumSize: Size(double.infinity, 48),
                            ),
                            onPressed: () {
                              print(questions[currentQuestionIndex]['options']
                                  [index]);
                              checkAnswer(questions[currentQuestionIndex]
                                  ['options'][index]);
                            },
                            child: Text(questions[currentQuestionIndex]
                                ['options'][index]),
                          ),
                        );
                      },
                    ),
                  ),
                // if (!isLoading)
                //   Center(
                //     child: Text(answered == 1
                //         ? 'Correct: ${questions[currentQuestionIndex]['options'][int.parse(questions[currentQuestionIndex]['correctAnswer'])]}'
                //         : ''),
                //   ),
                if (isLoading)
                  Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.black,
                      size: 200,
                    ),
                  )
              ],
            )
          : Column(),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black87,
              onPrimary: Colors.white,
              minimumSize: Size(double.infinity, 48),
            ),
            onPressed: () {
              questions.isNotEmpty ? nextQuestion() : Navigator.pop(context);
            },
            child: Text(questions.isNotEmpty ? 'Next Question' : 'Home'),
          ),
        ),
      ),
    );
  }
}
