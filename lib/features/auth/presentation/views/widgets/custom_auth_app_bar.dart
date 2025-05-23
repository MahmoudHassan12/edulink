import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        FlexibleSpaceBar,
        GestureDetector,
        LinearProgressIndicator,
        MediaQuery,
        SliverAppBar,
        SliverSafeArea,
        StatelessWidget,
        TextStyle;

class CustomAuthAppBar extends StatelessWidget {
  const CustomAuthAppBar({
    required this.title,
    this.isLoading = false,
    this.automaticallyImplyLeading = true,
    super.key,
  });
  final bool isLoading;
  final String title;
  final bool automaticallyImplyLeading;
  @override
  SliverSafeArea build(BuildContext context) => SliverSafeArea(
    sliver: SliverAppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: isLoading
          ? const LinearProgressIndicator(borderRadius: xxsBorder)
          : null,
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          // TODO(Anyone): Remove the gesture detector after implementation
          child: GestureDetector(
            onLongPress: () => homeNavigation(context),
            child: EText(title, style: const TextStyle(fontSize: 36)),
          ),
        ),
      ),
      centerTitle: true,
      expandedHeight: MediaQuery.sizeOf(context).height / 4,
    ),
  );
}
