import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/result.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppDimens.marginM),
          Text(
            'Loading...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.marginL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppDimens.iconL,
              color: AppColors.errorColor,
            ),
            const SizedBox(height: AppDimens.marginM),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimens.marginL),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String message;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyState({
    super.key,
    required this.message,
    this.icon,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.marginL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: AppDimens.iconL * 2,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ),
            const SizedBox(height: AppDimens.marginL),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: AppDimens.marginL),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ResultBuilder<T> extends StatelessWidget {
  final Result<T> result;
  final Widget Function(T data) onSuccess;
  final Widget Function(String error)? onError;
  final Widget Function()? onLoading;
  
  const ResultBuilder({
    super.key,
    required this.result,
    required this.onSuccess,
    this.onError,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return result.when(
      success: onSuccess,
      failure: (error) => onError?.call(error) ?? ErrorState(message: error),
      loading: () => onLoading?.call() ?? const LoadingState(),
    );
  }
}

class SafeArea extends StatelessWidget {
  final Widget child;
  final bool maintainBottomViewPadding;

  const SafeArea({
    super.key,
    required this.child,
    this.maintainBottomViewPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        maintainBottomViewPadding: maintainBottomViewPadding,
        child: child,
      ),
    );
  }
}