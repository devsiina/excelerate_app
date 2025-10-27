import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/program_model.dart';
import '../utils/result.dart';
import '../models/feedback_model.dart';

class ProgramProvider with ChangeNotifier {
  Result<List<Program>> _programs = const Result.loading();
  Result<List<Program>> get programs => _programs;

  Result<List<Program>> searchPrograms(String query) {
    return _programs.when(
      success: (programs) {
        if (query.isEmpty) return Result.success(programs);
        final lowercaseQuery = query.toLowerCase();
        final filtered = programs.where((program) =>
          program.title.toLowerCase().contains(lowercaseQuery) ||
          program.description.toLowerCase().contains(lowercaseQuery) ||
          program.instructor.toLowerCase().contains(lowercaseQuery) ||
          program.level.toLowerCase().contains(lowercaseQuery)
        ).toList();
        return Result.success(filtered);
      },
      failure: (error) => Result.failure(error),
      loading: () => const Result.loading(),
    );
  }

  Result<List<Program>> getProgramsByLevel(String level) {
    return _programs.when(
      success: (programs) {
        if (level == 'All') return Result.success(programs);
        final filtered = programs.where((program) => 
          program.level == level
        ).toList();
        return Result.success(filtered);
      },
      failure: (error) => Result.failure(error),
      loading: () => const Result.loading(),
    );
  }

  Result<List<Program>> get programsWithProgress {
    return _programs.when(
      success: (programs) {
        final filtered = programs.where((program) => 
          program.progress > 0
        ).toList();
        return Result.success(filtered);
      },
      failure: (error) => Result.failure(error),
      loading: () => const Result.loading(),
    );
  }

  Future<void> fetchPrograms() async {
    _programs = const Result.loading();
    notifyListeners();

    _programs = await ApiService.fetchPrograms();
    notifyListeners();
  }

  Future<Result<void>> updateProgress(String programId, double progress) async {
    return _programs.when(
      success: (programs) async {
        final index = programs.indexWhere((p) => p.id == programId);
        if (index == -1) return const Result.failure('Program not found');

        try {
          // Create a new list to ensure state change is detected
          final updatedPrograms = List<Program>.from(programs);
          updatedPrograms[index] = programs[index].copyWith(progress: progress);
          
          _programs = Result.success(updatedPrograms);
          notifyListeners();
          return const Result.success(null);
        } catch (e) {
          return Result.failure('Error updating progress: ${e.toString()}');
        }
      },
      failure: (error) => Result.failure(error),
      loading: () => const Result.failure('Cannot update progress while loading programs'),
    );
  }

  Future<Result<void>> enrollInProgram(String programId) async {
    const String userId = 'demo_user'; // In a real app, userId would come from an auth provider
    
    final result = await ApiService.registerForProgram(programId, userId);
    return result.when(
      success: (_) async {
        // Set minimal progress to indicate enrollment
        return updateProgress(programId, 0.01);
      },
      failure: (error) => Result.failure(error),
      loading: () => const Result.failure('Unexpected loading state'),
    );
  }

  Future<Result<void>> submitFeedback(FeedbackForm feedback) async {
    try {
      final result = await ApiService.submitFeedback(feedback);
      return result.when(
        success: (_) => const Result.success(null),
        failure: (error) => Result.failure(error),
        loading: () => const Result.failure('Unexpected loading state'),
      );
    } catch (e) {
      return Result.failure(e.toString());
    }
  }


}