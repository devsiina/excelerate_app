import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/program_provider.dart';
import '../models/program_model.dart';

class MyLearningPage extends StatelessWidget {
  const MyLearningPage({super.key});

  Widget _buildCourseList(BuildContext context, List<Program> courses) {
    if (courses.isEmpty) {
      return const Center(
        child: Text(
          'You are not enrolled in any courses yet.\nGo to the Home tab to start learning!',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        final course = courses[index];
        return Card(
          margin: const EdgeInsets.all(12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFF1E7FF),
              backgroundImage: course.imageUrl.isNotEmpty ? NetworkImage(course.imageUrl) : null,
              child: course.imageUrl.isEmpty ? const Icon(Icons.play_circle_fill, color: Colors.deepPurple) : null,
            ),
            title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tutor: ${course.instructor}"),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: course.progress,
                  color: const Color(0xFFFFC857),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 4),
                Text('${(course.progress * 100).toInt()}% Completed')
              ],
            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Learning'),
        backgroundColor: const Color(0xFFFFC857),
      ),
      body: programProvider.programsWithProgress.when(
        success: (courses) => _buildCourseList(context, courses),
        failure: (error) => Center(
          child: Text('Error loading courses: $error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}


class CourseDetailsPage extends StatelessWidget {
  final Program course;
  const CourseDetailsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: const Color(0xFFFFC857),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            if (course.imageUrl.isNotEmpty)
              Container(
                height: 150,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(course.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Text("Tutor: ${course.instructor}", style: const TextStyle(fontSize: 16)),
            Text("Duration: ${course.duration}"),
            Text("Level: ${course.level}"),
            Text("Rating: ${course.rating} ⭐ (${course.students} students)"),
            const SizedBox(height: 16),
            const Text("Overview", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 6),
            Text(course.description),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}