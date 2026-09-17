import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart' as helpers;

import 'messages_en.dart' as messages_en;
import 'messages_es.dart' as messages_es;
import 'messages_zh.dart' as messages_zh;

Future<bool> initializeMessages(String localeName) async {
  final availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => <String>{'en', 'es', 'zh'}.contains(locale),
    onFailure: (_) => null,
  );
  if (availableLocale == null) return false;
  final lookup = switch (availableLocale) {
    'es' => messages_es.messageLookup,
    'zh' => messages_zh.messageLookup,
    _ => messages_en.messageLookup,
  };
  helpers.initializeInternalMessageLookup(() => CompositeMessageLookup());
  helpers.messageLookup.addLocale(availableLocale, (_) => lookup);
  return true;
}
