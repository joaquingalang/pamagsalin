import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/tiles/glossary_tile.dart';

class GlosarryListView extends StatelessWidget {
  const GlosarryListView({super.key});

  List<Widget> buildGlossary() {
    const List glossary = [
      ['a, à', '(particle) 1. introductory exclamation... '],
      ['abàgat', 'n. southern breeze'],
      ['àbak', 'or kayabakan v. mayabak, mayayabak... '],
      ['abakâ', 'n. the abaca plant, fiber, or cloth'],
      ['a, à', '(particle) 1. introductory exclamation... '],
      ['abàgat', 'n. southern breeze'],
      ['àbak', 'or kayabakan v. mayabak, mayayabak... '],
      ['abakâ', 'n. the abaca plant, fiber, or cloth'],
      ['a, à', '(particle) 1. introductory exclamation... '],
      ['abàgat', 'n. southern breeze'],
      ['àbak', 'or kayabakan v. mayabak, mayayabak... '],
      ['abakâ', 'n. the abaca plant, fiber, or cloth'],
    ];

    List<Widget> glossaryList = [];

    for (List entry in glossary) {
      String word = entry[0];
      String definition = entry[1];

      glossaryList.add(Divider(color: kPink200));

      Widget entryRow = GlossaryTile(word: word, definition: definition);
      glossaryList.add(entryRow);
    }

    glossaryList.add(SizedBox(height: 50));

    return glossaryList;
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.white, kBlack100],
          stops: [0.6, 1],
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      child: ListView(children: buildGlossary()),
    );
  }
}