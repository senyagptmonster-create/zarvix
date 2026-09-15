import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quote_vault_controller.dart';
import 'zarvix_theme.dart';

class ReadingReflectionsView extends StatefulWidget {
  const ReadingReflectionsView({super.key});

  @override
  State<ReadingReflectionsView> createState() => _ReadingReflectionsViewState();
}

class _ReadingReflectionsViewState extends State<ReadingReflectionsView> {
  final _reflectionCtrl = TextEditingController();

  void _save() {
    if (_reflectionCtrl.text.isNotEmpty) {
      context.read<QuoteVaultController>().addReflection(_reflectionCtrl.text);
      _reflectionCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Marginalia insight preserved!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<QuoteVaultController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ZarvixTheme.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ZarvixTheme.borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Write Marginalia Reflection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                TextField(
                  controller: _reflectionCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'What does this passage reveal about your current path?',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ZarvixTheme.amberAccent,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Add Reflection Note'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Contemplation Archives', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ...ctrl.reflections.map((r) => Card(
                color: ZarvixTheme.cardSurface,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.edit_note, color: ZarvixTheme.amberAccent),
                  title: Text(r, style: const TextStyle(fontSize: 13, height: 1.4)),
                ),
              )),
        ],
      ),
    );
  }
}
