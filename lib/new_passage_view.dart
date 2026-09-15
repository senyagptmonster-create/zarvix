import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quote_vault_controller.dart';
import 'zarvix_theme.dart';

class NewPassageView extends StatefulWidget {
  const NewPassageView({super.key});

  @override
  State<NewPassageView> createState() => _NewPassageViewState();
}

class _NewPassageViewState extends State<NewPassageView> {
  final _quoteCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _bookCtrl = TextEditingController();
  final _pageCtrl = TextEditingController();

  void _submit() {
    if (_quoteCtrl.text.isNotEmpty && _authorCtrl.text.isNotEmpty) {
      final page = int.tryParse(_pageCtrl.text) ?? 1;
      context.read<QuoteVaultController>().addQuote(
            _quoteCtrl.text,
            _authorCtrl.text,
            _bookCtrl.text.isEmpty ? 'Unknown Work' : _bookCtrl.text,
            page,
          );
      _quoteCtrl.clear();
      _authorCtrl.clear();
      _bookCtrl.clear();
      _pageCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passage preserved in vault!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: ZarvixTheme.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ZarvixTheme.borderSubtle),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Capture Book Passage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              TextField(
                controller: _quoteCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Memorable Quote / Passage Text',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _authorCtrl,
                decoration: const InputDecoration(labelText: 'Author Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _bookCtrl,
                      decoration: const InputDecoration(labelText: 'Book Title', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _pageCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Page #', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ZarvixTheme.amberAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Save to Offline Vault', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
