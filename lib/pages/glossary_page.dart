import 'package:flutter/material.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/text_fields/glossary_search_bar.dart';
import 'package:pamagsalin/components/list_views/glossary_list_view.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';

class GlossaryPage extends StatelessWidget {
  const GlossaryPage({super.key});

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

                // Record Button
                Expanded(child: GlosarryListView()),
              ],
            ),

            // Back Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: RoundIconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 40,),
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
