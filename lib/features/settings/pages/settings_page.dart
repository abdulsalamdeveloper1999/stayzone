import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../core/routes/app_router.dart';

import '../../../core/utils/level_utils.dart';
import '../../../core/utils/string_extensions.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../../home/presentation/cubit/home_cubit.dart';
import '../../home/presentation/cubit/home_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0C14),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.router.replaceAll([const LoginRoute()]);
          }
        },
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;
          final name = (user?.name ?? 'The Monk').capitalize;
          final email = user?.email ?? '';
          final level = user != null
              ? LevelUtils.getTitle(user.totalFocusMinutes)
              : 'Novice';
          final minutes = user?.totalFocusMinutes ?? 0;

          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: Color(0xFF0D0C14),
                expandedHeight: 60,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                  title: Text('Profile', style: TextStyle(color: Colors.white)),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Profile Header
                      _buildProfileHeader(name, email, level),
                      const SizedBox(height: 32),

                      // Stats
                      _buildStatsRow(minutes),
                      const SizedBox(height: 32),

                      // Settings Groups
                      _buildSectionHeader('ACCOUNT'),
                      _buildSettingsGroup(
                        children: [
                          _buildSettingsTile(
                            icon: CupertinoIcons.person_solid,
                            iconColor: Colors.blue,
                            title: 'Personal Details',
                            onTap: () {
                              context.router.push(const EditProfileRoute());
                            },
                          ),
                          _buildDivider(),
                          _buildSettingsTile(
                            icon: CupertinoIcons.bell_solid,
                            iconColor: Colors.red,
                            title: 'Notifications',
                            onTap: () {
                              context.router.push(const NotificationsRoute());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      _buildSettingsGroup(
                        children: [
                          _buildSettingsTile(
                            icon: CupertinoIcons.arrow_right_circle_fill,
                            iconColor: Colors.grey,
                            title: 'Log Out',
                            titleColor: CupertinoColors.destructiveRed,
                            showChevron: false,
                            onTap: () {
                              context.read<AuthBloc>().add(
                                AuthLogoutRequested(),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildSettingsTile(
                            icon: CupertinoIcons.trash_fill,
                            iconColor: CupertinoColors.destructiveRed,
                            title: 'Delete Account',
                            titleColor: CupertinoColors.destructiveRed,
                            showChevron: false,
                            onTap: () => _showDeleteConfirmation(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'StayZone v1.0.0',
                        style: TextStyle(
                          color: Colors.grey.withValues(alpha: 0.5),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(String name, String email, String level) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1D1B26),
            border: Border.all(color: const Color(0xFF2C2C2E), width: 1),
          ),
          child: const Center(
            child: Icon(
              CupertinoIcons.person_fill,
              size: 40,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(email, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF8B3DFF).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF8B3DFF).withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Text(
            level.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8B3DFF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(int totalMinutes) {
    final hours = (totalMinutes / 60).toStringAsFixed(1);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _buildStatItem(
                'Total Focus',
                '$hours hrs',
                CupertinoIcons.time,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatItem(
                'Streak',
                '${state.userStreak} days',
                CupertinoIcons.flame,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    Color titleColor = Colors.white,
    Widget? trailing,
    bool showChevron = true,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(child: Icon(icon, color: Colors.white, size: 20)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: titleColor, fontSize: 16),
                ),
              ),
              if (trailing != null) trailing,
              if (showChevron) ...[
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 64,
      color: Color(0xFF2C2C2E),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permitted lost.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(AuthDeleteAccountRequested());
            },
          ),
        ],
      ),
    );
  }
}
