import 'package:app_genesis/utils/fonts.dart';
import 'package:app_genesis/view/auth/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenSize = MediaQuery.of(context).size;
          bool isLargeScreen = screenSize.width > 800;

          return Stack(
            children: [
              // Background Image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1494809610410-160faaed4de0?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Login Form
              Center(
                child: Container(
                  padding: isLargeScreen
                      ? const EdgeInsets.symmetric(horizontal: 40, vertical: 20)
                      : const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                  constraints: BoxConstraints(
                    maxWidth: isLargeScreen ? 500 : 400,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: AppTextStyles.heading(color: Colors.black),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // Handle login action
                            },
                            icon: Image.asset(
                              "assets/image/google_logo.png",
                              height: 30,
                              width: 30,
                            ),
                            label: Text(
                              'Login with Google',
                              style: AppTextStyles.body(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: const Text("Don't have an account? Sign Up"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
