import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  final TextEditingController userId = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLogin = false;

  String? selectedCategory;
  List<String> categories = [
    'General',
    'Books',
    'Film',
    'Music',
    'Musicals & Theatres',
    'Television',
    'Video Games',
    'Board Games',
    'Science & Nature',
    'Computer',
    'Maths',
    'Mythology',
    'Sports',
    'Geography',
    'History',
    'Politics',
    'Art',
    'Celebrities',
    'Animals',
    'Vehicles',
    'Comics',
    'Gadgets',
    'Cartoon & Animation',
  ];

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnitId = 'ca-app-pub-3940256099942544/6300978111'; //testing ad id

  initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

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
    final String category = selectedCategory!;
    final String question = questionController.text;
    final List<String> options =
        optionControllers.map((controller) => controller.text).toList();
    final correctAnswer = correctAnswerController.text;
    final DateTime now = DateTime.now();
    final int timestamp = now.millisecondsSinceEpoch;

    FocusScope.of(context).unfocus();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.black,
            size: 100,
          ));
        });

    // Prepare data to be stored in Firestore
    Map<String, dynamic> questionData = {
      'category': category,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'timestamp': timestamp,
    };

    // Add the question data to the Firestore collection
    await FirebaseFirestore.instance.collection('questions').add(questionData);

    // Clear text fields after submitting
    selectedCategory = null;
    questionController.clear();
    optionControllers.forEach((controller) => controller.clear());
    correctAnswerController.clear();
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Question added succesfully');
  }

  void login() async {
    FocusScope.of(context).unfocus();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.black,
            size: 100,
          ));
        });

    if (userId.text.toString() == '7002710476') {
      if (password.text.toString() == '7002710476') {
        setState(() {
          isLogin = true;
        });
        Fluttertoast.showToast(msg: 'Login succesfully');
      } else {
        Fluttertoast.showToast(msg: 'Opps! your password is incorrect');
      }
    } else {
      Fluttertoast.showToast(msg: 'Opps! your userId is incorrect');
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(isLogin == true ? 'Add Question' : 'Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: isLogin == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Select Category:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        items: categories
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text('Select a category'),
                        underline: SizedBox(), // Remove the default underline
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // TextField(
                    //   controller: categoryController,
                    //   decoration: InputDecoration(labelText: 'Category'),
                    // ),
                    SizedBox(height: 16),
                    TextField(
                      controller: questionController,
                      decoration: InputDecoration(labelText: 'Question'),
                    ),
                    SizedBox(height: 16),
                    for (int i = 0; i < 4; i++)
                      TextField(
                        controller: optionControllers[i],
                        decoration:
                            InputDecoration(labelText: 'Option ${i + 1}'),
                      ),
                    SizedBox(height: 16),
                    TextField(
                      controller: correctAnswerController,
                      decoration: InputDecoration(labelText: 'Correct Answer'),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedCategory.toString().isNotEmpty) {
                          if (questionController.text.toString().isNotEmpty) {
                            if (optionControllers.isNotEmpty) {
                              if (correctAnswerController.text
                                  .toString()
                                  .isNotEmpty) {
                                submitQuestion();
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Fill in the blanks');
                              }
                            } else {
                              Fluttertoast.showToast(msg: 'Fill in the blanks');
                            }
                          } else {
                            Fluttertoast.showToast(msg: 'Fill in the blanks');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Fill in the blanks');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                      ),
                      child: Text('Submit'),
                    ),
                    isAdLoaded == true
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: SizedBox(
                              height: bannerAd.size.height.toDouble(),
                              width: bannerAd.size.width.toDouble(),
                              child: AdWidget(ad: bannerAd),
                            ),
                          )
                        : const SizedBox()
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: userId,
                      decoration: InputDecoration(labelText: 'User Id'),
                      keyboardType: TextInputType
                          .number, // Set the keyboardType to TextInputType.number
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(labelText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText:
                          true, // Set obscureText to true to hide the password characters// Set the keyboardType to TextInputType.number
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        if (userId.text.toString().isNotEmpty &&
                            password.text.toString().isNotEmpty) {
                          login();
                        } else {
                          print(userId);
                          Fluttertoast.showToast(
                              msg: 'Please fill your credential');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                      ),
                      child: Text('Login'),
                    ),
                    isAdLoaded == true
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: SizedBox(
                              height: bannerAd.size.height.toDouble(),
                              width: bannerAd.size.width.toDouble(),
                              child: AdWidget(ad: bannerAd),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
        ),
      ),
    );
  }
}
