import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class AboutViewBody extends StatelessWidget {
  const AboutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    TableRow row(String name) => TableRow(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.person, color: Color.fromARGB(255, 11, 103, 223)),
        ),
        Padding(padding: const EdgeInsets.all(12), child: Text(name)),
      ],
    );
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          sliver: SliverList.list(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '''
EduLink is a smart university platform that bridges communication between students and professors.
It allows students to apply for courses, access organized course materials, participate in course-specific Q&A forums, and chat 1-to-1 with professors.
Professors can manage their courses, moderate discussions, and customize their profiles.
EduLink simplifies academic interaction and brings everything students need into one place.''',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 32),
              const EText(
                'Developed By',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Table(
                border: TableBorder.all(
                  color: const Color.fromARGB(255, 41, 41, 41),
                  width: 1.2,
                  borderRadius: xxsBorder,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(0.2),
                  1: FlexColumnWidth(),
                },
                children: [
                  row('Hossam Hassan Ibrahem'),
                  row('Mahmoud Hassan Samir'),
                  row('Yousef Saber Mohammad Kamal'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
