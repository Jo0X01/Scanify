import 'package:flutter/material.dart';

/// Semi-transparent overlay shown when map tiles fail to load.
///
/// Absorbs pointer events so the user cannot interact with a broken map.
class TileErrorOverlay extends StatelessWidget {
  const TileErrorOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        color: Colors.white.withValues(alpha: 0.85),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Icon(Icons.wifi_off, size: 40),
              Text('No internet connection'),
            ],
          ),
        ),
      ),
    );
  }
}
