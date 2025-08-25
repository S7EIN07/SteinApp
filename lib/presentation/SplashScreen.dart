import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rive/rive.dart';
import 'package:stein_aplication/presentation/TelaLogin.dart';
import 'package:stein_aplication/presentation/TelaCadastro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showButtons = false;
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
      debugPrint("Reproduzindo animação: $nextAnimationName");

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
      debugPrint("Sequência de animações completa! Exibindo botões...");
      setState(() {
        _showButtons = true;
      });
    }
  }

  void _removeButtons() {
    setState(() {
      _showButtons = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFC107),
      body: Column(
        children: [
          Center(
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
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation);

              return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: _showButtons
                ? Column(
                    key: const ValueKey('buttons'),
                    children: [
                      _buildCustomButton(
                        text: 'Já tenho uma conta',
                        icon: Icons.login,
                        onTap: () {
                          _removeButtons();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaLogin(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildCustomButton(
                        text: 'Criar uma conta',
                        icon: Icons.person_3,
                        onTap: () {
                          _removeButtons();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaCadastro(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                    ],
                  )
                : const SizedBox(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 400,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1000),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFFFC107), size: 50),
              const SizedBox(width: 20),
              Text(
                text,
                style: const TextStyle(color: Color(0xFFFFC107), fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
