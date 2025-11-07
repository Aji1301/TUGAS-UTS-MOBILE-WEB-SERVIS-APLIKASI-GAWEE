// lib/features/recent_job/screens/submission_page.dart
import 'package:flutter/material.dart';

class SubmissionPage extends StatelessWidget {
  // Tambahkan primaryColor agar warna tombol dan border konsisten
  final Color primaryColor;

  const SubmissionPage({required this.primaryColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle drag (garis di atas)
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 30),

          // Input User Name
          _buildTextField(primaryColor, label: 'User Name'),
          const SizedBox(height: 20),
          // Input Email Address
          _buildTextField(
            primaryColor,
            label: 'Email Address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          // Input Phone Number
          _buildTextField(
            primaryColor,
            label: 'Phone number',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 40),

          // Tombol SUBMIT
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Aplikasi Berhasil Dikirim!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // Warna ungu utama
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('SUBMIT'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    Color primaryColor, {
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEEEEEE)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2), // Warna ungu
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
