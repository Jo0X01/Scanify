import 'package:flutter/material.dart';

class BlockPermissionCustomWidget extends StatelessWidget {
  const BlockPermissionCustomWidget({
    super.key,
    required this.icon,
    required this.title,
    this.buttonTitle,
    this.subtitle,
    this.onTap,
    this.showButton = true,
  });

  final IconData icon;
  final String title;
  final bool showButton;
  final String? subtitle;
  final String? buttonTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 72, color: Colors.grey),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              if (showButton) ..._showButton(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _showButton() {
    return [
      const SizedBox(height: 12),
      Text(
        subtitle ?? "",
        style: const TextStyle(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 32),
      ElevatedButton(onPressed: onTap, child: Text(buttonTitle ?? "")),
    ];
  }
}
