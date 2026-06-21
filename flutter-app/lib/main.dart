import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/word.dart';
import 'services/api_service.dart';
import 'providers/words_provider.dart';
import 'widgets/word_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WordsProvider(api: api)..fetchWords()),
      ],
      child: MaterialApp(
        title: 'LingoBreeze',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('My Vocabulary')),
      body: RefreshIndicator(
        onRefresh: provider.fetchWords,
        child: Builder(builder: (context) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }
          if (provider.words.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bookmarks, size: 64, color: Colors.indigo.shade200),
                    const SizedBox(height: 16),
                    const Text("You haven't saved any words yet.", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    const Text('Save words you want to practice later — tap + to add one.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => _showAddDialog(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Your First Word'),
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    )
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 80),
            itemCount: provider.words.length,
            itemBuilder: (context, index) {
              final w = provider.words[index];
              return WordTile(word: w);
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final _wordController = TextEditingController();
    final _meaningController = TextEditingController();
    final _translationController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Word'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _wordController, decoration: const InputDecoration(labelText: 'Word')),
              TextField(controller: _meaningController, decoration: const InputDecoration(labelText: 'Meaning')),
              TextField(controller: _translationController, decoration: const InputDecoration(labelText: 'Translation')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final word = _wordController.text.trim();
              final meaning = _meaningController.text.trim();
              final translation = _translationController.text.trim();
              if (word.isEmpty || meaning.isEmpty || translation.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All fields are required')));
                return;
              }
              final provider = Provider.of<WordsProvider>(context, listen: false);
              final ok = await provider.addWord(word, meaning, translation);
              Navigator.of(ctx).pop();
              if (ok) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to save')));
              }
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
