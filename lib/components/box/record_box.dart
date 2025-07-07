import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class RecordBox extends StatelessWidget {
  const RecordBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: kRed300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kapampangan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),

            // Offset
            SizedBox(height: 20),

            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Color(0x80FFFFFF),
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices ultrices interdum. Duis justo nisi, feugiat nec erat eget, lacinia commodo dui. Nulla id metus elementum, aliquam arcu ',
                  ),
                ],
              ),
            ),

            // Offset
            SizedBox(height: 10),

            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Color(0x80FFFFFF),
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices ultrices interdum. Duis justo nisi, feugiat nec erat eget, lacinia commodo dui. Nulla id metus elementum, aliquam arcu ',
                  ),
                ],
              ),
            ),

            // Offset
            SizedBox(height: 10),

            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text:
                    'eget, accumsan ex. Nullam dignissim viverra nunc sed ',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
