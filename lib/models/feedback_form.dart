class FeedbackForm {
  final String name;
  final String email;
  final String program;
  final int rating;
  final String comments;
  final DateTime submittedAt;

  FeedbackForm({
    required this.name,
    required this.email,
    required this.program,
    required this.rating,
    required this.comments,
  }) : submittedAt = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'program': program,
      'rating': rating,
      'comments': comments,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  factory FeedbackForm.fromJson(Map<String, dynamic> json) {
    return FeedbackForm(
      name: json['name'] as String,
      email: json['email'] as String,
      program: json['program'] as String,
      rating: json['rating'] as int,
      comments: json['comments'] as String,
    );
  }
}