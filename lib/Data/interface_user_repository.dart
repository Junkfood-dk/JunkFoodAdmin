import 'dart:async';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

abstract interface class IUserRepository {
  Future<Stream<AuthState>> fetchUserAuthState();
  Future<void> signUserIn(String email, String password);
  Future<void> signUserOut();
}
