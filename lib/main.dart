import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:online_games/utils/custom_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  initializeApp(
      apiKey: "AIzaSyBzKeVnMWOIGz9VJFUI8kuFy2FjSYqyDTU",
      authDomain: "online-games-6d374.firebaseapp.com",
      databaseURL: "https://online-games-6d374.firebaseio.com",
      projectId: "online-games-6d374",
      storageBucket: "online-games-6d374.appspot.com",
      messagingSenderId: "458640760871",
      appId: "1:458640760871:web:f85854c554a711845bae02",
      measurementId: "G-QDP5C54M49");

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: CustomRouter().router.generator,
      initialRoute: "/games",
      title: 'Online Games',
    );
  }
}
