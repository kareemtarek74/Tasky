class EndPoints {
  static String baseUrl = 'https://todo.iraqsapp.com';
  static String register = '$baseUrl/auth/register';
  static String login = '$baseUrl/auth/login';
  static String logout = '$baseUrl/auth/logout';
  static String getProfile = '$baseUrl/auth/profile';
  static String refreshToken = '$baseUrl/auth/refresh-token';
}

class ApiKeys {
  static String message = 'message';
  static String error = 'error';
  static String statusCode = 'statusCode';
  static String name = "displayName";
  static String phone = "phone";
  static String experience = "experienceYears";
  static String level = "level";
  static String address = "address";
  static String password = "password";
  static String accessToken = "access_token";
  static String refreshToken = "refresh_token";
}
