import 'package:flutter/material.dart';
import '../theme/zarvix_theme.dart';

class QuoteIlluminatedPainter extends CustomPainter {
  final bool isBookmarked;

  QuoteIlluminatedPainter({required this.isBookmarked});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Outer card perimeter
    final cardRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(18),
    );
    final cardPaint = Paint()
      ..color = ZarvixTheme.surface
      ..style = PaintingStyle.fill;
    canvas.drawRRect(cardRRect, cardPaint);

    final borderPaint = Paint()
      ..color = ZarvixTheme.edge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(cardRRect, borderPaint);

    // Decorative illuminated corner brackets
    const bracketSize = 22.0;
    final bracketPaint = Paint()
      ..color = ZarvixTheme.accent.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Top-Left corner
    canvas.drawLine(const Offset(12, 12), const Offset(12 + bracketSize, 12), bracketPaint);
    canvas.drawLine(const Offset(12, 12), const Offset(12, 12 + bracketSize), bracketPaint);

    // Bottom-Right corner
    canvas.drawLine(Offset(w - 12, h - 12), Offset(w - 12 - bracketSize, h - 12), bracketPaint);
    canvas.drawLine(Offset(w - 12, h - 12), Offset(w - 12, h - 12 - bracketSize), bracketPaint);

    // Watermark giant quotation glyph in the background
    final watermarkPaint = Paint()
      ..color = ZarvixTheme.accent.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w * 0.25, h * 0.35), 24.0, watermarkPaint);
    canvas.drawCircle(Offset(w * 0.38, h * 0.35), 24.0, watermarkPaint);
  }

  @override
  bool shouldRepaint(covariant QuoteIlluminatedPainter oldDelegate) {
    return oldDelegate.isBookmarked != isBookmarked;
  }
}
