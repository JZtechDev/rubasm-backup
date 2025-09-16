import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ruba_sm/config/theme/color_palette.dart';

class CustomProgressButton extends StatelessWidget {
  final double progress;
  final Duration duration;
  final VoidCallback? ontap;

  const CustomProgressButton({
    super.key,
    required this.progress,
    this.ontap,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress),
        duration: duration,
        builder: (context, value, child) {
          return SizedBox(
            width: 80,
            height: 80,
            child: CustomPaint(
              painter: _CircularProgressPainter(
                progress: value,
                strokeWidth: 5,
                backgroundColor: Colors.white,
                progressColor: Palette.primaryBrown,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/images/Arrow 2.svg',
                  width: 31,
                  height: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - (strokeWidth / 20);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    paint.color = backgroundColor;
    canvas.drawCircle(center, radius, paint);

    paint.color = progressColor;
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
