import 'package:flutter/material.dart';
import 'package:pamagsalin/pages/home_page.dart';
import 'package:pamagsalin/utils/constants.dart';

void main() {
  runApp(Pamagsalin());
}

class Pamagsalin extends StatelessWidget {
  const Pamagsalin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        fontFamily: "Marope",
        scaffoldBackgroundColor: kGray100,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
        )
      ),
    );
  }
}
