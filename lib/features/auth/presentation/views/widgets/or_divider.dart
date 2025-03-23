import 'package:edu_link/core/widgets/e_text.dart';
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
        child: EText('OR', style: TextStyle(fontSize: 16)),
      ),
      Flexible(child: Divider(thickness: 1.5)),
    ],
  );
}
