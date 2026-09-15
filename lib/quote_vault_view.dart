import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quote_vault_controller.dart';
import 'zarvix_theme.dart';

class QuoteVaultView extends StatelessWidget {
  const QuoteVaultView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<QuoteVaultController>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ctrl.quotes.length,
      itemBuilder: (context, idx) {
        final item = ctrl.quotes[idx];

        return Card(
          color: ZarvixTheme.cardSurface,
          margin: const EdgeInsets.only(bottom: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: ZarvixTheme.borderSubtle),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '“${item.quote}”',
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    color: ZarvixTheme.creamText,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.author,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: ZarvixTheme.amberAccent, fontSize: 13)),
                          Text('${item.bookTitle} (p. ${item.pageNumber})',
                              style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        item.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: item.isBookmarked ? ZarvixTheme.amberAccent : Colors.grey,
                      ),
                      onPressed: () => ctrl.toggleBookmark(item.id),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
