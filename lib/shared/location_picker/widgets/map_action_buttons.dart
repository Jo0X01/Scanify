import 'package:flutter/material.dart';

/// The two FABs that float over the top-right corner of the map.
///
/// - "My location" → fetches & pans to device GPS position.
/// - "Go to pin" → pans to the currently selected marker.
class MapActionButtons extends StatelessWidget {
  const MapActionButtons({
    super.key,
    required this.onBringMeHere,
    required this.onGoToPin,
    required this.onZoomIn,
    required this.onZoomOut,
    this.swapPositions = false,
  });

  final VoidCallback onBringMeHere;
  final VoidCallback onGoToPin;
  final VoidCallback onZoomOut;
  final VoidCallback onZoomIn;
  final bool swapPositions;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 4,
            children: [
              MapFab(icon: Icons.my_location, onPressed: onBringMeHere),
              MapFab(icon: Icons.near_me, onPressed: onGoToPin),
            ],
          ),
          Column(
            spacing: 4,
            children: [
              MapFab(icon: Icons.zoom_in, onPressed: onZoomIn),
              MapFab(icon: Icons.zoom_out, onPressed: onZoomOut),
            ],
          ),
        ],
      ),
    );
  }
}

class MapFab extends StatelessWidget {
  const MapFab({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: onPressed,
      splashColor: Colors.transparent,
      child: Icon(icon),
    );
  }
}
