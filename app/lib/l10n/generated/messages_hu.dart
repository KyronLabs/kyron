import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hu';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Szó, kifejezés vagy #címke"),
      "about": MessageLookupByLibrary.simpleMessage("Névjegy"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Válasz hozzáadása"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Nyelvek hozzáadása…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Elfogadás és folytatás"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Van már Kyron-fiókod?"),
      "analytics_comments":
          MessageLookupByLibrary.simpleMessage("Hozzászólások"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Különböző emberek, nem megnyitások"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("Aktivitás"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Kedvelések"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Még nincsenek nézők"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Ezt a bejegyzést még senki sem nyitotta meg."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Közzétéve"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Mentések"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Nézők"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("NAPI NÉZŐK"),
      "and": MessageLookupByLibrary.simpleMessage("és"),
      "answerNumber": (Object a0) => "${a0}. válasz",
      "arLens": MessageLookupByLibrary.simpleMessage("AR-lencse"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Alkalmazásnapló csatolása"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Oda-vissza idő"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("TOKEN-ELLENŐRZÉS"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Próbáld újra"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Próbáld újra"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Ha most indítasz közvetítést, egy olyan szobába kerülsz, ahová senki sem tudna"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Közösség indítása"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Mire szolgál? (nem kötelező)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("visszajönni."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("visszajönni erről a listáról."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Ha bezárod,"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("előbb csatlakozz"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("hamarosan"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Saját nevedben posztolsz"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("posztolj ebben a közösségben"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Épp most"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Próbáld újra"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("1. téma"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Neked"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("van valami."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("már úton van oda."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", nem"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("mozgok-e"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Hang kikapcsolása"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Hang bekapcsolása"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Neked"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Lapjaid"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Próbáld újra"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Szimbólum (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("NAPI NÉZŐK"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("nem sikerült betölteni"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ez a bejegyzés"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Szeretnél még valamit hozzáfűzni? (nem kötelező)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ez a bejegyzés"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Egy fióktól"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Kijelentkezés"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Fiókod"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Jelszó megerősítése"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("most nem"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Betöltés…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Közzététel…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 órája"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Történet linkjének másolása"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Történeted"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "A fiókod, a bejegyzéseid és amire koppintasz, hogy"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Téma hozzáadása"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("sajátja."),
      "authorBlocked": (Object a0) => "${a0} letiltva",
      "authorPostsHidden": (Object a0) => "Nem fogod látni ${a0} bejegyzéseit",
      "block": MessageLookupByLibrary.simpleMessage("Letiltás"),
      "blockAuthor": (Object a0) => "Letiltod: ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Buildadatok másolva"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("A folytatással elfogadod:"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "A folytatással elfogadod a Felhasználási feltételeket és az Adatvédelmi irányelveket"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("A regisztrációval elfogadod:"),
      "cancel": MessageLookupByLibrary.simpleMessage("Mégse"),
      "change": MessageLookupByLibrary.simpleMessage("Módosítás"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("E-mail módosítása"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Erősítsd meg a fiókodat az e-mailből."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Ellenőrzés, hogy a Kyron elérhető-e"),
      "clear": MessageLookupByLibrary.simpleMessage("Törlés"),
      "close": MessageLookupByLibrary.simpleMessage("Bezárás"),
      "closeCommunity": (Object a0) => "Bezárod: ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Bezárás"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Közösség bezárása"),
      "communities": MessageLookupByLibrary.simpleMessage("Közösségek"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Keress egyet a Felfedezésben, vagy indíts sajátot."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Dobj be egy merész véleményt (vagy langyosat)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Mi jár a fejedben?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Mondj valamit, amit csak te tudsz…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("Ez a jel: posztold"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Írj, beszélj vagy gondolkodj hangosan"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Jelszó megerősítése"),
      "contactSupport": MessageLookupByLibrary.simpleMessage(
          "Kapcsolatfelvétel az ügyfélszolgálattal"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "A bejegyzéseknek még nincs nyelve, ezért ez még nem szűri a hírfolyamodat. A választásaidat addig megőrizzük."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Folytatás"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Folytatás e-maillel"),
      "copy": MessageLookupByLibrary.simpleMessage("Másolás"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Inkább a jelentés másolása"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Nem sikerült megnyitni a Google-bejelentkezést. ${a0}",
      "couldNotSignOut": (Object a0) => "Sikertelen kijelentkezés: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Nem sikerült fotót készíteni."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Megjelenik a profilodon és a bejegyzéseid alatt."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Egy ország sem felel meg ennek: „{query}”."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Ne jelenjen meg ország"),
      "country_search":
          MessageLookupByLibrary.simpleMessage("Országok keresése"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Megjelenik a profilodon és a bejegyzéseid alatt. Ha látod valaki bejegyzéseit, az országodat beleszámolják az Elemzéseibe, csak legalább ötfős csoportokban, és soha nem a neveddel."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("A telefonod beállításaiból"),
      "create": MessageLookupByLibrary.simpleMessage("Létrehozás"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Fiók létrehozása"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Hozd létre a fiókodat"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Hozd létre a profilodat"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR-lencse"),
      "create_go_live":
          MessageLookupByLibrary.simpleMessage("Élő adás indítása"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Szöveges bejegyzés"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Hangbejegyzés"),
      "delete": MessageLookupByLibrary.simpleMessage("Törlés"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Törlöd ezt a hozzászólást?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Törlöd ezt a bejegyzést?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Írd le ezt a mellékletet"),
      "description": MessageLookupByLibrary.simpleMessage("Leírás"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID a vágólapra másolva"),
      "done": MessageLookupByLibrary.simpleMessage("Kész"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Zárd be a szerkesztőt, miután írtál valamit, és felajánlunk egy piszkozatot."),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} napja"),
      "draft_hours_ago": MessageLookupByLibrary.simpleMessage("{hours} órája"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Épp most"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} perce"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Még semmi sincs megírva"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Szavazás, még kérdés nélkül"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Idézet, még szöveg nélkül"),
      "drafts": MessageLookupByLibrary.simpleMessage("Piszkozatok"),
      "editProfile":
          MessageLookupByLibrary.simpleMessage("Profil szerkesztése"),
      "email": MessageLookupByLibrary.simpleMessage("E-mail"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("E-mail-értesítések"),
      "explore": MessageLookupByLibrary.simpleMessage("Felfedezés"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Az arckövetés ezen az eszközön nem érhető el."),
      "feedTagDetail": (Object a0) =>
          "Még semmit sem tettek közzé ezzel: #${a0}.",
      "follow_author": MessageLookupByLibrary.simpleMessage("{name} követése"),
      "followers": MessageLookupByLibrary.simpleMessage("Követők"),
      "following": MessageLookupByLibrary.simpleMessage("Követettek"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Elfelejtetted a jelszót?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Segítség kérése"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Folytatás Google-lel"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Bejelentkezés Google-lel"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "A Google a kész bejelentkezést egy olyan linken küldi vissza a Kyronnak, amelyre csak az Android és az iOS válaszol, így ${a0} rendszeren a böngészőnek nincs hová visszaküldenie.\\n\\nHa már van Kyron-fiókod Google-lel, válaszd a Folytatás e-maillel lehetőséget ugyanazzal a címmel, és koppints az Elfelejtett jelszóra: kapsz egy linket a jelszó beállításához.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "A Google-bejelentkezéshez a telefonos alkalmazás kell"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Regisztráció Google-lel"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Útmutatók és válaszok gyakori kérdésekre"),
      "handle": MessageLookupByLibrary.simpleMessage("felhasználónév"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Súgó és támogatás"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Súgóközpont"),
      "home": MessageLookupByLibrary.simpleMessage("Kezdőlap"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("Egy sorban"),
      "ins_account": MessageLookupByLibrary.simpleMessage("A fiókod"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Közösség megnyitása"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Írj bejegyzést"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Bejegyzés megtekintése"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Profil szerkesztése"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Mikor vannak jelen"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("A saját időzónádban."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Életkorok"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Az elért emberek közül {known}, akik megadták a születésnapjukat."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Elért emberek naponta"),
      "ins_communities": MessageLookupByLibrary.simpleMessage(
          "Közösségek, amelyekben benne vannak"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Országok"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Az elért emberek közül {known}, akiknek van ország a profilján."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Elmúlt {days} nap"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a statisztikákat"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Követők"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Még nincs akkora csoport, amelyet meg lehetne mutatni."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Hogyan növekedj"),
      "ins_interests": MessageLookupByLibrary.simpleMessage("Követett témák"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Kedvelések"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Új"),
      "ins_new_followers": MessageLookupByLibrary.simpleMessage("Új követők"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Ebben az időszakban egyik bejegyzésed sem ért el senkit."),
      "ins_non_followers": MessageLookupByLibrary.simpleMessage("Nem követnek"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Az országok azok, amelyeket az emberek a profiljukon választottak. A Kyron senkinek a városát vagy nemét nem gyűjti, így ezekről nincs mit megmutatni."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Megnyitások"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} elért · {likes} kedvelés · {replies} válasz"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Elért emberek"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Mindenki egyszer számít: először mutatták meg neki vagy nyitotta meg valamelyik bejegyzésedet. Az új követők még követnek; a követés visszavonásait nem számoljuk."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Válaszok"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Újramegosztások"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Mentések"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Hogy kik a közönséged, akkor látszik, ha {floor} ember látta a bejegyzéseidet ebben az időszakban. Kevesebbnél ez valakire rámutathatna."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Még nincs elég ember"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}%-uk már követ: a bejegyzéseid főleg az ismerőseidhez jutnak el."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}%-uk még nem követ: a bejegyzéseidre rátalálnak."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "{reach} embert értél el, {pct}%-kal kevesebbet, mint az előző időszakban."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Az elmúlt {days} napban {reach} embert értél el."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "{reach} embert értél el, nagyjából annyit, mint az előző időszakban."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Az elmúlt {days} napban senki új nem látta a bejegyzéseidet."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "{reach} embert értél el, {pct}%-kal többet, mint az előző időszakban."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "{reach} embert értél el, {times}× annyit, mint az előző időszakban."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Közülük többen követik ezt: {name}, mint bármely más témát."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Közönség"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Áttekintés"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Akik rátalálnak egy bejegyzésedre, követés előtt megnézik a profilodat. Egy arc vagy logó jelzi, hogy valaki ott van."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Adj meg profilképet"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Mondd el egy sorban, miről posztolsz, hogy egy idegen tudja, mit kap, ha követ."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Írj bemutatkozást"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{total} bejegyzésedből {without} témát nem kapott. A téma a bejegyzést a téma hírfolyamába és a követői elé teszi."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Adj témákat a bejegyzéseidhez"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} ember válaszolt a bejegyzéseidre, te pedig {answered} válaszra feleltél. Elég fontos volt nekik, hogy írjanak: egy válasz törzsolvasót csinál az olvasóból."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Válaszolj a válaszokra"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "A közönséged {when} a legaktívabb. Egy kicsivel előtte közzétett bejegyzést lesz, aki fogadja."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Posztolj, amikor jelen vannak"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} ember, aki nem követ, látta a bejegyzéseidet, és {gained} követni kezdett. A bemutatkozásod és legújabb bejegyzéseid mondják el, mire számíthatnak tőled."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("Csinálj követőt az olvasókból"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Egy bejegyzésed {times}× annyi embert ért el, mint a többi általában. Nézd meg, mit csinált másképp, és csináld azt többet."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "Csináld többet azt, ami bevált"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Sokan, akik látják a bejegyzéseidet, benne vannak ebben: {name}. Ha ott posztolsz, a többiek elé is kerülsz."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Posztolj itt: {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "{days} nap alatt {posts}-szor posztoltál. Minden bejegyzés újabb esély arra, hogy rád találjanak, az egyenletes ritmus pedig a követőid hírfolyamában tart."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Posztolj gyakrabban"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Az elmúlt {days} napban nem tettél közzé semmit. Bejegyzés nélkül semmi sem jut el senkihez."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Ossz meg valamit"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Statisztikák"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("Legjobb bejegyzések"),
      "ins_vs_before":
          MessageLookupByLibrary.simpleMessage("Az előző {days} naphoz képest"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Érdeklődési kör hozzáadása"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Húzd az átrendezéshez"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "A sávra legfeljebb öt lap fér. Távolíts el egyet, hogy újat adj hozzá."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Követettek"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Neked"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "A hashtagek itt jelennek meg, amikor az emberek elkezdik használni őket."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Most felkapott"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Videók"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Lapjaid"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Mindkettőtöknél eltűnik."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Eltávolítjuk a szálból."),
      "join": MessageLookupByLibrary.simpleMessage("Csatlakozás"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Szerkesztés folytatása"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "A Kyron képernyői a te nyelveden vannak. Ha egy szó furcsán hangzik, szólj nekünk a Visszajelzés küldése menüben."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Nyelvek"),
      "leave": MessageLookupByLibrary.simpleMessage("Kilépés"),
      "leaveCommunity": (Object a0) => "Kilépsz innen: ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Visszaengedés"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 oldal nyitva"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Klip hozzáadása"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF hozzáadása"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Hashtag hozzáadása"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Fotó hozzáadása"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Szavazás hozzáadása"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Videó hozzáadása"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Érdeklődési kör hozzáadása"),
      "literaladdLabelAsATab": (Object a0) => "${a0} hozzáadása lapként",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Alkalmazás nyelve"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Alkalmazásverzió"),
      "literalblockAuthor": (Object a0) => "${a0} letiltása",
      "literalblockAuthor2": (Object a0) => "Letiltod: ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Letiltod ezt a fiókot?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Válasz elvetése"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Újraellenőrzés"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Választás a galériából"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Gyorsítótár törlése"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Összes oldal bezárása"),
      "literalcloseTabLabel": (Object a0) => "${a0} bezárása",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Böngésző bezárása"),
      "literalcloseWidgetCommunityName": (Object a0) => "Bezárod: ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Kapcsolat a támogatással"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Tartalom nyelvei"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Link másolása"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Bejegyzés linkjének másolása"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Bejegyzés szövegének másolása"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("Szöveg másolása"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a közösségeket"),
      "literalcouldNotLoadGifs": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a GIF-eket"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni az értesítéseket"),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a tagokat"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni ezeket a bejegyzéseket"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Nem sikerült betölteni ezt a beszélgetést"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni ezt a listát"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni ezt a bejegyzést"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni ezt a választ"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a népszerű címkéket"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Nem sikerült betölteni a közösségeidet"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni az üzeneteidet"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült megnyitni ezt a közösséget"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült közzétenni a választ."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("A keresés nem sikerült"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Sikertelen kijelentkezés: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} oldal nyitva",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Borítókép"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Adattakarékosság"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Bejegyzés törlése"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Emberek keresése"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Ne válaszolj"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Piszkozat mentve"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "A visszajelzést most nem lehet elküldeni"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Szövegméret"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("A GIF-ek nincsenek beállítva"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Átadás másik alkalmazásnak"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Jelszó elrejtése"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Bejegyzés elrejtése"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Elrejti, és kevesebb hasonló megjelenítését kéri"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Hogyan viselkedj"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Írás folytatása"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("A Kyron nem válaszolt"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} dátuma",
      "literalleaveCommunityName": (Object a0) => "Kilépsz innen: ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, arclencse",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Kedvelt bejegyzések"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("Link másolva"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Moderátorrá tétel"),
      "literalmuteAuthor": (Object a0) => "${a0} némítása",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Szál némítása"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Szavak vagy címkék némítása"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("Némított és letiltott fiókok"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Némítva. Nem kapsz értesítéseket."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Ezen az eszközön egyetlen alkalmazás sem nyit meg ${a0} linkeket.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Az eszközön egyetlen böngésző sem fogadta a linket."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Még nincs DID"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("Nincsenek piszkozatok"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
          "Még nincsenek érdeklődési körök"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Még nincsenek kedvelések"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Még nincsenek üzenetek"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Nincsenek új követők"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Még nincsenek bejegyzések"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Még nincsenek válaszok"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Még nincsenek megosztások"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Egy népszerű címke sem egyezik"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Senki sem található"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Senkit sem távolítottak el"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Még nincs itt senki"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Nem érdekel"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Nincs találat"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Még semmi sem felkapott"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Még semmi sincs a naplóban"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Nincs találat"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Nincs némítás"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Még nincs mit nézni"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Nincs olvasatlan"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Ezt csak a tulajdonos módosíthatja"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Válasz megnyitása"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Nyisd meg a Kyron e-mailjét"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Jelszó és bejelentkezés"),
      "literalpostInCommunityName": (Object a0) => "Közzététel itt: ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "Közzététel itt: ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Tedd közzé saját szavaiddal fölötte"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Elsődleges nyelv"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-értesítések"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Ellenőrzés…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Hangbejegyzés rögzítése"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Újrafelvétel"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Moderátori jog elvétele"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Eltávolítás a közösségből"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Eltávolítás a mentettek közül"),
      "literalremoveLabel": (Object a0) => "${a0} eltávolítása",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0} eltávolítása",
      "literalremoveMemberDisplayname": (Object a0) => "Eltávolítod: ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Szavazás eltávolítása"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Válasz eltávolítása"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Beszélgetés törlése"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Szavazás eltávolítása"),
      "literalreportAuthor": (Object a0) => "${a0} jelentése",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Bejegyzés jelentése"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Kód újraküldése"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Mentett bejegyzések"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Mondj valamit"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Mondj valamit itt: ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Sikertelen keresés"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Újraküldés"),
      "literalsendAgainInCooldownS": (Object a0) => "Újraküldés ${a0} mp múlva",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Visszajelzés küldése"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Link küldése"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Elküldve. Ez a(z) ${a0}. számú jelentés.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "Állíts be jelszót, és folytasd"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Napló megosztása a támogatással"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Közösség megosztása"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Oldal megosztása"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Profil megosztása"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Megosztás…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Megosztás idézettel"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Több ilyet mutass"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Jelszó megjelenítése"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Találatok megjelenítése"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Közösség indítása"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Felvétel indítása"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Betöltés leállítása"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Ne lássam többé ezt a bejegyzést és a válaszait"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Történetsáv, ${a0} elem",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Kameraváltás"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Valaki megjelölése"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Fotó készítése"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Koppints a borítóra vagy a fotóra a cseréhez"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Koppints a benne lévő linkre"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Koppints fotó és borító hozzáadásához"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("Nem sikerült. Próbáld újra."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Nem sikerült betölteni azt a GIF-et."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Ez a link itt nem nyitható meg."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("A kamera zárva"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Ez a közösség"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Ez a válasz már nem létezik"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Bejegyzés fordítása"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Hang kikapcsolása"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Hang bekapcsolása"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Egy a mieink közül"),
      "literalverificationCodeResent":
          MessageLookupByLibrary.simpleMessage("Megerősítő kód újraküldve."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Sikertelen megerősítés: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("E-mail megerősítése"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Nézők, kedvelések, mentések és hozzászólások"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Mit őriz meg a Kyron"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Mit csinált ez az alkalmazás"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Mit csináltál, mire számítottál, mi történt "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Amit közzéteszel, az a tiéd"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Elérhető-e most a Kyron"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Ki válaszolhat"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Kit szeretnél megjelölni?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Már minden népszerű címkét követsz"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Mindent láttál"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Nem vagy tagja egyetlen közösségnek sem"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Kijelentkeztél."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Kiléptél innen: ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Még nem tettél közzé semmit"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Továbbiak betöltése"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Napló törölve"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Napló másolva"),
      "logIn": MessageLookupByLibrary.simpleMessage("Bejelentkezés"),
      "logOut": MessageLookupByLibrary.simpleMessage("Kijelentkezés"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Kijelentkezel?"),
      "login": MessageLookupByLibrary.simpleMessage("Bejelentkezés"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Sikertelen bejelentkezés. Ellenőrizd az adataidat."),
      "manage": MessageLookupByLibrary.simpleMessage("Kezelés"),
      "menu": MessageLookupByLibrary.simpleMessage("Menü"),
      "message": MessageLookupByLibrary.simpleMessage("Üzenet"),
      "messages": MessageLookupByLibrary.simpleMessage("Üzenetek"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "Minden beszélgetést elolvastál."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Nyisd meg valakinek a profilját, és koppints az Üzenetre a beszélgetés indításához."),
      "mute": MessageLookupByLibrary.simpleMessage("Némítás"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Némítottak és letiltottak"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Némított szavak és címkék"),
      "name": MessageLookupByLibrary.simpleMessage("Név"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> képernyő"),
      "newEmailAddress": MessageLookupByLibrary.simpleMessage("Új e-mail-cím"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Új jelszó"),
      "newPost": MessageLookupByLibrary.simpleMessage("Új bejegyzés"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Most nem"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Nincs elküldve. Koppints az újrapróbáláshoz"),
      "nothingMatchesQuery": (Object a0) =>
          "Semmi sem egyezik ezzel a Kyronon: \"${a0}\"",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Nincs mit másolni"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "A kedvelések, válaszok és új követők ide érkeznek."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Akik követnek, itt jelennek meg."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Ha valaki kedveli a bejegyzésedet, itt jelenik meg."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "A bejegyzéseidre érkező válaszok ide jönnek."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Ha valaki megoszt téged, itt jelenik meg."),
      "notifications": MessageLookupByLibrary.simpleMessage("Értesítések"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Megnyitás böngészőben"),
      "or": MessageLookupByLibrary.simpleMessage("vagy"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Az oldal nem található"),
      "password": MessageLookupByLibrary.simpleMessage("Jelszó"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("A jelszó túl rövid"),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
          "Válaszd ki az érdeklődési köreidet"),
      "post": MessageLookupByLibrary.simpleMessage("Közzététel"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Bejegyzés statisztikái"),
      "postInCommunity": (Object a0) => "Közzététel itt: ${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Posztolj, mondd, mutasd."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Bejegyzés szövege másolva"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Adatvédelmi irányelvek"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profil frissítve"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bemutatkozás"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Ország"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Megjelenített név"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Hely"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Koppints a cseréhez"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Webhely"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-értesítések"),
      "quote": MessageLookupByLibrary.simpleMessage("Idézés"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Bejegyzés idézése"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Kapcsolat egy emberrel"),
      "remove": MessageLookupByLibrary.simpleMessage("Eltávolítás"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Törlöd ezt a beszélgetést?"),
      "removeMember": (Object a0) => "Eltávolítod: ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Törlöd ezt az üzenetet?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Válaszok, követések és említések"),
      "repliesPolicy": (Object a0) => "Válaszok: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Válasz"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Bárki csatlakozhat"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Bárki továbbra is láthatja, megoszthatja és idézheti ezt a bejegyzést."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "A Kyronon bárki válaszolhat erre a bejegyzésre."),
      "reply_followers": MessageLookupByLibrary.simpleMessage("Akik követnek"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Csak a követőid válaszolhatnak erre a bejegyzésre."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Akiket megemlítesz"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Csak azok válaszolhatnak, akiket @megemlítesz ebben a bejegyzésben."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Senki sem válaszolhat"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "A válaszok ki vannak kapcsolva. Te azért válaszolhatsz."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Ki válaszolhat?"),
      "report": MessageLookupByLibrary.simpleMessage("Jelentés"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Jelentés másolva. Illeszd be egy e-mailbe a támogatásnak."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Jelentés elküldve"),
      "repost": MessageLookupByLibrary.simpleMessage("Megosztás újra"),
      "reset": MessageLookupByLibrary.simpleMessage("Visszaállítás"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Jelszó visszaállítása"),
      "retry": MessageLookupByLibrary.simpleMessage("Újra"),
      "save": MessageLookupByLibrary.simpleMessage("Mentés"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Piszkozat mentése"),
      "saySomething": (Object a0) => "Mondj valamit itt: ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Keresés"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Keresés név vagy felhasználónév alapján"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Közösségek keresése"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF-ek keresése"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("Nyelvek keresése"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Népszerű címkék keresése"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Biztonsági riasztások és fiókváltozások"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Válaszd ki az alkalmazás felületének nyelvét."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Válaszd ki, mely nyelvek jelenjenek meg a hírfolyamaidban. Ha egyet sem választasz, minden nyelv megjelenik."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Válaszd ki az elsődleges nyelvet a hírfolyam fordításaihoz."),
      "send": MessageLookupByLibrary.simpleMessage("Küldés"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Megerősítés küldése"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Hibajelentés küldése"),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("Visszajelzés küldése"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Jelentés küldése"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Küldés a támogatásnak"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("Szolgáltatás állapota"),
      "settings": MessageLookupByLibrary.simpleMessage("Beállítások"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Alkalmazásnapló megosztása a támogatással"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Bejelentkezés a Kyronba"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Bejelentkezve mint"),
      "signupFailed": (Object a0) => "Sikertelen regisztráció: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Maradok"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "A Kyron még az elején tart, és a leggyorsabban úgy érheted el azt, aki tényleg ki tudja javítani, ha jegyet nyitsz. Mondd el, mit csináltál, és mi történt."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Az alkalmazásnak még nincs támogatási postafiókja, ezért ez a képernyő oda irányít, amit valóban figyelnek, nem egy semmibe vezető űrlaphoz."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Alkalmazásnapló"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Mondd el, mi hiányzik vagy mi romlott el"),
      "terms": MessageLookupByLibrary.simpleMessage("Felhasználási feltételek"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Szöveg, hang és videó, az alkotóik, és a szobák, ahol beszélgetnek."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "A szerkesztőben nincs Közzététel gomb"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Sötét"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Mindig sötét"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Tompa"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Lágyabb sötét, fekete helyett kékesszürke"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Világos"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Mindig világos"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Rendszer"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "A telefon világos vagy sötét beállítását követi"),
      "translate": MessageLookupByLibrary.simpleMessage("Fordítás"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "A fordítás még nem működik. A hírfolyamban még semmi sincs lefordítva; ezt addig megjegyezzük."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Ez megváltoztatja a Kyron saját szövegeit, a felület azon részeit, amelyeket a Flutter maga rajzol, a dátumokat és számokat, valamint az alkalmazás elrendezési irányát a jobbról balra írt nyelveknél."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Próbáld újra"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Adatvédelmi irányelvek"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Felhasználási feltételek"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Fiók"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Után"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Alkalmazás és eszköz"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Az átverést azért idéztem, hogy figyelmeztessem az embereket."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Írd le, miért gondolod, hogy a döntés hibás volt: mit jelentett a bejegyzés, mit hagyhatott figyelmen kívül a csapat, vagy miért nem illik rá a szabály. Nem az olvassa, aki döntött."),
      "ui_appeal_label":
          MessageLookupByLibrary.simpleMessage("A fellebbezésed"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Írj legalább \$count karaktert. Minden döntés ellen egyszer fellebbezhetsz."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Fellebbezés küldése"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Fellebbezés elküldve. Értesítést kapsz, amikor döntés születik."),
      "ui_appeal_title": MessageLookupByLibrary.simpleMessage(
          "Fellebbezés a(z) \$number. ügyben"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Megjelenés"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Világos, sötét vagy a telefon szerint"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Előtt"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Nem fogjátok látni egymást a Kyronon, és a köztetek lévő követések megszűnnek. Erről nem kap értesítést."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Tartalmazza"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Mire való (nem kötelező)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Csak moderátorok írhatnak"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Közleményekhez. A közösségben mindenki továbbra is olvashat és reagálhat."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Fotó vagy szavazás hozzáadása"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Fotók és videók"),
      "ui_cchat_close":
          MessageLookupByLibrary.simpleMessage("Csevegés lezárása"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Senki sem fog tudni olvasni vagy írni benne. Ez nem vonható vissza."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Lezárod ezt a csevegést?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Másolva"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Az üzenet mindenki számára eltűnik. A Kyron megőriz egy másolatot ellenőrzésre."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Az üzenet a csevegésben mindenki számára eltűnik."),
      "ui_cchat_edit":
          MessageLookupByLibrary.simpleMessage("Csevegés szerkesztése"),
      "ui_cchat_edit_message":
          MessageLookupByLibrary.simpleMessage("Szerkesztés"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("szerkesztve"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Szerkeszted az üzenetedet"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült megnyitni ezt a csevegést."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Csevegések"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Csatlakozás a csevegéshez"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Csatlakozz a közösséghez, hogy lásd a csevegéseit és részt vehess bennük."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count csatlakozott"),
      "ui_cchat_leave":
          MessageLookupByLibrary.simpleMessage("Kilépés a csevegésből"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Amíg a közösség tagja vagy, továbbra is olvashatod."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Itt csak a tulajdonos és a moderátorok írhatnak."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Némítás"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Nem kapsz róla értesítést, és nem számít bele az Üzenetek számába."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Csevegés neve"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Új csevegés"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Még nincsenek csevegések."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Még nincsenek csevegések. Nyiss egyet a közösségnek."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "A közösségi csevegések nem végpontok közötti titkosításúak. A közösség moderátorai és a Kyron olvashatják őket."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Kitűzés felülre"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Válasz hozzáadása"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Szavazás lezárása"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Lezárva"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Mindenki látja, hányan választották az egyes válaszokat, de azt soha, hogy kik."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Több választás engedélyezése"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Új szavazás"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Válassz egyet"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("\$n. válasz"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Szavazás: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Kérdés"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Minden válasz csak egyszer szerepelhet egy szavazásban."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Válassz egyet vagy többet"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count válaszolt"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Keresés ebben a csevegésben"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Keresés ebben a csevegésben"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Nincs találat."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Ezt a csevegést már nem láthatod."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Lassú mód"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Mennyit kell várni két üzenet között. A moderátorokra nem vonatkozik."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 óra"),
      "ui_cchat_slow_minutes": MessageLookupByLibrary.simpleMessage("\$n perc"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Lassú mód: \$seconds másodpercenként egy üzenet"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Ki"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n másodperc"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Nézőként olvashatsz és reagálhatsz. Csatlakozz, hogy írhass."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Ez az üzenet túl régi ahhoz, hogy megjelenítsük."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Valami, amit kiválasztottál, túl nagy a küldéshez, ezért kimaradt."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Némítás feloldása"),
      "ui_cchat_unpin":
          MessageLookupByLibrary.simpleMessage("Kitűzés megszüntetése"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Hangüzenet felvétele"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Te"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Közösségek"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Mire szolgál? (nem kötelező)"),
      "ui_community_posts":
          MessageLookupByLibrary.simpleMessage("Bejegyzések:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Tartalom és megjelenítés"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a hírfolyamot"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a kedvelt bejegyzéseidet"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a profilodat"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a mentett bejegyzéseidet"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Decentralizált azonosító"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Hibaelhárítás"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Csoportok"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("Nincsenek csoportok"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Itt láthatod a csoportokat, amelyeknek tagja vagy, és a közösségi csevegéseket, amelyekhez csatlakozol."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Legfeljebb \$count csevegést tűzhetsz ki. Előbb vegyél le egyet."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Kitűzve"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Kedvelt"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Mentett"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Még nincs itt semmi"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Kövess néhány fiókot, és a bejegyzéseik itt jelennek meg."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Semmi a követetteidtől"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "A bejegyzések itt jelennek meg, ahogy az emberek megírják őket."),
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("Halványul"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Nem érdekel"),
      "ui_feed_signal_more": MessageLookupByLibrary.simpleMessage("Több ilyet"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Eltávolítva"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("A hírfolyamod jelzései"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Koppints egy bejegyzésen a Több ilyen bejegyzés vagy a Nem érdekel lehetőségre, és itt megjelenik."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Még nincs itt semmi"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Amit a Több ilyet és a Nem érdekel mond a hírfolyamaidnak"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Ezek alakítják a Kezdőlapot és a Felfedezést, főleg aszerint, miről szólt egy bejegyzés. Mindegyik havonta a felére gyengül, és hat hónap után már nem számít. Távolíts el egyet, hogy most leállítsd."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "A klipet tartalmazó bejegyzések itt jelennek meg."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Még nincsenek videók"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Visszajelzés"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Emberek keresése a Kyronon"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Egy fióktól"),
      "ui_group_add":
          MessageLookupByLibrary.simpleMessage("Személyek hozzáadása"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Hozzáadás"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Csoportnév hozzáadása"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Elutasítás"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "A csoport üzenetei végpontok között titkosítottak, mint bármely más beszélgetés."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor hozzáadta: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor adminná tette: \$users"),
      "ui_group_event_created": MessageLookupByLibrary.simpleMessage(
          "\$actor létrehozta a csoportot"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor beállította, hogy az újak tagként csatlakozzanak"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor beállította, hogy az újak nézőként csatlakozzanak"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor kilépett"),
      "ui_group_event_member":
          MessageLookupByLibrary.simpleMessage("\$actor taggá tette: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor átadta a tulajdonjogot: \$users"),
      "ui_group_event_removed": MessageLookupByLibrary.simpleMessage(
          "\$actor eltávolította: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor átnevezte a csoportot: \$title"),
      "ui_group_event_spectator":
          MessageLookupByLibrary.simpleMessage("\$actor nézővé tette: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Egy csoportban legfeljebb \$count személy lehet."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Kéz feltéve. Az adminok értesültek."),
      "ui_group_hands": MessageLookupByLibrary.simpleMessage("\$count írna"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Írni szeretnének"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "A később hozzáadottak nézőként csatlakoznak"),
      "ui_group_leave":
          MessageLookupByLibrary.simpleMessage("Kilépés a csoportból"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Eltűnik a listádról, és nem látod, mi hangzik el utána. Valakinek újra hozzá kellene adnia."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Kilépsz ebből a csoportból?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Írás engedélyezése"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Kéz leengedése"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Adminná tétel"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Tulajdonossá tétel"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Nézővé tétel"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count tag"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Tagok"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Csoport neve"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Előbb nevezd el a csoportot."),
      "ui_group_new": MessageLookupByLibrary.simpleMessage(
          "Csoportos csevegés létrehozása"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Egy tulajdonos van. Te admin maradsz."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Tulajdonossá teszed: \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Kéz feltevése"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Eltávolítás a csoportból"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Admin jog elvétele"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Már nem vagy tagja ennek a csoportnak."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Átnevezés"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Adminisztrátor"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Tag"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("Néző"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Nézőként itt olvashatsz és reagálhatsz."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "A nézők olvashatnak, reagálhatnak, és feltehetik a kezüket, hogy írási jogot kérjenek."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Javasoltak"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Profil megtekintése"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("te"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Néző vagy"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Súgó"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Feljegyeztük. Ez segít eldönteni, mit mutassunk neked."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Csatlakozás"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Csatlakozott"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Nyelv"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Válassz nyelvet"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Jogi információk"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Tetszik"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Kedvelt bejegyzések"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "A kedvelt bejegyzéseid itt jelennek meg, a legújabbak elöl."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Link másolva"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Többé nem látod a bejegyzéseit. Erről nem kap értesítést."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Még nincsenek kedvelések"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Egy bejegyzés sem felel meg ezeknek a szűrőknek."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Még nincs mentés"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("A fiókod frissült"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Elfogadtuk a fellebbezésedet a(z) \$number. ügyben"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Újra megvizsgáltuk a fellebbezésedet a(z) \$number. ügyben, és a döntés érvényben marad"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "A fiókodat véglegesen letiltottuk"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("\$number. ügy · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("követ téged"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("kedvelte a bejegyzésedet"),
      "ui_notif_mentioned": MessageLookupByLibrary.simpleMessage("megemlített"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Még nincsenek említések"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Ha valaki beírja a @felhasználóneved egy bejegyzésbe vagy válaszba, itt jelenik meg."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Régebbiek"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Az üzenetedet eltávolítottuk egy közösségi csevegésből"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Eltávolítottunk valamit, amit közzétettél"),
      "ui_notif_removed_post": MessageLookupByLibrary.simpleMessage(
          "A bejegyzésedet eltávolítottuk"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("A válaszodat eltávolítottuk"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("válaszolt a bejegyzésedre"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Intézkedtünk valami miatt, amit jelentettél. Köszönjük, hogy szóltál."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Megvizsgáltunk valamit, amit jelentettél, és nem találtuk, hogy megsértené a szabályainkat."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Jelentés oka: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("megosztotta a bejegyzésedet"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Visszavontuk a(z) \$number. ügyben hozott döntést"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("A fiókod fel van függesztve"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "A fiókod felfüggesztése eddig tart: \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Összes"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Követők"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Kedvelések"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Említések"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Válaszok"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Ezen a héten"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Ma"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "A fiókod figyelmeztetést kapott"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Tegnap"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Kész"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Kihagyás"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Ezt már megnyitották."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Lejárt"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Nem sikerült megnyitni."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Egyszer nyitható meg, utána törlődik a Kyronról."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Egyszeri megtekintés"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Megnyitva"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "Megnyitotta: \$count / \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Csak azok nyithatják meg, akiknek elküldted, egyszer."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Küldés egyszeri megtekintésre"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Koppints a megtekintéshez"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Szünet"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Lejátszás"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Eltávolítjuk a profilodról és mindenki hírfolyamából. A válaszai is eltűnnek vele együtt."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Bejegyzés törölve"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Bejegyzés elrejtve"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Bejegyzés szövege másolva"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Közzétéve ekkor"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Elrejtve. Kevesebb ilyet mutatunk."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Beállítások"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Adatvédelem"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Van, amit hozzátennél? (nem kötelező)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Értesítést kapsz, amikor a csapat döntött, és a Jelentéseid között követheted."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Ha őt sem szeretnéd többé látni, ugyanebben a menüben elnémíthatod vagy letilthatod."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Ha ugyanazt kétszer jelented, attól nem lesz nagyobb súlya: személyenként egy jelentést őrzünk meg."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "A jelentésedet nem osztjuk meg vele. Megőrizzük a jelentett tartalom másolatát, hogy akkor is ellenőrizhető legyen, ha törlik."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "A jelentésedet megkaptuk, és ellenőrzésre vár. Nem mondjuk el neki, ki jelentette."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Jelentéseid megtekintése"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Mondd el, mi a baj"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Köszönjük, hogy szóltál"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Mi a baj vele: \$name?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("Mi a baj ezzel az üzenettel?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Mi a baj ezzel a bejegyzéssel?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("Mi a baj ezzel a válasszal?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Egy üzenet egy közösségi csevegésben"),
      "ui_reports_a_post":
          MessageLookupByLibrary.simpleMessage("Egy bejegyzés"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Egy válasz"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Intézkedtünk"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Egy fiók"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Döntés: \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Nincs szabálysértés"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a jelentéseidet"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Amit az elmúlt 90 napban jelentettél, és mi lett vele. Értesítést kapsz, amikor a csapat dönt. Akit jelentesz, sosem tudja meg, ki jelentette."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Nincs jelentés"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ha jelentesz egy bejegyzést, választ, üzenetet vagy fiókot, itt jelenik meg azzal együtt, hogy mi lett vele."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("Ellenőrzés alatt"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Jelentve: \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Amit jelentettél, és mi lett vele"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Jelentéseid"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Gyermekek biztonsága"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Bármi, ami kiskorút veszélyeztet vagy szexualizál."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Célzott bántalmazás, fenyegetés vagy nem kívánt kapcsolatfelvétel."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Emberek elleni támadás azért, akik."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Valami illegális árusítása vagy reklámozása."),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("Más személynek kiadni magát."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Engedély nélkül használja a művedet vagy a védjegyedet."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Félrevezető állítások egészségről, választásokról vagy eseményekről."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Önsértésre buzdítás vagy annak ábrázolása."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Figyelmeztetés nélkül megjelenő szexuális tartalom."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Egyik sem. Mondd el, mi a baj."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Ismétlődő, félrevezető vagy kéretlen reklám."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Erőszakkal fenyegetés, annak dicsőítése vagy arra uszítás."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Zaklatás vagy megfélemlítés"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Gyűlöletbeszéd"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Illegális áruk vagy szolgáltatások"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Más személy megszemélyesítése"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Szellemi tulajdon"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Hamis információ"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Öngyilkosság vagy önsértés"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Felnőtt tartalom"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Valami más"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Kéretlen tartalom"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Erőszak vagy fenyegetés"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Mentett bejegyzések"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Koppints egy bejegyzés archiválás ikonjára, hogy itt megtartsd. A mentéseidet csak te látod."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Keress felhasználónév vagy megjelenített név alapján."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Törlés"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "Keresés minden közzétett tartalomban"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Szűrők"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("Emberek keresése"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Bejegyzések keresése"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Beállítások"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Alkalmazás és eszköz"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Tartalom és megjelenítés"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Adattakarékosság"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Oszd meg a véleményed"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Súgócikkek böngészése"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Válassz nyelvet"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Kiket némítottál vagy tiltottál le"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Értesítési beállítások"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("Profilod és elérhetőségeid"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Újra be kell jelentkezned, hogy visszatérj a fiókodba."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Biztonsági beállítások"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Jelszó megerősítése"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("Egy sorban"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Új e-mail-cím"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Új jelszó"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Mi történt"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Segítség a csapatunktól"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Megosztás"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Idézés"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Küldés üzenetben"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyronon lévő embereknek"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Bejegyzés megosztása"),
      "ui_standing_about": MessageLookupByLibrary.simpleMessage("Miről szólt"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "A fiókodat véglegesen letiltottuk"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("A válasz, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Fellebbezés"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Fellebbezés a döntés ellen"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "E döntés ellen már nem lehet fellebbezni. Ha valami nincs rendben, fordulj az ügyfélszolgálathoz."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("A fellebbezés elbírálás alatt"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Fellebbezés elfogadva"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "A csapat egy másik tagja újra megvizsgálja. Értesítést kapsz, amikor döntés születik."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Ha szerinted ez tévedés volt, kérheted az újbóli vizsgálatot. Határidő: \$date. A csapat egy másik tagja dönt."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Fellebbezve: a döntés érvényben marad"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "\$number. ügy. Szabály: \$rule. A csapat ezt írta:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "A fiókod törlése nem oldja fel a letiltást: az ugyanazzal az e-mail-címmel létrehozott új fiók is letiltva indul."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Véglegesen letiltva"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Már csak ez az oldal, a fellebbezés, az ügyfélszolgálat és a fiók törlése működik."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Fellebbezhető"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("\$number. ügy"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Döntés: \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("A fiókodat érintő döntések"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Fiók törlése"),
      "ui_standing_details": MessageLookupByLibrary.simpleMessage("Részletek"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Részletek és fellebbezés"),
      "ui_standing_ends": MessageLookupByLibrary.simpleMessage("Lejár: \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("A fiókod rendben van"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Semmi sem korlátozza."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a fiók állapotát"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Üzenet eltávolítva"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "A fiókodról nem született döntés. Ha a csapat valaha eltávolít valamit tőled vagy korlátozza a fiókodat, itt jelenik meg az indoklással együtt, és fellebbezhetsz."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Nincs mit megfellebbezni: a döntést visszavonták."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Bejegyzés eltávolítva"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Húzd le az újbóli ellenőrzéshez."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Olvasd el a Kyron szabályait"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Válasz eltávolítva"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("Visszavonva"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Visszavonva: \$date. Minden eltávolított tartalom visszakerült, és semmilyen korlátozás nem érvényes többé."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Szabály: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("Kijelentkezés"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Felfüggesztve"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Olvashatsz, de nem tehetsz közzé, nem válaszolhatsz, nem követhetsz és nem küldhetsz üzenetet. A jelentés, a letiltás és az elnémítás továbbra is működik."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "A fiókod fel van függesztve: olvashatsz, de nem tehetsz közzé."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Felfüggesztve eddig: \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "A fiókod fel van függesztve eddig: \$date. Olvashatsz, de nem tehetsz közzé."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Mit írt a csapat"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Fiók állapota"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Figyelmeztetés"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Miért?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Ezt írtad, \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Az üzeneted"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("A bejegyzésed"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("A válaszod"),
      "ui_terms":
          MessageLookupByLibrary.simpleMessage("Felhasználási feltételek"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ez a bejegyzés"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Szál némítva"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Próbáld újra"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Hang kikapcsolása"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("Hang bekapcsolása"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Legalább két karakter."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Visszavonás"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Szavak vagy szűrő: fiók, időszak vagy a bejegyzés tartalma."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Megosztás visszavonása"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Jelszó frissítése"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Másik cím használata"),
      "username": MessageLookupByLibrary.simpleMessage("Felhasználónév"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "A felhasználónév csak kisbetűs lehet (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Videó"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Csatolás"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Csatolásra kész"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Hangbejegyzés rögzítése"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Mentés…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Leállítás"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Mi történt"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Mi történt, és mit nézzünk meg?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Mi van ezen a képen?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Mire szolgál? (nem kötelező)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Mit csináltál, mire számítottál, mi történt"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Mit csináltál, amikor történt."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Válaszoltál"),
      "dmReplied": (Object a0) => "$a0 válaszolt",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Hozzáadás az üzenethez"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Új üzenet"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Még semmi sem hangzott el. Egy integetés jó kezdet."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Integetés"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("Új üzenetek"),
      "dmTyping": (Object a0) => "$a0 éppen ír",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Reakciód eltávolítása"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Valaki"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Üzenet"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Melléklet"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Ez az üzenet ezen az eszközön nem olvasható."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Várakozás erre az üzenetre. Ez eltarthat egy ideig."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Titkosított üzenet"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Az üzenetek végpontok közötti titkosítással védettek"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Nincs végpontok közötti titkosítás"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Elküldve"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Látta"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Küldés…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Fénykép készítése"),
      "ui_media_more":
          MessageLookupByLibrary.simpleMessage("További lehetőségek"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Mentés az eszközre"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Megosztás"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Mentés…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Elmentve a fotóid közé"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült menteni. Próbáld újra."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Engedélyezd, hogy a Kyron hozzáadjon a fotóidhoz, hogy ezt elmenthesd."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Minden rendszer működik"),
      "ui_status_uptime":
          MessageLookupByLibrary.simpleMessage("Rendelkezésre állás"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Elmúlt 60 nap"),
      "ui_status_60_days_ago": MessageLookupByLibrary.simpleMessage("60 napja"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Ma"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Adatbázis"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Bejelentkezés"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Legutóbbi incidensek"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Nem volt incidens az elmúlt 60 napban."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Folyamatban"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Nincs adat"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Részletek"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "A Kyron működés közben 5 percenként ellenőrzi magát. A szürke napon nem volt ellenőrzés."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "A rendelkezésre állási előzmények még nem érhetők el."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Néhány rendszerrel problémák vannak"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Hangüzenet felvétele"),
      "voice_ready_send": MessageLookupByLibrary.simpleMessage("Küldésre kész"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Ez az üzenet már nincs itt."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Ugrás az üzenethez"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("Hangüzenet"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("A szerzőnek tetszik"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Fotó vagy klip hozzáadása"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Média"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Hangüzenetek"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Csevegés"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Háttérkép"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Értesítések némítása"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Ne kapj értesítést erről a beszélgetésről"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("Már nem tudnak üzenni neked"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Nincs"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Fotó"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Némítás feloldva."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült eltávolítani. Próbáld újra."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profil"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Némítás feloldása"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Az általad megosztott fotók és klipek itt jelennek meg."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Összes megtekintése"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Fotók és klipek"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Így fog kinézni a csevegésed."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Jól néz ki."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Pára"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Alkony"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Zsálya"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Homok"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Pöttyök"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Alkalmaz"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Jelenlegi"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Küldés előnézet nélkül"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Keresés"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Közzététel"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Írj üzenetet…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Küldés"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Elküldve"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Elküldve, de nem mindenkinek."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült elküldeni. Próbáld újra."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Követő"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Szűrő"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Összes"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Olvasatlan"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Megválaszolatlan"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Elrejtett"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Nincs elrejtett"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "A listádról eltávolított beszélgetések itt várnak, ha vissza szeretnéd őket."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Átkerül az Elrejtettek közé. A másik fél megtartja a sajátját, és visszajön, ha bármelyikőtök újra ír."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Visszahelyezés"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Újra a listádon."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Nincs egyező beszélgetés."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Semmi sem vár rád"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Minden beszélgetés a te szavaddal zárul."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Fénykép"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Fényképek"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Videó"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Még nincsenek üzenetek"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Te:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Tegnap"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Üzenetek"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Üzenetbeállítások"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Adatvédelem"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Olvasási visszaigazolások"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Ha ez ki van kapcsolva, mások nem látják, mikor olvastad az üzeneteiket, és te sem látod, mikor olvasták a tieidet."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Mutassa, amikor gépelsz"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Akinek írsz, látja, hogy éppen írsz."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Hivatkozás-előnézetek"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "A telefonod megnyitja az elküldött hivatkozást az előnézet elkészítéséhez, így a webhely látja a telefonod kérését. A Kyron szervere sosem látja a hivatkozást."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Üzenetértesítések"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Az üzenetek végpontok közötti titkosítással védettek. A Kyron nem tudja elolvasni őket, és ezen semmi sem változtat itt."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Címzett:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Legutóbbiak"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Emberek"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Senki sincs ilyen néven."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Próbaértesítés küldése"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "A Kyron szervere még nincs beállítva értesítések küldésére, így egy sem érkezhet meg. A hiba nálunk van, nem a telefonodban."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Ez a telefon nincs regisztrálva értesítésekre. Ellenőrizd, hogy a telefon beállításaiban engedélyezve vannak-e a Kyron értesítései, majd próbáld újra."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Az értesítést nem sikerült kézbesíteni erre a telefonra. Próbáld újra egy perc múlva."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Elküldve. Néhány másodpercen belül meg kell érkeznie."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Az értesítések működnek."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Még nincsenek bejegyzések"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("Új közösség"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Név"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("A címe a névből készül."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Ezen a címen találják meg:"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Te leszel a tulajdonosa. Képet, borítót és moderátorokat a létrehozása után az oldaláról adhatsz hozzá."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Kezdőlap"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Közösségi bejegyzések a Kezdőlapon"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "A közösségeid bejegyzései a Kezdőlapon is megjelennek. Kikapcsolva itt maradnak a Közösségekben, ahol mindegyik mutatja, mi újság."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("A listád"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Új bejegyzések száma"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Mutassa, hány új bejegyzés van az egyes közösségekben azóta, hogy utoljára megnyitottad."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Általad vezetett közösségek"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Az általad indított vagy moderált közösségek itt szerepelnek."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Tulajdonos"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderátor"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Új bejegyzések"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Általad vezetettek"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Közösségi beállítások"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("Felfedezés"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "Egyetlen közösség sem egyezik."),
      "ui_community_new_none": MessageLookupByLibrary.simpleMessage("Semmi új"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Minden közösség olyan, ahogy hagytad."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Még egyet sem vezetsz"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Nincs már mihez csatlakozni"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "A Kyron minden közösségében benne vagy. Indíts egy újat."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Próbálj másik szót, vagy indíts közösséget ezzel a névvel."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Bejegyzés írása"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Tagok:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Közzétéve"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Megtekintés"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Megnyitás"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Elérhető"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Mutassa, amikor elérhető vagy"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Akiknek üzensz, zöld pöttyöt látnak, amíg nálad nyitva van a Kyron. Ha ez ki van kapcsolva, te sem látod az övékét."),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "Emberek és bejegyzések keresése"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Közösségek, amelyekhez csatlakozhatsz"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Még nincs mit nézni"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Az emberek által közzétett fotók és klipek itt jelennek meg."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Követés"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("Fiók törlése"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Ezzel véglegesen törlöd a Kyron-fiókodat. Nem vonható vissza."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "A profilod, bejegyzéseid, válaszaid, kedveléseid és megosztásaid"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Az üzeneteid, a másoknak küldötteket is beleértve, valamint a bennük lévő fotók és hangüzenetek"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "A követőid, az általad követett emberek és a beállításaid"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Az általad alapított közösségek a legrégebbi moderátorhoz vagy taghoz kerülnek. Az a közösség, amelyben senki más nincs, megszűnik."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Törlöd a fiókodat?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Semmit sem tudsz majd visszaszerezni belőle."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("A fiókodat töröltük."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Törölt fiók"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Ezt a fiókot törölték, ezért ide már nem lehet üzenetet küldeni."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google-lel regisztráltál? Használd inkább a „Sign in with Google” gombot."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Az objektívet nem sikerült betölteni."),
      "ar_could_not_record": MessageLookupByLibrary.simpleMessage(
          "A videót nem sikerült rögzíteni."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Az objektívet nem sikerült hozzáadni a videóhoz, ezért úgy kerül közzé, ahogy felvették."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "A bejegyzésed már a lehető legtöbb mellékletet tartalmazza."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Objektív hozzáadása…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Vaku"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("Videó rögzítése"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Fotó"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Videó"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "A Google-bejelentkezés megszakadt."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("AJÁNDÉKOK"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Még senki sem küldött ajándékot ehhez a bejegyzéshez."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Ajándék"),
      "analytics_gifts_label":
          MessageLookupByLibrary.simpleMessage("Ajándékok"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Érmék"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Küldő"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Küldők"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Tesztérmék: még nem vehetők fel."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Mentett"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Bejegyzések"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Hozzászólások"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("További válaszok"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Szerkesztve"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Továbbiak"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Követettek"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Legjobb"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Legújabb"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage(
          "Hozzászólások rendezése: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "ajándékot küldött a bejegyzésedhez"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "\$gift ajándékot küldött a hozzászólásodhoz"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "\$gift ajándékot küldött a bejegyzésedhez"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Ajándék küldése"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("Bejegyzés szerkesztése"),
      "ui_edit_post_left":
          MessageLookupByLibrary.simpleMessage("Még \$n percig szerkesztheted"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Mentés"),
      "ui_feed_tag_detail":
          MessageLookupByLibrary.simpleMessage("#\$tab alatt még nincs semmi."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Válassz ajándékot"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Nincs elég érme"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Tesztérmék: nem vásárolhatók meg, és nincs pénzbeli értékük."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Feltöltődik: \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 érme"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count érme"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("\$coins van nálad"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift küldése"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift elküldve"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Próbáld újra"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("A közzététel után 15 percig"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Szerkesztve"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni a mentett hozzászólásaidat"),
      "ui_no_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Nincsenek mentett hozzászólások"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Koppints a hozzászólás alatti archívum ikonra, hogy itt megtartsd. Amit mentesz, csak te látod."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Válasz neki: \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Másolás"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Keresés"),
      "ui_select_all":
          MessageLookupByLibrary.simpleMessage("Összes kijelölése"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count ajándék"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 ajándék"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült több bejegyzést betölteni."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Emlékeztetők"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Mi újság, ha egy ideig távol voltál, és mikor kapod vissza az érméidet. Naponta legfeljebb egy."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Ajándékok"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("1 személytől"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count személytől"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("Legnagyobb ajándékozó"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült betölteni, ki küldött ajándékot."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Újdonságok"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Értem"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Köszönjük. Minden választ elolvasunk."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Hogy tetszik eddig a Kyron?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "A teszted \$day. napja. Egy koppintás elég."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Mit javítsunk vagy adjunk hozzá? (nem kötelező)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Küldés"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Most nem"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Nyomd meg újra a Vissza gombot a Kyronból való kilépéshez"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Erősítsd meg, hogy te vagy az"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "A fiókod törléséhez add meg a jelszavad."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "A fiókod törléséhez jelentkezz be újra a Google-lel."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Nem sikerült. Ellenőrizd, és próbáld újra."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Ez az oldal egy másik alkalmazást szeretne megnyitni"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Egy {scheme} hivatkozás megnyitását kéri."),
    };

final messageLookup = MessageLookup();
