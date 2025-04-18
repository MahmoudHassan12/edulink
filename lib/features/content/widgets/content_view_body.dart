import 'package:edu_link/core/services/content_service.dart';
import 'package:edu_link/features/content/domain/content_item_entity.dart';
import 'package:edu_link/features/content/widgets/content_card.dart';
import 'package:flutter/material.dart';

class ContentViewBody extends StatelessWidget {
  const ContentViewBody({required this.courseId, super.key});
  final String courseId;

  Future<List<ContentItem>> get _content async =>
      ContentService().fetchContentsForCourse(courseId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ContentItem>>(
      future: _content,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No content available'));
        }
        final contentItems = snapshot.data ?? [];
        return ListView.builder(
          itemCount: contentItems.length,
          itemBuilder:
              (context, index) => ContentItemCard(item: contentItems[index]),
        );
      },
    );
  }
}
