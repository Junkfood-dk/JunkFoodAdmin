import 'dart:async';

import 'package:supabase/supabase.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSupabase extends Fake implements SupabaseClient {
  @override
  get auth => FakeGotrue();
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
    return AuthResponse(
      session: Session(
        accessToken: '',
        tokenType: '',
        user: _user,
      ),
      user: _user,
    );
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
