import 'package:flutter/material.dart';
import '../../../core/widgets/section_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const SectionHeader(title: 'Account'),
            const SizedBox(height: 16),
            _buildSettingsItem(
              context,
              'Profile Details',
              Icons.person_outline,
            ),
            _buildSettingsItem(
              context,
              'Sync & Backup',
              Icons.cloud_sync_outlined,
              trailing: const Text(
                'Guest',
                style: TextStyle(
                  color: Color(0xFF8B3DFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Focus Mode'),
            const SizedBox(height: 16),
            _buildSettingsItem(
              context,
              'Strict Blocking',
              Icons.block_outlined,
              hasSwitch: true,
              switchValue: true,
            ),
            _buildSettingsItem(
              context,
              'Whitelist Apps',
              Icons.list_alt_outlined,
            ),
            _buildSettingsItem(
              context,
              'Break Intervals',
              Icons.timer_outlined,
              trailing: Text(
                '5 min',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'General'),
            const SizedBox(height: 16),
            _buildSettingsItem(
              context,
              'Notifications',
              Icons.notifications_none_outlined,
            ),
            _buildSettingsItem(context, 'About StayZone', Icons.info_outline),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Delete Account',
                style: TextStyle(color: Color(0xFFE11D48)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData icon, {
    Widget? trailing,
    bool hasSwitch = false,
    bool switchValue = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: hasSwitch
            ? Switch(
                value: switchValue,
                onChanged: (_) {},
                activeColor: const Color(0xFF8B3DFF),
              )
            : (trailing ?? const Icon(Icons.chevron_right, color: Colors.grey)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
