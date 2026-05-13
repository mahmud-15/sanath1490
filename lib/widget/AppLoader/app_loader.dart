import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ─────────────────────────────────────────────────────
// AppLoader — 5 property themed loaders in one widget
//
// Usage:
//   AppLoader(type: LoaderType.accentHouseCycle)
//   AppLoader(type: LoaderType.urbanPulse, message: 'Loading...')
//   AppLoader.show()   — full screen overlay
//   AppLoader.hide()   — dismiss overlay
// ─────────────────────────────────────────────────────

enum LoaderType {
  accentHouseCycle,   // Loader 1 — spinning arc around house
  urbanPulse,         // Loader 2 — city buildings with blinking windows
  pinwheelMapMarkers, // Loader 3 — rotating map markers
  geometricFlow,      // Loader 4 — infinity hexagon flow
  residentialPulse,   // Loader 5 — house with dual arc pulse
}

class AppLoader extends StatelessWidget {
  final LoaderType type;
  final String? message;
  final double size;

  const AppLoader({
    super.key,
    this.type = LoaderType.accentHouseCycle,
    this.message,
    this.size = 60,
  });

  // ─── Show full screen overlay loader ──────────────
  static void show({
    LoaderType type = LoaderType.accentHouseCycle,
    String? message,
  }) {
    if (navigatorKey.currentContext == null) return;
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha(80),
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: AppLoader(type: type, message: message, size: 100),
        ),
      ),
    );
  }

  // ─── Hide overlay loader ───────────────────────────
  static void hide() {
    if (navigatorKey.currentContext != null) {
      Navigator.of(navigatorKey.currentContext!, rootNavigator: true)
          .pop();
    }
  }

  // ─── Navigator key — add to GetMaterialApp ────────
  // GetMaterialApp(navigatorKey: AppLoader.navigatorKey, ...)
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size.w,
          height: size.w,
          child: _buildLoader(),
        ),
        if (message != null) ...[
          SizedBox(height: 12.h),
          Text(
            message!,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF0B3C6D),
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLoader() {
    switch (type) {
      case LoaderType.accentHouseCycle:
        return const _AccentHouseCycle();
      case LoaderType.urbanPulse:
        return const _UrbanPulse();
      case LoaderType.pinwheelMapMarkers:
        return const _PinwheelMapMarkers();
      case LoaderType.geometricFlow:
        return const _GeometricFlow();
      case LoaderType.residentialPulse:
        return const _ResidentialPulse();
    }
  }
}

// ─────────────────────────────────────────────────────
// LOADER 1 — Accent House Cycle
// Spinning teal arc around a dark house icon
// ─────────────────────────────────────────────────────
class _AccentHouseCycle extends StatefulWidget {
  const _AccentHouseCycle();

  @override
  State<_AccentHouseCycle> createState() => _AccentHouseCycleState();
}

class _AccentHouseCycleState extends State<_AccentHouseCycle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
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
      builder: (_, _) => CustomPaint(
        painter: _AccentArcPainter(progress: _controller.value),
        child: Center(child: _HouseIcon(size: 24, color: const Color(0xFF0B3C6D))),
      ),
    );
  }
}

class _AccentArcPainter extends CustomPainter {
  final double progress;

  _AccentArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    // ─── Background circle ────────────────────────
    final bgPaint = Paint()
      ..color = const Color(0xFF0B3C6D).withAlpha(20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawCircle(center, radius, bgPaint);

    // ─── Spinning teal arc ────────────────────────
    final arcPaint = Paint()
      ..shader = SweepGradient(
        colors: const [Color(0xFF14B8A6), Color(0xFF0B3C6D)],
        startAngle: 0,
        endAngle: pi * 2,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + (progress * pi * 2),
      pi * 1.2,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(_AccentArcPainter old) => old.progress != progress;
}

// ─────────────────────────────────────────────────────
// LOADER 2 — Urban Pulse
// City skyline with blinking teal windows
// ─────────────────────────────────────────────────────
class _UrbanPulse extends StatefulWidget {
  const _UrbanPulse();

  @override
  State<_UrbanPulse> createState() => _UrbanPulseState();
}

class _UrbanPulseState extends State<_UrbanPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, _) => CustomPaint(
        painter: _CityPainter(pulse: _anim.value),
      ),
    );
  }
}

class _CityPainter extends CustomPainter {
  final double pulse;

