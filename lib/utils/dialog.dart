import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/screens/home/home_screen.dart';
import 'package:todo_bloc/utils/color_constant.dart';
import 'package:todo_bloc/utils/font_constant.dart';
import 'package:todo_bloc/utils/loading.dart';

class UtilDialog {
  static showInformation(
    BuildContext context, {
    String? title,
    String? content,
    Function()? onClose,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? 'Title',
            style: FONT_CONST.MEDIUM_PRIMARY_20,
          ),
          content: Text(content!),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: FONT_CONST.BOLD,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              },
            )
          ],
        );
      },
    );
  }

  static showWaiting(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            alignment: Alignment.center,
            child: Loading(),
          ),
        );
      },
    );
  }

  static hideWaiting(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<bool?> showConfirmation(
    BuildContext context, {
    String? title,
    required Widget content,
    String confirmButtonText = "Yes",
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? 'Title',
            style: FONT_CONST.MEDIUM_PRIMARY_24,
          ),
          content: content,
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: FONT_CONST.MEDIUM_PRIMARY_18,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: Text(
                confirmButtonText,
                style: FONT_CONST.REGULAR_WHITE_18,
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.settings.name == "Home");
              },
              style: TextButton.styleFrom(
                backgroundColor: COLOR_CONST.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  static showSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Success',
            style: FONT_CONST.MEDIUM_PRIMARY_20,
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: FONT_CONST.MEDIUM_PRIMARY_18,
              ),
              onPressed: () {
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == "Initial");
              },
            )
          ],
        );
      },
    );
  }
}
