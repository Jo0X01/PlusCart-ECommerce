import 'dart:math' as math show pi;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';

class AppLoadingIndicator extends StatefulWidget {
  final Duration? duration;
  final Duration? timeout;
  final double? size;
  final double? strokeWidth;
  final double? gradientRotationAngle;
  final double? arcSweepAngle;
  final Function(BuildContext context)? onTimeoutDone;
  static bool isDialogShown = false;

  static hide(BuildContext context) {
    if (isDialogShown) {
      context.pop();
      isDialogShown = false;
    }
  }

  AppLoadingIndicator.show({
    super.key,
    required BuildContext context,
    required String text,
    this.size,
    this.duration,
    this.timeout,
    this.onTimeoutDone,
    this.strokeWidth,
    this.gradientRotationAngle,
    this.arcSweepAngle,
  }) {
    hide(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        isDialogShown = true;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                AppLoadingIndicator(
                  duration: duration,
                  timeout: timeout,
                  onTimeoutDone: onTimeoutDone,
                  size: size,
                  strokeWidth: strokeWidth,
                  gradientRotationAngle: gradientRotationAngle,
                  arcSweepAngle: arcSweepAngle,
                ),
                Flexible(child: Text(text, style: AppTextStyles.label)),
              ],
            ),
          ),
        );
      },
    );
  }

  const AppLoadingIndicator({
    super.key,
    this.size,
    this.duration,
    this.timeout,
    this.onTimeoutDone,
    this.strokeWidth,
    this.gradientRotationAngle,
    this.arcSweepAngle,
  });

  @override
  State<AppLoadingIndicator> createState() => _AppLoadingIndicatorState();
}

class _AppLoadingIndicatorState extends State<AppLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 1200),
    )..repeat();
    if (widget.timeout != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          Future.delayed(widget.timeout ?? const Duration(seconds: 3), () {
            if (mounted && widget.onTimeoutDone != null) {
              widget.onTimeoutDone!(context);
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: CustomPaint(
            size: Size(widget.size ?? 55, widget.size ?? 55),
            painter: ShadowTrailPainter(color: AppColors.divider),
          ),
        );
      },
    );
  }
}

class ShadowTrailPainter extends CustomPainter {
  final Color color;
  final double? strokeWidth;
  final double? gradientRotationAngle;
  final double? arcSweepAngle;
  ShadowTrailPainter({
    required this.color,
    this.strokeWidth,
    this.gradientRotationAngle,
    this.arcSweepAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - (strokeWidth ?? 8));
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth ?? 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          color.withValues(alpha: 0.0),
          color.withValues(alpha: 0.3),
          color.withValues(alpha: 0.7),
          color.withValues(alpha: 1.0),
          color.withValues(alpha: 1.0),
        ],
        stops: const [0.0, 0.4, 0.7, 0.9, 1.0],
        transform: GradientRotation(-math.pi / (gradientRotationAngle ?? 8)),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      (arcSweepAngle ?? 1.8) * math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
