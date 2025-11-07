import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard_screen.dart';
import 'signup_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Hapus deklarasi variabel lokal kPageBackground dan kPrimaryColor di sini
    // untuk menghindari warning karena tidak digunakan segera.

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // Menggunakan Theme.of(context) secara langsung
        backgroundColor: theme.scaffoldBackgroundColor,
        body: const SafeArea(
          child: Column(
            children: [
              _Header(),
              _TabSelector(),
              SizedBox(height: 24),
              Expanded(
                child: TabBarView(
                  children: [
                    _JobSeekerTab(),
                    _CompanyTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================================
// WIDGET BARU UNTUK KOMPONEN STATIS (Sisa kode tidak berubah)
// =======================================================================

class _Header extends StatelessWidget {
// ... (Kode _Header)
  const _Header();

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 60,
            errorBuilder: (ctx, err, st) =>
                Icon(Icons.work, color: kPrimaryColor, size: 60),
          ),
          const SizedBox(height: 8),
          Text(
            "Gawee",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
// ... (Kode _TabSelector)
  const _TabSelector();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final kPrimaryColor = theme.primaryColor;
    final kInactiveTab = theme.brightness == Brightness.light
        ? Colors.grey.shade500
        : Colors.grey.shade400;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TabBar(
        indicatorColor: kPrimaryColor,
        indicatorWeight: 4.0,
        labelColor: kPrimaryColor,
        unselectedLabelColor: kInactiveTab,
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: "JOB SEEKER"),
          Tab(text: "COMPANY"),
        ],
      ),
    );
  }
}

class _JobSeekerTab extends StatelessWidget {
// ... (Kode _JobSeekerTab)
  const _JobSeekerTab();

  @override
  Widget build(BuildContext context) {
    final kTextTitle =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign in to your registered account",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextTitle,
            ),
          ),
          const SizedBox(height: 24),
          const _CustomTextField(hintText: "User Name"),
          const SizedBox(height: 16),
          const _CustomTextField(hintText: "Password", isPassword: true),
          const SizedBox(height: 24),
          const _LoginButton(),
          const SizedBox(height: 16),
          const _ForgotPasswordText(),
          const SizedBox(height: 32),
          const _SocialLoginRow(),
          const SizedBox(height: 32),
          const _CreateAccountButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _CompanyTab extends StatelessWidget {
// ... (Kode _CompanyTab)
  const _CompanyTab();

  @override
  Widget build(BuildContext context) {
    final kTextTitle =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Company account",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextTitle,
            ),
          ),
          const SizedBox(height: 24),
          const _CustomTextField(hintText: "Company Id"),
          const SizedBox(height: 16),
          const _CustomTextField(hintText: "User Name"),
          const SizedBox(height: 16),
          const _CustomTextField(hintText: "Password", isPassword: true),
          const SizedBox(height: 24),
          const _LoginButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// =======================================================================
// WIDGET KOMPONEN (Sisa kode tidak berubah)
// =======================================================================

class _CustomTextField extends StatelessWidget {
// ...
  final String hintText;
  final bool isPassword;
  const _CustomTextField({required this.hintText, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    final kInactiveText = Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade500
        : Colors.grey.shade400;

    return TextFormField(
      obscureText: isPassword,
      style: GoogleFonts.poppins(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: kInactiveText),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
// ...
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      onPressed: () {
        // Navigasi ke DashboardPage dan hapus halaman Login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      },
      child: Text(
        "LOGIN",
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ForgotPasswordText extends StatelessWidget {
// ...
  const _ForgotPasswordText();

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final kTextSubtitle =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ??
            Colors.grey;

    return Center(
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
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigasi ke ResetPasswordScreen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen(),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialLoginRow extends StatelessWidget {
// ...
  const _SocialLoginRow();

  @override
  Widget build(BuildContext context) {
    final kTextSubtitle =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ??
            Colors.grey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Or sign in with",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: kTextSubtitle,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            // Aksi login Google
          },
          child: Image.asset('assets/images/google_logo.png', height: 32),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            // Aksi login Facebook
          },
          child: Image.asset('assets/images/facebook_logo.png', height: 32),
        ),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
// ...
  const _CreateAccountButton();

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: BorderSide(color: kPrimaryColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      onPressed: () {
        // Navigasi ke SignUpScreen
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      },
      child: Text(
        "CREATE ACCOUNT",
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
