import 'package:edu_link/features/content/domain/content_item_entity.dart';
import 'package:edu_link/features/content/widgets/content_viewer.dart';
import 'package:flutter/material.dart';

class ContentItemCard extends StatelessWidget {
  const ContentItemCard({required this.item, super.key});
  final ContentItem item;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (item.type) {
      case ContentType.video:
        icon = Icons.play_circle_fill;
      case ContentType.pdf:
        icon = Icons.picture_as_pdf;
      case ContentType.image:
        icon = Icons.image;
    }

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(item.title),
        subtitle: Text(item.description),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContentViewer(item: item)),
          );
        },
      ),
    );
  }
}
