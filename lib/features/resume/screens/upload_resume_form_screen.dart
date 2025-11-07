import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadResumeFormScreen extends StatelessWidget {
  const UploadResumeFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definisi warna
    final Color colorPrimaryButton = Color(0xFF8D3CFF);
    final Color colorPurpleText = Color(0xFF6A26C4);
    final Color colorGreyText = Colors.grey[600]!;

    return Scaffold(
      // 1. APP BAR
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Resume",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              print("More options pressed");
            },
          ),
        ],
      ),
      // 2. BODY UTAMA
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Handle (garis abu-abu di atas)
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),

            // Ikon
            Image.asset(
              'assets/images/upload_resume_icon.png',
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.upload_file, size: 80, color: colorGreyText);
              },
            ),
            const SizedBox(height: 16),

            // Judul
            Text(
              "Upload your resume",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorPurpleText,
              ),
            ),
            const SizedBox(height: 8),

            // Subteks
            Text(
              "Adding your resume allows you to apply very\nquickly to many jobs from any device",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: colorGreyText,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // 3. KOTAK UPLOAD (GARIS PUTUS-PUTUS)
            _buildDottedUploadBox(colorPrimaryButton, colorPurpleText),
            const SizedBox(height: 24),

            // 4. FORM INPUT
            // Label untuk Job Title
            _buildFormLabel("Your job title or qualification"),
            // Input Job Title
            _buildTextField("Your job title or qualification"),
            const SizedBox(height: 16),

            // Label untuk Lokasi
            _buildFormLabel("Your location"),
            // Input Lokasi
            _buildTextField("Town, county or counrtry"), // typo 'counrtry'
            const SizedBox(height: 32),

            // 5. TOMBOL-TOMBOL
            // Tombol "Upload" (Outlined)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  print("Form Upload pressed");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Upload",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorPrimaryButton,
                  backgroundColor:
                      Color(0xFFF7F4FD), // Latar belakang putih/ungu muda
                  side: BorderSide(color: colorPrimaryButton, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol "Cancel" (Elevated)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Form Cancel pressed");
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimaryButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN ---

  // Widget untuk Label Form (dengan Bintang Merah)
  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: label,
              style: TextStyle(color: Colors.black87),
              children: [
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Input Text Field
  Widget _buildTextField(String hintText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }

  // Widget untuk Kotak Upload Garis Putus-putus
  Widget _buildDottedUploadBox(
      Color colorPrimaryButton, Color colorPurpleText) {
    return DottedBorder(
      color: colorPrimaryButton.withOpacity(0.7),
      strokeWidth: 1.5,
      dashPattern: [6, 4], // Pola garis putus-putus
      borderType: BorderType.RRect,
      radius: Radius.circular(12.0),
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: Color(0xFFF7F4FD), // Latar belakang ungu sangat muda
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                print("Upload Resume Box Tapped");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "+Upload Resume",
                      style: TextStyle(
                        color: colorPurpleText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.upload_rounded,
                      color: colorPrimaryButton,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
