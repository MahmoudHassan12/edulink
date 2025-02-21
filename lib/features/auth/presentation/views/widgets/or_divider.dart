import 'package:flutter/material.dart'
    show
        BuildContext,
        Divider,
        EdgeInsets,
        Flexible,
        MainAxisAlignment,
        Padding,
        Row,
        StatelessWidget,
        Text,
        TextStyle;

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});
  @override
  Row build(BuildContext context) => const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(child: Divider(thickness: 1.5)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text('OR', style: TextStyle(fontSize: 16)),
      ),
      Flexible(child: Divider(thickness: 1.5)),
    ],
  );
}
