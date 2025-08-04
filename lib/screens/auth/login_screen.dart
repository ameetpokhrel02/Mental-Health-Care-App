import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/api_service.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        'WELCOME',
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: TextFormField(
                                controller: _emailController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(18),
                                ),
                                validator:
                                    (value) =>
                                        value?.isEmpty ?? true
                                            ? 'Please enter your email'
                                            : null,
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white70,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(18),
                                ),
                                obscureText: true,
                                validator:
                                    (value) =>
                                        value?.isEmpty ?? true
                                            ? 'Please enter your password'
                                            : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (_) {}),
                          Text(
                            'Remember me',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap:
                                () => Navigator.pushNamed(
                                  context,
                                  '/forgot_password',
                                ),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.white70,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
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
                      Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialLoginButton('assets/icons/google.png', () {}),
                          SizedBox(width: 16),
                          _socialLoginButton(
                            'assets/icons/facebook.png',
                            () {},
                          ),
                          SizedBox(width: 16),
                          _socialLoginButton('assets/icons/apple.png', () {}),
                        ],
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
                                () => Navigator.pushNamed(context, '/signup'),
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
                      TextButton(
                        onPressed:
                            () => Navigator.pushNamed(context, '/doctor_login'),
                        child: Text(
                          'Login as Doctor',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
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

  Widget _socialLoginButton(String iconPath, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(iconPath, height: 24, width: 24),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final response = await ApiService.login(
          _emailController.text,
          _passwordController.text,
        );

        // Update auth provider
        Provider.of<AuthProvider>(context, listen: false).login('user');

        // Navigate to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}
