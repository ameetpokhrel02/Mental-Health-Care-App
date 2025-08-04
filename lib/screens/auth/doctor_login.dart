import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class DoctorLoginScreen extends StatefulWidget {
  @override
  _DoctorLoginScreenState createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D5BBA), Color(0xFF8D58BF), Color(0xFFDE67A3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 370,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 30,
                        offset: Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'DOCTOR LOGIN',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          color: Colors.white.withOpacity(0.95),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              _emailController,
                              'Email',
                              Icons.email,
                              style: TextStyle(color: Colors.white),
                              fillColor: Colors.white.withOpacity(0.18),
                            ),
                            SizedBox(height: 18),
                            _buildTextField(
                              _passwordController,
                              'Password',
                              Icons.lock,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              fillColor: Colors.white.withOpacity(0.18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        child:
                            _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF76B6A),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed:
                                () => Navigator.pushNamed(
                                  context,
                                  '/doctor_signup',
                                ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xFFF76B6A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
    TextStyle? style,
    Color? fillColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        controller: controller,
        style: style,
        decoration: InputDecoration(
          hintText: label,
          hintStyle:
              style?.copyWith(color: Colors.white70) ??
              TextStyle(color: Colors.black45),
          prefixIcon: Icon(icon, color: style?.color ?? Colors.black45),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(18),
        ),
        obscureText: obscureText,
        validator:
            (value) =>
                value?.isEmpty ?? true ? 'Please enter your $label' : null,
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final response = await ApiService.doctorLogin(
          _emailController.text.trim(),
          _passwordController.text,
        );

        if (response.containsKey('token')) {
          Navigator.pushReplacementNamed(context, '/doctor-dashboard');
        } else {
          throw Exception('Invalid response from server');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception:', '')),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}
