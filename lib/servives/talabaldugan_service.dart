import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diacritic/diacritic.dart';
import 'package:pamagsalin/models/entry_model.dart';

class TalabalduganService {

  final urlPrefix = 'talabaldugan-api.onrender.com';
  final numberOfEntries = 3450;
  
  Future<dynamic> fetchIdRange({int? range}) async {
    final url = Uri.https(urlPrefix, 'api/ids/${range ?? numberOfEntries}');
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    final entryList = jsonData.map((entry) => EntryModel.fromJson(entry));
    return entryList.toList();
  }

  Future<dynamic> fetchWordMatches(String search) async {

    if (search.isEmpty) return [];

    final cleanSearch = removeDiacritics(search.toLowerCase());
    final url = Uri.https(urlPrefix, 'api/ids/$numberOfEntries');
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    final entryList = jsonData.map((entry) => EntryModel.fromJson(entry));

    final matches = [];
    for (EntryModel entry in entryList) {

      final String word = entry.word;
      final String cleanWord =  removeDiacritics(word.toLowerCase());

      if (cleanWord.contains(cleanSearch)) {
        matches.add(entry);
      }

    }

    for (EntryModel entry in matches) {
      print(entry.id);
      print(entry.word);
      print(entry.definition);
    }

    return matches;
  }

}