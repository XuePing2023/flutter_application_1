import 'package:flutter/material.dart';
import '../../core/storage/storage_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  final TextEditingController _controller = TextEditingController();
  String _savedData = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _savedData = StorageService().getString('example_key') ?? '';
    });
  }

  Future<void> _saveData() async {
    await StorageService().setString('example_key', _controller.text);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.dataSaved)),
      );
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.storageTab),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: l10n.enterText,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveData,
                  child: Text(l10n.saveData),
                ),
                ElevatedButton(
                  onPressed: _loadData,
                  child: Text(l10n.loadData),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('${l10n.loadData}: $_savedData'),
          ],
        ),
      ),
    );
  }
}
