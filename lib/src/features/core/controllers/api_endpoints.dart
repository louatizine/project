class ApiEndPoints {
  static const String baseUrl = 'http://localhost:8090/api/auth/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'signup';
  final String loginEmail = 'signin';
}
