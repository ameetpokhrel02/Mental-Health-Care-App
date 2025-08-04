import 'package:flutter/material.dart';

class ResetPasswordRequestScreen extends StatefulWidget {
  const ResetPasswordRequestScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordRequestScreen> createState() =>
      _ResetPasswordRequestScreenState();
}

class _ResetPasswordRequestScreenState
    extends State<ResetPasswordRequestScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  bool _isLoading = false;

  void _requestReset() async {
    setState(() => _isLoading = true);
    // TODO: Implement reset password request logic
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    // Show result or navigate
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Password Reset')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailOrPhoneController,
              decoration: const InputDecoration(labelText: 'Email or Phone'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _requestReset,
                  child: const Text('Request Reset'),
                ),
          ],
        ),
      ),
    );
  }
}
