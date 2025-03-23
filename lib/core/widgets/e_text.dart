import 'package:flutter/material.dart';

class EText extends StatelessWidget {
  const EText(this.data, {super.key, this.style, this.softWrap = false});
  final String data;
  final TextStyle? style;
  final bool? softWrap;
  @override
  Widget build(BuildContext context) =>
      Text(data, overflow: TextOverflow.fade, softWrap: softWrap, style: style);
}
