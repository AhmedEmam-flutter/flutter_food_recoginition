// file name: profile_tab.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/function/page_transitions.dart';

import 'edit_profile_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your account settings',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              _buildProfileHeader(),
              const SizedBox(height: 32),
              _buildSettingsItem(Icons.person, 'Personal Information', context),
              _buildSettingsItem(Icons.notifications, 'Notifications', context),
              _buildSettingsItem(Icons.lock, 'Privacy & Security', context),
              _buildSettingsItem(Icons.help, 'Help & Support', context),
              _buildSettingsItem(Icons.info, 'About App', context),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        page: const EditProfileScreen(),
                        routeType: RouteType.slideUp,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF42E87F), // اللون الأخضر
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33),
                    ),
                  ),
                  child: const Text(
                    'LOGOUT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF42E87F).withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF42E87F).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Color(0xFF42E87F),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'john.doe@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF42E87F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Premium Member',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF42E87F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[50],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF42E87F).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF42E87F),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          _handleSettingsTap(title, context);
        },
      ),
    );
  }

  void _handleSettingsTap(String title, BuildContext context) {
    switch (title) {
      case 'Personal Information':
        Navigator.push(
          context,
          CustomPageRoute(
            page: const EditProfileScreen(),
            routeType: RouteType.slideUp,
          ),
        );
        break;
      case 'Notifications':
        _showComingSoon(context);
        break;
      case 'Privacy & Security':
        _showComingSoon(context);
        break;
      case 'Help & Support':
        _showComingSoon(context);
        break;
      case 'About App':
        _showAboutDialog(context);
        break;
    }
  }

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content:
            const Text('This feature will be available in the next update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF42E87F)),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Food Recognition'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Food Recognition helps you track your nutrition by scanning and identifying food items. Get detailed nutritional information and maintain a healthy diet.',
            ),
            SizedBox(height: 16),
            Text(
              '© 2024 Food Recognition App. All rights reserved.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CLOSE',
              style: TextStyle(color: Color(0xFF42E87F)),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _performLogout(context);
            },
            child: const Text(
              'LOGOUT',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _performLogout(BuildContext context) {
    // TODO: Implement logout logic
    // Clear user data, tokens, etc.

    // Show logout success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logged out successfully'),
        backgroundColor: Color(0xFF42E87F),
      ),
    );

    // Navigate to login screen or home
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginScreen()),
    //   (route) => false,
    // );
  }
}
