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
