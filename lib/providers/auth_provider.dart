import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userType;

  bool get isAuthenticated => _isAuthenticated;
  String? get userType => _userType;

  void login(String type) {
    _isAuthenticated = true;
    _userType = type;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _userType = null;
    notifyListeners();
  }
}