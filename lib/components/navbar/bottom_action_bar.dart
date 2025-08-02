import 'package:flutter/material.dart';
import 'package:pamagsalin/components/sheets/fluency_checker_sheet.dart';
import 'package:pamagsalin/pages/home_page.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/buttons/round_button.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(90)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundButton(
            iconData: Icons.message,
            onPressed: () {
              showFluencyCheckerSheet(context);
            },
          ),
          RoundButton(
            fillColor: kRed300,
            iconData: Icons.mic,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          RoundButton(iconData: Icons.settings, onPressed: () {}),
        ],
      ),
    );
  }
}
