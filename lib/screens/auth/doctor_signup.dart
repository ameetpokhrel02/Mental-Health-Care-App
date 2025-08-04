import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class DoctorSignupScreen extends StatefulWidget {
  @override
  _DoctorSignupScreenState createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends State<DoctorSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _specializationController = TextEditingController();
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
                        'DOCTOR REGISTRATION',
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
                              _nameController,
                              'Full Name',
                              Icons.person,
                              style: TextStyle(color: Colors.white),
                              fillColor: Colors.white.withOpacity(0.18),
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              _emailController,
                              'Email',
                              Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white),
                              fillColor: Colors.white.withOpacity(0.18),
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              _specializationController,
                              'Specialization',
                              Icons.local_hospital,
                              style: TextStyle(color: Colors.white),
                              fillColor: Colors.white.withOpacity(0.18),
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              _passwordController,
                              'Password',
                              Icons.lock,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              fillColor: Colors.white.withOpacity(0.18),
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              _confirmPasswordController,
                              'Confirm Password',
                              Icons.lock_outline,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              fillColor: Colors.white.withOpacity(0.18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignup,
                        child:
                            _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  'SIGN UP',
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
                            'Already have an account?',
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Login',
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
    TextInputType? keyboardType,
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
        keyboardType: keyboardType,
      ),
    );
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final response = await ApiService.doctorSignup(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _specializationController.text,
        );
        Navigator.pushReplacementNamed(context, '/doctor_login');
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _specializationController.dispose();
    super.dispose();
  }
}
