// lib/features/recent_job/screens/job_detail_page.dart

import 'package:flutter/material.dart';
import 'our_gallery_page.dart';
import 'submission_page.dart';

// Import Custom Drawer Anda
import '../../../widgets/custom_drawer.dart';

class JobDetailScreen extends StatefulWidget {
  final Map<String, String> job;

  const JobDetailScreen({required this.job, super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Perlu TabController agar kita bisa menambahkan listener
  late TabController _tabController;

  // Status untuk mencegah navigasi berulang jika sudah di halaman galeri
  bool _isNavigatingToGallery = false;

  final List<Map<String, String>> galleryImages = const [
    // KRITIS: Pastikan path ini benar (termasuk subfolder 'images')
    {
      'url': 'assets/images/image1.png',
      'caption': 'Amazing beach in Goa, India'
    },
    // ... (Data gambar lainnya)
    {
      'url': 'assets/images/image2.png',
      'caption': 'I met this dog in Bali housing complex',
    },
    {
      'url': 'assets/images/image3.png',
      'caption': 'Beautiful mountains in Zhangjiajie, China',
    },
    {
      'url': 'assets/images/image4.png',
      'caption': 'I met this monkey in Chinese mountains',
    },
    {
      'url': 'assets/images/image5.png',
      'caption': 'Beautiful mountains in Zhangjiajie, China',
    },
  ];

  // State untuk menyimpan status bookmark
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi TabController dengan SingleTickerProviderStateMixin
    _tabController = TabController(length: 2, vsync: this);

    // Tambahkan listener untuk mendeteksi perubahan tab
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    // Tab Index 1 adalah 'Our Gallery'
    if (_tabController.index == 1 && !_tabController.indexIsChanging) {
      if (!_isNavigatingToGallery) {
        _isNavigatingToGallery = true;

        // Navigasi ke halaman OurGalleryScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OurGalleryScreen(images: galleryImages),
          ),
        ).then((_) {
          // Ketika OurGalleryScreen ditutup, reset status dan kembali ke Tab 0
          _isNavigatingToGallery = false;
          // Setel ulang ke tab Job Description (indeks 0)
          _tabController.index = 0;
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  // Helper method untuk membuat Chip jenis pekerjaan (Tidak Berubah)
  Widget _buildJobTypeChip(BuildContext context, String label, bool isPrimary) {
    // ... (Logika Chip) ...
    return Chip(
      label: Text(label),
      backgroundColor:
          isPrimary ? Colors.deepPurple.shade50 : Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isPrimary ? Colors.deepPurple : Colors.black87,
        fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: isPrimary
            ? const BorderSide(color: Colors.deepPurple, width: 1.5)
            : BorderSide.none,
      ),
    );
  }

  // LOGIKA BARU: Helper untuk mendapatkan path logo berdasarkan JUDUL pekerjaan (Diasumsikan sama dengan RecentJobScreen)
  String _getLogoPath(String jobTitle) {
    if (jobTitle.contains('Graphic Designer')) {
      return 'assets/images/logo 1.png';
    } else if (jobTitle.contains('Junior Software Engineer')) {
      return 'assets/images/logo 3.png';
    } else if (jobTitle.contains('Software Engineer')) {
      return 'assets/images/logo 4.png';
    } else {
      return 'assets/images/logo 4.png';
    }
  }

  void _toggleBookmark() {
    setState(() {
      _isSaved = !_isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Pekerjaan disimpan!' : 'Simpan dibatalkan.'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final String logoPath = _getLogoPath(widget.job['title']!);

    // Hapus DefaultTabController wrapper di sini karena sudah ada TabController di State
    return Scaffold(
      key: _scaffoldKey,

      // DRAWER
      drawer: SizedBox(
        width: 320,
        child: Drawer(
          child: CustomDrawerBody(),
        ),
      ),

      // APPBAR
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                logoPath,
                width: 28,
                height: 28,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 28,
                    height: 28,
                    color: primaryColor.withOpacity(0.5),
                    child: const Center(
                      child:
                          Icon(Icons.business, color: Colors.white, size: 18),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.job['company'] ?? 'Cosax Studios',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              }),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ... (Chip dan Detail Posisi tidak berubah) ...

          // Bagian Chip FULLTIME dan CONTRACT
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                _buildJobTypeChip(context, 'FULLTIME', true),
                const SizedBox(width: 8),
                _buildJobTypeChip(context, 'CONTRACT', false),
              ],
            ),
          ),

          // Detail Posisi, Lokasi, dan Gaji
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  widget.job['location']!,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      widget.job['salary']!,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Salary range (monthly)',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab Bar
          TabBar(
            controller: _tabController, // Hubungkan controller yang baru
            labelColor: primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primaryColor,
            tabs: const [
              Tab(text: 'Job Description'),
              // Tab ini akan kosong karena navigasi ditangani oleh listener
              Tab(text: 'Our Gallery'),
            ],
          ),

          // Konten Tab: Tab kedua diisi dengan widget kosong
          Expanded(
            child: TabBarView(
              controller: _tabController, // Hubungkan controller yang baru
              children: [
                // Tab 1: Job Description
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: JobDescriptionContent(primaryColor: primaryColor),
                ),
                // Tab 2: HANYA PLACEHOLDER KOSONG (Navigasi ditangani di Listener)
                const SizedBox.expand(),
              ],
            ),
          ),

          // Bottom Action Bar: Simpan dan Apply Job (Tidak Berubah)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Tombol Simpan
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.deepPurple, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                    onPressed: _toggleBookmark,
                  ),
                ),
                const SizedBox(width: 16),

                // Tombol APPLY JOB
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return SubmissionPage(primaryColor: primaryColor);
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'APPLY JOB',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Konten Job Description (Tidak Berubah) ---
class JobDescriptionContent extends StatelessWidget {
  final Color primaryColor;

  const JobDescriptionContent({required this.primaryColor, super.key});
  // ... (build method dan _buildRequirementItem tidak berubah) ...
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job Description',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
        ),
        const SizedBox(height: 10),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),
        Text(
          'Requirements',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
        ),
        const SizedBox(height: 10),
        const Text(
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
        _buildRequirementItem('Sed ut perspiciatis unde omnis', primaryColor),
        _buildRequirementItem('Doloremque laudantium', primaryColor),
        _buildRequirementItem('Ipsa quae ab illo inventore', primaryColor),
        _buildRequirementItem('Architecto beatae vitae dicta', primaryColor),
        _buildRequirementItem('Sunt explicabo', primaryColor),
      ],
    );
  }

  Widget _buildRequirementItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
