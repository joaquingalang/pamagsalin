import 'package:flutter/material.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/loading_indicator/loading_indicator.dart';
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

  List _matchedEntries = [];
  String _searchedWord = '';
  bool _isLoading = true;

  Future<void> _loadEntries() async {
    await glossary.loadCsv('assets/data/talabaldugan.csv');
    await _searchWords();
  }

  Future<void> _searchWords() async {
    setState(() {
      _isLoading = true;
    });

    if (_searchedWord.isEmpty) {
      _matchedEntries = glossary.getAllEntries();
    } else {
      _matchedEntries = glossary.searchByWord(_searchedWord);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _updateSearchedWord(String value) {
    setState(() {
      _searchedWord = value;
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
                      (_isLoading)
                          ? SizedBox()
                          : GlosarryListView(entries: _matchedEntries),
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
