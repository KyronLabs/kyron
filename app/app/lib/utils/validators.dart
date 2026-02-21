class Validators {
  static String? nonEmpty(String? v) {
    if (v == null || v.trim().isEmpty) return 'Cannot be empty';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email required';
    final r = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!r.hasMatch(v.trim())) return 'Invalid email';
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.length < 8) return 'Password must be at least 8 chars';
    return null;
  }
}
