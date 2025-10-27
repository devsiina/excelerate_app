import 'package:flutter/foundation.dart';

@immutable
class Program {
  final String id;
  final String title;
  final String instructor;
  final String description;
  final String duration;
  final String level;
  final double rating;
  final String students; // Changed to String to maintain formatting flexibility
  final String imageUrl;
  final double progress;

  const Program({
    required this.id,
    required this.title,
    required this.instructor,
    required this.description,
    required this.duration,
    required this.level,
    required this.rating,
    required this.students,
    required this.imageUrl,
    this.progress = 0.0,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      instructor: json['instructor']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      students: json['students']?.toString() ?? '0',
      level: json['level']?.toString() ?? 'Beginner',
      duration: json['duration']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instructor': instructor,
      'rating': rating,
      'students': students,
      'level': level,
      'duration': duration,
      'description': description,
      'imageUrl': imageUrl,
      'progress': progress,
    };
  }

  Program copyWith({
    String? id,
    String? title,
    String? instructor,
    String? description,
    String? duration,
    String? level,
    double? rating,
    String? students,
    String? imageUrl,
    double? progress,
  }) {
    return Program(
      id: id ?? this.id,
      title: title ?? this.title,
      instructor: instructor ?? this.instructor,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      level: level ?? this.level,
      rating: rating ?? this.rating,
      students: students ?? this.students,
      imageUrl: imageUrl ?? this.imageUrl,
      progress: progress ?? this.progress,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Program &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          instructor == other.instructor &&
          description == other.description &&
          duration == other.duration &&
          level == other.level &&
          rating == other.rating &&
          students == other.students &&
          imageUrl == other.imageUrl &&
          progress == other.progress;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      instructor.hashCode ^
      description.hashCode ^
      duration.hashCode ^
      level.hashCode ^
      rating.hashCode ^
      students.hashCode ^
      imageUrl.hashCode ^
      progress.hashCode;
}