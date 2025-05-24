import 'package:flutter/material.dart';
import '../layouts/freelancer_dashboard_layout.dart';

class FreelancerSettings extends StatefulWidget {
  final int selectedIndex;

  const FreelancerSettings({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<FreelancerSettings> createState() => _FreelancerSettingsState();
}

class _FreelancerSettingsState extends State<FreelancerSettings> {
  @override
  Widget build(BuildContext context) {
    return FreelancerDashboardLayout(
      title: 'Settings',
      userRole: 'Freelancer',
      userName: 'John Doe',
      initialSelectedIndex: widget.selectedIndex,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Settings
            _buildSection(
              'Account Settings',
              [
                _buildSettingItem(
                  'Profile Information',
                  'Update your personal information and profile details',
                  Icons.person,
                  () {},
                ),
                _buildSettingItem(
                  'Security',
                  'Manage your password and security settings',
                  Icons.security,
                  () {},
                ),
                _buildSettingItem(
                  'Notifications',
                  'Configure your notification preferences',
                  Icons.notifications,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Payment Settings
            _buildSection(
              'Payment Settings',
              [
                _buildSettingItem(
                  'Payment Methods',
                  'Manage your payment methods and billing information',
                  Icons.payment,
                  () {},
                ),
                _buildSettingItem(
                  'Payout Settings',
                  'Configure your payout preferences and schedule',
                  Icons.account_balance_wallet,
                  () {},
                ),
                _buildSettingItem(
                  'Transaction History',
                  'View your payment and earnings history',
                  Icons.history,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Preferences
            _buildSection(
              'Preferences',
              [
                _buildSettingItem(
                  'Language',
                  'English (US)',
                  Icons.language,
                  () {},
                ),
                _buildSettingItem(
                  'Theme',
                  'Dark Mode',
                  Icons.dark_mode,
                  () {},
                ),
                _buildSettingItem(
                  'Time Zone',
                  'UTC-05:00 (Eastern Time)',
                  Icons.access_time,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Danger Zone
            _buildSection(
              'Danger Zone',
              [
                _buildSettingItem(
                  'Delete Account',
                  'Permanently delete your account and all data',
                  Icons.delete_forever,
                  () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFF2D2D2D),
                        title: const Text(
                          'Delete Account',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: const Text(
                          'Are you sure you want to delete your account? This action cannot be undone.',
                          style: TextStyle(color: Colors.white70),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Implement account deletion
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  isDanger: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(color: Colors.white12),
          ...items,
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String subtitle, IconData icon, VoidCallback onTap, {bool isDanger = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDanger
                    ? Colors.red.withOpacity(0.1)
                    : const Color(0xFF6C63FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isDanger ? Colors.red : const Color(0xFF6C63FF),
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
                    style: TextStyle(
                      color: isDanger ? Colors.red : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }
} 