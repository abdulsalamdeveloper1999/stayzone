import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../home/widgets/heatmap_widget.dart';
import '../../home/widgets/stat_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/di/injection.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../presentation/cubit/heatmap_cubit.dart';
import '../presentation/cubit/heatmap_state.dart';

@RoutePage()
class HeatmapPage extends StatelessWidget {
  const HeatmapPage({super.key});

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
          create: (context) => getIt<HeatmapCubit>()..loadHeatmapData(userId),
          child: BlocBuilder<HeatmapCubit, HeatmapState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(color: Color(0xFF8B3DFF)),
                  ),
                );
              }

              if (state.errorMessage != null) {
                return Scaffold(
                  body: Center(
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
                              .read<HeatmapCubit>()
                              .loadHeatmapData(userId),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Focus Analysis',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SectionHeader(title: 'Overview'),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                value: _formatTotalMinutes(
                                  state.totalFocusMinutes,
                                ),
                                label: 'TOTAL FOCUS',
                                icon: Icons.history_toggle_off,
                                color: const Color(0xFF8B3DFF),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: StatCard(
                                value: _formatAverage(
                                  state.dailyAverageMinutes,
                                ),
                                label: 'DAILY AVG',
                                icon: Icons.auto_graph,
                                color: const Color(0xFF6366F1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const SectionHeader(title: 'Monthly Trends'),
                        const SizedBox(height: 20),
                        HeatmapWidget(dailyMinutes: state.dailyMinutes),
                        const SizedBox(height: 32),
                        const SectionHeader(title: 'Activity Highlights'),
                        const SizedBox(height: 16),
                        _buildHighlightCard(
                          context,
                          'Golden Hour',
                          state.goldenHour,
                          Icons.wb_sunny_outlined,
                        ),
                        const SizedBox(height: 12),
                        _buildHighlightCard(
                          context,
                          'Top Day',
                          state.mostFocusedDay,
                          Icons.calendar_today_outlined,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _formatTotalMinutes(int totalMinutes) {
    if (totalMinutes < 60) return '${totalMinutes}m';
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }

  String _formatAverage(double averageMinutes) {
    if (averageMinutes < 60) return '${averageMinutes.toStringAsFixed(1)}m';
    final hours = averageMinutes / 60;
    return '${hours.toStringAsFixed(1)}h';
  }

  Widget _buildHighlightCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF8B3DFF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF8B3DFF), size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
