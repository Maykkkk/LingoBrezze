import 'package:flutter/material.dart';
import '../models/word.dart';

class WordTile extends StatelessWidget {
  final Word word;
  const WordTile({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(word.word, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Meaning: ${word.meaning}'),
            const SizedBox(height: 4),
            Text('Translation: ${word.translation}'),
          ],
        ),
      ),
    );
  }
}
