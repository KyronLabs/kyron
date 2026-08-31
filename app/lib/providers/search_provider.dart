import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/profile_summary.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';

/// What the search screen is showing right now.
class SearchState {
  /// The query these results belong to. Used to discard a slow response that
  /// arrived after the box moved on.
  final String query;
  final List<ProfileSummary> results;
  final bool isSearching;
  final String? error;

  const SearchState({
    this.query = '',
    this.results = const [],
    this.isSearching = false,
    this.error,
  });

  /// Below this the server will not search, and saying so beats an empty list.
  static const minimumQueryLength = 2;

  bool get isTooShort =>
      query.trim().length < minimumQueryLength && query.trim().isNotEmpty;

  bool get isIdle => query.trim().isEmpty;

  bool get foundNothing =>
      !isSearching &&
      error == null &&
      !isIdle &&
      !isTooShort &&
      results.isEmpty;
}

class SearchNotifier extends StateNotifier<SearchState> {
  final Ref _ref;
  Timer? _debounce;

  /// Bumped on every keystroke; a response whose token is stale is dropped.
  int _token = 0;

  SearchNotifier(this._ref) : super(const SearchState());

  /// How long to wait after typing stops. A request per keystroke would send
  /// six for "kyron", five of which are thrown away.
  static const _debounceDelay = Duration(milliseconds: 300);

  void query(String value) {
    _debounce?.cancel();
    final trimmed = value.trim();

    if (trimmed.length < SearchState.minimumQueryLength) {
      _token++;
      state = SearchState(query: value);
      return;
    }

    state =
        SearchState(query: value, results: state.results, isSearching: true);
    _debounce = Timer(_debounceDelay, () => _run(value, ++_token));
  }

  Future<void> _run(String value, int token) async {
    try {
      final api = _ref.read(apiClientProvider);
      final res = await api.dio.get<Map<String, dynamic>>(
        '/profile/search',
        queryParameters: {'q': value.trim(), 'limit': 30},
      );
      if (token != _token) return;

      final items = ((res.data?['items'] as List<dynamic>?) ?? const [])
          .map((e) => ProfileSummary.fromJson(e as Map<String, dynamic>))
          .toList();
      state = SearchState(query: value, results: items);
    } catch (e) {
      if (token != _token) return;
      state = SearchState(
        query: value,
        error: describeApiError(e, sessionIsLive: true),
      );
    }
  }

  /// Re-runs the current query, for the retry button on a failed search.
  void retry() {
    final value = state.query;
    if (value.trim().length < SearchState.minimumQueryLength) return;
    state = SearchState(query: value, isSearching: true);
    _run(value, ++_token);
  }

  void clear() {
    _debounce?.cancel();
    _token++;
    state = const SearchState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier(ref);
});
