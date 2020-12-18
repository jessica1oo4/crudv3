import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _error = "";

  String get error => _error;

  setError(String customMessage) {
    _error = customMessage;
    notifyListeners();
  }
}
