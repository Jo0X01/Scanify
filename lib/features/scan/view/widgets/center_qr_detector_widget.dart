import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/features/scan/view/widgets/custom_painter_box_widget.dart';

class CenterQrDetectorAnimationWidget extends StatefulWidget {
  const CenterQrDetectorAnimationWidget({
    super.key,
    required this.scanSize,
    required this.detected,
    this.onPulseComplete,
    this.barcodeCorners,
    this.scannerWidgetSize,
    this.cameraResolution,
  });

  final double scanSize;
  final bool detected;
  final VoidCallback? onPulseComplete;
  final List<List<Offset>>? barcodeCorners;
  final Size? scannerWidgetSize;
  final Size? cameraResolution;

  @override
  State<CenterQrDetectorAnimationWidget> createState() =>
      _CenterQrDetectorAnimationWidgetState();
}

class _CenterQrDetectorAnimationWidgetState
    extends State<CenterQrDetectorAnimationWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _scanLineController;
  late final AnimationController _pulseController;
  late final Animation<double> _scanLineAnimation;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initAnimations();
  }

  @override
  void didUpdateWidget(CenterQrDetectorAnimationWidget old) {
    super.didUpdateWidget(old);
    if (widget.detected && !old.detected) {
      triggerPulse();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _scanLineController.repeat(reverse: true);
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _scanLineController.stop();
    }
  }

  void triggerPulse() => _pulseController.forward(from: 0);

  void _onPulseComplete(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    widget.onPulseComplete?.call();
  }

  void _initAnimations() {
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scanLineAnimation = Tween<double>(begin: 0.05, end: 0.95).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addStatusListener(_onPulseComplete);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_scanLineAnimation, _pulseAnimation]),
        builder: (_, _) => Transform.scale(
          scale: _pulseAnimation.value,
          child: SizedBox(
            width: widget.scanSize,
            height: widget.scanSize,
            child: CustomPaint(
              painter: CustomPainterBoxWidget(
                detected: widget.detected,
                scanLinePosition: _scanLineAnimation.value,
                allBarcodeCorners: widget.barcodeCorners,
                cameraResolution: widget.cameraResolution,
                scannerWidgetSize: context.mq.size,
                color: context.colorTheme.primary,
                detectedColor: widget.detected
                    ? context.colorTheme.primary
                    : context.colorTheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pulseController.removeStatusListener(_onPulseComplete);
    _scanLineController.dispose();
    _pulseController.dispose();
    super.dispose();
  }
}
