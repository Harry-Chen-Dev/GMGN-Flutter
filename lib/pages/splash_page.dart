import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  Future<void> _checkAuthStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // 延迟以显示启动画面
    await Future.delayed(const Duration(seconds: 2));

    await authProvider.checkAuthStatus();

    if (mounted) {
      if (authProvider.isAuthenticated) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.backgroundDark,
              AppTheme.primaryDark,
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GMGN.AI Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryGreen,
                      Color(0xFF00B894),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.auto_graph,
                  size: 60,
                  color: Colors.black,
                ),
              )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .scale(delay: 200.ms, duration: 600.ms)
                  .shimmer(delay: 800.ms, duration: 1200.ms),

              const SizedBox(height: 32),

              // App Title
              Text(
                'GMGN.AI',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 800.ms)
                  .slideY(begin: 0.3, delay: 600.ms, duration: 800.ms),

              const SizedBox(height: 8),

              Text(
                '智能复制交易助手',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              )
                  .animate()
                  .fadeIn(delay: 1000.ms, duration: 800.ms)
                  .slideY(begin: 0.3, delay: 1000.ms, duration: 800.ms),

              const SizedBox(height: 64),

              // Loading Animation
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                  strokeWidth: 3,
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(duration: 1000.ms),

              const SizedBox(height: 16),

              Text(
                '正在加载...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textTertiary,
                    ),
              ).animate().fadeIn(delay: 1400.ms, duration: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}
