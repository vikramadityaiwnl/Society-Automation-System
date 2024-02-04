import 'package:flutter/material.dart';

class CustomDialog {
  static void showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      },
    );
  }

  static void showCustomDialogWithInput(BuildContext context, String title, String message, Function(String) onInput) {
    final TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: message,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                onInput(textController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 12),
                Text('Please wait while we process your request...'),
              ],
            ),
          ),
        );
      },
    );
  }

  static void dismiss(BuildContext context) => Navigator.of(context).pop();
}
