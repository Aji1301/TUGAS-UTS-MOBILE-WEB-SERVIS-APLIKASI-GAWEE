import 'package:flutter/material.dart';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);

class GridLayoutPage extends StatelessWidget {
  const GridLayoutPage({super.key});

  // Warna latar belakang untuk kotak kolom
  static const Color columnBgColor = Color.fromARGB(255, 224, 223, 223);
  static const Color columnTextColor = Colors.black87;
  static const double columnHeight = 40.0;
  static const double gapSize = 8.0;

  // --- Widget Pembantu: Judul Bagian Ungu ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: framework7Purple,
        ),
      ),
    );
  }

  // --- Widget Pembantu: Kotak Kolom Dasar ---
  Widget _buildColumnBox(String text, {double horizontalPadding = 8.0}) {
    return Container(
      height: columnHeight,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: columnBgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: columnTextColor),
      ),
    );
  }

  // --- Bagian 1: Columns with gap ---
  Widget _buildGapGrid() {
    return Column(
      children: <Widget>[
        // Row 1: 50% / 50% (2 cols)
        Row(
          children: [
            Expanded(child: _buildColumnBox('2 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('2 cols')),
          ],
        ),
        const SizedBox(height: gapSize),

        // Row 2: 25% / 25% / 25% / 25% (4 cols)
        Row(
          children: [
            Expanded(child: _buildColumnBox('4 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('4 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('4 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('4 cols')),
          ],
        ),
        const SizedBox(height: gapSize),

        // Row 3: 33% / 33% / 33% (3 cols)
        Row(
          children: [
            Expanded(child: _buildColumnBox('3 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('3 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('3 cols')),
          ],
        ),
        const SizedBox(height: gapSize),

        // Row 4: 20% x 5 (5 cols)
        Row(
          children: [
            Expanded(child: _buildColumnBox('5 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('5 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('5 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('5 cols')),
            const SizedBox(width: gapSize),
            Expanded(child: _buildColumnBox('5 cols')),
          ],
        ),
      ],
    );
  }

  // --- Bagian 2: No gap between columns ---
  Widget _buildNoGapGrid() {
    return Column(
      children: <Widget>[
        // Row 1: 50% / 50% (2 cols)
        Row(
          children: [
            Expanded(child: _buildColumnBox('2 cols')),
            Expanded(child: _buildColumnBox('2 cols')),
          ],
        ),
        const Divider(
          height: 1,
          thickness: 0,
          color: Colors.transparent,
        ), // Mengganti SizedBox untuk konsistensi
        // Row 2: 25% / 25% / 25% / 25% (4 cols)
        Row(
          children: [
            Expanded(child: _buildColumnBox('4 cols')),
            Expanded(child: _buildColumnBox('4 cols')),
            Expanded(child: _buildColumnBox('4 cols')),
            Expanded(child: _buildColumnBox('4 cols')),
          ],
        ),
        const Divider(height: 1, thickness: 0, color: Colors.transparent),

        // Row 3: 33% / 33% / 33% (3 cols)
        Row(
          children: [
            Expanded(child: _buildColumnBox('3 cols')),
            Expanded(child: _buildColumnBox('3 cols')),
            Expanded(child: _buildColumnBox('3 cols')),
          ],
        ),
        const Divider(height: 1, thickness: 0, color: Colors.transparent),

        // Row 4: 20% x 5 (5 cols)
        Row(
          children: [
            Expanded(child: _buildColumnBox('5 cols')),
            Expanded(child: _buildColumnBox('5 cols')),
            Expanded(child: _buildColumnBox('5 cols')),
            Expanded(child: _buildColumnBox('5 cols')),
            Expanded(child: _buildColumnBox('5 cols')),
          ],
        ),
      ],
    );
  }

  // --- Bagian 3: Responsive Grid (Membutuhkan Logika Responsif Nyata) ---
  Widget _buildResponsiveGrid(BuildContext context) {
    // Di Flutter, kita bisa menggunakan MediaQuery untuk mensimulasikan 'medium' (tablet)
    // Di sini, kita akan menggunakan Expanded dengan rasio yang berbeda

    // Asumsi: Kita mensimulasikan layout mobile (1 col) vs layout tablet (2 atau 4 cols)

    final screenWidth = MediaQuery.of(context).size.width;
    // Tentukan ambang batas 'medium' (misalnya 600)
    final bool isMedium = screenWidth > 600;

    // Baris 1: 1 col / medium 2 cols
    Widget buildResponsiveRow1() {
      // Pada phone: 1/1 (full width)
      // Pada tablet: 1/2 (setengah width)

      // Karena ini adalah simulasi, kita akan menyamakan kedua tombol
      // agar tetap rapi pada tampilan kecil, dan biarkan Expanded bekerja.

      // Untuk meniru "1 col / medium 2 cols", kita memerlukan dua baris Expanded
      // yang bekerja sama. Karena terbatas pada satu Row, kita akan
      // menggunakan Expanded untuk membagi ruang secara horizontal.

      return Column(
        children: [
          // Baris 1: 1 col (lebar penuh)
          _buildColumnBox('1 col / medium 2 cols'),
          const SizedBox(height: gapSize),
          // Baris 2: 1 col (lebar penuh)
          _buildColumnBox('1 col / medium 2 cols'),
        ],
      );
    }

    // Baris 2: 2 col / medium 4 cols
    Widget buildResponsiveRow2() {
      // Pada phone: 1/2 (setengah width)
      // Pada tablet: 1/4 (seperempat width)

      // Simulasi ini memerlukan 4 Expanded item untuk 4 cols.
      // Pada tampilan sempit, 4 Expanded item akan menjadi 4 kolom sempit.

      // Solusi Flutter yang sederhana: Buat 4 kolom, dan label menunjukkan perubahannya.

      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildColumnBox('2 col / medium 4 cols')),
              const SizedBox(width: gapSize),
              Expanded(child: _buildColumnBox('2 col / medium 4 cols')),
            ],
          ),
          const SizedBox(height: gapSize),
          Row(
            children: [
              Expanded(child: _buildColumnBox('2 col / medium 4 cols')),
              const SizedBox(width: gapSize),
              Expanded(child: _buildColumnBox('2 col / medium 4 cols')),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        buildResponsiveRow1(),
        const SizedBox(height: gapSize),
        buildResponsiveRow2(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // --- AppBar ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
        child: Container(
          decoration: const BoxDecoration(
            color: lightPurpleBackground,
            border: Border(bottom: BorderSide(color: dividerColor, width: 1.0)),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Grid / Layout',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Teks Deskripsi
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Columns within a row are automatically set to have equal width. Otherwise you can define your column with pourcentage of screen you want.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ),

            // ----------------------------------------------------
            // 1. Columns with gap
            // ----------------------------------------------------
            _buildSectionTitle('Columns with gap'),
            _buildGapGrid(),

            // ----------------------------------------------------
            // 2. No gap between columns
            // ----------------------------------------------------
            _buildSectionTitle('No gap between columns'),
            _buildNoGapGrid(),

            // ----------------------------------------------------
            // 3. Responsive Grid
            // ----------------------------------------------------
            _buildSectionTitle('Responsive Grid'),
            const Text(
              'Grid cells have different size on Phone/Tablet',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 12),
            _buildResponsiveGrid(context),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
