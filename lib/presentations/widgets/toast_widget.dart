import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/presentations/routes.dart';

class Toast {
  static showError(String error) {
    _showMessage(error, MessageT.error);
  }

  static showSuccess(String message) {
    _showMessage(message, MessageT.success);
  }

  static showWarning(String message) {
    _showMessage(message, MessageT.warning);
  }

  static showInfo(String message) {
    _showMessage(message, MessageT.info);
  }

  static _showMessage(String message, MessageT type) {
    final context = AppNavigator.context;
    final theme = context.read<AppCubit>().state.theme;
    AppNavigator.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            type.icon,
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: AppTextStyle.s14w400.copyWith(color: theme.colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: theme.colors.alertBackground,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

enum MessageT {
  error,
  success,
  warning,
  info;

  String get type {
    switch (this) {
      case error:
        return 'error';
      case success:
        return 'success';
      case warning:
        return 'warning';
      case info:
        return 'info';
    }
  }

  Widget get icon {
    switch (this) {
      case error:
        return const Icon(Icons.error_outline, color: Colors.red);
      case success:
        return const Icon(Icons.done, color: Colors.green);
      case warning:
        return const Icon(Icons.warning, color: Colors.yellow);
      case info:
        return const Icon(Icons.info, color: Colors.blue);
    }
  }
}
