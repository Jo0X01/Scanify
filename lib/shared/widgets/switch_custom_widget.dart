import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';

class SwitchCustomWidget extends StatefulWidget {
  const SwitchCustomWidget({
    super.key,
    this.value = false,
    this.onChanged,
    this.disabled = false,
    this.size = 26,
    this.activeColor,
    this.inactiveColor,
  });

  final bool value;
  final bool disabled;
  final void Function(bool)? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;

  @override
  State<SwitchCustomWidget> createState() => _SwitchCustomWidgetState();
}

class _SwitchCustomWidgetState extends State<SwitchCustomWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _thumbAnimation;
  late final Animation<double> _scaleAnimation;

  double get _trackHeight => widget.size;
  double get _trackWidth => widget.size * 1.77;
  double get _thumbSize => widget.size * 0.77;
  double get _thumbPadding => widget.size * 0.115;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: widget.value ? 1.0 : 0.0,
    );

    _thumbAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
            reverseCurve: Curves.easeInOut,
          ),
        );
  }

  @override
  void didUpdateWidget(SwitchCustomWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.disabled) return;
    final newValue = !widget.value;
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.activeColor ?? AppColors.primary;
    final inactiveColor =
        widget.inactiveColor ?? AppColors.textSecondary.withValues(alpha: 0.25);

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, _) {
          final trackColor = Color.lerp(
            inactiveColor,
            activeColor,
            _thumbAnimation.value,
          )!;
          final thumbLeft =
              _thumbPadding +
              (_thumbAnimation.value *
                  (_trackWidth - _thumbSize - _thumbPadding * 2));

          return SizedBox(
            width: _trackWidth,
            height: _trackHeight,
            child: Stack(
              children: [
                Container(
                  width: _trackWidth,
                  height: _trackHeight,
                  decoration: BoxDecoration(
                    color: trackColor,
                    borderRadius: BorderRadius.circular(_trackHeight / 2),
                    boxShadow: [
                      BoxShadow(
                        color: activeColor.withValues(
                          alpha: 0.3 * _thumbAnimation.value,
                        ),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),

                // thumb
                Positioned(
                  left: thumbLeft,
                  top: _thumbPadding,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: _thumbSize,
                      height: _thumbSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedOpacity(
                          opacity: _thumbAnimation.value,
                          duration: const Duration(milliseconds: 150),
                          child: Icon(
                            Icons.check_rounded,
                            size: _thumbSize * 0.55,
                            color: activeColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
