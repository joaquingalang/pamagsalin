import 'package:pamagsalin/models/entry_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';


class TalabalduganService {
  List<EntryModel> _entries = [];

  /// Loads and parses the CSV from assets into _entries
  Future<void> loadCsv(String assetPath) async {
    final rawData = await rootBundle.loadString(assetPath);

    final List<List<dynamic>> rows =
    const CsvToListConverter().convert(rawData, eol: '\n');

    // Skip header row and map to EntryModel
    _entries = rows.skip(1).map((row) {
      return EntryModel(
        id: row[0] is int ? row[0] : int.parse(row[0].toString()),
        word: row[1].toString(),
        definition: row[2].toString(),
        audio: row[3].toString(),
      );
    }).toList();
  }

  /// Returns all entries
  List<EntryModel> getAllEntries() {
    return _entries;
  }

  /// Finds all entries containing the [word] in their `word` field (case-insensitive)
  List<EntryModel> searchByWord(String word) {
    final query = word.toLowerCase();
    return _entries
        .where((entry) => entry.word.toLowerCase().startsWith(query))
        .toList();
  }

  /// Finds a single entry by its [id]
  EntryModel? getById(int id) {
    try {
      return _entries.firstWhere((entry) => entry.id == id);
    } catch (_) {
      return null;
    }
  }
}
