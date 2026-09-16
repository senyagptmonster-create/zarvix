import 'package:flutter/material.dart';
import 'theme/zarvix_theme.dart';
import 'painters/quote_illuminated_painter.dart';

class ZarvixApp extends StatefulWidget {
  const ZarvixApp({super.key});

  @override
  State<ZarvixApp> createState() => _ZarvixAppState();
}

class _ZarvixAppState extends State<ZarvixApp> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _quotes = [
    {
      'quote': 'You have power over your mind - not outside events. Realize this, and you will find strength.',
      'author': 'Marcus Aurelius',
      'work': 'Meditations, Book IV',
      'tag': 'Stoicism',
      'bookmarked': true,
    },
    {
      'quote': 'One cannot think well, love well, sleep well, if one has not dined well.',
      'author': 'Virginia Woolf',
      'work': 'A Room of One\'s Own',
      'tag': 'Life & Art',
      'bookmarked': false,
    },
    {
      'quote': 'He who has a why to live can bear almost any how.',
      'author': 'Friedrich Nietzsche',
      'work': 'Twilight of the Idols',
      'tag': 'Philosophy',
      'bookmarked': true,
    },
    {
      'quote': 'We read books to find out who we are. What other people, real or imaginary, do and think and feel is an essential guide.',
      'author': 'Ursula K. Le Guin',
      'work': 'The Wave in the Mind',
      'tag': 'Literature',
      'bookmarked': false,
    },
  ];

  int _selectedQuoteIdx = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zarvix Quote Vault',
      debugShowCheckedModeBanner: false,
      theme: ZarvixTheme.themeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ZARVIX QUOTE VAULT',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: ZarvixTheme.ink,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                  children: [
                    _buildVaultView(),
                    _buildCaptureView(),
                    _buildAuthorsView(),
                    _buildReflectionsView(),
                  ],
                ),
              ),
              // Dots Indicator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (i) {
                    final isSel = _currentPage == i;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isSel ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isSel ? ZarvixTheme.accent : ZarvixTheme.edge,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVaultView() {
    final q = _quotes[_selectedQuoteIdx];
    final isBookmarked = q['bookmarked'] as bool;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Illuminated Quote Custom Painter Card
          SizedBox(
            height: 280,
            child: CustomPaint(
              painter: QuoteIlluminatedPainter(isBookmarked: isBookmarked),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: ZarvixTheme.edge,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            q['tag'] as String,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: ZarvixTheme.accentLight),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                            color: isBookmarked ? ZarvixTheme.accent : ZarvixTheme.muted,
                          ),
                          onPressed: () {
                            setState(() => q['bookmarked'] = !isBookmarked);
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '“${q['quote']}”',
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                        color: ZarvixTheme.ink,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '— ${q['author']}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: ZarvixTheme.accent),
                    ),
                    Text(
                      q['work'] as String,
                      style: const TextStyle(fontSize: 12, color: ZarvixTheme.muted),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Quote switch buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton.filledTonal(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: _selectedQuoteIdx > 0
                    ? () => setState(() => _selectedQuoteIdx--)
                    : null,
              ),
              Text(
                '${_selectedQuoteIdx + 1} of ${_quotes.length} Bookmarks',
                style: const TextStyle(fontWeight: FontWeight.bold, color: ZarvixTheme.muted),
              ),
              IconButton.filledTonal(
                icon: const Icon(Icons.arrow_forward_rounded),
                onPressed: _selectedQuoteIdx < _quotes.length - 1
                    ? () => setState(() => _selectedQuoteIdx++)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaptureView() {
    final textCtrl = TextEditingController();
    final authorCtrl = TextEditingController();
    final workCtrl = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Capture Memorable Passage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              TextField(
                controller: textCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Quotation Excerpt',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: authorCtrl,
                decoration: const InputDecoration(
                  labelText: 'Author Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: workCtrl,
                decoration: const InputDecoration(
                  labelText: 'Book Title / Source',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (textCtrl.text.isNotEmpty && authorCtrl.text.isNotEmpty) {
                    setState(() {
                      _quotes.add({
                        'quote': textCtrl.text,
                        'author': authorCtrl.text,
                        'work': workCtrl.text.isNotEmpty ? workCtrl.text : 'Personal Notes',
                        'tag': 'Custom',
                        'bookmarked': true,
                      });
                      _selectedQuoteIdx = _quotes.length - 1;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passage Saved into Vault!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ZarvixTheme.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('SAVE TO VAULT', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorsView() {
    final authors = [
      {'name': 'Marcus Aurelius', 'era': '121 - 180 AD', 'focus': 'Stoic Philosophy & Resilience', 'count': '1 Passage'},
      {'name': 'Virginia Woolf', 'era': '1882 - 1941', 'focus': 'Modernist Fiction & Feminist Essays', 'count': '1 Passage'},
      {'name': 'Friedrich Nietzsche', 'era': '1844 - 1900', 'focus': 'Existentialism & Perspectivism', 'count': '1 Passage'},
      {'name': 'Ursula K. Le Guin', 'era': '1929 - 2018', 'focus': 'Speculative Fiction & Language', 'count': '1 Passage'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: authors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final a = authors[i];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: ZarvixTheme.edge,
              child: Icon(Icons.person_rounded, color: ZarvixTheme.accent),
            ),
            title: Text(a['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${a['era']} • ${a['focus']}'),
            trailing: Text(a['count']!, style: const TextStyle(fontSize: 12, color: ZarvixTheme.accentLight, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }

  Widget _buildReflectionsView() {
    final reflections = [
      {'title': 'Internal Control over External Turmoil', 'date': 'Yesterday', 'source': 'Meditations', 'note': 'Reminds me that my reaction defines the event, not the event itself.'},
      {'title': 'Dignity in Nourishment', 'date': '3 days ago', 'source': 'A Room of One\'s Own', 'note': 'Art requires physical grounding and psychological comfort.'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: reflections.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final r = reflections[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(r['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(r['date']!, style: const TextStyle(fontSize: 11, color: ZarvixTheme.muted)),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Reflecting on: ${r['source']}', style: const TextStyle(fontSize: 12, color: ZarvixTheme.accentLight, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(r['note']!, style: const TextStyle(fontSize: 13, color: ZarvixTheme.ink, height: 1.4)),
              ],
            ),
          ),
        );
      },
    );
  }
}
