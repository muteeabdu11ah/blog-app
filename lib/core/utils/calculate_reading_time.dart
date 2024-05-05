int calcultaReadingTime(String Content) {
  final word = Content.split(RegExp(r'\s+')).length;

  final time = 1 + (word / 100);

  return time.toInt().ceil();
}
