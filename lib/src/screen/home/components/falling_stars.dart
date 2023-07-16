import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FallingStars extends StatefulWidget {
  @override
  _FallingStarsState createState() => _FallingStarsState();
}

class _FallingStarsState extends State<FallingStars> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Star> _stars = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..repeat();

    for (int i = 0; i < 1; i++) {
      _stars.add(Star(
        //  oldPosition: Offset(0, 500),
        // position: Offset(0, 500),
        oldPosition: Offset.zero,
        position: Offset.zero,

        size: 0,
        paint: Paint(),
        angle: 0,
      ));
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
      builder: (BuildContext context, Widget? child) {
        for (var star in _stars) {
          star.move(MediaQuery.of(context).size);
        }
        return CustomPaint(
          painter: StarPainter(stars: _stars),
        );
      },
    );
  }
}

/*
class Star {
  Offset position;
  Offset oldPosition; // New variable to store the previous position
  double size;
  Paint paint;
  double angle;

  Star({required this.position, required this.oldPosition, required this.size, required this.paint, required this.angle});

  void move(Size screenSize) {
    oldPosition = position;
    position = Offset(
      position.dx + size * cos(angle),
      position.dy + size * sin(angle),
    );

    if (position.dx < 0 || position.dx > screenSize.width || position.dy < 0 || position.dy > screenSize.height) {
      // Reset the star to a new position when it falls off screen
      reset(screenSize);
    }
  }

  void reset(Size screenSize) {
    position = Offset(
      Random().nextDouble() * screenSize.width,
      0.0, // Start from the top of the screen
    );
    oldPosition = position;
    size = Random().nextDouble() * 2 + 5;
    paint = Paint()..color = Colors.white.withAlpha(255 - (size.toInt() * 50));

    // Set angle between 75 and 105 degrees (converted to radians)
    angle = (75 + Random().nextInt(60)) * pi / 180;
  }
}

class StarPainter extends CustomPainter {
  final List<Star> stars;

  StarPainter({required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      canvas.drawLine(star.oldPosition, star.position, star.paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
*/
class Particle {
  Offset position;
  double opacity;
  Paint paint;

  Particle({required this.position, required this.opacity, required this.paint});

  void update() {
    opacity -= 0.03;
    if (opacity < 0) opacity = 0;
  }
}

class Star {
  Offset position;
  Offset oldPosition;
  double size;
  Paint paint;
  double angle;
  List<Particle> particles = [];

  Star({required this.position, required this.oldPosition, required this.size, required this.paint, required this.angle});

  void move(Size screenSize) {
    oldPosition = position;
    position = Offset(
      position.dx + size + 5 * cos(angle),
      position.dy + size + 1 * sin(angle),
    );

    // Create a new particle each time the star moves
    particles.add(Particle(position: position, opacity: 1, paint: Paint()..color = Colors.white));

    // Update all particles and remove any that are no longer visible
    particles.forEach((particle) => particle.update());
    particles.removeWhere((particle) => particle.opacity <= 0);

    if (position.dx < 0 || position.dx > screenSize.width || position.dy < 0 || position.dy > screenSize.height) {
      // Reset the star to a new position when it falls off screen
      reset(screenSize);
    }
  }

  void reset(Size screenSize) {
    position = Offset(
      Random().nextDouble() * screenSize.width,
      Random().nextDouble() * screenSize.height, // Start from the top of the screen
    );
    oldPosition = position;
    size = Random().nextDouble() * 0.09 + 0.4;
    paint = Paint()..color = Colors.white.withAlpha(255 - (size.toInt() * 10));

    // Set angle between 75 and 105 degrees (converted to radians)
    angle = (75 + Random().nextInt(30)) * pi / 180;
  }
}

class StarPainter extends CustomPainter {
  final List<Star> stars;

  StarPainter({required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      // Draw the particles
      for (var particle in star.particles) {
        canvas.drawCircle(particle.position, star.size, particle.paint..color = particle.paint.color.withOpacity(particle.opacity));
      }

      // Draw the star
      canvas.drawLine(star.oldPosition, star.position, star.paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
