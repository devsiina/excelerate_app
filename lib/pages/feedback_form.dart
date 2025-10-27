import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/feedback_model.dart';
import '../providers/program_provider.dart';
import '../widgets/dialogs.dart';

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _commentsController = TextEditingController();

  String _selectedProgram = '';
  int _selectedRating = 5;
  bool _isSubmitting = false;
  String _submissionMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeSelectedProgram();
  }

  void _initializeSelectedProgram() {
    final programProvider = Provider.of<ProgramProvider>(context, listen: false);
    programProvider.programs.when(
      success: (programs) {
        if (programs.isNotEmpty) {
          setState(() => _selectedProgram = programs.first.title);
        }
      },
      failure: (error) {
        showErrorDialog(context, 'Failed to load programs: $error');
      },
      loading: () {
        // Wait for programs to load
      },
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _commentsController.clear();
    setState(() => _selectedRating = 5);
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _submissionMessage = '';
    });

    try {
      final feedback = FeedbackForm(
        name: _nameController.text,
        email: _emailController.text,
        program: _selectedProgram,
        rating: _selectedRating,
        comments: _commentsController.text,
      );

      final result = await context.read<ProgramProvider>().submitFeedback(feedback);

      result.when(
        success: (success) {
          _resetForm();
          showSuccessDialog(context, 'Thank you for your feedback!');
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) Navigator.pop(context);
          });
        },
        failure: (error) {
          showErrorDialog(context, 'Failed to submit feedback: $error');
        },
        loading: () {
          // Loading state handled by button
        },
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Form'),
        backgroundColor: const Color(0xFFFFC857),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Submission message
              if (_submissionMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: _submissionMessage.contains('Thank you')
                        ? Colors.green[100]
                        : Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _submissionMessage.contains('Thank you')
                            ? Icons.check_circle
                            : Icons.error,
                        color: _submissionMessage.contains('Thank you')
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _submissionMessage,
                          style: TextStyle(
                            color: _submissionMessage.contains('Thank you')
                                ? Colors.green[800]
                                : Colors.red[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Program dropdown
              programProvider.programs.when(
                success: (programs) {
                  return DropdownButtonFormField<String>(
                    initialValue: _selectedProgram.isEmpty && programs.isNotEmpty
                        ? programs.first.title
                        : _selectedProgram,
                    decoration: const InputDecoration(
                      labelText: 'Select Program',
                      prefixIcon: Icon(Icons.menu_book),
                      border: OutlineInputBorder(),
                    ),
                    items: programs.map((program) {
                      return DropdownMenuItem<String>(
                        value: program.title,
                        child: Text(program.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProgram = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a program';
                      }
                      return null;
                    },
                  );
                },
                failure: (error) => Text('Failed to load programs: $error'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
              const SizedBox(height: 16),

              // Rating
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rating',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      final rating = index + 1;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRating = rating;
                          });
                        },
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: rating <= _selectedRating
                              ? Colors.orange
                              : Colors.grey[300],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_selectedRating out of 5 stars',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Comments
              TextFormField(
                controller: _commentsController,
                decoration: const InputDecoration(
                  labelText: 'Comments',
                  hintText: 'Tell us about your experience...',
                  prefixIcon: Icon(Icons.comment),
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your comments';
                  }
                  if (value.length < 10) {
                    return 'Please provide more detailed feedback';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC857),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSubmitting
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Submitting...'),
                          ],
                        )
                      : const Text(
                          'Submit Feedback',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentsController.dispose();
    super.dispose();
  }
}