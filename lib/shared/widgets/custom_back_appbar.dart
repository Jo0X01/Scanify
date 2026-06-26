import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';

class CustomAppbarMenuAction {
  final String? icon;
  final IconData? iconData;
  final String title;
  final VoidCallback onTap;
  CustomAppbarMenuAction({
    this.icon,
    this.iconData,
    required this.title,
    required this.onTap,
  });
}

class CustomBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomBackAppBar({
    super.key,
    this.title,
    this.hasBack = true,
    this.justGoBack = true,
    this.addSettings = false,
    this.kbHeight = 80,
    this.onBackPressed,
    this.menuItems,
    this.menuTooltip,
  });

  final String? title;
  final bool hasBack;
  final bool addSettings;
  final bool justGoBack;
  final double kbHeight;
  final VoidCallback? onBackPressed;
  final List<CustomAppbarMenuAction>? menuItems;
  final String? menuTooltip;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double iconSize = screenWidth < 360 ? 20 : 25;
    final double backButtonSize = screenWidth < 360 ? 32 : 35;

    final textScaler = MediaQuery.textScalerOf(context);
    final double fontSize = textScaler.scale(
      MediaQuery.of(context).size.width < 360 ? 16 : 18,
    );

    return AppBar(
      toolbarHeight: kbHeight,
      leadingWidth: screenWidth * 0.12,
      leading: !hasBack
          ? null
          : GestureDetector(
              onTap: () {
                onBackPressed?.call();
                if (justGoBack) {
                  AppRoutes.goBack(context);
                }
              },
              child: SizedBox(
                width: backButtonSize,
                height: backButtonSize,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(
                    horizontal: backButtonSize * 0.30,
                    vertical: backButtonSize * 0.20,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.backIcon,
                      matchTextDirection: true,
                      width: iconSize - 20,
                      height: iconSize - 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      forceMaterialTransparency: true,
      title: title == null
          ? null
          : Text(
              title!,
              style: TextStyle(fontSize: fontSize),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 10),
      actions: [
        if (addSettings)
          GestureDetector(
            onTap: () => AppRoutes.navigateToSettings(context),
            child: SvgPicture.asset(
              AppIcons.settingsIcon,
              width: iconSize,
              height: iconSize,
            ),
          ),
        if (menuItems != null && menuItems!.isNotEmpty)
          PopupMenuButton<int>(
            tooltip: menuTooltip,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            menuPadding: EdgeInsets.zero,
            iconSize: 30,
            iconColor: Theme.of(context).colorScheme.primary,
            itemBuilder: (BuildContext context) {
              return menuItems!
                  .map(
                    (ele) => PopupMenuItem<int>(
                      onTap: ele.onTap,
                      child: ListTile(
                        leading: _buildIcon(
                          ele.icon,
                          ele.iconData,
                          iconSize,
                          Theme.of(context).colorScheme.primary,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        visualDensity: VisualDensity.compact,
                        minLeadingWidth: 8,
                        title: Text(
                          ele.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  )
                  .toList();
            },
          ),
      ],
    );
  }

  Widget? _buildIcon(
    String? icon,
    IconData? iconData,
    double iconSize,
    Color color,
  ) {
    if (icon != null) {
      return SvgPicture.asset(
        icon,
        width: iconSize - 5,
        height: iconSize - 5,
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }
    if (iconData != null) {
      return Icon(iconData, size: iconSize, color: color);
    }
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(kbHeight);
}
