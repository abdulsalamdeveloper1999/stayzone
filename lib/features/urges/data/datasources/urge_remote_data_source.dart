import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/urge_report_model.dart';

abstract class UrgeRemoteDataSource {
  Future<UrgeReportModel> reportUrge({
    required String userId,
    required String interventionType,
  });

  Future<int> getTodayUrgesCount(String userId);
}

@LazySingleton(as: UrgeRemoteDataSource)
class UrgeRemoteDataSourceImpl implements UrgeRemoteDataSource {
  final SupabaseClient supabaseClient;

  UrgeRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UrgeReportModel> reportUrge({
    required String userId,
    required String interventionType,
  }) async {
    try {
      final response = await supabaseClient
          .from('urge_reports')
          .insert({
            'user_id': userId,
            'intervention_type': interventionType,
            'reported_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return UrgeReportModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getTodayUrgesCount(String userId) async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final response = await supabaseClient
          .from('urge_reports')
          .select('id')
          .eq('user_id', userId)
          .gte('reported_at', startOfDay.toIso8601String())
          .lt('reported_at', endOfDay.toIso8601String());

      return response.length;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
