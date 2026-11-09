import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sr';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Реч, фраза или #ознака"),
      "about": MessageLookupByLibrary.simpleMessage("О мени"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Додај одговор"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage("Додај језике…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Прихвати и настави"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Већ имате Kyron налог?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Коментари"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage("Различити људи, не отварања"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Ангажовање"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Свиђања"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Још нема гледалаца"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Ову објаву још нико није отворио."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Објављено"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Чувања"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Гледаоци"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("ГЛЕДАОЦИ ПО ДАНУ"),
      "and": MessageLookupByLibrary.simpleMessage("и"),
      "answerNumber": (Object a0) => "Одговор ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR сочиво"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Приложи дневник апликације"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Повратно време"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ПРОВЕРА ТОКЕНА"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Покушај поново"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Покушај поново"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Покретање преноса сада ставило би вас у собу у коју нико не би могао"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Покрени заједницу"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Чему служи? (није обавезно)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("поново да уђе."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("поново да уђе са ове листе."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Ако је затворите,"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("прво се придружите"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("ускоро"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Објављујете у своје име"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("објављујте у овој заједници"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Управо сада"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Покушај поново"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Тема 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("За вас"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("има нешто."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("управо је на путу."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", не"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("да ли се крећем"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Искључи звук"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Укључи звук"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("За вас"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Ваше картице"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Покушај поново"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Симбол (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("ГЛЕДАОЦИ ПО ДАНУ"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("није могуће учитати"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ова објава"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Желите ли нешто да додате? (није обавезно)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ова објава"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Са налога"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Одјави се"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Ваш налог"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Потврдите лозинку"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("не сада"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Учитавање…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Објављивање…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("пре 3 ч"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Копирај линк приче"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Ваша прича"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Ваш налог, ваше објаве и оно што додирнете, како би"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Додај тему"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("своје."),
      "authorBlocked": (Object a0) => "${a0} је блокиран",
      "authorPostsHidden": (Object a0) =>
          "Нећете видети објаве корисника ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Блокирај"),
      "blockAuthor": (Object a0) => "Блокирати корисника ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Подаци о верзији су копирани"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Наставком прихватате"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Наставком прихватате наше Услове коришћења и Политику приватности"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Регистрацијом прихватате"),
      "cancel": MessageLookupByLibrary.simpleMessage("Откажи"),
      "change": MessageLookupByLibrary.simpleMessage("Промени"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Промени имејл"),
      "checkEmailConfirm":
          MessageLookupByLibrary.simpleMessage("Потврдите налог путем имејла."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Провери да ли је Kyron доступан"),
      "clear": MessageLookupByLibrary.simpleMessage("Обриши"),
      "close": MessageLookupByLibrary.simpleMessage("Затвори"),
      "closeCommunity": (Object a0) => "Затворити ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Затвори"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Затвори ову заједницу"),
      "communities": MessageLookupByLibrary.simpleMessage("Заједнице"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Пронађите је у Истражи или покрените сопствену."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Избаците вруће мишљење (или млако)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Шта вам је на уму?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Реците нешто што само ви можете да кажете…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("Ово је знак: објавите"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Пишите, говорите или размишљајте наглас"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Потврдите лозинку"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Контактирај подршку"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Објаве још немају језик, па ово још не филтрира ваш фид. Ваш избор се чува до тада."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Настави"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Настави са имејлом"),
      "copy": MessageLookupByLibrary.simpleMessage("Копирај"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Радије копирај извештај"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Није могуће отворити пријаву преко Google-а. ${a0}",
      "couldNotSignOut": (Object a0) => "Одјава није успела: ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
          "Није могуће снимити фотографију."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Приказује се на твом профилу и испод твојих објава."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Ниједна држава не одговара упиту „{query}”."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Не приказуј државу"),
      "country_search": MessageLookupByLibrary.simpleMessage("Претражи државе"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Приказује се на твом профилу и испод твојих објава. Када видиш нечије објаве, твоја држава се рачуна у његовим Увидима, само у групама од пет или више и никад по имену."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Из подешавања твог телефона"),
      "create": MessageLookupByLibrary.simpleMessage("Направи"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Направи налог"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Направите налог"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Направите профил"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR сочиво"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Уживо"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Текстуална објава"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Гласовна објава"),
      "delete": MessageLookupByLibrary.simpleMessage("Избриши"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Избрисати овај коментар?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Избрисати ову објаву?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Опишите овај прилог"),
      "description": MessageLookupByLibrary.simpleMessage("Опис"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
          "DID је копиран у привремену меморију"),
      "done": MessageLookupByLibrary.simpleMessage("Готово"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Затворите уређивач када нешто напишете и биће вам понуђен нацрт."),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("пре {days} д"),
      "draft_hours_ago": MessageLookupByLibrary.simpleMessage("пре {hours} ч"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Управо сада"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("пре {minutes} мин"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Још ништа није написано"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Анкета, још без питања"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Цитат, још без текста"),
      "drafts": MessageLookupByLibrary.simpleMessage("Нацрти"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Измени профил"),
      "email": MessageLookupByLibrary.simpleMessage("Имејл"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Обавештења имејлом"),
      "explore": MessageLookupByLibrary.simpleMessage("Истражи"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Праћење лица није доступно на овом уређају."),
      "feedTagDetail": (Object a0) => "Са #${a0} још ништа није објављено.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Прати {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Пратиоци"),
      "following": MessageLookupByLibrary.simpleMessage("Пратите"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Заборавили сте лозинку?"),
      "gettingHelp":
          MessageLookupByLibrary.simpleMessage("Како да добијете помоћ"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Настави преко Google-а"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Пријави се преко Google-а"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google враћа завршену пријаву у Kyron преко линка на који одговарају само Android и iOS, па на платформи ${a0} прегледач нема где да је врати.\\n\\nАко већ имате Kyron налог преко Google-а, изаберите Настави са имејлом са истом адресом и додирните Заборавили сте лозинку: добићете линк за постављање лозинке.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Пријава преко Google-а захтева апликацију за телефон"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Региструј се преко Google-а"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Водичи и одговори на честа питања"),
      "handle": MessageLookupByLibrary.simpleMessage("корисничко име"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("Помоћ и подршка"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Центар за помоћ"),
      "home": MessageLookupByLibrary.simpleMessage("Почетна"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("У једном реду"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Твој налог"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Отвори заједницу"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Напиши објаву"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Погледај објаву"),
      "ins_act_profile": MessageLookupByLibrary.simpleMessage("Уреди профил"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Када су ту"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("У твојој временској зони."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Узраст"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Од {known} досегнутих особа које су навеле рођендан."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Досегнуте особе по дану"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Заједнице у којима су"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Државе"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Од {known} досегнутих особа које имају државу на профилу."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Последњих {days} дана"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Статистика није могла да се учита"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Пратиоци"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Још ниједна група није довољно велика за приказ."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Како расти"),
      "ins_interests": MessageLookupByLibrary.simpleMessage("Теме које прате"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Свиђања"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Ново"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Нови пратиоци"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Ниједна твоја објава није никог досегла у овом периоду."),
      "ins_non_followers": MessageLookupByLibrary.simpleMessage("Не прате те"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Државе су оне које су људи изабрали на својим профилима. Kyron не прикупља ничији град ни пол, па за њих нема шта да се прикаже."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Отварања"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} досегнуто · {likes} свиђања · {replies} одговора"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Досегнуте особе"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Свака особа се броји једном: први пут јој је приказана или је отворила неку твоју објаву. Нови пратиоци те и даље прате; престанци праћења се не броје."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Одговори"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Поновне објаве"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Чувања"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Ко је твоја публика приказује се кад {floor} особа види твоје објаве у овом периоду. Уз мање, могло би да укаже на некога."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Још нема довољно људи"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% њих те већ прати: твоје објаве углавном досежу људе који те познају."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% њих те још не прати: твоје објаве се проналазе."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Досегао си {reach} особа, {pct}% мање него у претходном периоду."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Досегао си {reach} особа у последњих {days} дана."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Досегао си {reach} особа, отприлике као у претходном периоду."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Нико нови није видео твоје објаве у последњих {days} дана."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Досегао си {reach} особа, {pct}% више него у претходном периоду."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Досегао си {reach} особа, {times}× више него у претходном периоду."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Више њих прати {name} него било коју другу тему."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Публика"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Преглед"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Људи који пронађу твоју објаву погледају твој профил пре него што те запрате. Лице или лого им говори да је неко ту."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Додај профилну слику"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Реци у једном реду о чему објављујеш, да странац зна шта добија ако те прати."),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("Напиши опис"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} од твојих {total} објава није имало тему. Тема ставља објаву у фид те теме и пред оне који је прате."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Додај теме објавама"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} особа је одговорило на твоје објаве, а ти си одговорио на {answered}. Било им је довољно стало да напишу: одговор претвара читаоца у сталног посетиоца."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Одговарај на одговоре"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Твоја публика је најактивнија {when}. Објава мало пре тога има ко да је дочека."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Објављуј кад су ту"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} особа које те не прате видело је твоје објаве, а {gained} те запратило. Нека твој опис и најновије објаве кажу шта могу да очекују од тебе."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("Претвори читаоце у пратиоце"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Једна објава је досегла {times}× више људи него што обично досежу остале. Погледај шта је урадила другачије и ради више тога."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Ради више онога што је успело"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Многи који виде твоје објаве су у {name}. Објава тамо те ставља и пред остале."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Објави у {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Објавио си {posts} пута за {days} дана. Свака објава је још једна прилика да те неко пронађе, а сталан ритам те држи у фидовима пратилаца."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Објављуј чешће"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Ништа ниси објавио у последњих {days} дана. Без објаве ништа не стиже ни до кога."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Објави нешто"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Статистика"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Најбоље објаве"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "У односу на претходних {days} дана"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Додај интересовање"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
          "Превуците да промените редослед"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "На траку стаје највише пет картица. Уклоните једну да бисте додали другу."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Пратите"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("За вас"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Хештегови се појављују овде када људи почну да их користе."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Тренутно у тренду"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Видео снимци"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Ваше картице"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Нестаће за обоје."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Биће уклоњено из нити."),
      "join": MessageLookupByLibrary.simpleMessage("Придружи се"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Настави уређивање"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Екрани Kyron-а су на вашем језику. Ако вам нека реч звучи погрешно, јавите нам преко опције Пошаљи повратне информације."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Језици"),
      "leave": MessageLookupByLibrary.simpleMessage("Напусти"),
      "leaveCommunity": (Object a0) => "Напустити ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Врати назад"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("Отворена 1 страница"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Додај клип"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Додај GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Додај хештаг"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Додај фотографију"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Додај анкету"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Додај видео"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Додај интересовање"),
      "literaladdLabelAsATab": (Object a0) => "Додај ${a0} као картицу",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Језик апликације"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Верзија апликације"),
      "literalblockAuthor": (Object a0) => "Блокирај ${a0}",
      "literalblockAuthor2": (Object a0) => "Блокирати ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Блокирати овај налог?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Одбаци одговор"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Провери поново"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Изабери из галерије"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Обриши кеш"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Затвори све странице"),
      "literalcloseTabLabel": (Object a0) => "Затвори ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Затвори прегледач"),
      "literalcloseWidgetCommunityName": (Object a0) => "Затворити ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Контактирај подршку"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Језици садржаја"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Копирај линк"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Копирај линк објаве"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Копирај текст објаве"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Копирај текст"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("Није могуће учитати заједнице"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Није могуће учитати GIF-ove"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати обавештења"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("Није могуће учитати чланове"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати ове објаве"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Није могуће учитати овај разговор"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("Није могуће учитати ову листу"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати ову објаву"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати овај одговор"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати популарне ознаке"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Није могуће учитати ваше заједнице"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати ваше поруке"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Није могуће отворити ову заједницу"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("Није могуће објавити одговор."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Претрага није успела"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Одјава није успела: ${a0}",
      "literalcountPagesOpen": (Object a0) => "Отворених страница: ${a0}",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Насловна фотографија"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Уштеда података"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Избриши објаву"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Пронађи људе"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Не одговарај"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Нацрт је сачуван"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Повратне информације тренутно не могу да се пошаљу"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Величина текста"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF-ови нису подешени"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Предај другој апликацији"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Сакриј лозинку"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Сакриј ову објаву"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Скрива је и тражи да приказујемо мање оваквих"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Како се понашати"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Настави писање"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron није одговорио"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "Датум \\${a0}",
      "literalleaveCommunityName": (Object a0) => "Напустити ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, сочиво за лице",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Објаве које вам се свиђају"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Линк је копиран"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Постави за модератора"),
      "literalmuteAuthor": (Object a0) => "Утишај ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Утишај ову нит"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Утишај речи или ознаке"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("Утишани и блокирани налози"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Утишано. Нећете примати обавештења."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Ниједна апликација на овом уређају не отвара линкове ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Ниједан прегледач на овом уређају није прихватио линк."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Још нема DID-а"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Нема нацрта"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Још нема интересовања"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Још нема свиђања"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Још нема порука"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Нема нових пратилаца"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Још нема објава"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Још нема одговора"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Још нема поновних објава"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Ниједна популарна ознака се не подудара"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Нико није пронађен"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Нико није уклоњен"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Овде још нема никога"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Не занима ме"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Ништа није пронађено"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Још ништа није у тренду"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("У дневнику још нема ничега"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Нема резултата"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Ништа није утишано"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Још нема ничега за гледање"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Нема непрочитаних"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Ово може да промени само власник"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Отвори одговор"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Отворите имејл од Kyron-а"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Лозинка и пријава"),
      "literalpostInCommunityName": (Object a0) => "Објави у ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Објави у ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Објави са сопственим речима изнад"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Главни језик"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push обавештења"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Провера…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Сними гласовну објаву"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Сними поново"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Уклони из модератора"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Уклони из заједнице"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Уклони из сачуваног"),
      "literalremoveLabel": (Object a0) => "Уклони ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Уклони ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Уклонити ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Уклони анкету"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Уклони овај одговор"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Избриши овај разговор"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Уклони ову анкету"),
      "literalreportAuthor": (Object a0) => "Пријави ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Пријави објаву"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Поново пошаљи код"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Сачуване објаве"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Реците нешто"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Реците нешто у ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Претрага није успела"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Поново пошаљи"),
      "literalsendAgainInCooldownS": (Object a0) => "Поново пошаљи за ${a0} с",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Пошаљи повратне информације"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("Пошаљи линк"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Послато. То је извештај бр. ${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Поставите лозинку и наставите"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("Подели дневник са подршком"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Подели ову заједницу"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Подели ову страницу"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Подели овај профил"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Подели…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Подели са цитатом"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Прикажи више оваквих"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Прикажи лозинку"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Прикажи резултате"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Покрени заједницу"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Почни снимање"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Заустави учитавање"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Престани да гледаш ову објаву и њене одговоре"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Трака прича, ставки: ${a0}",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Промени камеру"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Означи некога"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Сними фотографију"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Додирните насловну слику или фотографију да бисте их променили"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Додирните линк у њему"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Додирните да додате фотографију и насловну слику"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Није успело. Покушајте поново."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("Није могуће учитати тај GIF."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Овај линк не може да се отвори овде."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Камера је затворена"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Ова заједница"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Овај одговор више не постоји"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Преведи објаву"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Искључи звук"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("Укључи звук"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Користи неку од наших"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Код за потврду је поново послат."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Потврда није успела: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Потврди имејл"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Гледаоци, свиђања, чувања и коментари"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Шта Kyron чува"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Шта је ова апликација радила"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Шта сте радили, шта сте очекивали, шта се десило "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Оно што објавите припада вама"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Да ли је Kyron тренутно доступан"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Ко може да одговори"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Кога желите да означите?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Већ пратите све популарне ознаке"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Све сте прегледали"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("Нисте ни у једној заједници"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Одјављени сте."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Напустили сте ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Још нисте ништа објавили"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Учитај још"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Дневник је обрисан"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Дневник је копиран"),
      "logIn": MessageLookupByLibrary.simpleMessage("Пријави се"),
      "logOut": MessageLookupByLibrary.simpleMessage("Одјави се"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Одјавити се?"),
      "login": MessageLookupByLibrary.simpleMessage("Пријава"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Пријава није успела. Проверите податке."),
      "manage": MessageLookupByLibrary.simpleMessage("Управљај"),
      "menu": MessageLookupByLibrary.simpleMessage("Мени"),
      "message": MessageLookupByLibrary.simpleMessage("Порука"),
      "messages": MessageLookupByLibrary.simpleMessage("Поруке"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("Прочитали сте све разговоре."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Отворите нечији профил и додирните Порука да бисте започели разговор."),
      "mute": MessageLookupByLibrary.simpleMessage("Утишај"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Утишани и блокирани"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Утишане речи и ознаке"),
      "name": MessageLookupByLibrary.simpleMessage("Име"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Екран <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Нова имејл адреса"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Нова лозинка"),
      "newPost": MessageLookupByLibrary.simpleMessage("Нова објава"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Не сада"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Није послато. Додирните да покушате поново"),
      "nothingMatchesQuery": (Object a0) =>
          "Ништа на Kyron-у не одговара упиту \"${a0}\"",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Нема ничега за копирање"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Овде стижу свиђања, одговори и нови пратиоци."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Овде ће се појавити људи који вас прате."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Када се некоме свиди ваша објава, појавиће се овде."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Овде стижу одговори на ваше објаве."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Када вас неко поново објави, појавиће се овде."),
      "notifications": MessageLookupByLibrary.simpleMessage("Обавештења"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Отвори у прегледачу"),
      "or": MessageLookupByLibrary.simpleMessage("или"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Страница није пронађена"),
      "password": MessageLookupByLibrary.simpleMessage("Лозинка"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Лозинка је прекратка"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Изаберите интересовања"),
      "post": MessageLookupByLibrary.simpleMessage("Објави"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Статистика објаве"),
      "postInCommunity": (Object a0) => "Објави у ${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Објави, реци, покажи."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Текст објаве је копиран"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Политика приватности"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Профил је ажуриран"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("О мени"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Држава"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Приказно име"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Локација"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Додирните да промените"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Веб-сајт"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push обавештења"),
      "quote": MessageLookupByLibrary.simpleMessage("Цитирај"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Цитирај објаву"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Обратите се човеку"),
      "remove": MessageLookupByLibrary.simpleMessage("Уклони"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Избрисати овај разговор?"),
      "removeMember": (Object a0) => "Уклонити ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Избрисати ову поруку?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("Одговори, праћења и помињања"),
      "repliesPolicy": (Object a0) => "Одговори: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Одговори"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Свако може да се укључи"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Свако и даље може да види, поново објави и цитира ову објаву."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Свако на Kyron-у може да одговори на ову објаву."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Људи који вас прате"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "На ову објаву могу да одговоре само ваши пратиоци."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Људи које поменете"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Одговорити могу само људи које @поменете у овој објави."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Нико не може да одговори"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Одговори су искључени. Ви и даље можете да одговорите."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Ко може да одговори?"),
      "report": MessageLookupByLibrary.simpleMessage("Пријави"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Извештај је копиран. Налепите га у имејл подршци."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Пријава је послата"),
      "repost": MessageLookupByLibrary.simpleMessage("Поново објави"),
      "reset": MessageLookupByLibrary.simpleMessage("Ресетуј"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Ресетујте лозинку"),
      "retry": MessageLookupByLibrary.simpleMessage("Покушај поново"),
      "save": MessageLookupByLibrary.simpleMessage("Сачувај"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Сачувај нацрт"),
      "saySomething": (Object a0) => "Реците нешто у ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Претрага"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Претражи по имену или корисничком имену"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Претражи заједнице"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Претражи GIF-ove"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("Претражи језике"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Претражи популарне ознаке"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Безбедносна упозорења и промене налога"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Изаберите језик интерфејса апликације."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Изаберите који се језици приказују у вашим фидовима. Ако не изаберете ниједан, приказују се сви језици."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Изаберите главни језик за преводе у фиду."),
      "send": MessageLookupByLibrary.simpleMessage("Пошаљи"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Пошаљи потврду"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Пошаљи извештај о грешци"),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("Пошаљи повратне информације"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Пошаљи пријаву"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("Пошаљи подршци"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Статус услуге"),
      "settings": MessageLookupByLibrary.simpleMessage("Подешавања"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Подели дневник апликације са подршком"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Пријава на Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Пријављени сте као"),
      "signupFailed": (Object a0) => "Регистрација није успела: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Остани"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron је на почетку, а најбржи начин да стигнете до некога ко то заиста може да поправи јесте да отворите тикет. Реците нам шта сте радили и шта се десило."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Апликација још нема пријемно сандуче подршке, па вас овај екран упућује тамо где неко заиста прати, а не на образац који никуда не води."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Дневник апликације"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Реците нам шта недостаје или не ради"),
      "terms": MessageLookupByLibrary.simpleMessage("Услове коришћења"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Текст, глас и видео, људи који их стварају и собе у којима разговарају."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "У уређивачу нема дугмета Објави"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Тамна"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Увек тамна"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Пригушена"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Блажа тамна, плавкастосива уместо црне"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Светла"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("Увек светла"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Систем"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Прати светло или тамно подешавање телефона"),
      "translate": MessageLookupByLibrary.simpleMessage("Преведи"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Превођење још није укључено. У вашем фиду се још ништа не преводи; подешавање се памти до тада."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Ово мења Kyron-ове сопствене речи, делове интерфејса које Flutter сам црта, датуме и бројеве, као и смер распореда апликације за језике који се пишу здесна налево."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Покушај поново"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Политика приватности"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Услови коришћења"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Налог"),
      "ui_after": MessageLookupByLibrary.simpleMessage("После"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Апликација и уређај"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Цитат је требало да упозори друге на превару."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Напишите зашто мислите да је одлука била погрешна: шта је објава значила, шта је тим можда пропустио или зашто правило не одговара. Прочитаће је неко други, а не онај ко је одлучио."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Ваша жалба"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Напишите најмање \$count знакова. На сваку одлуку можете да се жалите једном."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Пошаљи жалбу"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Жалба је послата. Добићете обавештење када се одлучи."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Жалба на случај \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Изглед"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Светла, тамна или према телефону"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Пре"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Нећете се међусобно видети на Kyron-у, а праћења међу вама биће уклоњена. Та особа неће бити обавештена."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Садржи"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Чему служи (необавезно)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Само модератори могу да пишу"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "За обавештења. Сви у заједници и даље могу да читају и реагују."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Додај фотографију или анкету"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Фотографије и видео-снимци"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Затвори ћаскање"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Нико више неће моћи да чита или пише у њему. Ово не може да се опозове."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Затворити ово ћаскање?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Копирано"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Порука се уклања за све. Kyron задржава копију ради прегледа."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Порука се уклања за све у ћаскању."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Измени ћаскање"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Измени"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("измењено"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Мењате своју поруку"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Није могуће отворити ово ћаскање."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Ћаскања"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Придружи се ћаскању"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Придружите се заједници да бисте видели њена ћаскања и учествовали."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Придружено: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Напусти ћаскање"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "И даље можете да га читате док сте у заједници."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Овде могу да пишу само власник и модератори."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Искључи звук"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Без обавештења из овог ћаскања, и не рачуна се у Поруке."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Назив ћаскања"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Ново ћаскање"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Још нема ћаскања."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Још нема ћаскања. Отворите једно за заједницу."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Ћаскања заједнице нису шифрована с краја на крај. Модератори заједнице и Kyron могу да их читају."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Закачи на врх"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Додај одговор"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Затвори анкету"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Затворена"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Сви виде колико је људи изабрало сваки одговор, никад ко."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Дозволи више одговора"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Нова анкета"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Изаберите један"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Одговор \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Анкета: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Питање"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Сваки одговор може бити у анкети само једном."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Изаберите један или више"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("Одговорило: \$count"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Претражи ово ћаскање"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Претражи ово ћаскање"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Ништа није пронађено."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Више не можете да видите ово ћаскање."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Спори режим"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Колико се чека између порука. Не важи за модераторе."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 сат"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Минути: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Спори режим: једна порука на сваких \$seconds с"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Искључено"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Секунде: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Као посматрач можете да читате и реагујете. Придружите се да бисте писали."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Та порука је предалеко у прошлости да би се приказала."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Нешто што сте изабрали превелико је за слање и изостављено је."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("Укључи звук"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Откачи"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Сними гласовну поруку"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Ви"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Заједнице"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Чему служи? (није обавезно)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Објаве:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Садржај и приказ"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("Није могуће учитати ваш фид"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати објаве које вам се свиђају"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати ваш профил"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати сачуване објаве"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Децентрализовани ID"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("Решавање проблема"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Групе"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Нема група"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Овде су групе у којима сте и ћаскања заједница којима се придружите."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Можете да закачите највише \$count ћаскања. Прво откачите једно."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Закачено"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Свиђа ми се"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Сачувано"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Овде још нема ничега"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Пратите неколико налога и њихове објаве ће се појавити овде."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Ништа од оних које пратите"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Објаве ће се појављивати овде како их људи пишу."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Слаби"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Не занима ме"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Прикажи више оваквих"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Уклоњено"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Сигнали твог фида"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Додирни Прикажи више оваквих објава или Не занима ме на објави и појавиће се овде."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Овде још нема ничега"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Шта Прикажи више и Не занима ме говоре твојим фидовима"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Обликују Почетну и Истражи, углавном према теми сваке објаве. Сваки сваког месеца ослаби на пола и престаје да се рачуна после шест. Уклони један да га одмах зауставиш."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Објаве са клипом појавиће се овде."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Још нема видео снимака"),
      "ui_feedback":
          MessageLookupByLibrary.simpleMessage("Повратне информације"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Пронађите људе на Kyron-у"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Са налога"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Додај особе"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Додај"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Додај назив групе"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Одбиј"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Поруке у овој групи су шифроване од краја до краја, као и сваки други разговор."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor додаје: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor поставља за администратора: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor прави групу"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor подешава да се нови придружују као чланови"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor подешава да се нови придружују као посматрачи"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor напушта групу"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor поставља за члана: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor предаје власништво: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor уклања: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor преименује групу у \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor поставља за посматрача: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Група може имати највише \$count особа."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Рука подигнута. Администратори су обавештени."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Желе да пишу: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Желе да пишу"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Особе додате касније придружују се као посматрачи"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Напусти групу"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Нестаће са ваше листе и нећете видети шта се касније напише. Неко би морао поново да вас дода."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Напустити ову групу?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Дозволи писање"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Спусти руку"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Постави за администратора"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Предај власништво"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Постави за посматрача"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Чланова: \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Чланови"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Назив групе"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Прво дајте назив групи."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Направи групно ћаскање"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Власник је само један. Остаћете администратор."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Предати власништво: \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Подигни руку"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Уклони из групе"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Уклони као администратора"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Више нисте у овој групи."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Преименуј"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Администратор"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Члан"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Посматрач"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Као посматрач овде можете да читате и реагујете."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Посматрачи могу да читају, реагују и подигну руку да затраже писање."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Предлози"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Прикажи профил"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("ви"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Ви сте посматрач"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Помоћ"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Забележено. То помаже да изаберемо шта вам приказујемо."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Придружи се"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Придружио се"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Језик"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Изаберите језик"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Правне информације"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Свиђа ми се"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Објаве које вам се свиђају"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Објаве које вам се свиђају појављују се овде, најновије прве."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Линк је копиран"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Више нећете видети њене објаве. Та особа неће бити обавештена."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Још нема свиђања"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Ниједна објава не одговара тим филтерима."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Још ништа није сачувано"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Ваш налог је ажуриран"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Ваша жалба на случај \$number је прихваћена"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Поново смо размотрили вашу жалбу на случај \$number и одлука остаје на снази"),
      "ui_notif_banned":
          MessageLookupByLibrary.simpleMessage("Ваш налог је трајно забрањен"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Случај \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("вас прати"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("је лајковао/ла вашу објаву"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("вас је поменуо/ла"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Још нема помињања"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Када неко напише ваше @корисничко име у објави или одговору, појавиће се овде."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Старије"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Ваша порука у ћаскању заједнице је уклоњена"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Нешто што сте објавили је уклоњено"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Ваша објава је уклоњена"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Ваш одговор је уклоњен"),
      "ui_notif_replied": MessageLookupByLibrary.simpleMessage(
          "је одговорио/ла на вашу објаву"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Предузели смо мере у вези са нечим што сте пријавили. Хвала што сте нам јавили."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Прегледали смо нешто што сте пријавили и нисмо утврдили да крши наша правила."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Пријављено због: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("је поделио/ла вашу објаву"),
      "ui_notif_reversed":
          MessageLookupByLibrary.simpleMessage("Поништили смо случај \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Ваш налог је суспендован"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Ваш налог је суспендован до \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Све"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Пратиоци"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Лајкови"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("Помињања"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Одговори"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Ове недеље"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Данас"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Ваш налог је добио упозорење"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Јуче"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Готово"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Прескочи"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Ово је већ отворено."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Истекло"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Ово није могло да се отвори."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Отвара се једном, затим се брише са Kyron-а."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Прикажи једном"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Отворено"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Отворило: \$count од \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Могу да га отворе само они којима сте га послали, и то једном."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Пошаљи за једнократан приказ"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Додирните за приказ"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Пауза"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Пусти"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Биће уклоњена са вашег профила и из свих фидова. Њени одговори нестају са њом."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Објава је избрисана"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Објава је сакривена"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Текст објаве је копиран"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Објављено између"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Сакривено. Приказиваћемо мање оваквих."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Подешавања"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Приватност"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Желите ли нешто да додате? (опционо)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Када тим одлучи, добићете обавештење, а случај можете пратити у одељку Ваше пријаве."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Ако ту особу такође више не желите да видите, утишајте је или блокирајте у истом менију."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Пријављивање исте ствари двапут не даје јој већу тежину: чувамо једну пријаву по особи."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Ваша пријава се не дели са том особом. Чувамо копију пријављеног садржаја како би могао да се прегледа и ако буде избрисан."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Ваша пријава је примљена и чека на преглед. Тој особи не кажемо ко ју је пријавио."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Погледајте своје пријаве"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Реците нам шта није у реду"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Хвала што сте нам рекли"),
      "ui_report_what_account": MessageLookupByLibrary.simpleMessage(
          "Шта није у реду са налогом \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Шта није у реду са овом поруком?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Шта није у реду са овом објавом?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Шта није у реду са овим одговором?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Порука у ћаскању заједнице"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Објава"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Одговор"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Предузете мере"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Налог"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Одлучено \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Правила нису прекршена"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Ваше пријаве није могуће учитати"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Шта сте пријавили у последњих 90 дана и шта је из тога проистекло. Када тим одлучи, добићете обавештење. Нико кога пријавите не сазнаје ко га је пријавио."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Ништа пријављено"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Када пријавите објаву, одговор, поруку или налог, појавиће се овде заједно са исходом."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("У прегледу"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Пријављено \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Шта сте пријавили и какав је исход"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Ваше пријаве"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Безбедност деце"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Све што угрожава или сексуализује малолетнике."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Циљано злостављање, претње или нежељени контакт."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Напади на људе због тога ко су."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Продаја или промовисање нечег незаконитог."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Лажно представљање као неко други."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Користи ваше дело или жиг без дозволе."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Обмањујуће тврдње о здрављу, изборима или догађајима."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Подстицање или приказивање самоповређивања."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Сексуални садржај приказан без упозорења."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Ништа од наведеног. Реците нам шта није у реду."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Понављајуће, обмањујуће или нежељено оглашавање."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Претње насиљем, величање насиља или подстицање на њега."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Узнемиравање или малтретирање"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Говор мржње"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Незаконита роба или услуге"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Лажно представљање"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Интелектуална својина"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Лажне информације"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Самоубиство или самоповређивање"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Садржај за одрасле"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Нешто друго"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Нежељени садржај"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Насиље или претње"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("Сачуване објаве"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Додирните икону архиве на објави да бисте је задржали овде. Сачувано видите само ви."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Тражите по корисничком или приказном имену."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Обриши"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Претражите све објављено"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Филтери"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Претражи људе"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Претражи објаве"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Подешавања"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Апликација и уређај"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Садржај и приказ"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Уштеда података"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Поделите мишљење"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Прегледај чланке помоћи"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Изаберите језик"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Кога сте утишали или блокирали"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Подешавања обавештења"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("Ваш профил и контакт подаци"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Мораћете поново да се пријавите да бисте се вратили на налог."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Безбедносна подешавања"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Потврдите лозинку"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("У једном реду"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Нова имејл адреса"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Нова лозинка"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Шта се десило"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Помоћ нашег тима"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Подели"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Цитирај"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Пошаљи у поруци"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Људима на Kyron-у"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Подели ову објаву"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("На шта се односило"),
      "ui_standing_account_banned":
          MessageLookupByLibrary.simpleMessage("Ваш налог је трајно забрањен"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Одговор, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Жалба"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Уложи жалбу на ову одлуку"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "На ову одлуку више није могуће уложити жалбу. Ако нешто није у реду, обратите се подршци."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Жалба се разматра"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Жалба прихваћена"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Неко други из тима поново то прегледа. Добићете обавештење када се одлучи."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Ако мислите да је реч о грешци, до \$date можете да затражите поновни преглед. Одлучује неко други из тима."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "После жалбе: одлука остаје на снази"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Случај \$number. Правило: \$rule. Тим је написао:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Брисање налога не укида забрану: нови налог са истом адресом е-поште такође ће бити забрањен."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Трајно забрањен"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Раде само још ова страница, жалбе, подршка и брисање налога."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Могућа жалба"),
      "ui_standing_case":
          MessageLookupByLibrary.simpleMessage("Случај \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Одлучено \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Одлуке о вашем налогу"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Избриши налог"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Прикажи детаље"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Прикажи детаље и уложи жалбу"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Завршава се \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Ваш налог је у реду"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Ништа га не ограничава."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Стање налога није могуће учитати"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Порука уклоњена"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "О вашем налогу ништа није одлучено. Ако тим икада уклони нешто ваше или ограничи ваш налог, то ће бити наведено овде са разлогом и моћи ћете да уложите жалбу."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Нема на шта да се жалите: одлука је поништена."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Објава уклоњена"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Повуците надоле да проверите поново."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Прочитај правила Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Одговор уклоњен"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Поништено"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Поништено \$date. Све уклоњено је враћено и ниједно ограничење више не важи."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Правило: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Одјави се"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Суспендован"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Можете да читате, али не и да објављујете, одговарате, пратите или шаљете поруке. Пријављивање, блокирање и утишавање и даље раде."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Ваш налог је суспендован: можете да читате, али не и да објављујете."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Суспендован до \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Ваш налог је суспендован до \$date: можете да читате, али не и да објављујете."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Шта је тим написао"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("Стање налога"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Упозорење"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Зашто?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Ваше речи, \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Ваша порука"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Ваша објава"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Ваш одговор"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Услове коришћења"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ова објава"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Нит је утишана"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Покушај поново"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("Искључи звук"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Укључи звук"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Најмање два знака."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Опозови"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Речи или филтер: налог, период или садржај објаве."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Опозови поновну објаву"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Ажурирај лозинку"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Користи другу адресу"),
      "username": MessageLookupByLibrary.simpleMessage("Корисничко име"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Корисничко име мора бити малим словима (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Видео"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Приложи"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Спремно за прилагање"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Сними гласовну објаву"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Чување…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Заустави"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Шта се десило"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Шта се догодило и шта треба да погледамо?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Шта је на овој слици?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Чему служи? (није обавезно)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Шта сте радили, шта сте очекивали, шта се десило"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Шта сте радили када се то десило."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Ваш одговор"),
      "dmReplied": (Object a0) => "Одговор од $a0",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Додај у поруку"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Нова порука"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Још ништа није речено. Махање је добар почетак."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Махни"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("Нове поруке"),
      "dmTyping": (Object a0) => "$a0 куца",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Уклони своју реакцију"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Неко"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Порука"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("Прилог"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Ова порука се не може прочитати на овом уређају."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Чека се ова порука. То може потрајати."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Шифрована порука"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Поруке су шифроване с краја на крај"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Није шифровано с краја на крај"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Послато"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Виђено"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Слање…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Сликај"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Још опција"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Сачувај на уређај"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Подели"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Чување…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Сачувано у ваше фотографије"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Чување није успело. Покушајте поново."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Дозволите Kyron-у да додаје у ваше фотографије да бисте ово сачували."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Сви системи раде"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Доступност"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Последњих 60 дана"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Пре 60 дана"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Данас"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database":
          MessageLookupByLibrary.simpleMessage("База података"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Пријава"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Недавни инциденти"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Нема инцидената у последњих 60 дана."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("У току"),
      "ui_status_no_data":
          MessageLookupByLibrary.simpleMessage("Нема података"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Детаљи"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron проверава сам себе на сваких 5 минута док ради. Сиви дан није имао провере."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Историја доступности још није доступна."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Неки системи имају проблема"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Сними гласовну поруку"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Спремно за слање"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Те поруке више нема."),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("Иди на поруку"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Гласовна порука"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Аутору се свиђа"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Додај фотографију или снимак"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Медији"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Гласовне поруке"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Ћаскање"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Позадина"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Искључи обавештења"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Престани да примаш обавештења о овом разговору"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("Више ти не могу слати поруке"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Ништа"),
      "ui_dm_wallpaper_photo":
          MessageLookupByLibrary.simpleMessage("Фотографија"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("Звук укључен."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Уклањање није успело. Покушај поново."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Профил"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Укључи звук"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Фотографије и снимци које делиш појављују се овде."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("Прикажи све"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Фотографије и снимци"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Овако ће изгледати твоје ћаскање."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Изгледа добро."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Измаглица"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Сумрак"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Жалфија"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Песак"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Тачкице"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Примени"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Тренутна"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Пошаљи без прегледа"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Претрага"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Објави"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Напиши поруку…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Пошаљи"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Послато"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Послато, али не свима."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Слање није успело. Покушај поново."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Пратилац"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Филтер"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Све"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Непрочитано"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Без одговора"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Скривено"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Ништа није скривено"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Разговори које уклониш са листе чекају овде, ако их пожелиш назад."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Премешта се у Скривено. Друга особа задржава свој, а враћа се ако неко од вас поново напише."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Врати"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Поново на твојој листи."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Нема одговарајућих разговора."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Ништа те не чека"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Сваки разговор се завршава твојом речју."),
      "ui_dm_preview_photo":
          MessageLookupByLibrary.simpleMessage("Фотографија"),
      "ui_dm_preview_photos":
          MessageLookupByLibrary.simpleMessage("Фотографије"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Видео"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Још нема порука"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Ти:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Јуче"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Поруке"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Подешавања порука"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Приватност"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Потврде о читању"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Када је ово искључено, други неће видети када си прочитао њихове поруке, а ти нећеш видети када су они прочитали твоје."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Прикажи док куцаш"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Особа којој пишеш види да пишеш."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Прегледи линкова"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Твој телефон отвара линк који шаљеш да би направио преглед, па сајт види захтев твог телефона. Kyron сервер никада не види линк."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Обавештења о порукама"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Поруке су шифроване од краја до краја. Kyron не може да их чита, и ништа овде то не мења."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("За:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Недавно"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Особе"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Нема никога са тим именом."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Пошаљи пробно обавештење"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron сервер још није подешен за слање обавештења, па ниједно не може да стигне. Проблем је код нас, не у твом телефону."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Овај телефон није регистрован за обавештења. Провери да ли су обавештења за Kyron дозвољена у подешавањима телефона, па покушај поново."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Обавештење није могло да се испоручи на овај телефон. Покушај поново за минут."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Послато. Требало би да стигне за неколико секунди."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Обавештења раде."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Још нема објава"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Нова заједница"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Назив"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Адреса се прави од назива."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Људи ће је наћи на адреси"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Ти ћеш бити власник. Слику, банер и модераторе можеш додати на њеној страници када буде направљена."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Почетна"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Објаве заједница на Почетној"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Објаве из твојих заједница појављују се и на Почетној. Када је искључено, остају овде у Заједницама, где свака показује шта је ново."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Твоја листа"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Број нових објава"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Прикажи колико је објава ново у свакој заједници откад си је последњи пут отворио."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Заједнице које водиш"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Овде су заједнице које покренеш или модерираш."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Власник"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Модератор"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Нове објаве"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Које водиш"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Подешавања заједница"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Откриј"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "Ниједна заједница се не поклапа."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Ништа ново"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Свака заједница је онаква какву си је оставио."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Још не водиш ниједну"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "Нема више чему да се придружиш"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "У свакој си заједници на Kyron-у. Покрени још једну."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Пробај другу реч или покрени заједницу с тим називом."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Напиши објаву"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Чланови:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Објављено"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Погледај"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Отвори"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("На мрежи"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Прикажи кад си на мрежи"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Људи којима пишеш виде зелену тачку док ти је Kyron отворен. Када је ово искључено, ни ти нећеш видети њихову."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Претражи људе и објаве"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Заједнице којима можете да се придружите"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Још нема ничега за гледање"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Овде ће се појавити фотографије и снимци које људи објављују."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Прати"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Избриши налог"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Овим се трајно брише ваш Kyron налог. То се не може опозвати."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Ваш профил, објаве, одговори, свиђања и поновне објаве"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Ваше поруке, укључујући оне које сте послали другима, и фотографије и гласовне поруке у њима"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Ваши пратиоци, људи које пратите и ваша подешавања"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Заједнице које сте покренули прелазе на модератора или члана који је најдуже у њима. Заједница у којој нема никог другог се затвара."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Избрисати ваш налог?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Ништа од тога нећете моћи да вратите."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Ваш налог је избрисан."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Избрисан налог"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Овај налог је избрисан, па се овде више не могу слати поруке."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Регистровали сте се преко Google-а? Уместо тога користите „Sign in with Google”."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Тај филтер није могуће учитати."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Видео није могуће снимити."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Филтер није могуће додати овом видеу, па се објављује онако како је снимљен."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Ваша објава већ има највећи број прилога."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Додавање филтера…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Блиц"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Сними видео"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Фотографија"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Видео"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Пријава преко Google-а је отказана."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("ПОКЛОНИ"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Још нико није послао поклон овој објави."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Поклон"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Поклони"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Новчићи"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Пошиљалац"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Пошиљаоци"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Тест новчићи: још се не могу исплатити."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Сачувано"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Објаве"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Коментари"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Прикажи још одговора"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Измењено"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Још"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Пратим"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Најбоље"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Најновије"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Сортирај коментаре: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "је послао/ла поклон вашој објави"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "је послао/ла \$gift вашем коментару"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "је послао/ла \$gift вашој објави"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Пошаљи поклон"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Измени објаву"),
      "ui_edit_post_left":
          MessageLookupByLibrary.simpleMessage("Можете је мењати још \$n мин"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Сачувај"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Под #\$tab још ништа није објављено."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Изаберите поклон"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Нема довољно новчића"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Тест новчићи: не могу се купити и немају новчану вредност."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Допуњује се \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 новчић"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("Новчићи: \$count"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("Имате \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Пошаљи \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift послато"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Покушај поново"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("15 минута након објављивања"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Измењено"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Сачувани коментари нису могли да се учитају"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Нема сачуваних коментара"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Додирните икону архиве испод коментара да бисте га задржали овде. Само ви видите шта чувате."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Одговор за \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Копирај"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Претражи"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Изабери све"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("Поклони: \$count"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 поклон"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати још објава."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Подсетници"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Шта је ново када вас није било и када вам се врате новчићи. Никад више од једног дневно."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Поклони"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("од 1 особе"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("од \$count особа"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("Највећи дародавац"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Није могуће учитати ко је послао поклоне."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Новости"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Разумем"),
      "ui_check_in_thanks":
          MessageLookupByLibrary.simpleMessage("Хвала. Читамо сваки одговор."),
      "ui_check_in_title": MessageLookupByLibrary.simpleMessage(
          "Како вам се засад свиђа Kyron?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Дан \$day вашег тестирања. Довољан је један додир."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Нешто што треба да поправимо или додамо? (необавезно)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Пошаљи"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Не сада"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Поново притисните Назад да бисте изашли из Kyron-а"),
    };

final messageLookup = MessageLookup();
