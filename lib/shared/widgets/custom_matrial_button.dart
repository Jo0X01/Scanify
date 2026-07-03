import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.closeText,
    required this.onPressed,
    this.width,
    this.color,
  });

  final double? width;
  final String closeText;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: MaterialButton(
        elevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: color ?? Theme.of(context).colorScheme.primary,
        child: Text(closeText),
      ),
    );
  }
}
