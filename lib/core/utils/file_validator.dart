import 'dart:io';

class FileValidator {
  static const int maxFileSize = 5 * 1024 * 1024;

  static bool isValidSize(File file) {
    return file.lengthSync() <= maxFileSize;
  }

  static String getSizeErrorMessage() {
    return 'حجم الصورة يتجاوز الحد المسموح به (5 ميجابايت).';
  }
}
