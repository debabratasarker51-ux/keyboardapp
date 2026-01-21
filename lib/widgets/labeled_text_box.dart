import 'package:flutter/material.dart';

class LabeledTextBox extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isInput;

  const LabeledTextBox({
    super.key,
    required this.controller,
    required this.label,
    this.isInput = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            readOnly: !isInput,
            showCursor: isInput,
            autofocus: isInput,
            minLines: 1,
            maxLines: 5,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isInput ? Theme.of(context).primaryColor : Colors.grey.shade400,
                  width: isInput ? 2.0 : 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isInput ? Theme.of(context).primaryColor : Colors.grey.shade400,
                  width: isInput ? 2.0 : 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
