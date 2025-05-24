import 'package:flutter/material.dart';
import '../layouts/dashboard_layout.dart';

class ClientSettings extends StatelessWidget {
  final int selectedIndex;

  const ClientSettings({
    super.key,
    this.selectedIndex = 4, // Default to settings index
  });

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Settings',
      userRole: 'Client',
      userName: 'John Doe',
      initialSelectedIndex: selectedIndex,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Settings Section
            Text(
              'Account Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildSettingsItem(
                'Personal Information',
                'Update your personal details and contact information',
                Icons.person_outline,
                () {},
              ),
              _buildDivider(),
              _buildSettingsItem(
                'Security',
                'Manage your password and security settings',
                Icons.security,
                () {},
              ),
              _buildDivider(),
              _buildSettingsItem(
                'Notifications',
                'Configure your notification preferences',
                Icons.notifications_outlined,
                () {},
              ),
            ]),
            const SizedBox(height: 32),
            // Preferences Section
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildSettingsItem(
                'Language',
                'English (US)',
                Icons.language,
                () {},
                showArrow: true,
              ),
              _buildDivider(),
              _buildSettingsItem(
                'Theme',
                'Dark Mode',
                Icons.dark_mode,
                () {},
                showArrow: true,
              ),
              _buildDivider(),
              _buildSettingsItem(
                'Currency',
                r'USD ($)',
                Icons.attach_money,
                () {},
                showArrow: true,
              ),
            ]),
            const SizedBox(height: 32),
            // Billing Section
            Text(
              'Billing & Payments',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildSettingsItem(
                'Payment Methods',
                'Manage your payment methods and billing information',
                Icons.payment,
                () {},
              ),
              _buildDivider(),
              _buildSettingsItem(
                'Billing History',
                'View your past transactions and invoices',
                Icons.history,
                () {},
              ),
              _buildDivider(),
              _buildSettingsItem(
                'Tax Information',
                'Update your tax details and documents',
                Icons.description_outlined,
                () {},
              ),
            ]),
            const SizedBox(height: 32),
            // Danger Zone Section
            Text(
              'Danger Zone',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildSettingsItem(
                'Delete Account',
                'Permanently delete your account and all data',
                Icons.delete_forever,
                () {},
                textColor: Colors.red,
                iconColor: Colors.red,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool showArrow = false,
    Color? textColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (iconColor ?? const Color(0xFF6C63FF)).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor ?? const Color(0xFF6C63FF),
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
                      color: textColor ?? Colors.white,
                      fontSize: 16,
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
            if (showArrow)
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.1),
      height: 1,
    );
  }
} 