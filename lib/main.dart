import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/pages/home_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(Pamagsalin());
}

class Pamagsalin extends StatelessWidget {
  const Pamagsalin({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          home: HomePage(),
          theme: ThemeData(
            scaffoldBackgroundColor: kBlack100,
          ),
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}
