import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/utils/api_error_message.dart';

DioException _response(int status, {Object? data}) => DioException(
      requestOptions: RequestOptions(path: '/profile'),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(path: '/profile'),
        statusCode: status,
        data: data,
      ),
    );

void main() {
  group('describeApiError', () {
    test('reports an unreachable server as unreachable, not a bad connection',
        () {
      final message = describeApiError(
        DioException(
          requestOptions: RequestOptions(path: '/profile'),
          type: DioExceptionType.connectionError,
        ),
      );
      expect(message, contains('service may be'));
    });

    test('blames the server, not the connection, on a 5xx', () {
      final message = describeApiError(_response(503));
      expect(message, contains('503'));
      expect(message, contains('on its end'));
      expect(message.toLowerCase(), isNot(contains('connection')));
    });

    test('tells an unauthenticated caller their session expired', () {
      final message = describeApiError(_response(401));
      expect(message, contains('expired'));
      expect(message, contains('sign in again'));
    });

    test('does not claim expiry when the session is demonstrably live', () {
      // The bug this guards: a valid Supabase session refused by a server that
      // could not verify it was reported as an expired session, so signing in
      // again returned the user to the same screen and the same error.
      final message = describeApiError(_response(401), sessionIsLive: true);
      expect(message, contains('401'));
      expect(message.toLowerCase(), isNot(contains('expired')));
      expect(message.toLowerCase(), isNot(contains('sign in again')));
      expect(message, contains('our end'));
    });

    test('says what the server said, when the server said something', () {
      // Three different faults reach the client as 401: no Authorization
      // header, a signature that will not verify, and an account the server
      // could not write. Dropping the message made them one indistinguishable
      // sentence, which is what left a reader stuck on the create-profile
      // screen with nothing to report but "error 401".
      final message = describeApiError(
        _response(401, data: {'message': 'Could not resolve account'}),
        sessionIsLive: true,
      );
      expect(message, contains('401'));
      expect(message, contains('Could not resolve account'));
    });

    test('still explains itself when the server said nothing', () {
      final message = describeApiError(_response(401), sessionIsLive: true);
      expect(message, contains('our end'));
    });

    test('carries a 500 the server explained', () {
      expect(
        describeApiError(
          _response(500, data: {
            'message': 'Your sign-in is valid, but Kyron could not set up your '
                'account on this server.',
          }),
        ),
        contains('could not set up your account'),
      );
    });

    test('does not repeat Nest\'s placeholder for an unhandled throw', () {
      final message = describeApiError(
        _response(500, data: {'message': 'Internal server error'}),
      );
      expect(message, contains('trouble on its end'));
      expect(message, isNot(contains('Internal server error')));
    });

    test('applies the same rule to a 403', () {
      expect(
        describeApiError(_response(403), sessionIsLive: true),
        contains('403'),
      );
      expect(
        describeApiError(_response(403)).toLowerCase(),
        contains('expired'),
      );
    });

    test('prefers the server message on other 4xx', () {
      final message = describeApiError(
        _response(400, data: {'message': 'Display name is required'}),
      );
      expect(message, 'Display name is required');
    });

    test('takes the first entry of a validation message list', () {
      final message = describeApiError(
        _response(422, data: {
          'message': ['name should not be empty', 'bio too long'],
        }),
      );
      expect(message, 'name should not be empty');
    });

    test('falls back for a non-Dio error', () {
      expect(describeApiError(StateError('boom')), contains('Something went'));
    });
  });
}