  _CityPainter({required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final darkBlue = const Color(0xFF031D4B);
    final teal     = Color.lerp(const Color(0xFF14B8A6), Colors.white, pulse * 0.4)!;
    final w = size.width;
    final h = size.height;

    final buildingPaint = Paint()..color = darkBlue..style = PaintingStyle.fill;
    final windowPaint   = Paint()..color = teal..style = PaintingStyle.fill;

    // ─── Buildings ────────────────────────────────
    final buildings = [
      Rect.fromLTWH(w * 0.05, h * 0.35, w * 0.14, h * 0.55),
      Rect.fromLTWH(w * 0.21, h * 0.20, w * 0.16, h * 0.70),
      Rect.fromLTWH(w * 0.39, h * 0.10, w * 0.22, h * 0.80),
      Rect.fromLTWH(w * 0.63, h * 0.25, w * 0.16, h * 0.65),
      Rect.fromLTWH(w * 0.81, h * 0.40, w * 0.14, h * 0.50),
    ];

    for (final b in buildings) {
      canvas.drawRect(b, buildingPaint);
    }

    // ─── Ground line ──────────────────────────────
    canvas.drawRect(Rect.fromLTWH(0, h * 0.90, w, h * 0.05), buildingPaint);

    // ─── Windows (blink with pulse) ───────────────
    final windowRects = [
      Rect.fromLTWH(w * 0.07, h * 0.42, w * 0.04, h * 0.06),
      Rect.fromLTWH(w * 0.07, h * 0.54, w * 0.04, h * 0.06),
      Rect.fromLTWH(w * 0.24, h * 0.28, w * 0.05, h * 0.07),
      Rect.fromLTWH(w * 0.24, h * 0.42, w * 0.05, h * 0.07),
      Rect.fromLTWH(w * 0.42, h * 0.18, w * 0.06, h * 0.08),
      Rect.fromLTWH(w * 0.52, h * 0.18, w * 0.06, h * 0.08),
      Rect.fromLTWH(w * 0.42, h * 0.34, w * 0.06, h * 0.08),
      Rect.fromLTWH(w * 0.52, h * 0.34, w * 0.06, h * 0.08),
      Rect.fromLTWH(w * 0.65, h * 0.32, w * 0.05, h * 0.07),
      Rect.fromLTWH(w * 0.65, h * 0.46, w * 0.05, h * 0.07),
      Rect.fromLTWH(w * 0.83, h * 0.48, w * 0.04, h * 0.06),
    ];

    for (int i = 0; i < windowRects.length; i++) {
      final opacity = ((pulse + i * 0.15) % 1.0);
      canvas.drawRect(
        windowRects[i],
        Paint()..color = teal.withAlpha((opacity * 255).toInt()),
      );
    }
  }

  @override
  bool shouldRepaint(_CityPainter old) => old.pulse != pulse;
}

// ─────────────────────────────────────────────────────
// LOADER 3 — Pinwheel Map Markers
// 3 map markers rotating in a circle
// ─────────────────────────────────────────────────────
class _PinwheelMapMarkers extends StatefulWidget {
  const _PinwheelMapMarkers();

  @override
  State<_PinwheelMapMarkers> createState() => _PinwheelMapMarkersState();
}

class _PinwheelMapMarkersState extends State<_PinwheelMapMarkers>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
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
      builder: (_, __) {
        return CustomPaint(
          painter: _PinwheelPainter(angle: _controller.value * 2 * pi),
        );
      },
    );
  }
}

class _PinwheelPainter extends CustomPainter {
  final double angle;

  _PinwheelPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.32;

    // ─── Arc trail ────────────────────────────────
    final arcPaint = Paint()
      ..color = const Color(0xFF14B8A6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      angle,
      pi * 1.5,
      false,
      arcPaint,
    );

    // ─── 3 map markers at different positions ─────
    final markerData = [
      (angle,             const Color(0xFF0B3C6D), 16.0),
      (angle + pi * 0.7,  const Color(0xFF14B8A6), 12.0),
      (angle + pi * 1.4,  const Color(0xFF031D4B), 10.0),
    ];

    for (final (a, color, markerSize) in markerData) {
      final pos = Offset(
        center.dx + cos(a) * radius,
        center.dy + sin(a) * radius,
      );
      _drawMapMarker(canvas, pos, color, markerSize);
    }
  }

  void _drawMapMarker(Canvas canvas, Offset pos, Color color, double size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;

    // ─── Circle top ───────────────────────────────
    canvas.drawCircle(Offset(pos.dx, pos.dy - size * 0.2), size * 0.55, paint);

    // ─── Triangle bottom ──────────────────────────
    final path = Path()
      ..moveTo(pos.dx - size * 0.4, pos.dy - size * 0.2)
      ..lineTo(pos.dx + size * 0.4, pos.dy - size * 0.2)
      ..lineTo(pos.dx, pos.dy + size * 0.6)
      ..close();
    canvas.drawPath(path, paint);

    // ─── Inner dot ────────────────────────────────
    canvas.drawCircle(
      Offset(pos.dx, pos.dy - size * 0.2),
      size * 0.2,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_PinwheelPainter old) => old.angle != angle;
}

// ─────────────────────────────────────────────────────
// LOADER 4 — Geometric Flow
// Hexagonal shapes flowing in infinity/oval pattern
// ─────────────────────────────────────────────────────
class _GeometricFlow extends StatefulWidget {
  const _GeometricFlow();

