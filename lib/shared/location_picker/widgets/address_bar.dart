import 'package:flutter/material.dart';

/// Displays the reverse-geocoded address in a pill at the bottom of the map.
///
/// Hidden when [address] is null.
class AddressBar extends StatelessWidget {
  const AddressBar({super.key, required this.address});

  final String? address;

  @override
  Widget build(BuildContext context) {
    if (address == null) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 6,
          children: [
            Icon(Icons.location_on, size: 16, color: colorScheme.primary),
            Flexible(
              child: Text(
                address!,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colorScheme.onSurface),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
