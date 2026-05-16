import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:toastification/toastification.dart';

abstract class AppToast {
  static void showToast({
    required BuildContext context,
    required String title,
    required String description,
    required ToastificationType type,
  }) {
    toastification.show(
      context: context,
      type: type,
      title: Text(title, style: Theme.of(context).textTheme.labelLarge),
      description: Text(
        description,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      primaryColor: AppColors.surface,
      autoCloseDuration: const Duration(seconds: 3),
      progressBarTheme: ProgressIndicatorThemeData(
        color: type == ToastificationType.success
            ? Colors.green
            : type == ToastificationType.info
            ? Colors.blue
            : type == ToastificationType.warning
            ? Colors.orange
            : Colors.red,
      ),
      showProgressBar: true,
      backgroundColor: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.info
          ? Colors.blue
          : type == ToastificationType.warning
          ? Colors.orange
          : Colors.red,
      foregroundColor: AppColors.surface,
    );
  }

  static void error(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showToast(
      context: context,
      title: title,
      description: description,
      type: ToastificationType.error,
    );
  }

  static void success(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showToast(
      context: context,
      title: title,
      description: description,
      type: ToastificationType.success,
    );
  }

  static void warn(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showToast(
      context: context,
      title: title,
      description: description,
      type: ToastificationType.warning,
    );
  }

  static void info(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showToast(
      context: context,
      title: title,
      description: description,
      type: ToastificationType.info,
    );
  }
}
