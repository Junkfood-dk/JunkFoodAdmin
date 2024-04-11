import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

part 'database_provider.g.dart';

@riverpod
SupabaseClient database(DatabaseRef ref) => Supabase.instance.client;
