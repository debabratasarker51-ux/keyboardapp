import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum KeyboardLayout {
  lowercase,
  uppercase,
  numbers,
  symbols,
}

class KeyboardManager with ChangeNotifier {
  final _inputController = TextEditingController();
  final _banglaController = TextEditingController();
  final _englishController = TextEditingController();

  TextEditingController get inputController => _inputController;
  TextEditingController get banglaController => _banglaController;
  TextEditingController get englishController => _englishController;

  KeyboardLayout _layout = KeyboardLayout.lowercase;
  KeyboardLayout get layout => _layout;

  Map<String, String> _enToBnMap = {};
  Map<String, String> _bnToEnMap = {};
  bool _isInitialized = false;

  KeyboardManager() {
    _loadJson();
    _inputController.addListener(_onInputChanged);
  }

  Future<void> _loadJson() async {
    try {
      final enToBnString = await rootBundle.loadString('assets/en_to_bn.json');
      final bnToEnString = await rootBundle.loadString('assets/bn_to_en.json');

      _enToBnMap = Map<String, String>.from(json.decode(enToBnString));
      _bnToEnMap = Map<String, String>.from(json.decode(bnToEnString));

      _isInitialized = true;
      notifyListeners(); // Notify listeners that maps are loaded
    } catch (e) {
      // Handle potential errors, e.g., file not found
      print('Error loading transliteration maps: $e');
    }
  }

  void _onInputChanged() {
    if (!_isInitialized) return;

    final text = _inputController.text;

    // Transliterate from English to Bangla
    final banglaBuffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      banglaBuffer.write(_enToBnMap[char] ?? char);
    }
    _banglaController.text = banglaBuffer.toString();

    // Transliterate from Bangla back to English
    final englishBuffer = StringBuffer();
    final banglaText = _banglaController.text;
    for (var i = 0; i < banglaText.length; i++) {
      final char = banglaText[i];
      englishBuffer.write(_bnToEnMap[char] ?? char);
    }
    _englishController.text = englishBuffer.toString();

    notifyListeners();
  }

  void handleKeyPress(String key) {
    final text = _inputController.text;
    final selection = _inputController.selection;

    String newText;
    TextSelection newSelection;

    switch (key) {
      case 'BACKSPACE':
        if (selection.isCollapsed && selection.start > 0) {
          newText = text.substring(0, selection.start - 1) + text.substring(selection.start);
          newSelection = TextSelection.collapsed(offset: selection.start - 1);
        } else if (!selection.isCollapsed) {
          newText = text.replaceRange(selection.start, selection.end, '');
          newSelection = TextSelection.collapsed(offset: selection.start);
        } else {
          return;
        }
        break;
      case 'ENTER':
        newText = text.replaceRange(selection.start, selection.end, '\n');
        newSelection = TextSelection.collapsed(offset: selection.start + 1);
        break;
      case 'SPACE':
        newText = text.replaceRange(selection.start, selection.end, ' ');
        newSelection = TextSelection.collapsed(offset: selection.start + 1);
        break;
      case 'LEFT':
        newSelection = TextSelection.collapsed(offset: (selection.start - 1).clamp(0, text.length));
        newText = text;
        break;
      case 'RIGHT':
        newSelection = TextSelection.collapsed(offset: (selection.start + 1).clamp(0, text.length));
        newText = text;
        break;
      default:
        newText = text.replaceRange(selection.start, selection.end, key);
        newSelection = TextSelection.collapsed(offset: selection.start + key.length);
    }

    _inputController.value = TextEditingValue(
      text: newText,
      selection: newSelection,
    );
  }

  void toggleCase() {
    if (_layout == KeyboardLayout.lowercase) {
      _layout = KeyboardLayout.uppercase;
    } else if (_layout == KeyboardLayout.uppercase) {
      _layout = KeyboardLayout.lowercase;
    } else {
      _layout = KeyboardLayout.lowercase; // Default to lowercase if not in a letter layout
    }
    notifyListeners();
  }

  void switchToLetters() {
    if (_layout != KeyboardLayout.lowercase && _layout != KeyboardLayout.uppercase) {
      _layout = KeyboardLayout.lowercase;
      notifyListeners();
    }
  }

  void switchToNumbers() {
    if (_layout != KeyboardLayout.numbers) {
      _layout = KeyboardLayout.numbers;
      notifyListeners();
    }
  }

  void switchToSymbols() {
    if (_layout != KeyboardLayout.symbols) {
      _layout = KeyboardLayout.symbols;
      notifyListeners();
    }
  }

  void clearAllText() {
    _inputController.clear();
  }

  @override
  void dispose() {
    _inputController.removeListener(_onInputChanged);
    _inputController.dispose();
    _banglaController.dispose();
    _englishController.dispose();
    super.dispose();
  }
}
