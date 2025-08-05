import 'package:flutter/material.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/gradient/gradient_text.dart';
import 'package:pamagsalin/components/text_fields/glossary_search_bar.dart';
import 'package:pamagsalin/components/list_views/glossary_list_view.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/utils/constants.dart';

class WordPage extends StatelessWidget {
  const WordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            // Main Page
            Column(
              children: [
                // Offset
                const SizedBox(height: 50),

                GlossarySearchBar(),

                // Offset
                const SizedBox(height: 50),

                // Record Button
                Expanded(
                  child: ListView(
                    children: [
                      // Word
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 14,
                        children: [
                          GradientText('mayap', style: kPoppinsTitleLarge),
                          RoundIconButton(
                            icon: Icon(
                              Icons.volume_down,
                              color: Colors.white,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(3),
                            onPressed: () {},
                          ),
                        ],
                      ),

                      // Offset
                      SizedBox(height: 16),

                      // Definition
                      Text(
                        'or kayabakan v. mayabak, mayayabak, meyabak; to do something until morning; become morning. n. morning.',
                        style: kPoppinsBodyMedium.copyWith(
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Back Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: RoundIconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 40),
                  padding: EdgeInsets.all(16),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
