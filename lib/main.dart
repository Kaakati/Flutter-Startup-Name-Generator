import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Startup Name Generator', home: RandomWords());
  }
}

// Create a Mutable State for the RandomWords Immutable State.
class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _sugesstions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator')),
      body: _buildSugesstions(),
    );
  }

  // Build ListView
  Widget _buildSugesstions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _sugesstions.length) {
          _sugesstions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_sugesstions[index]);
      },
    );
  }

  // Build Row for ListView
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
