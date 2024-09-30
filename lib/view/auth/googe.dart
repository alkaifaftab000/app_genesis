import 'package:app_genesis/view/TeacherPanel/home_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';

class AuthHandler extends StatefulWidget {
  final Widget child;

  const AuthHandler({super.key, required this.child});

  @override
  AuthHandlerState createState() => AuthHandlerState();
}

class AuthHandlerState extends State<AuthHandler> {
  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle app links while the app is already started
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleDeepLink(uri);
      }
    });

    try {
      // Handle app links when the app is started by the link
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        handleDeepLink(initialLink);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error handling initial deep link: $e');
      }
    }
  }

  void handleDeepLink(Uri uri) {
    // Parse the URI and handle authentication result
    if (uri.path == '/auth') {
      final success = uri.queryParameters['success'] == 'true';
      final token = uri.queryParameters['token'];

      if (success && token != null) {
        if (kDebugMode) {
          print('Authentication successful. Token: $token');
        }
        // Navigate to the main app screen or save the token
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      } else {
        if (kDebugMode) {
          print('Authentication failed');
        }
        // Optionally show an error message or redirect to login
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child; // Return the child widget
  }
}