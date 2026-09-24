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
      "hashtagsEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Хаштагите се появяват тук, когато хората започнат да ги използват.",
      ),
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
      "literalcouldNotLoadSuggestions": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди предложенията",
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
      "literalcouldNotLoadTopics": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди темите",
      ),
      "literalcouldNotLoadTrending": MessageLookupByLibrary.simpleMessage(
        "Не може да зареди популярното",
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
      "literalnoTopicsYet": MessageLookupByLibrary.simpleMessage(
        "Все още няма теми",
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
      "literalnobodyLeftToSuggest": MessageLookupByLibrary.simpleMessage(
        "Няма останали за предложение",
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
      "peopleEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Вече следвате всички, които Kyron би поставил тук.",
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
      "topicsEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Темите се задават от Kyron и в момента няма налични. Върнете се по-късно.",
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
      "ui_help": MessageLookupByLibrary.simpleMessage("Помощ"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Записано. Това помага да се формира това, което ви се показва.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Присъедини се"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Присъединил се"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Език"),
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
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Завърши",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Пропусни",
      ),
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
    };

final messageLookup = MessageLookup();
