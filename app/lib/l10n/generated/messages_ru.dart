import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
        "A word, phrase or #tag",
      ),
      "about": MessageLookupByLibrary.simpleMessage("About"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Add an answer"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage(
        "Add more languages…",
      ),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage(
        "Agree and continue",
      ),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Already on Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Comments"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
        "Distinct people, not opens",
      ),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Engagement"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Likes"),
      "analytics_no_viewers_yet": MessageLookupByLibrary.simpleMessage(
        "No viewers yet",
      ),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
        "Nobody has opened this post yet.",
      ),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Posted"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Saves"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Viewers"),
      "analytics_viewers_per_day": MessageLookupByLibrary.simpleMessage(
        "VIEWERS PER DAY",
      ),
      "and": MessageLookupByLibrary.simpleMessage("and"),
      "answerNumber": (Object a0) => "Answer ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage(
        "Attach the system log",
      ),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Round trip"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("TOKEN VERIFICATION"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Try again"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Try again"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
        "Starting a broadcast now would put you in a room nobody could",
      ),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Start a community"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("back in."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("back in from this list."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Closing it"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("join first"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("coming soon"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Posting as you"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("post in this community"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage(
        "Just now",
      ),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage(
        "Try again",
      ),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage(
        "Topic 1",
      ),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage(
        "For You",
      ),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("has anything."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("its way to it now."),
      "audit_google_button_not_bbd76526": MessageLookupByLibrary.simpleMessage(
        ", not",
      ),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("am I moving"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage(
        "For You",
      ),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Your tabs"),
      "audit_media_tray_alt_784030d4": MessageLookupByLibrary.simpleMessage(
        "+ ALT",
      ),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Try again"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Symbol (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("VIEWERS PER DAY"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("could not load"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("this post"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("Anything to add? (optional)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("this post"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("From an account"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Log Out"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Your account"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("not now"),
      "audit_skeleton_loading_18e82bcc": MessageLookupByLibrary.simpleMessage(
        "Loading…",
      ),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87": MessageLookupByLibrary.simpleMessage(
        "Posting…",
      ),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage(
        "3h ago",
      ),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Copy story link"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Your Story"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
        "Your account, your posts, and what you tap on so",
      ),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Add a topic"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage(
        "its own.",
      ),
      "authorBlocked": (Object a0) => "${a0} blocked",
      "authorPostsHidden": (Object a0) => "You will not see posts from ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Block"),
      "blockAuthor": (Object a0) => "Block ${a0}?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
        "Build details copied",
      ),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "By continuing you agree to our",
      ),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
        "By continuing you agree to our Terms and Privacy Policy",
      ),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "By signing up you agree to our",
      ),
      "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
      "change": MessageLookupByLibrary.simpleMessage("Изменить"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Change Email"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
        "Check your email to confirm your account.",
      ),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
        "Check whether Kyron is reachable",
      ),
      "clear": MessageLookupByLibrary.simpleMessage("Clear"),
      "close": MessageLookupByLibrary.simpleMessage("Close"),
      "closeCommunity": (Object a0) => "Close ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Close it"),
      "closeThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Close this community",
      ),
      "communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Find one on Discover, or start your own.",
      ),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
        "Drop a hot take (or a warm one)",
      ),
      "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
        "What's rattling around your head?",
      ),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
        "Say something only you can say…",
      ),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
        "This is your signal — send it",
      ),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
        "Type, speak, or think-out-loud",
      ),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Связаться с поддержкой"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
        "Posts do not carry a language yet, so this does not filter your feed today. Your choice is kept for when they do.",
      ),
      "continueAction": MessageLookupByLibrary.simpleMessage("Continue"),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage(
        "Continue with email",
      ),
      "copy": MessageLookupByLibrary.simpleMessage("Copy"),
      "copyReportInstead": MessageLookupByLibrary.simpleMessage(
        "Copy report instead",
      ),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Could not open Google sign-in. ${a0}",
      "couldNotSignOut": (Object a0) => "Could not sign out: ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
        "Could not take that picture.",
      ),
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
      "create": MessageLookupByLibrary.simpleMessage("Create"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
      "createYourAccount": MessageLookupByLibrary.simpleMessage(
        "Create your account",
      ),
      "createYourProfile": MessageLookupByLibrary.simpleMessage(
        "Create your profile",
      ),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Go live"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("Text post"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("Voice post"),
      "delete": MessageLookupByLibrary.simpleMessage("Delete"),
      "deleteThisComment": MessageLookupByLibrary.simpleMessage(
        "Delete this comment?",
      ),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Delete this post?"),
      "describeAttachment": MessageLookupByLibrary.simpleMessage(
        "Describe this attachment",
      ),
      "description": MessageLookupByLibrary.simpleMessage("Description"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID copied to clipboard"),
      "done": MessageLookupByLibrary.simpleMessage("Готово"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
        "Close the composer with something written and you will be offered a draft.",
      ),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} days ago"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} hours ago"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Just now"),
      "draft_minutes_ago": MessageLookupByLibrary.simpleMessage(
        "{minutes} minutes ago",
      ),
      "draft_nothing_empty": MessageLookupByLibrary.simpleMessage(
        "Nothing written yet",
      ),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
        "A poll, with no question yet",
      ),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage(
        "A quote, with nothing written yet",
      ),
      "drafts": MessageLookupByLibrary.simpleMessage("Drafts"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
      "email": MessageLookupByLibrary.simpleMessage("Email"),
      "emailNotifications": MessageLookupByLibrary.simpleMessage(
        "Email notifications",
      ),
      "explore": MessageLookupByLibrary.simpleMessage("Explore"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
        "Face tracking is not available on this device.",
      ),
      "feedTagDetail": (Object a0) =>
          "Nothing has been posted under #${a0} yet.",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("Подписаться на {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Followers"),
      "following": MessageLookupByLibrary.simpleMessage("Following"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Forgot password?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Getting help"),
      "googleContinue": MessageLookupByLibrary.simpleMessage(
        "Continue with Google",
      ),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Sign in with Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google hands the finished sign-in back to Kyron over a link only Android and iOS answer, so on ${a0} the browser would have nowhere to return it to.\\n\\nIf you already have a Kyron account through Google, use Continue with email with that same address and tap Forgot password — it will mail you a link to set one.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
        "Google sign-in needs the phone app",
      ),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Sign up with Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
        "Guides and answers to common questions",
      ),
      "handle": MessageLookupByLibrary.simpleMessage("handle"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("Help & Support"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Help Centre"),
      "home": MessageLookupByLibrary.simpleMessage("Home"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("In one line"),
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
      "interest_add": MessageLookupByLibrary.simpleMessage("Add an interest"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
        "Drag to reorder",
      ),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
        "Five tabs is the most the strip holds. Remove one to add another.",
      ),
      "interest_following": MessageLookupByLibrary.simpleMessage("Following"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("For You"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
        "Hashtags turn up here as people start using them.",
      ),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Trending now"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Videos"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Your tabs"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
        "It disappears for both of you.",
      ),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
        "It will be removed from the thread.",
      ),
      "join": MessageLookupByLibrary.simpleMessage("Join"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Keep editing"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
        "Kyron's words are still being translated, so most screens stay in English for now.",
      ),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Languages"),
      "leave": MessageLookupByLibrary.simpleMessage("Leave"),
      "leaveCommunity": (Object a0) => "Leave ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Let back in"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("1 page open"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Add a clip"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Add a GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Add a hashtag"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Add a photo"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Add a poll"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Add a video"),
      "literaladdAnInterest": MessageLookupByLibrary.simpleMessage(
        "Add an interest",
      ),
      "literaladdLabelAsATab": (Object a0) => "Add ${a0} as a tab",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("App language"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("App version"),
      "literalblockAuthor": (Object a0) => "Block ${a0}",
      "literalblockAuthor2": (Object a0) => "Block ${a0}?",
      "literalblockThisAccount": MessageLookupByLibrary.simpleMessage(
        "Block this account?",
      ),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Cancel reply"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("Check again"),
      "literalchooseFromGallery": MessageLookupByLibrary.simpleMessage(
        "Choose from gallery",
      ),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Clear cache"),
      "literalcloseAllPages": MessageLookupByLibrary.simpleMessage(
        "Close all pages",
      ),
      "literalcloseTabLabel": (Object a0) => "Close ${a0}",
      "literalcloseTheBrowser": MessageLookupByLibrary.simpleMessage(
        "Close the browser",
      ),
      "literalcloseWidgetCommunityName": (Object a0) => "Close ${a0}?",
      "literalcontactSupport": MessageLookupByLibrary.simpleMessage(
        "Contact Support",
      ),
      "literalcontentLanguages": MessageLookupByLibrary.simpleMessage(
        "Content languages",
      ),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Copy link"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
        "Copy link to post",
      ),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Copy post text"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Copy text"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
        "Could not load communities",
      ),
      "literalcouldNotLoadGifs": MessageLookupByLibrary.simpleMessage(
        "Could not load GIFs",
      ),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
        "Could not load notifications",
      ),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
        "Could not load the members",
      ),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
        "Could not load these posts",
      ),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
        "Could not load this conversation",
      ),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
        "Could not load this list",
      ),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
        "Could not load this post",
      ),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
        "Could not load this reply",
      ),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Could not load trending tags",
      ),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
        "Could not load your communities",
      ),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
        "Could not load your messages",
      ),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Could not open this community",
      ),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
        "Could not post that reply.",
      ),
      "literalcouldNotSearch": MessageLookupByLibrary.simpleMessage(
        "Could not search",
      ),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Could not sign out: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} pages open",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Cover photo"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("Data Saver"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("Delete post"),
      "literaldiscoverPeople": MessageLookupByLibrary.simpleMessage(
        "Discover people",
      ),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Do not reply"),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage("Draft saved"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
        "Feedback cannot be sent right now",
      ),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Font Size"),
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
        "GIFs are not set up",
      ),
      "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage(
        "Hand it to another app",
      ),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Hide password"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Hide this post"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
        "Hides it, and tells us to show fewer like it",
      ),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("How to behave"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("Keep typing"),
      "literalkyronDidNotAnswer": MessageLookupByLibrary.simpleMessage(
        "Kyron did not answer",
      ),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} date",
      "literalleaveCommunityName": (Object a0) => "Leave ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, face lens",
      "literallikedPosts": MessageLookupByLibrary.simpleMessage("Liked posts"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("Link copied"),
      "literalmakeAModerator": MessageLookupByLibrary.simpleMessage(
        "Make a moderator",
      ),
      "literalmuteAuthor": (Object a0) => "Mute ${a0}",
      "literalmuteThisThread": MessageLookupByLibrary.simpleMessage(
        "Mute this thread",
      ),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
        "Mute words or tags",
      ),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
        "Muted and blocked accounts",
      ),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
        "Muted. You will not be notified.",
      ),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "No app on this device opens ${a0} links.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
        "No browser on this device took that link.",
      ),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("No DID yet"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("No drafts"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
        "No interests yet",
      ),
      "literalnoLikesYet": MessageLookupByLibrary.simpleMessage("No likes yet"),
      "literalnoMessagesYet": MessageLookupByLibrary.simpleMessage(
        "No messages yet",
      ),
      "literalnoNewFollowers": MessageLookupByLibrary.simpleMessage(
        "No new followers",
      ),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage("No posts yet"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("No replies yet"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("No reposts yet"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
        "No trending tag matches that",
      ),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Nobody found"),
      "literalnobodyHasBeenRemoved": MessageLookupByLibrary.simpleMessage(
        "Nobody has been removed",
      ),
      "literalnobodyHereYet": MessageLookupByLibrary.simpleMessage(
        "Nobody here yet",
      ),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis": MessageLookupByLibrary.simpleMessage(
        "Not interested in this",
      ),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Nothing found"),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
        "Nothing is trending yet",
      ),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
        "Nothing logged yet",
      ),
      "literalnothingMatched": MessageLookupByLibrary.simpleMessage(
        "Nothing matched",
      ),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Nothing muted"),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
        "Nothing to look at yet",
      ),
      "literalnothingUnread": MessageLookupByLibrary.simpleMessage(
        "Nothing unread",
      ),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
        "Only the owner can change this",
      ),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Open reply"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
        "Open the mail from Kyron",
      ),
      "literalpasswordLogin": MessageLookupByLibrary.simpleMessage(
        "Password & Login",
      ),
      "literalpostInCommunityName": (Object a0) => "Post in ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Post in ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
        "Post it with your own words above it",
      ),
      "literalprimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Primary language",
      ),
      "literalpushNotifications": MessageLookupByLibrary.simpleMessage(
        "Push Notifications",
      ),
      "literalreading": MessageLookupByLibrary.simpleMessage("Reading…"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage(
        "Record a voice post",
      ),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Record again"),
      "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage(
        "Remove as moderator",
      ),
      "literalremoveFromCommunity": MessageLookupByLibrary.simpleMessage(
        "Remove from community",
      ),
      "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage(
        "Remove from saved",
      ),
      "literalremoveLabel": (Object a0) => "Remove ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Remove ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Remove ${a0}?",
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage(
        "Remove the poll",
      ),
      "literalremoveThisAnswer": MessageLookupByLibrary.simpleMessage(
        "Remove this answer",
      ),
      "literalremoveThisConversation": MessageLookupByLibrary.simpleMessage(
        "Remove this conversation",
      ),
      "literalremoveThisPoll": MessageLookupByLibrary.simpleMessage(
        "Remove this poll",
      ),
      "literalreportAuthor": (Object a0) => "Report ${a0}",
      "literalreportPost": MessageLookupByLibrary.simpleMessage("Report post"),
      "literalresendCode": MessageLookupByLibrary.simpleMessage("Resend code"),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage("Saved posts"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Say something"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Say something to ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Search failed"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Send again"),
      "literalsendAgainInCooldownS": (Object a0) => "Send again in ${a0}s",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Send Feedback"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Send the link"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Sent. It is report #${a0}.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
        "Set a password and carry on",
      ),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
        "Share the log with support",
      ),
      "literalshareThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Share this community",
      ),
      "literalshareThisPage": MessageLookupByLibrary.simpleMessage(
        "Share this page",
      ),
      "literalshareThisProfile": MessageLookupByLibrary.simpleMessage(
        "Share this profile",
      ),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Share via…"),
      "literalshareWithAQuote": MessageLookupByLibrary.simpleMessage(
        "Share with a quote",
      ),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
        "Show more posts like this",
      ),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Show password"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Show results"),
      "literalstartACommunity": MessageLookupByLibrary.simpleMessage(
        "Start a community",
      ),
      "literalstartRecording": MessageLookupByLibrary.simpleMessage(
        "Start recording",
      ),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Stop loading"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
        "Stop seeing this post and replies to it",
      ),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Stories ribbon, ${a0} items",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Switch camera"),
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("Tag someone"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Take a picture"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
        "Tap the banner or the picture to change it",
      ),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
        "Tap the link inside it",
      ),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
        "Tap to add a photo and a cover",
      ),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
        "That did not go through. Try again.",
      ),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
        "That GIF could not be downloaded.",
      ),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
        "That link is not one this can open.",
      ),
      "literaltheCameraIsClosed": MessageLookupByLibrary.simpleMessage(
        "The camera is closed",
      ),
      "literalthisCommunity": MessageLookupByLibrary.simpleMessage(
        "This community",
      ),
      "literalthisReplyIsGone": MessageLookupByLibrary.simpleMessage(
        "This reply is gone",
      ),
      "literaltranslatePost": MessageLookupByLibrary.simpleMessage(
        "Translate post",
      ),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage(
        "Use one of ours",
      ),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
        "Verification code resent.",
      ),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Verification failed: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Verify Email"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
        "Viewers, likes, saves and comments",
      ),
      "literalwhatKyronKeeps": MessageLookupByLibrary.simpleMessage(
        "What Kyron keeps",
      ),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
        "What this app has been doing",
      ),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
        "What you did, what you expected, what happened ",
      ),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
        "What you post is yours",
      ),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
        "Whether Kyron is reachable right now",
      ),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Who can reply"),
      "literalwhoDoYouWantToTag": MessageLookupByLibrary.simpleMessage(
        "Who do you want to tag?",
      ),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
        "You already follow every trending tag",
      ),
      "literalyouAreAllCaughtUp": MessageLookupByLibrary.simpleMessage(
        "You are all caught up",
      ),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
        "You are not in any communities",
      ),
      "literalyouAreSignedOut": MessageLookupByLibrary.simpleMessage(
        "You are signed out.",
      ),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "You have left ${a0}",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
        "You have not posted yet",
      ),
      "loadMore": MessageLookupByLibrary.simpleMessage("Load more"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Log cleared"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Log copied"),
      "logIn": MessageLookupByLibrary.simpleMessage("Log in"),
      "logOut": MessageLookupByLibrary.simpleMessage("Log Out"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Log Out?"),
      "login": MessageLookupByLibrary.simpleMessage("Login"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
        "Login failed. Please check your credentials.",
      ),
      "manage": MessageLookupByLibrary.simpleMessage("Manage"),
      "menu": MessageLookupByLibrary.simpleMessage("Menu"),
      "message": MessageLookupByLibrary.simpleMessage("Message"),
      "messages": MessageLookupByLibrary.simpleMessage("Messages"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
        "Every conversation is caught up.",
      ),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
        "Open somebody's profile and tap Message to start a conversation.",
      ),
      "mute": MessageLookupByLibrary.simpleMessage("Mute"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Muted and blocked"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
        "Muted words and tags",
      ),
      "name": MessageLookupByLibrary.simpleMessage("Name"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> Screen"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("New email address"),
      "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
      "newPost": MessageLookupByLibrary.simpleMessage("New post"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Not now"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
        "Not sent. Tap to try again",
      ),
      "nothingMatchesQuery": (Object a0) =>
          "Nothing on Kyron matches \"${a0}\"",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("Nothing to copy"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Likes, replies and new followers land here as they arrive.",
      ),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
        "People who follow you show up here.",
      ),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
        "When somebody likes one of your posts, it shows up here.",
      ),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
        "Replies to your posts land here.",
      ),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
        "When somebody reposts you, it shows up here.",
      ),
      "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("Open in browser"),
      "or": MessageLookupByLibrary.simpleMessage("or"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("Page not found"),
      "password": MessageLookupByLibrary.simpleMessage("Password"),
      "passwordTooShort": MessageLookupByLibrary.simpleMessage(
        "Password too short",
      ),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
        "Pick your interests",
      ),
      "post": MessageLookupByLibrary.simpleMessage("Post"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("Post analytics"),
      "postInCommunity": (Object a0) => "Post in ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
        "Post it, say it, show it.",
      ),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Post text copied"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
      "profileUpdated": MessageLookupByLibrary.simpleMessage("Profile updated"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Страна"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Display name"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Location"),
      "profile_tap_to_change": MessageLookupByLibrary.simpleMessage(
        "Tap to change",
      ),
      "profile_website": MessageLookupByLibrary.simpleMessage("Website"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage(
        "Push notifications",
      ),
      "quote": MessageLookupByLibrary.simpleMessage("Quote"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Quote post"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Reach a person"),
      "remove": MessageLookupByLibrary.simpleMessage("Remove"),
      "removeConversation": MessageLookupByLibrary.simpleMessage(
        "Remove this conversation?",
      ),
      "removeMember": (Object a0) => "Remove ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Remove this message?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
        "Replies, follows and mentions",
      ),
      "repliesPolicy": (Object a0) => "Replies: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Reply"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Anyone can interact"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
        "Anyone can still see, repost and quote this post.",
      ),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
        "Anyone on Kyron can reply to this post.",
      ),
      "reply_followers": MessageLookupByLibrary.simpleMessage(
        "People who follow you",
      ),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
        "Only people who follow you can reply to this post.",
      ),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("People you mention"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
        "Only the people you @mention in this post can reply.",
      ),
      "reply_nobody": MessageLookupByLibrary.simpleMessage("Nobody can reply"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
        "Replies are turned off. You can still reply.",
      ),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Who can reply?"),
      "report": MessageLookupByLibrary.simpleMessage("Пожаловаться"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Жалоба отправлена"),
      "repost": MessageLookupByLibrary.simpleMessage("Repost"),
      "reset": MessageLookupByLibrary.simpleMessage("Reset"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Reset your password"),
      "retry": MessageLookupByLibrary.simpleMessage("Retry"),
      "save": MessageLookupByLibrary.simpleMessage("Save"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Save draft"),
      "saySomething": (Object a0) => "Say something to ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Search"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
        "Search by name or handle",
      ),
      "searchCommunities": MessageLookupByLibrary.simpleMessage(
        "Search communities",
      ),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Search GIFs"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("Search languages"),
      "searchTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Search trending tags",
      ),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
        "Security alerts and account changes",
      ),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
        "Select which language to use for the app's user interface.",
      ),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
        "Select which languages you want your subscribed feeds to include. If none are selected, all languages will be shown.",
      ),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Select your preferred language for translations in your feed.",
      ),
      "send": MessageLookupByLibrary.simpleMessage("Send"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Send confirmation"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Send error report"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Send feedback"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Отправить жалобу"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("Send to support"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Service status"),
      "settings": MessageLookupByLibrary.simpleMessage("Settings"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
        "Share the app log with support",
      ),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Sign in to Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Signed in as"),
      "signupFailed": (Object a0) => "Signup failed: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Stay"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
        "Kyron is early, and the fastest way to reach someone who can actually fix a problem is to open an issue. Include what you were doing and what happened instead.",
      ),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
        "There is no in-app support inbox yet, so this screen points at the place that is actually monitored rather than at a form that goes nowhere.",
      ),
      "systemLog": MessageLookupByLibrary.simpleMessage("System log"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
        "Tell us what is missing or broken",
      ),
      "terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
        "Text, voice and video, the people who make them, and the rooms they talk in.",
      ),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
        "The composer has no Post button",
      ),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Dark"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Always dark"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Dim"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
        "A softer dark, blue-grey rather than black",
      ),
      "theme_light": MessageLookupByLibrary.simpleMessage("Light"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Always light"),
      "theme_system": MessageLookupByLibrary.simpleMessage("System"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
        "Follow the phone’s own light or dark setting",
      ),
      "translate": MessageLookupByLibrary.simpleMessage("Translate"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
        "Translation is not built yet. Nothing in your feed is translated today; this is remembered for when it is.",
      ),
      "translation_description": MessageLookupByLibrary.simpleMessage(
        "Kyron's own words are still being translated, so most screens stay in English for now. What this changes today: the parts of the interface Flutter draws itself, dates and numbers, and the direction the app lays out in for right-to-left languages.",
      ),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Попробовать снова"),
      "ui_about_privacy_policy": MessageLookupByLibrary.simpleMessage(
        "Privacy Policy",
      ),
      "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage(
        "Terms of Service",
      ),
      "ui_account": MessageLookupByLibrary.simpleMessage("Account"),
      "ui_after": MessageLookupByLibrary.simpleMessage("After"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("App & Device"),
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
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "Light, dark, or whatever the phone is set to",
      ),
      "ui_before": MessageLookupByLibrary.simpleMessage("Before"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "Neither of you will see the other on Kyron, and any follow between you is removed. They are not told.",
      ),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Carrying"),
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
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Публикации:"),
      "ui_content_display": MessageLookupByLibrary.simpleMessage(
        "Content & Display",
      ),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
        "Could not load your feed",
      ),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
        "Could not load your liked posts",
      ),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
        "Could not load your profile",
      ),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
        "Could not load your saved posts",
      ),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage(
        "Decentralized ID",
      ),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnostics"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Группы"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Нет групп"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Здесь группы, в которых вы состоите, и чаты сообществ, к которым вы присоединяетесь."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Можно закрепить не больше \$count чатов. Сначала открепите один."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Закреплён"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Понравилось"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Сохранённое"),
      "ui_feed_empty": MessageLookupByLibrary.simpleMessage("Nothing here yet"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
        "Follow a few accounts and their posts will show up here.",
      ),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
        "Nothing from the people you follow",
      ),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
        "Posts will show up here as people write them.",
      ),
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
        "Posts carrying a clip will show up here.",
      ),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("No videos yet"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
      "ui_find_people_on_kyron": MessageLookupByLibrary.simpleMessage(
        "Find people on Kyron",
      ),
      "ui_from_account":
          MessageLookupByLibrary.simpleMessage("From an account"),
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
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Выберите язык"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Legal"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Like"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("Liked posts"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Posts you like show up here, most recent first.",
      ),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Link copied"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
        "You will stop seeing their posts. They are not told.",
      ),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage("No likes yet"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
        "No posts match those filters.",
      ),
      "ui_nothing_saved_yet": MessageLookupByLibrary.simpleMessage(
        "Nothing saved yet",
      ),
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
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
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
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pause"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Play"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
        "It is removed from your profile and from everyone else's feed. Replies to it go with it.",
      ),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("Post deleted"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("Post hidden"),
      "ui_post_text_copied": MessageLookupByLibrary.simpleMessage(
        "Post text copied",
      ),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Posted between"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
        "Hidden. We will show you fewer like it.",
      ),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
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
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("Saved posts"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Tap the archive icon on any post to keep it here. Only you can see what you save.",
      ),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
        "Search by handle or display name.",
      ),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Clear"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
        "Search everything posted",
      ),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filters"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Search people"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("Search posts"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Settings"),
      "ui_settings_app_device": MessageLookupByLibrary.simpleMessage(
        "App & Device",
      ),
      "ui_settings_content_display": MessageLookupByLibrary.simpleMessage(
        "Content & Display",
      ),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Data Saver"),
      "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
        "Tell us what you think",
      ),
      "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage(
        "Browse help articles",
      ),
      "ui_settings_language_detail": MessageLookupByLibrary.simpleMessage(
        "Choose your language",
      ),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
        "Who you have muted or blocked",
      ),
      "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
        "Notification preferences",
      ),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
        "Your profile and contact information",
      ),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
        "You will need to sign in again to get back to your account.",
      ),
      "ui_settings_security": MessageLookupByLibrary.simpleMessage(
        "Security settings",
      ),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("In one line"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("New email address"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("New password"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("What happened"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
        "Get help from our team",
      ),
      "ui_share": MessageLookupByLibrary.simpleMessage("Share"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Цитировать"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Отправить в сообщении"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Людям в Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Share this post"),
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
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Повторить"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Two characters or more.",
      ),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Отменить"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
        "Words, or a filter — an account, a date range, or what a post carries.",
      ),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Undo repost"),
      "updatePassword": MessageLookupByLibrary.simpleMessage("Update password"),
      "useDifferentAddress": MessageLookupByLibrary.simpleMessage(
        "Use a different address",
      ),
      "username": MessageLookupByLibrary.simpleMessage("Username"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
        "Username must be lowercase (a-z, 0-9, _)",
      ),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Attach"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Ready to attach"),
      "voice_record_post": MessageLookupByLibrary.simpleMessage(
        "Record a voice post",
      ),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Recording…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Stop"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("What happened"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Что случилось и на что нам обратить внимание?",
      ),
      "whatInPicture": MessageLookupByLibrary.simpleMessage(
        "What is in this picture?",
      ),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage(
        "What is it for? (optional)",
      ),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
        "What you did, what you expected, what happened",
      ),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
        "What you were doing when it happened.",
      ),
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
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
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
    };

final messageLookup = MessageLookup();
