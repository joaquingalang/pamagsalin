import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

Future<void> showFluencyCheckerSheet(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    builder: (context) => FluencyCheckerSheet(),
  );
}

class FluencyCheckerSheet extends StatelessWidget {
  const FluencyCheckerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: kGray100,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          // Draggable Line
          Container(
            width: 160,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
          ),

          // Close Sheet Button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kRed300,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Icon(Icons.close, color: Colors.white, size: 15),
              ),
            ),
          ),

          // Offset
          SizedBox(height: 13),

          // Sheet Title
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Fluency Checker',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // Offset
          SizedBox(height: 24),

          Container(
            width: double.infinity,
            height: 204,
            decoration: BoxDecoration(
              color: kGreen100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Icon(Icons.face, color: kGray100, size: 100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
