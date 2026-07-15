import 'dart:math' as math show pi;

import 'package:flutter/material.dart';
import 'package:plus_cart/core/theme/app_colors.dart';

class AppLoadingIndicator extends StatefulWidget {
  final Duration? duration;
  final Duration? timeout;
  final Function(BuildContext context)? onTimeoutDone;

  const AppLoadingIndicator({
    super.key,
    this.duration,
    this.timeout,
    this.onTimeoutDone,
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
            size: const Size(55, 55),
            painter: ShadowTrailPainter(color: AppColors.divider),
          ),
        );
      },
    );
  }
}

class ShadowTrailPainter extends CustomPainter {
  final Color color;

  ShadowTrailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 8;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth);
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
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
        transform: const GradientRotation(-math.pi / 8),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      1.8 * math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
