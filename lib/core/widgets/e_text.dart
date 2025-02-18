import 'package:flutter/material.dart';

class EText extends StatelessWidget {
  const EText(this.data, {super.key, this.style});
  final String data;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) =>
      Text(data, overflow: TextOverflow.fade, softWrap: false, style: style);
}
