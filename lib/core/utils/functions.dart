import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Functions {
  static void printWarning(String text) {
    if (kDebugMode) {
      print('\x1B[33m$text\x1B[0m');
    }
  }

  static void printError(String text) {
    if (kDebugMode) {
      print('\x1B[31m$text\x1B[0m');
    }
  }

  static void printNormal(String text) {
    if (kDebugMode) {
      print('\x1B[36m$text\x1B[0m');
    }
  }

  static void printDone(String text) {
    if (kDebugMode) {
      print('\x1B[32m$text\x1B[0m');
    }
  }

  static Size textSize({
    required String text,
    required TextStyle? style,
    int maxLines = 1,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }

  static showLoaderDialog(BuildContext context) {
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const Dialog(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
          );
        });
    //     .timeout(const Duration(seconds: 20)).catchError((value) {
    //   context.pop();
    //   toast(language.errorInternetNotAvailable);
    // });
  }
}
