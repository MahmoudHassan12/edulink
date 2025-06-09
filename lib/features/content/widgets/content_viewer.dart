import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/features/content/domain/content_item_entity.dart';
import 'package:edu_link/features/content/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ContentViewer extends StatelessWidget {
  const ContentViewer({required this.item, super.key});
  final ContentItem item;

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      case ContentType.video:
        return ExternalVideoScreen(videoUrl: item.url);
      case ContentType.pdf:
        return Scaffold(
          appBar: AppBar(title: Text(item.title)),
          body: SfPdfViewer.network(item.url),
        );
      case ContentType.image:
        return Scaffold(
          appBar: AppBar(title: Text(item.title)),
          body: Center(child: CachedNetworkImage(imageUrl: item.url)),
        );
    }
  }
}
