import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart' as helpers;

import 'messages_af.dart' as messages_af;
import 'messages_am.dart' as messages_am;
import 'messages_ar.dart' as messages_ar;
import 'messages_az.dart' as messages_az;
import 'messages_bg.dart' as messages_bg;
import 'messages_bn.dart' as messages_bn;
import 'messages_ca.dart' as messages_ca;
import 'messages_cs.dart' as messages_cs;
import 'messages_da.dart' as messages_da;
import 'messages_de.dart' as messages_de;
import 'messages_el.dart' as messages_el;
import 'messages_en.dart' as messages_en;
import 'messages_es.dart' as messages_es;
import 'messages_et.dart' as messages_et;
import 'messages_eu.dart' as messages_eu;
import 'messages_fa.dart' as messages_fa;
import 'messages_fi.dart' as messages_fi;
import 'messages_fr.dart' as messages_fr;
import 'messages_gl.dart' as messages_gl;
import 'messages_gu.dart' as messages_gu;
import 'messages_ha.dart' as messages_ha;
import 'messages_he.dart' as messages_he;
import 'messages_hi.dart' as messages_hi;
import 'messages_hr.dart' as messages_hr;
import 'messages_hu.dart' as messages_hu;
import 'messages_hy.dart' as messages_hy;
import 'messages_id.dart' as messages_id;
import 'messages_ig.dart' as messages_ig;
import 'messages_it.dart' as messages_it;
import 'messages_ja.dart' as messages_ja;
import 'messages_ka.dart' as messages_ka;
import 'messages_kk.dart' as messages_kk;
import 'messages_km.dart' as messages_km;
import 'messages_kn.dart' as messages_kn;
import 'messages_ko.dart' as messages_ko;
import 'messages_lv.dart' as messages_lv;
import 'messages_lt.dart' as messages_lt;
import 'messages_ml.dart' as messages_ml;
import 'messages_mr.dart' as messages_mr;
import 'messages_ms.dart' as messages_ms;
import 'messages_my.dart' as messages_my;
import 'messages_nb.dart' as messages_nb;
import 'messages_ne.dart' as messages_ne;
import 'messages_nl.dart' as messages_nl;
import 'messages_pa.dart' as messages_pa;
import 'messages_pl.dart' as messages_pl;
import 'messages_pt.dart' as messages_pt;
import 'messages_ro.dart' as messages_ro;
import 'messages_ru.dart' as messages_ru;
import 'messages_si.dart' as messages_si;
import 'messages_sk.dart' as messages_sk;
import 'messages_sl.dart' as messages_sl;
import 'messages_so.dart' as messages_so;
import 'messages_sr.dart' as messages_sr;
import 'messages_sv.dart' as messages_sv;
import 'messages_sw.dart' as messages_sw;
import 'messages_ta.dart' as messages_ta;
import 'messages_te.dart' as messages_te;
import 'messages_th.dart' as messages_th;
import 'messages_tl.dart' as messages_tl;
import 'messages_tr.dart' as messages_tr;
import 'messages_uk.dart' as messages_uk;
import 'messages_ur.dart' as messages_ur;
import 'messages_uz.dart' as messages_uz;
import 'messages_vi.dart' as messages_vi;
import 'messages_xh.dart' as messages_xh;
import 'messages_yo.dart' as messages_yo;
import 'messages_zu.dart' as messages_zu;
import 'messages_zh.dart' as messages_zh;

