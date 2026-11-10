import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Слово, фраза або #тег"),
      "about": MessageLookupByLibrary.simpleMessage("Про себе"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Додати варіант"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage("Додати мови…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Прийняти й продовжити"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Уже маєте акаунт Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Коментарі"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage("Різні люди, а не відкриття"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Залученість"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Вподобання"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Глядачів поки немає"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Цю публікацію ще ніхто не відкривав."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Опубліковано"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Збереження"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Глядачі"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("ГЛЯДАЧІВ НА ДЕНЬ"),
      "and": MessageLookupByLibrary.simpleMessage("і"),
      "answerNumber": (Object a0) => "Варіант ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR-лінза"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Додати журнал застосунку"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Затримка туди й назад"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ПЕРЕВІРКА ТОКЕНА"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Спробувати знову"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Спробувати знову"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Якщо почати трансляцію зараз, ви опинитеся в кімнаті, куди ніхто не зможе"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Створити спільноту"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Для чого це? (необов'язково)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("увійти знову."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("повернутися з цього списку."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Якщо її закрити,"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("спершу приєднайтеся"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("незабаром"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Публікуєте від свого імені"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("публікувати в цій спільноті"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Щойно"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Спробувати знову"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Тема 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Для вас"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("щось є."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("вже прямує туди."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", не"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("чи рухаюся я"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Вимкнути звук"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Увімкнути звук"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Для вас"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Ваші вкладки"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Спробувати знову"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Символ (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("ГЛЯДАЧІВ НА ДЕНЬ"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("не вдалося завантажити"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ця публікація"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Хочете щось додати? (необов'язково)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ця публікація"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Від акаунта"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Вийти"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Ваш акаунт"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Підтвердьте пароль"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("не зараз"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Завантаження…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Публікація…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 год тому"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage(
              "Копіювати посилання на історію"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Ваша історія"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Ваш акаунт, ваші публікації та те, на що ви натискаєте, щоб"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Додати тему"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("своє."),
      "authorBlocked": (Object a0) => "${a0} заблоковано",
      "authorPostsHidden": (Object a0) => "Ви не бачитимете публікацій ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Заблокувати"),
      "blockAuthor": (Object a0) => "Заблокувати ${a0}?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
          "Відомості про збірку скопійовано"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Продовжуючи, ви приймаєте"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Продовжуючи, ви погоджуєтеся з нашими Умовами використання та Політикою конфіденційності"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Реєструючись, ви приймаєте"),
      "cancel": MessageLookupByLibrary.simpleMessage("Скасувати"),
      "change": MessageLookupByLibrary.simpleMessage("Змінити"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Змінити пошту"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Підтвердьте акаунт через лист."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Перевірити, чи доступний Kyron"),
      "clear": MessageLookupByLibrary.simpleMessage("Очистити"),
      "close": MessageLookupByLibrary.simpleMessage("Закрити"),
      "closeCommunity": (Object a0) => "Закрити ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Закрити"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Закрити цю спільноту"),
      "communities": MessageLookupByLibrary.simpleMessage("Спільноти"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Знайдіть спільноту в Огляді або створіть свою."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Висловіть гарячу думку (або теплу)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Про що думаєте?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Скажіть те, що можете сказати лише ви…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("Це знак: надсилайте"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Пишіть, говоріть або думайте вголос"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Підтвердьте пароль"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Звернутися до підтримки"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "У публікацій поки немає мови, тож це ще не фільтрує стрічку. Ваш вибір збережеться до того часу."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Продовжити"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Продовжити з поштою"),
      "copy": MessageLookupByLibrary.simpleMessage("Копіювати"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Скопіювати звіт натомість"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Не вдалося відкрити вхід через Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Не вдалося вийти: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Не вдалося зробити знімок."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Показується у твоєму профілі та під твоїми дописами."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Немає країн, що відповідають «{query}»."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Не показувати країну"),
      "country_search": MessageLookupByLibrary.simpleMessage("Пошук країн"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Показується у твоєму профілі та під твоїми дописами. Коли ти бачиш чиїсь дописи, твоя країна враховується в його Статистиці, лише в групах від п'яти осіб і ніколи за іменем."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("З налаштувань телефона"),
      "create": MessageLookupByLibrary.simpleMessage("Створити"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Створити акаунт"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Створіть акаунт"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Створіть профіль"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR-лінза"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Почати ефір"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Текстова публікація"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Голосова публікація"),
      "delete": MessageLookupByLibrary.simpleMessage("Видалити"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Видалити цей коментар?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Видалити цю публікацію?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Опишіть це вкладення"),
      "description": MessageLookupByLibrary.simpleMessage("Опис"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
          "DID скопійовано в буфер обміну"),
      "done": MessageLookupByLibrary.simpleMessage("Готово"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Закрийте редактор, написавши щось, і вам запропонують зберегти чернетку."),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} дн. тому"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} год тому"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Щойно"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} хв тому"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Поки нічого не написано"),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
          "Опитування, поки без запитання"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Цитата, поки без тексту"),
      "drafts": MessageLookupByLibrary.simpleMessage("Чернетки"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Редагувати профіль"),
      "email": MessageLookupByLibrary.simpleMessage("Пошта"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Сповіщення поштою"),
      "explore": MessageLookupByLibrary.simpleMessage("Огляд"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Відстеження обличчя недоступне на цьому пристрої."),
      "feedTagDetail": (Object a0) =>
          "З тегом #${a0} поки нічого не опубліковано.",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("Стежити за {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Підписники"),
      "following": MessageLookupByLibrary.simpleMessage("Стежите"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage("Забули пароль?"),
      "gettingHelp":
          MessageLookupByLibrary.simpleMessage("Як отримати допомогу"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Продовжити з Google"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Увійти через Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google повертає завершений вхід у Kyron за посиланням, на яке відповідають лише Android та iOS, тож на платформі ${a0} браузеру нікуди його повернути.\\n\\nЯкщо у вас уже є акаунт Kyron через Google, оберіть «Продовжити з поштою» з тією ж адресою й натисніть «Забули пароль?»: вам прийде посилання для створення пароля.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Вхід через Google працює в застосунку для телефона"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Зареєструватися через Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Посібники та відповіді на поширені запитання"),
      "handle": MessageLookupByLibrary.simpleMessage("ім'я користувача"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Допомога й підтримка"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Довідковий центр"),
      "home": MessageLookupByLibrary.simpleMessage("Головна"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("В одному рядку"),
      "ins_account":
          MessageLookupByLibrary.simpleMessage("Ваш обліковий запис"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Відкрити спільноту"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Написати допис"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Переглянути допис"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Редагувати профіль"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Коли вони тут"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("У вашому часовому поясі."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Вік"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "З {known} охоплених людей, які вказали день народження."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Охоплені люди за днями"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Спільноти, у яких вони є"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Країни"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "З {known} охоплених людей, які вказали країну в профілі."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Останні {days} днів"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити статистику"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Підписники"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Поки немає достатньо великої групи, щоб її показати."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Як рости"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Теми, за якими вони стежать"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Вподобання"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Нове"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Нові підписники"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "За цей період жоден ваш допис нікого не охопив."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Не стежать за вами"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Країни — ті, що люди обрали у своїх профілях. Kyron не збирає нічиє місто чи стать, тож показувати щодо них нічого."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Відкриття"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "охоплення {reach} · {likes} вподобань · {replies} відповідей"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Охоплені люди"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Кожну людину враховано один раз: їй уперше показали або вона вперше відкрила один із ваших дописів. Нові підписники досі стежать за вами; відписки не враховуються."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Відповіді"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Репости"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Збереження"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Хто ваша аудиторія, буде видно, коли {floor} людей побачать ваші дописи за цей період. Якщо менше, це могло б вказати на конкретну людину."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Поки замало людей"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% із них уже стежать за вами: ваші дописи здебільшого доходять до тих, хто вас знає."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% із них ще не стежать за вами: ваші дописи знаходять."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Ви охопили {reach} людей — на {pct}% менше, ніж за попередній період."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "За останні {days} днів ви охопили {reach} людей."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Ви охопили {reach} людей — приблизно стільки ж, як за попередній період."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "За останні {days} днів ваші дописи не побачив ніхто новий."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Ви охопили {reach} людей — на {pct}% більше, ніж за попередній період."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Ви охопили {reach} людей — у {times}× більше, ніж за попередній період."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Найбільше з них стежать за темою «{name}»."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Аудиторія"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Огляд"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Ті, хто знаходить ваш допис, дивляться профіль, перш ніж підписатися. Обличчя чи логотип кажуть їм, що тут хтось є."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Додайте фото профілю"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Скажіть одним рядком, про що ви пишете, щоб незнайомець знав, що йому дасть підписка."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Напишіть про себе"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "У {without} із {total} ваших дописів не було теми. Тема ставить допис у стрічку цієї теми і перед тими, хто за нею стежить."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Додавайте теми до дописів"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} людей відповіли на ваші дописи, а ви відповіли на {answered}. Їм було не байдуже настільки, щоб написати: відповідь перетворює читача на постійного гостя."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Відповідайте на відповіді"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Ваша аудиторія найактивніша: {when}. Допис трохи раніше матиме кому його зустріти."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Публікуйте, коли вони тут"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} людей, які за вами не стежать, побачили ваші дописи, і {gained} підписалися. Нехай опис і найновіші дописи кажуть, чого від вас чекати."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Перетворюйте читачів на підписників"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Один допис охопив у {times}× більше людей, ніж зазвичай інші ваші. Подивіться, що в ньому було інакше, і робіть більше цього."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "Робіть більше того, що спрацювало"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Багато хто з тих, хто бачить ваші дописи, є у спільноті {name}. Дописи там покажуть вас і решті."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Публікуйте в спільноті {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Ви публікували {posts} разів за {days} днів. Кожен допис — ще один шанс, що вас знайдуть, а рівний ритм тримає вас у стрічках підписників."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Публікуйте частіше"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "За останні {days} днів ви нічого не публікували. Без допису ніщо ні до кого не доходить."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Опублікуйте щось"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Статистика"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Найкращі дописи"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Порівняно з попередніми {days} днями"),
      "interest_add": MessageLookupByLibrary.simpleMessage("Додати інтерес"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Перетягніть, щоб упорядкувати"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "На панелі вміщується не більше п'яти вкладок. Приберіть одну, щоб додати іншу."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Стежите"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Для вас"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Хештеги з'являться тут, коли люди почнуть ними користуватися."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Зараз у тренді"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Відео"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Ваші вкладки"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Воно зникне в вас обох."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Його буде видалено з гілки."),
      "join": MessageLookupByLibrary.simpleMessage("Приєднатися"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Продовжити редагування"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Екрани Kyron вашою мовою. Якщо якесь слово звучить неправильно, повідомте нам через «Надіслати відгук»."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Мови"),
      "leave": MessageLookupByLibrary.simpleMessage("Вийти"),
      "leaveCommunity": (Object a0) => "Вийти з ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Впустити знову"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("Відкрито 1 сторінку"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Додати кліп"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Додати GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Додати хештег"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Додати фото"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Додати опитування"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Додати відео"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Додати інтерес"),
      "literaladdLabelAsATab": (Object a0) => "Додати ${a0} як вкладку",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Мова застосунку"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Версія застосунку"),
      "literalblockAuthor": (Object a0) => "Заблокувати ${a0}",
      "literalblockAuthor2": (Object a0) => "Заблокувати ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Заблокувати цей акаунт?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Скасувати відповідь"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Перевірити знову"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Вибрати з галереї"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Очистити кеш"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Закрити всі сторінки"),
      "literalcloseTabLabel": (Object a0) => "Закрити ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Закрити браузер"),
      "literalcloseWidgetCommunityName": (Object a0) => "Закрити ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Зв'язатися з підтримкою"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Мови контенту"),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("Копіювати посилання"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
          "Копіювати посилання на публікацію"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Копіювати текст публікації"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("Копіювати текст"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити спільноти"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Не вдалося завантажити GIF"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити сповіщення"),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити учасників"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити ці публікації"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Не вдалося завантажити цей чат"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити цей список"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити цю публікацію"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити цю відповідь"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити популярні теги"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Не вдалося завантажити ваші спільноти"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити повідомлення"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Не вдалося відкрити цю спільноту"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Не вдалося опублікувати відповідь."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Пошук не вдався"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Не вдалося вийти: ${a0}",
      "literalcountPagesOpen": (Object a0) => "Відкрито сторінок: ${a0}",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Обкладинка"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Економія трафіку"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Видалити публікацію"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Знайти людей"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("Не відповідати"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Чернетку збережено"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Зараз не вдається надіслати відгук"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Розмір тексту"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF не налаштовано"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Передати в інший застосунок"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Сховати пароль"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Приховати цю публікацію"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Приховує її й просить показувати менше подібного"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Як поводитися"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Продовжити писати"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron не відповів"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0}: дата",
      "literalleaveCommunityName": (Object a0) => "Вийти з ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, лінза для обличчя",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Вподобані публікації"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Посилання скопійовано"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Зробити модератором"),
      "literalmuteAuthor": (Object a0) => "Приховати ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Приховати цю гілку"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Приховати слова або теги"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Приховані й заблоковані акаунти"),
      "literalmutedYouWillNotBeNotified":
          MessageLookupByLibrary.simpleMessage("Приховано. Сповіщень не буде."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Жоден застосунок на цьому пристрої не відкриває посилання ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Жоден браузер на цьому пристрої не прийняв посилання."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("DID поки немає"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Немає чернеток"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Інтересів поки немає"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Вподобань поки немає"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Повідомлень поки немає"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Нових підписників немає"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Публікацій поки немає"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Відповідей поки немає"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Репостів поки немає"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Жоден популярний тег не підходить"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Нікого не знайдено"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Нікого не видалено"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Тут поки нікого немає"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Не цікаво"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Нічого не знайдено"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Поки нічого не в тренді"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("У журналі поки нічого немає"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Нічого не знайдено"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Нічого не приховано"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Поки нічого дивитися"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Немає непрочитаних"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("Змінити це може лише власник"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Відкрити відповідь"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Відкрийте лист від Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Пароль і вхід"),
      "literalpostInCommunityName": (Object a0) => "Опублікувати в ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Опублікувати в ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Опублікуйте зі своїми словами зверху"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Основна мова"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-сповіщення"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Перевіряємо…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Записати голосову публікацію"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Записати знову"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Зняти з модераторів"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Видалити зі спільноти"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Прибрати зі збереженого"),
      "literalremoveLabel": (Object a0) => "Прибрати ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Прибрати ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Видалити ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Видалити опитування"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Видалити цей варіант"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Видалити цей чат"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Видалити це опитування"),
      "literalreportAuthor": (Object a0) => "Поскаржитися на ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Поскаржитися на публікацію"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Надіслати код знову"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Збережені публікації"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Скажіть щось"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Скажіть щось у ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Пошук не вдався"),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("Надіслати знову"),
      "literalsendAgainInCooldownS": (Object a0) => "Повторити через ${a0} с",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Залишити відгук"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Надіслати посилання"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Надіслано. Це звіт №${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Задайте пароль і продовжуйте"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Поділитися журналом із підтримкою"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Поділитися цією спільнотою"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Поділитися цією сторінкою"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Поділитися цим профілем"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Поділитися…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Поділитися з цитатою"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Показувати більше таких"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Показати пароль"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Показати результати"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Створити спільноту"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Почати запис"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Зупинити завантаження"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Більше не бачити цю публікацію та відповіді на неї"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Стрічка історій, елементів: ${a0}",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Змінити камеру"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Позначити людину"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Зробити знімок"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Торкніться банера або фото, щоб змінити"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Торкніться посилання в ньому"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Торкніться, щоб додати фото й обкладинку"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("Не вийшло. Спробуйте ще раз."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Не вдалося завантажити цей GIF."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage("Це посилання тут не відкрити."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Камеру закрито"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Ця спільнота"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Цю відповідь видалено"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Перекласти публікацію"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Вимкнути звук"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Увімкнути звук"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Взяти одну з наших"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Код підтвердження надіслано знову."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Не вдалося підтвердити: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Підтвердьте пошту"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Глядачі, вподобання, збереження та коментарі"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Що зберігає Kyron"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Що робив цей застосунок"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Що ви робили, чого очікували, що сталося "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Ваші публікації належать вам"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Чи доступний Kyron просто зараз"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Хто може відповідати"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Кого позначити?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Ви вже стежите за всіма популярними тегами"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Ви все переглянули"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Ви не перебуваєте в жодній спільноті"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Ви вийшли з акаунта."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Ви вийшли з ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Ви ще нічого не опублікували"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Завантажити ще"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Журнал очищено"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Журнал скопійовано"),
      "logIn": MessageLookupByLibrary.simpleMessage("Увійти"),
      "logOut": MessageLookupByLibrary.simpleMessage("Вийти"),
      "logOutQuestion":
          MessageLookupByLibrary.simpleMessage("Вийти з акаунта?"),
      "login": MessageLookupByLibrary.simpleMessage("Вхід"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося увійти. Перевірте облікові дані."),
      "manage": MessageLookupByLibrary.simpleMessage("Керувати"),
      "menu": MessageLookupByLibrary.simpleMessage("Меню"),
      "message": MessageLookupByLibrary.simpleMessage("Написати"),
      "messages": MessageLookupByLibrary.simpleMessage("Повідомлення"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("Усі розмови прочитано."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Відкрийте чийсь профіль і натисніть «Написати», щоб почати розмову."),
      "mute": MessageLookupByLibrary.simpleMessage("Приховати"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Приховані й заблоковані"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Приховані слова й теги"),
      "name": MessageLookupByLibrary.simpleMessage("Ім'я"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Екран <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Нова адреса пошти"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Новий пароль"),
      "newPost": MessageLookupByLibrary.simpleMessage("Нова публікація"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Не зараз"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Не надіслано. Торкніться, щоб повторити"),
      "nothingMatchesQuery": (Object a0) =>
          "У Kyron немає нічого за запитом \"${a0}\"",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("Нічого копіювати"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Сюди надходять вподобання, відповіді та нові підписники."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Тут з'являться люди, які на вас підписалися."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Коли комусь сподобається ваша публікація, це з'явиться тут."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Сюди надходять відповіді на ваші публікації."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Коли хтось зробить репост вашої публікації, це з'явиться тут."),
      "notifications": MessageLookupByLibrary.simpleMessage("Сповіщення"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Відкрити в браузері"),
      "or": MessageLookupByLibrary.simpleMessage("або"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Сторінку не знайдено"),
      "password": MessageLookupByLibrary.simpleMessage("Пароль"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Пароль надто короткий"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Оберіть інтереси"),
      "post": MessageLookupByLibrary.simpleMessage("Опублікувати"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Статистика публікації"),
      "postInCommunity": (Object a0) => "Опублікувати в ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
          "Публікуйте, кажіть, показуйте."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Текст публікації скопійовано"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Політика конфіденційності"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Профіль оновлено"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Про себе"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Країна"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Відображуване ім'я"),
      "profile_location":
          MessageLookupByLibrary.simpleMessage("Місцезнаходження"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Торкніться, щоб змінити"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Вебсайт"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-сповіщення"),
      "quote": MessageLookupByLibrary.simpleMessage("Цитувати"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Цитувати публікацію"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Зв'язатися з людиною"),
      "remove": MessageLookupByLibrary.simpleMessage("Прибрати"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Видалити цей чат?"),
      "removeMember": (Object a0) => "Видалити ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Видалити це повідомлення?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("Відповіді, підписки та згадки"),
      "repliesPolicy": (Object a0) => "Відповіді: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Відповісти"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Усі можуть долучитися"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Бачити, репостити й цитувати цю публікацію, як і раніше, може будь-хто."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Відповідати на цю публікацію може будь-хто в Kyron."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Ваші підписники"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Відповідати на цю публікацію можуть лише ваші підписники."),
      "reply_mentioned": MessageLookupByLibrary.simpleMessage("Згадані люди"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Відповідати можуть лише люди, яких ви @згадали в цій публікації."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Ніхто не може відповідати"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Відповіді вимкнено. Ви все одно можете відповісти самі."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Хто може відповідати?"),
      "report": MessageLookupByLibrary.simpleMessage("Поскаржитися"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Звіт скопійовано. Вставте його в лист до підтримки."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Скаргу надіслано"),
      "repost": MessageLookupByLibrary.simpleMessage("Репост"),
      "reset": MessageLookupByLibrary.simpleMessage("Скинути"),
      "resetPassword": MessageLookupByLibrary.simpleMessage("Скиньте пароль"),
      "retry": MessageLookupByLibrary.simpleMessage("Повторити"),
      "save": MessageLookupByLibrary.simpleMessage("Зберегти"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Зберегти чернетку"),
      "saySomething": (Object a0) => "Скажіть щось у ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Пошук"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Пошук за іменем або ім'ям користувача"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Пошук спільнот"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Пошук GIF"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Пошук мов"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Пошук популярних тегів"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Сповіщення безпеки та зміни акаунта"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Оберіть мову інтерфейсу застосунку."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Оберіть, якими мовами показувати стрічку. Якщо нічого не вибрано, показуються всі мови."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Оберіть основну мову для перекладів у стрічці."),
      "send": MessageLookupByLibrary.simpleMessage("Надіслати"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Надіслати підтвердження"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Надіслати звіт про помилку"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Надіслати відгук"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Надіслати скаргу"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Надіслати в підтримку"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Стан сервісу"),
      "settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Поділитися журналом застосунку з підтримкою"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Вхід у Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Ви увійшли як"),
      "signupFailed": (Object a0) => "Не вдалося зареєструватися: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Залишитися"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron лише починається, і найшвидше зв'язатися з тим, хто справді може виправити проблему, — відкрити заявку. Розкажіть, що ви робили і що сталося."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "У застосунку поки немає скриньки підтримки, тож цей екран веде туди, де справді читають, а не до форми, що нікуди не йде."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Журнал застосунку"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Розкажіть, чого бракує або що зламалося"),
      "terms": MessageLookupByLibrary.simpleMessage("Умови використання"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Текст, голос і відео, люди, які їх створюють, і кімнати, де вони спілкуються."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "У редакторі немає кнопки «Опублікувати»"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Темна"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Завжди темна"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Приглушена"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "М'яка темна, синьо-сіра замість чорної"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Світла"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Завжди світла"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Системна"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Як світла чи темна тема телефона"),
      "translate": MessageLookupByLibrary.simpleMessage("Перекласти"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Переклад поки не працює. У стрічці поки нічого не перекладається; налаштування запам'ятається до того часу."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Це змінює власні слова Kyron, частини інтерфейсу, які Flutter малює сам, дати й числа, а також напрямок розкладки застосунку для мов із письмом справа наліво."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Спробувати ще раз"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Політика конфіденційності"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Умови використання"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Акаунт"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Після"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Застосунок і пристрій"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Це цитата, щоб застерегти людей від шахрайства."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Поясніть, чому ви вважаєте рішення помилковим: що означав допис, що команда могла пропустити або чому правило тут не підходить. Її прочитає інша людина, а не та, що ухвалила рішення."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Ваша апеляція"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Напишіть щонайменше \$count символів. Кожне рішення можна оскаржити один раз."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Надіслати апеляцію"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Апеляцію надіслано. Ви отримаєте сповіщення, коли буде ухвалено рішення."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Апеляція у справі \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Вигляд"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Світла, темна або як у телефоні"),
      "ui_before": MessageLookupByLibrary.simpleMessage("До"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Ви перестанете бачити одне одного в Kyron, а підписки між вами буде видалено. Йому не повідомлять."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Містить"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Для чого він (необов’язково)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Писати можуть лише модератори"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Для оголошень. Усі в спільноті й далі можуть читати та реагувати."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Додати фото або опитування"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Фото й відео"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Закрити чат"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Ніхто більше не зможе читати чи писати в ньому. Цю дію не можна скасувати."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Закрити цей чат?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Скопійовано"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Повідомлення видаляється для всіх. Kyron зберігає копію для перевірки."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Повідомлення видаляється для всіх у чаті."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Редагувати чат"),
      "ui_cchat_edit_message":
          MessageLookupByLibrary.simpleMessage("Редагувати"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("змінено"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Ви редагуєте повідомлення"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Не вдалося відкрити цей чат."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Чати"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Приєднатися до чату"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Приєднайтеся до спільноти, щоб бачити її чати й брати в них участь."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Учасників: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Вийти з чату"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Ви зможете читати його, доки перебуваєте в спільноті."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Писати тут можуть лише власник і модератори."),
      "ui_cchat_mute":
          MessageLookupByLibrary.simpleMessage("Вимкнути сповіщення"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Сповіщень із цього чату не буде, і він не враховується в лічильнику повідомлень."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Назва чату"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Новий чат"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Чатів поки немає."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Чатів поки немає. Відкрийте перший для спільноти."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Чати спільнот не мають наскрізного шифрування. Модератори спільноти та Kyron можуть їх читати."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Закріпити вгорі"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Додати відповідь"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Закрити опитування"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Закрито"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Усі бачать, скільки людей вибрали кожну відповідь, але не хто саме."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Дозволити кілька відповідей"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Нове опитування"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Виберіть одну"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Відповідь \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Опитування: \$question"),
      "ui_cchat_poll_question":
          MessageLookupByLibrary.simpleMessage("Запитання"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Кожна відповідь може бути в опитуванні лише один раз."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Виберіть одну або кілька"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("Відповіли: \$count"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Пошук у цьому чаті"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Пошук у цьому чаті"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Нічого не знайдено."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Ви більше не можете бачити цей чат."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Повільний режим"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Скільки потрібно чекати між повідомленнями. Не стосується модераторів."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 година"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Хвилин: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Повільний режим: одне повідомлення раз на \$seconds с"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Вимк."),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Секунд: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Ви можете читати й реагувати як глядач. Приєднайтеся, щоб писати."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Це повідомлення надто далеко в історії, щоб його показати."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Щось із вибраного завелике для надсилання, тож його не додано."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Увімкнути сповіщення"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Відкріпити"),
      "ui_cchat_voice": MessageLookupByLibrary.simpleMessage(
          "Записати голосове повідомлення"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Ви"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Спільноти"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Для чого це? (необов'язково)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Дописи:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Контент і відображення"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити стрічку"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити вподобані публікації"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити ваш профіль"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити збережені публікації"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Децентралізований ID"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("Усунення несправностей"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Групи"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Немає груп"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Тут групи, у яких ви є, і чати спільнот, до яких ви приєднуєтеся."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Можна закріпити не більше \$count чатів. Спершу відкріпіть один."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Закріплено"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Вподобане"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Збережене"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Тут поки нічого немає"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Підпишіться на кілька акаунтів, і їхні публікації з'являться тут."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "Нічого від тих, за ким ви стежите"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Публікації з'являтимуться тут, коли люди почнуть їх писати."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Слабне"),
      "ui_feed_signal_less": MessageLookupByLibrary.simpleMessage("Не цікаво"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Показувати більше таких"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Видалено"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Сигнали вашої стрічки"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Натисніть «Показувати більше таких дописів» або «Не цікаво» біля допису, і він з'явиться тут."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Тут поки нічого немає"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Що «Показувати більше» і «Не цікаво» кажуть вашим стрічкам"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Вони формують Головну та Огляд, переважно за темою кожного допису. Кожен сигнал щомісяця слабне вдвічі й через шість перестає враховуватися. Видаліть сигнал, щоб зупинити його зараз."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Тут з'являться публікації з кліпом."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Відео поки немає"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Відгук"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Знайдіть людей у Kyron"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Від акаунта"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Додати людей"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Додати"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Додати назву групи"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Відхилити"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Повідомлення в цій групі захищено наскрізним шифруванням, як і в будь-якій іншій розмові."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor додає: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor призначає адміністратором: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor створює групу"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor: нові люди приєднуються як учасники"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor: нові люди приєднуються як глядачі"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor виходить із групи"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor призначає учасником: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor передає власність: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor видаляє: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor перейменовує групу на \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor призначає глядачем: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "У групі може бути щонайбільше \$count людей."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Руку піднято. Адміністраторам повідомлено."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Хочуть писати: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Хочуть писати"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Додані пізніше приєднуються як глядачі"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Вийти з групи"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Вона зникне з вашого списку, і ви не побачите, що буде написано потім. Комусь доведеться додати вас знову."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Вийти з цієї групи?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Дозволити писати"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Опустити руку"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Призначити адміністратором"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Передати власність"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Зробити глядачем"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Учасників: \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Учасники"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Назва групи"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Спершу назвіть групу."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Створити груповий чат"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Власник лише один. Ви залишитеся адміністратором."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Передати власність: \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Підняти руку"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Видалити з групи"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Зняти права адміністратора"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Ви більше не в цій групі."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Перейменувати"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Адміністратор"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Учасник"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("Глядач"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Як глядач ви можете читати й реагувати."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Глядачі можуть читати, реагувати й підняти руку, щоб попросити дозволу писати."),
      "ui_group_suggested":
          MessageLookupByLibrary.simpleMessage("Рекомендовані"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Переглянути профіль"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("ви"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Ви глядач"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Допомога"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Враховано. Це допоможе обирати, що вам показувати."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Приєднатися"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Приєднався"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Мова"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Виберіть мову"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Правова інформація"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Подобається"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Вподобані публікації"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Вподобані публікації з'являться тут, спершу нові."),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Посилання скопійовано"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Ви більше не бачитимете його публікацій. Йому не повідомлять."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Вподобань поки немає"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Немає публікацій, що відповідають фільтрам."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Поки нічого не збережено"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Ваш обліковий запис оновлено"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Вашу апеляцію у справі \$number задоволено"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Ми повторно розглянули вашу апеляцію у справі \$number, і рішення залишається чинним"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Ваш обліковий запис заблоковано назавжди"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Справа \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("підписався(-лася) на вас"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("вподобав(-ла) ваш допис"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("згадав(ла) вас"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Згадок поки немає"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Коли хтось напише ваш @нік у дописі чи відповіді, це з'явиться тут."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Раніше"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Ваше повідомлення в чаті спільноти видалено"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Щось із опублікованого вами видалено"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Ваш допис видалено"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Вашу відповідь видалено"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("відповів(-ла) на ваш допис"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Ми вжили заходів за вашою скаргою. Дякуємо, що повідомили."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Ми перевірили вашу скаргу й не виявили порушень наших правил."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Причина скарги: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("поширив(-ла) ваш допис"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Ми скасували рішення у справі \$number"),
      "ui_notif_suspended": MessageLookupByLibrary.simpleMessage(
          "Ваш обліковий запис тимчасово заблоковано"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Ваш обліковий запис заблоковано до \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Усі"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Підписники"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Вподобання"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("Згадки"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Відповіді"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Цього тижня"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Сьогодні"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Ваш обліковий запис отримав попередження"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Учора"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Готово"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Пропустити"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Це вже відкривали."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Термін минув"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Не вдалося відкрити."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Відкривається один раз, потім видаляється з Kyron."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Одноразовий перегляд"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Відкрито"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Відкрили: \$count із \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Відкрити це можуть лише ті, кому ви надіслали, і лише раз."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Надіслати для одноразового перегляду"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Торкніться, щоб переглянути"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Пауза"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Відтворити"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Її буде видалено з вашого профілю та зі стрічок усіх користувачів. Відповіді на неї зникнуть разом із нею."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Публікацію видалено"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Публікацію приховано"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Текст публікації скопійовано"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Опубліковано в період"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Приховано. Показуватимемо менше такого."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Налаштування"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Конфіденційність"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Хочете щось додати? (необов’язково)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Ви отримаєте сповіщення, коли команда ухвалить рішення, а стежити за скаргою можна в розділі «Ваші скарги»."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Якщо ви також не хочете бачити цю людину, приховайте або заблокуйте її в тому самому меню."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Повторна скарга на те саме не додає їй ваги: ми зберігаємо одну скаргу від кожної людини."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Вашу скаргу не передають цій людині. Ми зберігаємо копію того, на що ви поскаржилися, щоб це можна було перевірити, навіть якщо його видалять."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Вашу скаргу отримано, і вона чекає на перевірку. Ми не повідомляємо цій людині, хто на неї поскаржився."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Переглянути ваші скарги"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Розкажіть, що не так"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Дякуємо, що повідомили"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Що не так із \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Що не так із цим повідомленням?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("Що не так із цим дописом?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("Що не так із цією відповіддю?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Повідомлення в чаті спільноти"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Допис"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Відповідь"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Вжито заходів"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("Обліковий запис"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Вирішено \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Порушень немає"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити ваші скарги"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Ваші скарги за останні 90 днів і чим вони завершилися. Ви отримуєте сповіщення, коли команда ухвалює рішення. Той, на кого ви поскаржилися, ніколи не дізнається, хто це зробив."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Скарг немає"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Коли ви поскаржитеся на допис, відповідь, повідомлення чи обліковий запис, скарга з’явиться тут разом із результатом."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("На розгляді"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Скарга від \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Ваші скарги і чим вони завершилися"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Ваші скарги"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Безпека дітей"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Усе, що загрожує неповнолітнім або сексуалізує їх."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Цілеспрямовані образи, погрози або небажаний контакт."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Напади на людей через те, ким вони є."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Продаж або реклама чогось незаконного."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Видавання себе за іншу людину."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Використовує ваш твір або торговельну марку без дозволу."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Оманливі твердження про здоров’я, вибори чи події."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Заохочення до самоушкодження або його показ."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Сексуальний вміст без попередження."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Нічого з переліченого. Розкажіть, що не так."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Повторювана, оманлива або небажана реклама."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Погрози насильством, його прославлення або заклики до нього."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Цькування або булінг"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Мова ворожнечі"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Незаконні товари чи послуги"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Видавання себе за іншу особу"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Інтелектуальна власність"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Неправдива інформація"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Самогубство або самоушкодження"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Контент для дорослих"),
      "ui_rule_something_else": MessageLookupByLibrary.simpleMessage("Інше"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Спам"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Насильство або погрози"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Збережені публікації"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Натисніть значок архіву на публікації, щоб зберегти її тут. Збережене бачите лише ви."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Шукайте за ім'ям користувача або відображуваним ім'ям."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Очистити"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "Пошук по всьому опублікованому"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Фільтри"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Пошук людей"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Пошук публікацій"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Застосунок і пристрій"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Контент і відображення"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Економія трафіку"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Поділіться думкою"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Довідкові статті"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Оберіть мову"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Кого ви приховали або заблокували"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Налаштування сповіщень"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("Ваш профіль і контактні дані"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Щоб повернутися до акаунта, доведеться увійти знову."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Налаштування безпеки"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Підтвердьте пароль"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("В одному рядку"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Нова адреса пошти"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Новий пароль"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Що сталося"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Допомога від нашої команди"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Поділитися"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Цитувати"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Надіслати в повідомленні"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Людям у Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Поділитися цією публікацією"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Про що йшлося"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Ваш обліковий запис заблоковано назавжди"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Відповідь, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Апеляція"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Оскаржити це рішення"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Це рішення вже не можна оскаржити. Якщо щось не так, зверніться до підтримки."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Апеляція на розгляді"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Апеляцію задоволено"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Інша людина з команди переглядає це знову. Ви отримаєте сповіщення, коли буде ухвалено рішення."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Якщо ви вважаєте, що це помилка, можете попросити переглянути рішення до \$date. Вирішує інша людина з команди."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Оскаржено: рішення залишається в силі"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Справа \$number. Правило: \$rule. Команда написала:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Видалення облікового запису не знімає блокування: новий обліковий запис із тією самою адресою електронної пошти теж буде заблоковано."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Заблоковано назавжди"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Працюють лише ця сторінка, апеляції, підтримка й видалення облікового запису."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Можна оскаржити"),
      "ui_standing_case":
          MessageLookupByLibrary.simpleMessage("Справа \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Рішення ухвалено \$date"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "Рішення щодо вашого облікового запису"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Видалити обліковий запис"),
      "ui_standing_details": MessageLookupByLibrary.simpleMessage("Докладніше"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Докладніше й оскаржити"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Закінчується \$date"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "З вашим обліковим записом усе гаразд"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Жодних обмежень."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити статус облікового запису"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Повідомлення видалено"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Щодо вашого облікового запису не ухвалювали жодних рішень. Якщо команда колись видалить щось ваше або обмежить ваш обліковий запис, це з’явиться тут із причиною, і ви зможете це оскаржити."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Нічого оскаржувати: рішення скасовано."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Допис видалено"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Потягніть униз, щоб перевірити ще раз."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Прочитати правила Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Відповідь видалено"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Скасовано"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Скасовано \$date. Усе видалене відновлено, і жодні обмеження більше не діють."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Правило: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Вийти"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Тимчасово заблоковано"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Ви можете читати, але не можете публікувати, відповідати, стежити чи надсилати повідомлення. Скарги, блокування й приховування й далі працюють."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Ваш обліковий запис тимчасово заблоковано: ви можете читати, але не публікувати."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Заблоковано до \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Ваш обліковий запис заблоковано до \$date: ви можете читати, але не публікувати."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Що написала команда"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Статус облікового запису"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Попередження"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Чому?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Ви написали \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Ваше повідомлення"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Ваш допис"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Ваша відповідь"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Умови використання"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ця публікація"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Гілку приховано"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Спробувати ще раз"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Вимкнути звук"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("Увімкнути звук"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Щонайменше два символи."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Скасувати"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Слова або фільтр: акаунт, період чи вміст публікації."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Скасувати репост"),
      "updatePassword": MessageLookupByLibrary.simpleMessage("Оновити пароль"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Використати іншу адресу"),
      "username": MessageLookupByLibrary.simpleMessage("Ім'я користувача"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Ім'я користувача має бути в нижньому регістрі (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Відео"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Вставити"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Готово до вставлення"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Записати голосову публікацію"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Збереження…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Стоп"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Що сталося"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Що сталося і на що нам звернути увагу?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Що на цьому зображенні?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Для чого це? (необов'язково)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Що ви робили, чого очікували, що сталося"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Що ви робили, коли це сталося."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Ви відповіли"),
      "dmReplied": (Object a0) => "Відповідь від $a0",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Додати до повідомлення"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Нове повідомлення"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Ще нічого не сказано. Помахати рукою — гарний початок."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Помахати"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Нові повідомлення"),
      "dmTyping": (Object a0) => "$a0 друкує",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Прибрати вашу реакцію"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Хтось"),
      "ui_dm_quote_message":
          MessageLookupByLibrary.simpleMessage("Повідомлення"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Вкладення"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Це повідомлення неможливо прочитати на цьому пристрої."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Очікування цього повідомлення. Це може зайняти деякий час."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Зашифроване повідомлення"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Повідомлення захищені наскрізним шифруванням"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Без наскрізного шифрування"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Надіслано"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Переглянуто"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Надсилання…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Зробити фото"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Інші дії"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Зберегти на пристрій"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Поділитися"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Збереження…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Збережено у фото"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося зберегти. Спробуйте ще раз."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Дозвольте Kyron додавати до ваших фото, щоб зберегти це."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Усі системи працюють"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Доступність"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Останні 60 днів"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 днів тому"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Сьогодні"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("База даних"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Вхід"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Нещодавні інциденти"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "За останні 60 днів інцидентів не було."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Триває"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Немає даних"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Подробиці"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron перевіряє себе кожні 5 хвилин, поки працює. У сірий день перевірок не було."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Історія доступності ще недоступна."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("У деяких системах є проблеми"),
      "ui_dm_voice": MessageLookupByLibrary.simpleMessage(
          "Записати голосове повідомлення"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Готово до надсилання"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Цього повідомлення вже немає."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Перейти до повідомлення"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Голосове повідомлення"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Сподобалося авторові"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Додати фото або кліп"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Медіа"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Голосові повідомлення"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Чат"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Шпалери"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Вимкнути сповіщення"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Більше не отримувати сповіщень про цю розмову"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Вони більше не зможуть вам писати"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Немає"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Сповіщення увімкнено."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося видалити. Спробуйте ще раз."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Профіль"),
      "ui_dm_unmute":
          MessageLookupByLibrary.simpleMessage("Увімкнути сповіщення"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Тут з'являються фото та кліпи, якими ви ділитеся."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Переглянути все"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("Фото та кліпи"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Так виглядатиме ваш чат."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Виглядає добре."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Туман"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Сутінки"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Шавлія"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Пісок"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Цятки"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("Застосувати"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Поточні"),
      "ui_dm_link_card_remove": MessageLookupByLibrary.simpleMessage(
          "Надіслати без попереднього перегляду"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Пошук"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Опублікувати"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Напишіть повідомлення…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Надіслати"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Надіслано"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Надіслано, але не всім."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося надіслати. Спробуйте ще раз."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Підписник"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Фільтр"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Усі"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Непрочитані"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Без відповіді"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Приховані"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Нічого не приховано"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Розмови, які ви прибираєте зі списку, чекають тут, якщо захочете їх повернути."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Вона переходить до Прихованих. Інша людина зберігає свою, а розмова повернеться, якщо хтось із вас знову напише."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Повернути"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Знову у вашому списку."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Немає відповідних розмов."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Ніщо не чекає на вас"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Кожна розмова закінчується вашим словом."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Відео"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Ще немає повідомлень"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Ви:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Учора"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Повідомлення"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Налаштування повідомлень"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Конфіденційність"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Звіти про прочитання"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Коли це вимкнено, люди не бачитимуть, коли ви прочитали їхні повідомлення, а ви не бачитимете, коли вони прочитали ваші."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Показувати, що ви друкуєте"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Людина, якій ви пишете, бачить, що ви пишете."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Попередній перегляд посилань"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Ваш телефон відкриває посилання, яке ви надсилаєте, щоб створити попередній перегляд, тож сайт бачить запит вашого телефона. Сервер Kyron ніколи не бачить посилання."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Сповіщення про повідомлення"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Повідомлення мають наскрізне шифрування. Kyron не може їх читати, і ніщо тут цього не змінює."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Кому:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Нещодавні"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Люди"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Нікого з таким ім'ям."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Надіслати тестове сповіщення"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Сервер Kyron ще не налаштовано для надсилання сповіщень, тож жодне не може надійти. Проблема на нашому боці, а не у вашому телефоні."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Цей телефон не зареєстровано для сповіщень. Перевірте, чи дозволено сповіщення Kyron у налаштуваннях телефона, і спробуйте ще раз."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Не вдалося доставити сповіщення на цей телефон. Спробуйте ще раз за хвилину."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Надіслано. Має надійти за кілька секунд."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Сповіщення працюють."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Ще немає дописів"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Нова спільнота"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Назва"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Адреса утворюється з назви."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Її знайдуть за адресою"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Ви будете власником. Зображення, банер і модераторів можна додати на її сторінці, щойно вона з'явиться."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Головна"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Дописи спільнот на Головній"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Дописи з ваших спільнот видно й на Головній. Якщо вимкнути, вони залишаються тут, у Спільнотах, де кожна показує, що нового."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Ваш список"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Кількість нових дописів"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Показувати, скільки дописів нових у кожній спільноті відтоді, як ви її востаннє відкривали."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Спільноти, якими ви керуєте"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Тут спільноти, які ви створили або модеруєте."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Власник"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Модератор"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Нові дописи"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Під вашим керуванням"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Налаштування спільнот"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Огляд"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Немає відповідних спільнот."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Нічого нового"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Кожна спільнота така, якою ви її залишили."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Ви поки нічим не керуєте"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "Більше нема до чого приєднатися"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ви в усіх спільнотах Kyron. Створіть ще одну."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Спробуйте інше слово або створіть спільноту з такою назвою."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Написати допис"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Учасники:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Опубліковано"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Переглянути"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Відкрити"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("У мережі"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Показувати, коли ви в мережі"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Ті, з ким ви листуєтеся, бачать зелену крапку, поки у вас відкритий Kyron. Коли це вимкнено, ви теж не бачитимете їхньої."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Пошук людей і дописів"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Спільноти, до яких можна приєднатися"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Поки що нема на що дивитися"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Тут з'являтимуться фото та кліпи, які публікують люди."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Стежити"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Видалити обліковий запис"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Це назавжди видалить ваш обліковий запис Kyron. Цю дію не можна скасувати."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Ваш профіль, дописи, відповіді, вподобання та репости"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Ваші повідомлення, зокрема надіслані іншим, а також фото й голосові повідомлення в них"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Ваші підписники, люди, на яких ви підписані, і ваші налаштування"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Створені вами спільноти перейдуть до модератора або учасника, який перебуває в них найдовше. Спільноту, у якій більше нікого немає, буде закрито."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Видалити ваш обліковий запис?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Ви не зможете нічого з цього повернути."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Ваш обліковий запис видалено."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Видалений обліковий запис"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Цей обліковий запис видалено, тому сюди більше не можна надсилати повідомлення."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Реєструвалися через Google? Скористайтеся «Sign in with Google»."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити цей фільтр."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Не вдалося записати відео."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Не вдалося додати фільтр до цього відео, тому його опубліковано без змін."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "У вашому дописі вже максимальна кількість вкладень."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Додаємо ваш фільтр…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Спалах"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Записати відео"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Відео"),
      "googleSignInCancelled":
          MessageLookupByLibrary.simpleMessage("Вхід через Google скасовано."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("ПОДАРУНКИ"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Цьому допису ще ніхто не надіслав подарунок."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Подарунок"),
      "analytics_gifts_label":
          MessageLookupByLibrary.simpleMessage("Подарунки"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Монети"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Відправник"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Відправники"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Тестові монети: їх поки не можна вивести."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Збережене"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Дописи"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Коментарі"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Переглянути більше відповідей"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Змінено"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Більше"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Відстежувані"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Найкращі"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Нові"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Сортувати коментарі: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "надсилає подарунок вашому допису"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "надсилає \$gift вашому коментарю"),
      "ui_notif_gift_named":
          MessageLookupByLibrary.simpleMessage("надсилає \$gift вашому допису"),
      "ui_gift_title":
          MessageLookupByLibrary.simpleMessage("Надіслати подарунок"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Редагувати допис"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Ви можете редагувати його ще \$n хв"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Зберегти"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Під #\$tab ще нічого не опубліковано."),
      "ui_gift_pick":
          MessageLookupByLibrary.simpleMessage("Виберіть подарунок"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Недостатньо монет"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Тестові монети: їх не можна купити, і вони не мають грошової вартості."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Поповнення: \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 монета"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("Монети: \$count"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("У вас \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Надіслати \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift надіслано"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Спробувати ще раз"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "Протягом 15 хвилин після публікації"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Змінено"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити збережені коментарі"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Немає збережених коментарів"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Торкніться значка архіву під коментарем, щоб зберегти його тут. Те, що ви зберігаєте, бачите лише ви."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Відповідь для \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Копіювати"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Пошук"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Вибрати все"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("Подарунки: \$count"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 подарунок"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити більше дописів."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Нагадування"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Що нового, поки вас не було, і коли повертаються монети. Не більше одного на день."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Подарунки"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("від 1 людини"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("від \$count людей"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Найщедріший"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити, хто надіслав подарунки."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Що нового"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Зрозуміло"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Дякуємо. Ми читаємо кожну відповідь."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Як вам Kyron поки що?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "День \$day вашого тестування. Достатньо одного дотику."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Що нам виправити або додати? (необов'язково)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Надіслати"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Не зараз"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Натисніть «Назад» ще раз, щоб вийти з Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Підтвердьте, що це ви"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Введіть пароль, щоб видалити обліковий запис."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Знову увійдіть через Google, щоб видалити обліковий запис."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося. Перевірте й спробуйте ще раз."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Ця сторінка хоче відкрити інший застосунок"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Вона просить відкрити посилання {scheme}."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("Збірка"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "{size} зображень і файлів у кеші"),
      "ui_about_freed":
          MessageLookupByLibrary.simpleMessage("Звільнено {size}"),
      "ui_about_measuring":
          MessageLookupByLibrary.simpleMessage("Вимірювання…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("Нема чого очищати"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("Сховище"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("Версія {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("Заблоковані"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("Публікуєте від свого імені"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "Ці вкладення не завантажилися. Торкніться одного, щоб спробувати ще раз, або видаліть його."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося змінити пошту. Спробуйте ще раз."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "Адреса зміниться, коли ви перейдете за посиланням, яке ми надішлемо."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "Перевірте {email} — там посилання для підтвердження."),
      "ui_email_enter": MessageLookupByLibrary.simpleMessage(
          "Введіть адресу електронної пошти."),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage(
          "Це не схоже на адресу електронної пошти."),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "Це вже ваша адреса електронної пошти."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "Що ви зробили, чого очікували і що сталося натомість."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "Дайте закріпити допис у профілі"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "Чого ви хочете і що це дасть вам зробити."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("Що допомогло б"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("Проблема"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("Ідея"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("Запитання"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "Це читає лише команда Kyron. Повідомлення надсилається разом з обліковим записом, щоб ми могли відповісти поштою, і з версією застосунку, якою ви користуєтеся. Якщо видалити обліковий запис, воно теж видалиться."),
      "ui_feedback_question_example":
          MessageLookupByLibrary.simpleMessage("Як приховати слово?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "Що ви намагаєтеся зробити і де застрягли."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("Ваше запитання"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Не вдалося зв'язатися з Kyron. Перевірте підключення і спробуйте ще раз. Поки нічого не написано, тож нічого не втрачено."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("Очистити"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Тут з'являються невдалі запити й інші помітні події."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("Приховані"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "Додайте слово або тег вище. Дописи з ним не потраплятимуть у вашу стрічку."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "Дописи з будь-яким із цих слів не потрапляють у вашу стрічку. Регістр не враховується, а слово знаходиться й усередині довших, тож «spoiler» спіймає й «spoilers»."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("Нікого не заблоковано"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "Блокування приховує вас одне від одного в обидва боки. Заблокувати можна в меню профілю."),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("Нікого не приховано"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "Приховування облікового запису ховає його дописи, не повідомляючи про це. Приховати можна в меню профілю або допису."),
      "ui_password": MessageLookupByLibrary.simpleMessage("Пароль"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("Не збігаються."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "На цьому пристрої ви залишитеся в обліковому записі. На інших пристроях буде виконано вихід."),
      "ui_password_too_short": MessageLookupByLibrary.simpleMessage(
          "Використайте щонайменше 8 символів."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося оновити пароль. Спробуйте ще раз."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("Пароль оновлено."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID скопійовано"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "Дописи, що вам сподобалися, зберігаються тут, лише для вас."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "Ви ще не публікували фото чи кліпів."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} ще не публікував(ла) фото чи кліпів."),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "Усе, що ви публікуєте, з'являється тут."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} ще нічого не опублікував(ла)."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити ваш профіль"),
      "ui_profile_load_failed_other": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити @{handle}"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("Щонайменше 8 символів"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("Мала літера (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("Хоча б одна цифра"),
      "ui_pw_rule_symbol":
          MessageLookupByLibrary.simpleMessage("Символ (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("Велика літера (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "Останніх записів: {count}. Перегляньте їх у розділі «Про застосунок › Системний журнал» перед надсиланням."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "Це читає лише команда Kyron. Повідомлення надсилається разом з обліковим записом, щоб ми могли відповісти. Спершу прочитайте журнал у розділі «Про застосунок › Системний журнал», якщо хочете побачити, що саме буде надіслано."),
      "ui_report_sent":
          MessageLookupByLibrary.simpleMessage("Надіслано, дякуємо."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "Надіслано, дякуємо. Номер звіту — #{number}."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("Що пішло не так?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "Версія, правила, стан і системний журнал"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "Не запускати відео автоматично під час прокручування"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "Ваш децентралізований ідентифікатор"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("Модерація"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "Скарги й апеляції, що чекають на розгляд"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "Не показувати у стрічці дописи з цими словами"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("Вхід не виконано"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("Налаштування сповіщень"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("Конфіденційність і безпека"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "Рішення щодо вашого облікового запису та апеляції"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("Змінити розмір тексту"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("Ваш обліковий запис"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "Запис і публікація AR-масок ще в розробці. Нічого із знятого поки не збережеться, тож камера лишається закритою."),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("Маски ще не готові"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR-маска"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "Для ефіру потрібен медіасервер, якого в Kyron поки немає. Якщо почати трансляцію зараз, ви опинитеся в кімнаті, куди ніхто не зможе увійти. Записати голосовий допис можна вже сьогодні."),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("Ефіри ще не готові"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("Почати ефір"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Опитуванням потрібне місце, де зберігати варіанти й рахувати голоси. Його поки немає, тож опитування, опубліковане сьогодні, втратить усі відповіді."),
      "ui_soon_poll_heading":
          MessageLookupByLibrary.simpleMessage("Опитування ще не готові"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("Опитування"),
      "ui_soon_write_instead":
          MessageLookupByLibrary.simpleMessage("Написати текстовий допис"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("Перевірити знову"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("Подробиці"),
      "ui_status_mirror":
          MessageLookupByLibrary.simpleMessage("Дзеркальні таблиці"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron відповів, але щось не так."),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("Час відгуку"),
      "ui_support_ask":
          MessageLookupByLibrary.simpleMessage("Поставити запитання"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Про обліковий запис або про те, як щось працює"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("Поштою"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Якщо Kyron аварійно закрився: надсилає журнал застосунку"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("У застосунку"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "Напишіть команді Kyron звідси. Повідомлення надійде нам приватно, разом з вашим обліковим записом, а відповімо ми на його адресу пошти."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "Поштовий застосунок не відкрився. {address} скопійовано."),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("Конфіденційність і ваші дані"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("Повідомити про проблему"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "Щось зламалося або працює не так, як має"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "Щоб поскаржитися на допис чи обліковий запис, скористайтеся його меню: так ми точно знатимемо, про що йдеться."),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("Безпека та порушення"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Чи не працює Kyron для всіх, чи лише для вас"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("Великий"),
      "ui_text_size_larger":
          MessageLookupByLibrary.simpleMessage("Дуже великий"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("Середній"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron — місце, де кажуть те, що варто прочитати."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("Малий"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Завжди темна"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("Приглушена"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "М'якша темна тема, синьо-сіра, а не чорна"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Завжди світла"),
      "ui_theme_system_detail":
          MessageLookupByLibrary.simpleMessage("Як у налаштуваннях телефона"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("Розблокувати"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("Показувати знову"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("Хто ви"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "Власними словами: що має знати перевіряльник."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "Я пишу про птахів тут і на своєму сайті."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("Додати ще посилання"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "Подати запит знову можна з {date}."),
      "ui_verify_ask":
          MessageLookupByLibrary.simpleMessage("Подати запит на підтвердження"),
      "ui_verify_before": MessageLookupByLibrary.simpleMessage("Перед запитом"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("Автор"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("Журналіст"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("Організація або бренд"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("Інше"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("Публічна особа"),
      "ui_verify_denied":
          MessageLookupByLibrary.simpleMessage("Запит {number} не схвалено"),
      "ui_verify_done":
          MessageLookupByLibrary.simpleMessage("Вас підтверджено"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("Редагувати профіль"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("Введіть 6-значний код"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "Надіслати код повторно через {seconds} с"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("Ми надіслали його на {email}"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("Підтвердити"),
      "ui_verify_hero": MessageLookupByLibrary.simpleMessage(
          "Пройдіть підтвердження в Kyron"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Пройдіть"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("підтвердження"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("в Kyron."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "Значок означає, що хтось із команди Kyron перевірив, що цей обліковий запис — той, за кого себе видає. Він не дає додаткового охоплення і не продається."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "Значок лишається, поки не змінюється ваше ім'я. Якщо змінити ім'я, значок зникне, доки хтось не перевірить нове."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("Де ми можемо перевірити"),
      "ui_verify_link_more":
          MessageLookupByLibrary.simpleMessage("Ще посилання"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "Сайт або інший профіль, де сказано, що цей обліковий запис Kyron ваш: укажіть там своє ім'я в Kyron або посилання на профіль. Kyron ніколи не просить документів."),
      "ui_verify_load_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завантажити ваш статус"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "Щоб подати запит, усе вище має бути позначене."),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "Обліковому запису щонайменше {days} днів"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("Опис, де сказано, хто ви"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("Ваше ім'я в профілі"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("Фото профілю"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "Жодних порушень за останні {days} днів"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "Надіслано. Запит перегляне людина."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("З {date}."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("Запит"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Хто ви, і посилання,\nщо це доводить"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("Значок"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "Поруч з вашим іменем,\nскрізь, де воно видно"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("Перевіряє\nлюдина"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "Хтось із команди\nпереходить за посиланнями"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("Підтвердження"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "Запит {number} у перевіряльника"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "Надіслано {date}, категорія: {category}. Коли рішення буде ухвалено, прийде сповіщення."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("Відкликати запит"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("Запит відкликано."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося завершити запис: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("До десяти хвилин."),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("Слухаю…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron потрібен дозвіл на мікрофон для запису. Його можна надати в налаштуваннях пристрою."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося почати запис: {error}"),
      "ui_2fa_title": MessageLookupByLibrary.simpleMessage("Двоетапний вхід"),
      "ui_2fa_help": MessageLookupByLibrary.simpleMessage(
          "Код з автентифікатора для інструментів команди"),
      "ui_2fa_intro": MessageLookupByLibrary.simpleMessage(
          "Інструменти команди, крім входу, запитують код із застосунку-автентифікатора, щоб одного викраденого пароля було недостатньо."),
      "ui_2fa_on":
          MessageLookupByLibrary.simpleMessage("Двоетапний вхід увімкнено."),
      "ui_2fa_remove": MessageLookupByLibrary.simpleMessage("Видалити"),
      "ui_2fa_set_up": MessageLookupByLibrary.simpleMessage("Налаштувати"),
      "ui_2fa_scan": MessageLookupByLibrary.simpleMessage(
          "Відскануйте це застосунком-автентифікатором або введіть ключ нижче. Якщо можете, додайте його у два застосунки: втративши єдиний, доведеться просити підтримку видалити його."),
      "ui_2fa_key": MessageLookupByLibrary.simpleMessage("Ключ налаштування"),
      "ui_2fa_copied":
          MessageLookupByLibrary.simpleMessage("Ключ налаштування скопійовано"),
      "ui_2fa_confirm": MessageLookupByLibrary.simpleMessage("Підтвердити"),
      "ui_2fa_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося почати налаштування. Спробуйте ще раз."),
      "ui_2fa_wrong": MessageLookupByLibrary.simpleMessage(
          "Цей код не спрацював. Перевірте час на телефоні та спробуйте ще раз."),
      "ui_2fa_code": MessageLookupByLibrary.simpleMessage("6-значний код"),
      "ui_2fa_enter": MessageLookupByLibrary.simpleMessage(
          "Введіть код із застосунку-автентифікатора"),
      "ui_2fa_verify": MessageLookupByLibrary.simpleMessage("Перевірити"),
      "ui_password_breached": MessageLookupByLibrary.simpleMessage(
          "Цей пароль траплявся у витоку даних, тож зловмисники пробують його одним із перших. Виберіть інший."),
    };

final messageLookup = MessageLookup();
