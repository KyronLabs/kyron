import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'nl';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Een woord, zin of #tag"),
      "about": MessageLookupByLibrary.simpleMessage("Over"),
      "addAnAnswer":
          MessageLookupByLibrary.simpleMessage("Een antwoord toevoegen"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Meer talen toevoegen…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Akkoord en doorgaan"),
      "alreadyOnKyron": MessageLookupByLibrary.simpleMessage("Al op Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Reacties"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Unieke personen, geen keren geopend"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Betrokkenheid"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Likes"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Nog geen kijkers"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Nog niemand heeft dit bericht geopend."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Geplaatst"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Opgeslagen"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Kijkers"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("KIJKERS PER DAG"),
      "and": MessageLookupByLibrary.simpleMessage("en"),
      "answerNumber": (Object a0) => "Antwoord ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR-lens"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Het systeemlogboek bijvoegen"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Retourtijd"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("TOKENVERIFICATIE"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Nu een uitzending starten zou je in een ruimte zetten waar niemand"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Een community starten"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Waar is het voor? (optioneel)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("weer binnen."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage(
              "weer binnen vanuit deze lijst."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Hem sluiten"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("eerst lid worden"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("binnenkort"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Je plaatst als jezelf"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("plaats in deze community"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Zojuist"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Onderwerp 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Voor jou"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("iets heeft."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("nu onderweg ernaartoe."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", niet"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("beweeg ik"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Geluid uit"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Geluid aan"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Voor jou"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Jouw tabbladen"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Symbool (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("KIJKERS PER DAG"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("kon niet laden"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("dit bericht"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Nog iets toe te voegen? (optioneel)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("dit bericht"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Van een account"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Uitloggen"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Je account"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Wachtwoord bevestigen"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("niet nu"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Laden…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Plaatsen…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 u geleden"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Link naar verhaal kopiëren"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Jouw verhaal"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Je account, je berichten en waar je op tikt, zodat"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Een onderwerp toevoegen"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("zelf."),
      "authorBlocked": (Object a0) => "${a0} geblokkeerd",
      "authorPostsHidden": (Object a0) =>
          "Je ziet geen berichten meer van ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Blokkeren"),
      "blockAuthor": (Object a0) => "${a0} blokkeren?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Build-gegevens gekopieerd"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Door verder te gaan ga je akkoord met onze"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Door verder te gaan ga je akkoord met onze Voorwaarden en ons Privacybeleid"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Door je te registreren ga je akkoord met onze"),
      "cancel": MessageLookupByLibrary.simpleMessage("Annuleren"),
      "change": MessageLookupByLibrary.simpleMessage("Wijzigen"),
      "changeEmail":
          MessageLookupByLibrary.simpleMessage("E-mailadres wijzigen"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Check je e-mail om je account te bevestigen."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Controleren of Kyron bereikbaar is"),
      "clear": MessageLookupByLibrary.simpleMessage("Wissen"),
      "close": MessageLookupByLibrary.simpleMessage("Sluiten"),
      "closeCommunity": (Object a0) => "${a0} sluiten?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Sluiten"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Deze community sluiten"),
      "communities": MessageLookupByLibrary.simpleMessage("Community's"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Vind er een via Ontdekken, of start je eigen."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Gooi een stevige mening eruit (of een lauwe)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Wat spookt er door je hoofd?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Zeg iets wat alleen jij kunt zeggen…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "Dit is je signaal: verstuur het"),
      "composer_placeholder_think":
          MessageLookupByLibrary.simpleMessage("Typ, spreek of denk hardop"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Wachtwoord bevestigen"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Contact opnemen met support"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Berichten hebben nog geen taal, dus dit filtert je feed nog niet. Je keuze wordt bewaard voor later."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Doorgaan"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Doorgaan met e-mail"),
      "copy": MessageLookupByLibrary.simpleMessage("Kopiëren"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Rapport kopiëren"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Kon Google-inloggen niet openen. ${a0}",
      "couldNotSignOut": (Object a0) => "Kon niet uitloggen: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Kon die foto niet maken."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Zichtbaar op je profiel en onder je berichten."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Geen land komt overeen met ‘{query}’."),
      "country_none": MessageLookupByLibrary.simpleMessage("Geen land tonen"),
      "country_search": MessageLookupByLibrary.simpleMessage("Landen zoeken"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Zichtbaar op je profiel en onder je berichten. Als je iemands berichten ziet, telt je land mee in diens Inzichten, alleen in groepen van vijf of meer en nooit bij naam."),
      "country_suggested": MessageLookupByLibrary.simpleMessage(
          "Uit de instellingen van je telefoon"),
      "create": MessageLookupByLibrary.simpleMessage("Maken"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Account maken"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Maak je account"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Maak je profiel"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR-lens"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Live gaan"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("Tekstbericht"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Spraakbericht"),
      "delete": MessageLookupByLibrary.simpleMessage("Verwijderen"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Deze reactie verwijderen?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Dit bericht verwijderen?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Beschrijf deze bijlage"),
      "description": MessageLookupByLibrary.simpleMessage("Beschrijving"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID naar klembord gekopieerd"),
      "done": MessageLookupByLibrary.simpleMessage("Klaar"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Sluit de editor met iets geschreven en je krijgt een concept aangeboden."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} dagen geleden"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} uur geleden"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Zojuist"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} minuten geleden"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Nog niets geschreven"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Een peiling, nog zonder vraag"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Een citaat, nog zonder tekst"),
      "drafts": MessageLookupByLibrary.simpleMessage("Concepten"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Profiel bewerken"),
      "email": MessageLookupByLibrary.simpleMessage("E-mail"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("E-mailmeldingen"),
      "explore": MessageLookupByLibrary.simpleMessage("Verkennen"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Gezichtsherkenning is niet beschikbaar op dit apparaat."),
      "feedTagDetail": (Object a0) => "Er is nog niets geplaatst onder #${a0}.",
      "follow_author": MessageLookupByLibrary.simpleMessage("{name} volgen"),
      "followers": MessageLookupByLibrary.simpleMessage("Volgers"),
      "following": MessageLookupByLibrary.simpleMessage("Volgend"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Wachtwoord vergeten?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Hulp krijgen"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Doorgaan met Google"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Inloggen met Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google geeft de voltooide aanmelding terug aan Kyron via een link waar alleen Android en iOS op reageren, dus op ${a0} kan de browser hem nergens naartoe sturen.\\n\\nHeb je al een Kyron-account via Google, gebruik dan Doorgaan met e-mail met hetzelfde adres en tik op Wachtwoord vergeten: je krijgt een link om er een in te stellen.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Inloggen met Google kan alleen in de telefoonapp"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Registreren met Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Handleidingen en antwoorden op veelgestelde vragen"),
      "handle": MessageLookupByLibrary.simpleMessage("gebruikersnaam"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Hulp en ondersteuning"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Helpcentrum"),
      "home": MessageLookupByLibrary.simpleMessage("Home"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("In één regel"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Je account"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Community openen"),
      "ins_act_post":
          MessageLookupByLibrary.simpleMessage("Schrijf een bericht"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Bericht bekijken"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Je profiel bewerken"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Wanneer ze er zijn"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("In jouw tijdzone."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Leeftijden"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Van de {known} bereikte mensen die een verjaardag hebben opgegeven."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Bereikte mensen per dag"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Community's waarin ze zitten"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Landen"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Van de {known} bereikte mensen die een land op hun profiel hebben."),
      "ins_days":
          MessageLookupByLibrary.simpleMessage("Afgelopen {days} dagen"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Statistieken konden niet worden geladen"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Volgers"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Nog geen groep is groot genoeg om te tonen."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Zo groei je"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Onderwerpen die ze volgen"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Vind-ik-leuks"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Nieuw"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Nieuwe volgers"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Geen van je berichten heeft in deze periode iemand bereikt."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Volgen je niet"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "De landen zijn die mensen op hun profiel hebben gekozen. Kyron verzamelt van niemand de stad of het geslacht, dus daarvoor valt niets te tonen."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Geopend"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} bereikt · {likes} vind-ik-leuks · {replies} reacties"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Bereikte mensen"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Iedereen telt één keer: kreeg een van je berichten voor het eerst te zien of opende het. Nieuwe volgers volgen je nog; ontvolgen wordt niet geteld."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Reacties"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Herposts"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Opgeslagen"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Wie je publiek is, verschijnt zodra {floor} mensen je berichten in deze periode hebben gezien. Bij minder zou het naar iemand kunnen wijzen."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Nog niet genoeg mensen"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% van hen volgt je al: je berichten bereiken vooral mensen die je kennen."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% van hen volgt je nog niet: je berichten worden gevonden."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Je hebt {reach} mensen bereikt, {pct}% minder dan de periode ervoor."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Je hebt de afgelopen {days} dagen {reach} mensen bereikt."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Je hebt {reach} mensen bereikt, ongeveer evenveel als de periode ervoor."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Niemand nieuw heeft je berichten de afgelopen {days} dagen gezien."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Je hebt {reach} mensen bereikt, {pct}% meer dan de periode ervoor."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Je hebt {reach} mensen bereikt, {times}× zoveel als de periode ervoor."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Meer van hen volgen {name} dan enig ander onderwerp."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Publiek"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Overzicht"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Wie een van je berichten vindt, kijkt naar je profiel voordat die je volgt. Een gezicht of logo laat zien dat er iemand is."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Voeg een profielfoto toe"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Zeg in één regel waarover je post, zodat een vreemde weet wat volgen hem oplevert."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Schrijf een bio"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} van je {total} berichten hadden geen onderwerp. Een onderwerp zet een bericht in de feed van dat onderwerp en voor de mensen die het volgen."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Geef je berichten onderwerpen"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} mensen reageerden op je berichten en je beantwoordde er {answered}. Ze vonden het belangrijk genoeg om te schrijven: een antwoord maakt van een lezer een vaste bezoeker."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Beantwoord je reacties"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Je publiek is het actiefst op {when}. Een bericht vlak daarvoor heeft mensen die het opvangen."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Post wanneer ze er zijn"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} mensen die je niet volgen, zagen je berichten, en {gained} gingen je volgen. Laat je bio en je nieuwste berichten zeggen wat ze van je kunnen verwachten."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("Maak lezers volgers"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Eén bericht bereikte {times}× zoveel mensen als je andere meestal doen. Kijk wat het anders deed, en doe daar meer van."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Doe meer van wat werkte"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Veel mensen die je berichten zien, zitten in {name}. Daar posten zet je voor de rest ervan."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Plaatsen in {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Je hebt {posts} keer gepost in {days} dagen. Elk bericht is een nieuwe kans om gevonden te worden, en een vast ritme houdt je in de feeds van je volgers."),
      "ins_tip_post_more_t": MessageLookupByLibrary.simpleMessage("Post vaker"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Je hebt de afgelopen {days} dagen niets geplaatst. Zonder bericht bereikt niets iemand."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Plaats iets"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Statistieken"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Topberichten"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Vergeleken met de {days} dagen ervoor"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Een interesse toevoegen"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Sleep om te ordenen"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "De balk kan hooguit vijf tabbladen bevatten. Verwijder er een om een ander toe te voegen."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Volgend"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Voor jou"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Hashtags verschijnen hier zodra mensen ze gaan gebruiken."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Nu trending"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Video's"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Jouw tabbladen"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
          "Het verdwijnt voor jullie allebei."),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
          "Het wordt uit de discussie verwijderd."),
      "join": MessageLookupByLibrary.simpleMessage("Lid worden"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Verder bewerken"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "De schermen van Kyron zijn in jouw taal. Klinkt een woord verkeerd, laat het ons weten via Feedback versturen."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Talen"),
      "leave": MessageLookupByLibrary.simpleMessage("Verlaten"),
      "leaveCommunity": (Object a0) => "${a0} verlaten?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Weer toelaten"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("1 pagina open"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Een clip toevoegen"),
      "literaladdAGif":
          MessageLookupByLibrary.simpleMessage("Een GIF toevoegen"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Een hashtag toevoegen"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Een foto toevoegen"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Een peiling toevoegen"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Een video toevoegen"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Een interesse toevoegen"),
      "literaladdLabelAsATab": (Object a0) => "${a0} als tabblad toevoegen",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Taal van de app"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("App-versie"),
      "literalblockAuthor": (Object a0) => "${a0} blokkeren",
      "literalblockAuthor2": (Object a0) => "${a0} blokkeren?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Dit account blokkeren?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Reactie annuleren"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Opnieuw controleren"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Kiezen uit galerij"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Cache wissen"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Alle pagina's sluiten"),
      "literalcloseTabLabel": (Object a0) => "${a0} sluiten",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("De browser sluiten"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0} sluiten?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Contact met ondersteuning"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Inhoudstalen"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Link kopiëren"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Link naar bericht kopiëren"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Berichttekst kopiëren"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Tekst kopiëren"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("Kon community's niet laden"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Kon GIF's niet laden"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("Kon meldingen niet laden"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("Kon de leden niet laden"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("Kon deze berichten niet laden"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("Kon dit gesprek niet laden"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("Kon deze lijst niet laden"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("Kon dit bericht niet laden"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("Kon deze reactie niet laden"),
      "literalcouldNotLoadTrendingTags":
          MessageLookupByLibrary.simpleMessage("Kon trending tags niet laden"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage("Kon je community's niet laden"),
      "literalcouldNotLoadYourMessages":
          MessageLookupByLibrary.simpleMessage("Kon je berichten niet laden"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Kon deze community niet openen"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Kon die reactie niet plaatsen."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Kon niet zoeken"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Kon niet uitloggen: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} pagina's open",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Omslagfoto"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("Databesparing"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Bericht verwijderen"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Mensen ontdekken"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("Niet reageren"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Concept opgeslagen"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Feedback kan nu niet worden verstuurd"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Tekstgrootte"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF's zijn niet ingesteld"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Doorgeven aan een andere app"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Wachtwoord verbergen"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Dit bericht verbergen"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Verbergt het en vertelt ons minder van dit soort te tonen"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Hoe je je gedraagt"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("Blijf typen"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron gaf geen antwoord"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0}-datum",
      "literalleaveCommunityName": (Object a0) => "${a0} verlaten?",
      "literallensNameFaceLens": (Object a0) => "${a0}, gezichtslens",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Gelikete berichten"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Link gekopieerd"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Moderator maken"),
      "literalmuteAuthor": (Object a0) => "${a0} dempen",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Deze discussie dempen"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Woorden of tags dempen"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Gedempte en geblokkeerde accounts"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Gedempt. Je krijgt geen meldingen."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Geen app op dit apparaat opent ${a0}-links.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Geen browser op dit apparaat nam die link aan."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Nog geen DID"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Geen concepten"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Nog geen interesses"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Nog geen likes"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Nog geen berichten"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Geen nieuwe volgers"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Nog geen berichten"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Nog geen reacties"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Nog geen reposts"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Geen trending tag komt overeen"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Niemand gevonden"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Niemand is verwijderd"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Hier is nog niemand"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Niet geïnteresseerd"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Niets gevonden"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Er is nog niets trending"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Nog niets gelogd"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Niets gevonden"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Niets gedempt"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Nog niets te zien"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Niets ongelezen"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Alleen de eigenaar kan dit wijzigen"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Reactie openen"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Open de e-mail van Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Wachtwoord en inloggen"),
      "literalpostInCommunityName": (Object a0) => "Plaatsen in ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Plaatsen in ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Plaats het met je eigen woorden erboven"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Hoofdtaal"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Pushmeldingen"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Lezen…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Een spraakbericht opnemen"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Opnieuw opnemen"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Als moderator verwijderen"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Uit community verwijderen"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Uit opgeslagen verwijderen"),
      "literalremoveLabel": (Object a0) => "${a0} verwijderen",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0} verwijderen",
      "literalremoveMemberDisplayname": (Object a0) => "${a0} verwijderen?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("De peiling verwijderen"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Dit antwoord verwijderen"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Dit gesprek verwijderen"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Deze peiling verwijderen"),
      "literalreportAuthor": (Object a0) => "${a0} melden",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Bericht melden"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Code opnieuw versturen"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Opgeslagen berichten"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("Zeg iets"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Zeg iets tegen ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Zoeken mislukt"),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("Opnieuw versturen"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "Opnieuw versturen over ${a0} s",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Feedback versturen"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("De link versturen"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Verstuurd. Het is rapport #${a0}.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "Stel een wachtwoord in en ga verder"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Het logboek met de ondersteuning delen"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Deze community delen"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Deze pagina delen"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Dit profiel delen"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Delen via…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Delen met een citaat"),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
          "Meer berichten zoals dit tonen"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Wachtwoord tonen"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Resultaten tonen"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Een community starten"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Opname starten"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Laden stoppen"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Dit bericht en de reacties erop niet meer zien"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Verhalenbalk, ${a0} items",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Camera wisselen"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Iemand taggen"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Een foto maken"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Tik op de banner of de afbeelding om die te wijzigen"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Tik op de link erin"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Tik om een foto en omslag toe te voegen"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Dat lukte niet. Probeer het opnieuw."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Die GIF kon niet worden gedownload."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Die link kan hier niet worden geopend."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("De camera is gesloten"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Deze community"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Deze reactie is weg"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Bericht vertalen"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("Geluid uit"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("Geluid aan"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Een van de onze gebruiken"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Verificatiecode opnieuw verstuurd."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Verificatie mislukt: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("E-mailadres verifiëren"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Kijkers, likes, opgeslagen en reacties"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Wat Kyron bewaart"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Wat deze app heeft gedaan"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Wat je deed, wat je verwachtte, wat er gebeurde "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Wat je plaatst is van jou"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Of Kyron nu bereikbaar is"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Wie kan reageren"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Wie wil je taggen?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Je volgt al alle trending tags"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Je bent helemaal bij"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Je zit in geen enkele community"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Je bent uitgelogd."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) =>
          "Je hebt ${a0} verlaten",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Je hebt nog niets geplaatst"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Meer laden"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Logboek gewist"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Logboek gekopieerd"),
      "logIn": MessageLookupByLibrary.simpleMessage("Inloggen"),
      "logOut": MessageLookupByLibrary.simpleMessage("Uitloggen"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Uitloggen?"),
      "login": MessageLookupByLibrary.simpleMessage("Inloggen"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Inloggen mislukt. Controleer je gegevens."),
      "manage": MessageLookupByLibrary.simpleMessage("Beheren"),
      "menu": MessageLookupByLibrary.simpleMessage("Menu"),
      "message": MessageLookupByLibrary.simpleMessage("Bericht"),
      "messages": MessageLookupByLibrary.simpleMessage("Berichten"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "Alle gesprekken zijn bijgewerkt."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Open iemands profiel en tik op Bericht om een gesprek te beginnen."),
      "mute": MessageLookupByLibrary.simpleMessage("Dempen"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Gedempt en geblokkeerd"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Gedempte woorden en tags"),
      "name": MessageLookupByLibrary.simpleMessage("Naam"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name>-scherm"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Nieuw e-mailadres"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Nieuw wachtwoord"),
      "newPost": MessageLookupByLibrary.simpleMessage("Nieuw bericht"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Niet nu"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Niet verstuurd. Tik om opnieuw te proberen"),
      "nothingMatchesQuery": (Object a0) =>
          "Niets op Kyron komt overeen met \"${a0}\"",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Niets om te kopiëren"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Likes, reacties en nieuwe volgers komen hier binnen."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Mensen die je volgen verschijnen hier."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Als iemand een van je berichten liket, zie je dat hier."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Reacties op je berichten komen hier."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Als iemand je repost, zie je dat hier."),
      "notifications": MessageLookupByLibrary.simpleMessage("Meldingen"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Openen in browser"),
      "or": MessageLookupByLibrary.simpleMessage("of"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Pagina niet gevonden"),
      "password": MessageLookupByLibrary.simpleMessage("Wachtwoord"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Wachtwoord te kort"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Kies je interesses"),
      "post": MessageLookupByLibrary.simpleMessage("Plaatsen"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Berichtstatistieken"),
      "postInCommunity": (Object a0) => "Plaatsen in ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
          "Plaats het, zeg het, laat het zien."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Berichttekst gekopieerd"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacybeleid"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profiel bijgewerkt"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Land"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Weergavenaam"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Locatie"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Tik om te wijzigen"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Website"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Pushmeldingen"),
      "quote": MessageLookupByLibrary.simpleMessage("Citeren"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Bericht citeren"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Een mens bereiken"),
      "remove": MessageLookupByLibrary.simpleMessage("Verwijderen"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Dit gesprek verwijderen?"),
      "removeMember": (Object a0) => "${a0} verwijderen?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Dit bericht verwijderen?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Reacties, volgers en vermeldingen"),
      "repliesPolicy": (Object a0) => "Reacties: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Reageren"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Iedereen kan reageren"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Iedereen kan dit bericht nog steeds zien, reposten en citeren."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Iedereen op Kyron kan op dit bericht reageren."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Mensen die je volgen"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Alleen mensen die je volgen kunnen op dit bericht reageren."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Mensen die je noemt"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Alleen de mensen die je in dit bericht @noemt kunnen reageren."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Niemand kan reageren"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Reacties staan uit. Jij kunt nog steeds reageren."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Wie kan reageren?"),
      "report": MessageLookupByLibrary.simpleMessage("Melden"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Rapport gekopieerd. Plak het in een e-mail aan de ondersteuning."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Melding verstuurd"),
      "repost": MessageLookupByLibrary.simpleMessage("Reposten"),
      "reset": MessageLookupByLibrary.simpleMessage("Resetten"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Je wachtwoord resetten"),
      "retry": MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "save": MessageLookupByLibrary.simpleMessage("Opslaan"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Concept opslaan"),
      "saySomething": (Object a0) => "Zeg iets tegen ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Zoeken"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Zoeken op naam of gebruikersnaam"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Community's zoeken"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF's zoeken"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Talen zoeken"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Trending tags zoeken"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Beveiligingsmeldingen en accountwijzigingen"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Kies de taal van de app-interface."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Kies welke talen je feeds moeten bevatten. Als je er geen kiest, worden alle talen getoond."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Kies je voorkeurstaal voor vertalingen in je feed."),
      "send": MessageLookupByLibrary.simpleMessage("Versturen"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Bevestiging versturen"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Foutrapport versturen"),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("Feedback versturen"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Melding versturen"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Naar ondersteuning sturen"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Servicestatus"),
      "settings": MessageLookupByLibrary.simpleMessage("Instellingen"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Het app-logboek met de ondersteuning delen"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Inloggen bij Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Ingelogd als"),
      "signupFailed": (Object a0) => "Registreren mislukt: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Blijven"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron is jong, en de snelste manier om iemand te bereiken die een probleem kan oplossen, is een issue openen. Vermeld wat je deed en wat er in plaats daarvan gebeurde."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Er is nog geen ondersteuningsinbox in de app, dus dit scherm wijst naar de plek die echt wordt gevolgd in plaats van naar een formulier dat nergens heen gaat."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Systeemlogboek"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Vertel ons wat ontbreekt of kapot is"),
      "terms": MessageLookupByLibrary.simpleMessage("Voorwaarden"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Tekst, spraak en video, de mensen die ze maken en de ruimtes waarin ze praten."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "De editor heeft geen knop Plaatsen"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Donker"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Altijd donker"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Gedimd"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Een zachter donker, blauwgrijs in plaats van zwart"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Licht"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Altijd licht"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Systeem"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "De lichte of donkere instelling van de telefoon volgen"),
      "translate": MessageLookupByLibrary.simpleMessage("Vertalen"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Vertalen bestaat nog niet. Er wordt nog niets in je feed vertaald; dit wordt bewaard voor later."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Dit verandert de woorden van Kyron, de delen van de interface die Flutter zelf tekent, datums en getallen, en de richting waarin de app wordt opgemaakt voor talen die van rechts naar links lezen."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Privacybeleid"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Servicevoorwaarden"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Account"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Na"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("App en apparaat"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Ik citeerde de oplichting om mensen te waarschuwen."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Leg uit waarom je denkt dat de beslissing verkeerd was: wat de post bedoelde, wat het team misschien heeft gemist of waarom de regel niet past. Iemand anders dan degene die besliste leest het."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Je bezwaar"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Schrijf minstens \$count tekens. Je kunt tegen elke beslissing één keer bezwaar maken."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Bezwaar versturen"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Bezwaar verstuurd. Je krijgt een melding zodra er is beslist."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Bezwaar tegen zaak \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Weergave"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Licht, donker of wat de telefoon gebruikt"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Voor"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Jullie zien elkaar niet meer op Kyron en een eventuele volgrelatie wordt verwijderd. Diegene krijgt geen melding."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Met"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Waar hij voor is (optioneel)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Alleen moderators kunnen schrijven"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Voor aankondigingen. Iedereen in de community kan nog steeds lezen en reageren."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Foto of poll toevoegen"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Foto's en video's"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Chat sluiten"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Niemand kan er nog in lezen of schrijven. Dit kan niet ongedaan worden gemaakt."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Deze chat sluiten?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Gekopieerd"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Het bericht wordt voor iedereen verwijderd. Kyron bewaart een kopie voor beoordeling."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Het bericht wordt voor iedereen in de chat verwijderd."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Chat bewerken"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Bewerken"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("bewerkt"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Je bewerkt je bericht"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Kan deze chat niet openen."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Chats"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Deelnemen aan chat"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Word lid van de community om de chats te zien en mee te doen."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count deelnemers"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Chat verlaten"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Je kunt hem blijven lezen zolang je in de community zit."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Alleen de eigenaar en moderators kunnen hier schrijven."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Dempen"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Geen meldingen hiervan, en de chat telt niet mee bij Berichten."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Naam van de chat"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Nieuwe chat"),
      "ui_cchat_none": MessageLookupByLibrary.simpleMessage("Nog geen chats."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Nog geen chats. Open er een voor de community."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Communitychats zijn niet end-to-end versleuteld. De moderators van de community en Kyron kunnen ze lezen."),
      "ui_cchat_pin":
          MessageLookupByLibrary.simpleMessage("Bovenaan vastzetten"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Antwoord toevoegen"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Poll sluiten"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Gesloten"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Iedereen ziet hoeveel mensen elk antwoord kozen, nooit wie."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Meerdere keuzes toestaan"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Nieuwe poll"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Kies er één"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Antwoord \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Peiling: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Vraag"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Elk antwoord mag maar één keer in een poll staan."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Kies er één of meer"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count hebben geantwoord"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Zoeken in deze chat"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Zoeken in deze chat"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Niets gevonden."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Je kunt deze chat niet meer zien."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Langzame modus"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Hoe lang mensen wachten tussen berichten. Niet voor moderators."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 uur"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minuten"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Langzame modus: één bericht per \$seconds seconden"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Uit"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n seconden"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Je kunt als toeschouwer lezen en reageren. Doe mee om te schrijven."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Dat bericht ligt te ver terug om te tonen."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Iets wat je koos is te groot om te versturen en is weggelaten."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Dempen opheffen"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Losmaken"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Spraakbericht opnemen"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Jij"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Community's"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Waar is het voor? (optioneel)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Berichten:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Inhoud en weergave"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("Kon je feed niet laden"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Kon je gelikete berichten niet laden"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("Kon je profiel niet laden"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Kon je opgeslagen berichten niet laden"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Gedecentraliseerde ID"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnose"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Groepen"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Geen groepen"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Groepen waar je in zit en communitychats waar je lid van wordt, staan hier."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Je kunt maximaal \$count chats vastzetten. Maak er eerst een los."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Vastgezet"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Vind ik leuk"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Opgeslagen"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Hier is nog niets"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Volg een paar accounts en hun berichten verschijnen hier."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "Niets van de mensen die je volgt"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Berichten verschijnen hier zodra mensen ze schrijven."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Vervaagt"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Niet geïnteresseerd"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Meer zoals dit tonen"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Verwijderd"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Je feedsignalen"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Tik bij een bericht op Meer berichten zoals dit tonen of Niet geïnteresseerd hierin, en het verschijnt hier."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Nog niets hier"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Wat Meer tonen en Niet geïnteresseerd je feeds vertellen"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Ze bepalen Home en Ontdekken, vooral naar het onderwerp van elk bericht. Elk signaal wordt elke maand half zo sterk en telt na zes niet meer mee. Verwijder er een om het nu te stoppen."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Berichten met een clip verschijnen hier."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Nog geen video's"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Mensen vinden op Kyron"),
      "ui_from_account":
          MessageLookupByLibrary.simpleMessage("Van een account"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Mensen toevoegen"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Toevoegen"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Groepsnaam toevoegen"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Afwijzen"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Berichten in deze groep zijn end-to-end versleuteld, net als elk ander gesprek."),
      "ui_group_event_added": MessageLookupByLibrary.simpleMessage(
          "\$actor heeft \$users toegevoegd"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor heeft \$users beheerder gemaakt"),
      "ui_group_event_created": MessageLookupByLibrary.simpleMessage(
          "\$actor heeft de groep gemaakt"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor laat nieuwe mensen meedoen als lid"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor laat nieuwe mensen meedoen als toeschouwer"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor is vertrokken"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor heeft \$users lid gemaakt"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor heeft \$users eigenaar gemaakt"),
      "ui_group_event_removed": MessageLookupByLibrary.simpleMessage(
          "\$actor heeft \$users verwijderd"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor heeft de groep hernoemd naar \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor heeft \$users toeschouwer gemaakt"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Een groep kan maximaal \$count mensen hebben."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Hand opgestoken. De beheerders weten het."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count willen schrijven"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Willen schrijven"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Mensen die later worden toegevoegd, doen mee als toeschouwer"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Groep verlaten"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Hij verdwijnt uit je lijst en je ziet niet wat er daarna wordt gezegd. Iemand zou je opnieuw moeten toevoegen."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Deze groep verlaten?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Laten schrijven"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Hand laten zakken"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Beheerder maken"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Eigenaar maken"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Toeschouwer maken"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count leden"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Leden"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Groepsnaam"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Geef de groep eerst een naam."),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("Groepschat maken"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Er is één eigenaar. Je blijft beheerder."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("\$name eigenaar maken?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Hand opsteken"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Uit groep verwijderen"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Als beheerder verwijderen"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Je zit niet meer in deze groep."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Hernoemen"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Beheerder"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Lid"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Toeschouwer"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Als toeschouwer kun je hier lezen en reageren."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Toeschouwers kunnen lezen, reageren en hun hand opsteken om te vragen of ze mogen schrijven."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Voorgesteld"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Profiel bekijken"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("jij"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Je bent toeschouwer"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Hulp"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Genoteerd. Dit helpt bepalen wat je te zien krijgt."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Lid worden"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Lid"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Taal"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Kies je taal"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Juridisch"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Liken"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Gelikete berichten"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Berichten die je liket verschijnen hier, de nieuwste eerst."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Link gekopieerd"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Je ziet hun berichten niet meer. Diegene krijgt geen melding."),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage("Nog geen likes"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Geen berichten komen overeen met die filters."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Nog niets opgeslagen"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Je account is bijgewerkt"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Je bezwaar tegen zaak \$number is toegekend"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "We hebben je bezwaar tegen zaak \$number opnieuw bekeken en het besluit blijft staan"),
      "ui_notif_banned":
          MessageLookupByLibrary.simpleMessage("Je account is verbannen"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Zaak \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("volgt je nu"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("vindt je post leuk"),
      "ui_notif_mentioned": MessageLookupByLibrary.simpleMessage("noemde je"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Nog geen vermeldingen"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Als iemand je @gebruikersnaam in een bericht of reactie schrijft, zie je dat hier."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Ouder"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Je bericht in een communitychat is verwijderd"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Iets wat je hebt geplaatst is verwijderd"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Je post is verwijderd"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Je reactie is verwijderd"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("heeft op je post gereageerd"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "We hebben actie ondernomen op iets wat je hebt gemeld. Bedankt dat je het ons liet weten."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "We hebben iets bekeken wat je hebt gemeld en vonden niet dat het onze regels overtrad."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Gemeld voor: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("heeft je post gedeeld"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "We hebben zaak \$number teruggedraaid"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Je account is geschorst"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Je account is geschorst tot \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Alles"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Volgers"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Likes"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Vermeldingen"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Reacties"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Deze week"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Vandaag"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Je account heeft een waarschuwing"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Gisteren"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Voltooien"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Overslaan"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Dit is al geopend."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Verlopen"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Dit kon niet worden geopend."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Gaat één keer open en wordt daarna van Kyron verwijderd."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Eén keer bekijken"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Geopend"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "Geopend door \$count van \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Alleen de mensen naar wie je dit stuurde, kunnen het openen, één keer."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Verstuur om één keer te bekijken"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Tik om te bekijken"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pauzeren"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Afspelen"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Het wordt van je profiel en uit ieders feed verwijderd. Reacties erop gaan mee."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Bericht verwijderd"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Bericht verborgen"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Berichttekst gekopieerd"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Geplaatst tussen"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Verborgen. We tonen je minder van dit soort."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Voorkeuren"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Nog iets toe te voegen? (optioneel)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Je krijgt een melding als het team heeft besloten, en je kunt het volgen in Je meldingen."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Wil je die persoon ook niet meer zien? Demp of blokkeer via hetzelfde menu."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Hetzelfde twee keer melden geeft het niet meer gewicht: we bewaren één melding per persoon."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Je melding wordt niet met die persoon gedeeld. We bewaren een kopie van wat je hebt gemeld, zodat het ook na verwijdering nog beoordeeld kan worden."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Je melding is ontvangen en staat in de wachtrij voor beoordeling. We vertellen die persoon niet wie het heeft gemeld."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Je meldingen bekijken"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Vertel ons wat er mis is"),
      "ui_report_thanks": MessageLookupByLibrary.simpleMessage(
          "Bedankt dat je het ons laat weten"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Wat is er mis met \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Wat is er mis met dit bericht?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("Wat is er mis met deze post?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Wat is er mis met deze reactie?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Een bericht in een communitychat"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Een post"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Een reactie"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Actie ondernomen"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("Een account"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Besloten op \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Geen regel overtreden"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Je meldingen konden niet worden geladen"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Wat je de afgelopen 90 dagen hebt gemeld en wat ermee is gebeurd. Je krijgt een melding als het team besluit. Wie je meldt, krijgt nooit te horen wie hem heeft gemeld."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Niets gemeld"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Als je een post, een reactie, een bericht of een account meldt, staat het hier met wat ermee is gebeurd."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("Wordt beoordeeld"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Gemeld op \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Wat je hebt gemeld en wat ermee is gebeurd"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Je meldingen"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Veiligheid van kinderen"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Alles wat een minderjarige in gevaar brengt of seksualiseert."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Gericht misbruik, bedreigingen of ongewenst contact."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Aanvallen op mensen om wie ze zijn."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Iets illegaals verkopen of promoten."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Zich voordoen als iemand anders."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Gebruikt je werk of handelsmerk zonder toestemming."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Misleidende beweringen over gezondheid, verkiezingen of gebeurtenissen."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Zelfbeschadiging aanmoedigen of tonen."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Seksuele inhoud zonder waarschuwing."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Geen van deze. Vertel ons wat er mis is."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Herhaalde, misleidende of ongewenste promotie."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Dreigen met, verheerlijken van of aanzetten tot geweld."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Intimidatie of pesten"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Haatzaaiende taal"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Illegale goederen of diensten"),
      "ui_rule_impersonation": MessageLookupByLibrary.simpleMessage(
          "Zich voordoen als iemand anders"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Intellectueel eigendom"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Onjuiste informatie"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Zelfmoord of zelfbeschadiging"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Inhoud voor volwassenen"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Iets anders"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spam"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Geweld of bedreigingen"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Opgeslagen berichten"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Tik op het archiefpictogram bij een bericht om het hier te bewaren. Alleen jij ziet wat je opslaat."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Zoek op gebruikersnaam of weergavenaam."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Wissen"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "Alles doorzoeken wat geplaatst is"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filters"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Mensen zoeken"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Berichten zoeken"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Instellingen"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("App en apparaat"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Inhoud en weergave"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Databesparing"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Vertel ons wat je ervan vindt"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Helpartikelen bekijken"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Kies je taal"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Wie je hebt gedempt of geblokkeerd"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Meldingsvoorkeuren"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("Je profiel en contactgegevens"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Je moet opnieuw inloggen om bij je account te komen."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Beveiligingsinstellingen"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Wachtwoord bevestigen"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("In één regel"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Nieuw e-mailadres"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Nieuw wachtwoord"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Wat er gebeurde"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Hulp krijgen van ons team"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Delen"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Citeren"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Versturen in een bericht"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Aan mensen op Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Dit bericht delen"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Waar het over ging"),
      "ui_standing_account_banned":
          MessageLookupByLibrary.simpleMessage("Je account is verbannen"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Het antwoord, op \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Bezwaar"),
      "ui_standing_appeal_button": MessageLookupByLibrary.simpleMessage(
          "Bezwaar maken tegen deze beslissing"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Tegen deze beslissing kun je geen bezwaar meer maken. Klopt er iets niet, neem dan contact op met support."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Bezwaar in behandeling"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Bezwaar toegekend"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Iemand anders in het team bekijkt het opnieuw. Je krijgt een melding zodra er is beslist."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Denk je dat dit een vergissing was? Dan kun je tot \$date vragen om het opnieuw te bekijken. Iemand anders in het team beslist."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Bezwaar gemaakt: de beslissing blijft staan"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Zaak \$number. Regel: \$rule. Het team schreef:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Je account verwijderen heft een verbanning niet op: een nieuw account met hetzelfde e-mailadres is ook meteen verbannen."),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("Verbannen"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Alleen deze pagina, bezwaren, support en het verwijderen van je account werken nog."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Bezwaar mogelijk"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Zaak \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Beslist op \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Beslissingen over je account"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Je account verwijderen"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Details bekijken"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "Details bekijken en bezwaar maken"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Eindigt op \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Je account is in orde"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Er gelden geen beperkingen."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Accountstatus kon niet worden geladen"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Bericht verwijderd"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Er is niets beslist over je account. Als het team ooit iets van je verwijdert of je account beperkt, staat het hier met de reden en kun je bezwaar maken."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Geen bezwaar nodig: de beslissing is teruggedraaid."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Post verwijderd"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Trek omlaag om opnieuw te controleren."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Lees de regels van Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Reactie verwijderd"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("Teruggedraaid"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Teruggedraaid op \$date. Alles wat was verwijderd is terug, en er gelden geen beperkingen meer."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("Regel: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Uitloggen"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Geschorst"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Je kunt lezen, maar niet posten, reageren, volgen of berichten sturen. Melden, blokkeren en dempen werken nog wel."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Je account is geschorst: je kunt lezen, maar niet posten."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Geschorst tot \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Je account is geschorst tot \$date: je kunt lezen, maar niet posten."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Wat het team zei"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Accountstatus"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Waarschuwing"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Waarom?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Je schreef, op \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Je bericht"),
      "ui_standing_your_post": MessageLookupByLibrary.simpleMessage("Je post"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Je reactie"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Voorwaarden"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("dit bericht"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Discussie gedempt"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("Geluid uit"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Geluid aan"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Twee tekens of meer."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Ongedaan maken"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Woorden, of een filter: een account, een periode of wat een bericht bevat."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Repost ongedaan maken"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Wachtwoord bijwerken"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Een ander adres gebruiken"),
      "username": MessageLookupByLibrary.simpleMessage("Gebruikersnaam"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Gebruikersnaam moet in kleine letters (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Bijvoegen"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Klaar om bij te voegen"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Een spraakbericht opnemen"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Opnemen…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Stoppen"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Wat er gebeurde"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Wat is er gebeurd, en waar moeten we naar kijken?",
      ),
      "whatInPicture": MessageLookupByLibrary.simpleMessage(
          "Wat staat er op deze afbeelding?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Waar is het voor? (optioneel)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Wat je deed, wat je verwachtte, wat er gebeurde"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Wat je aan het doen was toen het gebeurde."),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("Je antwoordde"),
      "dmReplied": (Object a0) => "$a0 antwoordde",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Toevoegen aan bericht"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Nieuw bericht"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Nog niets gezegd. Een zwaai is een goed begin."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Zwaaien"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Nieuwe berichten"),
      "dmTyping": (Object a0) => "$a0 is aan het typen",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Je reactie verwijderen"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Iemand"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Bericht"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("Bijlage"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Dit bericht kan op dit apparaat niet worden gelezen."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Wachten op dit bericht. Dit kan even duren."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Versleuteld bericht"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Berichten zijn end-to-end versleuteld"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Niet end-to-end versleuteld"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Verzonden"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Gezien"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Verzenden…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Foto maken"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Meer opties"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Opslaan op apparaat"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Delen"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Opslaan…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Opgeslagen in je foto's"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Kon het niet opslaan. Probeer het opnieuw."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Sta Kyron toe iets aan je foto's toe te voegen om dit op te slaan."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Alle systemen operationeel"),
      "ui_status_uptime":
          MessageLookupByLibrary.simpleMessage("Beschikbaarheid"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Afgelopen 60 dagen"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 dagen geleden"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Vandaag"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Database"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Inloggen"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Recente incidenten"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Geen incidenten in de afgelopen 60 dagen."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Bezig"),
      "ui_status_no_data":
          MessageLookupByLibrary.simpleMessage("Geen gegevens"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Details"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron controleert zichzelf elke 5 minuten zolang het draait. Op een grijze dag waren er geen controles."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "De beschikbaarheidsgeschiedenis is nog niet beschikbaar."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Sommige systemen hebben problemen"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Spraakbericht opnemen"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Klaar om te verzenden"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Dat bericht is er niet meer."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Naar het bericht"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Spraakbericht"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Leuk gevonden door de auteur"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Foto of clip toevoegen"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Media"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Spraakberichten"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("Achtergrond"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Meldingen dempen"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Geen meldingen meer over dit gesprek ontvangen"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Ze kunnen je geen berichten meer sturen"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Geen"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Dempen opgeheven."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Kon het niet verwijderen. Probeer het opnieuw."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profiel"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Dempen opheffen"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Foto's en clips die je deelt, verschijnen hier."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Alles bekijken"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Foto's en clips"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Zo ziet je chat eruit."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Ziet er goed uit."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Mist"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Schemering"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Salie"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Zand"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Stippen"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("Toepassen"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Huidige"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Verzenden zonder voorbeeld"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Zoeken"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Plaatsen"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Schrijf een bericht…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Verzenden"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Verzonden"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "Verzonden, maar niet naar iedereen."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Dat kon niet worden verzonden. Probeer het opnieuw."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Volger"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filter"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Alle"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Ongelezen"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Onbeantwoord"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Verborgen"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Niets verborgen"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Gesprekken die je uit je lijst haalt, wachten hier voor het geval je ze terug wilt."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Het gaat naar Verborgen. De ander houdt het zijne, en het komt terug als een van jullie weer schrijft."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Terugzetten"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Weer in je lijst."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Geen gesprekken gevonden."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Er wacht niets op je"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Elk gesprek eindigt met jouw woord."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Foto's"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Nog geen berichten"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Jij:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Gisteren"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Berichten"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Berichtinstellingen"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Leesbevestigingen"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Als dit uit staat, zien anderen niet wanneer je hun berichten hebt gelezen, en zie jij niet wanneer zij de jouwe hebben gelezen."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Tonen wanneer je typt"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Degene aan wie je schrijft, ziet dat je aan het schrijven bent."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Linkvoorbeelden"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Je telefoon opent een link die je stuurt om het voorbeeld te maken, dus de site ziet je telefoon vragen. De server van Kyron ziet de link nooit."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Meldingen voor berichten"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Berichten zijn end-to-end versleuteld. Kyron kan ze niet lezen, en niets hier verandert dat."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Aan:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Recent"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Mensen"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Niemand met die naam."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Stuur een testmelding"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "De server van Kyron is nog niet ingesteld om meldingen te sturen, dus er kan er geen aankomen. Het ligt aan ons, niet aan je telefoon."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Deze telefoon is niet geregistreerd voor meldingen. Controleer of meldingen voor Kyron zijn toegestaan in de instellingen van je telefoon en probeer het opnieuw."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "De melding kon niet worden afgeleverd op deze telefoon. Probeer het over een minuut opnieuw."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Verstuurd. Hij zou binnen een paar seconden moeten aankomen."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Meldingen werken."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Nog geen berichten"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Nieuwe community"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Naam"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Het adres wordt van de naam gemaakt."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Mensen vinden het op"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Jij wordt de eigenaar. Een afbeelding, een banner en moderators kun je toevoegen op de pagina zodra die bestaat."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Home"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Communityberichten in Home"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Berichten uit je community's verschijnen ook in Home. Uit blijven ze hier in Community's, waar elke community laat zien wat nieuw is."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Je lijst"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Aantal nieuwe berichten"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Laat zien hoeveel berichten nieuw zijn in elke community sinds je die het laatst opende."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Community's die je beheert"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Community's die je begint of modereert, staan hier."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Eigenaar"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderator"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Nieuwe berichten"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Door jou beheerd"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Community-instellingen"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("Ontdekken"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Geen community's gevonden."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Niets nieuws"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Elke community is zoals je hem achterliet."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Je beheert er nog geen"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "Niets meer om lid van te worden"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Je zit in elke community op Kyron. Begin er nog een."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Probeer een ander woord, of begin een community met die naam."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Bericht schrijven"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Leden:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Geplaatst"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Bekijken"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Openen"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Online"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Tonen wanneer je online bent"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Mensen met wie je chat, zien een groene stip zolang je Kyron open hebt. Als dit uit staat, zie jij die van hen ook niet."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Zoek mensen en berichten"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Community's om lid van te worden"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Nog niets om te bekijken"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Foto's en clips die mensen plaatsen, verschijnen hier."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Volgen"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Account verwijderen"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Hiermee verwijder je je Kyron-account definitief. Dit kan niet ongedaan worden gemaakt."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Je profiel, berichten, reacties, likes en reposts"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Je berichten, ook die je naar anderen hebt gestuurd, en de foto's en spraakberichten daarin"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Je volgers, de mensen die je volgt en je instellingen"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Community's die je bent begonnen, gaan naar de moderator of het lid dat er het langst bij is. Een community zonder anderen wordt gesloten."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Je account verwijderen?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Je kunt er niets van terugkrijgen."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Je account is verwijderd."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Verwijderd account"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Dit account is verwijderd, dus hier kunnen geen berichten meer worden verstuurd."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Aangemeld met Google? Gebruik in plaats daarvan ‘Sign in with Google’."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Die lens kon niet worden geladen."),
      "ar_could_not_record": MessageLookupByLibrary.simpleMessage(
          "De video kon niet worden opgenomen."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "De lens kon niet aan deze video worden toegevoegd, dus hij wordt geplaatst zoals hij is gefilmd."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Je bericht heeft al zoveel bijlagen als het kan bevatten."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Je lens wordt toegevoegd…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Flitser"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Video opnemen"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Video"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Inloggen met Google is geannuleerd."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("CADEAUS"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Niemand heeft dit bericht nog een cadeau gestuurd."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Cadeau"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Cadeaus"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Munten"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Afzender"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Afzenders"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Testmunten: ze kunnen nog niet worden opgenomen."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Opgeslagen"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Berichten"),
      "ui_saved_tab_comments": MessageLookupByLibrary.simpleMessage("Reacties"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Meer reacties bekijken"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Bewerkt"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Meer"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Volgend"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Top"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Recent"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Reacties sorteren: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "heeft je bericht een cadeau gestuurd"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "heeft je reactie een \$gift gestuurd"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "heeft je bericht een \$gift gestuurd"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Cadeau sturen"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Bericht bewerken"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Je kunt het nog \$n min bewerken"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Opslaan"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Er is nog niets geplaatst onder #\$tab."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Kies een cadeau"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Niet genoeg munten"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Testmunten: ze kunnen niet worden gekocht en hebben geen geldwaarde."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Wordt aangevuld op \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 munt"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count munten"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("Je hebt \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift sturen"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift verstuurd"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("15 minuten na het plaatsen"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Bewerkt"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Je opgeslagen reacties konden niet worden geladen"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Geen opgeslagen reacties"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Tik op het archiefpictogram onder een reactie om die hier te bewaren. Alleen jij ziet wat je opslaat."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Antwoord aan \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Kopiëren"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Zoeken"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Alles selecteren"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count cadeaus"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 cadeau"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Kon geen berichten meer laden."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Herinneringen"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Wat er nieuw is als je even weg was, en wanneer je munten terug zijn. Nooit meer dan één per dag."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Cadeaus"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("van 1 persoon"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("van \$count personen"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Grootste gever"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Kon niet laden wie cadeaus heeft gestuurd."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Nieuw"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Begrepen"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Bedankt. We lezen elk antwoord."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Hoe bevalt Kyron tot nu toe?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Dag \$day van je test. Eén tik is genoeg."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Iets wat we moeten verbeteren of toevoegen? (optioneel)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Versturen"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Niet nu"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Druk nogmaals op terug om Kyron te verlaten"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Bevestig dat jij het bent"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Voer je wachtwoord in om je account te verwijderen."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Log opnieuw in met Google om je account te verwijderen."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Dat lukte niet. Controleer het en probeer het opnieuw."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Deze pagina wil een andere app openen"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Ze vraagt om een {scheme}-link te openen."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("Build"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "{size} aan gecachte afbeeldingen en bestanden"),
      "ui_about_freed":
          MessageLookupByLibrary.simpleMessage("{size} vrijgemaakt"),
      "ui_about_measuring":
          MessageLookupByLibrary.simpleMessage("Bezig met meten…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("Niets te wissen"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("Opslag"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("Versie {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("Geblokkeerd"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("Je plaatst als jezelf"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "Die bijlagen zijn niet geüpload. Tik op een bijlage om het opnieuw te proberen, of verwijder hem."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "Je e-mailadres kon niet worden gewijzigd. Probeer het opnieuw."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "Je adres verandert zodra je de link volgt die we sturen."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "Kijk in {email} voor een bevestigingslink."),
      "ui_email_enter":
          MessageLookupByLibrary.simpleMessage("Voer een e-mailadres in."),
      "ui_email_invalid":
          MessageLookupByLibrary.simpleMessage("Dat lijkt geen e-mailadres."),
      "ui_email_same":
          MessageLookupByLibrary.simpleMessage("Dat is al je e-mailadres."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "Wat je deed, wat je verwachtte en wat er in plaats daarvan gebeurde."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "Laat me een bericht vastzetten op mijn profiel"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "Wat je zou willen en wat je daarmee zou kunnen."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("Wat zou helpen"),
      "ui_feedback_kind_bug":
          MessageLookupByLibrary.simpleMessage("Een probleem"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("Een idee"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("Een vraag"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "Alleen het Kyron-team leest dit. Het wordt met je account verstuurd, zodat we per e-mail kunnen antwoorden, en met de versie van de app die je gebruikt. Als je je account verwijdert, wordt dit ook verwijderd."),
      "ui_feedback_question_example":
          MessageLookupByLibrary.simpleMessage("Hoe demp ik een woord?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "Wat je probeert te doen en waar je vastloopt."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("Je vraag"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Kyron was niet bereikbaar. Controleer je verbinding en probeer het opnieuw. Er is nog niets geschreven, dus er gaat niets verloren."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("Wissen"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Mislukte verzoeken en andere opvallende gebeurtenissen verschijnen hier."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("Gedempt"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "Voeg hierboven een woord of tag toe. Berichten daarmee blijven uit je feed."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "Berichten met een van deze blijven uit je feed. Hoofdletters maken niet uit, en een woord matcht ook binnen langere woorden, dus „spoiler” vangt ook „spoilers”."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("Niemand geblokkeerd"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "Blokkeren verbergt jullie voor elkaar, in beide richtingen. Blokkeer iemand via het menu op diens profiel."),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("Niemand gedempt"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "Een account dempen verbergt diens berichten zonder het te laten weten. Demp iemand via het menu op diens profiel of bij een bericht."),
      "ui_password": MessageLookupByLibrary.simpleMessage("Wachtwoord"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("Ze komen niet overeen."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "Je blijft ingelogd op dit apparaat. Andere apparaten worden uitgelogd."),
      "ui_password_too_short":
          MessageLookupByLibrary.simpleMessage("Gebruik minstens 8 tekens."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "Je wachtwoord kon niet worden bijgewerkt. Probeer het opnieuw."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("Wachtwoord bijgewerkt."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID gekopieerd"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "Berichten die je leuk vindt, worden hier bewaard, alleen voor jou."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "Je hebt nog geen foto's of clips geplaatst."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} heeft nog geen foto's of clips geplaatst."),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "Alles wat je plaatst, verschijnt hier."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} heeft nog niets geplaatst."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "Je profiel kon niet worden geladen"),
      "ui_profile_load_failed_other": MessageLookupByLibrary.simpleMessage(
          "@{handle} kon niet worden geladen"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("Minimaal 8 tekens"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("Kleine letter (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("Minstens één cijfer"),
      "ui_pw_rule_symbol":
          MessageLookupByLibrary.simpleMessage("Symbool (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("Hoofdletter (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "{count} recente regels. Bekijk ze onder Over › Systeemlogboek voordat je verstuurt."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "Alleen het Kyron-team leest dit. Het wordt met je account verstuurd, zodat we contact kunnen opnemen. Lees eerst het logboek onder Over › Systeemlogboek als je precies wilt zien wat er meegaat."),
      "ui_report_sent":
          MessageLookupByLibrary.simpleMessage("Verstuurd, bedankt."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "Verstuurd, bedankt. Het is melding #{number}."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("Wat ging er mis?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "Versie, beleid, status en het systeemlogboek"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "Video's niet vanzelf laten spelen tijdens het scrollen"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "Je gedecentraliseerde identificatie"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("Moderatie"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "Meldingen en bezwaren die op beoordeling wachten"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "Berichten met deze woorden uit je feed houden"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("Niet ingelogd"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("Meldingsvoorkeuren"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("Privacy en veiligheid"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "Beslissingen over je account, en bezwaren"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("Tekstgrootte aanpassen"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("Je account"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "Het opnemen en publiceren van AR-lenzen wordt nog gebouwd. Niets wat je vastlegt zou al worden bewaard, dus de camera blijft dicht."),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("Lenzen zijn nog niet klaar"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR-lens"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "Live gaan heeft een mediaserver nodig die Kyron nog niet draait. Nu een uitzending starten zou je in een ruimte zetten waar niemand bij kan. Een spraakbericht opnemen werkt al."),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("Live gaan is nog niet klaar"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("Live gaan"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Peilingen hebben een plek nodig om de opties te bewaren en de stemmen te tellen. Die is er nog niet, dus een peiling die je nu plaatst, zou elk antwoord kwijtraken."),
      "ui_soon_poll_heading":
          MessageLookupByLibrary.simpleMessage("Peilingen zijn nog niet klaar"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("Peiling"),
      "ui_soon_write_instead": MessageLookupByLibrary.simpleMessage(
          "Schrijf in plaats daarvan een tekstbericht"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("Opnieuw controleren"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("Detail"),
      "ui_status_mirror":
          MessageLookupByLibrary.simpleMessage("Spiegeltabellen"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron antwoordde, maar er klopt iets niet."),
      "ui_status_round_trip": MessageLookupByLibrary.simpleMessage("Rondetijd"),
      "ui_support_ask":
          MessageLookupByLibrary.simpleMessage("Een vraag stellen"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Over je account, of hoe iets werkt"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("Per e-mail"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Als Kyron is gecrasht: stuurt het logboek van de app mee"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("In de app"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "Schrijf het Kyron-team vanaf hier. Het bereikt ons privé, met je account, en we antwoorden op het e-mailadres dat erbij hoort."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "Er ging geen mailapp open. {address} is gekopieerd."),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("Privacy en je gegevens"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("Een probleem melden"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "Iets is kapot of doet niet wat het moet doen"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "Gebruik het menu bij een bericht of account om het te melden: zo weten we precies welke je bedoelt."),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("Veiligheid en misbruik"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Of Kyron voor iedereen plat ligt, of alleen voor jou"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("Groot"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("Groter"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("Gemiddeld"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron is een plek om iets te zeggen dat het lezen waard is."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("Klein"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Altijd donker"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("Gedimd"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Een zachter donker, blauwgrijs in plaats van zwart"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Altijd licht"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "De lichte of donkere instelling van de telefoon volgen"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("Deblokkeren"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("Dempen opheffen"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("Wie je bent"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "In je eigen woorden: wat de beoordelaar moet weten."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "Ik schrijf hier en op mijn eigen site over vogels."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("Nog een link toevoegen"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "Je kunt het vanaf {date} opnieuw vragen."),
      "ui_verify_ask":
          MessageLookupByLibrary.simpleMessage("Verificatie aanvragen"),
      "ui_verify_before":
          MessageLookupByLibrary.simpleMessage("Voordat je het vraagt"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("Maker"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("Journalist"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("Organisatie of merk"),
      "ui_verify_cat_other":
          MessageLookupByLibrary.simpleMessage("Iets anders"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("Publiek figuur"),
      "ui_verify_denied": MessageLookupByLibrary.simpleMessage(
          "Aanvraag {number} is niet goedgekeurd"),
      "ui_verify_done":
          MessageLookupByLibrary.simpleMessage("Je bent geverifieerd"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("Je profiel bewerken"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("Voer de 6-cijferige code in"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "Code opnieuw sturen over {seconds} seconden"),
      "ui_verify_email_sent_to": MessageLookupByLibrary.simpleMessage(
          "We hebben hem naar {email} gestuurd"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("Verifiëren"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Laat je verifiëren op Kyron"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Laat je"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("verifiëren"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("op Kyron."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "Het badge zegt dat iemand van het Kyron-team heeft gecontroleerd dat dit account is wie het zegt te zijn. Het geeft geen extra bereik en is niet te koop."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "Het badge blijft zolang je naam blijft. Verander je naam, dan verdwijnt het tot iemand de nieuwe controleert."),
      "ui_verify_link_first": MessageLookupByLibrary.simpleMessage(
          "Waar we het kunnen controleren"),
      "ui_verify_link_more":
          MessageLookupByLibrary.simpleMessage("Nog een link"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "Een site of ander profiel dat zegt dat dit Kyron-account van jou is: zet je Kyron-naam, of een link naar je profiel, erop. Kyron vraagt nooit om identiteitsbewijzen."),
      "ui_verify_load_failed": MessageLookupByLibrary.simpleMessage(
          "Je stand van zaken kon niet worden geladen"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "Alles hierboven heeft een vinkje nodig voordat je het kunt vragen."),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "Een account van minstens {days} dagen oud"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("Een bio die zegt wie je bent"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("Je naam op het profiel"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("Een profielfoto"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "Niets op je naam in de afgelopen {days} dagen"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "Verstuurd. Een mens gaat ernaar kijken."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("Sinds {date}."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("Vragen"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Wie je bent, en een link\ndie het bewijst"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("Het badge"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "Naast je naam,\noveral waar die staat"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("Een mens\ncontroleert"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "Iemand van het team\nvolgt je links"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("Verificatie"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "Aanvraag {number} ligt bij een mens"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "Verstuurd op {date}, als {category}. Je krijgt een melding als er is beslist."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("Aanvraag intrekken"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("Aanvraag ingetrokken."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "De opname kon niet worden afgerond: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("Tot tien minuten."),
      "ui_voice_listening":
          MessageLookupByLibrary.simpleMessage("Aan het luisteren…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron heeft toestemming nodig om de microfoon te gebruiken voor opnames. Je kunt die geven in de instellingen van je apparaat."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "De opname kon niet worden gestart: {error}"),
      "ui_2fa_title":
          MessageLookupByLibrary.simpleMessage("Inloggen in twee stappen"),
      "ui_2fa_help": MessageLookupByLibrary.simpleMessage(
          "Een authenticatorcode voor teamtools"),
      "ui_2fa_intro": MessageLookupByLibrary.simpleMessage(
          "Teamtools vragen naast je inlog ook een code uit een authenticator-app, zodat een gestolen wachtwoord alleen niet genoeg is."),
      "ui_2fa_on": MessageLookupByLibrary.simpleMessage(
          "Inloggen in twee stappen staat aan."),
      "ui_2fa_remove": MessageLookupByLibrary.simpleMessage("Verwijderen"),
      "ui_2fa_set_up": MessageLookupByLibrary.simpleMessage("Instellen"),
      "ui_2fa_scan": MessageLookupByLibrary.simpleMessage(
          "Scan dit met je authenticator-app of voer de sleutel hieronder in. Voeg hem zo mogelijk toe aan twee apps: verlies je je enige, dan moet je support vragen hem te verwijderen."),
      "ui_2fa_key": MessageLookupByLibrary.simpleMessage("Instelsleutel"),
      "ui_2fa_copied":
          MessageLookupByLibrary.simpleMessage("Instelsleutel gekopieerd"),
      "ui_2fa_confirm": MessageLookupByLibrary.simpleMessage("Bevestigen"),
      "ui_2fa_failed": MessageLookupByLibrary.simpleMessage(
          "Kan het instellen niet starten. Probeer het opnieuw."),
      "ui_2fa_wrong": MessageLookupByLibrary.simpleMessage(
          "Die code werkte niet. Controleer de tijd op je telefoon en probeer het opnieuw."),
      "ui_2fa_code": MessageLookupByLibrary.simpleMessage("6-cijferige code"),
      "ui_2fa_enter": MessageLookupByLibrary.simpleMessage(
          "Voer de code uit je authenticator-app in"),
      "ui_2fa_verify": MessageLookupByLibrary.simpleMessage("Verifiëren"),
      "ui_password_breached": MessageLookupByLibrary.simpleMessage(
          "Dit wachtwoord is opgedoken in een datalek, dus het is een van de eerste die aanvallers proberen. Kies een ander."),
    };

final messageLookup = MessageLookup();
