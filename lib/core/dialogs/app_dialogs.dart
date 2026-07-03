import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:scanify/core/constants/app_assets.dart';
import 'package:scanify/core/constants/app_strings.dart';
import 'package:scanify/shared/widgets/custom_matrial_button.dart'
    show CustomMaterialButton;

abstract class AppDialogs {
  static void showNotifiyToast(BuildContext context, String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg);
  }

  static void showPicker<T>({
    required BuildContext context,
    required String title,
    required List<T> options,
    required T current,
    required ValueChanged<T>? onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.outlineVariant,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(height: 1),
          ...options.map((opt) {
            final isSelected = opt == current;
            return ListTile(
              onTap: () {
                onSelected?.call(opt);
                Navigator.pop(context);
              },
              title: Text(
                opt.toString(),
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    )
                  : null,
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  static void showConfirm(
    BuildContext context, {
    required String title,
    String? content,
    String? cancelText,
    String? confirmText,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText ?? "Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm?.call();
            },
            child: Text(
              confirmText ?? "Confirm",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  static void showSomeInfoInRowsDialog(
    BuildContext context, {
    required String title,
    required Map<String, String> rows,
    String? closeText,
    String? copyText,
    void Function(String)? onCopy,
    String? icon,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        title: Row(
          spacing: 10,
          children: [
            if (icon != null)
              SvgPicture.asset(
                icon,
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 15))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: rows.entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        e.key,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        e.value,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),

        actions: [
          if (copyText != null)
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                elevation: 0,
                onPressed: () => onCopy?.call(
                  rows.entries.map((e) => "${e.key}: ${e.value}").join('\n'),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(copyText),
              ),
            ),
          if (closeText != null)
            CustomMaterialButton(
              closeText: closeText,
              onPressed: Navigator.of(context).pop,
            ),
        ],
      ),
    );
  }

  static void showSomeInfoDialog(
    BuildContext context, {
    required String title,
    required String content,
    String? closeText,
    Widget? icon,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              ?icon,
              Text(content, style: const TextStyle(fontSize: 13, height: 1.6)),
            ],
          ),
        ),
        actions: [
          if (closeText != null)
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(closeText),
            ),
        ],
      ),
    );
  }

  static void showAdvancedInfoDialog(
    BuildContext context, {
    required String title,
    required Widget child,
    VoidCallback? onClose,
  }) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: child,
      ),
    );
  }

  static void showAbout(
    BuildContext context, {
    required String title,
    required String content,
    required String versionText,
    required String closeText,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SvgPicture.asset(AppIcons.appIcon, width: 72, height: 72),
            ),
            const SizedBox(height: 12),
            Text(
              '$versionText ${AppStrings.appVersion}',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.appTitle,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, height: 1.6),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(closeText),
          ),
        ],
      ),
    );
  }

  static void showLoading(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
              const SizedBox(width: 16),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
