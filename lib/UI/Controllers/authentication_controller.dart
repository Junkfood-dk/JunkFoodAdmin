import 'dart:async';
import 'package:chefapp/Data/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

part 'authentication_controller.g.dart';

@riverpod
class AuthenticationController extends _$AuthenticationController {
  @override
  Future<Stream<AuthState>> build() async {
    var repository = ref.read(userRepositoryProvider);
    return repository.fetchUserAuthState();
  }

  Future<void> signIn(String email, String password) async {
    await ref.read(userRepositoryProvider).signUserIn(email, password);
  }

  Future<void> signOut() async {
    await ref.read(userRepositoryProvider).signUserOut();
  }
}
