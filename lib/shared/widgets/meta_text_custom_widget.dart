import 'package:flutter/material.dart';

enum MetaTextMode { metadata, filter, tap }

class MetaTextCustomWidget extends StatefulWidget {
  const MetaTextCustomWidget({
    super.key,
    required this.label,
    this.mode = MetaTextMode.metadata,
    this.fontSize,
    this.radius,
    this.initialToggle = false,
    this.onToggle,
    this.leadingIcon,
    this.isDestructive = false,
  });

  final bool isDestructive;
  final IconData? leadingIcon;
  final String label;
  final MetaTextMode mode;
  final double? fontSize;
  final double? radius;
  final bool initialToggle;
  final void Function(bool)? onToggle;

  @override
  State<MetaTextCustomWidget> createState() => _MetaTextCustomWidgetState();
}

class _MetaTextCustomWidgetState extends State<MetaTextCustomWidget> {
  late bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialToggle;
  }

  void _handleTap() {
    if (widget.mode == MetaTextMode.metadata) return;
    setState(() => _selected = !_selected);
    widget.onToggle?.call(_selected);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    final color = widget.isDestructive
        ? themeColor.error
        : themeColor.primary;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: switch (widget.mode) {
            MetaTextMode.metadata ||
            MetaTextMode.tap => color.withValues(alpha: 0.12),
            MetaTextMode.filter =>
              _selected
                  ? color.withValues(alpha: 0.85)
                  : color.withValues(alpha: 0.12),
          },
          borderRadius: BorderRadius.circular(widget.radius ?? 6),
          border:
              widget.mode == MetaTextMode.filter ||
                  widget.mode == MetaTextMode.tap
              ? Border.all(
                  color: _selected ? color : color.withValues(alpha: 0.30),
                  width: 1,
                )
              : null
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: widget.leadingIcon != null ? 4 : 0,
          children: [
            widget.leadingIcon != null
                ? Icon(
                    widget.leadingIcon!,
                    color: color,
                    size: widget.fontSize,
                  )
                : const SizedBox.shrink(),
            Text(
              widget.label.toUpperCase(),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: switch (widget.mode) {
                  MetaTextMode.metadata || MetaTextMode.tap => color,
                  MetaTextMode.filter => _selected ? Colors.white : color,
                },
                fontWeight: FontWeight.w700,
                fontSize: widget.fontSize,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
