import 'package:flutter/material.dart';
import '../app/brand.dart';
import '../app/theme.dart';
import 'zarvix_store.dart';

class ZarvixMainScreen extends StatefulWidget {
  const ZarvixMainScreen({super.key});
  @override
  _ZarvixMainScreenState createState() => _ZarvixMainScreenState();
}

class _ZarvixMainScreenState extends State<ZarvixMainScreen> {
  final PageController _pageController = PageController();
  final ZarvixStore _store = ZarvixStore();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _store.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Zarvix Vault', style: AppTheme.display(cInk)),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildVault(),
                  _buildNewForm(),
                  _buildCollections(),
                  _buildReflections(),
                ],
              ),
            ),
            _buildDots(),
          ],
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: _currentIndex == index ? 12.0 : 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: _currentIndex == index ? cAccent : cEdge,
              borderRadius: BorderRadius.circular(4.0),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildVault() {
    if (_store.quotes.isEmpty) {
      return Center(child: Text('No quotes stored.', style: AppTheme.text(cInk)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _store.quotes.length,
      itemBuilder: (context, index) {
        final q = _store.quotes[index];
        return Card(
          color: cSurface,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('"${q['text']}"', style: AppTheme.display(cInk).copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(height: 8),
                Text('- ${q['author']}, ${q['book']}', style: AppTheme.text(cAccent)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewForm() {
    final textCtrl = TextEditingController();
    final authorCtrl = TextEditingController();
    final bookCtrl = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('New Passage', style: AppTheme.display(cInk)),
          const SizedBox(height: 16),
          TextField(controller: textCtrl, maxLines: 3, decoration: InputDecoration(labelText: 'Quote', fillColor: cSurface, filled: true)),
          const SizedBox(height: 8),
          TextField(controller: authorCtrl, decoration: InputDecoration(labelText: 'Author', fillColor: cSurface, filled: true)),
          const SizedBox(height: 8),
          TextField(controller: bookCtrl, decoration: InputDecoration(labelText: 'Book', fillColor: cSurface, filled: true)),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: cAccent),
            onPressed: () {
              if (textCtrl.text.isNotEmpty) {
                _store.addQuote({
                  'text': textCtrl.text,
                  'author': authorCtrl.text,
                  'book': bookCtrl.text,
                });
                textCtrl.clear();
                authorCtrl.clear();
                bookCtrl.clear();
                _pageController.jumpToPage(0);
              }
            },
            child: Text('Save to Vault', style: AppTheme.text(cSurface)),
          ),
        ],
      ),
    );
  }

  Widget _buildCollections() {
    final authors = <String>{};
    for (var q in _store.quotes) {
      authors.add(q['author']);
    }
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: authors.map((a) {
        final count = _store.quotes.where((q) => q['author'] == a).length;
        return ListTile(
          title: Text(a, style: AppTheme.display(cInk)),
          trailing: Text('$count quotes', style: AppTheme.text(cAccent2)),
        );
      }).toList(),
    );
  }

  Widget _buildReflections() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _store.reflections.length,
      itemBuilder: (context, index) {
        final r = _store.reflections[index];
        return Card(
          color: cSurface,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r['book'], style: AppTheme.display(cAccent)),
                const SizedBox(height: 8),
                Text(r['notes'], style: AppTheme.text(cInk)),
              ],
            ),
          ),
        );
      },
    );
  }
}
