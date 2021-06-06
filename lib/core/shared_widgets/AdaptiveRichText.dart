import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveRichText extends StatelessWidget {
  final TextSpan textSpan;
  final TextStyle? textStyle;

  const AdaptiveRichText({Key? key, required this.textSpan, this.textStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (kIsWeb)
      return SelectableText.rich(
        textSpan,
        style: textStyle,
      );
    else
      return Text.rich(textSpan, style: textStyle);
  }
}
