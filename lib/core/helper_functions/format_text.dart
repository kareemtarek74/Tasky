String formatText(String text, int maxLineLength) {
  final words = text.split(' ');
  final buffer = StringBuffer();
  int currentLineLength = 0;

  for (final word in words) {
    if (currentLineLength + word.length + 1 <= maxLineLength) {
      if (currentLineLength > 0) {
        buffer.write(' ');
      }
      buffer.write(word);
      currentLineLength += word.length + 1;
    } else {
      buffer.write('\n');
      buffer.write(word);
      currentLineLength = word.length;
    }
  }

  return buffer.toString();
}
