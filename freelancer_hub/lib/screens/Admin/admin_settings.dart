import 'package:flutter/material.dart';
import '../layouts/admin_dashboard_layout.dart';

class AdminSettings extends StatelessWidget {
  final int selectedIndex;

  const AdminSettings({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AdminDashboardLayout(
      title: 'Settings',
      userRole: 'Admin',
      userName: 'Admin User',
      initialSelectedIndex: selectedIndex,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'General Settings',
              [
                _buildSettingItem(
                  'Platform Name',
                  'Change the name of your platform',
                  Icons.business,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'Platform Description',
                  'Update your platform description',
                  Icons.description,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'Contact Email',
                  'Set the contact email for support',
                  Icons.email,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'User Management',
              [
                _buildSettingItem(
                  'User Registration',
                  'Configure user registration settings',
                  Icons.person_add,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'User Verification',
                  'Set up user verification process',
                  Icons.verified_user,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'User Roles',
                  'Manage user roles and permissions',
                  Icons.admin_panel_settings,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Project Settings',
              [
                _buildSettingItem(
                  'Project Categories',
                  'Manage project categories',
                  Icons.category,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'Project Requirements',
                  'Configure project requirements',
                  Icons.assignment,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'Project Fees',
                  'Set up project fees and commissions',
                  Icons.attach_money,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Payment Settings',
              [
                _buildSettingItem(
                  'Payment Methods',
                  'Configure available payment methods',
                  Icons.payment,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'Transaction Fees',
                  'Set up transaction fees',
                  Icons.money,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'Payout Settings',
                  'Configure payout methods and schedules',
                  Icons.account_balance,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'System Settings',
              [
                _buildSettingItem(
                  'Email Templates',
                  'Customize email notifications',
                  Icons.email,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'API Keys',
                  'Manage API integrations',
                  Icons.api,
                  onTap: () {},
                ),
                _buildSettingItem(
                  'Backup & Restore',
                  'Configure system backup settings',
                  Icons.backup,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Danger Zone',
              [
                _buildSettingItem(
                  'Delete Platform',
                  'Permanently delete the platform',
                  Icons.delete_forever,
                  isDanger: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Platform'),
                        content: const Text(
                          'Are you sure you want to delete the platform? This action cannot be undone.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle platform deletion
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...items,
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    String title,
    String description,
    IconData icon, {
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDanger
                    ? Colors.red.withOpacity(0.1)
                    : const Color(0xFF6C63FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDanger ? Colors.red : const Color(0xFF6C63FF),
                size: 20,
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
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
} 