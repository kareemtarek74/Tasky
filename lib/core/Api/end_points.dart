class EndPoints {
  static String baseUrl = 'https://todo.iraqsapp.com';
  static String register = '$baseUrl/auth/register';
  static String login = '$baseUrl/auth/login';
  static String logout = '$baseUrl/auth/logout';
  static String getProfile = '$baseUrl/auth/profile';
  static String refreshToken = '$baseUrl/auth/refresh-token';
  static String uploadImage = '$baseUrl/upload/image';
  static String createTask = '$baseUrl/todos';
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
  static String token = "token";
  static String image = "image";
  static String title = "title";
  static String description = "desc";
  static String priority = "priority";
  static String date = "dueDate";
}
