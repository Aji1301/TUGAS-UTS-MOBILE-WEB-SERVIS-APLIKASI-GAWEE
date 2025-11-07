import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/theme_provider.dart';
import '../widgets/custom_drawer.dart';
import '../utils/constants.dart'; // <--- PASTIKAN defaultColors ADA DI SINI

import '../features/recent_job/screens/recent_job_page.dart';
import '../features/recent_job/screens/job_detail_page.dart';

// (Di bawah import lainnya)
import '../features/featured_job/screens/featured_job_detail_screen.dart';

class DashboardPage extends StatefulWidget {
  // Hapus parameter onToggleTheme, kita akan akses state secara global
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // FUNGSI BARU UNTUK MENAMPILKAN BOTTOM SHEET
  void _showColorPickerSheet(BuildContext context, ThemeProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Theme.of(context).cardColor, // <-- Sesuaikan dengan warna kartu tema
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      // 🔹 PERBAIKAN: Tambahkan isScrollControlled
      isScrollControlled:
          true, // Ini memungkinkan sheet untuk tidak full screen
      builder: (context) {
        // Kita teruskan provider ke widget sheet
        // 🔹 PERBAIKAN: Bungkus dengan DraggableScrollableSheet
        // Ini akan membuat sheet bisa di-scroll dan ukurannya pas.
        return DraggableScrollableSheet(
          initialChildSize: 0.6, // Mulai dari 60% tinggi layar
          minChildSize: 0.4, // Minimal 40%
          maxChildSize: 0.9, // Maksimal 90%
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return _ColorPickerSheet(
              provider: provider,
              scrollController: scrollController, // Teruskan scroll controller
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // === BACA STATE GLOBAL (VERSI PROVIDER) ===
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium!.color!;
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final kPrimaryColor = theme.primaryColor;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const SizedBox(
        width: 320,
        child: Drawer(child: CustomDrawerBody()),
      ),
      body: SafeArea(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            children: [
              // ======= TOP BAR =======
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, size: 28, color: textColor),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    const Spacer(),
                    // === PERUBAHAN DI SINI ===
                    GestureDetector(
                      onTap: () {
                        // 🔹 PERBAIKAN: Gunakan listen: false saat memanggil
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        _showColorPickerSheet(context, provider);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.color_lens,
                          size: 18,
                          color: textColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                    // ==========================
                    const SizedBox(width: 8),
                    // Tombol Ganti Tema
                    GestureDetector(
                      onTap: () {
                        Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).toggleTheme(!isDark);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isDark
                              ? Icons.wb_sunny_outlined
                              : Icons.dark_mode_outlined,
                          size: 18,
                          color: isDark ? Colors.amber : textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ======= BODY =======
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ... (Profile Info)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello',
                                  style: GoogleFonts.poppins(
                                    color: textColor.withOpacity(0.7),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Richard Brownlee',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: const AssetImage(
                                'assets/images/foto.webp'), // Ganti ke Aset Lokal
                            onBackgroundImageError: (exception, stackTrace) {
                              // Fallback
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ... (Search)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: textColor.withOpacity(0.6),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.poppins(
                                  color: textColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search job here...',
                                  hintStyle: GoogleFonts.poppins(
                                    color: textColor.withOpacity(0.5),
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // ... (Recommended Card)
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 110,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  kPrimaryColor,
                                  kPrimaryColor.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withOpacity(0.25),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Recomended Jobs',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'See our recomendations job for you based your skills',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(flex: 2),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: -20,
                            child: Image.asset(
                              'assets/images/onboarding_2.png',
                              height: 110,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // ... (Stats)
                      const Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              number: '45',
                              label: 'Jobs Applied',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(number: '28', label: 'Interviews'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // ======= CATEGORIES =======
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Job Categories',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // ⬇️ PERBAIKAN: BUAT "MORE" BISA DIKLIK
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecentJobScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'More',
                              style: GoogleFonts.poppins(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // ⬆️ PERBAIKAN SELESAI
                        ],
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            // ⬇️ PERBAIKAN FINAL: KIRIM NAMA KATEGORI
                            _CategoryChip(
                              label: 'Designer',
                              color: const Color(0xFF0E6F83),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecentJobScreen(
                                        categoryName: 'Designer'),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            _CategoryChip(
                              label: 'Manager',
                              color: const Color(0xFF006A5B),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecentJobScreen(
                                        categoryName: 'Manager'),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            _CategoryChip(
                              label: 'Programmer',
                              color: const Color(0xFF8B5600),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecentJobScreen(
                                        categoryName: 'Programmer'),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            _CategoryChip(
                              label: 'UX/UI Designer',
                              color: const Color(0xFF116C1A),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecentJobScreen(
                                        categoryName: 'UX/UI Designer'),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            _CategoryChip(
                              label: 'Photographer',
                              color: kPrimaryColor.withOpacity(0.8),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecentJobScreen(
                                        categoryName: 'Photographer'),
                                  ),
                                );
                              },
                            ),
                            // ⬆️ PERBAIKAN SELESAI
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      // ======= FEATURED JOBS =======
                      Text(
                        'Featured Jobs',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ⬇️ PERBAIKAN 2: BUAT FEATURED JOBS BISA DIKLIK
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            // KARTU PERTAMA DIBUAT BISA DIKLIK
                            InkWell(
                              onTap: () {
                                // Buat data dummy untuk dikirim
                                final jobData = {
                                  'id': 'feat1', // ID unik sementara
                                  'title': 'Software Engineer',
                                  'company': 'Cosax Studios',
                                  'location': 'Medan, Indonesia',
                                  'salary': '\$500 - \$1,000',
                                  'is_saved': 'true',
                                  'icon_bg_color': '0xFF295D8A',
                                  'icon_fg_color': '0xFFFFFFFF',
                                };
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // KIRIM KE HALAMAN DETAIL BARU
                                    builder: (context) =>
                                        FeaturedJobDetailScreen(job: jobData),
                                  ),
                                );
                              },
                              child: const _FeaturedJobCard(
                                // Ganti logoColor dengan logoPath
                                logoColor: Color(0xFF295D8A), // Warna fallback
                                logoPath:
                                    'assets/images/logo 4.png', // Ganti nama logo
                                title: 'Software Engineer',
                                company: 'Cosax Studios',
                                location: 'Medan, Indonesia',
                                salary: '\$500 - \$1,000',
                                isBookmarked: true,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // KARTU KEDUA DIBUAT BISA DIKLIK
                            InkWell(
                              onTap: () {
                                final jobData = {
                                  'id': 'feat2',
                                  'title': 'Senior Programmer',
                                  'company': 'Cosax Studios',
                                  'location': 'Medan, Indonesia',
                                  'salary': '\$900 - \$1,200',
                                  'is_saved': 'false',
                                  'icon_bg_color': '0xFF1B7C50',
                                  'icon_fg_color': '0xFFFFFFFF',
                                };
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // KIRIM KE HALAMAN DETAIL BARU
                                    builder: (context) =>
                                        FeaturedJobDetailScreen(job: jobData),
                                  ),
                                );
                              },
                              child: const _FeaturedJobCard(
                                // Ganti logoColor dengan logoPath
                                logoColor: Color(0xFF1B7C50), // Warna fallback
                                logoPath:
                                    'assets/images/logo 1.png', // Ganti nama logo
                                title: 'Senior Programmer',
                                company: 'Cosax Studios',
                                location: 'Medan, Indonesia',
                                salary: '\$900 - \$1,200',
                                isBookmarked: false,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // KARTU KETIGA DIBUAT BISA DIKLIK
                            InkWell(
                              onTap: () {
                                final jobData = {
                                  'id': 'feat3',
                                  'title': 'UX/UI Designer',
                                  'company': 'Cosax Studios',
                                  'location': 'Medan, Indonesia',
                                  'salary': '\$700 - \$1,500',
                                  'is_saved': 'false',
                                  'icon_bg_color':
                                      kPrimaryColor.value.toString(),
                                  'icon_fg_color': '0xFFFFFFFF',
                                };
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // KIRIM KE HALAMAN DETAIL BARU
                                    builder: (context) =>
                                        FeaturedJobDetailScreen(job: jobData),
                                  ),
                                );
                              },
                              child: _FeaturedJobCard(
                                logoColor: kPrimaryColor,
                                // ⬇️ --- PERBAIKAN DI SINI --- ⬇️
                                logoPath:
                                    'assets/images/logo 1.png', // <-- GANTI DARI null
                                // ⬆️ --- PERBAIKAN DI SINI --- ⬆️
                                title: 'UX/UI Designer',
                                company: 'Cosax Studios',
                                location: 'Medan, Indonesia',
                                salary: '\$700 - \$1,500',
                                isBookmarked: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ⬆️ PERBAIKAN SELESAI

                      // ======= RECENT JOBS =======
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Jobs List',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // ⬇️ PERBAIKAN: Buat "More" di Recent Jobs bisa diklik
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecentJobScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'More',
                              style: GoogleFonts.poppins(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // ⬆️ PERBAIKAN: Selesai
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ⬇️ PERBAIKAN: LIST RECENT JOB DENGAN PATH LOGO KUSTOM
                      Column(
                        children: [
                          // 1. Junior Software Engineer (Logo 4 - Ungu)
                          _RecentJobTile(
                            logoColor: kPrimaryColor,
                            logoPath: 'assets/images/logo 4.png',
                            title: 'Junior Software Engineer',
                            company: 'Cosax Studios',
                            location: 'Medan, Indonesia',
                            salary: '\$500 - \$1,000',
                          ),
                          const SizedBox(height: 10),
                          // 2. Software Engineer (Logo 1 - Ungu/Primary)
                          _RecentJobTile(
                            logoColor: kPrimaryColor.withOpacity(0.7),
                            logoPath: 'assets/images/logo 1.png',
                            title: 'Software Engineer',
                            company: 'Kelakon',
                            location: 'Medan, Indonesia',
                            salary: '\$500 - \$1,000',
                          ),
                          const SizedBox(height: 10),
                          // 3. Graphic Designer (Logo 1 - Hijau Tua)
                          const _RecentJobTile(
                            logoColor: Color(0xFF1B7C50),
                            logoPath: 'assets/images/logo 1.png',
                            title: 'Graphic Designer',
                            company: 'Nelakon',
                            location: 'Medan, Indonesia',
                            salary: '\$500 - \$1,000',
                          ),
                          const SizedBox(height: 10),
                          // 4. Software Engineer (Logo 4 - Biru Kehijauan)
                          const _RecentJobTile(
                            logoColor: Color(0xFF0E6F83),
                            logoPath: 'assets/images/logo 4.png',
                            title: 'Software Engineer',
                            company: 'Nelakon',
                            location: 'Medan, Indonesia',
                            salary: '\$500 - \$1,000',
                          ),
                        ],
                      ),
                      // ⬆️ PERBAIKAN SELESAI
                      const SizedBox(height: 40),
                    ],
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

// ===================================================================
// WIDGET BARU UNTUK BOTTOM SHEET
// ===================================================================
class _ColorPickerSheet extends StatelessWidget {
  final ThemeProvider provider;
  final ScrollController scrollController;
  const _ColorPickerSheet(
      {required this.provider, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final colors = defaultColors;

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      children: [
        // Drag Handle
        Center(
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 25),
        // Grid
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 kolom
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.0, // Perbandingan tinggi-lebar item
          ),
          itemCount: colors.length,
          shrinkWrap: true, // Penting untuk di dalam ListView
          physics:
              const NeverScrollableScrollPhysics(), // Biarkan ListView yg scroll
          itemBuilder: (context, index) {
            String name = colors.keys.elementAt(index);
            Color color = colors.values.elementAt(index);
            bool isSelected = provider.primaryColor.value == color.value;

            return _ColorPickerItem(
              name: name,
              color: color,
              isSelected: isSelected,
              onTap: () {
                provider.setPrimaryColor(color);
              },
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// WIDGET BARU UNTUK TIAP ITEM WARNA DI GRID
class _ColorPickerItem extends StatelessWidget {
  final String name;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorPickerItem({
    required this.name,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).textTheme.bodyMedium!.color!,
                      width: 2)
                  : null,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 28)
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}

// ... (Widget _StatCard)
class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  const _StatCard({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ), // <-- FONT DITERAPKAN
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              // <-- FONT DITERAPKAN
              color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

// ⬇️ PERBAIKAN 2: MODIFIKASI _CategoryChip
class _CategoryChip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onTap; // <-- TAMBAHKAN INI

  const _CategoryChip({
    required this.label,
    required this.color,
    this.onTap, // <-- TAMBAHKAN INI
  });

  @override
  Widget build(BuildContext context) {
    // BUNGKUS DENGAN INKWELL AGAR BISA DI-TAP
    return InkWell(
      onTap: onTap, // <-- GUNAKAN FUNGSI ONTAP
      borderRadius: BorderRadius.circular(12), // <-- SINKRONKAN BORDER RADIUS
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            // <-- FONT DITERAPKAN
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
// ⬆️ PERBAIKAN SELESAI

// ⬇️ PERBAIKAN 1: MODIFIKASI _FeaturedJobCard (sudah benar, tidak diubah)
class _FeaturedJobCard extends StatefulWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final Color logoColor; // Warna fallback jika logoPath null
  final String? logoPath; // Path gambar logo (bisa null)
  final bool isBookmarked;

  const _FeaturedJobCard({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.logoColor,
    this.logoPath, // Tambahkan ini
    this.isBookmarked = false,
  });

  @override
  State<_FeaturedJobCard> createState() => _FeaturedJobCardState();
}

class _FeaturedJobCardState extends State<_FeaturedJobCard> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(right: 0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- PERUBAHAN LOGO DI SINI ---
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  // Gunakan warna logo sbg background jika path tidak ada
                  color: widget.logoPath == null
                      ? widget.logoColor.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  // Tambahkan ClipRRect agar gambar sesuai radius
                  borderRadius: BorderRadius.circular(8),
                  child: (widget.logoPath != null)
                      ? Image.asset(
                          // Jika ada path, tampilkan gambar
                          widget.logoPath!,
                          fit: BoxFit.cover, // Gunakan cover agar penuh
                          errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.work,
                              color: widget.logoColor,
                              size: 22),
                        )
                      : Icon(Icons.work,
                          color: widget.logoColor, size: 22), // Fallback
                ),
              ),
              // --- AKHIR PERUBAHAN LOGO ---
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.orange,
                ),
                onPressed: () {
                  setState(() {
                    _isBookmarked = !_isBookmarked;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.company,
            style: GoogleFonts.poppins(
              // <-- FONT DITERAPKAN
              color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ), // <-- FONT DITERAPKAN
          ),
          const SizedBox(height: 4),
          Text(
            widget.location,
            style: GoogleFonts.poppins(
              // <-- FONT DITERAPKAN
              color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.salary,
                style: GoogleFonts.poppins(
                  // <-- FONT DITERAPKAN
                  color: theme.primaryColor, // <-- Gunakan warna Theme
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: theme.textTheme.bodyMedium!.color!.withOpacity(0.5),
                size: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// ⬆️ PERBAIKAN SELESAI

// ⬇️ PERBAIKAN PENTING: MODIFIKASI _RecentJobTile
class _RecentJobTile extends StatefulWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final Color logoColor;
  final String logoPath; // <--- BARU

  const _RecentJobTile({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.logoColor,
    required this.logoPath, // <--- BARU
  });

  @override
  State<_RecentJobTile> createState() => _RecentJobTileState();
}

class _RecentJobTileState extends State<_RecentJobTile> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        // PERBAIKAN: Tambahkan logika navigasi ke JobDetailScreen
        final jobData = {
          'id': 'recent_${widget.title}',
          'title': widget.title,
          'company': widget.company,
          'location': widget.location,
          'salary': widget.salary,
          'is_saved': _isBookmarked.toString(),
          'icon_bg_color':
              widget.logoColor.value.toRadixString(16).toUpperCase(),
          'icon_fg_color': '0xFFFFFFFF', // Ikon dalam berwarna putih
        };
        Navigator.push(
          context,
          MaterialPageRoute(
            // Buka halaman job_detail_page.dart
            builder: (context) => JobDetailScreen(job: jobData),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // --- LOGO GAMBAR PERUSAHAAN/IKON KUSTOM ---
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                // Warna latar belakang yang lembut (opacity 0.15)
                color: widget.logoColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.logoPath, // <--- MENGGUNAKAN LOGO ASSET
                  fit: BoxFit.contain, // Agar terlihat penuh di dalam kotak
                  // Menghilangkan pewarnaan color: widget.logoColor jika gambar adalah logo berwarna.
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.work, color: widget.logoColor, size: 24),
                ),
              ),
            ),
            // --- AKHIR LOGO GAMBAR ---
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      // <-- FONT DITERAPKAN
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Hapus Text(widget.company)
                  Text(
                    widget.location,
                    style: GoogleFonts.poppins(
                      // <-- FONT DITERAPKAN
                      color: theme.textTheme.bodyMedium!.color!.withOpacity(
                        0.6,
                      ),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.salary,
                    style: GoogleFonts.poppins(
                      // <-- FONT DITERAPKAN
                      color: theme.primaryColor, // <-- Gunakan warna Theme
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: theme.textTheme.bodyMedium!.color!.withOpacity(0.5),
              ),
              onPressed: () {
                setState(() {
                  _isBookmarked = !_isBookmarked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
// ⬆️ PERBAIKAN Selesai
