import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/features/app_section/view/widgets/bottom_nav_item_custom_widget.dart';
import 'package:qrcode_scanner_app/features/app_section/view/widgets/center_nav_item_custom_widget.dart';

const double _kNavBarMinHeight = 60.0;
const double _kNavBarMaxHeight = 80.0;
const double _kCenterBtnMin = 60.0;
const double _kCenterBtnMax = 80.0;

class NavBarItem {
  final String iconPath;
  final String label;
  final int index;
  final VoidCallback? onTap;

  const NavBarItem({
    required this.iconPath,
    required this.label,
    required this.index,
    this.onTap,
  });
}

class NavBarCenterItem {
  final String iconPath;
  final bool isActive;
  final VoidCallback? onTap;
  final int index;

  const NavBarCenterItem({
    required this.iconPath,
    required this.index,
    this.isActive = false,
    this.onTap,
  });
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.menuItems,
    required this.centerItem,
    required this.animationActive,
  });

  final int currentIndex;
  final bool animationActive;
  final void Function(int) onTap;
  final List<NavBarItem> menuItems;
  final NavBarCenterItem centerItem;

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

    final theme = Theme.of(context);
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
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border(
                    top: BorderSide(color: theme.primaryColor, width: 2),
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
                    for (var i = 0; i < menuItems.length; i++) ...[
                      Expanded(
                        child: BottomNavItemCustomWidget(
                          iconPath: menuItems[i].iconPath,
                          label: menuItems[i].label,
                          isSelected: currentIndex == menuItems[i].index,
                          navBarHeight: navBarHeight,
                          onTap: () {
                            onTap(menuItems[i].index);
                            menuItems[i].onTap?.call();
                          },
                        ),
                      ),
                      if (i == (menuItems.length / 2).floor() - 1)
                        SizedBox(width: btnSize + 16),
                    ],
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: navBarHeight + bottomPadding - halfBtn,
              child: DeferPointer(
                paintOnTop: true,
                child: CenterNavItemCustomWidget(
                  iconPath: centerItem.iconPath,
                  size: btnSize,
                  isSelected: currentIndex == centerItem.index,
                  isActive: centerItem.isActive,
                  onTap: () {
                    onTap(centerItem.index);
                    centerItem.onTap?.call();
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
