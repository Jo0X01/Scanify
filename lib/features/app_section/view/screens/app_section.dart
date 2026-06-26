import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/features/app_section/controller/app_section_controller.dart';
import 'package:qrcode_scanner_app/features/app_section/data/models/app_section_screens.dart';
import 'package:qrcode_scanner_app/features/app_section/data/models/app_section_status.dart'
    show AppSectionStatus;
import 'package:qrcode_scanner_app/features/app_section/view/widgets/custom_bottom_nav_bar.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/generate_screen.dart';
import 'package:qrcode_scanner_app/features/history/view/screens/history_screen.dart';
import 'package:qrcode_scanner_app/features/scan/view/screens/scan_screen.dart';
import 'package:qrcode_scanner_app/shared/widgets/block_permission_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/loading_screen.dart';

class QRCodeScannerApp extends StatefulWidget {
  const QRCodeScannerApp({super.key});
  static const routeName = AppRoutes.appRoute;

  @override
  State<QRCodeScannerApp> createState() => _QRCodeScannerAppState();
}

class _QRCodeScannerAppState extends State<QRCodeScannerApp>
    with WidgetsBindingObserver, RouteAware {
  late final AppSectionController _sectionController;
  late final Map<AppSectionScreens, Widget> _screens;
  late final List<Widget> _screensList;

  _QRCodeScannerAppState() {
    _sectionController = AppSectionController();
    _screens = const {
      AppSectionScreens.generate: GenerateScreen(),
      AppSectionScreens.scan: ScanScreen(),
      AppSectionScreens.history: HistoryScreen(),
    };
    _screensList = _screens.values.toList();
  }

  void _onTabTap(int index) async {
    if (await _sectionController.navigateOnSelect(
          _screens.entries.elementAt(index).key,
        ) &&
        mounted) {
      await AppRoutes.navigateTo(
        context,
        AppRoutes.detailsScreen,
        arguments: _sectionController.getDetailsData(),
      );
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return ValueListenableBuilder(
      valueListenable: _sectionController.screenStatus,
      builder: (_, value, _) => switch (value) {
        AppSectionStatus.loading => LoadingScreen(),
        AppSectionStatus.cameraError => BlockPermissionCustomWidget(
          icon: Icons.camera_enhance_rounded,
          title: l.camera,
        ),
        AppSectionStatus.blockPerms => BlockPermissionCustomWidget(
          icon: Icons.new_releases_rounded,
          title: l.permissionRequired,
          buttonTitle: l.openSettings,
          subtitle:
              "${l.requireMissedPermissions}\n[ ${_sectionController.missedPermissionStr} ]",
          onTap: openAppSettings,
        ),
        AppSectionStatus.success => ValueListenableBuilder(
          valueListenable: _sectionController.activeCenterAnimation,
          builder: (context, value, child) {
            return Scaffold(
              extendBody: true,
              body: IndexedStack(
                index: _sectionController.currentScreen.index,
                children: _screensList,
              ),
              bottomNavigationBar: CustomBottomNavBar(
                currentIndex: _sectionController.currentScreen.index,
                onTap: _onTabTap,
                animationActive: value,
                centerItem: NavBarCenterItem(
                  index: AppSectionScreens.centerScreen.index,
                  iconPath: AppSectionScreens.centerScreen.icon,
                  isActive: _sectionController.isAnimationActive,
                ),
                menuItems: AppSectionScreens.sideScreens
                    .map(
                      (ele) => NavBarItem(
                        index: ele.index,
                        iconPath: ele.icon,
                        label: ele.label(l),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRoutes.registerObserver(this, context);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      await _sectionController.onAppPaused();
    } else if (state == AppLifecycleState.resumed) {
      await _sectionController.onAppResumed();
    }
  }

  @override
  void didPopNext() async => await _sectionController.onAppResumed();
  @override
  void didPushNext() async => await _sectionController.onAppPaused();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AppRoutes.unregisterObserver(this);
    _sectionController.dispose();
    super.dispose();
  }
}
