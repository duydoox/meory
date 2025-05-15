import 'package:flutter/material.dart';

class TextHighlight extends StatelessWidget {
  final String text;
  final String highlightText;
  final TextStyle? textStyle;
  final TextStyle? highlightStyle;

  const TextHighlight({
    super.key,
    required this.text,
    required this.highlightText,
    this.textStyle,
    this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (highlightText.isEmpty) {
      return Text(text, style: textStyle);
    }

    final textSpans = <TextSpan>[];
    final lowerText = text.toLowerCase();
    final lowerHighlight = highlightText.toLowerCase();

    int start = 0;
    while (start < text.length) {
      final index = lowerText.indexOf(lowerHighlight, start);
      if (index < 0) {
        textSpans.add(TextSpan(
          text: text.substring(start),
          style: textStyle,
        ));
        break;
      }

      if (index > start) {
        textSpans.add(TextSpan(
          text: text.substring(start, index),
          style: textStyle,
        ));
      }

      textSpans.add(TextSpan(
        text: text.substring(index, index + highlightText.length),
        style: highlightStyle ?? const TextStyle(color: Colors.red),
      ));
      start = index + highlightText.length;
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}
