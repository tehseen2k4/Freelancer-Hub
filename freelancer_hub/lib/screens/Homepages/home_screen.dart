import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';
import '../Client/client_dashboard.dart';
import '../Freelancer/freelancer_dashboard.dart';
import '../Admin/admin_dashboard.dart';
import 'find_work_screen.dart';
import 'find_talent_screen.dart';
import '../../models/client_profile.dart';
import '../../models/freelancer_profile.dart';
import '../../services/profile_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = _authService.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ModernNavbar(
          currentUser: _currentUser,
          onUserChanged: (user) {
            setState(() {
              _currentUser = user;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section with Animated Background
            Container(
              height: 700,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2D2D2D),
                    const Color(0xFF1A1A1A),
                    const Color(0xFF6C63FF).withOpacity(0.1),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Animated Background Pattern
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: CustomPaint(
                        painter: PatternPainter(),
                      ),
                    ),
                  ),
                  // Floating Elements
                  Positioned(
                    right: -100,
                    top: 100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Find Your Dream\nFreelance Projects',
                                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Connect with top clients and work on exciting projects from anywhere in the world.',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey[400],
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  // Stats Row
                                  Row(
                                    children: [
                                      _buildStatItem('10K+', 'Active Projects'),
                                      const SizedBox(width: 32),
                                      _buildStatItem('5K+', 'Freelancers'),
                                      const SizedBox(width: 32),
                                      _buildStatItem('2K+', 'Clients'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 40),
                            // Hero Image or Illustration
                            Expanded(
                              child: Container(
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.work_outline,
                                    size: 100,
                                    color: Color(0xFF6C63FF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Search Bar
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 24),
                              const Icon(Icons.search, color: Colors.grey),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Search for projects...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                margin: const EdgeInsets.only(right: 8),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6C63FF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text('Search Projects'),
                                ),
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
            // Featured Projects Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Featured Projects',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Discover the most exciting projects',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: const Icon(Icons.work, color: Colors.white),
                        label: const Text(
                          'View All Projects',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 320,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildProjectCard(
                          'E-commerce Website Development',
                          'Web Development',
                          '\$2,500 - \$3,500',
                          '4.9',
                          '12 proposals',
                          '2 days ago',
                        ),
                        _buildProjectCard(
                          'Mobile App UI/UX Design',
                          'UI/UX Design',
                          '\$1,500 - \$2,000',
                          '4.8',
                          '8 proposals',
                          '1 day ago',
                        ),
                        _buildProjectCard(
                          'Content Writing for Blog',
                          'Writing',
                          '\$500 - \$1,000',
                          '4.7',
                          '15 proposals',
                          '3 days ago',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Top Freelancers Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top Freelancers',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Find the best talent for your projects',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: const Icon(Icons.people, color: Colors.white),
                        label: const Text(
                          'View All Freelancers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 380,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFreelancerCard(
                          'Sarah Johnson',
                          'UI/UX Designer',
                          '4.9',
                          '\$45/hr',
                          '5 years exp.',
                        ),
                        _buildFreelancerCard(
                          'Mike Chen',
                          'Web Developer',
                          '4.8',
                          '\$50/hr',
                          '7 years exp.',
                        ),
                        _buildFreelancerCard(
                          'Emma Wilson',
                          'Content Writer',
                          '4.9',
                          '\$35/hr',
                          '4 years exp.',
                        ),
                        _buildFreelancerCard(
                          'David Kim',
                          'Mobile Developer',
                          '4.7',
                          '\$55/hr',
                          '6 years exp.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Categories Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Popular Categories',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Browse projects by category',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 1.2,
                    children: [
                      _buildCategoryCard('Web Development', Icons.code, '1.2k projects'),
                      _buildCategoryCard('Mobile Apps', Icons.phone_android, '800 projects'),
                      _buildCategoryCard('UI/UX Design', Icons.design_services, '1.5k projects'),
                      _buildCategoryCard('Writing', Icons.edit, '900 projects'),
                      _buildCategoryCard('Marketing', Icons.trending_up, '700 projects'),
                      _buildCategoryCard('Data Science', Icons.analytics, '600 projects'),
                      _buildCategoryCard('Video Editing', Icons.video_library, '500 projects'),
                      _buildCategoryCard('Translation', Icons.translate, '400 projects'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF6C63FF),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(String title, String category, String budget, String rating, String proposals, String timeAgo) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: Color(0xFF6C63FF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  budget,
                  style: const TextStyle(
                    color: Color(0xFF6C63FF),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  proposals,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey[400], size: 16),
                const SizedBox(width: 4),
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFreelancerCard(String name, String title, String rating, String rate, String experience) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile section
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    border: Border.all(
                      color: const Color(0xFF6C63FF).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Stats section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rating',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      rate,
                      style: const TextStyle(
                        color: Color(0xFF6C63FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rate',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      experience,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Experience',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Action button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Hire Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, String projectCount) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF6C63FF), size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              projectCount,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModernNavbar extends StatefulWidget {
  const ModernNavbar({super.key, required this.currentUser, required this.onUserChanged});

  final UserModel? currentUser;
  final Function(UserModel?) onUserChanged;

  @override
  State<ModernNavbar> createState() => _ModernNavbarState();
}

class _ModernNavbarState extends State<ModernNavbar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleLogin(String role) {
    final userRole = role == 'client' ? UserRole.client : UserRole.freelancer;
    
    widget.onUserChanged(UserModel(
      uid: 'temp_uid', // This will be replaced with actual Firebase UID
      email: 'temp@email.com', // This will be replaced with actual email
      role: userRole,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    ));
    
    // Navigate to the appropriate dashboard based on role
    switch (role) {
      case 'client':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ClientDashboard(),
          ),
        );
        break;
      case 'freelancer':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FreelancerDashboard(),
          ),
        );
        break;
    }
  }

  void _navigateToFindWork() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindWorkScreen()),
    );
  }

  void _navigateToFindTalent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindTalentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A).withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {},
                child: Row(
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Navigation Items based on user role
            if (widget.currentUser == null) ...[
              // Public navigation
              Row(
                children: [
                  _buildNavItem('Home', 0, () {}),
                  _buildNavItem('Find Work', 1, _navigateToFindWork),
                  _buildNavItem('Find Talent', 2, _navigateToFindTalent),
                  _buildNavItem('About Us', 3, () {}),
                ],
              ),
            ] else ...[
              // User navigation based on role
              Row(
                children: [
                  _buildNavItem('Dashboard', 0, () {}),
                  if (widget.currentUser!.role == UserRole.client) ...[
                    _buildNavItem('Post Job', 1, () {}),
                    _buildNavItem('My Jobs', 2, () {}),
                  ] else ...[
                    _buildNavItem('Find Work', 1, _navigateToFindWork),
                    _buildNavItem('My Proposals', 2, () {}),
                  ],
                  _buildNavItem('Messages', 3, () {}),
                ],
              ),
            ],
            // Auth Buttons or User Profile
            if (widget.currentUser == null) ...[
              Row(
                children: [
                  _buildLoginButton(),
                  const SizedBox(width: 16),
                  _buildSignUpButton(),
                ],
              ),
            ] else ...[
              _buildUserProfile(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Show profile menu
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6C63FF).withOpacity(0.2),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF6C63FF),
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.currentUser!.role == UserRole.client ? 'Client' : 'Freelancer',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int index, VoidCallback onTap) {
    bool isSelected = _controller.value.floor() == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _controller.forward(from: 0);
          if (title == 'Find Work') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FindWorkScreen()),
            );
          } else {
            onTap();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6C63FF).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF6C63FF) : Colors.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF6C63FF),
                  size: 12,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showRoleSelectionDialog(BuildContext context, bool isLogin) {
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
              Text(
                isLogin ? 'Welcome Back!' : 'Join FreelancerHub',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isLogin ? 'Choose your account type' : 'Select how you want to work',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              _buildRoleCard(
                context,
                'Client',
                'Hire talented freelancers for your projects',
                Icons.business,
                'client',
                isLogin,
              ),
              const SizedBox(height: 16),
              _buildRoleCard(
                context,
                'Freelancer',
                'Find work and grow your career',
                Icons.work,
                'freelancer',
                isLogin,
              ),
              if (isLogin) ...[
                const SizedBox(height: 16),
                _buildRoleCard(
                  context,
                  'Admin',
                  'Manage platform operations',
                  Icons.admin_panel_settings,
                  'admin',
                  isLogin,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showLoginForm(BuildContext context, String role) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isPasswordVisible = false;

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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with role icon and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            role == 'client' ? Icons.business :
                            role == 'freelancer' ? Icons.work :
                            Icons.admin_panel_settings,
                            color: const Color(0xFF6C63FF),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Login as ${role.toUpperCase()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Welcome message
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                // Email field
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[700]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1A1A1A),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password field
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(color: Colors.white),
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[400],
                      ),
                      onPressed: () {
                        isPasswordVisible = !isPasswordVisible;
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[700]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1A1A1A),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                // Remember me and forgot password row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {
                            // TODO: Implement remember me functionality
                          },
                          activeColor: const Color(0xFF6C63FF),
                          checkColor: Colors.white,
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password functionality
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: const Color(0xFF6C63FF),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // TODO: Implement actual login logic here
                        Navigator.pop(context);
                        _handleLogin(role);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showRoleSelectionDialog(context, false);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 14,
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
      ),
    );
  }

  void _showSignupForm(BuildContext context, String role) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isPasswordVisible = false;
    bool isConfirmPasswordVisible = false;
    bool isLoading = false;
    final AuthService _authService = AuthService();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 500,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: const EdgeInsets.all(32),
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
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with role icon and close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C63FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                role == 'client' ? Icons.business :
                                role == 'freelancer' ? Icons.work :
                                Icons.admin_panel_settings,
                                color: const Color(0xFF6C63FF),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Sign Up as ${role.toUpperCase()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Welcome message
                    Text(
                      'Create your account',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Email field
                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF1A1A1A),
                        errorStyle: const TextStyle(color: Colors.redAccent),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password field
                    TextFormField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF1A1A1A),
                        errorStyle: const TextStyle(color: Colors.redAccent),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Confirm Password field
                    TextFormField(
                      controller: confirmPasswordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: !isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible = !isConfirmPasswordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF1A1A1A),
                        errorStyle: const TextStyle(color: Colors.redAccent),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // Sign up button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              print('Starting registration process...');
                              print('Email: ${emailController.text}');
                              print('Role: $role');
                              
                              final userRole = role == 'client' ? UserRole.client : UserRole.freelancer;
                              print('Converted role: $userRole');
                              
                              print('Calling registerWithEmailAndPassword...');
                              final user = await _authService.registerWithEmailAndPassword(
                                emailController.text,
                                passwordController.text,
                                userRole,
                              );
                              print('Registration successful! User ID: ${user.uid}');
                              
                              if (mounted) {
                                Navigator.pop(context);
                                _showProfileCreationForm(context, role);
                              }
                            } catch (e, stackTrace) {
                              print('Registration error occurred:');
                              print('Error: $e');
                              print('Stack trace: $stackTrace');
                              
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Registration failed: ${e.toString()}'),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 5),
                                    action: SnackBarAction(
                                      label: 'Dismiss',
                                      textColor: Colors.white,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      },
                                    ),
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showRoleSelectionDialog(context, true);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFF6C63FF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Temporary bypass button for testing
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showProfileCreationForm(context, role);
                      },
                      child: Text(
                        'Skip to Profile Form (Testing)',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
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

  void _showProfileCreationForm(BuildContext context, String role) {
    final formKey = GlobalKey<FormState>();
    int currentStep = 0;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController bioController = TextEditingController();
    
    // Client specific controllers
    final TextEditingController companyNameController = TextEditingController();
    final TextEditingController companySizeController = TextEditingController();
    final TextEditingController industryController = TextEditingController();
    final TextEditingController websiteController = TextEditingController();
    
    // Freelancer specific controllers
    final TextEditingController titleController = TextEditingController();
    final TextEditingController experienceController = TextEditingController();
    final TextEditingController hourlyRateController = TextEditingController();
    
    // Skills selection
    final List<String> availableSkills = [
      'Flutter', 'Dart', 'React', 'Node.js', 'Python', 'Java', 'JavaScript',
      'TypeScript', 'HTML', 'CSS', 'UI/UX Design', 'Mobile Development',
      'Web Development', 'Database Design', 'DevOps', 'Cloud Computing',
      'Machine Learning', 'Data Science', 'Project Management', 'Agile'
    ];
    final List<String> selectedSkills = [];
    
    // Services
    final ProfileService _profileService = ProfileService();
    final AuthService _authService = AuthService();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 500,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: const EdgeInsets.all(32),
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
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with role icon and close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C63FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                role == 'client' ? Icons.business :
                                role == 'freelancer' ? Icons.work :
                                Icons.admin_panel_settings,
                                color: const Color(0xFF6C63FF),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Complete Your Profile',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Progress indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStepIndicator(context, 1, 'Personal Info', currentStep >= 0),
                        _buildStepConnector(context, currentStep > 0),
                        _buildStepIndicator(context, 2, role == 'client' ? 'Company Info' : 'Professional Info', currentStep >= 1),
                        if (role == 'client') ...[
                          _buildStepConnector(context, currentStep > 1),
                          _buildStepIndicator(context, 3, 'Additional Info', currentStep >= 2),
                        ],
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Form steps
                    if (currentStep == 0) ...[
                      // Personal Information Step
                      TextFormField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[700]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[700]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.phone_outlined, color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[700]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: locationController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Location',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.location_on_outlined, color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[700]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your location';
                          }
                          return null;
                        },
                      ),
                    ] else if (currentStep == 1) ...[
                      if (role == 'client') ...[
                        // Company Information Step for Client
                        TextFormField(
                          controller: companyNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Company Name',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(Icons.business, color: Colors.grey[400]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1A1A1A),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter company name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: companySizeController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Company Size',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(Icons.people_outline, color: Colors.grey[400]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1A1A1A),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter company size';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: industryController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Industry',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(Icons.work_outline, color: Colors.grey[400]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1A1A1A),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter industry';
                            }
                            return null;
                          },
                        ),
                      ] else ...[
                        // Professional Information Step for Freelancer
                        TextFormField(
                          controller: titleController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Professional Title',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(Icons.work_outline, color: Colors.grey[400]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1A1A1A),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your professional title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Skills Selection
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Skills',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[700]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: availableSkills.map((skill) {
                                      final isSelected = selectedSkills.contains(skill);
                                      return FilterChip(
                                        label: Text(
                                          skill,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.grey[400],
                                            fontSize: 14,
                                          ),
                                        ),
                                        selected: isSelected,
                                        onSelected: (selected) {
                                          setState(() {
                                            if (selected) {
                                              selectedSkills.add(skill);
                                            } else {
                                              selectedSkills.remove(skill);
                                            }
                                          });
                                        },
                                        backgroundColor: const Color(0xFF2D2D2D),
                                        selectedColor: const Color(0xFF6C63FF),
                                        checkmarkColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          side: BorderSide(
                                            color: isSelected ? const Color(0xFF6C63FF) : Colors.grey[700]!,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  if (selectedSkills.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Please select at least one skill',
                                        style: TextStyle(
                                          color: Colors.redAccent[200],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Experience in Years
                        TextFormField(
                          controller: experienceController,
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Years of Experience',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(Icons.history, color: Colors.grey[400]),
                            suffixText: 'years',
                            suffixStyle: TextStyle(color: Colors.grey[400]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1A1A1A),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your years of experience';
                            }
                            final years = int.tryParse(value);
                            if (years == null || years < 0) {
                              return 'Please enter a valid number of years';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Hourly Rate
                        TextFormField(
                          controller: hourlyRateController,
                          style: const TextStyle(color: Colors.white),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Hourly Rate',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(Icons.attach_money, color: Colors.grey[400]),
                            suffixText: 'USD',
                            suffixStyle: TextStyle(color: Colors.grey[400]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1A1A1A),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your hourly rate';
                            }
                            final rate = double.tryParse(value);
                            if (rate == null || rate <= 0) {
                              return 'Please enter a valid hourly rate';
                            }
                            return null;
                          },
                        ),
                      ],
                    ] else if (currentStep == 2 && role == 'client') ...[
                      // Additional Information Step for Client
                      TextFormField(
                        controller: websiteController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Website',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.language, color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[700]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your website';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: bioController,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Company Bio',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.description_outlined, color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[700]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter company bio';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 32),
                    // Navigation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep > 0)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                currentStep--;
                              });
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                          )
                        else
                          const SizedBox(width: 80),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (currentStep < (role == 'client' ? 2 : 1)) {
                                setState(() {
                                  currentStep++;
                                });
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                
                                try {
                                  final now = DateTime.now();
                                  
                                  if (role == 'client') {
                                    final clientProfile = ClientProfile(
                                      uid: _authService.currentUser!.uid,
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      location: locationController.text,
                                      companyName: companyNameController.text,
                                      companySize: companySizeController.text,
                                      industry: industryController.text,
                                      website: websiteController.text,
                                      bio: bioController.text,
                                      createdAt: now,
                                      updatedAt: now,
                                    );
                                    
                                    await _profileService.createClientProfile(clientProfile);
                                  } else {
                                    final freelancerProfile = FreelancerProfile(
                                      uid: _authService.currentUser!.uid,
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      location: locationController.text,
                                      title: titleController.text,
                                      skills: selectedSkills,
                                      yearsOfExperience: int.parse(experienceController.text),
                                      hourlyRate: double.parse(hourlyRateController.text),
                                      bio: bioController.text,
                                      createdAt: now,
                                      updatedAt: now,
                                    );
                                    
                                    await _profileService.createFreelancerProfile(freelancerProfile);
                                  }
                                  
                                  if (mounted) {
                                    Navigator.pop(context);
                                    _handleLogin(role);
                                  }
                                } catch (e) {
                                  print('Error creating profile: $e');
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to create profile: ${e.toString()}'),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'Dismiss',
                                          textColor: Colors.white,
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text(
                                  'Complete Profile',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ],
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

  Widget _buildStepIndicator(BuildContext context, int step, String label, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCompleted ? const Color(0xFF6C63FF) : Colors.grey[700],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isCompleted ? const Color(0xFF6C63FF) : Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(BuildContext context, bool isCompleted) {
    return Container(
      width: 50,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: isCompleted ? const Color(0xFF6C63FF) : Colors.grey[700],
    );
  }

  Widget _buildRoleCard(BuildContext context, String title, String subtitle, IconData icon, String role, bool isLogin) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          if (isLogin) {
            _showLoginForm(context, role);
          } else {
            _showSignupForm(context, role);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF6C63FF),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF6C63FF),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showRoleSelectionDialog(context, true),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showRoleSelectionDialog(context, false),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < size.width; i += 30) {
      for (var j = 0; j < size.height; j += 30) {
        canvas.drawCircle(Offset(i.toDouble(), j.toDouble()), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 