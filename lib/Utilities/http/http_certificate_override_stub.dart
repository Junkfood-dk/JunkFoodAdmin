import 'dart:io';

// Dummy class
class HttpCertificateOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    throw Exception(
        'createHttpClient() should not be run in web or production.',);
  }
}
