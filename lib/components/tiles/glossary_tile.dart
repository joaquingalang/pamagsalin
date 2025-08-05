import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class GlossaryTile extends StatelessWidget {
  const GlossaryTile({
    super.key,
    required this.word,
    required this.definition,
  });

  final String word;
  final String definition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('${word}: ${definition}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(word, style: kPoppinsBodySmall),
            Text(
              definition,
              style: kPoppinsBodySmall.copyWith(
                color: Colors.white.withOpacity(0.35),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
