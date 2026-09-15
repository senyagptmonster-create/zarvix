import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'zarvix_theme.dart';
import 'quote_vault_controller.dart';
import 'quote_vault_view.dart';
import 'new_passage_view.dart';
import 'author_collections_view.dart';
import 'reading_reflections_view.dart';

class ZarvixApp extends StatelessWidget {
  const ZarvixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuoteVaultController(),
      child: MaterialApp(
        title: 'Zarvix Quote Vault',
        theme: ZarvixTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const ZarvixHomeScaffold(),
      ),
    );
  }
}

class ZarvixHomeScaffold extends StatefulWidget {
  const ZarvixHomeScaffold({super.key});

  @override
  State<ZarvixHomeScaffold> createState() => _ZarvixHomeScaffoldState();
}

class _ZarvixHomeScaffoldState extends State<ZarvixHomeScaffold> {
  int _currentIndex = 0;

  final _titles = ['Quote Vault', 'Capture Passage', 'Author Index', 'Reflections'];
  final _views = const [
    QuoteVaultView(),
    NewPassageView(),
    AuthorCollectionsView(),
    ReadingReflectionsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _views[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories), label: 'Vault'),
          NavigationDestination(icon: Icon(Icons.post_add_outlined), selectedIcon: Icon(Icons.post_add), label: 'Capture'),
          NavigationDestination(icon: Icon(Icons.group_outlined), selectedIcon: Icon(Icons.group), label: 'Authors'),
          NavigationDestination(icon: Icon(Icons.psychology_outlined), selectedIcon: Icon(Icons.psychology), label: 'Reflections'),
        ],
      ),
    );
  }
}
