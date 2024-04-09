import 'dart:async';
import 'package:chefapp/Data/database_provider.dart';
import 'package:chefapp/Data/interface_user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

part 'user_repository.g.dart';

class UserRepository implements IUserRepository {
  SupabaseClient database;

  UserRepository({required this.database});

  @override
  Future<Stream<AuthState>> fetchUserAuthState() async {
    return database.auth.onAuthStateChange;
  }

  @override
  Future<void> signUserIn(String email, String password) async {
    await database.auth.signInWithPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
}

@riverpod
IUserRepository userRepository(UserRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return UserRepository(database: database);
}
