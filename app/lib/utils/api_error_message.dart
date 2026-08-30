import 'package:dio/dio.dart';

/// Turns a thrown error into something worth showing a user.
///
/// Written after "Could not save your profile. Check your connection and try
/// again." was shown while the connection was fine and the API was down. Telling
/// someone to check their connection when the server is unreachable or
/// returning a 500 sends them to fix something that is not broken, so the cases
/// are kept apart here and a status code is always included when there is one.
///
/// Pass [sessionIsLive] when the caller still holds a valid signed-in session.
/// It only changes what a 401 or 403 is allowed to claim: without it, every
/// rejection is reported as an expired session, which is the wrong advice when
/// the session is demonstrably fine and the server is the one refusing it.
String describeApiError(Object error, {bool sessionIsLive = false}) {
  if (error is! DioException) return 'Something went wrong. Please try again.';

  switch (error.type) {
    case DioExceptionType.connectionError:
    case DioExceptionType.connectionTimeout:
      return 'Cannot reach Kyron. Check your connection, or the service may be '
          'temporarily down.';

    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return 'Kyron took too long to respond. Please try again.';

    case DioExceptionType.cancel:
      return 'That request was cancelled.';

    case DioExceptionType.badCertificate:
      return 'Could not establish a secure connection to Kyron.';

    case DioExceptionType.badResponse:
      final status = error.response?.statusCode;
      if (status == null) return 'Kyron returned an unreadable response.';
      if (status == 401 || status == 403) {
        // "Sign in again" is a loop when the session is already valid: the user
        // signs in, lands back on the same screen and gets the same error,
        // because nothing about their credentials was ever the problem.
        return sessionIsLive
            ? 'Kyron could not verify your sign-in (error $status). That is a '
                'problem on our end, not with your account.'
            : 'Your session has expired. Please sign in again.';
      }
      if (status >= 500) {
        // Explicitly not the caller's connection.
        return 'Kyron is having trouble on its end (error $status). Please try '
            'again shortly.';
      }
      return _serverMessage(error.response?.data) ??
          'That request was rejected (error $status).';

    case DioExceptionType.unknown:
      return 'Cannot reach Kyron right now. Please try again.';
  }
}

/// NestJS answers with {"message": ...}, where message is a string for a plain
/// failure and a list for validation errors. Anything else is not worth
/// surfacing raw.
String? _serverMessage(Object? data) {
  if (data is! Map) return null;
  final message = data['message'];
  if (message is String && message.isNotEmpty) return message;
  if (message is List && message.isNotEmpty) return message.first.toString();
  return null;
}
