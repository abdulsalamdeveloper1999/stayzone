import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentSession;
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  });
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> updateUser(UserModel user);
  Future<void> deleteAccount();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  const AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<void> updateUser(UserModel user) async {
    try {
      await supabaseClient.from('profiles').upsert({
        'id': user.id,
        'name': user.name,
        // We don't update totalFocusMinutes here usually, but we could if needed.
        // For profile edits, it's mostly name/avatar.
        'email': user
            .email, // Store email in profiles too if needed, or just keep it in auth
      });
      // Also update auth metadata if helpful, but profiles table is our source of truth for app data.
      await supabaseClient.auth.updateUser(
        UserAttributes(data: {'name': user.name}),
      );
    } catch (e) {
      throw ServerFailure('Failed to update profile: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: name != null ? {'name': name} : null,
      );
      if (response.user == null) {
        throw const ServerFailure('User is null!');
      }
      // Note: We might want to create the profile row here if Supabase triggers don't do it.
      // For now, assuming triggers or implicit handling.
      // But we should fetch the profile to be sure or just use the input name.
      return UserModel.fromSupabaseUser(
        response.user!,
        profileData: {'name': name},
      );
    } on AuthException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerFailure('User is null!');
      }
      final profile = await _mGetProfile(response.user!.id);
      return UserModel.fromSupabaseUser(response.user!, profileData: profile);
    } on AuthException catch (e) {
      String message = e.message;
      if (message.contains("Invalid login credentials")) {
        message = "Incorrect email or password.";
      }
      throw ServerFailure(message);
    } catch (e) {
      throw ServerFailure('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user != null) {
        final profile = await _mGetProfile(user.id);
        return UserModel.fromSupabaseUser(user, profileData: profile);
      }
      return null;
    } on AuthException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> _mGetProfile(String userId) async {
    try {
      // Assuming 'profiles' table exists and has a 'total_focus_minutes' column
      final data = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      return data;
    } catch (e) {
      // If profile fetch fails, we shouldn't block the user, but maybe log it.
      // Returning null means we fall back to metadata or defaults.
      return null;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw const ServerFailure('User not logged in');

      // Try calling a database function 'delete_user'
      // This function should be defined in Supabase to handle safe deletion
      await supabaseClient.rpc('delete_user');

      // Also sign out locally
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerFailure('Failed to delete account: ${e.toString()}');
    }
  }
}
