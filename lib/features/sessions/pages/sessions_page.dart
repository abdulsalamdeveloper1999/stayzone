import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';
import '../../../core/di/injection.dart';
import '../../../core/widgets/section_header.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../../focus/domain/entities/focus_session.dart';
import '../presentation/cubit/sessions_cubit.dart';
import '../presentation/cubit/sessions_state.dart';

@RoutePage()
class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is! AuthAuthenticated) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF8B3DFF)),
            ),
          );
        }

        final userId = authState.user.id;

        return BlocProvider(
          create: (context) => getIt<SessionsCubit>()..loadSessions(userId),
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Session History',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: BlocBuilder<SessionsCubit, SessionsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF8B3DFF)),
                  );
                }

                if (state.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context
                              .read<SessionsCubit>()
                              .loadSessions(userId),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.sessions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_outlined,
                          size: 64,
                          color: Colors.white.withOpacity(0.1),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No sessions yet',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Complete a focus session to see it here.',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final groupedSessions = _groupSessions(state.sessions);

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<SessionsCubit>().refreshSessions(userId),
                  color: const Color(0xFF8B3DFF),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24.0),
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: groupedSessions.length,
                    itemBuilder: (context, index) {
                      final group = groupedSessions[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SectionHeader(title: group.title),
                          const SizedBox(height: 16),
                          ...group.sessions.map((session) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: _buildSessionCard(context, session),
                            );
                          }),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  List<_SessionGroup> _groupSessions(List<FocusSessionEntity> sessions) {
    final Map<String, List<FocusSessionEntity>> groups = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final session in sessions) {
      if (session.completedAt == null) continue;

      final date = DateTime(
        session.completedAt!.year,
        session.completedAt!.month,
        session.completedAt!.day,
      );

      String title;
      if (date == today) {
        title = 'Today';
      } else if (date == yesterday) {
        title = 'Yesterday';
      } else {
        title = DateFormat('MMMM d, y').format(date);
      }

      if (!groups.containsKey(title)) {
        groups[title] = [];
      }
      groups[title]!.add(session);
    }

    return groups.entries
        .map((e) => _SessionGroup(title: e.key, sessions: e.value))
        .toList();
  }

  Widget _buildSessionCard(BuildContext context, FocusSessionEntity session) {
    final timeStr = session.completedAt != null
        ? DateFormat('h:mm a').format(session.completedAt!.toLocal())
        : '';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF322E40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getActivityIcon(session.activityType),
              color: Colors.white70,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.activityType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeStr,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${session.completedMinutes}m',
                style: const TextStyle(
                  color: Color(0xFF8B3DFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              // Note: We could add resisted urges count here if we had that data in FocusSessionEntity
            ],
          ),
        ],
      ),
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type.toLowerCase()) {
      case 'deep focus':
        return Icons.bolt;
      case 'study':
        return Icons.menu_book_outlined;
      case 'work':
        return Icons.work_outline;
      case 'meditation':
        return Icons.spa_outlined;
      default:
        return Icons.timer_outlined;
    }
  }
}

class _SessionGroup {
  final String title;
  final List<FocusSessionEntity> sessions;

  _SessionGroup({required this.title, required this.sessions});
}
