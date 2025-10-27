import 'package:flutter/material.dart';
import '../models/program_model.dart';

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