import 'package:flutter/material.dart';
import 'package:scanify/core/constants/app_assets.dart' show AppIcons;
import 'package:scanify/core/dialogs/app_dialogs.dart';
import 'package:scanify/core/enum/app_routes.dart' show AppRouteKeys;
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/managers/scanner_manager.dart';
import 'package:scanify/core/services/route_service.dart';
import 'package:scanify/core/services/settings_service.dart';
import 'package:scanify/features/app_section/widgets/custom_bottom_nav_bar.dart';
import 'package:scanify/features/generate/view/screens/generate_screen.dart';
import 'package:scanify/features/history/view/screens/history_screen.dart';
import 'package:scanify/features/scan/view/screens/scan_screen.dart';

class AppSectionScreen extends StatefulWidget {
  const AppSectionScreen({super.key});
  static const routeName = AppRouteKeys.appRoute;

  @override
  State<AppSectionScreen> createState() => _AppSectionScreenState();
}

class _AppSectionScreenState extends State<AppSectionScreen> with RouteAware {
  final _settings = SettingsService.instance;

  final _scanStateKey = GlobalKey<ScanScreenState>();

  late final List<Widget> screens;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    screens = [
      GenerateScreen(),
      ScanScreen(key: _scanStateKey),
      HistoryScreen(),
    ];
  }

  void _onTabTap(int index) async {
    if (index == 1 && _currentIndex == index) {
      _scanStateKey.currentState?.goToDetails();
      return;
    }
    if (index == 2) {
      if (!_settings.enableHistory) {
        AppDialogs.showNotifiyToast(context, context.l.historyDisabled);
        if (_currentIndex == 2) {
          _onTabTap(1);
        }
        return;
      }
    }
    setState(() {
      _currentIndex = index;
      _updateChildLifecycle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: ScannerManager.instance.detectListener,
        builder: (context, value, child) {
          return CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onTabTap,
            animationActive: value,
            centerItem: NavBarCenterItem(
              index: 1,
              iconPath: AppIcons.scanIcon,
              isActive: value,
            ),
            menuItems: [
              NavBarItem(
                index: 0,
                iconPath: AppIcons.generateIcon,
                label: context.l.generate,
              ),
              NavBarItem(
                index: 2,
                iconPath: AppIcons.historyIcon,
                label: context.l.history,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteService.registerObserver(this, context);
  }

  @override
  void didPopNext() {
    if (_currentIndex == 1) _scanStateKey.currentState?.didPopNext();
    if (_currentIndex == 2) _onTabTap(2);
  }

  @override
  void didPushNext() {
    if (_currentIndex == 1) _scanStateKey.currentState?.didPushNext();
  }

  void _updateChildLifecycle() {
    if (_currentIndex == 1) {
      _scanStateKey.currentState?.didPopNext();
    } else {
      _scanStateKey.currentState?.didPushNext();
    }
  }

  @override
  void dispose() {
    RouteService.unregisterObserver(this);
    super.dispose();
  }
}
