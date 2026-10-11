import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ConnectionTestScreen extends StatefulWidget {
  const ConnectionTestScreen({super.key});

  @override
  State<ConnectionTestScreen> createState() => _ConnectionTestScreenState();
}

class _ConnectionTestScreenState extends State<ConnectionTestScreen> {
  String _statusMessage = 'Testing connection to Django...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _runTest();
  }

  Future<void> _runTest() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Connecting to ${ApiService.baseUrl}...';
    });

    final statusCode = await ApiService.checkConnection();

    setState(() {
      _isLoading = false;
      if (statusCode == 401) {
        _statusMessage =
        'SUCCESS! (HTTP 401)\nReached Django backend.\nAuthentication barrier active.';
      } else if (statusCode == 200) {
        _statusMessage = 'SUCCESS! (HTTP 200)\nConnected to backend.';
      } else if (statusCode == -1) {
        _statusMessage =
        'FAILED TO CONNECT!\nCheck Wi-Fi, IP address, and make sure Django is running on 0.0.0.0:8000.';
      } else {
        _statusMessage = 'Connected! Server returned HTTP $statusCode';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Django Connection Test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading) const CircularProgressIndicator(),
              if (!_isLoading) ...[
                Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _runTest,
                  child: const Text('Retry Connection'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}