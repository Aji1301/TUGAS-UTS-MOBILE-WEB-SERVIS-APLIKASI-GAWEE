import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. Import drawer
import '../../../widgets/custom_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  // 2. Tambahkan GlobalKey untuk Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // 3. Ambil warna dari Theme, bukan hardcode
    final theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color backgroundColor = theme.scaffoldBackgroundColor;
    final Color textColor = theme.textTheme.bodyMedium?.color ?? Colors.black87;
    final Color subTextColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ?? Colors.grey;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey, // 4. Gunakan ScaffoldKey
      backgroundColor: backgroundColor,
      // 5. Tambahkan drawer
      drawer: const SizedBox(
        width: 320,
        child: Drawer(child: CustomDrawerBody()),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(
              bottom: BorderSide(
                  color: theme.brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : const Color(0xFFDDDDDD),
                  width: 1.3),
            ),
          ),
          padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            bottom: screenHeight * 0.005,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Kembali
                  Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor, // Gunakan theme.cardColor
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: textColor, // Gunakan textColor
                        size: 28,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Text(
                    "Profile",
                    style: GoogleFonts.poppins(
                      // Terapkan Font
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // Tombol Titik 3 (More)
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: textColor,
                      size: 28,
                    ),
                    // 6. Atur onPressed untuk membuka drawer
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(theme.cardColor),
          trackColor: WidgetStateProperty.all(Colors.grey[400]),
          thickness: WidgetStateProperty.all(8),
          thumbVisibility: WidgetStateProperty.all(true),
          trackVisibility: WidgetStateProperty.all(true),
          radius: const Radius.circular(10),
        ),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar Profil
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'assets/images/foto.webp', // Pastikan gambar ini ada
                    width: screenWidth * 0.43,
                    height: screenWidth * 0.43,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: screenHeight * 0.018),

                Text(
                  'Richard Brownlee',
                  style: GoogleFonts.poppins(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Engineer',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: subTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: screenHeight * 0.018),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
                    'Excepteur sint occaecat cupidatat non proident.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      color: textColor.withOpacity(0.9),
                      height: 1.35,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 4,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Tombol My Resume
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: primaryColor, // Gunakan primaryColor dari theme
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2), // Bayangan
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Resume',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'david_resume.pdf',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.file_download_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.045),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Skills',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                _buildSkill('Problem Solving', 0.7, primaryColor, textColor,
                    subTextColor),
                SizedBox(height: screenHeight * 0.03),
                _buildSkill(
                    'Drawing', 0.35, primaryColor, textColor, subTextColor),
                SizedBox(height: screenHeight * 0.03),
                _buildSkill(
                    'Illustration', 0.8, primaryColor, textColor, subTextColor),
                SizedBox(height: screenHeight * 0.03),
                _buildSkill(
                    'Photoshop', 0.34, primaryColor, textColor, subTextColor),

                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget untuk Skill (diperbarui dengan theme)
  static Widget _buildSkill(String skill, double progress, Color color,
      Color textColor, Color subTextColor) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.poppins(fontSize: 16, color: subTextColor),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: subTextColor.withOpacity(0.2),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