Future<bool> initializeMessages(String localeName) async {
  final availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => const <String>{
      'af',
      'am',
      'ar',
      'az',
      'bg',
      'bn',
      'ca',
      'cs',
      'da',
      'de',
      'el',
      'en',
      'es',
      'et',
      'eu',
      'fa',
      'fi',
      'fr',
      'gl',
      'gu',
      'ha',
      'he',
      'hi',
      'hr',
      'hu',
      'hy',
      'id',
      'ig',
      'it',
      'ja',
      'ka',
      'kk',
      'km',
      'kn',
      'ko',
      'lv',
      'lt',
      'ml',
      'mr',
      'ms',
      'my',
      'nb',
      'ne',
      'nl',
      'pa',
      'pl',
      'pt',
      'ro',
      'ru',
      'si',
      'sk',
      'sl',
      'so',
      'sr',
      'sv',
      'sw',
      'ta',
      'te',
      'th',
      'tl',
      'tr',
      'uk',
      'ur',
      'uz',
      'vi',
      'xh',
      'yo',
      'zu',
      'zh',
    }.contains(locale),
    onFailure: (_) => null,
  );
  if (availableLocale == null) return false;
  final lookup = switch (availableLocale) {
    'af' => messages_af.messageLookup,
    'am' => messages_am.messageLookup,
    'ar' => messages_ar.messageLookup,
    'az' => messages_az.messageLookup,
    'bg' => messages_bg.messageLookup,
    'bn' => messages_bn.messageLookup,
    'ca' => messages_ca.messageLookup,
    'cs' => messages_cs.messageLookup,
    'da' => messages_da.messageLookup,
    'de' => messages_de.messageLookup,
    'el' => messages_el.messageLookup,
    'en' => messages_en.messageLookup,
    'es' => messages_es.messageLookup,
    'et' => messages_et.messageLookup,
    'eu' => messages_eu.messageLookup,
    'fa' => messages_fa.messageLookup,
    'fi' => messages_fi.messageLookup,
    'fr' => messages_fr.messageLookup,
    'gl' => messages_gl.messageLookup,
    'gu' => messages_gu.messageLookup,
    'ha' => messages_ha.messageLookup,
    'he' => messages_he.messageLookup,
    'hi' => messages_hi.messageLookup,
    'hr' => messages_hr.messageLookup,
    'hu' => messages_hu.messageLookup,
    'hy' => messages_hy.messageLookup,
    'id' => messages_id.messageLookup,
    'ig' => messages_ig.messageLookup,
    'it' => messages_it.messageLookup,
    'ja' => messages_ja.messageLookup,
    'ka' => messages_ka.messageLookup,
    'kk' => messages_kk.messageLookup,
    'km' => messages_km.messageLookup,
    'kn' => messages_kn.messageLookup,
    'ko' => messages_ko.messageLookup,
    'lv' => messages_lv.messageLookup,
    'lt' => messages_lt.messageLookup,
    'ml' => messages_ml.messageLookup,
    'mr' => messages_mr.messageLookup,
    'ms' => messages_ms.messageLookup,
    'my' => messages_my.messageLookup,
    'nb' => messages_nb.messageLookup,
    'ne' => messages_ne.messageLookup,
    'nl' => messages_nl.messageLookup,
    'pa' => messages_pa.messageLookup,
    'pl' => messages_pl.messageLookup,
    'pt' => messages_pt.messageLookup,
    'ro' => messages_ro.messageLookup,
    'ru' => messages_ru.messageLookup,
    'si' => messages_si.messageLookup,
    'sk' => messages_sk.messageLookup,
    'sl' => messages_sl.messageLookup,
    'so' => messages_so.messageLookup,
    'sr' => messages_sr.messageLookup,
    'sv' => messages_sv.messageLookup,
    'sw' => messages_sw.messageLookup,
    'ta' => messages_ta.messageLookup,
    'te' => messages_te.messageLookup,
    'th' => messages_th.messageLookup,
    'tl' => messages_tl.messageLookup,
    'tr' => messages_tr.messageLookup,
    'uk' => messages_uk.messageLookup,
    'ur' => messages_ur.messageLookup,
    'uz' => messages_uz.messageLookup,
    'vi' => messages_vi.messageLookup,
    'xh' => messages_xh.messageLookup,
    'yo' => messages_yo.messageLookup,
    'zu' => messages_zu.messageLookup,
    'zh' => messages_zh.messageLookup,
    _ => messages_en.messageLookup,
  };
  helpers.initializeInternalMessageLookup(() => CompositeMessageLookup());
  helpers.messageLookup.addLocale(availableLocale, (_) => lookup);
  return true;
}
