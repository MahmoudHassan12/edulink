import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        ConnectionState,
        StatelessWidget,
        StreamBuilder,
        Text,
        Widget;

class AppStreamBuilder<T> extends StatelessWidget {
  const AppStreamBuilder({
    required this.stream,
    required this.builder,
    super.key,
  });
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;
  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
    stream: stream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      if (!snapshot.hasData) {
        return const Center(child: Text('No data available'));
      }
      return builder(context, snapshot.data as T);
    },
  );
}
