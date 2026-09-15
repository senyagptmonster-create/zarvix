import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quote_vault_controller.dart';
import 'zarvix_theme.dart';

class AuthorCollectionsView extends StatelessWidget {
  const AuthorCollectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<QuoteVaultController>();
    final authors = ctrl.quotes.map((q) => q.author).toSet().toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: authors.length,
      itemBuilder: (context, idx) {
        final author = authors[idx];
        final count = ctrl.quotes.where((q) => q.author == author).length;

        return Card(
          color: ZarvixTheme.cardSurface,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: ZarvixTheme.borderSubtle),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFF383531),
              child: Icon(Icons.person, color: ZarvixTheme.amberAccent),
            ),
            title: Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text('$count Passages',
                style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
