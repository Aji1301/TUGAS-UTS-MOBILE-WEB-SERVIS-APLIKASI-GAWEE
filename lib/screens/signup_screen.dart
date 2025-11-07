import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reset_password_screen.dart';
// Hapus import constants.dart

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const Color kTextTitle = Color(0xFF333333);
  static const Color kTextSubtitle = Color(0xFF757575);
  static const Color kInactiveTab = Color(0xFFBDBDBD);

  InputDecoration _buildInputDecoration(BuildContext context, String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(color: kInactiveTab),
      filled: true,
      fillColor: Theme.of(context).cardColor, // Gunakan warna Tema
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    // === GUNAKAN WARNA DARI THEME ===
    final theme = Theme.of(context);
    final kPageBackground = theme.scaffoldBackgroundColor;
    final kPrimaryColor = theme.primaryColor; // <-- Baca dari Theme

    return Scaffold(
      backgroundColor: kPageBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kTextTitle),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png', height: 60),
                    const SizedBox(height: 8),
                    Text(
                      "Gawee",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor, // <-- Gunakan warna Theme
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Create an account",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kTextTitle,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: _buildInputDecoration(context, "Email Address"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _buildInputDecoration(context, "User Name"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _buildInputDecoration(context, "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor, // <-- Gunakan warna Theme
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "SUBMIT",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: kTextSubtitle,
                    ),
                    children: [
                      const TextSpan(text: "Forgot your password? "),
                      TextSpan(
                        text: "Reset here",
                        style: TextStyle(
                          color: kPrimaryColor, // <-- Gunakan warna Theme
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  "Already have an account",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: kTextSubtitle,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  side: BorderSide(
                    color: kPrimaryColor,
                    width: 1.5,
                  ), // <-- Gunakan warna Theme
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "SIGN IN",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor, // <-- Gunakan warna Theme
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
