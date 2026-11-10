import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Слово, фраза или #тег"),
      "about": MessageLookupByLibrary.simpleMessage("О себе"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Добавить вариант"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Добавить языки…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Принять и продолжить"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Уже есть аккаунт Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Комментарии"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage("Разные люди, а не открытия"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Вовлечённость"),
      "analytics_likes":
          MessageLookupByLibrary.simpleMessage("Отметки «Нравится»"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Зрителей пока нет"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Эту публикацию ещё никто не открывал."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Опубликовано"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Сохранения"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Зрители"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("ЗРИТЕЛЕЙ В ДЕНЬ"),
      "and": MessageLookupByLibrary.simpleMessage("и"),
      "answerNumber": (Object a0) => "Вариант ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR-линза"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Приложить журнал приложения"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Задержка туда и обратно"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ПРОВЕРКА ТОКЕНА"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Попробовать снова"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Попробовать снова"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Если начать трансляцию сейчас, вы окажетесь в комнате, куда никто не сможет"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Создать сообщество"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Для чего это? (необязательно)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("войти снова."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("вернуться из этого списка."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Если его закрыть,"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("сначала вступите"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("скоро"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Публикуете от своего имени"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("публиковать в этом сообществе"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Только что"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Попробовать снова"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Тема 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Для вас"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("что-то есть."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("уже направляется туда."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", не"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("двигаюсь ли я"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Выключить звук"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Включить звук"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Для вас"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Ваши вкладки"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Попробовать снова"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Символ (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("ЗРИТЕЛЕЙ В ДЕНЬ"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("не удалось загрузить"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("эта публикация"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Хотите что-то добавить? (необязательно)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("эта публикация"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("От аккаунта"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Выйти"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Ваш аккаунт"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Подтвердите пароль"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("не сейчас"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Загрузка…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Публикация…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 ч назад"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Копировать ссылку на историю"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Ваша история"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Ваш аккаунт, ваши публикации и то, на что вы нажимаете, чтобы"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Добавить тему"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("своё."),
      "authorBlocked": (Object a0) => "${a0} заблокирован(а)",
      "authorPostsHidden": (Object a0) => "Вы не увидите публикации ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Заблокировать"),
      "blockAuthor": (Object a0) => "Заблокировать ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Сведения о сборке скопированы"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Продолжая, вы принимаете"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Продолжая, вы соглашаетесь с нашими Условиями использования и Политикой конфиденциальности"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Регистрируясь, вы принимаете"),
      "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
      "change": MessageLookupByLibrary.simpleMessage("Изменить"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Сменить почту"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Подтвердите аккаунт через письмо."),
      "checkKyronReachable":
          MessageLookupByLibrary.simpleMessage("Проверить, доступен ли Kyron"),
      "clear": MessageLookupByLibrary.simpleMessage("Очистить"),
      "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
      "closeCommunity": (Object a0) => "Закрыть ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Закрыть"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Закрыть это сообщество"),
      "communities": MessageLookupByLibrary.simpleMessage("Сообщества"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Найдите сообщество в Обзоре или создайте своё."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Выскажите горячее мнение (или тёплое)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("О чём думаете?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Скажите то, что можете сказать только вы…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("Это знак: отправляйте"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Пишите, говорите или думайте вслух"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Подтвердите пароль"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Связаться с поддержкой"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "У публикаций пока нет языка, поэтому это ещё не фильтрует ленту. Ваш выбор сохранится до тех пор."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Продолжить"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Продолжить с почтой"),
      "copy": MessageLookupByLibrary.simpleMessage("Копировать"),
      "copyReportInstead": MessageLookupByLibrary.simpleMessage(
          "Скопировать отчёт вместо этого"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Не удалось открыть вход через Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Не удалось выйти: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Не удалось сделать снимок."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Показывается в твоём профиле и под твоими публикациями."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Нет стран, подходящих под «{query}»."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Не показывать страну"),
      "country_search": MessageLookupByLibrary.simpleMessage("Поиск стран"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Показывается в твоём профиле и под твоими публикациями. Когда ты видишь чьи-то публикации, твоя страна учитывается в его Статистике, только в группах от пяти человек и никогда по имени."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Из настроек телефона"),
      "create": MessageLookupByLibrary.simpleMessage("Создать"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Создать аккаунт"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Создайте аккаунт"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Создайте профиль"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR-линза"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Начать эфир"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Текстовая публикация"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Голосовая публикация"),
      "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Удалить этот комментарий?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Удалить эту публикацию?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Опишите это вложение"),
      "description": MessageLookupByLibrary.simpleMessage("Описание"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID скопирован в буфер обмена"),
      "done": MessageLookupByLibrary.simpleMessage("Готово"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Закройте редактор, написав что-нибудь, и вам предложат сохранить черновик."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} дн. назад"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} ч назад"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Только что"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} мин назад"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Пока ничего не написано"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Опрос, пока без вопроса"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Цитата, пока без текста"),
      "drafts": MessageLookupByLibrary.simpleMessage("Черновики"),
      "editProfile":
          MessageLookupByLibrary.simpleMessage("Редактировать профиль"),
      "email": MessageLookupByLibrary.simpleMessage("Почта"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Уведомления по почте"),
      "explore": MessageLookupByLibrary.simpleMessage("Обзор"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Отслеживание лица недоступно на этом устройстве."),
      "feedTagDetail": (Object a0) =>
          "С тегом #${a0} пока ничего не опубликовано.",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("Подписаться на {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Подписчики"),
      "following": MessageLookupByLibrary.simpleMessage("Подписки"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
      "gettingHelp":
          MessageLookupByLibrary.simpleMessage("Как получить помощь"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Продолжить с Google"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Войти через Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google возвращает завершённый вход в Kyron по ссылке, на которую отвечают только Android и iOS, поэтому на платформе ${a0} браузеру некуда его вернуть.\\n\\nЕсли у вас уже есть аккаунт Kyron через Google, выберите «Продолжить с почтой» с тем же адресом и нажмите «Забыли пароль?»: вам придёт ссылка для создания пароля.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Вход через Google работает в приложении для телефона"),
      "googleSignUp": MessageLookupByLibrary.simpleMessage(
          "Зарегистрироваться через Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Руководства и ответы на частые вопросы"),
      "handle": MessageLookupByLibrary.simpleMessage("имя пользователя"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Помощь и поддержка"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Справочный центр"),
      "home": MessageLookupByLibrary.simpleMessage("Главная"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("В одной строке"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Ваш аккаунт"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Открыть сообщество"),
      "ins_act_post":
          MessageLookupByLibrary.simpleMessage("Написать публикацию"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Открыть публикацию"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Изменить профиль"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("Когда они бывают в сети"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("В вашем часовом поясе."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Возраст"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Из {known} охваченных людей, указавших день рождения."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Охваченные люди по дням"),
      "ins_communities": MessageLookupByLibrary.simpleMessage(
          "Сообщества, в которых они состоят"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Страны"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Из {known} охваченных людей, указавших страну в профиле."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Последние {days} дней"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить статистику"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Подписчики"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Пока нет достаточно большой группы, чтобы её показать."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Как расти"),
      "ins_interests": MessageLookupByLibrary.simpleMessage(
          "Темы, на которые они подписаны"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Отметки «Нравится»"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Новое"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Новые подписчики"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "За этот период ваши публикации никого не охватили."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Не подписаны на вас"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Страны — те, что люди выбрали в своих профилях. Kyron не собирает ничей город или пол, поэтому показывать по ним нечего."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Открытия"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "охват {reach} · {likes} отметок · {replies} ответов"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Охваченные люди"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Каждый человек считается один раз: ему впервые показали или он впервые открыл одну из ваших публикаций. Новые подписчики всё ещё подписаны на вас; отписки не учитываются."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Ответы"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Репосты"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Сохранения"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Кто ваша аудитория, станет видно, когда {floor} человек увидят ваши публикации за этот период. При меньшем числе это могло бы указать на конкретного человека."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Пока недостаточно людей"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% из них уже подписаны на вас: ваши публикации в основном доходят до тех, кто вас знает."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% из них ещё не подписаны на вас: ваши публикации находят."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Вы охватили {reach} человек — на {pct}% меньше, чем за прошлый период."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "За последние {days} дней вы охватили {reach} человек."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Вы охватили {reach} человек — примерно столько же, сколько за прошлый период."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "За последние {days} дней ваши публикации не увидел никто новый."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Вы охватили {reach} человек — на {pct}% больше, чем за прошлый период."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Вы охватили {reach} человек — в {times}× больше, чем за прошлый период."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Больше всего из них подписаны на тему «{name}»."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Аудитория"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Обзор"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Те, кто находит вашу публикацию, смотрят профиль, прежде чем подписаться. Лицо или логотип говорят им, что здесь кто-то есть."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Добавьте фото профиля"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Скажите в одной строке, о чём вы пишете, чтобы незнакомец знал, что ему даст подписка."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Напишите о себе"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "У {without} из {total} ваших публикаций не было темы. Тема помещает публикацию в ленту этой темы и перед теми, кто на неё подписан."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Добавляйте темы к публикациям"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} человек ответили на ваши публикации, а вы ответили на {answered}. Им было не всё равно настолько, чтобы написать: ответ превращает читателя в постоянного гостя."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Отвечайте на ответы"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Ваша аудитория активнее всего: {when}. У публикации незадолго до этого будет кому её встретить."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Публикуйте, когда они в сети"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} человек, не подписанных на вас, увидели ваши публикации, и {gained} подписались. Пусть описание и свежие публикации говорят, чего от вас ждать."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Превращайте читателей в подписчиков"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Одна публикация охватила в {times}× больше людей, чем обычно ваши другие. Посмотрите, что в ней было иначе, и делайте больше этого."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "Делайте больше того, что сработало"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Многие из тех, кто видит ваши публикации, состоят в сообществе {name}. Публикации там покажут вас и остальным."),
      "ins_tip_post_in_community_t": MessageLookupByLibrary.simpleMessage(
          "Публикуйте в сообществе {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Вы публиковали {posts} раз за {days} дней. Каждая публикация — ещё один шанс, что вас найдут, а ровный ритм держит вас в лентах подписчиков."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Публикуйте чаще"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Вы ничего не публиковали последние {days} дней. Без публикации ничего ни до кого не доходит."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Опубликуйте что-нибудь"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Статистика"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("Лучшие публикации"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "По сравнению с предыдущими {days} днями"),
      "interest_add": MessageLookupByLibrary.simpleMessage("Добавить интерес"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Перетащите, чтобы упорядочить"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "На панели помещается не больше пяти вкладок. Уберите одну, чтобы добавить другую."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Подписки"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Для вас"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Хештеги появятся здесь, когда люди начнут ими пользоваться."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Сейчас в тренде"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Видео"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Ваши вкладки"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Он исчезнет у вас обоих."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Он будет удалён из ветки."),
      "join": MessageLookupByLibrary.simpleMessage("Вступить"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Продолжить редактирование"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Экраны Kyron на вашем языке. Если какое-то слово звучит неправильно, сообщите нам через «Отправить отзыв»."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Языки"),
      "leave": MessageLookupByLibrary.simpleMessage("Покинуть"),
      "leaveCommunity": (Object a0) => "Покинуть ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Впустить обратно"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("Открыта 1 страница"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Добавить клип"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Добавить GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Добавить хештег"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Добавить фото"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Добавить опрос"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Добавить видео"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Добавить интерес"),
      "literaladdLabelAsATab": (Object a0) => "Добавить ${a0} как вкладку",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Язык приложения"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Версия приложения"),
      "literalblockAuthor": (Object a0) => "Заблокировать ${a0}",
      "literalblockAuthor2": (Object a0) => "Заблокировать ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Заблокировать этот аккаунт?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Отменить ответ"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Проверить снова"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Выбрать из галереи"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Очистить кэш"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Закрыть все страницы"),
      "literalcloseTabLabel": (Object a0) => "Закрыть ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Закрыть браузер"),
      "literalcloseWidgetCommunityName": (Object a0) => "Закрыть ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Связаться с поддержкой"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Языки контента"),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("Копировать ссылку"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
          "Копировать ссылку на публикацию"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Копировать текст публикации"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("Копировать текст"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить сообщества"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Не удалось загрузить GIF"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить уведомления"),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить участников"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить эти публикации"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("Не удалось загрузить этот чат"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить этот список"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить эту публикацию"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить этот ответ"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить популярные теги"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Не удалось загрузить ваши сообщества"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить сообщения"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Не удалось открыть это сообщество"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Не удалось опубликовать ответ."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Поиск не удался"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Не удалось выйти: ${a0}",
      "literalcountPagesOpen": (Object a0) => "Открыто страниц: ${a0}",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Обложка"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Экономия трафика"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Удалить публикацию"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Найти людей"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Не отвечать"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Черновик сохранён"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Сейчас не получается отправить отзыв"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Размер текста"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF не настроены"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Передать в другое приложение"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Скрыть пароль"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Скрыть эту публикацию"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Скрывает её и просит показывать меньше подобного"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Как себя вести"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Продолжить писать"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron не ответил"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0}: дата",
      "literalleaveCommunityName": (Object a0) => "Покинуть ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, линза для лица",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Понравившиеся публикации"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Ссылка скопирована"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Сделать модератором"),
      "literalmuteAuthor": (Object a0) => "Скрыть ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Скрыть эту ветку"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Скрыть слова или теги"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Скрытые и заблокированные аккаунты"),
      "literalmutedYouWillNotBeNotified":
          MessageLookupByLibrary.simpleMessage("Скрыто. Уведомлений не будет."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Ни одно приложение на этом устройстве не открывает ссылки ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Ни один браузер на этом устройстве не принял ссылку."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("DID пока нет"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Нет черновиков"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Интересов пока нет"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Отметок «Нравится» пока нет"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Сообщений пока нет"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Новых подписчиков нет"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Публикаций пока нет"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Ответов пока нет"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Репостов пока нет"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Ни один популярный тег не подходит"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Никого не найдено"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Никто не удалён"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Здесь пока никого нет"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Не интересно"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Ничего не найдено"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Пока ничего не в тренде"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("В журнале пока ничего нет"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Ничего не найдено"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Ничего не скрыто"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Смотреть пока нечего"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Нет непрочитанных"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Изменить это может только владелец"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Открыть ответ"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Откройте письмо от Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Пароль и вход"),
      "literalpostInCommunityName": (Object a0) => "Опубликовать в ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Опубликовать в ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Опубликуйте со своими словами сверху"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Основной язык"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-уведомления"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Проверяем…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Записать голосовую публикацию"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Записать заново"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Снять с модераторов"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Удалить из сообщества"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Убрать из сохранённого"),
      "literalremoveLabel": (Object a0) => "Убрать ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Убрать ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Удалить ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Удалить опрос"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Удалить этот вариант"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Удалить этот чат"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Удалить этот опрос"),
      "literalreportAuthor": (Object a0) => "Пожаловаться на ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Пожаловаться на публикацию"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Отправить код снова"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Сохранённые публикации"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Скажите что-нибудь"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Скажите что-нибудь в ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Поиск не удался"),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("Отправить снова"),
      "literalsendAgainInCooldownS": (Object a0) => "Повторить через ${a0} с",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Оставить отзыв"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Отправить ссылку"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Отправлено. Это отчёт №${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Задайте пароль и продолжайте"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Поделиться журналом с поддержкой"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Поделиться этим сообществом"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Поделиться этой страницей"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Поделиться этим профилем"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Поделиться…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Поделиться с цитатой"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Показывать больше таких"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Показать пароль"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Показать результаты"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Создать сообщество"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Начать запись"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Остановить загрузку"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Больше не видеть эту публикацию и ответы на неё"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Лента историй, элементов: ${a0}",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Сменить камеру"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Отметить человека"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Сделать снимок"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Нажмите на баннер или фото, чтобы сменить"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Нажмите на ссылку в нём"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Нажмите, чтобы добавить фото и обложку"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Не получилось. Попробуйте снова."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Не удалось загрузить этот GIF."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage("Эту ссылку здесь не открыть."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Камера закрыта"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Это сообщество"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Этот ответ удалён"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Перевести публикацию"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Выключить звук"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Включить звук"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Взять один из наших"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Код подтверждения отправлен снова."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Не удалось подтвердить: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Подтвердите почту"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Зрители, отметки, сохранения и комментарии"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Что хранит Kyron"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Что делало это приложение"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Что вы делали, чего ожидали, что произошло "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
          "Ваши публикации принадлежат вам"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Доступен ли Kyron прямо сейчас"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Кто может отвечать"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Кого отметить?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Вы уже подписаны на все популярные теги"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Вы всё просмотрели"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Вы не состоите ни в одном сообществе"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Вы вышли из аккаунта."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Вы покинули ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Вы ещё ничего не опубликовали"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Загрузить ещё"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Журнал очищен"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Журнал скопирован"),
      "logIn": MessageLookupByLibrary.simpleMessage("Войти"),
      "logOut": MessageLookupByLibrary.simpleMessage("Выйти"),
      "logOutQuestion":
          MessageLookupByLibrary.simpleMessage("Выйти из аккаунта?"),
      "login": MessageLookupByLibrary.simpleMessage("Вход"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Не удалось войти. Проверьте учётные данные."),
      "manage": MessageLookupByLibrary.simpleMessage("Управление"),
      "menu": MessageLookupByLibrary.simpleMessage("Меню"),
      "message": MessageLookupByLibrary.simpleMessage("Написать"),
      "messages": MessageLookupByLibrary.simpleMessage("Сообщения"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("Все разговоры прочитаны."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Откройте чей-нибудь профиль и нажмите «Написать», чтобы начать разговор."),
      "mute": MessageLookupByLibrary.simpleMessage("Скрыть"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Скрытые и заблокированные"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Скрытые слова и теги"),
      "name": MessageLookupByLibrary.simpleMessage("Имя"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Экран <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Новый адрес почты"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
      "newPost": MessageLookupByLibrary.simpleMessage("Новая публикация"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Не сейчас"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Не отправлено. Нажмите, чтобы повторить"),
      "nothingMatchesQuery": (Object a0) =>
          "В Kyron нет ничего по запросу \"${a0}\"",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Нечего копировать"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Сюда приходят отметки, ответы и новые подписчики."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Здесь появятся люди, которые на вас подписались."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Когда кому-то понравится ваша публикация, это появится здесь."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Сюда приходят ответы на ваши публикации."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Когда кто-то сделает репост вашей публикации, это появится здесь."),
      "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Открыть в браузере"),
      "or": MessageLookupByLibrary.simpleMessage("или"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Страница не найдена"),
      "password": MessageLookupByLibrary.simpleMessage("Пароль"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Пароль слишком короткий"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Выберите интересы"),
      "post": MessageLookupByLibrary.simpleMessage("Опубликовать"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Статистика публикации"),
      "postInCommunity": (Object a0) => "Опубликовать в ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
          "Публикуйте, говорите, показывайте."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Текст публикации скопирован"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Профиль обновлён"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("О себе"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Страна"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Отображаемое имя"),
      "profile_location":
          MessageLookupByLibrary.simpleMessage("Местоположение"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Нажмите, чтобы сменить"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Сайт"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-уведомления"),
      "quote": MessageLookupByLibrary.simpleMessage("Цитировать"),
      "quotePost":
          MessageLookupByLibrary.simpleMessage("Цитировать публикацию"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Связаться с человеком"),
      "remove": MessageLookupByLibrary.simpleMessage("Убрать"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Удалить этот чат?"),
      "removeMember": (Object a0) => "Удалить ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Удалить это сообщение?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("Ответы, подписки и упоминания"),
      "repliesPolicy": (Object a0) => "Ответы: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Ответить"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Все могут участвовать"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Видеть, репостить и цитировать эту публикацию по-прежнему может кто угодно."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Отвечать на эту публикацию может любой пользователь Kyron."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Ваши подписчики"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Отвечать на эту публикацию могут только ваши подписчики."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Упомянутые люди"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Отвечать могут только люди, которых вы @упомянули в этой публикации."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Никто не может отвечать"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Ответы отключены. Вы по-прежнему можете ответить сами."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Кто может отвечать?"),
      "report": MessageLookupByLibrary.simpleMessage("Пожаловаться"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Отчёт скопирован. Вставьте его в письмо в поддержку."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Жалоба отправлена"),
      "repost": MessageLookupByLibrary.simpleMessage("Репост"),
      "reset": MessageLookupByLibrary.simpleMessage("Сбросить"),
      "resetPassword": MessageLookupByLibrary.simpleMessage("Сбросьте пароль"),
      "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
      "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Сохранить черновик"),
      "saySomething": (Object a0) => "Скажите что-нибудь в ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Поиск"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Поиск по имени или имени пользователя"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Поиск сообществ"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Поиск GIF"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Поиск языков"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Поиск популярных тегов"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Оповещения безопасности и изменения аккаунта"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Выберите язык интерфейса приложения."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Выберите, на каких языках показывать ленту. Если не выбрано ничего, показываются все языки."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Выберите основной язык для переводов в ленте."),
      "send": MessageLookupByLibrary.simpleMessage("Отправить"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Отправить подтверждение"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Отправить отчёт об ошибке"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Отправить отзыв"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Отправить жалобу"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Отправить в поддержку"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("Состояние сервиса"),
      "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Поделиться журналом приложения с поддержкой"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Вход в Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Вы вошли как"),
      "signupFailed": (Object a0) => "Не удалось зарегистрироваться: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Остаться"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron только начинается, и быстрее всего связаться с тем, кто реально может исправить проблему, — открыть заявку. Расскажите, что вы делали и что произошло."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "В приложении пока нет ящика поддержки, поэтому этот экран ведёт туда, где действительно читают, а не к форме, которая никуда не уходит."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Журнал приложения"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Расскажите, чего не хватает или что сломалось"),
      "terms": MessageLookupByLibrary.simpleMessage("Условия использования"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Текст, голос и видео, люди, которые их создают, и комнаты, где они общаются."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "В редакторе нет кнопки «Опубликовать»"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Тёмная"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Всегда тёмная"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Приглушённая"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Мягкая тёмная, сине-серая вместо чёрной"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Светлая"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Всегда светлая"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Системная"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Как светлая или тёмная тема телефона"),
      "translate": MessageLookupByLibrary.simpleMessage("Перевести"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Перевод пока не работает. В ленте пока ничего не переводится; настройка запомнится до тех пор."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Это меняет собственные слова Kyron, части интерфейса, которые Flutter рисует сам, даты и числа, а также направление раскладки приложения для языков с письмом справа налево."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Попробовать снова"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Условия использования"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
      "ui_after": MessageLookupByLibrary.simpleMessage("После"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Приложение и устройство"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Это цитата, чтобы предупредить людей о мошенничестве."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Объясните, почему вы считаете решение ошибочным: что имелось в виду в публикации, что команда могла упустить или почему правило здесь не подходит. Её прочитает другой человек, а не тот, кто принимал решение."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Ваша апелляция"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Напишите не меньше \$count символов. Каждое решение можно обжаловать один раз."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Отправить апелляцию"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Апелляция отправлена. Вы получите уведомление, когда будет принято решение."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Апелляция по делу \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Оформление"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Светлая, тёмная или как в телефоне"),
      "ui_before": MessageLookupByLibrary.simpleMessage("До"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Вы перестанете видеть друг друга в Kyron, а подписки между вами будут удалены. Его не уведомят."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Содержит"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Для чего он (необязательно)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Писать могут только модераторы"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Для объявлений. Все в сообществе по-прежнему могут читать и реагировать."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Добавить фото или опрос"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Фото и видео"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Закрыть чат"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Никто больше не сможет читать или писать в нём. Это нельзя отменить."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Закрыть этот чат?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Скопировано"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Сообщение удаляется для всех. Kyron сохраняет копию для проверки."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Сообщение удаляется для всех в чате."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Изменить чат"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Изменить"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("изменено"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Вы редактируете сообщение"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Не удалось открыть этот чат."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Чаты"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("Вступить в чат"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Вступите в сообщество, чтобы видеть его чаты и участвовать в них."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Участников: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Покинуть чат"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Вы сможете читать его, пока состоите в сообществе."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Писать здесь могут только владелец и модераторы."),
      "ui_cchat_mute":
          MessageLookupByLibrary.simpleMessage("Отключить уведомления"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Уведомлений из этого чата не будет, и он не учитывается в счётчике сообщений."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Название чата"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Новый чат"),
      "ui_cchat_none": MessageLookupByLibrary.simpleMessage("Чатов пока нет."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Чатов пока нет. Откройте первый для сообщества."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Чаты сообществ не защищены сквозным шифрованием. Модераторы сообщества и Kyron могут их читать."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Закрепить наверху"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Добавить ответ"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Закрыть опрос"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Закрыт"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Все видят, сколько человек выбрали каждый ответ, но не кто именно."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Разрешить несколько ответов"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Новый опрос"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Выберите один"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("Ответ \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Опрос: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Вопрос"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Каждый ответ может быть в опросе только один раз."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Выберите один или несколько"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("Ответили: \$count"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Поиск в этом чате"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Поиск в этом чате"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Ничего не найдено."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Вы больше не можете видеть этот чат."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Медленный режим"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Сколько нужно ждать между сообщениями. Не касается модераторов."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 час"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Минут: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Медленный режим: одно сообщение раз в \$seconds с"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Выкл."),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Секунд: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Вы можете читать и реагировать как зритель. Вступите, чтобы писать."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Это сообщение слишком далеко в истории, чтобы его показать."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Что-то из выбранного слишком велико для отправки и не было добавлено."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Включить уведомления"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Открепить"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Записать голосовое сообщение"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Вы"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Сообщества"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Для чего это? (необязательно)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Публикации:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Контент и отображение"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("Не удалось загрузить ленту"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить понравившиеся публикации"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить ваш профиль"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить сохранённые публикации"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Децентрализованный ID"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("Устранение неполадок"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Группы"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Нет групп"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Здесь группы, в которых вы состоите, и чаты сообществ, к которым вы присоединяетесь."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Можно закрепить не больше \$count чатов. Сначала открепите один."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Закреплён"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Понравилось"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Сохранённое"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Здесь пока ничего нет"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Подпишитесь на несколько аккаунтов, и их публикации появятся здесь."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Ничего от ваших подписок"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Публикации появятся здесь, когда люди начнут их писать."),
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("Ослабевает"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Не интересно"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Показывать больше таких"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("Удалено"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Сигналы вашей ленты"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Нажмите «Показывать больше таких публикаций» или «Не интересно» у публикации, и она появится здесь."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Здесь пока ничего нет"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Что «Показывать больше» и «Не интересно» сообщают вашим лентам"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Они формируют Главную и Обзор, в основном по теме каждой публикации. Каждый сигнал каждый месяц ослабевает вдвое и через шесть перестаёт учитываться. Удалите сигнал, чтобы остановить его сейчас."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Здесь появятся публикации с клипом."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Видео пока нет"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Отзыв"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Найдите людей в Kyron"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("От аккаунта"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Добавить людей"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Добавить"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Добавить название группы"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Отклонить"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Сообщения в этой группе защищены сквозным шифрованием, как и в любом другом чате."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor добавляет: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor назначает администратором: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor создаёт группу"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor: новые участники входят как участники"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor: новые участники входят как зрители"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor выходит из группы"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor назначает участником: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor передаёт владение: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor удаляет: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor переименовывает группу в \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor назначает зрителем: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "В группе может быть не больше \$count человек."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Рука поднята. Администраторы уведомлены."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Хотят писать: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Хотят писать"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Добавленные позже входят как зрители"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Выйти из группы"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Она пропадёт из вашего списка, и вы не увидите, что будет написано потом. Кому-то придётся добавить вас снова."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Выйти из этой группы?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Разрешить писать"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Опустить руку"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Назначить администратором"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Передать владение"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Сделать зрителем"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Участников: \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Участники"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Название группы"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Сначала назовите группу."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Создать групповой чат"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Владелец только один. Вы останетесь администратором."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Передать владение: \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Поднять руку"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Удалить из группы"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Снять права администратора"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Вы больше не в этой группе."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Администратор"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Участник"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Зритель"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Как зритель вы можете читать и реагировать."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Зрители могут читать, реагировать и поднять руку, чтобы попросить разрешения писать."),
      "ui_group_suggested":
          MessageLookupByLibrary.simpleMessage("Рекомендуемые"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Открыть профиль"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("вы"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Вы зритель"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Помощь"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Учтено. Это поможет выбирать, что вам показывать."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Вступить"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Регистрация"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Язык"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Выберите язык"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Правовая информация"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Нравится"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Понравившиеся публикации"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Понравившиеся публикации появятся здесь, сначала новые."),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Ссылка скопирована"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Вы больше не будете видеть его публикации. Его не уведомят."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Отметок «Нравится» пока нет"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Нет публикаций, подходящих под фильтры."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Пока ничего не сохранено"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Ваш аккаунт обновлён"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Ваша апелляция по делу \$number принята"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Мы повторно рассмотрели вашу апелляцию по делу \$number, решение остаётся в силе"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Ваш аккаунт заблокирован навсегда"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Дело \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("подписался(-ась) на вас"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("оценил(а) вашу публикацию"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("упомянул(а) вас"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Упоминаний пока нет"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Когда кто-то напишет ваш @ник в публикации или ответе, это появится здесь."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Ранее"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Ваше сообщение в чате сообщества удалено"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Что-то из опубликованного вами удалено"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Ваша публикация удалена"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Ваш ответ удалён"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("ответил(а) на вашу публикацию"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Мы приняли меры по вашей жалобе. Спасибо, что сообщили."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Мы проверили вашу жалобу и не нашли нарушений наших правил."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Причина жалобы: \$reason"),
      "ui_notif_reposted": MessageLookupByLibrary.simpleMessage(
          "сделал(а) репост вашей публикации"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Мы отменили решение по делу \$number"),
      "ui_notif_suspended": MessageLookupByLibrary.simpleMessage(
          "Ваш аккаунт временно заблокирован"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Ваш аккаунт заблокирован до \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Все"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Подписчики"),
      "ui_notif_tab_likes":
          MessageLookupByLibrary.simpleMessage("Отметки «Нравится»"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Упоминания"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Ответы"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("На этой неделе"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Сегодня"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Ваш аккаунт получил предупреждение"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Вчера"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Готово"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Пропустить"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Это уже открывали."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Срок истёк"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Не удалось открыть."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Открывается один раз, затем удаляется из Kyron."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Одноразовый просмотр"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Открыто"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Открыли: \$count из \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Открыть это могут только те, кому вы отправили, и только один раз."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Отправить для одноразового просмотра"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Нажмите, чтобы посмотреть"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Пауза"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Воспроизвести"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Она будет удалена из вашего профиля и из лент всех пользователей. Ответы на неё удалятся вместе с ней."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Публикация удалена"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Публикация скрыта"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Текст публикации скопирован"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Опубликовано в период"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Скрыто. Будем показывать меньше такого."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Настройки"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Конфиденциальность"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Хотите что-то добавить? (необязательно)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Вы получите уведомление, когда команда примет решение, а следить за жалобой можно в разделе «Ваши жалобы»."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Если вы также не хотите видеть этого человека, скройте или заблокируйте его в том же меню."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Повторная жалоба на то же самое не придаёт ей веса: мы храним одну жалобу от каждого человека."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Ваша жалоба не передаётся этому человеку. Мы сохраняем копию того, на что вы пожаловались, чтобы это можно было проверить, даже если оно будет удалено."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Ваша жалоба получена и ждёт проверки. Мы не сообщаем этому человеку, кто на него пожаловался."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Посмотреть ваши жалобы"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Расскажите, что не так"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Спасибо, что сообщили"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Что не так с \$name?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("Что не так с этим сообщением?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Что не так с этой публикацией?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("Что не так с этим ответом?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Сообщение в чате сообщества"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Публикация"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Ответ"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Приняты меры"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Решено \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Нарушений нет"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить ваши жалобы"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Ваши жалобы за последние 90 дней и чем они закончились. Вы получаете уведомление, когда команда принимает решение. Тот, на кого вы пожаловались, никогда не узнает, кто это сделал."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Жалоб нет"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Когда вы пожалуетесь на публикацию, ответ, сообщение или аккаунт, жалоба появится здесь вместе с результатом."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("На рассмотрении"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Жалоба от \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Ваши жалобы и чем они закончились"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Ваши жалобы"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Безопасность детей"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Всё, что угрожает несовершеннолетним или сексуализирует их."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Целенаправленные оскорбления, угрозы или нежелательные контакты."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Нападки на людей за то, кто они есть."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Продажа или реклама чего-то незаконного."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Выдача себя за другого человека."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Использует ваше произведение или товарный знак без разрешения."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Вводящие в заблуждение заявления о здоровье, выборах или событиях."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Поощрение или демонстрация самоповреждения."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Сексуальный контент без предупреждения."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Ничего из перечисленного. Расскажите, что не так."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Повторяющаяся, вводящая в заблуждение или нежелательная реклама."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Угрозы насилием, его прославление или призывы к нему."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Травля или издевательства"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Язык вражды"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Незаконные товары или услуги"),
      "ui_rule_impersonation": MessageLookupByLibrary.simpleMessage(
          "Выдача себя за другого человека"),
      "ui_rule_intellectual_property": MessageLookupByLibrary.simpleMessage(
          "Интеллектуальная собственность"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Ложная информация"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Суицид или самоповреждение"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Контент для взрослых"),
      "ui_rule_something_else": MessageLookupByLibrary.simpleMessage("Другое"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Спам"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Насилие или угрозы"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Сохранённые публикации"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Нажмите значок архива на публикации, чтобы сохранить её здесь. Сохранённое видите только вы."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Ищите по имени пользователя или отображаемому имени."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Очистить"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "Поиск по всему опубликованному"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Фильтры"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Поиск людей"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Поиск публикаций"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Настройки"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Приложение и устройство"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Контент и отображение"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Экономия трафика"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Поделитесь мнением"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Справочные статьи"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Выберите язык"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Кого вы скрыли или заблокировали"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Настройки уведомлений"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Ваш профиль и контактные данные"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Чтобы вернуться в аккаунт, нужно будет войти снова."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Настройки безопасности"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Подтвердите пароль"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("В одной строке"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Новый адрес почты"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Новый пароль"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Что произошло"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Помощь от нашей команды"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Поделиться"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Цитировать"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Отправить в сообщении"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Людям в Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Поделиться этой публикацией"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("О чём шла речь"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Ваш аккаунт заблокирован навсегда"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Ответ, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Апелляция"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Обжаловать это решение"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Это решение больше нельзя обжаловать. Если что-то не так, свяжитесь с поддержкой."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Апелляция на рассмотрении"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Апелляция принята"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Другой человек из команды пересматривает его. Вы получите уведомление, когда будет принято решение."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Если вы считаете, что это ошибка, вы можете попросить пересмотреть решение до \$date. Решает другой человек из команды."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Обжаловано: решение остаётся в силе"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Дело \$number. Правило: \$rule. Команда написала:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Удаление аккаунта не снимает блокировку: новый аккаунт с тем же адресом электронной почты тоже будет заблокирован."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Заблокирован навсегда"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Работают только эта страница, апелляции, поддержка и удаление аккаунта."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Можно обжаловать"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Дело \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Решение принято \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Решения по вашему аккаунту"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
      "ui_standing_details": MessageLookupByLibrary.simpleMessage("Подробнее"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Подробнее и обжаловать"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Заканчивается \$date"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "С вашим аккаунтом всё в порядке"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Никаких ограничений."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить статус аккаунта"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Сообщение удалено"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "По вашему аккаунту не принималось никаких решений. Если команда когда-нибудь удалит что-то ваше или ограничит ваш аккаунт, это появится здесь с причиной, и вы сможете это обжаловать."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Нечего обжаловать: решение отменено."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Публикация удалена"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Потяните вниз, чтобы проверить снова."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Прочитать правила Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Ответ удалён"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Отменено"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Отменено \$date. Всё удалённое восстановлено, и никакие ограничения больше не действуют."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Правило: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Выйти"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Временно заблокирован"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Вы можете читать, но не можете публиковать, отвечать, подписываться и отправлять сообщения. Жалобы, блокировка и скрытие по-прежнему работают."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Ваш аккаунт временно заблокирован: вы можете читать, но не публиковать."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Заблокирован до \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Ваш аккаунт заблокирован до \$date: вы можете читать, но не публиковать."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Что написала команда"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Статус аккаунта"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Предупреждение"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Почему?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Вы написали \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Ваше сообщение"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Ваша публикация"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Ваш ответ"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Условия использования"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("эта публикация"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Ветка скрыта"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Повторить"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Выключить звук"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Включить звук"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Не менее двух символов."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Отменить"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Слова или фильтр: аккаунт, период или содержимое публикации."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Отменить репост"),
      "updatePassword": MessageLookupByLibrary.simpleMessage("Обновить пароль"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Использовать другой адрес"),
      "username": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Имя пользователя должно быть в нижнем регистре (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Видео"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Вставить"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Готово к вставке"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Записать голосовую публикацию"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Сохранение…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Стоп"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Что произошло"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Что случилось и на что нам обратить внимание?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Что на этом изображении?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Для чего это? (необязательно)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Что вы делали, чего ожидали, что произошло"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Что вы делали, когда это случилось."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Вы ответили"),
      "dmReplied": (Object a0) => "Ответ от $a0",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Добавить в сообщение"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Новое сообщение"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Пока ничего не сказано. Помахать рукой — хорошее начало."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Помахать"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Новые сообщения"),
      "dmTyping": (Object a0) => "$a0 печатает",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Убрать вашу реакцию"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Кто-то"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Сообщение"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Вложение"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Это сообщение нельзя прочитать на этом устройстве."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Ожидание этого сообщения. Это может занять некоторое время."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Зашифрованное сообщение"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Сообщения защищены сквозным шифрованием"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Без сквозного шифрования"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Отправлено"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Просмотрено"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Отправка…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Сделать фото"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Другие действия"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Сохранить на устройство"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Поделиться"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Сохранение…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Сохранено в фото"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось сохранить. Попробуйте ещё раз."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Разрешите Kyron добавлять в ваши фото, чтобы сохранить это."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Все системы работают"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Доступность"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Последние 60 дней"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 дней назад"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Сегодня"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("База данных"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Вход"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Недавние инциденты"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "За последние 60 дней инцидентов не было."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Продолжается"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Нет данных"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Подробности"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron проверяет себя каждые 5 минут, пока работает. В серый день проверок не было."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "История доступности пока недоступна."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "В некоторых системах есть проблемы"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Записать голосовое сообщение"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Готово к отправке"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Этого сообщения больше нет."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Перейти к сообщению"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Голосовое сообщение"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Понравилось автору"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Добавить фото или клип"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Медиа"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Голосовые сообщения"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Чат"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Обои"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Отключить уведомления"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Больше не получать уведомления об этом разговоре"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Они больше не смогут вам писать"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Нет"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Уведомления включены."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось удалить. Попробуйте ещё раз."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Профиль"),
      "ui_dm_unmute":
          MessageLookupByLibrary.simpleMessage("Включить уведомления"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Здесь появляются фото и клипы, которыми вы делитесь."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Смотреть все"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("Фото и клипы"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Так будет выглядеть ваш чат."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Выглядит хорошо."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Туман"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Сумерки"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Шалфей"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Песок"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Точки"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("Применить"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Текущие"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Отправить без превью"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Поиск"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Опубликовать"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Напишите сообщение…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Отправить"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Отправлено"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Отправлено, но не всем."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось отправить. Попробуйте ещё раз."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Подписчик"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Все"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Непрочитанные"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Без ответа"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Скрытые"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Ничего не скрыто"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Разговоры, которые вы убираете из списка, ждут здесь — на случай, если захотите их вернуть."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Он перемещается в Скрытые. У собеседника он остаётся, и он вернётся, если кто-то из вас снова напишет."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Вернуть"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Снова в вашем списке."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Подходящих разговоров нет."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Вас ничего не ждёт"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Каждый разговор заканчивается вашим словом."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Видео"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Сообщений пока нет"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Вы:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Вчера"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Сообщения"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Настройки сообщений"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Конфиденциальность"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Отчёты о прочтении"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Если это выключено, другие не увидят, когда вы прочитали их сообщения, а вы не увидите, когда они прочитали ваши."),
      "ui_dm_typing_setting": MessageLookupByLibrary.simpleMessage(
          "Показывать, когда вы печатаете"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Собеседник видит, что вы пишете."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Предпросмотр ссылок"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Чтобы сделать предпросмотр, ваш телефон открывает отправляемую ссылку, поэтому сайт видит запрос вашего телефона. Сервер Kyron никогда не видит ссылку."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Уведомления о сообщениях"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Сообщения защищены сквозным шифрованием. Kyron не может их прочитать, и ничто здесь этого не меняет."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Кому:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Недавние"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Люди"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Нет никого с таким именем."),
      "ui_push_test": MessageLookupByLibrary.simpleMessage(
          "Отправить тестовое уведомление"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Сервер Kyron ещё не настроен на отправку уведомлений, поэтому ни одно не может прийти. Проблема на нашей стороне, а не в вашем телефоне."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Этот телефон не зарегистрирован для уведомлений. Проверьте, что уведомления Kyron разрешены в настройках телефона, и попробуйте снова."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Не удалось доставить уведомление на этот телефон. Попробуйте снова через минуту."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Отправлено. Оно должно прийти через несколько секунд."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Уведомления работают."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Пока нет публикаций"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Новое сообщество"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Название"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Адрес составляется из названия."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Его найдут по адресу"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Вы станете владельцем. Картинку, баннер и модераторов можно добавить на его странице, когда оно появится."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Главная"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Публикации сообществ на Главной"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Публикации ваших сообществ видны и на Главной. Если выключить, они останутся здесь, в Сообществах, где каждое показывает, что нового."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Ваш список"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Число новых публикаций"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Показывать, сколько публикаций появилось в каждом сообществе с тех пор, как вы открывали его в последний раз."),
      "ui_community_settings_running": MessageLookupByLibrary.simpleMessage(
          "Сообщества, которыми вы управляете"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Здесь сообщества, которые вы создали или модерируете."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Владелец"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Модератор"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Новые публикации"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Под вашим управлением"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Настройки сообществ"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Обзор"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Подходящих сообществ нет."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Ничего нового"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Все сообщества такие, какими вы их оставили."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Вы пока ничем не управляете"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "Больше не к чему присоединиться"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Вы во всех сообществах Kyron. Создайте ещё одно."),
      "ui_community_discover_search_detail": MessageLookupByLibrary.simpleMessage(
          "Попробуйте другое слово или создайте сообщество с таким названием."),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("Написать"),
      "ui_community_members":
          MessageLookupByLibrary.simpleMessage("Участники:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Опубликовано"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Посмотреть"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Открыть"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("В сети"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Показывать, когда вы в сети"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Те, с кем вы переписываетесь, видят зелёную точку, пока у вас открыт Kyron. Если это выключено, вы тоже не увидите их точку."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Поиск людей и публикаций"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Сообщества, к которым можно присоединиться"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Пока здесь не на что смотреть"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Здесь появятся фото и клипы, которые публикуют люди."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Подписаться"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Ваш аккаунт Kyron будет удалён навсегда. Это действие нельзя отменить."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Ваш профиль, публикации, ответы, отметки «Нравится» и репосты"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Ваши сообщения, включая отправленные другим людям, а также фото и голосовые сообщения в них"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Ваши подписчики, люди, на которых вы подписаны, и ваши настройки"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Созданные вами сообщества перейдут к модератору или участнику, который состоит в них дольше всех. Сообщество, в котором больше никого нет, будет закрыто."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Удалить ваш аккаунт?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Вы не сможете ничего из этого вернуть."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Ваш аккаунт удалён."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Удалённый аккаунт"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Этот аккаунт удалён, поэтому сюда больше нельзя отправлять сообщения."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Регистрировались через Google? Используйте «Sign in with Google»."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить эту маску."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Не удалось записать видео."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Не удалось добавить маску к этому видео, поэтому оно публикуется в исходном виде."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "В вашей публикации уже максимальное число вложений."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Добавляем маску…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Вспышка"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Записать видео"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Видео"),
      "googleSignInCancelled":
          MessageLookupByLibrary.simpleMessage("Вход через Google отменён."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("ПОДАРКИ"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Этой публикации ещё никто не отправлял подарков."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Подарок"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Подарки"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Монеты"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Отправитель"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Отправители"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Тестовые монеты: их пока нельзя вывести."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Сохранённое"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Публикации"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Комментарии"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Показать ещё ответы"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Изменено"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Ещё"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Подписки"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Лучшие"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Новые"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage(
          "Сортировать комментарии: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "отправляет подарок вашей публикации"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "отправляет \$gift вашему комментарию"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "отправляет \$gift вашей публикации"),
      "ui_gift_title":
          MessageLookupByLibrary.simpleMessage("Отправить подарок"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("Редактировать публикацию"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Можно редактировать ещё \$n мин"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Сохранить"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "В #\$tab пока ничего не опубликовано."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Выберите подарок"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Недостаточно монет"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Тестовые монеты: их нельзя купить, и они не имеют денежной ценности."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Пополнение: \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 монета"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("Монеты: \$count"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("У вас \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Отправить \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift отправлен"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Повторить"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "В течение 15 минут после публикации"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Изменено"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить сохранённые комментарии"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Нет сохранённых комментариев"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Нажмите на значок архива под комментарием, чтобы сохранить его здесь. Сохранённое видите только вы."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Ответ для \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Копировать"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Поиск"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Выбрать всё"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("Подарки: \$count"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 подарок"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить больше публикаций."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Напоминания"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Что нового, пока вас не было, и когда вернутся монеты. Не чаще одного в день."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Подарки"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("от 1 человека"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("от \$count человек"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Самый щедрый"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить, кто отправил подарки."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Что нового"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Понятно"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Спасибо. Мы читаем каждый ответ."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Как вам Kyron пока?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "День \$day вашего тестирования. Достаточно одного касания."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Что нам исправить или добавить? (необязательно)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Отправить"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Не сейчас"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Нажмите «Назад» ещё раз, чтобы выйти из Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Подтвердите, что это вы"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Введите пароль, чтобы удалить аккаунт."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Снова войдите через Google, чтобы удалить аккаунт."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Не получилось. Проверьте и попробуйте ещё раз."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Эта страница хочет открыть другое приложение"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Она просит открыть ссылку {scheme}."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("Сборка"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "{size} изображений и файлов в кэше"),
      "ui_about_freed":
          MessageLookupByLibrary.simpleMessage("Освобождено {size}"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("Подсчёт…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("Нечего очищать"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("Хранилище"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("Версия {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("Заблокированные"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("Публикация от вашего имени"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "Эти вложения не загрузились. Нажмите на одно, чтобы повторить, или удалите его."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось изменить почту. Попробуйте ещё раз."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "Адрес изменится, когда вы перейдёте по ссылке из нашего письма."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "Проверьте {email} — там ссылка для подтверждения."),
      "ui_email_enter": MessageLookupByLibrary.simpleMessage(
          "Введите адрес электронной почты."),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage(
          "Это не похоже на адрес электронной почты."),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "Это уже ваш адрес электронной почты."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "Что вы сделали, чего ожидали и что произошло вместо этого."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "Дайте закрепить пост в профиле"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "Чего вы хотите и что это позволит вам сделать."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("Что помогло бы"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("Проблема"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("Идея"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("Вопрос"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "Это читает только команда Kyron. Сообщение отправляется вместе с аккаунтом, чтобы мы могли ответить по почте, и с версией приложения, которой вы пользуетесь. Если удалить аккаунт, оно тоже удалится."),
      "ui_feedback_question_example":
          MessageLookupByLibrary.simpleMessage("Как скрыть слово?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "Что вы пытаетесь сделать и где застряли."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("Ваш вопрос"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Не удалось связаться с Kyron. Проверьте подключение и попробуйте ещё раз. Пока ничего не написано, так что ничего не потеряно."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("Очистить"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Здесь появляются неудачные запросы и другие заметные события."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("Скрытые"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "Добавьте слово или тег выше. Посты с ним не будут попадать в вашу ленту."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "Посты с любым из этих слов не попадают в вашу ленту. Регистр не важен, а слово находится и внутри более длинных, так что «spoiler» поймает и «spoilers»."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("Никто не заблокирован"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "Блокировка скрывает вас друг от друга в обе стороны. Заблокировать можно в меню профиля."),
      "ui_nobody_muted": MessageLookupByLibrary.simpleMessage("Никто не скрыт"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "Скрытие аккаунта убирает его посты, не сообщая ему об этом. Скрыть можно в меню профиля или поста."),
      "ui_password": MessageLookupByLibrary.simpleMessage("Пароль"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("Не совпадают."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "На этом устройстве вы останетесь в аккаунте. С других устройств выход будет выполнен."),
      "ui_password_too_short": MessageLookupByLibrary.simpleMessage(
          "Используйте не меньше 8 символов."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось обновить пароль. Попробуйте ещё раз."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("Пароль обновлён."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID скопирован"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "Понравившиеся посты хранятся здесь, только для вас."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "Вы ещё не публиковали фото или клипы."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} ещё не публиковал(а) фото или клипы."),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "Всё, что вы публикуете, появляется здесь."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} ещё ничего не публиковал(а)."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить ваш профиль"),
      "ui_profile_load_failed_other": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить @{handle}"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("Не меньше 8 символов"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("Строчная буква (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("Хотя бы одна цифра"),
      "ui_pw_rule_symbol":
          MessageLookupByLibrary.simpleMessage("Символ (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("Заглавная буква (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "Последних записей: {count}. Просмотрите их в разделе «О приложении › Системный журнал» перед отправкой."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "Это читает только команда Kyron. Сообщение отправляется вместе с аккаунтом, чтобы мы могли ответить. Сначала прочтите журнал в разделе «О приложении › Системный журнал», если хотите увидеть, что именно отправится."),
      "ui_report_sent":
          MessageLookupByLibrary.simpleMessage("Отправлено, спасибо."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "Отправлено, спасибо. Номер отчёта — #{number}."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("Что пошло не так?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "Версия, правила, статус и системный журнал"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "Не запускать видео автоматически при прокрутке"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "Ваш децентрализованный идентификатор"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("Модерация"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "Жалобы и апелляции, ждущие проверки"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "Не показывать в ленте посты с этими словами"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("Вход не выполнен"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("Настройки уведомлений"),
      "ui_settings_privacy_safety": MessageLookupByLibrary.simpleMessage(
          "Конфиденциальность и безопасность"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "Решения по вашему аккаунту и апелляции"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("Изменить размер текста"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("Ваш аккаунт"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "Запись и публикация AR-масок ещё в разработке. Ничего из снятого пока не сохранится, поэтому камера остаётся закрытой."),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("Маски пока не готовы"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR-маска"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "Для эфира нужен медиасервер, которого у Kyron пока нет. Если начать трансляцию сейчас, вы окажетесь в комнате, куда никто не сможет войти. Записать голосовой пост можно уже сегодня."),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("Эфиры пока не готовы"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("Начать эфир"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Опросам нужно место, где хранить варианты и считать голоса. Его пока нет, поэтому опрос, опубликованный сегодня, потеряет все ответы."),
      "ui_soon_poll_heading":
          MessageLookupByLibrary.simpleMessage("Опросы пока не готовы"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("Опрос"),
      "ui_soon_write_instead":
          MessageLookupByLibrary.simpleMessage("Написать текстовый пост"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("Проверить снова"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("Подробности"),
      "ui_status_mirror":
          MessageLookupByLibrary.simpleMessage("Зеркальные таблицы"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron ответил, но что-то не так."),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("Время отклика"),
      "ui_support_ask": MessageLookupByLibrary.simpleMessage("Задать вопрос"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Об аккаунте или о том, как что-то работает"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("По почте"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Если Kyron вылетел: отправляет журнал приложения"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("В приложении"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "Напишите команде Kyron отсюда. Сообщение придёт нам лично, вместе с вашим аккаунтом, а ответим мы на его адрес почты."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "Почтовое приложение не открылось. {address} скопирован."),
      "ui_support_privacy": MessageLookupByLibrary.simpleMessage(
          "Конфиденциальность и ваши данные"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("Сообщить о проблеме"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "Что-то сломалось или работает не так, как должно"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "Чтобы пожаловаться на пост или аккаунт, используйте его меню: так мы точно поймём, о чём речь."),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("Безопасность и нарушения"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Не работает ли Kyron у всех или только у вас"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("Крупный"),
      "ui_text_size_larger":
          MessageLookupByLibrary.simpleMessage("Очень крупный"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("Средний"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron — место, где говорят то, что стоит прочитать."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("Мелкий"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Всегда тёмная"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("Приглушённая"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Более мягкая тёмная тема, сине-серая, а не чёрная"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Всегда светлая"),
      "ui_theme_system_detail":
          MessageLookupByLibrary.simpleMessage("Как в настройках телефона"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("Разблокировать"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("Показывать снова"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("Кто вы"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "Своими словами: что должен знать проверяющий."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "Я пишу о птицах здесь и на своём сайте."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("Добавить ещё ссылку"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "Подать заявку снова можно с {date}."),
      "ui_verify_ask": MessageLookupByLibrary.simpleMessage(
          "Подать заявку на подтверждение"),
      "ui_verify_before": MessageLookupByLibrary.simpleMessage("Перед заявкой"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("Автор"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("Журналист"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("Организация или бренд"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("Другое"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("Публичная личность"),
      "ui_verify_denied":
          MessageLookupByLibrary.simpleMessage("Заявка {number} не одобрена"),
      "ui_verify_done": MessageLookupByLibrary.simpleMessage("Вы подтверждены"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("Изменить профиль"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("Введите 6-значный код"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "Отправить код повторно через {seconds} с"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("Мы отправили его на {email}"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("Подтвердить"),
      "ui_verify_hero": MessageLookupByLibrary.simpleMessage(
          "Пройдите подтверждение в Kyron"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Пройдите"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("подтверждение"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("в Kyron."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "Значок означает, что кто-то из команды Kyron проверил, что этот аккаунт — тот, за кого себя выдаёт. Он не даёт дополнительного охвата и не продаётся."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "Значок остаётся, пока не меняется ваше имя. Если сменить имя, значок исчезнет, пока кто-нибудь не проверит новое."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("Где мы можем проверить"),
      "ui_verify_link_more": MessageLookupByLibrary.simpleMessage("Ещё ссылка"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "Сайт или другой профиль, где сказано, что этот аккаунт Kyron ваш: укажите там своё имя в Kyron или ссылку на профиль. Kyron никогда не просит документы."),
      "ui_verify_load_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось загрузить ваш статус"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "Чтобы подать заявку, всё выше должно быть отмечено."),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "Аккаунту не меньше {days} дней"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("Описание, где сказано, кто вы"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("Ваше имя в профиле"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("Фото профиля"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "Никаких нарушений за последние {days} дней"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "Отправлено. Заявку посмотрит человек."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("С {date}."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("Заявка"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Кто вы, и ссылка,\nкоторая это доказывает"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("Значок"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "Рядом с вашим именем,\nвезде, где оно видно"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("Проверяет\nчеловек"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "Кто-то из команды\nпереходит по ссылкам"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("Подтверждение"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "Заявка {number} у проверяющего"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "Отправлена {date}, категория: {category}. Когда решение будет принято, придёт уведомление."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("Отозвать заявку"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("Заявка отозвана."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось завершить запись: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("До десяти минут."),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("Слушаю…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron нужно разрешение на микрофон для записи. Его можно дать в настройках устройства."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "Не удалось начать запись: {error}"),
    };

final messageLookup = MessageLookup();
