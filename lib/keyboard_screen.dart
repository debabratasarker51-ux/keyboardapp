import 'package:flutter/material.dart';
import 'package:myapp/managers/keyboard_manager.dart';
import 'package:myapp/widgets/keyboard_widget.dart';
import 'package:myapp/widgets/labeled_text_box.dart';
import 'package:provider/provider.dart';

class KeyboardScreen extends StatelessWidget {
  const KeyboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KeyboardManager(),
      child: Consumer<KeyboardManager>(
        builder: (context, manager, child) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: const Text('Bangla Transliteration Keyboard'),
              elevation: 2,
              actions: [
                TextButton(
                  onPressed: manager.clearAllText,
                  child: const Text(
                    'Clear All',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledTextBox(
                            controller: manager.inputController,
                            label: 'Input',
                            isInput: true,
                          ),
                          const SizedBox(width: 4),
                          LabeledTextBox(
                            controller: manager.banglaController,
                            label: 'Bangla',
                          ),
                          const SizedBox(width: 4),
                          LabeledTextBox(
                            controller: manager.englishController,
                            label: 'English',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  KeyboardWidget(
                    onKeyPressed: manager.handleKeyPress,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
