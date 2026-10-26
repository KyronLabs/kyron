import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'cs';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
        "Slovo, fráze nebo #tag",
      ),
      "about": MessageLookupByLibrary.simpleMessage("O aplikaci"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Přidat odpověď"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage(
        "Přidat další jazyky…",
      ),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage(
        "Souhlasím a pokračovat",
      ),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Už jste na Kyronu?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Komentáře"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
        "Jedineční lidé, ne otevření",
      ),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("Zapojení"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Lajky"),
      "analytics_no_viewers_yet": MessageLookupByLibrary.simpleMessage(
        "Zatím žádní diváci",
      ),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
        "Nikdo tento příspěvek zatím neotevřel.",
      ),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Zveřejněno"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Uložení"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Diváci"),
      "analytics_viewers_per_day": MessageLookupByLibrary.simpleMessage(
        "DIVÁCI ZA DEN",
      ),
      "and": MessageLookupByLibrary.simpleMessage("a"),
      "answerNumber": (Object a0) => "Odpověď ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage(
        "Připojit systémový log",
      ),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Kola zpět"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("OVĚŘENÍ TOKENU"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Zkusit znovu"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Zkusit znovu"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
        "Startování vysílání teď by vás dostalo do místnosti, kde by nikdo nemohl",
      ),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Založit komunitu"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("K čemu to je? (volitelné)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("zpět."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("zpět z tohoto seznamu."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Je uzavíráno"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("nejprve se připojte"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("brzy k dispozici"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Přidává se jako vy"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("přidat do této komunity"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage(
        "Právě teď",
      ),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage(
        "Zkusit znovu",
      ),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage(
        "Téma 1",
      ),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage(
        "Pro vás",
      ),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("má něco."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("je na cestě."),
      "audit_google_button_not_bbd76526": MessageLookupByLibrary.simpleMessage(
        ", ne",
      ),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("hýbu se"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Vypnout zvuk"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Zapnout zvuk"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage(
        "Pro vás",
      ),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Vaše karty"),
      "audit_media_tray_alt_784030d4": MessageLookupByLibrary.simpleMessage(
        "+ ALT",
      ),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Zkusit znovu"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Symbol (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("DIVÁCI ZA DEN"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("nebylo možné načíst"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("tento příspěvek"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Máte něco k přidání? (volitelné)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("tento příspěvek"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Z účtu"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Odhlásit se"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Váš účet"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Potvrdit heslo"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("teď ne"),
      "audit_skeleton_loading_18e82bcc": MessageLookupByLibrary.simpleMessage(
        "Načítání…",
      ),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87": MessageLookupByLibrary.simpleMessage(
        "Odesílání…",
      ),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage(
        "před 3 h",
      ),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Kopírovat odkaz na příběh"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Váš příběh"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
        "Váš účet, vaše příspěvky a co klepnete, takže",
      ),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Přidat téma"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage(
        "své vlastní.",
      ),
      "authorBlocked": (Object a0) => "${a0} zablokován",
      "authorPostsHidden": (Object a0) => "Nebudete vidět příspěvky od ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Zablokovat"),
      "blockAuthor": (Object a0) => "Zablokovat ${a0}?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
        "Detaily sestavení zkopírovány",
      ),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "Pokračováním souhlasíte s našimi",
      ),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
        "Pokračováním souhlasíte s našimi Podmínkami a Zásadami ochrany osobních údajů",
      ),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "Registrací souhlasíte s našimi",
      ),
      "cancel": MessageLookupByLibrary.simpleMessage("Zrušit"),
      "change": MessageLookupByLibrary.simpleMessage("Změnit"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Změnit e-mail"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
        "Zkontrolujte svou e-mailovou schránku a potvrďte účet.",
      ),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
        "Zkontrolovat, zda je Kyron dostupný",
      ),
      "clear": MessageLookupByLibrary.simpleMessage("Vymazat"),
      "close": MessageLookupByLibrary.simpleMessage("Zavřít"),
      "closeCommunity": (Object a0) => "Uzavřít ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Uzavřít"),
      "closeThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Uzavřít tuto komunitu",
      ),
      "communities": MessageLookupByLibrary.simpleMessage("Komunity"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Najděte jednu v Objevování nebo založte vlastní.",
      ),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
        "Přidejte ostrý názor (nebo teplý)",
      ),
      "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
        "Co vám běhá hlavou?",
      ),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
        "Řekněte něco, co můžete říct jen vy…",
      ),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
        "Tohle je váš signál — pošlete ho",
      ),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
        "Pište, mluvte, nebo přemýšlejte nahlas",
      ),
      "confirmPassword": MessageLookupByLibrary.simpleMessage("Potvrďte heslo"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Kontaktovat podporu"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
        "Příspěvky ještě nemají přiřazen jazyk, takže to dnes nefiltruje váš feed. Vaše volba se uloží pro dobu, kdy budou.",
      ),
      "continueAction": MessageLookupByLibrary.simpleMessage("Pokračovat"),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage(
        "Pokračovat e-mailem",
      ),
      "copy": MessageLookupByLibrary.simpleMessage("Kopírovat"),
      "copyReportInstead": MessageLookupByLibrary.simpleMessage(
        "Místo toho zkopírovat zprávu",
      ),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Nepodařilo se otevřít přihlášení přes Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Nepodařilo se odhlásit: ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se pořídit tento snímek.",
      ),
      "create": MessageLookupByLibrary.simpleMessage("Vytvořit"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Vytvořit účet"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Vytvořte si účet"),
      "createYourProfile": MessageLookupByLibrary.simpleMessage(
        "Vytvořte si profil",
      ),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Vysílat živě"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Textový příspěvek"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage(
        "Hlasový příspěvek",
      ),
      "delete": MessageLookupByLibrary.simpleMessage("Smazat"),
      "deleteThisComment": MessageLookupByLibrary.simpleMessage(
        "Smazat tento komentář?",
      ),
      "deleteThisPost": MessageLookupByLibrary.simpleMessage(
        "Smazat tento příspěvek?",
      ),
      "describeAttachment": MessageLookupByLibrary.simpleMessage(
        "Popište tuto přílohu",
      ),
      "description": MessageLookupByLibrary.simpleMessage("Popis"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
        "DID zkopírován do schránky",
      ),
      "done": MessageLookupByLibrary.simpleMessage("Hotovo"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
        "Zavřete editor s něčím napsaným a nabídneme vám koncept.",
      ),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} dní zpět"),
      "draft_hours_ago": MessageLookupByLibrary.simpleMessage(
        "{hours} hodin(y) zpět",
      ),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Právě teď"),
      "draft_minutes_ago": MessageLookupByLibrary.simpleMessage(
        "{minutes} minut(y) zpět",
      ),
      "draft_nothing_empty": MessageLookupByLibrary.simpleMessage(
        "Zatím nic nenapsáno",
      ),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
        "Anketa, bez otázky",
      ),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage(
        "Citace, bez textu",
      ),
      "drafts": MessageLookupByLibrary.simpleMessage("Koncepty"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Upravit profil"),
      "email": MessageLookupByLibrary.simpleMessage("E-mail"),
      "emailNotifications": MessageLookupByLibrary.simpleMessage(
        "E-mailová oznámení",
      ),
      "explore": MessageLookupByLibrary.simpleMessage("Prozkoumat"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
        "Sledování tváře na tomto zařízení není dostupné.",
      ),
      "feedTagDetail": (Object a0) => "Pod #${a0} zatím nebylo nic zveřejněno.",
      "followers": MessageLookupByLibrary.simpleMessage("Sledující"),
      "following": MessageLookupByLibrary.simpleMessage("Sleduje"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage(
        "Zapomněli jste heslo?",
      ),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Získání pomoci"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Pokračovat s Google"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage(
        "Přihlásit se přes Google",
      ),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google předá dokončené přihlášení Kyronu přes odkaz, na který dokážou odpovědět pouze Android a iOS, takže na ${a0} by v prohlížeči nebylo kam se vrátit.\\n\\nPokud už máte účet Kyron přes Google, použijte Pokračovat e-mailem s tou samou adresou a klepněte na Zapomněli jste heslo — pošleme vám odkaz pro jeho nastavení.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
        "Přihlášení přes Google vyžaduje mobilní aplikaci",
      ),
      "googleSignUp": MessageLookupByLibrary.simpleMessage(
        "Registrovat se přes Google",
      ),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
        "Průvodci a odpovědi na časté otázky",
      ),
      "handle": MessageLookupByLibrary.simpleMessage("uživatelské jméno"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Nápověda a podpora"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Centrum nápovědy"),
      "home": MessageLookupByLibrary.simpleMessage("Domů"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("V jedné větě"),
      "interest_add": MessageLookupByLibrary.simpleMessage("Přidat zájem"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
        "Táhněte pro přeuspořádání",
      ),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
        "Pět karet je maximum. Odeberte jednu pro přidání další.",
      ),
      "interest_following": MessageLookupByLibrary.simpleMessage("Sleduji"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Pro vás"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
        "Hashtagy se tu objeví, jak je lidé začnou používat.",
      ),
      "interest_trending_now": MessageLookupByLibrary.simpleMessage(
        "Právě teď v trendech",
      ),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Videa"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Vaše karty"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
        "Zmizí to pro vás oba.",
      ),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
        "Bude to odstraněno ze série příspěvků.",
      ),
      "join": MessageLookupByLibrary.simpleMessage("Připojit se"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Pokračovat v úpravách"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
        "Kyronovy texty se stále překládají, takže většina obrazovek zatím zůstává v angličtině.",
      ),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Jazyky"),
      "leave": MessageLookupByLibrary.simpleMessage("Opustit"),
      "leaveCommunity": (Object a0) => "Opustit ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Pustit zpět"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage(
        "1 stránka otevřená",
      ),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Přidat klip"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Přidat GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Přidat hashtag"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Přidat fotku"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Přidat anketu"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Přidat video"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Přidat zájem"),
      "literaladdLabelAsATab": (Object a0) => "Přidat ${a0} jako kartu",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Jazyk aplikace"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Verze aplikace"),
      "literalblockAuthor": (Object a0) => "Zablokovat ${a0}",
      "literalblockAuthor2": (Object a0) => "Zablokovat ${a0}?",
      "literalblockThisAccount": MessageLookupByLibrary.simpleMessage(
        "Zablokovat tento účet?",
      ),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Zrušit odpověď"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage(
        "Zkontrolovat znovu",
      ),
      "literalchooseFromGallery": MessageLookupByLibrary.simpleMessage(
        "Vybrat z galerie",
      ),
      "literalclearCache": MessageLookupByLibrary.simpleMessage(
        "Vymazat mezipaměť",
      ),
      "literalcloseAllPages": MessageLookupByLibrary.simpleMessage(
        "Zavřít všechny stránky",
      ),
      "literalcloseTabLabel": (Object a0) => "Zavřít ${a0}",
      "literalcloseTheBrowser": MessageLookupByLibrary.simpleMessage(
        "Zavřít prohlížeč",
      ),
      "literalcloseWidgetCommunityName": (Object a0) => "Uzavřít ${a0}?",
      "literalcontactSupport": MessageLookupByLibrary.simpleMessage(
        "Kontaktovat podporu",
      ),
      "literalcontentLanguages": MessageLookupByLibrary.simpleMessage(
        "Jazyky obsahu",
      ),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("Zkopírovat odkaz"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
        "Kopírovat odkaz na příspěvek",
      ),
      "literalcopyPostText": MessageLookupByLibrary.simpleMessage(
        "Kopírovat text příspěvku",
      ),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Kopírovat text"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst komunity",
      ),
      "literalcouldNotLoadGifs": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst GIFy",
      ),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst oznámení",
      ),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst členy",
      ),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst tyto příspěvky",
      ),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst tento rozhovor",
      ),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst tento seznam",
      ),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst tento příspěvek",
      ),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst tuto odpověď",
      ),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst populární tagy",
      ),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst vaše komunity",
      ),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst vaše zprávy",
      ),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se otevřít tuto komunitu",
      ),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se odeslat tuto odpověď.",
      ),
      "literalcouldNotSearch": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se vyhledat",
      ),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Nepodařilo se odhlásit: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} stránek otevřených",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Obálková fotka"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("Úspora dat"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Smazat příspěvek"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Objevte lidi"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("Neodpovídejte"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Koncept uložen"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
        "Zpětnou vazbu nelze právě nyní odeslat",
      ),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Velikost písma"),
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
        "GIFy nejsou nastaveny",
      ),
      "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage(
        "Předat jiné aplikaci",
      ),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Skrýt heslo"),
      "literalhideThisPost": MessageLookupByLibrary.simpleMessage(
        "Skrýt tento příspěvek",
      ),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
        "Skrývá to a říká nám, abychom ukazovali méně podobných",
      ),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Jak se chovat"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage(
        "Pokračujte v psaní",
      ),
      "literalkyronDidNotAnswer": MessageLookupByLibrary.simpleMessage(
        "Kyron neodpověděl",
      ),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} datum",
      "literalleaveCommunityName": (Object a0) => "Opustit ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, face lens",
      "literallikedPosts": MessageLookupByLibrary.simpleMessage(
        "Oblíbené příspěvky",
      ),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Odkaz zkopírován"),
      "literalmakeAModerator": MessageLookupByLibrary.simpleMessage(
        "Jmenovat moderátora",
      ),
      "literalmuteAuthor": (Object a0) => "Ztlumit ${a0}",
      "literalmuteThisThread": MessageLookupByLibrary.simpleMessage(
        "Ztlumit tuto diskusi",
      ),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
        "Ztlumit slova nebo tagy",
      ),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
        "Ztlumené a zablokované účty",
      ),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
        "Ztlumeno. Nebudete upozorněni.",
      ),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Žádná aplikace na tomto zařízení neotevírá odkazy ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
        "Žádná aplikace na tomto zařízení nepřevzala tento odkaz.",
      ),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("Ještě žádné DID"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Žádné koncepty"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
        "Zatím žádné zájmy",
      ),
      "literalnoLikesYet": MessageLookupByLibrary.simpleMessage(
        "Zatím žádná lajkování",
      ),
      "literalnoMessagesYet": MessageLookupByLibrary.simpleMessage(
        "Zatím žádné zprávy",
      ),
      "literalnoNewFollowers": MessageLookupByLibrary.simpleMessage(
        "Žádní noví sledující",
      ),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage(
        "Zatím žádné příspěvky",
      ),
      "literalnoRepliesYet": MessageLookupByLibrary.simpleMessage(
        "Zatím žádné odpovědi",
      ),
      "literalnoRepostsYet": MessageLookupByLibrary.simpleMessage(
        "Zatím žádná sdílení",
      ),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
        "Žádný populární tag neodpovídá",
      ),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Nic nenalezeno"),
      "literalnobodyHasBeenRemoved": MessageLookupByLibrary.simpleMessage(
        "Nikdo nebyl odstraněn",
      ),
      "literalnobodyHereYet": MessageLookupByLibrary.simpleMessage(
        "Zatím tu nikdo není",
      ),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis": MessageLookupByLibrary.simpleMessage(
        "Nezajímá mě to",
      ),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Nic nenalezeno"),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
        "Zatím nic není v trendech",
      ),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
        "Zatím nic nezaznamenáno",
      ),
      "literalnothingMatched": MessageLookupByLibrary.simpleMessage(
        "Nic neodpovídá",
      ),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Žádné ztlumené"),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
        "Zatím není co prohlížet",
      ),
      "literalnothingUnread": MessageLookupByLibrary.simpleMessage(
        "Žádné nepřečtené",
      ),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
        "Pouze vlastník to může změnit",
      ),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Otevřít odpověď"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
        "Otevřete e-mail od Kyron",
      ),
      "literalpasswordLogin": MessageLookupByLibrary.simpleMessage(
        "Heslo a přihlášení",
      ),
      "literalpostInCommunityName": (Object a0) => "Přidat do ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Přidat do ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
        "Přidat to s vlastním komentářem nahoře",
      ),
      "literalprimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Primární jazyk",
      ),
      "literalpushNotifications": MessageLookupByLibrary.simpleMessage(
        "Push oznámení",
      ),
      "literalreading": MessageLookupByLibrary.simpleMessage("Čtení…"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage(
        "Nahrát hlasový příspěvek",
      ),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Nahrát znovu"),
      "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage(
        "Odebrat moderátora",
      ),
      "literalremoveFromCommunity": MessageLookupByLibrary.simpleMessage(
        "Odstranit z komunity",
      ),
      "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage(
        "Odebrat ze uložených",
      ),
      "literalremoveLabel": (Object a0) => "Odebrat ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Odebrat ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Odstranit ${a0}?",
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage(
        "Odstranit anketu",
      ),
      "literalremoveThisAnswer": MessageLookupByLibrary.simpleMessage(
        "Odstranit tuto odpověď",
      ),
      "literalremoveThisConversation": MessageLookupByLibrary.simpleMessage(
        "Odstranit tento rozhovor",
      ),
      "literalremoveThisPoll": MessageLookupByLibrary.simpleMessage(
        "Odstranit tuto anketu",
      ),
      "literalreportAuthor": (Object a0) => "Nahlásit ${a0}",
      "literalreportPost": MessageLookupByLibrary.simpleMessage(
        "Nahlásit příspěvek",
      ),
      "literalresendCode": MessageLookupByLibrary.simpleMessage(
        "Znovu odeslat kód",
      ),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage(
        "Uložené příspěvky",
      ),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Napište něco"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Napište něco do ${a0}",
      "literalsearchFailed": MessageLookupByLibrary.simpleMessage(
        "Hledání selhalo",
      ),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Odeslat znovu"),
      "literalsendAgainInCooldownS": (Object a0) => "Odeslat znovu za ${a0}s",
      "literalsendFeedback": MessageLookupByLibrary.simpleMessage(
        "Odeslat zpětnou vazbu",
      ),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Odeslat odkaz"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Odesláno. Je to hlášení #${a0}.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
        "Nastavte heslo a pokračujte",
      ),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
        "Sdílet záznam s podporou",
      ),
      "literalshareThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Sdílet tuto komunitu",
      ),
      "literalshareThisPage": MessageLookupByLibrary.simpleMessage(
        "Sdílet tuto stránku",
      ),
      "literalshareThisProfile": MessageLookupByLibrary.simpleMessage(
        "Sdílet tento profil",
      ),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Sdílet přes…"),
      "literalshareWithAQuote": MessageLookupByLibrary.simpleMessage(
        "Sdílet s citací",
      ),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
        "Ukázat více podobných příspěvků",
      ),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Zobrazit heslo"),
      "literalshowResults": MessageLookupByLibrary.simpleMessage(
        "Zobrazit výsledky",
      ),
      "literalstartACommunity": MessageLookupByLibrary.simpleMessage(
        "Založit komunitu",
      ),
      "literalstartRecording": MessageLookupByLibrary.simpleMessage(
        "Začít nahrávat",
      ),
      "literalstopLoading": MessageLookupByLibrary.simpleMessage(
        "Zastavit načítání",
      ),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
        "Přestat vidět tento příspěvek a jeho odpovědi",
      ),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Stuha příběhů, ${a0} položek",
      "literalswitchCamera": MessageLookupByLibrary.simpleMessage(
        "Přepnout fotoaparát",
      ),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Označit někoho"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Pořídit snímek"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
        "Klepněte na banner nebo obrázek pro změnu",
      ),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
        "Klepněte na odkaz v něm",
      ),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
        "Klepněte pro přidání fotky a obálky",
      ),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
        "To neprošlo. Zkuste to znovu.",
      ),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
        "Tento GIF se nepodařilo stáhnout.",
      ),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
        "Ten odkaz toto zařízení neumí otevřít.",
      ),
      "literaltheCameraIsClosed": MessageLookupByLibrary.simpleMessage(
        "Fotoaparát je vypnutý",
      ),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Tato komunita"),
      "literalthisReplyIsGone": MessageLookupByLibrary.simpleMessage(
        "Tato odpověď zmizela",
      ),
      "literaltranslatePost": MessageLookupByLibrary.simpleMessage(
        "Přeložit příspěvek",
      ),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Zvuk vypnout"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Zvuk zapnout"),
      "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage(
        "Použít jednu z našich",
      ),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
        "Ověřovací kód znovu odeslán.",
      ),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Ověření selhalo: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Ověřit e-mail"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
        "Sledující, lajky, uložené a komentáře",
      ),
      "literalwhatKyronKeeps": MessageLookupByLibrary.simpleMessage(
        "Co Kyron uchovává",
      ),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
        "Co tato aplikace dělala",
      ),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
        "Co jste udělali, co jste očekávali, co se stalo ",
      ),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
        "Co zveřejníte, patří vám",
      ),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Zda je Kyron právě dostupný"),
      "literalwhoCanReply": MessageLookupByLibrary.simpleMessage(
        "Kdo může odpovědět",
      ),
      "literalwhoDoYouWantToTag": MessageLookupByLibrary.simpleMessage(
        "Koho chcete označit?",
      ),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
        "Už sledujete všechny populární tagy",
      ),
      "literalyouAreAllCaughtUp": MessageLookupByLibrary.simpleMessage(
        "Vše máte dohnané",
      ),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
        "Nejste v žádné komunitě",
      ),
      "literalyouAreSignedOut": MessageLookupByLibrary.simpleMessage(
        "Jste odhlášeni.",
      ),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Opustili jste ${a0}",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
        "Ještě jste nic nezveřejnili",
      ),
      "loadMore": MessageLookupByLibrary.simpleMessage("Načíst další"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Záznam vymazán"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Záznam zkopírován"),
      "logIn": MessageLookupByLibrary.simpleMessage("Přihlásit se"),
      "logOut": MessageLookupByLibrary.simpleMessage("Odhlásit se"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Odhlásit se?"),
      "login": MessageLookupByLibrary.simpleMessage("Přihlášení"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
        "Přihlášení selhalo. Zkontrolujte prosím své přihlašovací údaje.",
      ),
      "manage": MessageLookupByLibrary.simpleMessage("Spravovat"),
      "menu": MessageLookupByLibrary.simpleMessage("Menu"),
      "message": MessageLookupByLibrary.simpleMessage("Zpráva"),
      "messages": MessageLookupByLibrary.simpleMessage("Zprávy"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
        "Každý rozhovor je aktuální.",
      ),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
        "Otevřete profil někoho a klepněte na Zpráva pro zahájení konverzace.",
      ),
      "mute": MessageLookupByLibrary.simpleMessage("Ztlumit"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
        "Ztlumeno a zablokováno",
      ),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
        "Ztlumená slova a tagy",
      ),
      "name": MessageLookupByLibrary.simpleMessage("Jméno"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> Obrazovka"),
      "newEmailAddress": MessageLookupByLibrary.simpleMessage(
        "Nová e-mailová adresa",
      ),
      "newPassword": MessageLookupByLibrary.simpleMessage("Nové heslo"),
      "newPost": MessageLookupByLibrary.simpleMessage("Nový příspěvek"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Ne teď"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
        "Odeslání selhalo. Klepněte pro opakování",
      ),
      "nothingMatchesQuery": (Object a0) =>
          "Na Kyronu nic neodpovídá \"${a0}\"",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Není co kopírovat"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Lajky, odpovědi a noví sledující se tu objeví, jak přijdou.",
      ),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
        "Lidé, kteří vás sledují, se zde ukážou.",
      ),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
        "Když někdo označí váš příspěvek jako líbí se, objeví se to zde.",
      ),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
        "Odpovědi na vaše příspěvky se objeví zde.",
      ),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
        "Když vás někdo sdílí, objeví se to zde.",
      ),
      "notifications": MessageLookupByLibrary.simpleMessage("Oznámení"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Otevřít v prohlížeči"),
      "or": MessageLookupByLibrary.simpleMessage("nebo"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Stránka nenalezena"),
      "password": MessageLookupByLibrary.simpleMessage("Heslo"),
      "passwordTooShort": MessageLookupByLibrary.simpleMessage(
        "Heslo je příliš krátké",
      ),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
        "Vyberte své zájmy",
      ),
      "post": MessageLookupByLibrary.simpleMessage("Přidat"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Analytika příspěvku"),
      "postInCommunity": (Object a0) => "Přidat do ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
        "Napište to, řekněte to, ukažte to.",
      ),
      "postTextCopied": MessageLookupByLibrary.simpleMessage(
        "Text příspěvku zkopírován",
      ),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage(
        "Zásadami ochrany osobních údajů",
      ),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profil aktualizován"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_display_name": MessageLookupByLibrary.simpleMessage(
        "Zobrazované jméno",
      ),
      "profile_location": MessageLookupByLibrary.simpleMessage("Lokalita"),
      "profile_tap_to_change": MessageLookupByLibrary.simpleMessage(
        "Klepněte pro změnu",
      ),
      "profile_website": MessageLookupByLibrary.simpleMessage("Webová stránka"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push oznámení"),
      "quote": MessageLookupByLibrary.simpleMessage("Citovat"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Citovat příspěvek"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Dostat se ke člověku"),
      "remove": MessageLookupByLibrary.simpleMessage("Odstranit"),
      "removeConversation": MessageLookupByLibrary.simpleMessage(
        "Odstranit tento rozhovor?",
      ),
      "removeMember": (Object a0) => "Odstranit ${a0}?",
      "removeMessage": MessageLookupByLibrary.simpleMessage(
        "Odstranit tuto zprávu?",
      ),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
        "Odpovědi, sledování a zmínky",
      ),
      "repliesPolicy": (Object a0) => "Odpovědi: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Odpovědět"),
      "reply_anyone": MessageLookupByLibrary.simpleMessage(
        "Kdokoliv může interagovat",
      ),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
        "Kdokoliv to může vidět, sdílet a citovat.",
      ),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
        "Kdokoli na Kyronu může odpovědět na tento příspěvek.",
      ),
      "reply_followers": MessageLookupByLibrary.simpleMessage(
        "Lidé, kteří vás sledují",
      ),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
        "Pouze lidé, kteří vás sledují, mohou odpovědět na tento příspěvek.",
      ),
      "reply_mentioned": MessageLookupByLibrary.simpleMessage(
        "Lidé, které zmíníte",
      ),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
        "Pouze lidé, které v tomto příspěvku @zmíníte, mohou odpovědět.",
      ),
      "reply_nobody": MessageLookupByLibrary.simpleMessage(
        "Nikdo nemůže odpovědět",
      ),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
        "Odpovědi jsou vypnuté. Vy stále můžete odpovědět.",
      ),
      "reply_who_can_reply": MessageLookupByLibrary.simpleMessage(
        "Kdo může odpovědět?",
      ),
      "report": MessageLookupByLibrary.simpleMessage("Nahlásit"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Zpráva zkopírována. Vložte ji do e-mailu podpoře.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Zpráva odeslána"),
      "repost": MessageLookupByLibrary.simpleMessage("Sdílet znovu"),
      "reset": MessageLookupByLibrary.simpleMessage("Resetovat"),
      "resetPassword": MessageLookupByLibrary.simpleMessage("Resetovat heslo"),
      "retry": MessageLookupByLibrary.simpleMessage("Opakovat"),
      "save": MessageLookupByLibrary.simpleMessage("Uložit"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Uložit koncept"),
      "saySomething": (Object a0) => "Napište něco do ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Hledat"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
        "Vyhledat podle jména nebo uživatelského jména",
      ),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Hledat komunity"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Vyhledat GIFy"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Hledat jazyky"),
      "searchTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Vyhledat aktuálně populární tagy",
      ),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
        "Bezpečnostní upozornění a změny účtu",
      ),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
        "Vyberte jazyk, který se má použít v uživatelském rozhraní aplikace.",
      ),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
        "Vyberte jazyky, které chcete, aby vaše odběry obsahovaly. Pokud žádné nevyberete, budou zobrazeny všechny jazyky.",
      ),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Vyberte preferovaný jazyk pro překlady ve svém feedu.",
      ),
      "send": MessageLookupByLibrary.simpleMessage("Odeslat"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Odeslat potvrzení"),
      "sendErrorReport": MessageLookupByLibrary.simpleMessage(
        "Odeslat hlášení o chybě",
      ),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("Odeslat zpětnou vazbu"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Odeslat zprávu"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("Odeslat podpoře"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Stav služby"),
      "settings": MessageLookupByLibrary.simpleMessage("Nastavení"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
        "Sdílet log aplikace s podporou",
      ),
      "signInToKyron": MessageLookupByLibrary.simpleMessage(
        "Přihlásit se do Kyron",
      ),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Přihlášeno jako"),
      "signupFailed": (Object a0) => "Registrace selhala: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Zůstat"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
        "Kyron je v rané fázi a nejrychlejší cesta, jak dostat někoho, kdo může problém opravit, je otevřít hlášení. Včetně toho, co jste dělali a co se stalo místo toho.",
      ),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
        "Zatím neexistuje interní podpora v aplikaci, takže tato obrazovka ukazuje na místo, které je skutečně monitorované, místo na formulář, který nic neudělá.",
      ),
      "systemLog": MessageLookupByLibrary.simpleMessage("Systémový log"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
        "Řekněte nám, co chybí nebo nefunguje",
      ),
      "terms": MessageLookupByLibrary.simpleMessage("Podmínkami"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
        "Text, hlas a video, lidé, kteří je vytvářejí, a místnosti, ve kterých spolu mluví.",
      ),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
        "V editoru chybí tlačítko Přidat",
      ),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Tmavé"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Vždy tmavé"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Ztlumené"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
        "Měkčí tma, modrošedá místo černé",
      ),
      "theme_light": MessageLookupByLibrary.simpleMessage("Světlé"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("Vždy světlé"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Systém"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
        "Řídit podle nastavení telefonu pro světlý nebo tmavý režim",
      ),
      "translate": MessageLookupByLibrary.simpleMessage("Přeložit"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
        "Překlad ještě není připraven. Dnes se v běhu nic nepřekládá; toto se zapamatuje pro pozdější použití.",
      ),
      "translation_description": MessageLookupByLibrary.simpleMessage(
        "Kyronovy vlastní texty se stále překládají, takže většina obrazovek zatím zůstává v angličtině. Co se tím dnes mění: části rozhraní, které vykresluje Flutter, data a čísla a směr uspořádání aplikace pro jazyky zprava doleva.",
      ),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Zkusit znovu"),
      "ui_about_privacy_policy": MessageLookupByLibrary.simpleMessage(
        "Zásady ochrany osobních údajů",
      ),
      "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage(
        "Podmínky služby",
      ),
      "ui_account": MessageLookupByLibrary.simpleMessage("Účet"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Po"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Aplikace a zařízení"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Citát měl varovat ostatní před podvodem."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Napište, proč si myslíte, že rozhodnutí bylo chybné: co příspěvek znamenal, co mohl tým přehlédnout nebo proč pravidlo nesedí. Přečte si to někdo jiný než ten, kdo rozhodl."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Vaše odvolání"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Napište alespoň \$count znaků. Proti každému rozhodnutí se můžete odvolat jednou."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Odeslat odvolání"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Odvolání odesláno. Až bude rozhodnuto, dostanete oznámení."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Odvolání v případu \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Vzhled"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "Světlé, tmavé, nebo podle nastavení telefonu",
      ),
      "ui_before": MessageLookupByLibrary.simpleMessage("Před"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "Ani jeden z vás neuvidí druhého na Kyronu a jakékoliv sledování mezi vámi je odstraněno. Osoba není informována.",
      ),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Nese"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("K čemu slouží (nepovinné)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Psát mohou jen moderátoři"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Pro oznámení. Všichni v komunitě mohou dál číst a reagovat."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Přidat fotku nebo anketu"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Fotky a videa"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Zavřít chat"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Nikdo v něm už nebude moci číst ani psát. Tuto akci nelze vrátit."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Zavřít tento chat?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Zkopírováno"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Zpráva bude odstraněna pro všechny. Kyron si ponechá kopii ke kontrole."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Zpráva bude odstraněna pro všechny v chatu."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Upravit chat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Upravit"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("upraveno"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Upravujete svou zprávu"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Tento chat se nepodařilo otevřít."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Chaty"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Připojit se k chatu"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Připojte se ke komunitě, abyste viděli její chaty a mohli se zapojit."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Připojeno: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Opustit chat"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Dokud jste v komunitě, můžete ho dál číst."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Psát sem mohou jen vlastník a moderátoři."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Ztlumit"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Žádná oznámení z tohoto chatu a nezapočítává se do Zpráv."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Název chatu"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Nový chat"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Zatím žádné chaty."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Zatím žádné chaty. Otevřete jeden pro komunitu."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Chaty komunity nejsou šifrovány end-to-end. Moderátoři komunity a Kyron je mohou číst."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Připnout nahoru"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Přidat odpověď"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Ukončit anketu"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Ukončeno"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Všichni vidí, kolik lidí zvolilo kterou odpověď, nikdy kdo."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Povolit více odpovědí"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Nová anketa"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Vyberte jednu"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Odpověď \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Anketa: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Otázka"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Každá odpověď může být v anketě jen jednou."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Vyberte jednu nebo více"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("Odpovědělo: \$count"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Hledat v tomto chatu"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Hledat v tomto chatu"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Nic nenalezeno."),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("Tento chat už nemůžete vidět."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Pomalý režim"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Jak dlouho se čeká mezi zprávami. Neplatí pro moderátory."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 hodina"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Minuty: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Pomalý režim: jedna zpráva každých \$seconds s"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Vypnuto"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Sekundy: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Jako divák můžete číst a reagovat. Připojte se, abyste mohli psát."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Tato zpráva je v historii příliš daleko, aby se dala zobrazit."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Něco z vybraného je příliš velké na odeslání a bylo vynecháno."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Zrušit ztlumení"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Odepnout"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Nahrát hlasovou zprávu"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Vy"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Komunity"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("K čemu to je? (volitelné)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Příspěvky:"),
      "ui_content_display": MessageLookupByLibrary.simpleMessage(
        "Obsah a zobrazení",
      ),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst váš feed",
      ),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst vaše oblíbené příspěvky",
      ),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst váš profil",
      ),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
        "Nepodařilo se načíst vaše uložené příspěvky",
      ),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage(
        "Decentralizované ID",
      ),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnostika"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Skupiny"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("Žádné skupiny"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Zde jsou skupiny, ve kterých jste, a komunitní chaty, ke kterým se připojíte."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Připnout můžete až \$count chatů. Nejdřív jeden odepněte."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Připnuto"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Líbí se mi"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Uložené"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Zatím tu nic není"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
        "Sledujte několik účtů a jejich příspěvky se tu objeví.",
      ),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
        "Žádné příspěvky od lidí, které sledujete",
      ),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
        "Příspěvky se tu objeví, jak je lidé píší.",
      ),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Slábne"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Nezajímá mě"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Zobrazit víc podobných"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Odebráno"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Signály pro váš kanál"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Klepněte u příspěvku na Zobrazit víc podobných příspěvků nebo Tohle mě nezajímá a objeví se tady."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Zatím tu nic není"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Co vašim kanálům říká Zobrazit víc a Nezajímá mě"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Utvářejí Domů a Prozkoumat, hlavně podle toho, o čem příspěvek byl. Každý každý měsíc zeslábne na polovinu a po šesti přestane platit. Odeberte některý, chcete-li ho zastavit hned."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
        "Příspěvky s klipem se zde budou zobrazovat.",
      ),
      "ui_feed_videos_empty": MessageLookupByLibrary.simpleMessage(
        "Zatím žádná videa",
      ),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Zpětná vazba"),
      "ui_find_people_on_kyron": MessageLookupByLibrary.simpleMessage(
        "Najít lidi na Kyronu",
      ),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Z účtu"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Přidat lidi"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Přidat"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Přidat název skupiny"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Zamítnout"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Zprávy v této skupině jsou koncově šifrované, stejně jako každá jiná konverzace."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor přidává: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor jmenuje adminem: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor vytváří skupinu"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor nastavuje, že noví lidé se připojí jako členové"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor nastavuje, že noví lidé se připojí jako diváci"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor odchází"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor jmenuje členem: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor předává vlastnictví: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor odebírá: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor přejmenovává skupinu na \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor jmenuje divákem: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Skupina může mít nejvýš \$count lidí."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Ruka zvednutá. Admini to vědí."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Chtějí psát: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Chtějí psát"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Lidé přidaní později se připojí jako diváci"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Opustit skupinu"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Zmizí z vašeho seznamu a neuvidíte, co se napíše potom. Někdo by vás musel přidat znovu."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Opustit tuto skupinu?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Povolit psaní"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Spustit ruku"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Jmenovat adminem"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Předat vlastnictví"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Jmenovat divákem"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Členové: \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Členové"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Název skupiny"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Nejprve skupinu pojmenujte."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Vytvořit skupinový chat"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Vlastník je jen jeden. Zůstanete adminem."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Předat vlastnictví: \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Zvednout ruku"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Odebrat ze skupiny"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Odebrat roli admina"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Už nejste v této skupině."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Přejmenovat"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Admin"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Člen"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("Divák"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Jako divák zde můžete číst a reagovat."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Diváci mohou číst, reagovat a zvednout ruku, aby požádali o psaní."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Návrhy"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Zobrazit profil"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("vy"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Jste divák"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Nápověda"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Poznamenáno. To pomáhá formovat, co vám bude ukazováno.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Připojit se"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Připojeno"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Jazyk"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Vyberte jazyk"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Právní"),
      "ui_like": MessageLookupByLibrary.simpleMessage("To se mi líbí"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Oblíbené příspěvky"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Příspěvky, které se vám líbí, se tu zobrazují, nejnovější první.",
      ),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Odkaz zkopírován"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
        "Přestanete vidět jejich příspěvky. Osoba o tom není informována.",
      ),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Zatím žádné lajky"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
        "Žádné příspěvky neodpovídají těmto filtrům.",
      ),
      "ui_nothing_saved_yet": MessageLookupByLibrary.simpleMessage(
        "Zatím nic uloženo",
      ),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Váš účet byl aktualizován"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Vaše odvolání v případu \$number bylo přijato"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Vaše odvolání v případu \$number jsme znovu posoudili a rozhodnutí platí"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Váš účet byl natrvalo zablokován"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Případ \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("vás sleduje"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("dal(a) like vašemu příspěvku"),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Starší"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Vaše zpráva v komunitním chatu byla odstraněna"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Něco, co jste zveřejnili, bylo odstraněno"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Váš příspěvek byl odstraněn"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Vaše odpověď byla odstraněna"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("odpověděl(a) na váš příspěvek"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Na základě vašeho nahlášení jsme zasáhli. Děkujeme, že jste nám dali vědět."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Prověřili jsme vaše nahlášení a nezjistili jsme porušení našich pravidel."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Nahlášeno kvůli: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("sdílel(a) váš příspěvek"),
      "ui_notif_reversed":
          MessageLookupByLibrary.simpleMessage("Zrušili jsme případ \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Váš účet je pozastaven"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Váš účet je pozastaven do \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Vše"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Sledující"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Lajky"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Odpovědi"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Tento týden"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Dnes"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Váš účet dostal varování"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Včera"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Dokončit",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Přeskočit",
      ),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Tohle už bylo otevřeno."),
      "ui_once_expired":
          MessageLookupByLibrary.simpleMessage("Platnost vypršela"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Nepodařilo se to otevřít."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Otevře se jednou a pak se z Kyronu smaže."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Zobrazit jednou"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Otevřeno"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Otevřeno: \$count z \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Otevřít to mohou jen ti, kterým jste to poslali, a to jednou."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Odeslat k jednorázovému zobrazení"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Klepnutím zobrazíte"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pozastavit"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Přehrát"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
        "Je odstraněn z vašeho profilu a z feedů ostatních. Odpovědi s ním zmizí.",
      ),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Příspěvek smazán"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("Příspěvek skryt"),
      "ui_post_text_copied": MessageLookupByLibrary.simpleMessage(
        "Text příspěvku zkopírován",
      ),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Zveřejněno mezi"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
        "Skryto. Ukážeme vám jich méně.",
      ),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Předvolby"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Soukromí"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Chcete něco dodat? (nepovinné)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Až tým rozhodne, dostanete oznámení, a celou věc můžete sledovat v sekci Vaše nahlášení."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Pokud tuto osobu už také nechcete vidět, ztlumte ji nebo zablokujte ve stejné nabídce."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Nahlásit stejnou věc dvakrát jí nepřidá na váze: od každého uchováváme jedno nahlášení."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Vaše nahlášení se s danou osobou nesdílí. Uchováváme kopii nahlášeného obsahu, aby ho bylo možné posoudit, i když bude smazán."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Vaše nahlášení jsme přijali a čeká na posouzení. Dané osobě neříkáme, kdo ji nahlásil."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Zobrazit vaše nahlášení"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Řekněte nám, co je špatně"),
      "ui_report_thanks": MessageLookupByLibrary.simpleMessage(
          "Děkujeme, že jste nám dali vědět"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Co je špatně s účtem \$name?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("Co je špatně s touto zprávou?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Co je špatně s tímto příspěvkem?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Co je špatně s touto odpovědí?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Zpráva v komunitním chatu"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Příspěvek"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Odpověď"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Zasáhli jsme"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Účet"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Rozhodnuto \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Pravidla neporušena"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Vaše nahlášení se nepodařilo načíst"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Co jste za posledních 90 dní nahlásili a jak to dopadlo. Až tým rozhodne, dostanete oznámení. Nikdo, koho nahlásíte, se nedozví, kdo ho nahlásil."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Nic nenahlášeno"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Když nahlásíte příspěvek, odpověď, zprávu nebo účet, objeví se tady i s tím, jak to dopadlo."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("Posuzuje se"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Nahlášeno \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Co jste nahlásili a jak to dopadlo"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Vaše nahlášení"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Bezpečnost dětí"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Cokoli, co ohrožuje nebo sexualizuje nezletilé."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Cílené obtěžování, výhrůžky nebo nevyžádaný kontakt."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Útoky na lidi kvůli tomu, kým jsou."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Prodej nebo propagace něčeho nezákonného."),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("Vydávání se za někoho jiného."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Používá vaše dílo nebo ochrannou známku bez svolení."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Zavádějící tvrzení o zdraví, volbách nebo událostech."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Podněcování k sebepoškozování nebo jeho zobrazování."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Sexuální obsah zobrazený bez upozornění."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Nic z uvedeného. Řekněte nám, co je špatně."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Opakovaná, zavádějící nebo nevyžádaná propagace."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Vyhrožování násilím, jeho oslavování nebo podněcování k němu."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Obtěžování nebo šikana"),
      "ui_rule_hate":
          MessageLookupByLibrary.simpleMessage("Nenávistné projevy"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Nelegální zboží nebo služby"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Vydávání se za jiného"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Duševní vlastnictví"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Nepravdivé informace"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Sebevražda nebo sebepoškozování"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Obsah pro dospělé"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Něco jiného"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spam"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Násilí nebo výhrůžky"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Uložené příspěvky"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Klepněte na ikonu archivu u libovolného příspěvku, abyste ho zde uložili. Vidíte to pouze vy.",
      ),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
        "Hledat podle uživatelského jména nebo zobrazovaného jména.",
      ),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Vymazat"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
        "Vyhledat vše zveřejněné",
      ),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filtry"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Hledat lidi"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Hledat příspěvky"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Nastavení"),
      "ui_settings_app_device": MessageLookupByLibrary.simpleMessage(
        "Aplikace a zařízení",
      ),
      "ui_settings_content_display": MessageLookupByLibrary.simpleMessage(
        "Obsah a zobrazení",
      ),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Úspora dat"),
      "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
        "Řekněte nám, co si myslíte",
      ),
      "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage(
        "Procházet články nápovědy",
      ),
      "ui_settings_language_detail": MessageLookupByLibrary.simpleMessage(
        "Vyberte svůj jazyk",
      ),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
        "Koho máte ztlumeného nebo zablokovaného",
      ),
      "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
        "Nastavení oznámení",
      ),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
        "Váš profil a kontaktní informace",
      ),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
        "Budete se muset znovu přihlásit, abyste se vrátili ke svému účtu.",
      ),
      "ui_settings_security": MessageLookupByLibrary.simpleMessage(
        "Nastavení zabezpečení",
      ),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Potvrďte heslo"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("V jedné větě"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Nová e-mailová adresa"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Nové heslo"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Co se stalo"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
        "Získat pomoc od našeho týmu",
      ),
      "ui_share": MessageLookupByLibrary.simpleMessage("Sdílet"),
      "ui_share_this_post": MessageLookupByLibrary.simpleMessage(
        "Sdílet tento příspěvek",
      ),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Čeho se to týkalo"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Váš účet je natrvalo zablokován"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Odpověď, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Odvolání"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Odvolat se proti rozhodnutí"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Proti tomuto rozhodnutí se už nelze odvolat. Pokud je něco špatně, kontaktujte podporu."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Odvolání se posuzuje"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Odvolání přijato"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Někdo jiný z týmu to posuzuje znovu. Až bude rozhodnuto, dostanete oznámení."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Pokud si myslíte, že šlo o chybu, můžete do \$date požádat o nové posouzení. Rozhoduje někdo jiný z týmu."),
      "ui_standing_appeal_upheld":
          MessageLookupByLibrary.simpleMessage("Po odvolání: rozhodnutí platí"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Případ \$number. Pravidlo: \$rule. Tým napsal:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Smazání účtu zablokování nezruší: nový účet se stejnou e-mailovou adresou bude také zablokován."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Natrvalo zablokován"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Funguje už jen tato stránka, odvolání, podpora a smazání účtu."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Lze se odvolat"),
      "ui_standing_case":
          MessageLookupByLibrary.simpleMessage("Případ \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Rozhodnuto \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Rozhodnutí o vašem účtu"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Smazat účet"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Zobrazit podrobnosti"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "Zobrazit podrobnosti a odvolat se"),
      "ui_standing_ends": MessageLookupByLibrary.simpleMessage("Končí \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Váš účet je v pořádku"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Nic ho neomezuje."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Stav účtu se nepodařilo načíst"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Zpráva odstraněna"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "O vašem účtu nebylo nic rozhodnuto. Pokud tým někdy odstraní něco vašeho nebo omezí váš účet, uvidíte to zde i s důvodem a budete se moci odvolat."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Není proti čemu se odvolat: rozhodnutí bylo zrušeno."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Příspěvek odstraněn"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Stáhněte dolů a zkontrolujte znovu."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Přečíst pravidla Kyronu"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Odpověď odstraněna"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Zrušeno"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Zrušeno \$date. Vše, co bylo odstraněno, je zpět, a žádné omezení už neplatí."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Pravidlo: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("Odhlásit se"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Pozastaveno"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Můžete číst, ale ne přidávat příspěvky, odpovídat, sledovat ani posílat zprávy. Nahlašování, blokování a ztlumení stále fungují."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Váš účet je pozastaven: můžete číst, ale ne přidávat příspěvky."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Pozastaveno do \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Váš účet je pozastaven do \$date: můžete číst, ale ne přidávat příspěvky."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Co napsal tým"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("Stav účtu"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Upozornění"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Proč?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Vaše slova, \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Vaše zpráva"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Váš příspěvek"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Vaše odpověď"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Podmínky"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("tento příspěvek"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Vlákno ztlumeno"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Zkusit znovu"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("Vypnout zvuk"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Zapnout zvuk"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Dva nebo více znaků.",
      ),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Zpět"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
        "Slova nebo filtr — účet, rozsah dat nebo co příspěvek nese.",
      ),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Vrátit sdílení"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Aktualizovat heslo"),
      "useDifferentAddress": MessageLookupByLibrary.simpleMessage(
        "Použít jinou adresu",
      ),
      "username": MessageLookupByLibrary.simpleMessage("Uživatelské jméno"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
        "Uživatelské jméno musí být malými písmeny (a-z, 0-9, _)",
      ),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Připojit"),
      "voice_ready_attach": MessageLookupByLibrary.simpleMessage(
        "Připraveno k přiložení",
      ),
      "voice_record_post": MessageLookupByLibrary.simpleMessage(
        "Nahrát hlasový příspěvek",
      ),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Nahrávání…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Zastavit"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Co se stalo"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Co se stalo a na co se máme podívat?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Co je na této fotce?"),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage(
        "K čemu to je? (volitelné)",
      ),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
        "Co jste udělali, co jste očekávali, co se stalo",
      ),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
        "Co jste dělal, když se to stalo.",
      ),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Vaše odpověď"),
      "dmReplied": (Object a0) => "Odpověď od $a0",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Přidat do zprávy"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Nová zpráva"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Zatím nic. Zamávání je dobrý začátek."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Zamávat"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("Nové zprávy"),
      "dmTyping": (Object a0) => "$a0 píše",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Odebrat vaši reakci"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Někdo"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Zpráva"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("Příloha"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Tuto zprávu nelze na tomto zařízení přečíst."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Čeká se na tuto zprávu. Může to chvíli trvat."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Šifrovaná zpráva"),
      "ui_dm_e2ee_notice":
          MessageLookupByLibrary.simpleMessage("Zprávy jsou koncově šifrované"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Bez koncového šifrování"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Odesláno"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Zobrazeno"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Odesílání…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Vyfotit"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Další možnosti"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Uložit do zařízení"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Sdílet"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Ukládání…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Uloženo do fotek"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Nepodařilo se uložit. Zkuste to znovu."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Povolte Kyronu přidávat do fotek, abyste to mohli uložit."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Všechny systémy fungují"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Dostupnost"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Posledních 60 dní"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Před 60 dny"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Dnes"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Databáze"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Přihlášení"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Nedávné incidenty"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Za posledních 60 dní žádné incidenty."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Probíhá"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Žádná data"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Podrobnosti"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron se za běhu kontroluje každých 5 minut. Šedý den neměl žádné kontroly."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Historie dostupnosti zatím není k dispozici."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Některé systémy mají potíže"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Nahrát hlasovou zprávu"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Připraveno k odeslání"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Tato zpráva tu už není."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Přejít na zprávu"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Hlasová zpráva"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Autorovi se to líbí"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Přidat fotku nebo klip"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Média"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Hlasové zprávy"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Tapeta"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Ztlumit oznámení"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Přestat dostávat oznámení o této konverzaci"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("Už vám nemohou psát"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Žádná"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Fotka"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Ztlumení zrušeno."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Nepodařilo se odstranit. Zkuste to znovu."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profil"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Zrušit ztlumení"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Fotky a klipy, které sdílíte, se zobrazí tady."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Zobrazit vše"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("Fotky a klipy"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Takhle bude váš chat vypadat."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Vypadá to dobře."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Mlha"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Soumrak"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Šalvěj"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Písek"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Tečky"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Použít"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Aktuální"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Odeslat bez náhledu"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Hledat"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Zveřejnit"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Napište zprávu…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Odeslat"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Odesláno"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Odesláno, ale ne všem."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Nepodařilo se odeslat. Zkuste to znovu."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Sledující"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtr"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Vše"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Nepřečtené"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Bez odpovědi"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Skryté"),
      "ui_dm_hidden_none": MessageLookupByLibrary.simpleMessage("Nic skrytého"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Konverzace, které odeberete ze seznamu, čekají tady, kdybyste je chtěli zpět."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Přesune se do Skrytých. Druhá strana si tu svou ponechá a vrátí se, když jeden z vás znovu napíše."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Vrátit"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Zpět ve vašem seznamu."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "Žádné odpovídající konverzace."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Nic na vás nečeká"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Každá konverzace končí vaším slovem."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Fotka"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Fotky"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Zatím žádné zprávy"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Vy:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Včera"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Zprávy"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Nastavení zpráv"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Soukromí"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Potvrzení o přečtení"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Když je to vypnuté, lidé neuvidí, kdy jste si přečetli jejich zprávy, a vy neuvidíte, kdy si oni přečetli ty vaše."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Zobrazit, když píšete"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Člověk, kterému píšete, vidí, že píšete."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Náhledy odkazů"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Váš telefon otevře odkaz, který posíláte, aby vytvořil náhled, takže web uvidí požadavek vašeho telefonu. Server Kyronu odkaz nikdy neuvidí."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Oznámení o zprávách"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Zprávy jsou koncově šifrované. Kyron je nemůže číst a nic tady to nemění."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Komu:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Nedávné"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Lidé"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Nikdo s tímto jménem."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Poslat zkušební oznámení"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Server Kyronu zatím není nastavený na odesílání oznámení, takže žádné nemůže dorazit. Chyba je u nás, ne ve vašem telefonu."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Tento telefon není zaregistrovaný pro oznámení. Zkontrolujte, že má Kyron v nastavení telefonu povolená oznámení, a zkuste to znovu."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Oznámení se do tohoto telefonu nepodařilo doručit. Zkuste to znovu za minutu."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Odesláno. Mělo by dorazit během několika sekund."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Oznámení fungují."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Zatím žádné příspěvky"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("Nová komunita"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Název"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Adresa se vytvoří z názvu."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Lidé ji najdou na adrese"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Budete jejím vlastníkem. Obrázek, banner a moderátory můžete přidat na její stránce, jakmile vznikne."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Domů"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Příspěvky komunit na Domů"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Příspěvky z vašich komunit se zobrazují i na Domů. Když je to vypnuté, zůstávají tady v Komunitách, kde každá ukazuje, co je nového."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Váš seznam"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Počty nových příspěvků"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Ukazovat, kolik příspěvků je v každé komunitě nových od chvíle, kdy jste ji naposledy otevřeli."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Komunity, které spravujete"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Zde jsou komunity, které založíte nebo moderujete."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Vlastník"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderátor"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Nové příspěvky"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Spravované vámi"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Nastavení komunit"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Objevit"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Žádné komunity neodpovídají."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Nic nového"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Každá komunita je tak, jak jste ji opustili."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Zatím žádnou nespravujete"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Už není k čemu se přidat"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Jste ve všech komunitách na Kyronu. Založte další."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Zkuste jiné slovo, nebo založte komunitu s tímto názvem."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Napsat příspěvek"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Členové:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Zveřejněno"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Zobrazit"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Otevřít"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Online"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Zobrazit, když jste online"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Lidé, kterým píšete, vidí zelenou tečku, když máte Kyron otevřený. Když je to vypnuté, neuvidíte ani tu jejich."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Hledat lidi a příspěvky"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Komunity, ke kterým se můžete připojit"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Zatím tu není nic k vidění"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Zde se zobrazí fotky a klipy, které lidé zveřejní."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Sledovat"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("Smazat účet"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Tímto trvale smažete svůj účet Kyron. Tento krok nelze vrátit."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Váš profil, příspěvky, odpovědi, lajky a sdílení"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Vaše zprávy, včetně těch, které jste poslali ostatním, a fotky a hlasové zprávy v nich"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Vaši sledující, lidé, které sledujete, a vaše nastavení"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Komunity, které jste založili, přejdou na nejdéle působícího moderátora nebo člena. Komunita, ve které nikdo jiný není, se zavře."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Smazat váš účet?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Nic z toho už nebudete moct získat zpět."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Váš účet byl smazán."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Smazaný účet"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Tento účet byl smazán, takže sem už nelze posílat zprávy."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Registrovali jste se přes Google? Použijte raději „Přihlásit se přes Google“."),
    };

final messageLookup = MessageLookup();
