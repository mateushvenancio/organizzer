import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organizzer/presenter/components/logo_component.dart';
import 'package:organizzer/resources/colors.dart';

class SplashScreen extends StatefulWidget {
  final Future<void> Function() onLoad;
  const SplashScreen({super.key, required this.onLoad});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await widget.onLoad();
    if (mounted) {
      context.go('/main');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoComponent(size: 200),
            Text(
              'Organizzer',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
