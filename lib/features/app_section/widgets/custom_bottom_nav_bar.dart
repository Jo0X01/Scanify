import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 12,
            margin: const EdgeInsets.only(left: 40, right: 40, bottom: 33),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              color: Color(0xff333333),
              borderRadius: BorderRadius.all(Radius.circular(6)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x60000000),
                  blurStyle: BlurStyle.outer,
                  // blurRadius: 8,
                  // spreadRadius: 20,
                  // offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavItem(
                  iconPath: AppIcons.generateIcon,
                  selectedIconPath: AppIcons.generateIcon,
                  label: AppStrings.generate,
                  isSelected: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
                _NavItem(
                  iconPath: AppIcons.historyIcon,
                  selectedIconPath: AppIcons.historyIcon,
                  label: AppStrings.history,
                  isSelected: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
              ],
            ),
          ),
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: DeferPointer(
              paintOnTop: true,
              child: _CenterNavItem(
                iconPath: AppIcons.scanIcon,
                onTap: () => onTap(1),
              ),
            ),
          ),
        ],
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
  });

  final String iconPath;
  final String selectedIconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.secondary : Color(0xffD9D9D9);
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // spacing: 8,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 0),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: SvgPicture.asset(
              isSelected ? selectedIconPath : iconPath,
              key: ValueKey('$isSelected-$label'),
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              fontFamily: AppStrings.fontPoppins,
            ),
            child: Text(label, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 5),
          isSelected
              ? Container(
                  width: 28,
                  height: 3,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: const BoxDecoration(color: AppColors.secondary),
                )
              : const SizedBox(height: 3),
        ],
      ),
    );
  }
}

class _CenterNavItem extends StatelessWidget {
  const _CenterNavItem({required this.iconPath, required this.onTap});

  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppColors.secondary, blurRadius: 15)],
        ),
        child: SvgPicture.asset(iconPath, width: 40, height: 40),
      ),
    );
  }
}
