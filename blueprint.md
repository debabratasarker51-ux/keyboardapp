# Project Blueprint: Flutter Keyboard App

## Overview

This document outlines the plan and implementation details for a custom Flutter keyboard application. The goal is to create a keyboard with English letters, numbers, and symbols, along with a preview area that shows the input in English and a transliterated Bangla output.

## Current Plan

### Step 1: Project Setup & Basic UI

*   **Create `blueprint.md`:** Done.
*   **Modify `lib/main.dart`:** Set up the main app structure with a `MaterialApp` and a `HomeScreen`.
*   **Create `keyboard_screen.dart`:** This will be the main screen of the app, holding the preview and keyboard widgets.
*   **Create `preview_widget.dart`:** This widget will display the input text and will have tabs for "Input", "Bangla", and "English".
*   **Create `keyboard_widget.dart`:** This widget will render the custom keyboard layout.

### Step 2: Keyboard Logic

*   Implement the logic for handling key presses.
*   Update the preview widget with the typed text.

### Step 3: Bangla Transliteration

*   Integrate a package or an API for transliterating English text to Bangla.
*   Display the transliterated text in the "Bangla" tab of the preview widget.

### Step 4: Styling and Refinements

*   Apply Material Design principles to create a visually appealing and user-friendly interface.
*   Add animations and feedback for key presses.
*   Ensure the app is responsive and works well on different screen sizes.
    *   **Make keyboard layout responsive:** Updated `keyboard_widget.dart` to adjust the keyboard layout and key sizes based on the screen width.
    *   **Fix keyboard layout bug:** Corrected a syntax error in the symbol layout definition.
    *   **Enhanced Responsiveness:** Constrained the maximum width of the keyboard to prevent stretching on large screens and refined the scaling logic for a more graceful scaling of keys and fonts.
    *   **Align text boxes with keyboard:** Applied the same `maxWidth` constraint to the text boxes to ensure they align perfectly with the keyboard.
*   **Fix linting warning:** Refactored the `KeyboardLayout` enum to use `lowerCamelCase` for its values (`lowercase`, `uppercase`, `symbols`) to adhere to Dart's style guide.
*   **Fix deprecated `withOpacity`:** Replaced the deprecated `withOpacity` method with `withAlpha` to adhere to current Flutter best practices.
*   **Code Cleanup:** Removed redundant `.toList()` calls when using spread operators for cleaner and more efficient code.
*   **Fix unnecessary escape:** Removed an unnecessary `\` escape from a string literal in the symbol layout definition.


### Step 5: UI Enhancements

*   **Add a close button to the preview widget:** Implemented a close button to allow users to hide the preview section.
*   **Add separation between the preview tabs and content:** Added a 3-pixel separation for better visual clarity.
*   **Replace "upper/lower" text with an icon:** Changed the case-toggle button to display an upward arrow icon (`Icons.arrow_upward`) instead of text, with dynamic color to indicate the uppercase state.
*   **Dynamic case-toggle icon:** The case-toggle button now shows an upward arrow to switch to uppercase and a downward arrow to switch to lowercase.
*   **Improved Keyboard Layout:** The keyboard layout has been updated for better ergonomics and a cleaner look. The case-toggle button is now on the left of the third row, and the backspace key (now an icon) is on the right. This creates a more traditional and balanced layout, and simplifies the bottom row to just the 'symbols' and 'space' keys.
*   **Add Send/Enter button:** A "Send/Enter" button with a `send` icon has been added to the bottom right of the keyboard.
*   **Multi-Layout Keyboard with Top Control Row:** The keyboard has been completely redesigned with a multi-layout architecture.
    *   **Top Control Row:** A dedicated row at the top of the keyboard provides buttons ("ABC", "?123", "#+=") to switch between the letter, number, and symbol layouts.
    *   **Letter Layout:** The standard QWERTY keyboard for text entry.
    *   **Number Layout:** A numpad-style interface for efficient number input.
    *   **Symbol Layout:** A grid-based layout for a wide range of symbols.
    This new structure provides a more powerful and intuitive user experience, similar to modern mobile keyboards.
