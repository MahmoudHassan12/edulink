import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class AboutViewBody extends StatelessWidget {
  const AboutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/logo.png'),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(height: 12),
          const Text(
            'EduLink is a smart university platform that bridges communication between students and professors. '
            'It allows students to apply for courses, access organized course materials, participate in course-specific Q&A forums, '
            'and chat 1-to-1 with professors. Professors can manage their courses, moderate discussions, and customize their profiles. '
            'EduLink simplifies academic interaction and brings everything students need into one place.',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 32),
          const EText(
            'Authors',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(
              color: const Color.fromARGB(255, 41, 41, 41),
              width: 1.2,
              borderRadius: BorderRadius.circular(12),
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(0.2),
              1: FlexColumnWidth(1),
            },
            children: const [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.person, color: Color.fromARGB(255, 11, 103, 223)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Hossam Hassan Ibrahem'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.person, color: Color.fromARGB(255, 11, 103, 223)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Mahmoud Hassan Samir'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.person, color: Color.fromARGB(255, 11, 103, 223)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Yousef Saber Mohammad-Kamal'),
                  ),
                ],
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
