import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookQuote {
  final String id;
  final String quote;
  final String author;
  final String bookTitle;
  final int pageNumber;
  bool isBookmarked;

  BookQuote({
    required this.id,
    required this.quote,
    required this.author,
    required this.bookTitle,
    required this.pageNumber,
    this.isBookmarked = false,
  });
}

class QuoteVaultController extends ChangeNotifier {
  final List<BookQuote> _quotes = [
    BookQuote(
      id: 'q1',
      quote: 'You have power over your mind - not outside events. Realize this, and you will find strength.',
      author: 'Marcus Aurelius',
      bookTitle: 'Meditations',
      pageNumber: 42,
      isBookmarked: true,
    ),
    BookQuote(
      id: 'q2',
      quote: 'The soul is healed by being with children.',
      author: 'Fyodor Dostoevsky',
      bookTitle: 'The Idiot',
      pageNumber: 118,
      isBookmarked: false,
    ),
    BookQuote(
      id: 'q3',
      quote: 'You do not rise to the level of your goals. You fall to the level of your systems.',
      author: 'James Clear',
      bookTitle: 'Atomic Habits',
      pageNumber: 27,
      isBookmarked: true,
    ),
    BookQuote(
      id: 'q4',
      quote: 'Lock up your libraries if you like; but there is no gate, no lock, no bolt that you can set upon the freedom of my mind.',
      author: 'Virginia Woolf',
      bookTitle: 'A Room of One\'s Own',
      pageNumber: 79,
      isBookmarked: false,
    ),
  ];

  final List<String> _reflections = [
    'Meditations reflection: Focus purely on internal reaction discipline today.',
    'Atomic Habits note: Reduce friction for morning writing routine.',
  ];

  QuoteVaultController() {
    _loadPrefs();
  }

  List<BookQuote> get quotes => _quotes;
  List<String> get reflections => _reflections;

  void toggleBookmark(String id) {
    final q = _quotes.firstWhere((item) => item.id == id);
    q.isBookmarked = !q.isBookmarked;
    notifyListeners();
  }

  void addQuote(String text, String author, String book, int page) {
    _quotes.insert(
      0,
      BookQuote(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        quote: text,
        author: author,
        bookTitle: book,
        pageNumber: page,
      ),
    );
    notifyListeners();
  }

  void addReflection(String note) {
    _reflections.insert(0, note);
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    await SharedPreferences.getInstance();
    notifyListeners();
  }
}
