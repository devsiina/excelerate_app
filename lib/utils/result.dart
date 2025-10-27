// utils/result.dart
import 'package:flutter/foundation.dart';

@immutable
class Result<T> {
  final T? data;
  final String? error;
  final bool isLoading;

  const Result({
    this.data,
    this.error,
    this.isLoading = false,
  });

  // Add these simple constructors that your repositories need
  const Result.success(T this.data)
      : error = null,
        isLoading = false;

  const Result.failure(String this.error)
      : data = null,
        isLoading = false;

  const Result.loading()
      : data = null,
        error = null,
        isLoading = true;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  R when<R>({
    required R Function(T data) success,
    required R Function(String error) failure,
    required R Function() loading,
  }) {
    if (isLoading) return loading();
    if (isFailure) return failure(error!);
    return success(data as T);
  }
}

extension FutureResult<T> on Future<T> {
  Future<Result<T>> asResult() async {
    try {
      final data = await this;
      return Result.success(data);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}