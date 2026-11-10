import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'kk';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Сөз, тіркес немесе #тег"),
      "about": MessageLookupByLibrary.simpleMessage("Туралы"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Жауап қосу"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage("Тіл қосу…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Келісу және жалғастыру"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Kyron аккаунтыңыз бар ма?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Пікірлер"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Әртүрлі адамдар, ашылу саны емес"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Белсенділік"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Ұнатулар"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Әзірге көрермендер жоқ"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Бұл жазбаны әлі ешкім ашпаған."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Жарияланды"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Сақтаулар"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Көрермендер"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("КҮНДІК КӨРЕРМЕНДЕР"),
      "and": MessageLookupByLibrary.simpleMessage("және"),
      "answerNumber": (Object a0) => "${a0}-жауап",
      "arLens": MessageLookupByLibrary.simpleMessage("AR линзасы"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Қолданба журналын тіркеу"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Барып-келу уақыты"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ТОКЕНДІ ТЕКСЕРУ"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Қайталау"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Қайталау"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Қазір эфир бастасаңыз, ешкім кіре алмайтын бөлмеде боласыз"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Қауымдастық құру"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Бұл не үшін? (міндетті емес)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("қайта кіре алмайды."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage(
              "осы тізімнен қайта кіре алмайды."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Оны жапсаңыз,"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("алдымен қосылыңыз"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("жақында"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage(
              "Өз атыңыздан жариялап жатырсыз"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("осы қауымдастықта жариялау"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Жаңа ғана"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Қайталау"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("1-тақырып"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Сіз үшін"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("бірдеңе бар."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("қазір сонда бара жатыр."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", емес"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("қозғалып жатырмын ба"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Дыбысты өшіру"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Дыбысты қосу"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Сіз үшін"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Қойындыларыңыз"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Қайталау"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Таңба (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("КҮНДІК КӨРЕРМЕНДЕР"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("жүктеу мүмкін болмады"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("бұл жазба"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Қосарыңыз бар ма? (міндетті емес)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("бұл жазба"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Аккаунттан"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Шығу"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңыз"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Құпия сөзді растаңыз"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("қазір емес"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Жүктелуде…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Жариялануда…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 сағ бұрын"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Оқиға сілтемесін көшіру"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Сіздің оқиғаңыз"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Аккаунтыңыз, жазбаларыңыз және түрткен нәрселеріңіз, осылайша"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Тақырып қосу"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("өзінікі."),
      "authorBlocked": (Object a0) => "${a0} бұғатталды",
      "authorPostsHidden": (Object a0) => "${a0} жазбаларын көрмейсіз",
      "block": MessageLookupByLibrary.simpleMessage("Бұғаттау"),
      "blockAuthor": (Object a0) => "${a0} бұғатталсын ба?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
          "Құрастыру мәліметтері көшірілді"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Жалғастыру арқылы келісесіз:"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Жалғастыру арқылы Қызмет көрсету шарттары мен Құпиялылық саясатымызға келісесіз"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Тіркелу арқылы келісесіз:"),
      "cancel": MessageLookupByLibrary.simpleMessage("Бас тарту"),
      "change": MessageLookupByLibrary.simpleMessage("Өзгерту"),
      "changeEmail":
          MessageLookupByLibrary.simpleMessage("Электрондық поштаны өзгерту"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңызды электрондық пошта арқылы растаңыз."),
      "checkKyronReachable":
          MessageLookupByLibrary.simpleMessage("Kyron қолжетімді ме, тексеру"),
      "clear": MessageLookupByLibrary.simpleMessage("Тазалау"),
      "close": MessageLookupByLibrary.simpleMessage("Жабу"),
      "closeCommunity": (Object a0) => "${a0} жабылсын ба?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Жабу"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Осы қауымдастықты жабу"),
      "communities": MessageLookupByLibrary.simpleMessage("Қауымдастықтар"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Шолудан біреуін табыңыз немесе өзіңіздікін құрыңыз."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Ыстық пікір айтыңыз (немесе жылы)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Ойыңызда не бар?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Тек сіз айта алатын нәрсені айтыңыз…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("Бұл белгі: жариялаңыз"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Жазыңыз, сөйлеңіз немесе дауыстап ойлаңыз"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Құпия сөзді растаңыз"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Қолдау қызметіне хабарласу"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Жазбалардың әлі тілі жоқ, сондықтан бұл лентаңызды әлі сүзбейді. Таңдауларыңыз оған дейін сақталады."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Жалғастыру"),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage(
          "Электрондық поштамен жалғастыру"),
      "copy": MessageLookupByLibrary.simpleMessage("Көшіру"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Оның орнына есепті көшіру"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google арқылы кіруді ашу мүмкін болмады. ${a0}",
      "couldNotSignOut": (Object a0) => "Шығу сәтсіз: ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
          "Суретке түсіру мүмкін болмады."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Профиліңде және жазбаларыңның астында көрсетіледі."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "«{query}» сұрауына сай ел жоқ."),
      "country_none": MessageLookupByLibrary.simpleMessage("Ел көрсетпеу"),
      "country_search": MessageLookupByLibrary.simpleMessage("Елдерді іздеу"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Профиліңде және жазбаларыңның астында көрсетіледі. Біреудің жазбаларын көргенде, елің оның Талдауында есептеледі, тек бес не одан көп адамдық топтарда және ешқашан атыңмен емес."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Телефоныңның баптауларынан"),
      "create": MessageLookupByLibrary.simpleMessage("Жасау"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Аккаунт жасау"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңызды жасаңыз"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Профиліңізді жасаңыз"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR линзасы"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Тікелей эфир"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Мәтіндік жазба"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Дауыстық жазба"),
      "delete": MessageLookupByLibrary.simpleMessage("Жою"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Бұл пікір жойылсын ба?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Бұл жазба жойылсын ба?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Бұл тіркемені сипаттаңыз"),
      "description": MessageLookupByLibrary.simpleMessage("Сипаттама"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID буферге көшірілді"),
      "done": MessageLookupByLibrary.simpleMessage("Дайын"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Бірдеңе жазғаннан кейін редакторды жабыңыз, сізге жоба ұсынылады."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} күн бұрын"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} сағ бұрын"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Жаңа ғана"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} мин бұрын"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Әлі ештеңе жазылмаған"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Сауалнама, әлі сұрақсыз"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Дәйексөз, әлі мәтінсіз"),
      "drafts": MessageLookupByLibrary.simpleMessage("Жобалар"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Профильді өңдеу"),
      "email": MessageLookupByLibrary.simpleMessage("Электрондық пошта"),
      "emailNotifications": MessageLookupByLibrary.simpleMessage(
          "Электрондық пошта хабарландырулары"),
      "explore": MessageLookupByLibrary.simpleMessage("Шолу"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Бұл құрылғыда бетті бақылау қолжетімсіз."),
      "feedTagDetail": (Object a0) =>
          "#${a0} тегімен әлі ештеңе жарияланбаған.",
      "follow_author": MessageLookupByLibrary.simpleMessage("{name} жазылу"),
      "followers": MessageLookupByLibrary.simpleMessage("Жазылушылар"),
      "following": MessageLookupByLibrary.simpleMessage("Жазылымдар"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Құпия сөзді ұмыттыңыз ба?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Көмек алу"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Google арқылы жалғастыру"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Google арқылы кіру"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google аяқталған кіруді Kyron-ға тек Android пен iOS жауап беретін сілтеме арқылы қайтарады, сондықтан ${a0} платформасында браузердің оны қайтаратын жері жоқ.\\n\\nЕгер Google арқылы Kyron аккаунтыңыз болса, сол мекенжаймен Электрондық поштамен жалғастыруды таңдап, Құпия сөзді ұмыттыңыз ба түймесін түртіңіз: құпия сөз орнату сілтемесін аласыз.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google арқылы кіруге телефон қолданбасы керек"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Google арқылы тіркелу"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Нұсқаулықтар және жиі қойылатын сұрақтарға жауаптар"),
      "handle": MessageLookupByLibrary.simpleMessage("пайдаланушы аты"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Анықтама және қолдау"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Анықтама орталығы"),
      "home": MessageLookupByLibrary.simpleMessage("Басты бет"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("Бір жолда"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Сіздің аккаунтыңыз"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Қауымдастықты ашу"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Жазба жазу"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("Жазбаны көру"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Профильді өңдеу"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Олар қашан белсенді"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Сіздің уақыт белдеуіңізде."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Жас"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Туған күнін көрсеткен {known} жеткен адамнан."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Күн сайын жеткен адамдар"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Олар бар қауымдастықтар"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Елдер"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Профилінде елі бар, қамтылған {known} адамнан."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Соңғы {days} күн"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Статистиканы жүктеу мүмкін болмады"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Оқырмандар"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Көрсетуге жететін үлкен топ әзірге жоқ."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Қалай өсуге болады"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Олар бақылайтын тақырыптар"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Ұнатулар"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Жаңа"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Жаңа оқырмандар"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Бұл кезеңде жазбаларыңыздың ешқайсысы ешкімге жетпеді."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Сізге жазылмаған"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Елдер — адамдар өз профилінде таңдағандары. Kyron ешкімнің қаласын не жынысын жинамайды, сондықтан олар үшін көрсететін ештеңе жоқ."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Ашулар"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} жетті · {likes} ұнату · {replies} жауап"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Жеткен адамдар"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Әр адам бір рет саналады: оған жазбаларыңыздың бірі алғаш рет көрсетілген немесе ол алғаш рет ашқан. Жаңа оқырмандар әлі де жазылулы; жазылудан бас тартқандар саналмайды."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Жауаптар"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Қайта жариялаулар"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Сақтаулар"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Аудиторияңыздың кім екені бұл кезеңде {floor} адам жазбаларыңызды көргенде көрсетіледі. Одан аз болса, бұл нақты бір адамды көрсетіп қоюы мүмкін."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Әзірге адам жеткіліксіз"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "Олардың {pct}%-ы сізге жазылып қойған: жазбаларыңыз көбіне таныстарға жетеді."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "Олардың {pct}%-ы әзірге сізге жазылмаған: жазбаларыңызды тауып жатыр."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "{reach} адамға жеттіңіз, алдыңғы кезеңнен {pct}% аз."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Соңғы {days} күнде {reach} адамға жеттіңіз."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "{reach} адамға жеттіңіз, шамамен алдыңғы кезеңдегідей."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Соңғы {days} күнде жазбаларыңызды ешбір жаңа адам көрмеді."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "{reach} адамға жеттіңіз, алдыңғы кезеңнен {pct}% көп."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "{reach} адамға жеттіңіз, алдыңғы кезеңнен {times}× көп."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Олардың көбі кез келген басқа тақырыпқа қарағанда {name} тақырыбын бақылайды."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Аудитория"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Шолу"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Жазбаңызды тапқандар жазылмас бұрын профиліңізге қарайды. Бет не логотип онда біреу бар екенін айтады."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Профиль суретін қосыңыз"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Не туралы жазатыныңызды бір жолмен айтыңыз, бейтаныс адам сізге жазылу оған не беретінін білсін."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Өзіңіз туралы жазыңыз"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{total} жазбаңыздың {without}-ында тақырып болмады. Тақырып жазбаны сол тақырыптың лентасына және оны бақылайтындардың алдына шығарады."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Жазбаларға тақырып қосыңыз"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} адам жазбаларыңызға жауап жазды, сіз {answered} жауап бердіңіз. Олар жазуға жететіндей мән берді: жауап оқырманды тұрақты қонаққа айналдырады."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Жауаптарға жауап беріңіз"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Аудиторияңыз {when} ең белсенді. Одан сәл бұрын жарияланған жазбаны қарсы алатын адамдар болады."),
      "ins_tip_best_time_t": MessageLookupByLibrary.simpleMessage(
          "Олар белсенді кезде жариялаңыз"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "Сізге жазылмаған {reached} адам жазбаларыңызды көрді, {gained} жазылды. Өзіңіз туралы мәтін мен жаңа жазбаларыңыз сізден не күтуге болатынын айтсын."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Оқырмандарды жазылушыға айналдырыңыз"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Бір жазба басқаларыңыз әдетте жететіннен {times}× көп адамға жетті. Оның нені басқаша жасағанын қарап, соны көбірек жасаңыз."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "Нәтиже бергенін көбірек жасаңыз"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Жазбаларыңызды көретіндердің көбі {name} қауымдастығында. Онда жариялау сізді қалғандарының алдына шығарады."),
      "ins_tip_post_in_community_t": MessageLookupByLibrary.simpleMessage(
          "{name} қауымдастығында жариялаңыз"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "{days} күнде {posts} рет жарияладыңыз. Әр жазба табылудың тағы бір мүмкіндігі, ал тұрақты ырғақ сізді оқырмандардың лентасында ұстайды."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Жиірек жариялаңыз"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Соңғы {days} күнде жариялаған жоқсыз. Жазбасыз ештеңе ешкімге жетпейді."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Бірдеңе жариялаңыз"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Статистика"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Үздік жазбалар"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Алдыңғы {days} күнмен салыстырғанда"),
      "interest_add": MessageLookupByLibrary.simpleMessage("Қызығушылық қосу"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Ретін өзгерту үшін сүйреңіз"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Жолаққа ең көбі бес қойынды сыяды. Басқасын қосу үшін біреуін алып тастаңыз."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Жазылымдар"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Сіз үшін"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Адамдар хэштегтерді қолдана бастағанда, олар осында көрінеді."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Қазір трендте"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Бейнелер"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Қойындыларыңыз"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Ол екеуіңізден де жоғалады."),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
          "Ол тізбектен алынып тасталады."),
      "join": MessageLookupByLibrary.simpleMessage("Қосылу"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Өңдеуді жалғастыру"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron экрандары сіздің тіліңізде. Қай сөз дұрыс естілмесе, Пікір жіберу арқылы бізге айтыңыз."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Тілдер"),
      "leave": MessageLookupByLibrary.simpleMessage("Шығу"),
      "leaveCommunity": (Object a0) => "${a0} қауымдастығынан шығасыз ба?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Қайта кіргізу"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("1 бет ашық"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Клип қосу"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF қосу"),
      "literaladdAHashtag": MessageLookupByLibrary.simpleMessage("Хэштег қосу"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Сурет қосу"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Сауалнама қосу"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Бейне қосу"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Қызығушылық қосу"),
      "literaladdLabelAsATab": (Object a0) => "${a0} қойынды ретінде қосу",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Қолданба тілі"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Қолданба нұсқасы"),
      "literalblockAuthor": (Object a0) => "${a0} бұғаттау",
      "literalblockAuthor2": (Object a0) => "${a0} бұғатталсын ба?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Бұл аккаунт бұғатталсын ба?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Жауаптан бас тарту"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Қайта тексеру"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Галереядан таңдау"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Кэшті тазалау"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Барлық беттерді жабу"),
      "literalcloseTabLabel": (Object a0) => "${a0} жабу",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Браузерді жабу"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0} жабылсын ба?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Қолдау қызметіне хабарласу"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Мазмұн тілдері"),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("Сілтемені көшіру"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Жазба сілтемесін көшіру"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Жазба мәтінін көшіру"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Мәтінді көшіру"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Қауымдастықтарды жүктеу мүмкін болмады"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF жүктеу мүмкін болмады"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Хабарландыруларды жүктеу мүмкін болмады"),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
          "Мүшелерді жүктеу мүмкін болмады"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Бұл жазбаларды жүктеу мүмкін болмады"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Бұл әңгімені жүктеу мүмкін болмады"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Бұл тізімді жүктеу мүмкін болмады"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Бұл жазбаны жүктеу мүмкін болмады"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Бұл жауапты жүктеу мүмкін болмады"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Танымал тегтерді жүктеу мүмкін болмады"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Қауымдастықтарыңызды жүктеу мүмкін болмады"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Хабарларыңызды жүктеу мүмкін болмады"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Бұл қауымдастықты ашу мүмкін болмады"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Жауапты жариялау мүмкін болмады."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Іздеу жұмыс істемеді"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Шығу сәтсіз: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} бет ашық",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Мұқаба суреті"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Трафикті үнемдеу"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("Жазбаны жою"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Адамдарды табу"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("Жауап бермеңіз"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Жоба сақталды"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Қазір пікір жіберу мүмкін емес"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Мәтін өлшемі"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF бапталмаған"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Басқа қолданбаға беру"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Құпия сөзді жасыру"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Бұл жазбаны жасыру"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Оны жасырып, бізден осындайларды азырақ көрсетуді сұрайды"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Қалай әрекет ету керек"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Жазуды жалғастыру"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron жауап бермеді"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} күні",
      "literalleaveCommunityName": (Object a0) =>
          "${a0} қауымдастығынан шығасыз ба?",
      "literallensNameFaceLens": (Object a0) => "${a0}, бет линзасы",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Ұнатылған жазбалар"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Сілтеме көшірілді"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Модератор ету"),
      "literalmuteAuthor": (Object a0) => "${a0} дыбысын өшіру",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Бұл тізбектің дыбысын өшіру"),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
          "Сөздердің немесе тегтердің дыбысын өшіру"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Дыбысы өшірілген және бұғатталған аккаунттар"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Дыбысы өшірілді. Хабарландырулар келмейді."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Бұл құрылғыдағы ешбір қолданба ${a0} сілтемелерін ашпайды.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Бұл құрылғыдағы ешбір браузер сілтемені қабылдамады."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Әзірге DID жоқ"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Жобалар жоқ"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Әзірге қызығушылықтар жоқ"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Әзірге ұнатулар жоқ"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Әзірге хабарлар жоқ"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Жаңа жазылушылар жоқ"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Әзірге жазбалар жоқ"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Әзірге жауаптар жоқ"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Әзірге қайта жариялаулар жоқ"),
      "literalnoTrendingTagMatchesThat":
          MessageLookupByLibrary.simpleMessage("Сәйкес танымал тег жоқ"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Ешкім табылмады"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Ешкім алып тасталмаған"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Мұнда әлі ешкім жоқ"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Қызық емес"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Ештеңе табылмады"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Әзірге трендте ештеңе жоқ"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Журналда әлі ештеңе жоқ"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Сәйкестік жоқ"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Дыбысы өшірілгендер жоқ"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Әзірге көретін ештеңе жоқ"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Оқылмағандар жоқ"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("Мұны тек иесі өзгерте алады"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Жауапты ашу"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Kyron хатын ашыңыз"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Құпия сөз және кіру"),
      "literalpostInCommunityName": (Object a0) =>
          "${a0} қауымдастығына жариялау",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "${a0} қауымдастығына жариялау",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Үстіне өз сөзіңізді жазып жариялаңыз"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Негізгі тіл"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push хабарландырулар"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Тексерілуде…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Дауыстық жазба жазу"),
      "literalrecordAgain": MessageLookupByLibrary.simpleMessage("Қайта жазу"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Модераторлықтан алу"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Қауымдастықтан алып тастау"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Сақталғандардан алып тастау"),
      "literalremoveLabel": (Object a0) => "${a0} алып тастау",
      "literalremoveLanguageEnglishname": (Object a0) =>
          "${a0} тілін алып тастау",
      "literalremoveMemberDisplayname": (Object a0) =>
          "${a0} алып тасталсын ба?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Сауалнаманы алып тастау"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Бұл жауапты алып тастау"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Бұл әңгімені жою"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Бұл сауалнаманы алып тастау"),
      "literalreportAuthor": (Object a0) => "${a0} туралы шағымдану",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Жазба туралы шағымдану"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Кодты қайта жіберу"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Сақталған жазбалар"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Бірдеңе айтыңыз"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "${a0} қауымдастығына бірдеңе айтыңыз",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Іздеу сәтсіз"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Қайта жіберу"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "${a0} с кейін қайта жіберу",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Пікір қалдыру"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Сілтемені жіберу"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Жіберілді. Бұл №${a0} есеп.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "Құпия сөз орнатып, жалғастырыңыз"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Журналды қолдау қызметімен бөлісу"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Бұл қауымдастықпен бөлісу"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Бұл бетпен бөлісу"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Бұл профильмен бөлісу"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Бөлісу…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Дәйексөзбен бөлісу"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Осындайларды көбірек көрсету"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Құпия сөзді көрсету"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Нәтижелерді көрсету"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Қауымдастық құру"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Жазуды бастау"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Жүктеуді тоқтату"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Бұл жазба мен оның жауаптарын көрмеу"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Оқиғалар таспасы, ${a0} элемент",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Камераны ауыстыру"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Біреуді белгілеу"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Суретке түсіру"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Ауыстыру үшін баннерді немесе суретті түртіңіз"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Ішіндегі сілтемені түртіңіз"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Сурет пен мұқаба қосу үшін түртіңіз"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("Болмады. Қайталап көріңіз."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("Бұл GIF жүктелмеді."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Бұл сілтемені мұнда ашу мүмкін емес."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Камера жабық"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Бұл қауымдастық"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Бұл жауап енді жоқ"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Жазбаны аудару"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Дыбысты өшіру"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Дыбысты қосу"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Біздің біреуімізді пайдалану"),
      "literalverificationCodeResent":
          MessageLookupByLibrary.simpleMessage("Растау коды қайта жіберілді."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Растау сәтсіз: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Электрондық поштаны растау"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Көрермендер, ұнатулар, сақтаулар және пікірлер"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kyron нені сақтайды"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Бұл қолданба не істеп жатты"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Не істедіңіз, не күттіңіз, не болды "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Жариялағаныңыз — сіздікі"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Kyron қазір қолжетімді ме"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Кім жауап бере алады"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Кімді белгілегіңіз келеді?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Сіз барлық танымал тегтерге жазылып қойғансыз"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Барлығын көрдіңіз"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Сіз ешбір қауымдастықта емессіз"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Сіз шықтыңыз."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) =>
          "Сіз ${a0} қауымдастығынан шықтыңыз",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Сіз әлі ештеңе жарияламадыңыз"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Тағы жүктеу"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Журнал тазаланды"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Журнал көшірілді"),
      "logIn": MessageLookupByLibrary.simpleMessage("Кіру"),
      "logOut": MessageLookupByLibrary.simpleMessage("Шығу"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Шығасыз ба?"),
      "login": MessageLookupByLibrary.simpleMessage("Кіру"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Кіру сәтсіз. Деректеріңізді тексеріңіз."),
      "manage": MessageLookupByLibrary.simpleMessage("Басқару"),
      "menu": MessageLookupByLibrary.simpleMessage("Мәзір"),
      "message": MessageLookupByLibrary.simpleMessage("Хабар"),
      "messages": MessageLookupByLibrary.simpleMessage("Хабарлар"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("Барлық әңгімелерді оқыдыңыз."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Біреудің профилін ашып, әңгіме бастау үшін Хабар түймесін түртіңіз."),
      "mute": MessageLookupByLibrary.simpleMessage("Дыбысын өшіру"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
          "Дыбысы өшірілгендер мен бұғатталғандар"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
          "Дыбысы өшірілген сөздер мен тегтер"),
      "name": MessageLookupByLibrary.simpleMessage("Аты"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> экраны"),
      "newEmailAddress": MessageLookupByLibrary.simpleMessage(
          "Жаңа электрондық пошта мекенжайы"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Жаңа құпия сөз"),
      "newPost": MessageLookupByLibrary.simpleMessage("Жаңа жазба"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Қазір емес"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Жіберілмеді. Қайталау үшін түртіңіз"),
      "nothingMatchesQuery": (Object a0) =>
          "Kyron-да \"${a0}\" сұрауына сәйкес ештеңе жоқ",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Көшіретін ештеңе жоқ"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Ұнатулар, жауаптар және жаңа жазылушылар осында келеді."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Сізге жазылған адамдар осында көрінеді."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Біреу жазбаңызды ұнатса, ол осында көрінеді."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Жазбаларыңызға жауаптар осында келеді."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Біреу сізді қайта жарияласа, ол осында көрінеді."),
      "notifications": MessageLookupByLibrary.simpleMessage("Хабарландырулар"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("Браузерде ашу"),
      "or": MessageLookupByLibrary.simpleMessage("немесе"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("Бет табылмады"),
      "password": MessageLookupByLibrary.simpleMessage("Құпия сөз"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Құпия сөз тым қысқа"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Қызығушылықтарыңызды таңдаңыз"),
      "post": MessageLookupByLibrary.simpleMessage("Жариялау"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Жазба статистикасы"),
      "postInCommunity": (Object a0) => "${a0} қауымдастығына жариялау",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
          "Жариялаңыз, айтыңыз, көрсетіңіз."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Жазба мәтіні көшірілді"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Құпиялылық саясаты"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Профиль жаңартылды"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Өзі туралы"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Ел"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Көрсетілетін аты"),
      "profile_location":
          MessageLookupByLibrary.simpleMessage("Орналасқан жері"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Ауыстыру үшін түртіңіз"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Веб-сайт"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push хабарландырулар"),
      "quote": MessageLookupByLibrary.simpleMessage("Дәйексөз келтіру"),
      "quotePost":
          MessageLookupByLibrary.simpleMessage("Жазбадан дәйексөз келтіру"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Адаммен байланысу"),
      "remove": MessageLookupByLibrary.simpleMessage("Алып тастау"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Бұл әңгіме жойылсын ба?"),
      "removeMember": (Object a0) => "${a0} алып тасталсын ба?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Бұл хабар жойылсын ба?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Жауаптар, жазылымдар және аталулар"),
      "repliesPolicy": (Object a0) => "Жауаптар: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Жауап беру"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Кез келген адам қатыса алады"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Кез келген адам бұл жазбаны көре, қайта жариялай және дәйексөз келтіре алады."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-дағы кез келген адам бұл жазбаға жауап бере алады."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Сізге жазылғандар"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Бұл жазбаға тек жазылушыларыңыз жауап бере алады."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Сіз атаған адамдар"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Тек осы жазбада @атаған адамдарыңыз жауап бере алады."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Ешкім жауап бере алмайды"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Жауаптар өшірулі. Сіз бәрібір жауап бере аласыз."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Кім жауап бере алады?"),
      "report": MessageLookupByLibrary.simpleMessage("Шағымдану"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Есеп көшірілді. Оны қолдау қызметіне жазылатын хатқа қойыңыз."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Шағым жіберілді"),
      "repost": MessageLookupByLibrary.simpleMessage("Қайта жариялау"),
      "reset": MessageLookupByLibrary.simpleMessage("Қалпына келтіру"),
      "resetPassword": MessageLookupByLibrary.simpleMessage(
          "Құпия сөзді қалпына келтіріңіз"),
      "retry": MessageLookupByLibrary.simpleMessage("Қайталау"),
      "save": MessageLookupByLibrary.simpleMessage("Сақтау"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Жобаны сақтау"),
      "saySomething": (Object a0) => "${a0} қауымдастығына бірдеңе айтыңыз",
      "search": MessageLookupByLibrary.simpleMessage("Іздеу"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Аты немесе пайдаланушы аты бойынша іздеу"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Қауымдастықтарды іздеу"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF іздеу"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Тілдерді іздеу"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Танымал тегтерді іздеу"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Қауіпсіздік ескертулері және аккаунт өзгерістері"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Қолданба интерфейсінің тілін таңдаңыз."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Лентаңызда қандай тілдер көрсетілетінін таңдаңыз. Ешқайсысын таңдамасаңыз, барлық тілдер көрсетіледі."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Лентадағы аудармалар үшін негізгі тілді таңдаңыз."),
      "send": MessageLookupByLibrary.simpleMessage("Жіберу"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Растауды жіберу"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Қате туралы есеп жіберу"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Пікір жіберу"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Шағым жіберу"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Қолдау қызметіне жіберу"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Қызмет күйі"),
      "settings": MessageLookupByLibrary.simpleMessage("Параметрлер"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Қолданба журналын қолдау қызметімен бөлісу"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Kyron-ға кіру"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Кірген аккаунт"),
      "signupFailed": (Object a0) => "Тіркелу сәтсіз: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Қалу"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron енді ғана басталып жатыр, және мұны шынымен түзете алатын адамға жетудің ең жылдам жолы — өтініш ашу. Не істеп жатқаныңызды және не болғанын айтыңыз."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Қолданбада әлі қолдау жәшігі жоқ, сондықтан бұл экран сізді ешқайда апармайтын пішіннің орнына шынымен қадағаланатын жерге бағыттайды."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Қолданба журналы"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Не жетіспейтінін немесе не бұзылғанын айтыңыз"),
      "terms": MessageLookupByLibrary.simpleMessage("Қызмет көрсету шарттары"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Мәтін, дауыс және бейне, оларды жасайтын адамдар және олар сөйлесетін бөлмелер."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "Редакторда Жариялау түймесі жоқ"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Қараңғы"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Әрқашан қараңғы"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Күңгірт"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Жұмсағырақ қараңғы, қараның орнына көгілдір сұр"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Ашық"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Әрқашан ашық"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Жүйе"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Телефонның ашық немесе қараңғы параметріне сай"),
      "translate": MessageLookupByLibrary.simpleMessage("Аудару"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Аударма әлі қосылмаған. Лентаңызда әлі ештеңе аударылмайды; бұл оған дейін есте сақталады."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Бұл Kyron-ның өз сөздерін, Flutter өзі салатын интерфейс бөліктерін, күндер мен сандарды және оңнан солға жазылатын тілдер үшін қолданба орналасуының бағытын өзгертеді."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Қайталап көру"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Құпиялылық саясаты"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Қызмет көрсету шарттары"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Кейін"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Қолданба және құрылғы"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Бұл дәйексөз адамдарды алаяқтықтан сақтандыру үшін еді."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Шешім неге қате деп ойлайтыныңызды жазыңыз: жазба нені білдірді, команда нені байқамай қалуы мүмкін немесе ереже неге сәйкес келмейді. Оны шешім қабылдаған адам емес, басқа біреу оқиды."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Апелляцияңыз"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Кемінде \$count таңба жазыңыз. Әр шешімге бір рет апелляция бере аласыз."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Апелляцияны жіберу"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Апелляция жіберілді. Шешім шыққанда хабарландыру аласыз."),
      "ui_appeal_title": MessageLookupByLibrary.simpleMessage(
          "\$number ісі бойынша апелляция"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Сыртқы түр"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Ашық, қараңғы немесе телефонға сай"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Бұрын"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-да бір-біріңізді көрмейсіз, ал араларыңыздағы жазылымдар алынып тасталады. Оған хабарланбайды."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Құрамында"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Не үшін (міндетті емес)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Тек модераторлар жаза алады"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Хабарландырулар үшін. Қауымдастықтағы барлығы оқып, реакция білдіре алады."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Фото не сауалнама қосу"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Фотолар мен бейнелер"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Чатты жабу"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Онда енді ешкім оқи да, жаза да алмайды. Мұны қайтару мүмкін емес."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Бұл чатты жабу керек пе?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Көшірілді"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Хабар барлығы үшін жойылады. Kyron тексеру үшін көшірмесін сақтайды."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Хабар чаттағы барлығы үшін жойылады."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Чатты өңдеу"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Өңдеу"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("өңделді"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Хабарламаңызды өңдеп жатырсыз"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Бұл чатты ашу мүмкін болмады."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Чаттар"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("Чатқа қосылу"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Қауымдастықтың чаттарын көріп, қатысу үшін оған қосылыңыз."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Қосылғандар: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Чаттан шығу"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Қауымдастықта жүргенде оны оқи бере аласыз."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Мұнда тек иесі мен модераторлар жаза алады."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Дыбысын өшіру"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Одан хабарландыру келмейді және ол Хабарламалар санына кірмейді."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Чат атауы"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Жаңа чат"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Әзірге чаттар жоқ."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Әзірге чаттар жоқ. Қауымдастық үшін біреуін ашыңыз."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Қауымдастық чаттары өтпелі шифрланбаған. Қауымдастық модераторлары мен Kyron оларды оқи алады."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Жоғарыға бекіту"),
      "ui_cchat_poll_add": MessageLookupByLibrary.simpleMessage("Жауап қосу"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Сауалнаманы жабу"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Жабылды"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Барлығы әр жауапты қанша адам таңдағанын көреді, бірақ кім екенін ешқашан көрмейді."),
      "ui_cchat_poll_multiple": MessageLookupByLibrary.simpleMessage(
          "Бірнеше жауап таңдауға рұқсат беру"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Жаңа сауалнама"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Біреуін таңдаңыз"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("\$n-жауап"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Сауалнама: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Сұрақ"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Әр жауап сауалнамада бір рет қана бола алады."),
      "ui_cchat_poll_several": MessageLookupByLibrary.simpleMessage(
          "Бір немесе бірнешеуін таңдаңыз"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("Жауап бергендер: \$count"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Осы чаттан іздеу"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Осы чаттан іздеу"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Ештеңе табылмады."),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("Бұл чатты енді көре алмайсыз."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Баяу режим"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Хабарлар арасында қанша күту керек. Модераторларға қатысты емес."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 сағат"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n минут"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Баяу режим: әр \$seconds секунд сайын бір хабар"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Өшірулі"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n секунд"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Көрермен ретінде оқып, реакция білдіре аласыз. Жазу үшін қосылыңыз."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Бұл хабарлама көрсету үшін тым ескі."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Таңдағандарыңыздың бірі жіберу үшін тым үлкен, сондықтан қосылмады."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("Дыбысын қосу"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Бекітуден алу"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Дауыстық хабарлама жазу"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Сіз"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Қауымдастықтар"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Бұл не үшін? (міндетті емес)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Жазбалар:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Мазмұн және көрсету"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "Лентаңызды жүктеу мүмкін болмады"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Ұнатқан жазбаларыңызды жүктеу мүмкін болмады"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Профиліңізді жүктеу мүмкін болмады"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Сақталған жазбаларыңызды жүктеу мүмкін болмады"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Орталықсыздандырылған ID"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Ақауларды жою"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Топтар"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Топтар жоқ"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Мұнда сіз мүше топтар мен қосылған қауымдастық чаттары көрсетіледі."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "\$count чатқа дейін бекітуге болады. Алдымен біреуін босатыңыз."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Бекітілген"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Ұнағандар"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Сақталғандар"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Мұнда әлі ештеңе жоқ"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Бірнеше аккаунтқа жазылыңыз, олардың жазбалары осында көрінеді."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Жазылғандарыңыздан ештеңе жоқ"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Адамдар жазған сайын жазбалар осында көрінеді."),
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("Әлсіреп барады"),
      "ui_feed_signal_less": MessageLookupByLibrary.simpleMessage("Қызық емес"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Осындайды көбірек көрсету"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Алып тасталды"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Таспа сигналдарыңыз"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Жазбада Осындай жазбаларды көбірек көрсету немесе Бұл маған қызық емес түймесін түртіңіз, ол осында шығады."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Әзірге ештеңе жоқ"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Көбірек көрсету мен Қызық емес таспаларыңызға не айтады"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Олар Басты бет пен Шолуды, негізінен әр жазбаның тақырыбы бойынша қалыптастырады. Әрқайсысы ай сайын екі есе әлсірейді және алты айдан кейін есептелмейді. Қазір тоқтату үшін біреуін алып тастаңыз."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Клипі бар жазбалар осында көрінеді."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Әзірге бейнелер жоқ"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Пікір"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Kyron-да адамдарды табыңыз"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Аккаунттан"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Адам қосу"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Қосу"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Топ атауын қосу"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Қабылдамау"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Бұл топтағы хабарлар басқа кез келген сөйлесу сияқты шеткі нүктелер арасында шифрланған."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor қосты: \$users"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor әкімші етті: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor топ құрды"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor жаңа адамдардың мүше ретінде қосылуын белгіледі"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor жаңа адамдардың көрермен ретінде қосылуын белгіледі"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor шықты"),
      "ui_group_event_member":
          MessageLookupByLibrary.simpleMessage("\$actor мүше етті: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor иелікті берді: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor алып тастады: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor топ атын \$title деп өзгертті"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor көрермен етті: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Топта ең көбі \$count адам бола алады."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Қол көтерілді. Әкімшілерге хабарланды."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Жазғысы келеді: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Жазғысы келеді"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Кейін қосылғандар көрермен ретінде кіреді"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Топтан шығу"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Ол тізіміңізден жоғалады, кейін не айтылғанын көрмейсіз. Біреу сізді қайта қосуы керек болады."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Бұл топтан шығасыз ба?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Жазуға рұқсат беру"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Қолды түсіру"),
      "ui_group_make_admin": MessageLookupByLibrary.simpleMessage("Әкімші ету"),
      "ui_group_make_owner": MessageLookupByLibrary.simpleMessage("Иесі ету"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Көрермен ету"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count мүше"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Мүшелер"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Топ атауы"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Алдымен топқа атау беріңіз."),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("Топтық чат құру"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Иесі біреу ғана. Сіз әкімші болып қаласыз."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("\$name иесі болсын ба?"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("Қол көтеру"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Топтан алып тастау"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Әкімшіліктен алу"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Сіз енді бұл топта емессіз."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Атын өзгерту"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Әкімші"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Мүше"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Көрермен"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Көрермен ретінде мұнда оқып, реакция бере аласыз."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Көрермендер оқи алады, реакция бере алады және жазуға рұқсат сұрап қол көтере алады."),
      "ui_group_suggested":
          MessageLookupByLibrary.simpleMessage("Ұсынылғандар"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Профильді көру"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("сіз"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Сіз көрерменсіз"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Анықтама"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Белгіленді. Бұл сізге не көрсетуді таңдауға көмектеседі."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Қосылу"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Қосылды"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Тіл"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Тілді таңдаңыз"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Құқықтық ақпарат"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Ұнату"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Ұнатылған жазбалар"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Ұнатқан жазбаларыңыз осында, ең жаңалары алдымен көрінеді."),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Сілтеме көшірілді"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Енді оның жазбаларын көрмейсіз. Оған хабарланбайды."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Әзірге ұнатулар жоқ"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Бұл сүзгілерге сәйкес жазба жоқ."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Әзірге сақталғандар жоқ"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңыз жаңартылды"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "\$number ісі бойынша апелляцияңыз қанағаттандырылды"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "\$number ісі бойынша апелляцияңызды қайта қарадық, шешім күшінде қалады"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңыз біржола бұғатталды"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Іс \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("сізге жазылды"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("жазбаңызды ұнатты"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("сізді атап өтті"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Әзірге аталым жоқ"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Біреу жазбада не жауапта сіздің @атыңызды жазса, ол осында көрсетіледі."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Ескілері"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Қауымдастық чатындағы хабарламаңыз жойылды"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Сіз жариялаған бір нәрсе жойылды"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Жазбаңыз жойылды"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Жауабыңыз жойылды"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("жазбаңызға жауап берді"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Сіз шағымданған нәрсе бойынша шара қолдандық. Хабарлағаныңызға рахмет."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Сіз шағымданған нәрсені қарап шығып, ережелерімізді бұзғанын анықтамадық."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Шағым себебі: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("жазбаңызды бөлісті"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "\$number ісі бойынша шешімді жойдық"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңыз тоқтатылған"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңыз \$date дейін тоқтатылған"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Барлығы"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Жазылушылар"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Ұнатулар"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Аталымдар"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Жауаптар"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Осы аптада"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Бүгін"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңыз ескерту алды"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Кеше"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Дайын"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Өткізіп жіберу"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Бұл бұрын ашылған."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Мерзімі өтті"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Мұны ашу мүмкін болмады."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Бір рет ашылады, содан кейін Kyron-нан жойылады."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Бір рет көру"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Ашылды"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("\$total ішінен \$count ашты"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Мұны тек сіз жіберген адамдар ғана бір рет аша алады."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Бір рет көруге жіберу"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Көру үшін түртіңіз"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Кідірту"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Ойнату"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Ол профиліңізден және барлығының лентасынан алынып тасталады. Оған жауаптар да бірге кетеді."),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("Жазба жойылды"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("Жазба жасырылды"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Жазба мәтіні көшірілді"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Жарияланған аралық"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Жасырылды. Осындайларды азырақ көрсетеміз."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Параметрлер"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Құпиялылық"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Қосатын нәрсе бар ма? (міндетті емес)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Команда шешім қабылдағанда хабарландыру аласыз, оны «Шағымдарыңыз» бөлімінде бақылай аласыз."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Бұл адамды енді көргіңіз келмесе, сол мәзірден оның дыбысын өшіріп немесе бұғаттай аласыз."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Бір нәрсеге екі рет шағымдану оның салмағын арттырмайды: әр адамнан бір шағым сақтаймыз."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Шағымыңыз ол адамға көрсетілмейді. Жойылса да тексеруге болатындай, сіз шағымданған нәрсенің көшірмесін сақтаймыз."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Шағымыңыз қабылданды және тексеруді күтуде. Ол адамға кім шағымданғанын айтпаймыз."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Шағымдарыңызды көру"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Не дұрыс емес екенін айтыңыз"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Хабарлағаныңыз үшін рақмет"),
      "ui_report_what_account": MessageLookupByLibrary.simpleMessage(
          "\$name аккаунтында не дұрыс емес?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Бұл хабарламада не дұрыс емес?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("Бұл жазбада не дұрыс емес?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("Бұл жауапта не дұрыс емес?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Қауымдастық чатындағы хабарлама"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Жазба"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Жауап"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Шара қолданылды"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Шешілген күні: \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Ереже бұзылмаған"),
      "ui_reports_failed":
          MessageLookupByLibrary.simpleMessage("Шағымдарыңыз жүктелмеді"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Соңғы 90 күнде неге шағымданғаныңыз және оның нәтижесі. Команда шешім қабылдағанда хабарландыру аласыз. Сіз шағымданған адам кімнің шағымданғанын ешқашан білмейді."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Шағымдар жоқ"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Жазбаға, жауапқа, хабарламаға немесе аккаунтқа шағымданғанда, ол осында нәтижесімен бірге көрсетіледі."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("Қаралуда"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Шағым күні: \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Неге шағымданғаныңыз және нәтижесі"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Шағымдарыңыз"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Балалар қауіпсіздігі"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Кәмелетке толмағандарға қауіп төндіретін немесе оларды сексуализациялайтын кез келген нәрсе."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Нысаналы қорлау, қоқан-лоқы немесе қалаусыз байланыс."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Адамдарға кім екені үшін шабуыл жасау."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Заңсыз нәрсені сату немесе жарнамалау."),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("Басқа адамның атын жамылу."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Шығармаңызды немесе тауар белгіңізді рұқсатсыз пайдаланады."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Денсаулық, сайлау немесе оқиғалар туралы жаңылыстыратын мәлімдемелер."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Өзіне зиян келтіруді насихаттау немесе көрсету."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Ескертусіз көрсетілген жыныстық мазмұн."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Бұлардың ешқайсысы емес. Не дұрыс емес екенін айтыңыз."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Қайталанатын, жаңылыстыратын немесе қалаусыз жарнама."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Зорлық-зомбылықпен қорқыту, оны дәріптеу немесе оған итермелеу."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Қудалау немесе буллинг"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Өшпенділік сөзі"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Заңсыз тауарлар немесе қызметтер"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Басқа адамның атын жамылу"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Зияткерлік меншік"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Жалған ақпарат"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Суицид немесе өзіне зиян келтіру"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Ересектерге арналған контент"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Басқа нәрсе"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Спам"),
      "ui_rule_violence": MessageLookupByLibrary.simpleMessage(
          "Зорлық-зомбылық немесе қорқыту"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Сақталған жазбалар"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Жазбаны осында сақтау үшін оның мұрағат белгішесін түртіңіз. Сақтағандарыңызды тек сіз көресіз."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Пайдаланушы аты немесе көрсетілетін аты бойынша іздеңіз."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Тазалау"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Жарияланғанның бәрінен іздеу"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Сүзгілер"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("Адамдарды іздеу"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Жазбаларды іздеу"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Параметрлер"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Қолданба және құрылғы"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Мазмұн және көрсету"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Трафикті үнемдеу"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Ойыңызбен бөлісіңіз"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Анықтама мақалаларын шолу"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Тілді таңдаңыз"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Кімнің дыбысын өшірдіңіз немесе бұғаттадыңыз"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Хабарландыру параметрлері"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Профиліңіз және байланыс деректеріңіз"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Аккаунтқа оралу үшін қайта кіруіңіз керек болады."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Қауіпсіздік параметрлері"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Құпия сөзді растаңыз"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("Бір жолда"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage(
              "Жаңа электрондық пошта мекенжайы"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Жаңа құпия сөз"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Не болды"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Біздің командадан көмек алу"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Бөлісу"),
      "ui_share_quote":
          MessageLookupByLibrary.simpleMessage("Дәйексөз келтіру"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Хабарламамен жіберу"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron-дағы адамдарға"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Бұл жазбамен бөлісу"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Не туралы болды"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңыз біржола бұғатталды"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Жауап, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Апелляция"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Бұл шешімге апелляция беру"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Бұл шешімге енді апелляция беру мүмкін емес. Бірдеңе дұрыс болмаса, қолдау қызметіне жазыңыз."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Апелляция қаралуда"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Апелляция қанағаттандырылды"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Командадағы басқа біреу оны қайта қарап жатыр. Шешім шыққанда хабарландыру аласыз."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Бұл қате деп ойласаңыз, \$date дейін қайта қарауды сұрай аласыз. Шешімді командадағы басқа біреу қабылдайды."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Апелляция берілді: шешім күшінде қалады"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Іс \$number. Ереже: \$rule. Команда былай деп жазды:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Аккаунтты жою бұғатты алмайды: сол электрондық пошта мекенжайымен ашылған жаңа аккаунт та бұғатталған күйде басталады."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Біржола бұғатталған"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Тек осы бет, апелляциялар, қолдау және аккаунтты жою ғана жұмыс істейді."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Апелляция беруге болады"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Іс \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Шешім күні: \$date"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңызға қатысты шешімдер"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңызды жою"),
      "ui_standing_details": MessageLookupByLibrary.simpleMessage("Толығырақ"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Толығырақ және апелляция беру"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Аяқталу күні: \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңыз жақсы күйде"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Ешқандай шектеу жоқ."),
      "ui_standing_load_failed":
          MessageLookupByLibrary.simpleMessage("Аккаунт күйі жүктелмеді"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Хабарлама жойылды"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңыз туралы ешқандай шешім қабылданбаған. Егер команда бір кезде сіздің бір нәрсеңізді жойса немесе аккаунтыңызды шектесе, ол мұнда себебімен бірге көрсетіледі және апелляция бере аласыз."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Апелляция беретін ештеңе жоқ: шешімнің күші жойылды."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Жазба жойылды"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Қайта тексеру үшін төмен тартыңыз."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Kyron ережелерін оқу"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Жауап жойылды"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("Күші жойылды"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "\$date күні күші жойылды. Жойылғанның бәрі қайтарылды, енді ешқандай шектеу қолданылмайды."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("Ереже: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Шығу"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Тоқтатылған"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Оқи аласыз, бірақ жариялай, жауап бере, жазыла немесе хабарлама жібере алмайсыз. Шағымдану, бұғаттау және дыбысын өшіру жұмыс істей береді."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңыз тоқтатылған: оқи аласыз, бірақ жариялай алмайсыз."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("\$date дейін тоқтатылған"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңыз \$date дейін тоқтатылған: оқи аласыз, бірақ жариялай алмайсыз."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Команда не жазды"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("Аккаунт күйі"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Ескерту"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Неге?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Сіз \$date жаздыңыз:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Хабарламаңыз"),
      "ui_standing_your_post": MessageLookupByLibrary.simpleMessage("Жазбаңыз"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Жауабыңыз"),
      "ui_terms":
          MessageLookupByLibrary.simpleMessage("Қызмет көрсету шарттары"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("бұл жазба"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Тізбектің дыбысы өшірілді"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Қайталау"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Дыбысты өшіру"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Дыбысты қосу"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Кемінде екі таңба."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Болдырмау"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Сөздер немесе сүзгі: аккаунт, күн аралығы немесе жазба мазмұны."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Қайта жариялауды болдырмау"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Құпия сөзді жаңарту"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Басқа мекенжайды пайдалану"),
      "username": MessageLookupByLibrary.simpleMessage("Пайдаланушы аты"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Пайдаланушы аты кіші әріптермен болуы керек (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Бейне"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Тіркеу"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Тіркеуге дайын"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Дауыстық жазба жазу"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Сақталуда…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Тоқтату"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Не болды"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Не болды және нені тексеруіміз керек?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Бұл суретте не бар?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Бұл не үшін? (міндетті емес)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Не істедіңіз, не күттіңіз, не болды"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Бұл болған кезде не істеп жатқан едіңіз."),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("Сіз жауап бердіңіз"),
      "dmReplied": (Object a0) => "$a0 жауап берді",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Хабарламаға қосу"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Жаңа хабарлама"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Әлі ештеңе айтылмады. Қол бұлғау — жақсы бастама."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Қол бұлғау"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Жаңа хабарламалар"),
      "dmTyping": (Object a0) => "$a0 жазып жатыр",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Реакцияңызды алып тастау"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Біреу"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Хабарлама"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("Тіркеме"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Бұл хабарды осы құрылғыда оқу мүмкін емес."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Бұл хабар күтілуде. Біраз уақыт кетуі мүмкін."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Шифрланған хабар"),
      "ui_dm_e2ee_notice":
          MessageLookupByLibrary.simpleMessage("Хабарлар өтпелі шифрланған"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Өтпелі шифрланбаған"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Жіберілді"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Көрілді"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Жіберілуде…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Суретке түсіру"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Басқа опциялар"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("Құрылғыға сақтау"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Бөлісу"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Сақталуда…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Суреттеріңізге сақталды"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Сақтау мүмкін болмады. Қайталап көріңіз."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Мұны сақтау үшін Kyron-ға суреттеріңізге қосуға рұқсат беріңіз."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Барлық жүйе жұмыс істеп тұр"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Жұмыс уақыты"),
      "ui_status_last_60": MessageLookupByLibrary.simpleMessage("Соңғы 60 күн"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 күн бұрын"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Бүгін"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Дерекқор"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Кіру"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Соңғы оқиғалар"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Соңғы 60 күнде оқиға болған жоқ."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Жалғасуда"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Дерек жоқ"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Толығырақ"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron жұмыс істеп тұрғанда әр 5 минут сайын өзін тексереді. Сұр күні тексеру болмаған."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Жұмыс уақытының тарихы әлі қолжетімді емес."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Кейбір жүйелерде ақау бар"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Дауыстық хабар жазу"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Жіберуге дайын"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Бұл хабар енді жоқ."),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("Хабарға өту"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Дауыстық хабар"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Авторға ұнады"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Фото не клип қосу"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Медиа"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Дауыстық хабарлар"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Чат"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Тұсқағаз"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Хабарландыруларды өшіру"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Бұл сөйлесу туралы хабарландыру алуды тоқтату"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Олар енді сізге хабар жаза алмайды"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Жоқ"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("Дыбыс қосылды."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Жою мүмкін болмады. Қайталап көріңіз."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Профиль"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Дыбысын қосу"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Сіз бөліскен фотолар мен клиптер осында көрсетіледі."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Барлығын көру"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Фотолар мен клиптер"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Чатыңыз осылай көрінеді."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Жақсы көрінеді."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Тұман"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Ымырт"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Шалфей"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Құм"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Нүктелер"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Қолдану"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Ағымдағы"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Алдын ала қараусыз жіберу"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Іздеу"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Жариялау"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Хабарлама жазыңыз…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Жіберу"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Жіберілді"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "Жіберілді, бірақ барлығына емес."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Жіберу мүмкін болмады. Қайталап көріңіз."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Жазылушы"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Сүзгі"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Барлығы"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Оқылмаған"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Жауапсыз"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Жасырылған"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Ештеңе жасырылмаған"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Тізімнен алып тастаған әңгімелер қайтарғыңыз келсе, осында күтіп тұрады."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Ол Жасырылғандарға ауысады. Екінші адам өзінікін сақтайды, ал біреуіңіз қайта жазсаңыз, ол оралады."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Қайтару"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Тізіміңізге қайтты."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Сәйкес әңгіме жоқ."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Сізді ештеңе күтпейді"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Әр әңгіме сіздің сөзіңізбен аяқталады."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Фотолар"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Бейне"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Әзірге хабар жоқ"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Сіз:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Кеше"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Хабарлар"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Хабар параметрлері"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Құпиялық"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Оқылғаны туралы белгі"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Бұл өшірулі болса, басқалар олардың хабарын қашан оқығаныңызды көрмейді, ал сіз олардың сіздікін қашан оқығанын көрмейсіз."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Жазып жатқаныңызды көрсету"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Сіз жазып отырған адам жазып жатқаныңызды көреді."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Сілтеме алдын ала қарауы"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Алдын ала қарау жасау үшін телефоныңыз жіберген сілтемеңізді ашады, сондықтан сайт телефоныңыздың сұрауын көреді. Kyron серверi сілтемені ешқашан көрмейді."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Хабар хабарландырулары"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Хабарлар ұштан-ұшқа шифрланған. Kyron оларды оқи алмайды және мұндағы ештеңе мұны өзгертпейді."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Кімге:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Соңғылар"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Адамдар"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Бұл атпен ешкім жоқ."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Сынақ хабарландыруын жіберу"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron серверi хабарландыру жіберуге әлі бапталмаған, сондықтан ешқайсысы келе алмайды. Мәселе біз жақта, телефоныңызда емес."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Бұл телефон хабарландыруларға тіркелмеген. Телефон параметрлерінде Kyron хабарландыруларына рұқсат берілгенін тексеріп, қайталап көріңіз."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Хабарландыру бұл телефонға жеткізілмеді. Бір минуттан кейін қайталап көріңіз."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Жіберілді. Бірнеше секундта келуі керек."),
      "ui_push_working": MessageLookupByLibrary.simpleMessage(
          "Хабарландырулар жұмыс істейді."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Әзірге жазбалар жоқ"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Жаңа қауымдастық"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Аты"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Мекенжайы атауынан жасалады."),
      "ui_community_address": MessageLookupByLibrary.simpleMessage(
          "Адамдар оны мына мекенжайдан табады:"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Сіз оның иесі боласыз. Сурет, баннер және модераторларды ол жасалғаннан кейін оның бетінен қосуға болады."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Басты бет"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Қауымдастық жазбалары Басты бетте"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Қауымдастықтарыңыздың жазбалары Басты бетте де көрінеді. Өшірілсе, олар осында, Қауымдастықтарда қалады, әрқайсысы жаңасын көрсетеді."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Тізіміңіз"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Жаңа жазбалар саны"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Әр қауымдастықта соңғы ашқаныңыздан бері қанша жазба жаңа екенін көрсету."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Сіз басқаратын қауымдастықтар"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Сіз құрған немесе модерациялайтын қауымдастықтар осында."),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("Иесі"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Модератор"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Жаңа жазбалар"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Сіз басқаратындар"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Қауымдастық параметрлері"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Ашу"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Сәйкес қауымдастық жоқ."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Жаңалық жоқ"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Әр қауымдастық сіз қалдырғандай."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Әлі ешқайсысын басқармайсыз"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Қосылатын ештеңе қалмады"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Сіз Kyron-дағы барлық қауымдастықтасыз. Тағы біреуін құрыңыз."),
      "ui_community_discover_search_detail": MessageLookupByLibrary.simpleMessage(
          "Басқа сөзді қолданып көріңіз немесе осы атпен қауымдастық құрыңыз."),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("Жазба жазу"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Мүшелер:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Жарияланды"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Көру"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Ашу"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Желіде"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Желіде екеніңізді көрсету"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Сіз хат жазатын адамдар Kyron ашық тұрғанда жасыл нүктені көреді. Бұл өшірулі болса, сіз де олардікін көрмейсіз."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Адамдар мен жазбаларды іздеу"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Қосылуға болатын қауымдастықтар"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Әзірге көретін ештеңе жоқ"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Адамдар жариялаған фотолар мен клиптер осында көрінеді."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Жазылу"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Аккаунтты жою"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Бұл Kyron аккаунтыңызды біржола жояды. Мұны қайтару мүмкін емес."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Профиліңіз, жазбаларыңыз, жауаптарыңыз, ұнатуларыңыз және қайта жариялауларыңыз"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Хабарларыңыз, басқаларға жібергендеріңізді қоса, және олардағы фотолар мен дауыстық хабарлар"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Жазылушыларыңыз, өзіңіз жазылған адамдар және параметрлеріңіз"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Сіз құрған қауымдастықтар ең ұзақ жүрген модераторға немесе мүшеге өтеді. Басқа ешкім жоқ қауымдастық жабылады."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңыз жойылсын ба?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Оның ешқайсысын қайтара алмайсыз."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңыз жойылды."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Жойылған аккаунт"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Бұл аккаунт жойылды, сондықтан бұл жерге енді хабар жіберу мүмкін емес."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google арқылы тіркелдіңіз бе? Оның орнына «Sign in with Google» түймесін пайдаланыңыз."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Бұл линзаны жүктеу мүмкін болмады."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Бейнені жазу мүмкін болмады."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Линзаны бұл бейнеге қосу мүмкін болмады, сондықтан ол түсірілген күйінде жарияланады."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Жазбаңызда тіркемелердің ең көп саны бар."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Линза қосылуда…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Жарқылдақ"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Бейне жазу"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Бейне"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Google арқылы кіру тоқтатылды."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("СЫЙЛЫҚТАР"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Бұл жазбаға әлі ешкім сыйлық жібермеді."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Сыйлық"),
      "analytics_gifts_label":
          MessageLookupByLibrary.simpleMessage("Сыйлықтар"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Тиындар"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Жіберуші"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Жіберушілер"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Сынақ тиындары: оларды әлі шығаруға болмайды."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Сақталғандар"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Жазбалар"),
      "ui_saved_tab_comments": MessageLookupByLibrary.simpleMessage("Пікірлер"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Тағы жауаптарды көру"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Өңделген"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Тағы"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Жазылымдар"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Үздік"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Жаңа"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Пікірлерді сұрыптау: \$order"),
      "ui_notif_gift":
          MessageLookupByLibrary.simpleMessage("жазбаңызға сыйлық жіберді"),
      "ui_notif_gift_comment":
          MessageLookupByLibrary.simpleMessage("пікіріңізге \$gift жіберді"),
      "ui_notif_gift_named":
          MessageLookupByLibrary.simpleMessage("жазбаңызға \$gift жіберді"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Сыйлық жіберу"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Жазбаны өңдеу"),
      "ui_edit_post_left":
          MessageLookupByLibrary.simpleMessage("Оны тағы \$n мин өңдей аласыз"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Сақтау"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "#\$tab астында әлі ештеңе жарияланбаған."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Сыйлық таңдаңыз"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Тиын жеткіліксіз"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Сынақ тиындары: оларды сатып алуға болмайды және ақшалай құны жоқ."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("\$date толтырылады."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 тиын"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count тиын"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("Сізде \$coins бар"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift жіберу"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift жіберілді"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Қайталау"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "Жариялағаннан кейін 15 минут бойы"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Өңделді"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Сақталған пікірлеріңізді жүктеу мүмкін болмады"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Сақталған пікірлер жоқ"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Пікірді осында сақтау үшін астындағы мұрағат белгішесін түртіңіз. Сақтағаныңызды тек сіз көресіз."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("\$name пайдаланушысына жауап"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Көшіру"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Іздеу"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Барлығын таңдау"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count сыйлық"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 сыйлық"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Қосымша жазбаларды жүктеу мүмкін болмады."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Еске салғыштар"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Сіз болмаған кезде не жаңалық болды және тиындарыңыз қашан оралады. Күніне біреуден артық емес."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Сыйлықтар"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("1 адамнан"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count адамнан"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Ең жомарт"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Сыйлық жіберушілерді жүктеу мүмкін болмады."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Не жаңалық"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Түсіндім"),
      "ui_check_in_thanks":
          MessageLookupByLibrary.simpleMessage("Рақмет. Әр жауапты оқимыз."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Kyron әзірге қалай?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Сынағыңыздың \$day-күні. Бір түрту жеткілікті."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Түзету не қосу керек нәрсе бар ма? (міндетті емес)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Жіберу"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Қазір емес"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Kyron-нан шығу үшін «Артқа» түймесін қайта басыңыз"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Бұл сіз екеніңізді растаңыз"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Аккаунтты жою үшін құпия сөзді енгізіңіз."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Аккаунтты жою үшін Google арқылы қайта кіріңіз."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Болмады. Тексеріп, қайта көріңіз."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Бұл бет басқа қолданбаны ашқысы келеді"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Ол {scheme} сілтемесін ашуды сұрап тұр."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("Құрастыру"),
      "ui_about_cache_size":
          MessageLookupByLibrary.simpleMessage("Кэште {size} сурет пен файл"),
      "ui_about_freed":
          MessageLookupByLibrary.simpleMessage("{size} босатылды"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("Өлшенуде…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("Тазалайтын ештеңе жоқ"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("Жад"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("Нұсқа {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("Бұғатталғандар"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("Өз атыңыздан жариялайсыз"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "Бұл тіркемелер жүктелмеді. Қайталау үшін біреуін түртіңіз немесе оны алып тастаңыз."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "Поштаңызды өзгерту мүмкін болмады. Қайталап көріңіз."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "Біз жіберетін сілтемені ашқанда мекенжайыңыз өзгереді."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "Растау сілтемесін {email} ішінен қараңыз."),
      "ui_email_enter": MessageLookupByLibrary.simpleMessage(
          "Электрондық пошта мекенжайын енгізіңіз."),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage(
          "Бұл электрондық пошта мекенжайына ұқсамайды."),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "Бұл қазірдің өзінде сіздің поштаңыз."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "Не істедіңіз, не күттіңіз және оның орнына не болды."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "Профиліме жазбаны бекітуге рұқсат етіңіз"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "Не қалайсыз және ол сізге не істеуге мүмкіндік береді."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("Не көмектесер еді"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("Мәселе"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("Идея"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("Сұрақ"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "Мұны тек Kyron командасы оқиды. Біз поштамен жауап бере алуымыз үшін ол аккаунтыңызбен және қолданатын қолданба нұсқасымен бірге жіберіледі. Аккаунтты жойсаңыз, бұл да жойылады."),
      "ui_feedback_question_example":
          MessageLookupByLibrary.simpleMessage("Сөзді қалай дыбыссыз етемін?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "Не істемексіз және қай жерде тұрып қалдыңыз."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("Сұрағыңыз"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Kyron-ға қосылу мүмкін болмады. Байланысты тексеріп, қайталап көріңіз. Әзірге ештеңе жазылмаған, сондықтан ештеңе жоғалмады."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("Тазалау"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Сәтсіз сұраулар мен басқа маңызды оқиғалар осында көрсетіледі."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("Дыбыссыздар"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "Жоғарыда сөз не тег қосыңыз. Оны қамтитын жазбалар таспаңызға түспейді."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "Осылардың кез келгенін қамтитын жазбалар таспаңызға түспейді. Бас-кіші әріп маңызды емес, ал сөз ұзынырақ сөздердің ішінде де сәйкес келеді, сондықтан «spoiler» «spoilers» сөзін де ұстайды."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("Ешкім бұғатталмаған"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "Бұғаттау сізді бір-біріңізден екі жақты жасырады. Біреуді оның профиліндегі мәзірден бұғаттаңыз."),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("Ешкім дыбыссыз етілмеген"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "Аккаунтты дыбыссыз ету оған айтпастан жазбаларын жасырады. Біреуді профиль не жазба мәзірінен дыбыссыз етіңіз."),
      "ui_password": MessageLookupByLibrary.simpleMessage("Құпиясөз"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("Сәйкес емес."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "Бұл құрылғыда кірген күйде қаласыз. Басқа құрылғылардан шығасыз."),
      "ui_password_too_short":
          MessageLookupByLibrary.simpleMessage("Кемінде 8 таңба қолданыңыз."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "Құпиясөзді жаңарту мүмкін болмады. Қайталап көріңіз."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("Құпиясөз жаңартылды."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID көшірілді"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "Ұнаған жазбаларыңыз осында тек сіз үшін сақталады."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "Сіз әлі ешқандай фото не клип жарияламадыңыз."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} әлі ешқандай фото не клип жарияламады."),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "Жариялағаныңыздың бәрі осында көрінеді."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} әлі ештеңе жарияламады."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "Профиліңізді жүктеу мүмкін болмады"),
      "ui_profile_load_failed_other":
          MessageLookupByLibrary.simpleMessage("@{handle} жүктелмеді"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("Кемінде 8 таңба"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("Кіші әріп (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("Кемінде бір сан"),
      "ui_pw_rule_symbol": MessageLookupByLibrary.simpleMessage("Таңба (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("Бас әріп (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "Соңғы {count} жазба. Жібермес бұрын оларды Қолданба туралы › Жүйе журналы бөлімінен қараңыз."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "Мұны тек Kyron командасы оқиды. Сізбен байланыса алуымыз үшін ол аккаунтыңызбен бірге жіберіледі. Онымен бірге нақты не кететінін көргіңіз келсе, алдымен Қолданба туралы › Жүйе журналы бөлімінде журналды оқыңыз."),
      "ui_report_sent":
          MessageLookupByLibrary.simpleMessage("Жіберілді, рақмет."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "Жіберілді, рақмет. Бұл №{number} есеп."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("Не дұрыс болмады?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "Нұсқа, ережелер, күй және жүйе журналы"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "Айналдырғанда бейнелер өздігінен ойнамасын"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "Орталықсыздандырылған идентификаторыңыз"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("Модерация"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "Қарауды күтіп тұрған шағымдар мен апелляциялар"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "Осыларды қамтитын жазбаларды таспадан аулақ ұстау"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("Кірмеген"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("Хабарландыру параметрлері"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("Құпиялық және қауіпсіздік"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңыз туралы шешімдер және апелляциялар"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("Мәтін өлшемін реттеу"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("Аккаунтыңыз"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "AR линзаларын жазу және жариялау әлі әзірленуде. Түсіргеніңіз әзірге сақталмайды, сондықтан камера жабық тұрады."),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("Линзалар әлі дайын емес"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR линза"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "Тікелей эфирге Kyron әлі іске қоспаған медиасервер керек. Қазір эфир бастасаңыз, ешкім қосыла алмайтын бөлмеде боласыз. Дауыстық жазба жазу бүгін де жұмыс істейді."),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("Тікелей эфир әлі дайын емес"),
      "ui_soon_live_title":
          MessageLookupByLibrary.simpleMessage("Тікелей эфир"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Сауалнамаларға нұсқаларды сақтайтын және дауыстарды санайтын орын керек. Ол әлі жоқ, сондықтан бүгін жарияланған сауалнама әр жауапты жоғалтар еді."),
      "ui_soon_poll_heading":
          MessageLookupByLibrary.simpleMessage("Сауалнамалар әлі дайын емес"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("Сауалнама"),
      "ui_soon_write_instead": MessageLookupByLibrary.simpleMessage(
          "Оның орнына мәтіндік жазба жазыңыз"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("Қайта тексеру"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("Толығырақ"),
      "ui_status_mirror":
          MessageLookupByLibrary.simpleMessage("Айналы кестелер"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron жауап берді, бірақ бірдеңе дұрыс емес."),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("Бару-қайту уақыты"),
      "ui_support_ask": MessageLookupByLibrary.simpleMessage("Сұрақ қою"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Аккаунтыңыз туралы немесе бірдеңенің қалай жұмыс істейтіні туралы"),
      "ui_support_by_email":
          MessageLookupByLibrary.simpleMessage("Электрондық поштамен"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron істен шықса: қолданба журналын да жібереді"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("Қолданбада"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "Kyron командасына осы жерден жазыңыз. Ол бізге жеке, аккаунтыңызбен бірге жетеді, ал біз ондағы поштаға жауап береміз."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "Ешбір пошта қолданбасы ашылмады. {address} көшірілді."),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("Құпиялық және деректеріңіз"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("Мәселе туралы хабарлау"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "Бірдеңе бұзылған немесе тиісті жұмысын істемейді"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "Жазбаға не аккаунтқа шағымдану үшін оның мәзірін қолданыңыз: сонда қайсысын меңзеп тұрғаныңызды нақты білеміз."),
      "ui_support_safety": MessageLookupByLibrary.simpleMessage(
          "Қауіпсіздік және теріс пайдалану"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron бәрі үшін істемей тұр ма, әлде тек сіз үшін бе"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("Үлкен"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("Үлкенірек"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("Орташа"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron — оқуға тұрарлық нәрсе айтатын орын."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("Кіші"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Әрқашан қараңғы"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("Күңгірт"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Жұмсағырақ қараңғы, қараның орнына көкшіл-сұр"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Әрқашан жарық"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Телефонның жарық не қараңғы параметріне сай"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("Бұғаттан шығару"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("Дыбысын қосу"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("Сіз кімсіз"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "Өз сөзіңізбен: тексерушінің не білуі керек."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "Мен осында және өз сайтымда құстар туралы жазамын."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("Тағы сілтеме қосу"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "{date} бастап қайта сұрай аласыз."),
      "ui_verify_ask": MessageLookupByLibrary.simpleMessage("Растауды сұрау"),
      "ui_verify_before": MessageLookupByLibrary.simpleMessage("Сұрамас бұрын"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("Автор"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("Журналист"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("Ұйым немесе бренд"),
      "ui_verify_cat_other":
          MessageLookupByLibrary.simpleMessage("Басқа нәрсе"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("Қоғам қайраткері"),
      "ui_verify_denied":
          MessageLookupByLibrary.simpleMessage("№{number} сұрау мақұлданбады"),
      "ui_verify_done":
          MessageLookupByLibrary.simpleMessage("Сіз расталғансыз"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("Профильді өңдеу"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("6 таңбалы кодты енгізіңіз"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "Кодты {seconds} секундтан кейін қайта жіберу"),
      "ui_verify_email_sent_to": MessageLookupByLibrary.simpleMessage(
          "Біз оны {email} мекенжайына жібердік"),
      "ui_verify_email_verify": MessageLookupByLibrary.simpleMessage("Растау"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Kyron-да растаудан өтіңіз"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Kyron-да"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("растаудан"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("өтіңіз."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "Белгі Kyron командасынан біреу бұл аккаунттың өзі айтқан адам екенін тексергенін білдіреді. Ол қосымша қамту бермейді және сатылмайды."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "Атыңыз өзгермейінше белгі қалады. Атыңызды өзгертсеңіз, біреу жаңасын тексергенше ол алынып тасталады."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("Қай жерден тексере аламыз"),
      "ui_verify_link_more":
          MessageLookupByLibrary.simpleMessage("Басқа сілтеме"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "Бұл Kyron аккаунты сіздікі екенін айтатын сайт не басқа профиль: оған Kyron атыңызды немесе профиліңіздің сілтемесін қойыңыз. Kyron ешқашан жеке куәлік сұрамайды."),
      "ui_verify_load_failed": MessageLookupByLibrary.simpleMessage(
          "Күйіңізді жүктеу мүмкін болмады"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "Сұрамас бұрын жоғарыдағының бәрі белгіленуі керек."),
      "ui_verify_req_age":
          MessageLookupByLibrary.simpleMessage("Кемінде {days} күндік аккаунт"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("Кім екеніңізді айтатын био"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("Профильдегі атыңыз"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("Профиль суреті"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "Соңғы {days} күнде жазбаңызда ештеңе жоқ"),
      "ui_verify_sent":
          MessageLookupByLibrary.simpleMessage("Жіберілді. Оны адам қарайды."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("{date} бастап."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("Сұрау"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Кім екеніңіз және оны\nдәлелдейтін сілтеме"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("Белгі"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "Атыңыздың жанында,\nол көрінетін барлық жерде"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("Адам\nтексереді"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "Командадан біреу\nсілтемелеріңізді ашады"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("Растау"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "№{number} сұрау адамның қолында"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "{date} күні {category} ретінде жіберілді. Шешім шыққанда хабарландыру аласыз."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("Сұрауды қайтарып алу"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("Сұрау қайтарып алынды."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "Жазуды аяқтау мүмкін болмады: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("Он минутқа дейін."),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("Тыңдап тұр…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Жазу үшін Kyron-ға микрофон рұқсаты керек. Оны құрылғы параметрлерінен бере аласыз."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "Жазуды бастау мүмкін болмады: {error}"),
      "ui_2fa_title": MessageLookupByLibrary.simpleMessage("Екі қадамды кіру"),
      "ui_2fa_help": MessageLookupByLibrary.simpleMessage(
          "Қызметкер құралдарына арналған аутентификатор коды"),
      "ui_2fa_intro": MessageLookupByLibrary.simpleMessage(
          "Қызметкер құралдары кіруіңізден бөлек аутентификатор қолданбасының кодын да сұрайды, сонда ұрланған құпиясөздің өзі ғана оларды пайдалана алмайды."),
      "ui_2fa_on":
          MessageLookupByLibrary.simpleMessage("Екі қадамды кіру қосулы."),
      "ui_2fa_remove": MessageLookupByLibrary.simpleMessage("Жою"),
      "ui_2fa_set_up": MessageLookupByLibrary.simpleMessage("Баптау"),
      "ui_2fa_scan": MessageLookupByLibrary.simpleMessage(
          "Мұны аутентификатор қолданбасымен сканерлеңіз немесе төмендегі кілтті енгізіңіз. Мүмкін болса, екі қолданбаға қосыңыз: жалғызын жоғалтсаңыз, оны жою үшін қолдау қызметіне жүгінуге тура келеді."),
      "ui_2fa_key": MessageLookupByLibrary.simpleMessage("Баптау кілті"),
      "ui_2fa_copied":
          MessageLookupByLibrary.simpleMessage("Баптау кілті көшірілді"),
      "ui_2fa_confirm": MessageLookupByLibrary.simpleMessage("Растау"),
      "ui_2fa_failed": MessageLookupByLibrary.simpleMessage(
          "Баптауды бастау мүмкін болмады. Қайталап көріңіз."),
      "ui_2fa_wrong": MessageLookupByLibrary.simpleMessage(
          "Бұл код жұмыс істемеді. Телефоныңыздағы уақытты тексеріп, қайталап көріңіз."),
      "ui_2fa_code": MessageLookupByLibrary.simpleMessage("6 таңбалы код"),
      "ui_2fa_enter": MessageLookupByLibrary.simpleMessage(
          "Аутентификатор қолданбасындағы кодты енгізіңіз"),
      "ui_2fa_verify": MessageLookupByLibrary.simpleMessage("Тексеру"),
      "ui_password_breached": MessageLookupByLibrary.simpleMessage(
          "Бұл құпиясөз деректердің жылыстауында көрінген, сондықтан шабуылдаушылар алдымен байқап көретіндердің бірі. Басқасын таңдаңыз."),
    };

final messageLookup = MessageLookup();
