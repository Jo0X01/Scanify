import 'package:flutter/material.dart';

import '../constants/map_constants.dart';
import '../models/location_picker_result.dart';
import '../widgets/location_picker_map_widget.dart';

/// A modal dialog that wraps [LocationPickerMapWidget].
///
/// Prefer the static [LocationPickerDialog.show] factory over constructing
/// this directly.
///
/// ```dart
/// final result = await LocationPickerDialog.show(
///   context,
///   initialValue: LocationPickerResult(),
///   onApply: (r) => setState(() => _location = r),
/// );
/// ```
class LocationPickerDialog extends StatefulWidget {
  const LocationPickerDialog({
    super.key,
    required this.initialValue,
    required this.onApply,
    this.title = MapConstants.defaultDialogTitle,
    this.confirmText = MapConstants.defaultConfirmText,
    this.readOnly = false,
    this.autoLoadIfEmpty = true,
    this.loadingText,
    this.searchText,
    this.errorMsg,
    this.showSearch,
    this.showLocationBtn,
  });

  // ---------------------------------------------------------------------------
  // Static factory
  // ---------------------------------------------------------------------------

  /// Shows the dialog and returns a [Future] that completes when it closes.
  ///
  /// [onApply] is called (before the dialog closes) only when the user taps
  /// Confirm with a non-empty location selected.
  static Future<void> show(
    BuildContext context, {
    required LocationPickerResult initialValue,
    required void Function(LocationPickerResult) onApply,
    String title = MapConstants.defaultDialogTitle,
    String confirmText = MapConstants.defaultConfirmText,
    bool readOnly = false,
    bool autoLoadIfEmpty = true,
    String? loadingText,
    String? searchText,
    bool? showSearch,
    bool? showLocationBtn,
    String? errorMsg,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => LocationPickerDialog(
        initialValue: initialValue,
        onApply: onApply,
        title: title,
        errorMsg: errorMsg,
        loadingText: loadingText,
        searchText: searchText,
        showLocationBtn: showLocationBtn,
        showSearch: showSearch,
        confirmText: confirmText,
        readOnly: readOnly,
        autoLoadIfEmpty: autoLoadIfEmpty,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Props
  // ---------------------------------------------------------------------------

  final LocationPickerResult initialValue;
  final void Function(LocationPickerResult) onApply;
  final String title;
  final String confirmText;
  final String? loadingText;
  final String? searchText;
  final String? errorMsg;

  final bool? showSearch;
  final bool? showLocationBtn;

  final bool readOnly;
  final bool autoLoadIfEmpty;

  @override
  State<LocationPickerDialog> createState() => _LocationPickerDialogState();
}

class _LocationPickerDialogState extends State<LocationPickerDialog> {
  /// Tracks the latest selection so Confirm always has an up-to-date value.
  late LocationPickerResult _selectedResult;

  @override
  void initState() {
    super.initState();
    _selectedResult = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, theme, colorScheme),
            Expanded(
              child: LocationPickerMapWidget(
                initialValue: _selectedResult,
                autoLoadIfEmpty: widget.autoLoadIfEmpty,
                readOnly: widget.readOnly,
                dialogTitle: widget.title,
                confirmText: widget.confirmText,
                loadingText: widget.loadingText,
                searchHint: widget.searchText,
                showSearchBar: widget.showSearch,
                showLocationBtn: widget.showLocationBtn,
                errorMsg: widget.errorMsg,
                onLoad: (result) => _selectedResult = result,
                onSelectPosition: (result) => _selectedResult = result,
              ),
            ),
            _buildConfirmBar(colorScheme),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Private builders
  // ---------------------------------------------------------------------------

  Widget _buildHeader(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 12,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: colorScheme.primaryContainer),
                ),
                child: Icon(
                  Icons.location_on,
                  color: colorScheme.primary,
                  size: 18,
                ),
              ),
              Text(
                widget.title,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: colorScheme.onSurfaceVariant,
              size: 20,
            ),
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerHighest,
              padding: const EdgeInsets.all(6),
              minimumSize: const Size(32, 32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmBar(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: FilledButton.icon(
        onPressed: _onConfirm,
        icon: const Icon(Icons.check_rounded, size: 18),
        label: Text(widget.confirmText),
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _onConfirm() {
    if (_selectedResult.isLocationEmpty) return;
    widget.onApply(_selectedResult);
    Navigator.of(context).pop();
  }
}
