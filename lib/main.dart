// ignore: unused_import
import 'dart:math';
import 'dart:math' as math;
import 'dart:ui' as ui;


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
       debugShowCheckedModeBanner: false,
      title: "My Universe, My Love",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A001A),
        dialogTheme: const DialogTheme(
          backgroundColor: Color(0xFF1E0028),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
      ),

      home: const SplashScreen(),
      
    );
  }
}


// === 🎬 Intro Splash Screen (12 seconds) ===
// === 🎬 Beautiful 12-Second Splash Screen ===
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Single controller for all animations
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Start animation immediately
    _controller.forward();

    // Navigate after 12 seconds
    Future.delayed(const Duration(seconds: 12), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, animation, __) {
              return FadeTransition(
                opacity: animation,
                child: const LoveGalaxyPage(),
              );
            },
            transitionDuration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0020),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 💓 Floating Heart
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final scale = 0.5 + _controller.value * 0.5; // 0.5 → 1.0
                final opacity = _controller.value > 0.2 ? (_controller.value - 0.2) * 1.25 : 0.0;
                return Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pink.shade200,
                      size: 100,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            // "For My Love,"
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final opacity = _controller.value > 0.4 ? (_controller.value - 0.4) * 1.6 : 0.0;
                final translateY = 50 * (1 - opacity.clamp(0.0, 1.0));
                return Opacity(
                  opacity: opacity,
                  child: Transform.translate(
                    offset: Offset(0, translateY),
                    child: Text(
                      "For My Love,",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.pink.shade100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // "Liv-Victoria"
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final opacity = _controller.value > 0.6 ? (_controller.value - 0.6) * 2.5 : 0.0;
                return Opacity(
                  opacity: opacity,
                  child: Text(
                    "Liv-Victoria",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = ui.Gradient.linear(
                          const Offset(0, 0),
                          const Offset(250, 0),
                          [Colors.pink.shade100, Colors.purple.shade200],
                        ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            // "This universe was made for you."
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final opacity = _controller.value > 0.8 ? (_controller.value - 0.8) * 5.0 : 0.0;
                return Opacity(
                  opacity: opacity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                    "This universe was made for you.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "╰(*°▽°*)╯ ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                    ],
                  )
                );
              },
            ),

            const SizedBox(height: 60),

            // Pulsing Loading Indicator
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final pulse = 0.8 + 0.2 * math.sin(_controller.value * math.pi * 2);
                return Opacity(
                  opacity: 0.7,
                  child: Transform.scale(
                    scale: pulse,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
            Opacity(
              opacity: 0.6,
              child: Text(
                "Preparing your universe...",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// === 🌌 Main Galaxy Page ===
class LoveGalaxyPage extends StatefulWidget {
  const LoveGalaxyPage({super.key});

  @override
  State<LoveGalaxyPage> createState() => _LoveGalaxyPageState();
}

class _LoveGalaxyPageState extends State<LoveGalaxyPage>
    with TickerProviderStateMixin {
  late final AnimationController _orbitController;
  late final AnimationController _introController;
  late final AnimationController _starTwinkleController;

  Offset _cursorPos = const Offset(0, 0);
  final List<Particle> _particles = [];

  final List<Planet> _planets = [
Planet("That Day in the Park", Colors.pink.shade200, "You, looking way too cute for me to focus… me, trying to play it cool while my heart tripped over itself. 🌸😏"),
Planet("Hands That Fit", Colors.orange.shade300, "From that first walk, I couldn’t stop holding your hand… pretty sure it’s been glued to mine ever since. 🤝🔥"),
Planet("Sweet Discovery", Colors.yellow.shade300, "Every time we talked, I found another reason to think, ‘Damn… how did I get this lucky?’ 🏡😍"),
Planet("Closer Than Close", Colors.blue.shade200, "Weeks turned into months and suddenly… being away from you felt like trying to breathe without air. 🌌🫂"),
Planet("My Safe Place", Colors.teal.shade200, "Your hugs? Pure magic. Every time you hold me, the world just… melts away. 🌙💌"),
Planet("Wildfire Love", Colors.deepPurple.shade200, "This thing between us it’s fire, passion, and a little chaos… but it’s my favorite kind of beautiful madness. 🔥❤️‍🔥"),
Planet("Our Forever", Colors.indigo.shade200, "I picture us years from now, still stealing kisses on park benches, still laughing like it’s day one. 🕊️💍"),
Planet("Infinity and Beyond", Colors.grey.shade300, "Even if stars fall and time forgets us… my love for you will just keep spinning, endlessly yours. ♾️🌟"),


    // Removed middle planet (was "Future")
  ];

  @override
  void initState() {
    super.initState();

    _orbitController = AnimationController(
      duration: const Duration(seconds: 20), // Slower orbit
      vsync: this,
    )..repeat();

    _introController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _starTwinkleController = AnimationController(
      duration: const Duration(seconds: 8), // Slower twinkling
      vsync: this,
    )..repeat();

    _introController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
    });

    // Start stardust trail
    _startParticleTrail();
  }

  void _startParticleTrail() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        _updateParticles();
        _startParticleTrail();
      }
    });
  }

  void _updateParticles() {
    final random = math.Random();
    _particles.add(Particle(
      x: _cursorPos.dx + random.nextDouble() * 14 - 7,
      y: _cursorPos.dy + random.nextDouble() * 14 - 7,
      vx: random.nextDouble() * 0.8 - 0.4,
      vy: random.nextDouble() * 0.8 - 0.4,
      life: 1.0,
      color: Colors.pink.withOpacity(0.5),
    ));

    _particles.removeWhere((p) {
      p.x += p.vx;
      p.y += p.vy;
      p.vy += 0.02;
      p.life -= 0.01;
      return p.life <= 0;
    });

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _introController.dispose();
    _starTwinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerMove: (event) {
          final renderBox = context.findRenderObject() as RenderBox;
          setState(() {
            _cursorPos = renderBox.globalToLocal(event.position);
          });
        },
        child: Stack(
          children: [
            // === ✨ Slow Twinkling Stars ===
            LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: StarrySkyPainter(_starTwinkleController.value),
                );
              },
            ),

            // === ✨ Stardust Trail ===
            ..._particles.map((p) {
              return Positioned(
                left: p.x - 5,
                top: p.y - 5,
                child: Opacity(
                  opacity: p.life,
                  child: Icon(
                    Icons.star,
                    color: p.color,
                    size: p.life * 12,
                  ),
                ),
              );
            }),

            // === 🌠 "My Universe: Liv-Victoria" ===
            AnimatedBuilder(
              animation: _introController,
              builder: (context, child) {
                return Opacity(
                  opacity: _introController.value,
                  child: Transform.translate(
                    offset: Offset(0, 50 * (1 - _introController.value)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                        "Orbiting You, Liv",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = ui.Gradient.linear(
                              const Offset(0, 0),
                              const Offset(400, 0),
                              [Colors.pink.shade100, Colors.purple.shade200],
                            ),
                        ),
                      ),
                          Text(
                        "Every heartbeat, every star, always you.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          foreground: Paint()
                            ..shader = ui.Gradient.linear(
                              const Offset(0, 0),
                              const Offset(400, 0),
                              [Colors.pink.shade100, const ui.Color.fromARGB(255, 96, 95, 96)],
                            ),
                        ),
                      ),
                        ],
                      )
                    ),
                  ),
                );
              },
            ),

            // === 🪐 8 Orbiting Planets (No Middle One) ===
            Center(
              child: SizedBox(
                width: 360,
                height: 360,
                child: AnimatedBuilder(
                  animation: _orbitController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _orbitController.value * math.pi * 2,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 💖 Soft Heart Glow (Center)
                          

                          // 🌍 8 Planets
                          ..._planets.asMap().entries.map((entry) {
                            final index = entry.key;
                            final planet = entry.value;
                            final angle = index * (math.pi * 2 / 8);
                            final radius = 130.0;
                            final x = radius * math.cos(angle);
                            final y = radius * math.sin(angle);

                            return Positioned(
                              left: 180 + x - 20,
                              top: 180 + y - 20,
                              child: ScaleTransition(
                                scale: Tween<double>(begin: 0.6, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: _introController,
                                    curve: Interval(
                                      0.5 + index * 0.05, // Max: 0.5 + 7*0.05 = 0.85 → safe
                                      1.0,
                                      curve: Curves.elasticOut,
                                    ),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () => _showMemoryModal(context, planet),
                                  child: _cutePlanet(planet.color),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // === 💖 Floating Poetry Button ===
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.1).animate(
                    CurvedAnimation(
                      parent: _introController,
                      curve: const Interval(0.8, 1.0, curve: Curves.elasticOut),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => _showPoetryModal(context),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
                      ),
                      child: const Icon(Icons.favorite, color: Colors.white, size: 30),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cutePlanet(Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.7),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
      ),
    );
  }

  void _showMemoryModal(BuildContext context, Planet planet) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) => AlertDialog(
        title: Text(planet.name, style: TextStyle(color: planet.color, fontSize: 22)),
        content: Text(planet.story, style: const TextStyle(color: Colors.white70, height: 1.6)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Back to Stars"),
          ),
        ],
        scrollable: true,
      ),
      transitionBuilder: (ctx, a1, a2, child) => Transform.scale(
        scale: a1.value,
        child: Opacity(opacity: a1.value, child: child),
      ),
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  void _showPoetryModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) => AlertDialog(
        title: const Text(
          "Words from My Heart",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
  _poem(
    "You Are My Gravity",
    "You don’t just pull me like the moon tugs the tides…\n"
    "You are the gravity I surrendered to,\n"
    "Every orbit, every lifetime,\n"
    "forever anchored by your smile. 🌌❤️",
  ),
  const SizedBox(height: 20),
  _poem(
    "Invisible Strings",
    "No wires, no whispers, yet my heart\n"
    "finds yours across every distance…\n"
    "like constellations tracing paths\n"
    "only our souls can see. ✨🫂",
  ),
  const SizedBox(height: 20),
  _poem(
    "Forever Isn’t Long Enough",
    "Give me a thousand dawns,\n"
    "and I’ll still wake up aching\n"
    "to kiss you first, to love you more,\n"
    "to call you my whole universe. ☀️💌",
  ),
],

          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Back to You"),
          ),
        ],
        scrollable: true,
      ),
      transitionBuilder: (ctx, a1, a2, child) => FadeTransition(
        opacity: a1,
        child: ScaleTransition(scale: a1, child: child),
      ),
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  Widget _poem(String title, String lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        const SizedBox(height: 8),
        Text(lines, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white70, height: 1.6)),
      ],
    );
  }
}

// ✨ Stardust Particle
class Particle {
  double x, y, vx, vy, life;
  Color color;

  Particle({required this.x, required this.y, required this.vx, required this.vy, required this.color, required this.life});
}

// 🌌 Starry Sky (Slower Twinkling)
class StarrySkyPainter extends CustomPainter {
  final double twinkle;

  StarrySkyPainter(this.twinkle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random();

    for (int i = 0; i < 130; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final baseOpacity = 0.3 + random.nextDouble() * 0.6;
      final radius = 1 + random.nextDouble() * 1.5;

      final flicker = 0.7 + 0.3 * math.sin(twinkle * math.pi + i * 0.3); // Slower
      final opacity = baseOpacity * flicker;

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, paint);

      if (random.nextDouble() > 0.94) {
        paint.color = Colors.yellow.withOpacity(opacity * 0.6);
        canvas.drawCircle(Offset(x, y), radius + 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 🪐 Planet Model
class Planet {
  final String name;
  final Color color;
  final String story;

  Planet(this.name, this.color, this.story);
}