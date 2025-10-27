// import '../models/program_model.dart';
// import '../models/feedback_form.dart';
// import '../services/api_service.dart';
// import '../utils/result.dart';

// class ProgramRepository {
//   const ProgramRepository();

//   Future<Result<List<Program>>> getPrograms() async {
//     try {
//       final programs = await ApiService.fetchPrograms();
//       return Result.success(programs);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<bool>> submitFeedback(FeedbackForm feedback) async {
//     try {
//       final success = await ApiService.submitFeedback(feedback);
//       return Result.success(success);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<bool>> registerForProgram(String programId, String userId) async {
//     try {
//       final success = await ApiService.registerForProgram(programId, userId);
//       return Result.success(success);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<void>> updateProgress(String programId, String userId, double progress) async {
//     try {
//       // If ApiService.updateProgress exists, use it
//       // Otherwise simulate it
//       await Future.delayed(const Duration(milliseconds: 500));
//       return const Result.success(null);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }
// }

// class UserRepository {
//   Future<Result<void>> login(String email, String password) async {
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       return const Result.success(null);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<void>> register(String name, String email, String password) async {
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       return const Result.success(null);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<void>> logout() async {
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       return const Result.success(null);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<void>> updateProfile({
//     String? name,
//     String? email,
//     String? profilePicture,
//   }) async {
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       return const Result.success(null);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<void>> changePassword(String currentPassword, String newPassword) async {
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       return const Result.success(null);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<void>> resetPassword(String email) async {
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       return const Result.success(null);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }
// }

// class ProgressRepository {
//   Future<Result<Map<String, double>>> getUserProgress(String userId) async {
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       return const Result.success({});
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }

//   Future<Result<void>> saveProgress(String userId, String programId, double progress) async {
//     try {
//       await Future.delayed(const Duration(milliseconds: 500));
//       return const Result.success(null);
//     } catch (e) {
//       return Result.failure(e.toString());
//     }
//   }
// }