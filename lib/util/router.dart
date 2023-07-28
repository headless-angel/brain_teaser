import 'dart:ffi';

import 'package:brain_teaser/model/question.dart';
import 'package:brain_teaser/screen/dashboard.dart';
import 'package:brain_teaser/screen/quiz_finish_screen.dart';
import 'package:brain_teaser/screen/quiz_screen.dart';
import 'package:brain_teaser/screen/splash_screen.dart';
import 'package:brain_teaser/util/router_path.dart';
import 'package:flutter/material.dart';

class Routerr {
  static Route<dynamic>? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashPage());
      case DashBoardScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => DashboardPage());
      case QuizScreen:
        final argument = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => QuizPage(
            difficult: argument.toString(),
            listQuestion: argument as List<Question>,
            id: argument as int,
          ),
        );
      case QuizFinishScreen:
        final argument = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => QuizFinishPage(title: argument.toString()));
    }
  }
}
