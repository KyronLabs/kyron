import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'bg';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
        "Дума, фраза или #таг",
      ),
      "about": MessageLookupByLibrary.simpleMessage("Относно"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Добави отговор"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Добави още езици…"),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage(
        "Съгласявам се и продължавам",
      ),
      "alreadyOnKyron": MessageLookupByLibrary.simpleMessage("Вече в Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Коментари"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
        "Отделни хора, не отваряния",
      ),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Ангажираност"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Харесвания"),
      "analytics_no_viewers_yet": MessageLookupByLibrary.simpleMessage(
        "Все още няма зрители",
      ),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
        "Никой все още не е отворил тази публикация.",
      ),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Публикувано"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Запазвания"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Зрители"),
      "analytics_viewers_per_day": MessageLookupByLibrary.simpleMessage(
        "ЗРИТЕЛИ НА ДЕН",
      ),
      "and": MessageLookupByLibrary.simpleMessage("и"),
      "answerNumber": (Object a0) => "Отговор ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage(
        "Прикачи системния лог",
      ),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Кръгово пътуване"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ВЕРИФИКАЦИЯ НА ТОКЕН"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Опитай отново"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Опитай отново"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
        "Започването на излъчване сега ще ви сложи в стая, която никой не може",
      ),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Създай общност"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("За какво е? (по избор)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("отново."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("отново от този списък."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Затварянето"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("първо се присъедини"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("скоро"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Публикуване като теб"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("публикувай в тази общност"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage(
        "Току-що",
      ),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage(
        "Опитай отново",
      ),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage(
        "Тема 1",
      ),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage(
        "За теб",
      ),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("има нещо."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("в момента е на път към него."),
      "audit_google_button_not_bbd76526": MessageLookupByLibrary.simpleMessage(
        ", не",
      ),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("премествам ли се"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Изключи звука"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Включи звука"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage(
        "За теб",
      ),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Вашите раздели"),
      "audit_media_tray_alt_784030d4": MessageLookupByLibrary.simpleMessage(
        "+ ALT",
      ),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Опитай отново"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Символ (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("ЗРИТЕЛИ НА ДЕН"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join(\", \")"),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("не можа да зареди"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("този пост"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
        "Искате ли да добавите нещо? (по избор)",
      ),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("този пост"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("От акаунт"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Излез"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Вашият акаунт"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Потвърди паролата"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("не сега"),
      "audit_skeleton_loading_18e82bcc": MessageLookupByLibrary.simpleMessage(
        "Зареждане…",
      ),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87": MessageLookupByLibrary.simpleMessage(
        "Публикуване…",
      ),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage(
        "преди 3 ч.",
      ),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Копирай връзката на историята"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Твоята история"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
        "Вашият акаунт, вашите публикации и това, върху което натискате, така че",
      ),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Добави тема"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage(
        "своя собствена.",
      ),
      "authorBlocked": (Object a0) => "${a0} е блокиран",
      "authorPostsHidden": (Object a0) => "Няма да виждате публикации от ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Блокирай"),
      "blockAuthor": (Object a0) => "Блокирай ${a0}?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
        "Детайлите за билда са копирани",
      ),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "С продължаване се съгласявате с нашите",
      ),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
        "С продължаване се съгласявате с нашите Общи условия и Политика за поверителност",
      ),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "С регистрацията се съгласявате с нашите",
      ),
      "cancel": MessageLookupByLibrary.simpleMessage("Откажи"),
      "change": MessageLookupByLibrary.simpleMessage("Промени"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Смени имейла"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
        "Провери имейла си, за да потвърдиш акаунта си.",
      ),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
        "Провери дали Kyron е достъпен",
      ),
      "clear": MessageLookupByLibrary.simpleMessage("Изчисти"),
      "close": MessageLookupByLibrary.simpleMessage("Затвори"),
      "closeCommunity": (Object a0) => "Затвори ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Затвори го"),
      "closeThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Затвори тази общност",
      ),
      "communities": MessageLookupByLibrary.simpleMessage("Общности"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Намерете такава в Открий или създайте своя.",
      ),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
        "Сподели силно мнение (или по-умерено)",
      ),
      "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
        "Какво се върти в главата ти?",
      ),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
        "Кажи нещо, което само ти можеш да кажеш…",
      ),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
        "Това е твоят сигнал — изпрати го",
      ),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
        "Пиши, говори или мисли на глас",
      ),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Потвърди паролата"),
      "contactSupport": MessageLookupByLibrary.simpleMessage(
        "Свържи се с поддръжката",
      ),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
        "Публикациите все още нямат зададен език, така че това не филтрира вашия фийд за момента. Изборът ви се запазва за когато имат.",
      ),
      "continueAction": MessageLookupByLibrary.simpleMessage("Продължи"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Продължи с имейл"),
      "copy": MessageLookupByLibrary.simpleMessage("Копирай"),
      "copyReportInstead": MessageLookupByLibrary.simpleMessage(
        "Копирай отчета вместо това",
      ),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Не можа да се отвори влизането с Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Не може да излезеш: ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
        "Не можа да се направи тази снимка.",
      ),
      "create": MessageLookupByLibrary.simpleMessage("Създай"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Създай акаунт"),
      "createYourAccount": MessageLookupByLibrary.simpleMessage(
        "Създай своя акаунт",
      ),
      "createYourProfile": MessageLookupByLibrary.simpleMessage(
        "Създай своя профил",
      ),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Излез на живо"),
      "create_text_post": MessageLookupByLibrary.simpleMessage(
        "Текстова публикация",
      ),
      "create_voice_post": MessageLookupByLibrary.simpleMessage(
        "Гласова публикация",
      ),
      "delete": MessageLookupByLibrary.simpleMessage("Изтрий"),
      "deleteThisComment": MessageLookupByLibrary.simpleMessage(
        "Да изтрия този коментар?",
      ),
      "deleteThisPost": MessageLookupByLibrary.simpleMessage(
        "Да изтрия този пост?",
      ),
      "describeAttachment": MessageLookupByLibrary.simpleMessage(
        "Опиши това прикачване",
      ),
      "description": MessageLookupByLibrary.simpleMessage("Описание"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID копирано в клипборда"),
      "done": MessageLookupByLibrary.simpleMessage("Готово"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
        "Затворете редактора с написано нещо и ще ви бъде предложена чернова.",
      ),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("преди {days} дни"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("преди {hours} часа"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Току-що"),
      "draft_minutes_ago": MessageLookupByLibrary.simpleMessage(
        "преди {minutes} минути",
      ),
      "draft_nothing_empty": MessageLookupByLibrary.simpleMessage(
        "Все още няма написано",
      ),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
        "Анкета без зададен въпрос",
      ),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage(
        "Цитат, без нищо написано още",
      ),
      "drafts": MessageLookupByLibrary.simpleMessage("Чернови"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Редактирай профила"),
      "email": MessageLookupByLibrary.simpleMessage("Имейл"),
      "emailNotifications": MessageLookupByLibrary.simpleMessage(
        "Имейл уведомления",
      ),
      "explore": MessageLookupByLibrary.simpleMessage("Разгледай"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
        "Проследяването на лице не е налично на това устройство.",
      ),
      "feedTagDetail": (Object a0) => "Все още няма публикации под #${a0}.",
      "followers": MessageLookupByLibrary.simpleMessage("Последователи"),
      "following": MessageLookupByLibrary.simpleMessage("Следвани"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Забравена парола?"),
      "gettingHelp":
          MessageLookupByLibrary.simpleMessage("Получаване на помощ"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Продължи с Google"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("Влез с Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google предава завършения процес на влизане обратно на Kyron чрез връзка, на която отговарят само Android и iOS, така че на ${a0} браузърът няма къде да я върне.\\n\\nАко вече имате акаунт в Kyron чрез Google, използвайте Продължи с имейл с този същия адрес и натиснете Забравена парола — ще ви бъде изпратен имейл с връзка за задаване на парола.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
        "Влизането с Google изисква мобилното приложение",
      ),
      "googleSignUp": MessageLookupByLibrary.simpleMessage(
        "Регистрирай се с Google",
      ),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
        "Ръководства и отговори на често задавани въпроси",
      ),
      "handle": MessageLookupByLibrary.simpleMessage("никнейм"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Помощ и поддръжка"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Център за помощ"),
      "home": MessageLookupByLibrary.simpleMessage("Начало"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("В един ред"),
      "interest_add": MessageLookupByLibrary.simpleMessage("Добави интерес"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
        "Плъзнете, за да пренаредите",
      ),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
        "Пет раздела е максималното, което носи лентата. Премахнете един, за да добавите друг.",
      ),
      "interest_following": MessageLookupByLibrary.simpleMessage("Следвани"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("За теб"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
        "Хаштаговете се появяват тук, когато хората започнат да ги използват.",
      ),
      "interest_trending_now": MessageLookupByLibrary.simpleMessage(
        "Популярни в момента",
      ),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Видео"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Вашите раздели"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
        "То изчезва и за двамата.",
      ),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
        "То ще бъде премахнато от нишката.",
      ),
      "join": MessageLookupByLibrary.simpleMessage("Присъедини се"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Продължи да редактираш"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
        "Думите на Kyron все още се превеждат, затова повечето екрани остават на английски за момента.",
      ),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Езици"),
      "leave": MessageLookupByLibrary.simpleMessage("Напусни"),
      "leaveCommunity": (Object a0) => "Напусни ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Пусни отново"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage(
        "1 страница отворена",
      ),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Добави клип"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Добави GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Добави хаштаг"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Добави снимка"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Добави анкета"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Добави видео"),
      "literaladdAnInterest": MessageLookupByLibrary.simpleMessage(
        "Добави интерес",
      ),
      "literaladdLabelAsATab": (Object a0) => "Добави ${a0} като раздел",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage(
        "Език на приложението",
      ),
      "literalappVersion": MessageLookupByLibrary.simpleMessage(
        "Версия на приложението",
      ),
      "literalblockAuthor": (Object a0) => "Блокирай ${a0}",
      "literalblockAuthor2": (Object a0) => "Блокираш ли ${a0}?",
      "literalblockThisAccount": MessageLookupByLibrary.simpleMessage(
        "Блокирай този акаунт?",
      ),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Откажи отговора"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Провери отново"),
      "literalchooseFromGallery": MessageLookupByLibrary.simpleMessage(
        "Избери от галерията",
      ),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Изчисти кеша"),
      "literalcloseAllPages": MessageLookupByLibrary.simpleMessage(
        "Затвори всички страници",
      ),
      "literalcloseTabLabel": (Object a0) => "Затвори ${a0}",
      "literalcloseTheBrowser": MessageLookupByLibrary.simpleMessage(
        "Затвори браузъра",
      ),
      "literalcloseWidgetCommunityName": (Object a0) => "Затвори ${a0}?",
      "literalcontactSupport": MessageLookupByLibrary.simpleMessage(
        "Свържи се с поддръжката",
      ),
      "literalcontentLanguages": MessageLookupByLibrary.simpleMessage(
        "Езици на съдържанието",
      ),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("Копирай връзката"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
        "Копирай връзката към публикацията",
      ),
      "literalcopyPostText": MessageLookupByLibrary.simpleMessage(
        "Копирай текста на публикацията",
      ),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Копирай текста"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди общности",
      ),
      "literalcouldNotLoadGifs": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди GIF-ове",
      ),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди известията",
      ),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди членовете",
      ),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди тези публикации",
      ),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
        "Не може да зареди този разговор",
      ),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди този списък",
      ),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди този пост",
      ),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди този отговор",
      ),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди популярните тагове",
      ),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
        "Не може да зареди вашите общности",
      ),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди вашите съобщения",
      ),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Не може да отвори тази общност",
      ),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
        "Не можа да публикувам този отговор.",
      ),
      "literalcouldNotSearch": MessageLookupByLibrary.simpleMessage(
        "Не може да се търси",
      ),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Не може да излезеш: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} страници отворени",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Корица"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Икономия на данни"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage(
        "Изтрий публикацията",
      ),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Открий хора"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Не отговаряй"),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage(
        "Черновата е запазена",
      ),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
        "Обратната връзка не може да бъде изпратена в момента",
      ),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Размер на шрифта"),
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
        "GIF-овете не са настроени",
      ),
      "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage(
        "Предай го на друго приложение",
      ),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Скрий паролата"),
      "literalhideThisPost": MessageLookupByLibrary.simpleMessage(
        "Скрий тази публикация",
      ),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
        "Скрива го и ни казва да показваме по-малко подобни",
      ),
      "literalhowToBehave": MessageLookupByLibrary.simpleMessage(
        "Как да се държиш",
      ),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage(
        "Продължи да пишеш",
      ),
      "literalkyronDidNotAnswer": MessageLookupByLibrary.simpleMessage(
        "Kyron не отговори",
      ),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} дата",
      "literalleaveCommunityName": (Object a0) => "Напусни ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, face lens",
      "literallikedPosts": MessageLookupByLibrary.simpleMessage(
        "Харесани публикации",
      ),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage(
        "Връзката е копирана",
      ),
      "literalmakeAModerator": MessageLookupByLibrary.simpleMessage(
        "Направи модератор",
      ),
      "literalmuteAuthor": (Object a0) => "Заглуши ${a0}",
      "literalmuteThisThread": MessageLookupByLibrary.simpleMessage(
        "Заглуши тази нишка",
      ),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
        "Заглуши думи или тагове",
      ),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
        "Заглушени и блокирани акаунти",
      ),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
        "Заглушено. Няма да получавате известия.",
      ),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Нито едно приложение на това устройство не отваря връзки ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
        "Нито един браузър на това устройство не пое тази връзка.",
      ),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("Все още няма DID"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Няма чернови"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма интереси",
      ),
      "literalnoLikesYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма харесвания",
      ),
      "literalnoMessagesYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма съобщения",
      ),
      "literalnoNewFollowers": MessageLookupByLibrary.simpleMessage(
        "Няма нови последователи",
      ),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма публикации",
      ),
      "literalnoRepliesYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма отговори",
      ),
      "literalnoRepostsYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма препубликации",
      ),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
        "Няма популярен таг, който да съвпада",
      ),
      "literalnobodyFound": MessageLookupByLibrary.simpleMessage(
        "Никой не е намерен",
      ),
      "literalnobodyHasBeenRemoved": MessageLookupByLibrary.simpleMessage(
        "Никой не е бил премахнат",
      ),
      "literalnobodyHereYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма никого тук",
      ),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis": MessageLookupByLibrary.simpleMessage(
        "Не ме интересува това",
      ),
      "literalnothingFound": MessageLookupByLibrary.simpleMessage(
        "Нищо не е намерено",
      ),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма нищо популярно",
      ),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма записана информация",
      ),
      "literalnothingMatched": MessageLookupByLibrary.simpleMessage(
        "Нищо не съвпада",
      ),
      "literalnothingMuted": MessageLookupByLibrary.simpleMessage(
        "Нищо не е заглушено",
      ),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма какво да разглеждате",
      ),
      "literalnothingUnread": MessageLookupByLibrary.simpleMessage(
        "Няма непрочетени",
      ),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
        "Само собственикът може да промени това",
      ),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Отвори отговора"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
        "Отвори писмото от Kyron",
      ),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Парола и вход"),
      "literalpostInCommunityName": (Object a0) => "Публикувай в ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Публикувай в ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
        "Публикувай го с твои думи над него",
      ),
      "literalprimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Основен език",
      ),
      "literalpushNotifications": MessageLookupByLibrary.simpleMessage(
        "Push уведомления",
      ),
      "literalreading": MessageLookupByLibrary.simpleMessage("Четене…"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage(
        "Запиши гласова публикация",
      ),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Запиши отново"),
      "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage(
        "Премахни като модератор",
      ),
      "literalremoveFromCommunity": MessageLookupByLibrary.simpleMessage(
        "Премахни от общността",
      ),
      "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage(
        "Премахни от запазените",
      ),
      "literalremoveLabel": (Object a0) => "Премахни ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Премахни ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Премахни ${a0}?",
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage(
        "Премахни анкетата",
      ),
      "literalremoveThisAnswer": MessageLookupByLibrary.simpleMessage(
        "Премахни този отговор",
      ),
      "literalremoveThisConversation": MessageLookupByLibrary.simpleMessage(
        "Премахни този разговор",
      ),
      "literalremoveThisPoll": MessageLookupByLibrary.simpleMessage(
        "Премахни тази анкета",
      ),
      "literalreportAuthor": (Object a0) => "Докладвай ${a0}",
      "literalreportPost": MessageLookupByLibrary.simpleMessage(
        "Докладвай публикация",
      ),
      "literalresendCode": MessageLookupByLibrary.simpleMessage(
        "Изпрати кода отново",
      ),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage(
        "Запазени публикации",
      ),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("Кажи нещо"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Кажи нещо на ${a0}",
      "literalsearchFailed": MessageLookupByLibrary.simpleMessage(
        "Търсенето се провали",
      ),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("Изпрати отново"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "Изпрати отново след ${a0}s",
      "literalsendFeedback": MessageLookupByLibrary.simpleMessage(
        "Изпрати обратна връзка",
      ),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage(
        "Изпрати връзката",
      ),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Изпратено. Това е доклад №${a0}.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
        "Задай парола и продължи",
      ),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
        "Сподели лога с поддръжката",
      ),
      "literalshareThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Сподели тази общност",
      ),
      "literalshareThisPage": MessageLookupByLibrary.simpleMessage(
        "Сподели тази страница",
      ),
      "literalshareThisProfile": MessageLookupByLibrary.simpleMessage(
        "Сподели този профил",
      ),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Сподели чрез…"),
      "literalshareWithAQuote": MessageLookupByLibrary.simpleMessage(
        "Сподели с цитат",
      ),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
        "Покажи още публикации като тази",
      ),
      "literalshowPassword": MessageLookupByLibrary.simpleMessage(
        "Покажи паролата",
      ),
      "literalshowResults": MessageLookupByLibrary.simpleMessage(
        "Покажи резултатите",
      ),
      "literalstartACommunity": MessageLookupByLibrary.simpleMessage(
        "Създай общност",
      ),
      "literalstartRecording": MessageLookupByLibrary.simpleMessage(
        "Започни запис",
      ),
      "literalstopLoading": MessageLookupByLibrary.simpleMessage(
        "Спри зареждането",
      ),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
        "Престани да виждаш тази публикация и отговорите към нея",
      ),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Лента с истории, ${a0} елемента",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Смени камерата"),
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("Тагни някого"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Направи снимка"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
        "Докоснете банера или снимката, за да ги промените",
      ),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
        "Докосни връзката в него",
      ),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
        "Докосни, за да добавиш снимка и корица",
      ),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
        "Това не мина. Опитай отново.",
      ),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
        "Този GIF не можа да бъде изтеглен.",
      ),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
        "Тази връзка не може да бъде отворена от това приложение.",
      ),
      "literaltheCameraIsClosed": MessageLookupByLibrary.simpleMessage(
        "Камерата е затворена",
      ),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Тази общност"),
      "literalthisReplyIsGone": MessageLookupByLibrary.simpleMessage(
        "Този отговор е премахнат",
      ),
      "literaltranslatePost": MessageLookupByLibrary.simpleMessage(
        "Преведи публикацията",
      ),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Изключи звука"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Включи звука"),
      "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage(
        "Използвай една от нашите",
      ),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
        "Кодът за потвърждение е изпратен отново.",
      ),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Потвърждението не бе успешно: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Потвърди имейл"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
        "Зрители, харесвания, запазвания и коментари",
      ),
      "literalwhatKyronKeeps": MessageLookupByLibrary.simpleMessage(
        "Какво запазва Kyron",
      ),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
        "Какво е правилo това приложение",
      ),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
        "Какво направихте, какво очаквахте, какво се случи ",
      ),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
        "Това, което публикуваш, е твое",
      ),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Дали Kyron е достъпен в момента"),
      "literalwhoCanReply": MessageLookupByLibrary.simpleMessage(
        "Кой може да отговори",
      ),
      "literalwhoDoYouWantToTag": MessageLookupByLibrary.simpleMessage(
        "Кого искаш да тагнеш?",
      ),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
        "Вече следвате всички популярни тагове",
      ),
      "literalyouAreAllCaughtUp": MessageLookupByLibrary.simpleMessage(
        "Всичко е наваксано",
      ),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
        "Не сте член на нито една общност",
      ),
      "literalyouAreSignedOut": MessageLookupByLibrary.simpleMessage(
        "Вие сте излезли.",
      ),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Напуснахте ${a0}",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
        "Все още не сте публикували",
      ),
      "loadMore": MessageLookupByLibrary.simpleMessage("Зареди още"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Логът е изчистен"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Логът е копиран"),
      "logIn": MessageLookupByLibrary.simpleMessage("Влез"),
      "logOut": MessageLookupByLibrary.simpleMessage("Излез"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Да излезеш?"),
      "login": MessageLookupByLibrary.simpleMessage("Вход"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
        "Неуспешен вход. Моля, провери данните си за вход.",
      ),
      "manage": MessageLookupByLibrary.simpleMessage("Управление"),
      "menu": MessageLookupByLibrary.simpleMessage("Меню"),
      "message": MessageLookupByLibrary.simpleMessage("Съобщение"),
      "messages": MessageLookupByLibrary.simpleMessage("Съобщения"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
        "Всички разговори са наваксани.",
      ),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
        "Отворете профила на някого и натиснете Съобщение, за да започнете разговор.",
      ),
      "mute": MessageLookupByLibrary.simpleMessage("Заглуши"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
        "Заглушени и блокирани",
      ),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
        "Заглушени думи и тагове",
      ),
      "name": MessageLookupByLibrary.simpleMessage("Име"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> екран"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Нов имейл адрес"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Нова парола"),
      "newPost": MessageLookupByLibrary.simpleMessage("Нов пост"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Не сега"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
        "Не е изпратено. Докосни, за да опиташ отново",
      ),
      "nothingMatchesQuery": (Object a0) =>
          "Нищо в Kyron не съвпада с \"${a0}\"",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage(
        "Няма какво да се копира",
      ),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Харесванията, отговорите и новите последователи се появяват тук, когато пристигнат.",
      ),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
        "Хората, които ви следват, се появяват тук.",
      ),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
        "Когато някой хареса една от вашите публикации, тя ще се появи тук.",
      ),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
        "Отговорите на вашите публикации се появяват тук.",
      ),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
        "Когато някой ви препубликува, това ще се появи тук.",
      ),
      "notifications": MessageLookupByLibrary.simpleMessage("Известия"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("Отвори в браузър"),
      "or": MessageLookupByLibrary.simpleMessage("или"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage(
        "Страницата не е намерена",
      ),
      "password": MessageLookupByLibrary.simpleMessage("Парола"),
      "passwordTooShort": MessageLookupByLibrary.simpleMessage(
        "Паролата е твърде къса",
      ),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
        "Избери интересите си",
      ),
      "post": MessageLookupByLibrary.simpleMessage("Публикувай"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage(
        "Анализ на публикацията",
      ),
      "postInCommunity": (Object a0) => "Публикувай в ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
        "Публикувай го, кажи го, покажи го.",
      ),
      "postTextCopied": MessageLookupByLibrary.simpleMessage(
        "Текстът на публикацията е копиран",
      ),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage(
        "Политика за поверителност",
      ),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Профилът е обновен"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Биография"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Показвано име"),
      "profile_location":
          MessageLookupByLibrary.simpleMessage("Местоположение"),
      "profile_tap_to_change": MessageLookupByLibrary.simpleMessage(
        "Докосни, за да промениш",
      ),
      "profile_website": MessageLookupByLibrary.simpleMessage("Уебсайт"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push уведомления"),
      "quote": MessageLookupByLibrary.simpleMessage("Цитат"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Цитирай пост"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Свържи се с човек"),
      "remove": MessageLookupByLibrary.simpleMessage("Премахни"),
      "removeConversation": MessageLookupByLibrary.simpleMessage(
        "Да премахна този разговор?",
      ),
      "removeMember": (Object a0) => "Премахни ${a0}?",
      "removeMessage": MessageLookupByLibrary.simpleMessage(
        "Да премахна това съобщение?",
      ),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
        "Отговори, последвания и споменавания",
      ),
      "repliesPolicy": (Object a0) => "Отговори: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Отговори"),
      "reply_anyone": MessageLookupByLibrary.simpleMessage(
        "Всеки може да взаимодейства",
      ),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
        "Всеки все още може да вижда, препубликува и цитира тази публикация.",
      ),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
        "Всеки в Kyron може да отговаря на тази публикация.",
      ),
      "reply_followers": MessageLookupByLibrary.simpleMessage(
        "Хора, които ви следват",
      ),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
        "Само хора, които ви следват, могат да отговарят на тази публикация.",
      ),
      "reply_mentioned": MessageLookupByLibrary.simpleMessage(
        "Хора, които споменавате",
      ),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
        "Само хората, които @споменете в тази публикация, могат да отговорят.",
      ),
      "reply_nobody": MessageLookupByLibrary.simpleMessage(
        "Никой не може да отговори",
      ),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
        "Отговорите са изключени. Вие все още можете да отговорите.",
      ),
      "reply_who_can_reply": MessageLookupByLibrary.simpleMessage(
        "Кой може да отговори?",
      ),
      "report": MessageLookupByLibrary.simpleMessage("Докладвай"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Докладът е копиран. Поставете го в имейл до поддръжката.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Докладът е изпратен"),
      "repost": MessageLookupByLibrary.simpleMessage("Препубликувай"),
      "reset": MessageLookupByLibrary.simpleMessage("Нулирай"),
      "resetPassword": MessageLookupByLibrary.simpleMessage(
        "Възстанови паролата си",
      ),
      "retry": MessageLookupByLibrary.simpleMessage("Опитай отново"),
      "save": MessageLookupByLibrary.simpleMessage("Запази"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Запази черновата"),
      "saySomething": (Object a0) => "Кажи нещо на ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Търсене"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
        "Търси по име или никнейм",
      ),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Търси общности"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Търси GIF-ове"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Търси езици"),
      "searchTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Търси популярни тагове",
      ),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
        "Сигнализации за сигурност и промени в акаунта",
      ),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
        "Изберете кой език да се използва за потребителския интерфейс на приложението.",
      ),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
        "Изберете кои езици искате да включват абонираните ви емисии. Ако не са избрани, ще се показват съдържания на всички езици.",
      ),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Изберете предпочитания език за преводите във вашия фийд.",
      ),
      "send": MessageLookupByLibrary.simpleMessage("Изпрати"),
      "sendConfirmation": MessageLookupByLibrary.simpleMessage(
        "Изпрати потвърждение",
      ),
      "sendErrorReport": MessageLookupByLibrary.simpleMessage(
        "Изпрати отчет за грешка",
      ),
      "sendFeedback": MessageLookupByLibrary.simpleMessage(
        "Изпрати обратна връзка",
      ),
      "sendReport": MessageLookupByLibrary.simpleMessage("Изпрати доклад"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Изпрати до поддръжка"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("Статус на услугата"),
      "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
        "Сподели логовете на приложението с поддръжката",
      ),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Влез в Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Влязъл като"),
      "signupFailed": (Object a0) => "Регистрацията не бе успешна: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Остани"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
        "Kyron е в ранна фаза и най-бързият начин да достигнете до човек, който наистина може да реши проблем, е да отворите сигнал. Включете какво правехте и какво се случи.",
      ),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма входяща кутия за поддръжка в приложението, така че този екран сочи мястото, което действително се наблюдава, вместо към формуляр, който не води никъде.",
      ),
      "systemLog": MessageLookupByLibrary.simpleMessage("Системен лог"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
        "Кажи ни какво липсва или е счупено",
      ),
      "terms": MessageLookupByLibrary.simpleMessage("Условия"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
        "Текст, глас и видео, хората които ги създават и стаите, в които разговарят.",
      ),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
        "Редакторът няма бутон Публикувай",
      ),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Тъмен"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Винаги тъмен"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Мек тъмен"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
        "По-меки тъмни тонове, синьо-сиво вместо черно",
      ),
      "theme_light": MessageLookupByLibrary.simpleMessage("Светъл"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Винаги светъл"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Система"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
        "Следвай собствените настройки за светъл/тъмен режим на телефона",
      ),
      "translate": MessageLookupByLibrary.simpleMessage("Преведи"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
        "Преводът все още не е наличен. Нищо във вашия фийд не е преведено днес; това се запомня за когато бъде.",
      ),
      "translation_description": MessageLookupByLibrary.simpleMessage(
        "Думите на Kyron все още се превеждат, затова за момента повечето екрани остават на английски. Какво променя това днес: частите от интерфейса, които Flutter рисува сам, датите и числата и посоката на оформление за езици отдясно наляво.",
      ),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Опитай отново"),
      "ui_about_privacy_policy": MessageLookupByLibrary.simpleMessage(
        "Политика за поверителност",
      ),
      "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage(
        "Условия за ползване",
      ),
      "ui_account": MessageLookupByLibrary.simpleMessage("Акаунт"),
      "ui_after": MessageLookupByLibrary.simpleMessage("След"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage(
        "Приложение и устройство",
      ),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Външен вид"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "Светъл, тъмен или както е настроен телефонът",
      ),
      "ui_before": MessageLookupByLibrary.simpleMessage("Преди"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "Нито един от вас няма да вижда другия в Kyron и всяко следване между вас ще бъде премахнато. На другия не се съобщава.",
      ),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Съдържа"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("За какво е (по избор)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Само модераторите могат да пишат"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "За обявления. Всички в общността могат да продължат да четат и да реагират."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Добавяне на снимка или анкета"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Снимки и видеоклипове"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Затвори чата"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Никой няма да може да чете или пише в него. Това не може да бъде отменено."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Да се затвори ли този чат?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Копирано"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Съобщението се премахва за всички. Kyron пази копие за преглед."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Съобщението се премахва за всички в чата."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Редактирай чата"),
      "ui_cchat_edit_message":
          MessageLookupByLibrary.simpleMessage("Редактиране"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("редактирано"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Редактирате съобщението си"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Този чат не може да бъде отворен."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Чатове"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Присъедини се към чата"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Присъединете се към общността, за да виждате чатовете ѝ и да участвате."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Присъединили се: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Напусни чата"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Можете да продължите да го четете, докато сте в общността."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Тук могат да пишат само собственикът и модераторите."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Заглушаване"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Без известия от този чат и не се брои в Съобщения."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Име на чата"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Нов чат"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Все още няма чатове."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Все още няма чатове. Отворете един за общността."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Чатовете на общността не са шифровани от край до край. Модераторите на общността и Kyron могат да ги четат."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Закачи най-горе"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Добавяне на отговор"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Затваряне на анкетата"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Затворена"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Всички виждат колко души са избрали всеки отговор, никога кои."),
      "ui_cchat_poll_multiple": MessageLookupByLibrary.simpleMessage(
          "Разрешаване на няколко отговора"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Нова анкета"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Изберете един"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Отговор \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Анкета: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Въпрос"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Всеки отговор може да е в анкетата само веднъж."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Изберете един или повече"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("Отговорили: \$count"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Търсене в този чат"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Търсене в този чат"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Нищо не е намерено."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Вече не можете да виждате този чат."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Бавен режим"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Колко се чака между съобщенията. Не важи за модераторите."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 час"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Минути: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Бавен режим: едно съобщение на всеки \$seconds с"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Изключен"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Секунди: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Като зрител можете да четете и да реагирате. Присъединете се, за да пишете."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Това съобщение е твърде назад, за да бъде показано."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Нещо, което избрахте, е твърде голямо за изпращане и беше пропуснато."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Премахване на заглушаването"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Откачи"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Запис на гласово съобщение"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Вие"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Общности"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("За какво е? (по избор)"),
      "ui_content_display": MessageLookupByLibrary.simpleMessage(
        "Съдържание и показване",
      ),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди вашия фийд",
      ),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди вашите харесани публикации",
      ),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди профила ви",
      ),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди вашите запазени публикации",
      ),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage(
        "Децентрализиран ID",
      ),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Диагностика"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Групи"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Няма групи"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Тук са групите, в които сте, и чатовете на общности, в които се присъедините."),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Харесани"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Запазени"),
      "ui_feed_empty": MessageLookupByLibrary.simpleMessage(
        "Тук все още няма нищо",
      ),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
        "Следвайте няколко акаунта и техните публикации ще се появят тук.",
      ),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
        "Нищо от хората, които следвате",
      ),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
        "Публикациите ще се появяват тук, когато хората ги пишат.",
      ),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
        "Публикации с клип ще се появяват тук.",
      ),
      "ui_feed_videos_empty": MessageLookupByLibrary.simpleMessage(
        "Все още няма видеа",
      ),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Обратна връзка"),
      "ui_find_people_on_kyron": MessageLookupByLibrary.simpleMessage(
        "Намери хора в Kyron",
      ),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("От акаунт"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Добавяне на хора"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Добавяне"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Добавяне на име на групата"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Отхвърляне"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Съобщенията в тази група са шифровани от край до край, като всеки друг разговор."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor добави: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor направи администратор: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor създаде групата"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor зададе новите хора да влизат като членове"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor зададе новите хора да влизат като зрители"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor напусна"),
      "ui_group_event_member":
          MessageLookupByLibrary.simpleMessage("\$actor направи член: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor предаде собствеността на: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor премахна: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor преименува групата на \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor направи зрител: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Групата може да има най-много \$count души."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Ръката е вдигната. Администраторите са уведомени."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Искат да пишат: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Искат да пишат"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Хората, добавени по-късно, влизат като зрители"),
      "ui_group_leave":
          MessageLookupByLibrary.simpleMessage("Напускане на групата"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Тя изчезва от списъка ви и няма да виждате какво се казва след това. Някой ще трябва да ви добави отново."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Да напуснете ли тази група?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Разрешаване на писане"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Сваляне на ръката"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Направи администратор"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Направи собственик"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Направи зрител"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Членове: \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Членове"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Име на групата"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Първо дайте име на групата."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Създаване на групов чат"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Собственикът е един. Ще останете администратор."),
      "ui_group_owner_title": MessageLookupByLibrary.simpleMessage(
          "Да предадете ли собствеността на \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Вдигане на ръка"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Премахване от групата"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Премахване като администратор"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Вече не сте в тази група."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Преименуване"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Администратор"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Член"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("Зрител"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Като зрител тук можете да четете и да реагирате."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Зрителите могат да четат, да реагират и да вдигнат ръка, за да поискат да пишат."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Предложения"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Преглед на профила"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("вие"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Вие сте зрител"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Помощ"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Записано. Това помага да се формира това, което ви се показва.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Присъедини се"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Присъединил се"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Език"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Изберете език"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Правна информация"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Харесай"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Харесани публикации"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Публикациите, които харесвате, се показват тук, най-новите първи.",
      ),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Връзката е копирана"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
        "Ще спрете да виждате техните публикации. Те не са уведомени.",
      ),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage(
        "Все още няма харесвания",
      ),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
        "Нито една публикация не отговаря на тези филтри.",
      ),
      "ui_nothing_saved_yet": MessageLookupByLibrary.simpleMessage(
        "Все още няма запазено",
      ),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Профилът ви е актуализиран"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Обжалването ви по случай \$number е уважено"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Прегледахме отново обжалването ви по случай \$number и решението остава в сила"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Профилът ви е блокиран за постоянно"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Случай \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("ви последва"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("хареса публикацията ви"),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("По-стари"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Съобщението ви в чат на общност е премахнато"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Нещо, което публикувахте, е премахнато"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Публикацията ви е премахната"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Отговорът ви е премахнат"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("отговори на публикацията ви"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Предприехме мерки във връзка с нещо, което докладвахте. Благодарим, че ни уведомихте."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Прегледахме нещо, което докладвахте, и не установихме нарушение на правилата ни."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Докладвано за: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("сподели публикацията ви"),
      "ui_notif_reversed":
          MessageLookupByLibrary.simpleMessage("Отменихме случай \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Профилът ви е временно спрян"),
      "ui_notif_suspended_until":
          MessageLookupByLibrary.simpleMessage("Профилът ви е спрян до \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Всички"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Последователи"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Харесвания"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Отговори"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Тази седмица"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Днес"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Профилът ви получи предупреждение"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Вчера"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Завърши",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Пропусни",
      ),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Това вече е отворено."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Изтекло"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Не може да се отвори."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Отваря се веднъж, след което се изтрива от Kyron."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Еднократен преглед"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Отворено"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "Отворено от \$count от \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Само хората, на които сте го изпратили, могат да го отворят, веднъж."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Изпращане за еднократен преглед"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Докоснете, за да видите"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Пауза"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Пусни"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
        "Тя е премахната от вашия профил и от емисията на всички останали. Отговорите към нея се премахват също.",
      ),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage(
        "Публикацията е изтрита",
      ),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage(
        "Публикацията е скрита",
      ),
      "ui_post_text_copied": MessageLookupByLibrary.simpleMessage(
        "Текстът на публикацията е копиран",
      ),
      "ui_posted_between": MessageLookupByLibrary.simpleMessage(
        "Публикувано между",
      ),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
        "Скрито. Ще ви показваме по-малко подобни.",
      ),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Предпочитания"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Поверителност"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Ще получите известие, когато екипът реши, и можете да следите в раздела Вашите доклади."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Вижте докладите си"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Съобщение в чат на общност"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Публикация"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Отговор"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Предприети мерки"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Профил"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Решено на \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Няма нарушение на правилата"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Докладите ви не могат да се заредят"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Какво сте докладвали през последните 90 дни и какво е станало. Получавате известие, когато екипът реши. Никой, когото докладвате, не разбира кой го е докладвал."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Няма доклади"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Когато докладвате публикация, отговор, съобщение или профил, той се показва тук заедно с резултата."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("В процес на преглед"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Докладвано на \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Какво сте докладвали и какво е станало"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Вашите доклади"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Безопасност на децата"),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Тормоз или преследване"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Реч на омразата"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Незаконни стоки или услуги"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Представяне за друг човек"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Интелектуална собственост"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Невярна информация"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Самоубийство или самонараняване"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Съдържание за възрастни"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Нещо друго"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Спам"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Насилие или заплахи"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Запазени публикации"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Докоснете иконата на архива на всяка публикация, за да я запазите тук. Само вие можете да виждате какво сте запазили.",
      ),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
        "Търси по никнейм или показвано име.",
      ),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Изчисти"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
        "Търси всичко публикувано",
      ),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Филтри"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Търси хора"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Търси публикации"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Настройки"),
      "ui_settings_app_device": MessageLookupByLibrary.simpleMessage(
        "Приложение и устройство",
      ),
      "ui_settings_content_display": MessageLookupByLibrary.simpleMessage(
        "Съдържание и показване",
      ),
      "ui_settings_data_saver": MessageLookupByLibrary.simpleMessage(
        "Икономия на данни",
      ),
      "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
        "Кажете ни какво мислите",
      ),
      "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage(
        "Разгледайте помощни статии",
      ),
      "ui_settings_language_detail": MessageLookupByLibrary.simpleMessage(
        "Избери своя език",
      ),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
        "Кого сте заглушили или блокирали",
      ),
      "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
        "Предпочитания за известия",
      ),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
        "Вашият профил и контактна информация",
      ),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
        "Трябва отново да влезете, за да се върнете в своя акаунт.",
      ),
      "ui_settings_security": MessageLookupByLibrary.simpleMessage(
        "Настройки за сигурност",
      ),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Потвърди паролата"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("В един ред"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Нов имейл адрес"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Нова парола"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Какво се случи"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
        "Получете помощ от нашия екип",
      ),
      "ui_share": MessageLookupByLibrary.simpleMessage("Сподели"),
      "ui_share_this_post": MessageLookupByLibrary.simpleMessage(
        "Сподели тази публикация",
      ),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Условия"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("тази публикация"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage(
        "Нишката е заглушена",
      ),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Опитайте отново"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Изключи звука"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Включи звука"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Две или повече букви.",
      ),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
        "Думи или филтър — акаунт, период от време или какво съдържа публикацията.",
      ),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Отмени препубликуването"),
      "updatePassword": MessageLookupByLibrary.simpleMessage("Обнови паролата"),
      "useDifferentAddress": MessageLookupByLibrary.simpleMessage(
        "Използвай различен адрес",
      ),
      "username": MessageLookupByLibrary.simpleMessage("Потребителско име"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
        "Потребителското име трябва да е с малки букви (a-z, 0-9, _)",
      ),
      "video": MessageLookupByLibrary.simpleMessage("Видео"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Прикачи"),
      "voice_ready_attach": MessageLookupByLibrary.simpleMessage(
        "Готово за прикачване",
      ),
      "voice_record_post": MessageLookupByLibrary.simpleMessage(
        "Запиши гласова публикация",
      ),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Запис…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Спри"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Какво се случи"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Какво се случи и какво да разгледаме?",
      ),
      "whatInPicture": MessageLookupByLibrary.simpleMessage(
        "Какво има на тази снимка?",
      ),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("За какво е? (по избор)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
        "Какво направихте, какво очаквахте, какво се случи",
      ),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
        "Какво правехте когато се случи.",
      ),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("Вие отговорихте"),
      "dmReplied": (Object a0) => "$a0 отговори",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Добавяне към съобщението"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Ново съобщение"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Още нищо не е казано. Едно махване е добро начало."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Махни"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Нови съобщения"),
      "dmTyping": (Object a0) => "$a0 пише",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Премахни реакцията си"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Някой"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Съобщение"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Прикачен файл"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Това съобщение не може да бъде прочетено на това устройство."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Изчакване на това съобщение. Това може да отнеме известно време."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Шифровано съобщение"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Съобщенията са шифровани от край до край"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Не е шифровано от край до край"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Изпратено"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Видяно"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Изпраща се…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Направете снимка"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Още опции"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Запази на устройството"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Сподели"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Запазване…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Запазено в снимките ви"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Не можа да се запази. Опитайте отново."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Разрешете на Kyron да добавя към снимките ви, за да запазите това."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Всички системи работят"),
      "ui_status_uptime":
          MessageLookupByLibrary.simpleMessage("Време на работа"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Последните 60 дни"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Преди 60 дни"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Днес"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("База данни"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Вход"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Скорошни инциденти"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Няма инциденти през последните 60 дни."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("В ход"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Няма данни"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Подробности"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron се проверява на всеки 5 минути, докато работи. Сив ден означава, че не е имало проверки."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Историята на работата още не е налична."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Някои системи имат проблеми"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Запиши гласово съобщение"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Готово за изпращане"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Това съобщение вече го няма."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Към съобщението"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Гласово съобщение"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Харесано от автора"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Добави снимка или клип"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Мултимедия"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Гласови съобщения"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Чат"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Тапет"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Заглуши известията"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Спрете да получавате известия за този разговор"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("Вече не могат да ви пишат"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Без"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Снимка"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Звукът е включен."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Не можа да бъде премахнат. Опитайте отново."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Профил"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Включи звука"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Снимките и клиповете, които споделяте, се показват тук."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("Виж всички"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Снимки и клипове"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Ето как ще изглежда чатът ви."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Изглежда добре."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Мъгла"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Здрач"),
      "ui_wallpaper_sage":
          MessageLookupByLibrary.simpleMessage("Градински чай"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Пясък"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Точки"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Приложи"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("Текущ"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Изпрати без визуализацията"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Търсене"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Публикувай"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Напишете съобщение…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Изпрати"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Изпратено"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Изпратено, но не до всички."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Не можа да се изпрати. Опитайте отново."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Последовател"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Филтър"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Всички"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Непрочетени"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Без отговор"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Скрити"),
      "ui_dm_hidden_none": MessageLookupByLibrary.simpleMessage("Няма скрити"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Разговорите, които премахнете от списъка си, чакат тук, ако решите да ги върнете."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Преместват се в Скрити. Другият човек запазва своя, а разговорът се връща, ако някой от вас пише отново."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Върни"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Отново в списъка ви."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Няма съвпадащи разговори."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Нищо не ви чака"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Всеки разговор завършва с вашата дума."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Снимка"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Снимки"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Видео"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Все още няма съобщения"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Вие:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Вчера"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Съобщения"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Настройки на съобщенията"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Поверителност"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Потвърждения за прочитане"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Когато това е изключено, хората няма да виждат кога сте прочели съобщенията им, а вие няма да виждате кога са прочели вашите."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Показвай, когато пишете"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Човекът, на когото пишете, вижда, че пишете."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Визуализации на връзки"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Телефонът ви отваря връзката, която изпращате, за да направи визуализацията, затова сайтът вижда заявката на телефона ви. Сървърът на Kyron никога не вижда връзката."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Известия за съобщения"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Съобщенията са шифровани от край до край. Kyron не може да ги чете и нищо тук не променя това."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("До:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Скорошни"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Хора"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Няма никой с това име."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Изпрати тестово известие"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Сървърът на Kyron все още не е настроен да изпраща известия, така че никое не може да пристигне. Проблемът е при нас, не в телефона ви."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Този телефон не е регистриран за известия. Проверете дали известията за Kyron са разрешени в настройките на телефона, след което опитайте отново."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Известието не можа да бъде доставено на този телефон. Опитайте отново след минута."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Изпратено. Би трябвало да пристигне след няколко секунди."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Известията работят."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Още няма публикации"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("Нова общност"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Име"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Адресът ѝ се образува от името."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Хората ще я намират на"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Вие ще я притежавате. Снимка, банер и модератори могат да се добавят от страницата ѝ, след като бъде създадена."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Начало"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Публикации от общности в Начало"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Публикациите от вашите общности се появяват и в Начало. Ако е изключено, остават тук, в Общности, където всяка показва какво е ново."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Вашият списък"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Брой нови публикации"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Показване колко публикации са нови във всяка общност, откакто сте я отворили за последно."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Общности, които управлявате"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Тук са изброени общностите, които създавате или модерирате."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Собственик"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Модератор"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Нови публикации"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Управлявани от вас"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Настройки на общностите"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("Откриване"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Няма съвпадащи общности."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Няма нищо ново"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Всяка общност е такава, каквато сте я оставили."),
      "ui_community_running_none": MessageLookupByLibrary.simpleMessage(
          "Все още не управлявате нито една"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "Няма какво повече да присъедините"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Членувате във всяка общност в Kyron. Създайте още една."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Опитайте друга дума или създайте общност с това име."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Напиши публикация"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Членове:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Публикувано"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Виж"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Отвори"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("На линия"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Показвай, когато сте на линия"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Хората, на които пишете, виждат зелена точка, докато Kyron е отворен при вас. Когато това е изключено, няма да виждате и техните."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Търсете хора и публикации"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Общности, към които да се присъедините"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Още няма какво да се види"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Снимките и клиповете, които хората публикуват, ще се появяват тук."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Следвай"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Изтриване на профила"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Това изтрива завинаги профила ви в Kyron. Действието не може да бъде отменено."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Профилът ви, публикациите, отговорите, харесванията и споделянията ви"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Съобщенията ви, включително изпратените до други хора, и снимките и гласовите бележки в тях"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Последователите ви, хората, които следвате, и настройките ви"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Общностите, които сте създали, преминават към най-дълго служилия модератор или член. Общност, в която няма никой друг, се закрива."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Да се изтрие ли профилът ви?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Няма да можете да възстановите нищо от това."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Профилът ви е изтрит."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Изтрит профил"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Този профил е изтрит, така че вече не могат да се изпращат съобщения тук."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Регистрирахте се с Google? Използвайте „Влез с Google“."),
    };

final messageLookup = MessageLookup();
