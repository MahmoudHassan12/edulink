import 'dart:async';

import 'package:edu_link/core/helpers/navigations.dart' show popNavigation;
import 'package:edu_link/core/services/content_service.dart';
import 'package:edu_link/features/content/domain/content_item_entity.dart';
import 'package:edu_link/features/content/widgets/content_card.dart';
import 'package:flutter/material.dart';

class ContentViewBody extends StatefulWidget {
  const ContentViewBody({
    required this.courseId,
    required this.isProfessor,
    super.key,
  });
  final String courseId;
  final bool isProfessor;
  @override
  State<ContentViewBody> createState() => _ContentViewBodyState();
}

class _ContentViewBodyState extends State<ContentViewBody> {
  final _contentService = ContentService();
  List<ContentItem> _contentItems = [];
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_loadContent());
  }

  Future<void> _loadContent() async {
    try {
      final List<ContentItem> items = await _contentService
          .fetchContentsForCourse(widget.courseId);
      setState(() {
        _contentItems = items;
        _isLoading = false;
      });
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error loading content: $e',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteContent(ContentItem item) async {
    try {
      final String fileName = Uri.decodeFull(
        Uri.parse(item.url).pathSegments.last,
      );
      await _contentService.deleteContent(widget.courseId, item.type, fileName);

      setState(() {
        _contentItems.remove(item);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Content deleted successfully.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to delete: $e',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<bool?> _confirmDismiss(BuildContext context, ContentItem item) =>
      showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Content'),
          content: const Text('Are you sure you want to delete this content?'),
          actions: [
            TextButton(
              onPressed: () => popNavigation(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => popNavigation(context, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_contentItems.isEmpty) {
      return const Center(child: Text('No content available'));
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: _contentItems.length,
        itemBuilder: (context, index) {
          final ContentItem item = _contentItems[index];

          if (widget.isProfessor) {
            return Dismissible(
              key: Key(item.url),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) => _confirmDismiss(context, item),
              onDismissed: (direction) => _deleteContent(item),
              background: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white, size: 30),
              ),
              child: ContentItemCard(item: item),
            );
          } else {
            return ContentItemCard(item: item);
          }
        },
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {});
  }
}
