import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../core/network/http_client.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  String _data = '';
  bool _isLoading = false;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _data = '';
    });

    try {
      final response = await HttpClient().dio.get('/posts/1');
      setState(() {
        _data = response.data.toString();
      });
    } on DioException catch (e) {
      setState(() {
        _data = 'Error: ${e.message}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.networkTab),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchData,
              child: Text(_isLoading ? 'Loading...' : l10n.fetchData),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_data.isEmpty ? l10n.noData : _data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
