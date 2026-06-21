import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/word.dart';

class ApiService {
  // Change baseUrl to your backend host (localhost, 10.0.2.2 for emulator, etc.)
  final String baseUrl;
  ApiService({this.baseUrl = 'http://localhost:3000'});

  Future<List<Word>> fetchWords() async {
    final res = await http.get(Uri.parse('$baseUrl/words'));
    if (res.statusCode == 200) {
      final map = json.decode(res.body);
      if (map['ok'] == true) {
        final List<dynamic> data = map['data'];
        return data.map((e) => Word.fromJson(e)).toList();
      }
      throw Exception('API error');
    }
    throw Exception('Failed to fetch');
  }

  Future<Word> addWord(String word, String meaning, String translation) async {
    final res = await http.post(Uri.parse('$baseUrl/words'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'word': word, 'meaning': meaning, 'translation': translation}));
    if (res.statusCode == 201) {
      final map = json.decode(res.body);
      return Word.fromJson(map['data']);
    }
    throw Exception('Failed to add');
  }
}
