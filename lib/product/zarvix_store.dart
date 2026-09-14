import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class ZarvixStore extends ChangeNotifier {
  List<dynamic> quotes = [];
  List<dynamic> reflections = [];

  ZarvixStore() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('zarvix_data');
    if (data != null) {
      final json = jsonDecode(data);
      quotes = json['quotes'] ?? [];
      reflections = json['reflections'] ?? [];
      notifyListeners();
    } else {
      _loadDefault();
    }
  }

  Future<void> _loadDefault() async {
    try {
      final jsonStr = await rootBundle.loadString('content.json');
      final json = jsonDecode(jsonStr);
      quotes = json['quotes'] ?? [];
      reflections = json['reflections'] ?? [];
      save();
    } catch (e) {
      // fallback
    }
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('zarvix_data', jsonEncode({
      'quotes': quotes,
      'reflections': reflections,
    }));
    notifyListeners();
  }

  void addQuote(Map<String, dynamic> q) {
    quotes.insert(0, q);
    save();
  }
}
