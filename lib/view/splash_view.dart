import 'package:app_genesis/view/view_services/splash_view_services.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _splashServices = SplashViewServices();
  @override
  void initState() {
    super.initState();
    _splashServices.isCurrentUserLoggedIn(context);
  }

  @override
  void dispose() {
    super.dispose();
    _splashServices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash_Screen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
