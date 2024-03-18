import 'dart:async';

import 'package:supabase/supabase.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSupabase extends Fake implements SupabaseClient {
  @override
  get auth => FakeGotrue();

  @override
  SupabaseQueryBuilder from(String table) {
    return FakeSupabaseQueryBuilder();
  }
}

class FakeSupabaseQueryBuilder extends Fake implements SupabaseQueryBuilder {
  @override
  PostgrestFilterBuilder<PostgrestList> select([String columns = '*']) {
    return FakePostgrestFilterBuilder();
  }
}

class FakePostgrestFilterBuilder extends Fake
    implements PostgrestFilterBuilder<PostgrestList> {
  @override
  Future<PostgrestResponse<PostgrestList>> execute() async {
    // Return a fake response
    return PostgrestResponse<PostgrestList>(
      data: List.empty(),
      count: 0,
    );
  }

  @override
  PostgrestFilterBuilder<PostgrestList> filter(
      String column, String operator, value,
      {bool not = false}) {
    // Return this instance for chaining
    return this;
  }

  @override
  Future<U> then<U>(FutureOr<U> Function(PostgrestList value) onValue,
      {Function? onError}) {
    var fakeData = List<Map<String, dynamic>>.empty();
    return Future.value(onValue(fakeData));
  }
}

class FakeGotrue extends Fake implements GoTrueClient {
  final _user = User(
    id: 'id',
    appMetadata: {},
    userMetadata: {},
    aud: 'aud',
    createdAt: DateTime.now().toIso8601String(),
  );

  final StreamController<AuthChangeEvent> _authStateController =
      StreamController<AuthChangeEvent>.broadcast();

  @override
  get onAuthStateChange => FakeOnAuthStateChange();

  void simulateAuthStateChange(AuthChangeEvent event) {
    _authStateController.add(event);
  }

  @override
  Future<AuthResponse> signInWithPassword(
      {String? email,
      String? phone,
      required String password,
      String? captchaToken}) async {
    if (email == 'test@nytest.dk' && password == '1234') {
      return AuthResponse(
        session: Session(
          accessToken: 'fakeAccessToken',
          tokenType: 'Bearer',
          user: _user,
        ),
        user: _user,
      );
    } else {
      // Simulate a failed login
      throw const AuthException('Invalid login credentials');
    }
  }
}

class FakeOnAuthStateChange extends Fake implements Stream<AuthState> {
  final StreamController<AuthState> _controller =
      StreamController<AuthState>.broadcast();

  @override
  StreamSubscription<AuthState> listen(void Function(AuthState)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError as void Function(Object?)?,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void simulateAuthStateChange(AuthState event) {
    _controller.add(event);
  }

  void close() {
    _controller.close();
  }
}
