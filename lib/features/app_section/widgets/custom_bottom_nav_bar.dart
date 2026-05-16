import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';

const double _kNavBarMinHeight = 60.0;
const double _kNavBarMaxHeight = 90.0;
const double _kCenterBtnMin = 58.0;
const double _kCenterBtnMax = 76.0;

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterTapped,
  });

  final int currentIndex;
  final Function(int) onTap;
  final Function() onCenterTapped;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenW = mq.size.width;
    final bottomPadding = mq.padding.bottom;

    final navBarHeight =
        (_kNavBarMinHeight +
                (screenW - 320) /
                    (428 - 320) *
                    (_kNavBarMaxHeight - _kNavBarMinHeight))
            .clamp(_kNavBarMinHeight, _kNavBarMaxHeight);

    final btnSize =
        (_kCenterBtnMin +
                (screenW - 320) /
                    (428 - 320) *
                    (_kCenterBtnMax - _kCenterBtnMin))
            .clamp(_kCenterBtnMin, _kCenterBtnMax);

    final halfBtn = btnSize / 2;

    final totalHeight = navBarHeight + halfBtn + bottomPadding;

    return DeferredPointerHandler(
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: navBarHeight + bottomPadding,
                padding: EdgeInsets.only(
                  left: screenW * 0.07,
                  right: screenW * 0.07,
                  bottom: bottomPadding,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.tabBackground,
                  border: Border(
                    top: BorderSide(color: AppColors.toggleActive, width: 2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x60000000),
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _NavItem(
                        iconPath: AppIcons.generateIcon,
                        selectedIconPath: AppIcons.generateIcon,
                        label: AppStrings.generate,
                        isSelected: currentIndex == 0,
                        onTap: () => onTap(0),
                        navBarHeight: navBarHeight,
                      ),
                    ),
                    SizedBox(width: btnSize + 16),
                    Expanded(
                      child: _NavItem(
                        iconPath: AppIcons.historyIcon,
                        selectedIconPath: AppIcons.historyIcon,
                        label: AppStrings.history,
                        isSelected: currentIndex == 2,
                        onTap: () => onTap(2),
                        navBarHeight: navBarHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              // Sits so its bottom edge is flush with the top of the bar
              bottom: navBarHeight + bottomPadding - halfBtn,
              child: DeferPointer(
                paintOnTop: true,
                child: _CenterNavItem(
                  iconPath: AppIcons.scanIcon,
                  size: btnSize,
                  isSelected: currentIndex == 1,
                  onTap: () {
                    onTap(1);
                    onCenterTapped();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.iconPath,
    required this.selectedIconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.navBarHeight,
  });

  final String iconPath;
  final String selectedIconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double navBarHeight;

  @override
  Widget build(BuildContext context) {
    final iconSize = (navBarHeight * 0.38).clamp(22.0, 32.0);
    final fontSize = (navBarHeight * 0.15).clamp(10.0, 13.0);

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        height: navBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: SvgPicture.asset(
                isSelected ? selectedIconPath : iconPath,
                key: ValueKey('$isSelected-$label'),
                width: iconSize,
                height: iconSize,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.primary : AppColors.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: navBarHeight * 0.04),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.iconColor,
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontFamily: AppStrings.fontPoppins,
              ),
              child: Text(label, textAlign: TextAlign.center),
            ),
            SizedBox(height: navBarHeight * 0.05),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? iconSize - 2 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterNavItem extends StatelessWidget {
  const _CenterNavItem({
    required this.iconPath,
    required this.onTap,
    required this.size,
    required this.isSelected,
  });

  final String iconPath;
  final VoidCallback onTap;
  final double size;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final iconSize = size * 0.54;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(isSelected ? 0.55 : 0.30),
              blurRadius: isSelected ? 20 : 10,
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
        ),
        child: SvgPicture.asset(iconPath, width: iconSize, height: iconSize),
      ),
    );
  }
}
