import 'package:flutter/material.dart';

class PasswordValidatorProvider extends ChangeNotifier {
  bool _isPasswordEightCharacters = false;
  bool get isPasswordEightCharacters => _isPasswordEightCharacters;

  bool _hasPasswordOneNumber = false;
  bool get hasPasswordOneNumber => _hasPasswordOneNumber;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    _isPasswordEightCharacters = false;
    if (password.length >= 8) _isPasswordEightCharacters = true;

    _hasPasswordOneNumber = false;
    if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;
    notifyListeners();
  }
}