  @override
  State<_GeometricFlow> createState() => _GeometricFlowState();
}

class _GeometricFlowState extends State<_GeometricFlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
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
      builder: (_, __) => CustomPaint(
        painter: _GeometricFlowPainter(progress: _controller.value),
      ),
    );
  }
}

class _GeometricFlowPainter extends CustomPainter {
  final double progress;
  static const int _count = 12;

  _GeometricFlowPainter({required this.progress});

  // ─── Lemniscate (infinity) path position ──────────
  Offset _infinityPoint(double t, Offset center, double a, double b) {
    final angle = t * 2 * pi;
    final scale = 1 / (1 + pow(sin(angle), 2));
    return Offset(
      center.dx + a * cos(angle) * scale,
      center.dy + b * sin(angle) * cos(angle) * scale,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final a = size.width * 0.38;
    final b = size.height * 0.28;

    for (int i = 0; i < _count; i++) {
      final t = (i / _count + progress) % 1.0;
      final pos = _infinityPoint(t, center, a, b);

      // ─── Color gradient along path ───────────────
      final colorT = i / _count;
      final color = Color.lerp(
        const Color(0xFF0B3C6D),
        const Color(0xFF14B8A6),
        colorT,
      )!;

      // ─── Size pulse ───────────────────────────────
      final hexSize = 7.0 + (i == 0 ? 4.0 : 0.0);

      _drawHexagon(canvas, pos, hexSize, color);
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double size, Color color) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i - pi / 6;
      final x = center.dx + size * cos(angle);
      final y = center.dy + size * sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(_GeometricFlowPainter old) => old.progress != progress;
}

// ─────────────────────────────────────────────────────
// LOADER 5 — Residential Pulse
// House in circle with dual rotating arcs + glow
// ─────────────────────────────────────────────────────
class _ResidentialPulse extends StatefulWidget {
  const _ResidentialPulse();

  @override
  State<_ResidentialPulse> createState() => _ResidentialPulseState();
}

class _ResidentialPulseState extends State<_ResidentialPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
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
      builder: (_, __) => CustomPaint(
        painter: _ResidentialPulsePainter(progress: _controller.value),
        child: Center(
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF14B8A6).withAlpha(
                    (sin(_controller.value * pi) * 80 + 40).toInt(),
                  ),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Center(
              child: _HouseIcon(size: 26, color: Color(0xFF0B3C6D)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResidentialPulsePainter extends CustomPainter {
  final double progress;

  _ResidentialPulsePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // ─── Outer glow ring ──────────────────────────
    final glowPaint = Paint()
      ..color = const Color(0xFF14B8A6).withAlpha(30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawCircle(center, size.width / 2 - 6, glowPaint);

    // ─── Arc 1 — forward ──────────────────────────
    final arc1 = Paint()
      ..color = const Color(0xFF14B8A6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2 - 8),
      -pi / 2 + (progress * pi * 2),
      pi * 0.7,
      false,
      arc1,
    );

    // ─── Arc 2 — reverse ──────────────────────────
    final arc2 = Paint()
      ..color = const Color(0xFF0B3C6D).withAlpha(160)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2 - 8),
      pi / 2 - (progress * pi * 2),
      pi * 0.5,
      false,
      arc2,
    );
  }

  @override
  bool shouldRepaint(_ResidentialPulsePainter old) => old.progress != progress;
}

// ─────────────────────────────────────────────────────
// Shared house icon painter
// ─────────────────────────────────────────────────────
class _HouseIcon extends StatelessWidget {
  final double size;
  final Color color;

  const _HouseIcon({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HouseIconPainter(color: color),
    );
  }
}

class _HouseIconPainter extends CustomPainter {
  final Color color;

  _HouseIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // ─── Roof ─────────────────────────────────────
    final roof = Path()
      ..moveTo(w * 0.1, h * 0.52)
      ..lineTo(w * 0.5, h * 0.08)
      ..lineTo(w * 0.9, h * 0.52);
    canvas.drawPath(roof, paint);

    // ─── Walls ────────────────────────────────────
    final walls = Path()
      ..moveTo(w * 0.18, h * 0.48)
      ..lineTo(w * 0.18, h * 0.92)
      ..lineTo(w * 0.82, h * 0.92)
      ..lineTo(w * 0.82, h * 0.48);
    canvas.drawPath(walls, paint);

    // ─── Door ─────────────────────────────────────
    final door = Path()
      ..moveTo(w * 0.40, h * 0.92)
      ..lineTo(w * 0.40, h * 0.68)
      ..quadraticBezierTo(w * 0.50, h * 0.60, w * 0.60, h * 0.68)
      ..lineTo(w * 0.60, h * 0.92);
    canvas.drawPath(door, paint);
  }

  @override
  bool shouldRepaint(_HouseIconPainter old) => old.color != color;
}