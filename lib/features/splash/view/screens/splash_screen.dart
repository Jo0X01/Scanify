import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanify/app/app_init.dart' show AppInit;
import 'package:scanify/core/constants/app_assets.dart';
import 'package:scanify/core/enum/app_routes.dart' show AppRouteKeys;
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/features/splash/view/widgets/focus_frame_painter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = AppRouteKeys.splashRoute;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late ValueNotifier<bool?> isInitSuccess;

  @override
  void initState() {
    super.initState();
    isInitSuccess = ValueNotifier(null);
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _start();
  }

  Future<void> _start() async {
    isInitSuccess.value = await AppInit.init();
    if (isInitSuccess.value! && mounted) {
      await Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.goTo(AppRouteKeys.appRoute, replace: true);
        }
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _c,
        builder: (_, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.9,
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              CustomPaint(
                size: const Size(170, 170),
                painter: FocusFramePainter(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  backgroundColor: Colors.white.withValues(alpha: 0.05),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.9),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.70 + sin(_c.value * pi * 2) * 0.10,
                child: SvgPicture.asset(
                  AppIcons.generateIcon,
                  width: 100,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                child: ValueListenableBuilder(
                  valueListenable: isInitSuccess,
                  builder: (_, value, _) {
                    return Text(
                      value == null
                          ? context.l.initLoading
                          : value
                          ? context.l.initSuccess
                          : context.l.initError,
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    isInitSuccess.dispose();
    super.dispose();
  }
}
