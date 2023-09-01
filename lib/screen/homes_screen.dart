import 'package:brain_teaser/model/categories.dart';
import 'package:brain_teaser/provider/question_provider.dart';
import 'package:brain_teaser/screen/question_page/questions.dart';
import 'package:brain_teaser/screen/quiz_bottomsheet.dart';
import 'package:brain_teaser/screen/quiz_screen.dart';
import 'package:brain_teaser/util/constant.dart';
import 'package:brain_teaser/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: kItemSelectBottomNav),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Text(
            "Choose your  category",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                      itemCount: categories.length,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, right: 10, left: 10),
                          child: InkWell(
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => QuestionsPage()),
                            //   );
                            // },
                            // => _buildBottomSheet(context,
                            //     categories[index].name, categories[index].id),
                            child: CardItem(
                              index: index,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  _buildBottomSheet(BuildContext context, String title, int id) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        context: context,
        builder: (_) {
          return QuizBottomSheet(
            title: title,
            id: id,
          );
        });
  }
}
