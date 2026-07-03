import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CenterNavItemCustomWidget extends StatefulWidget {
  const CenterNavItemCustomWidget({
    super.key,
    required this.iconPath,
    required this.onTap,
    required this.size,
    required this.isSelected,
    required this.isActive,
  });

  final String iconPath;
  final VoidCallback onTap;
  final double size;
  final bool isActive;
  final bool isSelected;

  @override
  State<CenterNavItemCustomWidget> createState() =>
      _CenterNavItemCustomWidgetState();
}

class _CenterNavItemCustomWidgetState extends State<CenterNavItemCustomWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    if (widget.isActive) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant CenterNavItemCustomWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildWave(double delay,Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final value = (_controller.value + delay) % 1;

        return Transform.scale(
          scale: 1 + (value * 0.8),
          child: Opacity(
            opacity: (1 - value).clamp(0.0, 1.0),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.25),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = widget.size * 0.54;
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.isActive) ...[
              buildWave(0.0,primaryColor),
              buildWave(0.3,primaryColor),
              buildWave(0.6,primaryColor),
            ],
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.size,
              height: widget.size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(
                      alpha: widget.isSelected ? 0.55 : 0.30,
                    ),
                    blurRadius: widget.isSelected ? 20 : 10,
                    spreadRadius: widget.isSelected ? 2 : 0,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                widget.iconPath,
                width: iconSize,
                height: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
