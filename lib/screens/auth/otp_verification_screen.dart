import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String? phoneOrEmail;
  const OtpVerificationScreen({Key? key, this.phoneOrEmail}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  void _verifyOtp() async {
    setState(() => _isLoading = true);
    // TODO: Implement OTP verification logic
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    // Navigate or show result
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP sent to ${widget.phoneOrEmail ?? "your number/email"}',
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'OTP'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _verifyOtp,
                  child: const Text('Verify'),
                ),
          ],
        ),
      ),
    );
  }
}
