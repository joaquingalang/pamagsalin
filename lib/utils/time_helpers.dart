String getTimeOfDay() {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return 'abak';
  } else if (hour < 17) {
    return 'gatpanapun';
  } else {
    return 'bengi';
  }
}