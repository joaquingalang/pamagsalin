import 'package:flutter/material.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/text_fields/glossary_search_bar.dart';
import 'package:pamagsalin/components/list_views/glossary_list_view.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/services/talabaldugan_service.dart';

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({super.key});

  @override
  State<GlossaryPage> createState() => _GlossaryPageState();
}

class _GlossaryPageState extends State<GlossaryPage> {
  final TalabalduganService glossary = TalabalduganService();

  List matchedEntries = [];
  String searchedWord = '';
  bool isLoading = true;

  Future<void> _loadEntries() async {
    await glossary.loadCsv('assets/data/talabaldugan.csv');
    await _searchWords();
  }

  Future<void> _searchWords() async {
    setState(() {
      isLoading = true;
    });

    if (searchedWord.isEmpty) {
      matchedEntries = glossary.getAllEntries();
    } else {
      matchedEntries = glossary.searchByWord(searchedWord);
    }
    setState(() {
      isLoading = false;
    });
  }

  void _updateSearchedWord(String value) {
    setState(() {
      searchedWord = value;
    });
    _searchWords();
  }

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: Stack(
          children: [
            // Main Page
            Column(
              children: [
                // Offset
                const SizedBox(height: 50),

                GlossarySearchBar(onSubmit: _updateSearchedWord),

                // Record Button
                Expanded(
                  child:
                      (isLoading)
                          ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                          : GlosarryListView(entries: matchedEntries),
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
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
