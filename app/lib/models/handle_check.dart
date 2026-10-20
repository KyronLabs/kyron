// lib/models/handle_check.dart

/// Whether a handle could be this account's, as the server sees it.
class HandleCheck {
  /// The handle as it would be stored: no @, lowercase.
  final String handle;
  final bool available;

  /// `taken`, `reserved` or `format` when it is not available.
  final String? reason;

  const HandleCheck({
    required this.handle,
    required this.available,
    this.reason,
  });

  factory HandleCheck.fromJson(Map<String, dynamic> json) => HandleCheck(
        handle: json['handle'] as String? ?? '',
        available: json['available'] == true,
        reason: json['reason'] as String?,
      );
}
