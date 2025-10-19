import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyLearningPage extends StatelessWidget {
  const MyLearningPage({super.key});

  final List<Map<String, dynamic>> courses = const [
    {
      "title": "Flutter for Beginners",
      "tutor": "Dr. Angela Yu",
      "hours": "12h 30m",
      "certification": "Yes",
      "submissions": "5",
      "overview": "A complete Flutter course for absolute beginners.",
      "link": "https://excelerate.com/flutter-course"
    },
    {
      "title": "Advanced React",
      "tutor": "Jonas Schmedtmann",
      "hours": "10h 00m",
      "certification": "Yes",
      "submissions": "3",
      "overview": "Master React hooks, context, and API integrations.",
      "link": "https://excelerate.com/react-course"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Learning'),
        backgroundColor: const Color(0xFFFFC857),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(course["title"]),
              subtitle: Text("Tutor: ${course["tutor"]}"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailsPage(course: course),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CourseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> course;
  const CourseDetailsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course["title"]),
        backgroundColor: const Color(0xFFFFC857),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Tutor: ${course['tutor']}", style: const TextStyle(fontSize: 16)),
          Text("Duration: ${course['hours']}"),
          Text("Certification: ${course['certification']}"),
          Text("Submissions: ${course['submissions']}"),
          const SizedBox(height: 10),
          Text("Overview", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 6),
          Text(course["overview"]),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              final Uri url = Uri.parse(course["link"]);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            icon: const Icon(Icons.link),
            label: const Text("Go to Course Page"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC857),
              foregroundColor: Colors.black87,
            ),
          ),
        ]),
      ),
    );
  }
}