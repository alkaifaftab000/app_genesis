import 'package:app_genesis/view/TeacherPanel/teacher.dart';
import 'package:app_genesis/view/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(image: NetworkImage('https://blog.jeton.com/wp-content/uploads/2022/03/Cyber-security-keeping-your-digital-wallet-safe.png')),

                  Card(
                    elevation: 8.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          TextField(
                            style: GoogleFonts.poppins(fontSize: 16),
                            decoration: InputDecoration(
                              labelText: 'Email / Username',
                              labelStyle: GoogleFonts.poppins(fontSize: 18, color: Colors.blue.shade700),
                              hintText: 'Enter your email or username',
                              hintStyle: GoogleFonts.poppins(fontSize: 16),
                              prefixIcon: Icon(Icons.email, color: Colors.blue.shade700, size: 24),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.blue.shade200, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.blue.shade200, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.blue.shade50,
                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                            ),
                          ),
                          SizedBox(height: 14.0),
                          TextField(
                            obscureText: true,
                            style: GoogleFonts.poppins(fontSize: 16),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.poppins(fontSize: 18, color: Colors.blue.shade700),
                              hintText: 'Enter your password',
                              hintStyle: GoogleFonts.poppins(fontSize: 16),
                              prefixIcon: Icon(Icons.lock, color: Colors.blue.shade700, size: 24),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.blue.shade200, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.blue.shade200, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.blue.shade50,
                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Implement forgot password functionality
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const Teacher()));
                    },
                    icon: Icon(Icons.login_rounded, color: Colors.white, size: 24),
                    label: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1.5)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Or continue with',
                          style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 16),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1.5)),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement Google login
                          },
                          icon: Icon(Icons.g_translate, color: Colors.black, size: 24),
                          label: Text('Google', style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,

                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(color: Colors.grey.shade300, width: 2),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement phone login
                          },
                          icon: const Icon(Icons.phone, color: Colors.black, size: 24),
                          label: Text('Phone', style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,

                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(color: Colors.grey.shade300, width: 2),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                    ]),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RegisterScreen()));
                    },
                    icon: const Icon(Icons.login, color: Colors.black, size: 24),
                    label: Text('Register', style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade50,

                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: Colors.grey.shade300, width: 2),
                      ),
                      elevation: 2,
                    ),
                  ),
                ]),
            ),
          ),
        ),
      ),
    );
  }
}