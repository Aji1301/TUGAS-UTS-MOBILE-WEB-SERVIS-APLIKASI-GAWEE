import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- IMPOR HALAMAN UTAMA ---
import '../screens/dashboard_screen.dart';
import '../features/recent_job/screens/recent_job_page.dart';
import '../features/find_job/screens/find_job_screen.dart';
import '../features/notification/screens/notification_screen.dart';
import '../features/profile/screens/profile_page.dart';
import '../features/chat/screens/chat_list_screen.dart';
import '../settings/setting_page.dart';
import '../screens/login_screen.dart';

// 🚀 IMPOR BARU: Asumsi ElementPage berada di lib/features/elements/element_page.dart
import '../features/elements/element_page.dart'; // Impor ElementPage

// ======= DRAWER =======
class CustomDrawerBody extends StatelessWidget {
  const CustomDrawerBody({super.key});

  // --- FUNGSI NAVIGASI BARU ---
  void _pushPage(BuildContext context, Widget page) {
    Navigator.pop(context); // Tutup drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _pushReplacementPage(BuildContext context, Widget page) {
    Navigator.pop(context); // Tutup drawer
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
  // ---

  // 🚀 FUNGSI LOGOUT BARU
  void _logout(BuildContext context) {
    Navigator.pop(context); // Tutup drawer

    // Navigasi ke LoginPage dan menghapus semua rute sebelumnya (stack clear)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (Route<dynamic> route) => false, // Menghapus semua rute
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final kPrimaryColor = theme.primaryColor;

    final textColor = theme.brightness == Brightness.dark
        ? Colors.white.withOpacity(0.8)
        : Colors.black.withOpacity(0.7);

    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      child: Material(
        color: theme.cardColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 22, 18, 18),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === HEADER ===
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: 40,
                        errorBuilder: (ctx, err, st) =>
                            Icon(Icons.work, color: kPrimaryColor, size: 40)),
                    const SizedBox(width: 12),
                    Text(
                      'Gawee',
                      style: GoogleFonts.poppins(
                        color: kPrimaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark
                              ? Colors.grey.shade700
                              : Colors.black87,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
                // ==========================================

                const SizedBox(height: 26),

                // === DAFTAR MENU ===
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // 1. HOME
                      GestureDetector(
                        onTap: () {
                          // Gunakan replacement untuk Home/Dashboard
                          if (currentRoute != '/dashboard') {
                            _pushReplacementPage(
                                context, const DashboardPage());
                          } else {
                            Navigator.pop(context); // Tutup drawer
                          }
                        },
                        child: _DrawerItem(
                          icon: Icons.home_rounded,
                          label: 'Home',
                          highlighted: currentRoute == '/dashboard',
                        ),
                      ),

                      // 2. RECENT JOB
                      GestureDetector(
                        onTap: () {
                          if (currentRoute != '/recent_job') {
                            // Diasumsikan RecentJobScreen tidak const
                            _pushPage(context, RecentJobScreen());
                          } else {
                            Navigator.pop(context); // Tutup drawer
                          }
                        },
                        child: _DrawerItem(
                          icon: Icons.article_outlined,
                          label: 'Recent Job',
                          highlighted: currentRoute == '/recent_job',
                        ),
                      ),

                      // 3. FIND JOB
                      GestureDetector(
                        onTap: () {
                          if (currentRoute != '/find_job') {
                            _pushPage(context, const FindJobScreen());
                          } else {
                            Navigator.pop(context); // Tutup drawer
                          }
                        },
                        child: _DrawerItem(
                          icon: Icons.desktop_windows,
                          label: 'Find Job',
                          highlighted: currentRoute == '/find_job',
                        ),
                      ),

                      // 4. NOTIFICATIONS
                      GestureDetector(
                        onTap: () {
                          if (currentRoute != '/notifications') {
                            _pushPage(context, const NotificationScreen());
                          } else {
                            Navigator.pop(context); // Tutup drawer
                          }
                        },
                        child: _DrawerItem(
                          icon: Icons.notifications_none_outlined,
                          label: 'Notifications (2)',
                          highlighted: currentRoute == '/notifications',
                        ),
                      ),

                      // 5. PROFILE
                      GestureDetector(
                        onTap: () {
                          if (currentRoute != '/profile') {
                            _pushPage(context, const ProfilePage());
                          } else {
                            Navigator.pop(context); // Tutup drawer
                          }
                        },
                        child: _DrawerItem(
                          icon: Icons.person_outline,
                          label: 'Profile',
                          highlighted: currentRoute == '/profile',
                        ),
                      ),

                      // 6. CHAT / MESSAGE
                      GestureDetector(
                        onTap: () {
                          if (currentRoute != '/chat_list') {
                            _pushPage(context, const ChatListScreen());
                          } else {
                            Navigator.pop(context); // Tutup drawer
                          }
                        },
                        child: _DrawerItem(
                          icon: Icons.mail_outline,
                          label: 'Message',
                          highlighted: currentRoute == '/chat_list',
                        ),
                      ),

                      // 7. ELEMENTS 🚀 PERBAIKAN DI SINI
                      GestureDetector(
                        onTap: () {
                          if (currentRoute != '/elements_page') {
                            // PANGGIL TANPA 'const' untuk memperbaiki error
                            _pushPage(context, Framework7HomePage());
                          } else {
                            Navigator.pop(context); // Tutup drawer
                          }
                        },
                        child: _DrawerItem(
                          icon: Icons.grid_view,
                          label: 'Elements',
                          highlighted: currentRoute == '/elements_page',
                        ),
                      ),

                      // 8. SETTING
                      GestureDetector(
                        onTap: () {
                          if (currentRoute != '/settings') {
                            _pushPage(context, const SettingPage());
                          } else {
                            Navigator.pop(context); // Tutup drawer
                          }
                        },
                        child: _DrawerItem(
                          icon: Icons.settings_outlined,
                          label: 'Setting',
                          highlighted: currentRoute == '/settings',
                        ),
                      ),

                      // 9. LOGOUT (IMPLEMENTASI LOGOUT)
                      GestureDetector(
                        onTap: () =>
                            _logout(context), // <--- PANGGIL FUNGSI LOGOUT
                        child: const _DrawerItem(
                            icon: Icons.logout, label: 'Logout'),
                      ),
                    ],
                  ),
                ),

                // === FOOTER ===
                Text(
                  'Gawee Job Portal',
                  style: GoogleFonts.poppins(
                    color: textColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'App Version 1.3',
                  style: GoogleFonts.poppins(
                    color: textColor.withOpacity(0.4),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget privat untuk setiap item di menu
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlighted;
  const _DrawerItem({
    required this.icon,
    required this.label,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final kPrimaryColor = theme.primaryColor;

    final Color kLightPurple = theme.brightness == Brightness.dark
        ? kPrimaryColor.withOpacity(0.25)
        : kPrimaryColor.withOpacity(0.1);

    final Color textColor;
    if (highlighted) {
      textColor = kPrimaryColor;
    } else if (theme.brightness == Brightness.dark) {
      textColor = Colors.white.withOpacity(0.8);
    } else {
      textColor = Colors.black.withOpacity(0.7);
    }

    // Mengubah warna teks dan ikon logout menjadi merah untuk penekanan
    final finalColor = label == 'Logout' ? Colors.red.shade600 : textColor;

    return InkWell(
      onTap: null, // onTap ditangani oleh GestureDetector di atas
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: highlighted ? kLightPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: finalColor, size: 24),
              const SizedBox(width: 14),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: finalColor,
                  fontSize: 15,
                  fontWeight: highlighted ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
