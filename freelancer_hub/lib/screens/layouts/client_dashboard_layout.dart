import 'package:flutter/material.dart';
import '../Homepages/home_screen.dart';
import '../Client/client_profile.dart';
import '../Client/client_projects.dart';
import '../Client/client_settings.dart';
import '../Client/client_messages.dart';
import '../Client/client_dashboard.dart';
import '../Client/client_post_job.dart';
import '../../services/auth_service.dart';

class ClientDashboardLayout extends StatefulWidget {
  final Widget content;
  final String title;
  final String userRole;
  final String userName;
  final int initialSelectedIndex;

  const ClientDashboardLayout({
    super.key,
    required this.content,
    required this.title,
    required this.userRole,
    required this.userName,
    this.initialSelectedIndex = 0,
  });

  @override
  State<ClientDashboardLayout> createState() => _ClientDashboardLayoutState();
}

class _ClientDashboardLayoutState extends State<ClientDashboardLayout> {
  bool _isSidebarCollapsed = false;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Color(0xFF6C63FF),
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Logout Confirmation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Clear the user state before navigating
                      final authService = AuthService();
                      await authService.signOut();
                      if (mounted) {
                        Navigator.pop(context); // Close dialog
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false, // Remove all previous routes
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index == _selectedIndex) return; // Don't navigate if already on the page

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ClientDashboard(),
          ),
        );
        break;
      case 1: // Profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ClientProfile(selectedIndex: index),
          ),
        );
        break;
      case 2: // Projects
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ClientProjects(selectedIndex: index),
          ),
        );
        break;
      case 3: // Messages
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ClientMessages(selectedIndex: index),
          ),
        );
        break;
      case 4: // Settings
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ClientSettings(selectedIndex: index),
          ),
        );
        break;
      case 6: // Post Job
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ClientPostJob(selectedIndex: index),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: Row(
          children: [
            // Sidebar
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              width: _isSidebarCollapsed ? 80 : 280,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: OverflowBox(
                maxWidth: double.infinity,
                alignment: Alignment.centerLeft,
                child: ClipRect(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      width: _isSidebarCollapsed ? 80 : 280,
                      child: Column(
                        children: [
                          // Logo and Collapse Button
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: _isSidebarCollapsed 
                                  ? MainAxisAlignment.center 
                                  : MainAxisAlignment.spaceBetween,
                              children: [
                                if (!_isSidebarCollapsed) ...[
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF6C63FF).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.work_outline,
                                          color: Color(0xFF6C63FF),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'FreelancerHub',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isSidebarCollapsed = !_isSidebarCollapsed;
                                    });
                                  },
                                  icon: Icon(
                                    _isSidebarCollapsed 
                                        ? Icons.chevron_right 
                                        : Icons.chevron_left,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.white12),
                          // Navigation Items
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              children: [
                                _buildNavItem(
                                  icon: Icons.dashboard,
                                  title: 'Dashboard',
                                  index: 0,
                                  onTap: () => _handleNavigation(0),
                                ),
                                _buildNavItem(
                                  icon: Icons.person,
                                  title: 'Profile',
                                  index: 1,
                                  onTap: () => _handleNavigation(1),
                                ),
                                _buildNavItem(
                                  icon: Icons.work,
                                  title: 'Projects',
                                  index: 2,
                                  onTap: () => _handleNavigation(2),
                                ),
                                _buildNavItem(
                                  icon: Icons.post_add,
                                  title: 'Post a Job',
                                  index: 6,
                                  onTap: () => _handleNavigation(6),
                                ),
                                _buildNavItem(
                                  icon: Icons.message,
                                  title: 'Messages',
                                  index: 3,
                                  onTap: () => _handleNavigation(3),
                                ),
                                _buildNavItem(
                                  icon: Icons.settings,
                                  title: 'Settings',
                                  index: 4,
                                  onTap: () => _handleNavigation(4),
                                ),
                                _buildNavItem(
                                  icon: Icons.logout,
                                  title: 'Logout',
                                  index: 5,
                                  onTap: () => _showLogoutConfirmationDialog(context),
                                ),
                              ],
                            ),
                          ),
                          // User Profile Section
                          Container(
                            padding: EdgeInsets.all(_isSidebarCollapsed ? 8 : 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: EdgeInsets.all(_isSidebarCollapsed ? 8 : 16),
                            child: Row(
                              mainAxisAlignment: _isSidebarCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Color(0xFF6C63FF),
                                    size: 24,
                                  ),
                                ),
                                if (!_isSidebarCollapsed) ...[
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.userName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          widget.userRole,
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Main Content Area
            Expanded(
              child: Column(
                children: [
                  // Top Navigation Bar
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            // Search Bar
                            Container(
                              width: 300,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.search, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      style: const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: 'Search...',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Notifications
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications, color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            // Messages
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.message, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Main Content
                  Expanded(
                    child: widget.content,
                  ),
                  // Footer
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '© 2024 FreelancerHub. All rights reserved.',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Terms of Service',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
    Function()? onTap,
  }) {
    bool isSelected = _selectedIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _isSidebarCollapsed ? 8 : 16,
            vertical: 12,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: _isSidebarCollapsed ? 8 : 16,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6C63FF).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: _isSidebarCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF6C63FF) : Colors.white,
                size: 20,
              ),
              if (!_isSidebarCollapsed) ...[
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF6C63FF) : Colors.white,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
} 