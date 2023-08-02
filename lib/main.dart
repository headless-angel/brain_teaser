import 'package:brain_teaser/provider/question_provider.dart';
import 'package:brain_teaser/provider/score_provider.dart';
import 'package:brain_teaser/util/router.dart';
import 'package:brain_teaser/util/router_path.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => QuestionProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ScoreProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Teaser',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routerr.generateRouter,
      initialRoute: SplashScreen,
    );
  }
}
