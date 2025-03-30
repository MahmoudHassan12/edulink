import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/core/widgets/user_photo.dart' show UserPhoto;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class AnswerCard extends StatelessWidget {
  const AnswerCard({required this.answer, this.hasDivider = true, super.key});
  final AnswerEntity answer;
  final bool hasDivider;
  @override
  Widget build(BuildContext context) {
    final user = answer.user;
    final date = DateFormat('MMMM dd, yyyy').format(answer.date!);
    final time = DateFormat('hh:mm a').format(answer.date!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            minTileHeight: 56,
            contentPadding: EdgeInsets.zero,
            leading: UserPhoto(imageUrl: user?.imageUrl),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EText(user!.name!, style: const TextStyle(fontSize: 14)),
              ],
            ),
            subtitle: EText(
              '$date at $time',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
          EText(answer.answer!, softWrap: true),
          if (hasDivider) const Divider(),
        ],
      ),
    );
  }
}
