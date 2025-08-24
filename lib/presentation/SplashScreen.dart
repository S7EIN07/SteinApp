import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rive/rive.dart';
import 'TelaLogin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RiveAnimationController? _controller;

  final List<String> _animationSequence = [
    'OpenEye',
    'MoveDown',
    'MoveRight',
    'MoveLeft',
    'MoveCenter',
  ];

  int _currentAnimationIndex = 0;

  @override
  void initState() {
    super.initState();

    _playNextAnimation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _playNextAnimation() {
    if (_currentAnimationIndex < _animationSequence.length) {
      final nextAnimationName = _animationSequence[_currentAnimationIndex];
      print("Reproduzindo animação: $nextAnimationName");

      final nextAnimation = SimpleAnimation(nextAnimationName);

      nextAnimation.isActiveChanged.addListener(() {
        if (!nextAnimation.isActive) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _currentAnimationIndex++;
            _playNextAnimation();
          });
        }
      });

      _controller?.dispose();
      _controller = nextAnimation;

      setState(() {});
    } else {
      debugPrint("Sequência de animações completa! Navegando...");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: RiveAnimation.asset(
            'assets/animations/EyeSplash.riv',
            controllers: [_controller!],
            fit: BoxFit.contain,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFC107),
    );
  }
}
