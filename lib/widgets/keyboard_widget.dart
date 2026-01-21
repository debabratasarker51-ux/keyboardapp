import 'package:flutter/material.dart';
import 'package:myapp/managers/keyboard_manager.dart';
import 'package:provider/provider.dart';

class KeyboardWidget extends StatelessWidget {
  final Function(String) onKeyPressed;

  const KeyboardWidget({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double scaleFactor = (constraints.maxWidth / 400.0).clamp(0.8, 1.5);

            return Container(
              width: double.infinity,
              color: Colors.grey.shade300,
              padding: const EdgeInsets.all(4.0),
              child: _buildLayout(scaleFactor),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLayout(double scaleFactor) {
    return Builder(builder: (context) {
      final keyboardManager = Provider.of<KeyboardManager>(context);
      switch (keyboardManager.layout) {
        case KeyboardLayout.numbers:
          return _buildNumbersLayout(scaleFactor);
        case KeyboardLayout.symbols:
          return _buildSymbolsLayout(scaleFactor);
        default: // lowercase or uppercase
          return _buildLettersLayout(scaleFactor);
      }
    });
  }

  Widget _buildLettersLayout(double scaleFactor) {
    return Column(
      children: [
        _buildKeyboardRow(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], scaleFactor),
        _buildKeyboardRow(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'], scaleFactor),
        _buildThirdRow(scaleFactor),
        _buildBottomRow(scaleFactor),
      ],
    );
  }

  Widget _buildNumbersLayout(double scaleFactor) {
    return Column(
      children: [
        _buildKeyboardRow(['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'], scaleFactor),
        _buildKeyboardRow(['-', '/', ':', ';', '(', ')', '&', '@', '"'], scaleFactor),
        _buildKeyboardRow(['.', ',', '?', '!', '\'', 'x'], scaleFactor, addBackspace: true),
        _buildBottomRow(scaleFactor),
      ],
    );
  }

  Widget _buildSymbolsLayout(double scaleFactor) {
    return Column(
      children: [
        _buildKeyboardRow(['[', ']', '{', '}', '#', '%', '^', '*', '+', '='], scaleFactor),
        _buildKeyboardRow(['_', '\\\\', '|', '~', '<', '>', '\$', '€', '£'], scaleFactor),
        _buildKeyboardRow(['.', ',', '?', '!', '\''], scaleFactor, addBackspace: true),
        _buildBottomRow(scaleFactor),
      ],
    );
  }

  Widget _buildKeyboardRow(List<String> keys, double scaleFactor, {bool addBackspace = false}) {
    return Builder(builder: (context) {
      final keyboardManager = Provider.of<KeyboardManager>(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...keys.map((key) {
            if (keyboardManager.layout == KeyboardLayout.uppercase) {
              key = key.toUpperCase();
            }
            return Expanded(
              child: KeyboardKey(
                label: key,
                onTap: () => onKeyPressed(key),
                scaleFactor: scaleFactor,
              ),
            );
          }),
          if (addBackspace)
            Expanded(
              flex: 1,
              child: KeyboardKey(
                onTap: () => onKeyPressed('BACKSPACE'),
                isFunctional: true,
                scaleFactor: scaleFactor,
                child: Icon(
                  Icons.backspace,
                  size: 24 * scaleFactor,
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildThirdRow(double scaleFactor) {
    return Builder(builder: (context) {
      final keyboardManager = Provider.of<KeyboardManager>(context);
      final isUppercase = keyboardManager.layout == KeyboardLayout.uppercase;
      final keys = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: KeyboardKey(
              onTap: keyboardManager.toggleCase,
              isFunctional: true,
              scaleFactor: scaleFactor,
              child: Icon(
                isUppercase ? Icons.arrow_downward : Icons.arrow_upward,
                color: isUppercase ? Colors.blue : Colors.black,
                size: 24 * scaleFactor,
              ),
            ),
          ),
          ...keys.map((key) {
            if (isUppercase) {
              key = key.toUpperCase();
            }
            return Expanded(
              child: KeyboardKey(
                label: key,
                onTap: () => onKeyPressed(key),
                scaleFactor: scaleFactor,
              ),
            );
          }),
          Expanded(
            flex: 1,
            child: KeyboardKey(
              onTap: () => onKeyPressed('BACKSPACE'),
              isFunctional: true,
              scaleFactor: scaleFactor,
              child: Icon(
                Icons.backspace,
                size: 24 * scaleFactor,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBottomRow(double scaleFactor) {
    return Builder(builder: (context) {
      final keyboardManager = Provider.of<KeyboardManager>(context);
      final layout = keyboardManager.layout;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (layout == KeyboardLayout.numbers || layout == KeyboardLayout.symbols)
            Expanded(
              flex: 2,
              child: KeyboardKey(
                label: 'ABC',
                onTap: () => keyboardManager.switchToLetters(),
                isFunctional: true,
                scaleFactor: scaleFactor,
              ),
            )
          else
            Expanded(
              flex: 2,
              child: KeyboardKey(
                label: '?123',
                onTap: () => keyboardManager.switchToNumbers(),
                isFunctional: true,
                scaleFactor: scaleFactor,
              ),
            ),
          if (layout != KeyboardLayout.symbols)
            Expanded(
              flex: 2,
              child: KeyboardKey(
                label: '#+=',
                onTap: () => keyboardManager.switchToSymbols(),
                isFunctional: true,
                scaleFactor: scaleFactor,
              ),
            )
          else
            Expanded(
              flex: 2,
              child: KeyboardKey(
                label: '?123',
                onTap: () => keyboardManager.switchToNumbers(),
                isFunctional: true,
                scaleFactor: scaleFactor,
              ),
            ),
          Expanded(
            flex: 5,
            child: KeyboardKey(
              label: 'space',
              onTap: () => onKeyPressed('SPACE'),
              isFunctional: true,
              scaleFactor: scaleFactor,
            ),
          ),
          Expanded(
            flex: 2,
            child: KeyboardKey(
              onTap: () => onKeyPressed('ENTER'),
              isFunctional: true,
              scaleFactor: scaleFactor,
              child: Icon(
                Icons.send,
                size: 24 * scaleFactor,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class KeyboardKey extends StatelessWidget {
  final String? label;
  final Widget? child;
  final VoidCallback onTap;
  final bool isFunctional;
  final bool isDisabled;
  final bool isSelected;
  final double scaleFactor;

  const KeyboardKey({
    super.key,
    this.label,
    this.child,
    required this.onTap,
    this.isFunctional = false,
    this.isDisabled = false,
    this.isSelected = false,
    this.scaleFactor = 1.0,
  }) : assert(label != null || child != null);

  @override
  Widget build(BuildContext context) {
    Color color = isFunctional ? Colors.grey.shade400 : Colors.white;
    if (isSelected) {
      color = Colors.blue.shade300;
    }
    if (isDisabled) {
      color = Colors.grey.shade500;
    }

    final keyContent = child ??
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label!,
            style: TextStyle(
              fontSize: 16.0 * scaleFactor,
              fontWeight: FontWeight.w500,
              color: isDisabled ? Colors.white.withAlpha(128) : Colors.black,
            ),
          ),
        );

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        margin: const EdgeInsets.all(2.0),
        padding: EdgeInsets.symmetric(
            vertical: 12.0 * scaleFactor, horizontal: 6.0 * scaleFactor),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: keyContent,
        ),
      ),
    );
  }
}
