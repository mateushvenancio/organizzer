extension DateTimeX on DateTime {
  bool isAtTheSameDayAs(DateTime other) {
    if (day != other.day) return false;
    if (month != other.month) return false;
    if (year != other.year) return false;
    return true;
  }
}
