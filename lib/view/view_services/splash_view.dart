import 'package:app_genesis/view/view_services/splash_view_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashViewNew extends StatefulWidget {
  const SplashViewNew({super.key});
  @override
  State<SplashViewNew> createState() => _SplashViewNewState();
}
class _SplashViewNewState extends State<SplashViewNew> {
  final splashServices = SplashViewServices();
  @override
  void initState() {
    super.initState();
    splashServices.isCurrentUserLoggedIn(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/image/app_logo.gif')),
          const SizedBox(height: 20),
          LoadingAnimationWidget.inkDrop(
            color: Colors.cyan,
            size: 40,
          ),
          const SizedBox(height: 30),
          Text('Learning Management System 🚀🚀',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
