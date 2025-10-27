import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/program_model.dart';
import '../models/feedback_model.dart';
import '../utils/result.dart';
import '../constants/app_constants.dart';

class ApiService {
  static const Duration apiDelay = Duration(milliseconds: 1500);

  static Future<Result<List<Program>>> fetchPrograms() async {
    try {
      await Future.delayed(apiDelay);
      final String response = await rootBundle.loadString('assets/data/programs.json');
      final data = await json.decode(response) as Map<String, dynamic>;
      
      final programsList = data['programs'] as List;
      final programs = programsList
          .map((programJson) => Program.fromJson(programJson as Map<String, dynamic>))
          .toList();
      
      return Result.success(programs);
    } catch (e) {
      return Result.failure(
        e is Exception ? e.toString() : AppConstants.generalError,
      );
    }
  }

  static Future<Result<bool>> submitFeedback(FeedbackForm feedback) async {
    try {
      await Future.delayed(apiDelay);
      // Here we would normally send the feedback to a backend server
      print('Feedback submitted: ${feedback.toJson()}');
      return const Result.success(true);
    } catch (e) {
      return Result.failure(
        e is Exception ? e.toString() : AppConstants.generalError,
      );
    }
  }

  static Future<Result<bool>> registerForProgram(String programId, String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      // Here we would normally send the registration to a backend server
      print('User $userId registered for program $programId');
      return const Result.success(true);
    } catch (e) {
      return Result.failure(
        e is Exception ? e.toString() : AppConstants.generalError,
      );
    }
  }
  
  static Future<Result<void>> updateProgress(String programId, String userId, double progress) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // Here we would normally send the progress update to a backend server
      print('Updated progress for program $programId: $progress%');
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        e is Exception ? e.toString() : AppConstants.generalError,
      );
    }
  }
}