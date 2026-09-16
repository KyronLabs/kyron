import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart' as helpers;
import 'messages_en.dart' as messages_en;
import 'messages_es.dart' as messages_es;

Future<bool> initializeMessages(String localeName) async {
  final availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => <String>{'en', 'es'}.contains(locale),
    onFailure: (_) => null,
  );
  if (availableLocale == null) return false;
  final lookup = availableLocale == 'es'
      ? messages_es.messageLookup
      : messages_en.messageLookup;
  helpers.messageLookup.addLocale(availableLocale, (_) => lookup);
  return true;
}
