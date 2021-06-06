import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String data;

  final TextStyle? style;
  final int? maxlines;

  final TextAlign? textAlign;

  const AdaptiveText(this.data,
      {Key? key, this.style, this.textAlign, this.maxlines})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (kIsWeb)
      return SelectableText(
        data,
        style: style,
        textAlign: textAlign,
        maxLines: maxlines,
      );
    else
      return Text(
        data,
        style: style,
        maxLines: maxlines,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
      );
  }
}
