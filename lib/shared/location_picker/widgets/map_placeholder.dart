import 'package:flutter/material.dart';

/// Shown instead of the map when there is no location to display
/// (e.g. permission denied, service disabled, GPS error).
class MapPlaceholder extends StatelessWidget {
  const MapPlaceholder({
    super.key,
    this.icon = Icons.location_disabled,
    this.message,
  });

  final IconData icon;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Icon(icon, size: 60, color: colorScheme.onSurfaceVariant),
          Text(
            message ?? 'Location unavailable',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 1
                ),
              
            softWrap: true,
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
