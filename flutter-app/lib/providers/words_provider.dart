import 'package:flutter/material.dart';
import '../models/word.dart';
import '../services/api_service.dart';

class WordsProvider with ChangeNotifier {
  final ApiService api;
  List<Word> words = [];
  bool isLoading = false;
  String? error;

  WordsProvider({required this.api});

  Future<void> fetchWords() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      words = await api.fetchWords();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> addWord(String word, String meaning, String translation) async {
    try {
      final w = await api.addWord(word, meaning, translation);
      words.insert(0, w);
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
