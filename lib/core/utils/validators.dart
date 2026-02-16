library;

bool isNotEmpty(String? value) {
  return value != null && value.trim().isNotEmpty;
}

bool isValidEmail(String? email) {
  if (email == null || email.isEmpty) return false;
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email.trim().toLowerCase());
}
