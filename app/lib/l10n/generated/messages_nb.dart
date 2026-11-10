import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'nb';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
          "Et ord, en frase eller en #tagg"),
      "about": MessageLookupByLibrary.simpleMessage("Om"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Legg til et svar"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Legg til flere språk…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Godta og fortsett"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Allerede på Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Kommentarer"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage("Unike personer, ikke åpninger"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Engasjement"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Liker"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Ingen seere ennå"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Ingen har åpnet dette innlegget ennå."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Publisert"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Lagringer"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Seere"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("SEERE PER DAG"),
      "and": MessageLookupByLibrary.simpleMessage("og"),
      "answerNumber": (Object a0) => "Svar ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR-linse"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Legg ved systemloggen"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Tur-retur"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("TOKENBEKREFTELSE"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Prøv igjen"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Prøv igjen"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Å starte en sending nå ville satt deg i et rom ingen kunne"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Start et fellesskap"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Hva er den til? (valgfritt)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("inn igjen."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("inn igjen fra denne listen."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Å stenge det"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("bli med først"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("kommer snart"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Du publiserer som deg selv"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("publiser i dette fellesskapet"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Akkurat nå"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Prøv igjen"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Emne 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("For deg"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("har noe."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("på vei dit nå."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", ikke"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("beveger jeg meg"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Slå av lyd"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Slå på lyd"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("For deg"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Fanene dine"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Prøv igjen"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Symbol (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("SEERE PER DAG"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("kunne ikke lastes inn"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("dette innlegget"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("Noe å legge til? (valgfritt)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("dette innlegget"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Fra en konto"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Logg ut"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Kontoen din"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Bekreft passord"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("ikke nå"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Laster inn…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Publiserer…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 t siden"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Kopier lenke til historien"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Historien din"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Kontoen din, innleggene dine og det du trykker på, slik at"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Legg til et emne"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("på egen hånd."),
      "authorBlocked": (Object a0) => "${a0} blokkert",
      "authorPostsHidden": (Object a0) => "Du vil ikke se innlegg fra ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Blokker"),
      "blockAuthor": (Object a0) => "Blokkere ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Versjonsdetaljer kopiert"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Ved å fortsette godtar du våre"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Ved å fortsette godtar du vilkårene og personvernerklæringen vår"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Ved å registrere deg godtar du våre"),
      "cancel": MessageLookupByLibrary.simpleMessage("Avbryt"),
      "change": MessageLookupByLibrary.simpleMessage("Endre"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Endre e-post"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Sjekk e-posten din for å bekrefte kontoen."),
      "checkKyronReachable":
          MessageLookupByLibrary.simpleMessage("Sjekk om Kyron kan nås"),
      "clear": MessageLookupByLibrary.simpleMessage("Tøm"),
      "close": MessageLookupByLibrary.simpleMessage("Lukk"),
      "closeCommunity": (Object a0) => "Stenge ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Steng det"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Steng dette fellesskapet"),
      "communities": MessageLookupByLibrary.simpleMessage("Fellesskap"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Finn et i Oppdag, eller start ditt eget."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Slipp en het mening (eller en lunken)"),
      "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
          "Hva surrer rundt i hodet ditt?"),
      "composer_placeholder_say":
          MessageLookupByLibrary.simpleMessage("Si noe bare du kan si…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "Dette er signalet ditt: send det"),
      "composer_placeholder_think":
          MessageLookupByLibrary.simpleMessage("Skriv, snakk eller tenk høyt"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Bekreft passord"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Kontakt brukerstøtte"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Innlegg har ikke språk ennå, så dette filtrerer ikke feeden i dag. Valget ditt tas vare på til de har det."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Fortsett"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Fortsett med e-post"),
      "copy": MessageLookupByLibrary.simpleMessage("Kopier"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Kopier rapporten i stedet"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Kunne ikke åpne Google-pålogging. ${a0}",
      "couldNotSignOut": (Object a0) => "Kunne ikke logge ut: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Kunne ikke ta det bildet."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Vises på profilen din og under innleggene dine."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Ingen land samsvarer med «{query}»."),
      "country_none": MessageLookupByLibrary.simpleMessage("Ikke vis noe land"),
      "country_search": MessageLookupByLibrary.simpleMessage("Søk etter land"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Vises på profilen din og under innleggene dine. Når du ser noens innlegg, telles landet ditt med i Innsikten deres, bare i grupper på fem eller flere og aldri med navn."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Fra telefonens innstillinger"),
      "create": MessageLookupByLibrary.simpleMessage("Opprett"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Opprett konto"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Opprett kontoen din"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Opprett profilen din"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR-linse"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Gå direkte"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("Tekstinnlegg"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("Taleinnlegg"),
      "delete": MessageLookupByLibrary.simpleMessage("Slett"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Slette denne kommentaren?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Slette dette innlegget?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Beskriv dette vedlegget"),
      "description": MessageLookupByLibrary.simpleMessage("Beskrivelse"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
          "DID kopiert til utklippstavlen"),
      "done": MessageLookupByLibrary.simpleMessage("Ferdig"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Lukk redigeringen med noe skrevet, så får du tilbud om et utkast."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} dager siden"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} timer siden"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Akkurat nå"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} minutter siden"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Ingenting skrevet ennå"),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
          "En avstemning, uten spørsmål ennå"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Et sitat, uten tekst ennå"),
      "drafts": MessageLookupByLibrary.simpleMessage("Utkast"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Rediger profil"),
      "email": MessageLookupByLibrary.simpleMessage("E-post"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("E-postvarsler"),
      "explore": MessageLookupByLibrary.simpleMessage("Utforsk"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Ansiktssporing er ikke tilgjengelig på denne enheten."),
      "feedTagDetail": (Object a0) =>
          "Ingenting er publisert under #${a0} ennå.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Følg {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Følgere"),
      "following": MessageLookupByLibrary.simpleMessage("Følger"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Glemt passordet?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Få hjelp"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Fortsett med Google"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Logg inn med Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google leverer den fullførte påloggingen tilbake til Kyron via en lenke bare Android og iOS svarer på, så på ${a0} ville nettleseren ikke hatt noe sted å levere den.\\n\\nHar du allerede en Kyron-konto via Google, bruk Fortsett med e-post med samme adresse og trykk på Glemt passordet: du får en lenke for å lage et.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google-pålogging krever mobilappen"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Registrer deg med Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Veiledninger og svar på vanlige spørsmål"),
      "handle": MessageLookupByLibrary.simpleMessage("brukernavn"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("Hjelp og støtte"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Hjelpesenter"),
      "home": MessageLookupByLibrary.simpleMessage("Hjem"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("På én linje"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Kontoen din"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Åpne fellesskapet"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Skriv et innlegg"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("Se innlegget"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Rediger profilen"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Når de er der"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("I din tidssone."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Aldre"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Av de {known} som ble nådd og har oppgitt bursdag."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Personer nådd per dag"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Fellesskap de er med i"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Land"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Av de {known} nådde personene som har et land på profilen sin."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Siste {days} dager"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("Kunne ikke laste innsikt"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Følgere"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Ingen gruppe er stor nok til å vises ennå."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Slik vokser du"),
      "ins_interests": MessageLookupByLibrary.simpleMessage("Emner de følger"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Liker"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Ny"),
      "ins_new_followers": MessageLookupByLibrary.simpleMessage("Nye følgere"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Ingen av innleggene dine nådde noen i denne perioden."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Følger deg ikke"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Landene er dem folk har valgt på profilene sine. Kyron samler ikke inn noens by eller kjønn, så det er ingenting å vise for dem."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Åpninger"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} nådd · {likes} liker · {replies} svar"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Personer nådd"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Hver person telles én gang: vist eller åpnet et av innleggene dine for første gang. Nye følgere følger deg fortsatt; avfølginger telles ikke."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Svar"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Repostinger"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Lagringer"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Hvem publikummet ditt er, vises når {floor} personer har sett innleggene dine i perioden. Færre enn det, og det kunne peke på noen."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Ikke nok personer ennå"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct} % av dem følger deg allerede: innleggene dine når mest folk som kjenner deg."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct} % av dem følger deg ikke ennå: innleggene dine blir funnet."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Du nådde {reach} personer, {pct} % færre enn perioden før."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Du nådde {reach} personer de siste {days} dagene."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Du nådde {reach} personer, omtrent like mange som perioden før."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Ingen nye har sett innleggene dine de siste {days} dagene."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Du nådde {reach} personer, {pct} % flere enn perioden før."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Du nådde {reach} personer, {times}× så mange som perioden før."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Flere av dem følger {name} enn noe annet emne."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Publikum"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Oversikt"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Folk som finner et av innleggene dine, ser på profilen din før de følger. Et ansikt eller en logo forteller dem at noen er der."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Legg til profilbilde"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Si på én linje hva du legger ut om, så en fremmed vet hva det gir å følge deg."),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("Skriv en bio"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} av dine {total} innlegg hadde ikke noe emne. Et emne setter innlegget i emnets feed og foran dem som følger det."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Legg til emner i innleggene"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} personer svarte på innleggene dine, og du svarte {answered}. De brydde seg nok til å skrive: et svar gjør en leser til en stamgjest."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Svar på svarene"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Publikummet ditt er mest aktivt {when}. Et innlegg rett før har folk som tar imot det."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Legg ut når de er der"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} personer som ikke følger deg, så innleggene dine, og {gained} fulgte. La bioen og de nyeste innleggene si hva de kan forvente av deg."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("Gjør lesere til følgere"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Ett innlegg nådde {times}× så mange som de andre dine pleier. Se hva det gjorde annerledes, og gjør mer av det."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Gjør mer av det som virket"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Mange av dem som ser innleggene dine, er i {name}. Å legge ut der setter deg foran resten."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Legg ut i {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Du la ut {posts} ganger på {days} dager. Hvert innlegg er en ny sjanse til å bli funnet, og en jevn rytme holder deg i følgernes feeder."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Legg ut oftere"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Du har ikke lagt ut noe de siste {days} dagene. Ingenting når noen uten et innlegg."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Legg ut noe"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Innsikt"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Toppinnlegg"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Sammenlignet med de {days} dagene før"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Legg til en interesse"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Dra for å endre rekkefølge"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Feltet har plass til fem faner. Fjern én for å legge til en annen."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Følger"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("For deg"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Emneknagger dukker opp her når folk begynner å bruke dem."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Populært nå"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Videoer"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Fanene dine"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
          "Det forsvinner for dere begge."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Det fjernes fra tråden."),
      "join": MessageLookupByLibrary.simpleMessage("Bli med"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Fortsett å redigere"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Skjermene i Kyron er på ditt språk. Hvis et ord høres feil ut, si fra via Send tilbakemelding."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Språk"),
      "leave": MessageLookupByLibrary.simpleMessage("Forlat"),
      "leaveCommunity": (Object a0) => "Forlate ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Slipp inn igjen"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("1 side åpen"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Legg til et klipp"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Legg til en GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Legg til en emneknagg"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Legg til et bilde"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Legg til en avstemning"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Legg til en video"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Legg til en interesse"),
      "literaladdLabelAsATab": (Object a0) => "Legg til ${a0} som fane",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("Appspråk"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("Appversjon"),
      "literalblockAuthor": (Object a0) => "Blokker ${a0}",
      "literalblockAuthor2": (Object a0) => "Blokkere ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Blokkere denne kontoen?"),
      "literalcancelReply": MessageLookupByLibrary.simpleMessage("Avbryt svar"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("Sjekk igjen"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Velg fra galleriet"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Tøm hurtigbuffer"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Lukk alle sider"),
      "literalcloseTabLabel": (Object a0) => "Lukk ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Lukk nettleseren"),
      "literalcloseWidgetCommunityName": (Object a0) => "Stenge ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Kontakt brukerstøtten"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Innholdsspråk"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Kopier lenke"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Kopier lenke til innlegget"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Kopier innleggstekst"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Kopier tekst"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn fellesskap"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Kunne ikke laste inn GIF-er"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("Kunne ikke laste inn varsler"),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn medlemmene"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn disse innleggene"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Kunne ikke laste inn denne samtalen"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn denne listen"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn dette innlegget"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn dette svaret"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn populære tagger"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Kunne ikke laste inn fellesskapene dine"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn meldingene dine"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke åpne dette fellesskapet"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke publisere det svaret."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Kunne ikke søke"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Kunne ikke logge ut: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} sider åpne",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Forsidebilde"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("Datasparing"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Slett innlegg"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Oppdag folk"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Ikke svar"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Utkast lagret"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Tilbakemelding kan ikke sendes akkurat nå"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Skriftstørrelse"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF-er er ikke satt opp"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Gi det til en annen app"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Skjul passord"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Skjul dette innlegget"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Skjuler det og ber oss vise færre lignende"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Hvordan oppføre seg"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Fortsett å skrive"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron svarte ikke"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0}-dato",
      "literalleaveCommunityName": (Object a0) => "Forlate ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, ansiktslinse",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Likte innlegg"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Lenken er kopiert"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Gjør til moderator"),
      "literalmuteAuthor": (Object a0) => "Demp ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Demp denne tråden"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Demp ord eller tagger"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("Dempede og blokkerte kontoer"),
      "literalmutedYouWillNotBeNotified":
          MessageLookupByLibrary.simpleMessage("Dempet. Du får ikke varsler."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Ingen app på denne enheten åpner ${a0}-lenker.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Ingen nettleser på denne enheten tok imot lenken."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Ingen DID ennå"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Ingen utkast"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Ingen interesser ennå"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Ingen liker ennå"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Ingen meldinger ennå"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Ingen nye følgere"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Ingen innlegg ennå"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Ingen svar ennå"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Ingen delinger ennå"),
      "literalnoTrendingTagMatchesThat":
          MessageLookupByLibrary.simpleMessage("Ingen populær tagg passer"),
      "literalnobodyFound": MessageLookupByLibrary.simpleMessage("Fant ingen"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Ingen er fjernet"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Ingen her ennå"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Ikke interessert"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Ingenting funnet"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Ingenting er populært ennå"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Ingenting logget ennå"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Ingen treff"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Ingenting dempet"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Ingenting å se på ennå"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Ingenting ulest"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("Bare eieren kan endre dette"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Åpne svar"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Åpne e-posten fra Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Passord og pålogging"),
      "literalpostInCommunityName": (Object a0) => "Publiser i ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Publiser i ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Publiser det med egne ord over"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Hovedspråk"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-varsler"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Leser…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Ta opp et taleinnlegg"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Ta opp igjen"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Fjern som moderator"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Fjern fra fellesskapet"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Fjern fra lagrede"),
      "literalremoveLabel": (Object a0) => "Fjern ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Fjern ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Fjerne ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Fjern avstemningen"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Fjern dette svaret"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Fjern denne samtalen"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Fjern denne avstemningen"),
      "literalreportAuthor": (Object a0) => "Rapporter ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Rapporter innlegg"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Send koden på nytt"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Lagrede innlegg"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("Si noe"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Si noe til ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Søket mislyktes"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Send igjen"),
      "literalsendAgainInCooldownS": (Object a0) => "Send igjen om ${a0} s",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Send tilbakemelding"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("Send lenken"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Sendt. Det er rapport nr. ${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Lag et passord og fortsett"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("Del loggen med brukerstøtten"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Del dette fellesskapet"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Del denne siden"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Del denne profilen"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Del via…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Del med et sitat"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Vis flere innlegg som dette"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Vis passord"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Vis resultater"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Start et fellesskap"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Start opptak"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Stopp innlasting"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Slutt å se dette innlegget og svarene på det"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Historiefelt, ${a0} elementer",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Bytt kamera"),
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("Tagg noen"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Ta et bilde"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Trykk på banneret eller bildet for å endre det"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Trykk på lenken i den"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Trykk for å legge til et bilde og et forsidebilde"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Det gikk ikke gjennom. Prøv igjen."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Den GIF-en kunne ikke lastes ned."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Den lenken kan ikke åpnes her."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Kameraet er lukket"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Dette fellesskapet"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Dette svaret er borte"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Oversett innlegg"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("Slå av lyd"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("Slå på lyd"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Bruk en av våre"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Bekreftelseskoden er sendt på nytt."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Bekreftelsen mislyktes: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Bekreft e-post"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Seere, liker, lagringer og kommentarer"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Hva Kyron tar vare på"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Hva denne appen har gjort"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Hva du gjorde, hva du forventet, hva som skjedde "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Det du publiserer er ditt"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Om Kyron kan nås akkurat nå"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Hvem kan svare"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Hvem vil du tagge?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Du følger allerede alle populære tagger"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Du er à jour"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Du er ikke med i noen fellesskap"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Du er logget ut."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Du har forlatt ${a0}",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "Du har ikke publisert noe ennå"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Last inn flere"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Loggen tømt"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Loggen kopiert"),
      "logIn": MessageLookupByLibrary.simpleMessage("Logg inn"),
      "logOut": MessageLookupByLibrary.simpleMessage("Logg ut"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Logge ut?"),
      "login": MessageLookupByLibrary.simpleMessage("Pålogging"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Påloggingen mislyktes. Sjekk opplysningene dine."),
      "manage": MessageLookupByLibrary.simpleMessage("Administrer"),
      "menu": MessageLookupByLibrary.simpleMessage("Meny"),
      "message": MessageLookupByLibrary.simpleMessage("Melding"),
      "messages": MessageLookupByLibrary.simpleMessage("Meldinger"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("Alle samtaler er à jour."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Åpne noens profil og trykk på Melding for å starte en samtale."),
      "mute": MessageLookupByLibrary.simpleMessage("Demp"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Dempet og blokkert"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Dempede ord og tagger"),
      "name": MessageLookupByLibrary.simpleMessage("Navn"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name>-skjerm"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Ny e-postadresse"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Nytt passord"),
      "newPost": MessageLookupByLibrary.simpleMessage("Nytt innlegg"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Ikke nå"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Ikke sendt. Trykk for å prøve igjen"),
      "nothingMatchesQuery": (Object a0) =>
          "Ingenting på Kyron passer med «${a0}»",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Ingenting å kopiere"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Liker, svar og nye følgere havner her når de kommer."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Folk som følger deg, vises her."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Når noen liker et av innleggene dine, vises det her."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Svar på innleggene dine havner her."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Når noen deler deg videre, vises det her."),
      "notifications": MessageLookupByLibrary.simpleMessage("Varsler"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Åpne i nettleseren"),
      "or": MessageLookupByLibrary.simpleMessage("eller"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("Fant ikke siden"),
      "password": MessageLookupByLibrary.simpleMessage("Passord"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Passordet er for kort"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Velg interessene dine"),
      "post": MessageLookupByLibrary.simpleMessage("Publiser"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Innleggsstatistikk"),
      "postInCommunity": (Object a0) => "Publiser i ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
          "Publiser det, si det, vis det."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Innleggstekst kopiert"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Personvernerklæring"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profilen er oppdatert"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Land"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Visningsnavn"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Sted"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Trykk for å endre"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Nettsted"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage("Push-varsler"),
      "quote": MessageLookupByLibrary.simpleMessage("Siter"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Siter innlegg"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Nå et menneske"),
      "remove": MessageLookupByLibrary.simpleMessage("Fjern"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Fjerne denne samtalen?"),
      "removeMember": (Object a0) => "Fjerne ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Fjerne denne meldingen?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("Svar, følgere og omtaler"),
      "repliesPolicy": (Object a0) => "Svar: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Svar"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Alle kan samhandle"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Alle kan fortsatt se, dele og sitere dette innlegget."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Alle på Kyron kan svare på dette innlegget."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Folk som følger deg"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Bare folk som følger deg kan svare på dette innlegget."),
      "reply_mentioned": MessageLookupByLibrary.simpleMessage("Folk du nevner"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Bare de du @nevner i dette innlegget kan svare."),
      "reply_nobody": MessageLookupByLibrary.simpleMessage("Ingen kan svare"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Svar er slått av. Du kan fortsatt svare."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Hvem kan svare?"),
      "report": MessageLookupByLibrary.simpleMessage("Rapporter"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Rapporten er kopiert. Lim den inn i en e-post til brukerstøtten."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Rapport sendt"),
      "repost": MessageLookupByLibrary.simpleMessage("Del videre"),
      "reset": MessageLookupByLibrary.simpleMessage("Tilbakestill"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Tilbakestill passordet ditt"),
      "retry": MessageLookupByLibrary.simpleMessage("Prøv igjen"),
      "save": MessageLookupByLibrary.simpleMessage("Lagre"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Lagre utkast"),
      "saySomething": (Object a0) => "Si noe til ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Søk"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Søk etter navn eller brukernavn"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Søk i fellesskap"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Søk etter GIF-er"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("Søk etter språk"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Søk i populære tagger"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Sikkerhetsvarsler og kontoendringer"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Velg språket for appens brukergrensesnitt."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Velg hvilke språk feedene dine skal inneholde. Velger du ingen, vises alle språk."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Velg foretrukket språk for oversettelser i feeden."),
      "send": MessageLookupByLibrary.simpleMessage("Send"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Send bekreftelse"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Send feilrapport"),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("Send tilbakemelding"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Send rapport"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Send til brukerstøtten"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Tjenestestatus"),
      "settings": MessageLookupByLibrary.simpleMessage("Innstillinger"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Del appens logg med brukerstøtten"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Logg inn på Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Logget inn som"),
      "signupFailed": (Object a0) => "Registreringen mislyktes: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Bli"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron er tidlig ute, og den raskeste måten å nå noen som faktisk kan rette et problem på, er å åpne en sak. Fortell hva du gjorde og hva som skjedde i stedet."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Det finnes ingen innboks for brukerstøtte i appen ennå, så denne skjermen viser til stedet som faktisk følges med på, i stedet for et skjema som ikke leder noe sted."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Systemlogg"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Fortell oss hva som mangler eller ikke virker"),
      "terms": MessageLookupByLibrary.simpleMessage("Vilkår"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Tekst, tale og video, menneskene som lager dem, og rommene de prater i."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "Redigeringsverktøyet har ingen Publiser-knapp"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Mørkt"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Alltid mørkt"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Dempet"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Et mykere mørkt, blågrått i stedet for svart"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Lyst"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("Alltid lyst"),
      "theme_system": MessageLookupByLibrary.simpleMessage("System"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Følg telefonens lyse eller mørke innstilling"),
      "translate": MessageLookupByLibrary.simpleMessage("Oversett"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Oversettelse finnes ikke ennå. Ingenting i feeden oversettes i dag; dette huskes til den gjør det."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Dette endrer Kyrons egne ord, delene av grensesnittet Flutter tegner selv, datoer og tall, og retningen appen legges ut i for språk som skrives fra høyre mot venstre."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Prøv igjen"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Personvernerklæring"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Vilkår for bruk"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Konto"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Etter"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("App og enhet"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Jeg siterte svindelen for å advare folk."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Forklar hvorfor du mener avgjørelsen var feil: hva innlegget betydde, hva teamet kan ha oversett, eller hvorfor regelen ikke passer. Noen andre enn den som avgjorde, leser det."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Klagen din"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Skriv minst \$count tegn. Du kan klage på hver avgjørelse én gang."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Send klage"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Klagen er sendt. Du får et varsel når den er avgjort."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Klage på sak \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Utseende"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Lyst, mørkt eller det telefonen er satt til"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Før"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Ingen av dere ser den andre på Kyron, og eventuelle følginger mellom dere fjernes. Personen får ikke beskjed."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Inneholder"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Hva den er til (valgfritt)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Bare moderatorer kan skrive"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "For kunngjøringer. Alle i fellesskapet kan fortsatt lese og reagere."),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "Legg til et bilde eller en avstemning"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Bilder og videoer"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Lukk chatten"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Ingen vil kunne lese eller skrive i den. Dette kan ikke angres."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Lukke denne chatten?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Kopiert"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Meldingen fjernes for alle. Kyron beholder en kopi for gjennomgang."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Meldingen fjernes for alle i chatten."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Rediger chat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Rediger"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("redigert"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Du redigerer meldingen din"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke åpne denne chatten."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Chatter"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Bli med i chatten"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Bli med i fellesskapet for å se og delta i chattene."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count har blitt med"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Forlat chatten"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Du kan fortsatt lese den så lenge du er i fellesskapet."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Bare eieren og moderatorene kan skrive her."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Slå av lyd"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Ingen varsler fra den, og den telles ikke med i Meldinger."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Navn på chatten"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Ny chat"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Ingen chatter ennå."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Ingen chatter ennå. Åpne en for fellesskapet."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Fellesskapschatter er ikke ende-til-ende-kryptert. Fellesskapets moderatorer og Kyron kan lese dem."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Fest øverst"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Legg til et svar"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Avslutt avstemningen"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Avsluttet"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Alle ser hvor mange som valgte hvert svar, aldri hvem."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("La folk velge flere"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Ny avstemning"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Velg ett"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("Svar \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Avstemning: \$question"),
      "ui_cchat_poll_question":
          MessageLookupByLibrary.simpleMessage("Spørsmål"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Hvert svar kan bare være med én gang i en avstemning."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Velg ett eller flere"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count har svart"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Søk i denne chatten"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Søk i denne chatten"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Fant ingenting."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Du kan ikke lenger se denne chatten."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Saktemodus"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Hvor lenge folk venter mellom meldinger. Gjelder ikke moderatorer."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 time"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minutter"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Saktemodus: én melding hvert \$seconds. sekund"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Av"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n sekunder"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Du kan lese og reagere som tilskuer. Bli med for å skrive."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Den meldingen ligger for langt tilbake til å vises."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Noe du valgte, er for stort til å sendes og ble utelatt."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("Slå på lyd"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Løsne"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Ta opp en talemelding"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Du"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Fellesskap"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Hva er den til? (valgfritt)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Innlegg:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Innhold og visning"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn feeden din"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn innleggene du har likt"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn profilen din"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn de lagrede innleggene dine"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Desentralisert ID"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnostikk"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Grupper"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("Ingen grupper"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Grupper du er med i, og community-chatter du blir med i, vises her."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Du kan feste opptil \$count chatter. Løsne én først."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Festet"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Likt"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Lagret"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Ingenting her ennå"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Følg noen kontoer, så vises innleggene deres her."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Ingenting fra folk du følger"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Innlegg vises her etter hvert som folk skriver dem."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Svekkes"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Ikke interessert"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Vis flere som dette"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("Fjernet"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Feedsignalene dine"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Trykk på Vis flere innlegg som dette eller Ikke interessert i dette på et innlegg, så vises det her."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Ingenting her ennå"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Hva Vis mer og Ikke interessert forteller feedene dine"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "De former Hjem og Utforsk, mest etter hva hvert innlegg handlet om. Hvert signal svekkes til det halve hver måned og teller ikke etter seks. Fjern ett for å stoppe det nå."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Innlegg med et klipp vises her."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Ingen videoer ennå"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Tilbakemelding"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Finn folk på Kyron"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Fra en konto"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Legg til personer"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Legg til"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Legg til gruppenavn"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Avvis"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Meldinger i denne gruppen er ende-til-ende-krypterte, som alle andre samtaler."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor la til \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor gjorde \$users til admin"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor opprettet gruppen"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor lot nye personer bli med som medlemmer"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor lot nye personer bli med som tilskuere"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor forlot gruppen"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor gjorde \$users til medlem"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor gjorde \$users til eier"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor fjernet \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor ga gruppen nytt navn: \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor gjorde \$users til tilskuer"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "En gruppe kan ha maks \$count personer."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Hånden er rakt opp. Administratorene har fått beskjed."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count vil skrive"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Vil skrive"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Personer som legges til senere, blir med som tilskuere"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Forlat gruppen"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Den forsvinner fra listen din, og du ser ikke det som sies etterpå. Noen må legge deg til igjen."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Forlate denne gruppen?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("La dem skrive"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Ta ned hånden"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Gjør til admin"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Gjør til eier"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Gjør til tilskuer"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count medlemmer"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Medlemmer"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Gruppenavn"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Gi gruppen et navn først."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Opprett gruppechat"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Det er én eier. Du fortsetter som admin."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Gjøre \$name til eier?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Rekk opp hånden"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Fjern fra gruppen"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Fjern som admin"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Du er ikke lenger med i denne gruppen."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Gi nytt navn"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Administrator"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Medlem"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Tilskuer"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Som tilskuer kan du lese og reagere her."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Tilskuere kan lese, reagere og rekke opp hånden for å be om å få skrive."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Forslag"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Se profil"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("deg"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Du er tilskuer"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Hjelp"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Notert. Dette hjelper oss å velge hva du får se."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Bli med"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Medlem"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Språk"),
      "ui_language_detail": MessageLookupByLibrary.simpleMessage("Velg språk"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Juridisk"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Lik"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("Likte innlegg"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Innlegg du liker vises her, de nyeste først."),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Lenken er kopiert"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Du slutter å se innleggene til personen. Personen får ikke beskjed."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Ingen liker ennå"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Ingen innlegg passer med disse filtrene."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Ingenting lagret ennå"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Kontoen din er oppdatert"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Klagen din på sak \$number er tatt til følge"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Vi har sett på klagen din på sak \$number igjen, og avgjørelsen står fast"),
      "ui_notif_banned":
          MessageLookupByLibrary.simpleMessage("Kontoen din er utestengt"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Sak \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("følger deg nå"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("likte innlegget ditt"),
      "ui_notif_mentioned": MessageLookupByLibrary.simpleMessage("nevnte deg"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Ingen omtaler ennå"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Når noen skriver @brukernavnet ditt i et innlegg eller et svar, vises det her."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Eldre"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Meldingen din i en community-chat er fjernet"),
      "ui_notif_removed_other":
          MessageLookupByLibrary.simpleMessage("Noe du publiserte, er fjernet"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Innlegget ditt er fjernet"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Svaret ditt er fjernet"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("svarte på innlegget ditt"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Vi har grepet inn mot noe du rapporterte. Takk for at du sa ifra."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Vi har sett på noe du rapporterte, og fant ikke at det brøt reglene våre."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Rapportert for: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("delte innlegget ditt"),
      "ui_notif_reversed":
          MessageLookupByLibrary.simpleMessage("Vi har omgjort sak \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Kontoen din er suspendert"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Kontoen din er suspendert til \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Alle"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Følgere"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Likerklikk"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("Omtaler"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Svar"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Denne uken"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("I dag"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Kontoen din har fått en advarsel"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("I går"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Fullfør"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Hopp over"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Dette er allerede åpnet."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Utløpt"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Dette kunne ikke åpnes."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Åpnes én gang og slettes deretter fra Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Vis én gang"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Åpnet"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Åpnet av \$count av \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Bare de du sendte det til, kan åpne det, én gang."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Send for visning én gang"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Trykk for å se"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pause"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Spill av"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Det fjernes fra profilen din og fra alle andres feeder. Svarene på det forsvinner også."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Innlegget er slettet"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Innlegget er skjult"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Innleggstekst kopiert"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Publisert mellom"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Skjult. Vi viser deg færre lignende."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Innstillinger"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Personvern"),
      "ui_report_add":
          MessageLookupByLibrary.simpleMessage("Noe å legge til? (valgfritt)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Du får et varsel når teamet har bestemt seg, og du kan følge saken under Rapportene dine."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Hvis du heller ikke vil se personen, kan du dempe eller blokkere vedkommende fra samme meny."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Å rapportere det samme to ganger gir det ikke mer vekt: vi beholder én rapport per person."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Rapporten din deles ikke med personen. Vi beholder en kopi av det du rapporterte, slik at det kan gjennomgås selv om det slettes."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Rapporten din er mottatt og står i kø for gjennomgang. Vi forteller ikke personen hvem som rapporterte."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Se rapportene dine"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Fortell oss hva som er galt"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Takk for at du sa ifra"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Hva er galt med \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Hva er galt med denne meldingen?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Hva er galt med dette innlegget?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("Hva er galt med dette svaret?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "En melding i en community-chat"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Et innlegg"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Et svar"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Tiltak iverksatt"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("En konto"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Avgjort \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Ingen regler brutt"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Rapportene dine kunne ikke lastes inn"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Det du har rapportert de siste 90 dagene, og hva som skjedde. Du får et varsel når teamet bestemmer seg. Den du rapporterer, får aldri vite hvem som rapporterte."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Ingenting rapportert"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Når du rapporterer et innlegg, et svar, en melding eller en konto, vises det her med hva som skjedde."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("Under vurdering"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Rapportert \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Det du har rapportert, og hva som skjedde"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Rapportene dine"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Barns sikkerhet"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Alt som setter mindreårige i fare eller seksualiserer dem."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Målrettet trakassering, trusler eller uønsket kontakt."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Angrep på mennesker for den de er."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Salg eller markedsføring av noe ulovlig."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Å utgi seg for å være noen andre."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Bruker verket eller varemerket ditt uten tillatelse."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Villedende påstander om helse, valg eller hendelser."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Å oppmuntre til eller vise selvskading."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Seksuelt innhold vist uten advarsel."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Ingen av disse. Fortell oss hva som er galt."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Gjentatt, villedende eller uønsket markedsføring."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Å true med, forherlige eller oppfordre til vold."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Trakassering eller mobbing"),
      "ui_rule_hate":
          MessageLookupByLibrary.simpleMessage("Hatefulle ytringer"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Ulovlige varer eller tjenester"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Utgir seg for å være en annen"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Immaterielle rettigheter"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Falsk informasjon"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Selvmord eller selvskading"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Innhold for voksne"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Noe annet"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Søppel"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Vold eller trusler"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("Lagrede innlegg"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Trykk på arkivikonet på et innlegg for å beholde det her. Bare du ser det du lagrer."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Søk etter brukernavn eller visningsnavn."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Tøm"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Søk i alt som er publisert"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filtre"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("Søk etter folk"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("Søk i innlegg"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Innstillinger"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("App og enhet"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Innhold og visning"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Datasparing"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Fortell oss hva du synes"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Bla gjennom hjelpeartikler"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Velg språket ditt"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Hvem du har dempet eller blokkert"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Varselinnstillinger"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Profilen og kontaktopplysningene dine"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Du må logge inn på nytt for å komme tilbake til kontoen din."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Sikkerhetsinnstillinger"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Bekreft passord"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("På én linje"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Ny e-postadresse"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Nytt passord"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Hva som skjedde"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Få hjelp fra teamet vårt"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Del"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Siter"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Send i en melding"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Til folk på Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Del dette innlegget"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Hva det gjaldt"),
      "ui_standing_account_banned":
          MessageLookupByLibrary.simpleMessage("Kontoen din er utestengt"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Svaret, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Klage"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Klag på denne avgjørelsen"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Denne avgjørelsen kan ikke lenger påklages. Hvis noe er galt, kontakt brukerstøtte."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Klagen behandles"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Klagen er tatt til følge"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Noen andre i teamet ser på det igjen. Du får et varsel når det er avgjort."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Hvis du mener dette var en feil, kan du be om ny vurdering fram til \$date. Noen andre i teamet avgjør."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Påklaget: avgjørelsen står ved lag"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Sak \$number. Regel: \$rule. Teamet skrev:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Å slette kontoen din opphever ikke en utestengelse: en ny konto med samme e-postadresse blir også utestengt."),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("Utestengt"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Bare denne siden, klager, brukerstøtte og sletting av kontoen virker fortsatt."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Kan påklages"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Sak \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Avgjort \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Avgjørelser om kontoen din"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Slett kontoen din"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Se detaljer"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Se detaljer og klag"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Slutter \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Kontoen din er i god stand"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Ingenting begrenser den."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn kontostatus"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Meldingen er fjernet"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Ingenting er avgjort om kontoen din. Hvis teamet noen gang fjerner noe av ditt eller begrenser kontoen din, står det her med begrunnelsen, og du kan klage."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Ingenting å klage på: avgjørelsen er omgjort."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Innlegget er fjernet"),
      "ui_standing_pull_to_check":
          MessageLookupByLibrary.simpleMessage("Dra ned for å sjekke igjen."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Les Kyrons regler"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Svaret er fjernet"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Omgjort"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Omgjort \$date. Alt som ble fjernet er tilbake, og ingen begrensninger gjelder lenger."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("Regel: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Logg ut"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Suspendert"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Du kan lese, men ikke publisere, svare, følge eller sende meldinger. Rapportering, blokkering og demping virker fortsatt."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Kontoen din er suspendert: du kan lese, men ikke publisere."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Suspendert til \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Kontoen din er suspendert til \$date: du kan lese, men ikke publisere."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Hva teamet skrev"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("Kontostatus"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Advarsel"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Hvorfor?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Du skrev, \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Meldingen din"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Innlegget ditt"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Svaret ditt"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Vilkår"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("dette innlegget"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Tråden er dempet"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Prøv igjen"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("Slå av lyd"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Slå på lyd"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("To tegn eller flere."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Angre"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Ord, eller et filter: en konto, et datointervall eller hva et innlegg inneholder."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Angre deling"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Oppdater passord"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Bruk en annen adresse"),
      "username": MessageLookupByLibrary.simpleMessage("Brukernavn"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Brukernavnet må være små bokstaver (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Legg ved"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Klar til å legges ved"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Ta opp et taleinnlegg"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Tar opp…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Stopp"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Hva som skjedde"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Hva skjedde, og hva bør vi se på?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Hva er på dette bildet?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Hva er den til? (valgfritt)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Hva du gjorde, hva du forventet, hva som skjedde"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Hva du holdt på med da det skjedde."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Du svarte"),
      "dmReplied": (Object a0) => "$a0 svarte",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Legg til i melding"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Ny melding"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Ingenting er sagt ennå. Et vink er en god start."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Vink"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Nye meldinger"),
      "dmTyping": (Object a0) => "$a0 skriver",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Fjern reaksjonen din"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Noen"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Melding"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("Vedlegg"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Denne meldingen kan ikke leses på denne enheten."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Venter på denne meldingen. Dette kan ta litt tid."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Kryptert melding"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Meldinger er ende-til-ende-krypterte"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Ikke ende-til-ende-kryptert"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Sendt"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Sett"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Sender…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Ta et bilde"),
      "ui_media_more":
          MessageLookupByLibrary.simpleMessage("Flere alternativer"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("Lagre på enheten"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Del"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Lagrer…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Lagret i bildene dine"),
      "ui_media_save_failed":
          MessageLookupByLibrary.simpleMessage("Kunne ikke lagre. Prøv igjen."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "La Kyron legge til i bildene dine for å lagre dette."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Alle systemer i drift"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Oppetid"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Siste 60 dager"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("For 60 dager siden"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("I dag"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Database"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Innlogging"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Nylige hendelser"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Ingen hendelser de siste 60 dagene."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Pågår"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Ingen data"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Detaljer"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron sjekker seg selv hvert 5. minutt mens den kjører. En grå dag hadde ingen sjekker."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Oppetidshistorikk er ikke tilgjengelig ennå."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Noen systemer har problemer"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Ta opp en talemelding"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Klar til å sende"),
      "ui_dm_quote_gone": MessageLookupByLibrary.simpleMessage(
          "Den meldingen er ikke her lenger."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Gå til meldingen"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("Talemelding"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Likt av forfatteren"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Legg til et bilde eller klipp"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Medier"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Talemeldinger"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Bakgrunn"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Demp varsler"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Slutt å få varsler om denne samtalen"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "De kan ikke lenger sende deg meldinger"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Ingen"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Bilde"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Demping opphevet."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke fjerne den. Prøv igjen."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profil"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Opphev demping"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Bilder og klipp du deler, vises her."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("Se alle"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Bilder og klipp"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Slik kommer chatten din til å se ut."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Ser bra ut."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Tåke"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Skumring"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Salvie"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Sand"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Prikker"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Bruk"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Nåværende"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Send uten forhåndsvisningen"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Søk"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Publiser"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Skriv en melding…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Send"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Sendt"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Sendt, men ikke til alle."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Det kunne ikke sendes. Prøv igjen."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Følger"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtrer"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Alle"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Uleste"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Ubesvarte"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Skjulte"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Ingenting skjult"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Samtaler du fjerner fra listen, venter her i tilfelle du vil ha dem tilbake."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Den flyttes til Skjulte. Den andre beholder sin, og den kommer tilbake hvis en av dere skriver igjen."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Legg tilbake"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Tilbake i listen din."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Ingen samtaler passer."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Ingenting venter på deg"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Alle samtaler slutter med ditt ord."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Bilde"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Bilder"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Ingen meldinger ennå"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Du:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("I går"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Meldinger"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Meldingsinnstillinger"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Personvern"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Lesebekreftelser"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Når dette er av, ser ikke andre når du har lest meldingene deres, og du ser ikke når de har lest dine."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Vis når du skriver"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Den du skriver til, ser at du skriver."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Forhåndsvisning av lenker"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Telefonen din åpner en lenke du sender for å lage forhåndsvisningen, så nettstedet ser at telefonen din spør. Kyrons server ser aldri lenken."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Varsler om meldinger"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Meldinger er ende-til-ende-kryptert. Kyron kan ikke lese dem, og ingenting her endrer det."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Til:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Nylige"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Personer"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Ingen med det navnet."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Send et testvarsel"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyrons server er ennå ikke satt opp til å sende varsler, så ingen kan komme frem. Feilen er hos oss, ikke i telefonen din."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Denne telefonen er ikke registrert for varsler. Sjekk at varsler for Kyron er tillatt i telefonens innstillinger, og prøv igjen."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Varselet kunne ikke leveres til denne telefonen. Prøv igjen om et minutt."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Sendt. Det bør komme frem i løpet av noen sekunder."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Varsler fungerer."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Ingen innlegg ennå"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Nytt fellesskap"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Navn"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Adressen lages av navnet."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Folk finner det på"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Du eier det. Et bilde, et banner og moderatorer kan legges til fra siden når det finnes."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Hjem"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Fellesskapsinnlegg i Hjem"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Innlegg fra fellesskapene dine vises også i Hjem. Slått av blir de her i Fellesskap, der hvert enkelt viser hva som er nytt."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Listen din"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Antall nye innlegg"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Vis hvor mange innlegg som er nye i hvert fellesskap siden du sist åpnet det."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Fellesskap du styrer"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Fellesskap du starter eller modererer, står her."),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("Eier"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderator"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Nye innlegg"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("De du styrer"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Innstillinger for fellesskap"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Utforsk"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Ingen fellesskap passer."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Ingenting nytt"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Hvert fellesskap er som du forlot det."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Du styrer ingen ennå"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Ingenting igjen å bli med i"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Du er med i alle fellesskap på Kyron. Start et nytt."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Prøv et annet ord, eller start et fellesskap med det navnet."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Skriv et innlegg"),
      "ui_community_members":
          MessageLookupByLibrary.simpleMessage("Medlemmer:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Publisert"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Vis"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Åpne"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Pålogget"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Vis når du er pålogget"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Folk du skriver med, ser en grønn prikk mens du har Kyron åpen. Når dette er av, ser du heller ikke deres."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Søk etter folk og innlegg"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Fellesskap du kan bli med i"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Ingenting å se ennå"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Bilder og klipp som folk legger ut, vises her."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Følg"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("Slett konto"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Dette sletter Kyron-kontoen din permanent. Det kan ikke angres."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Profilen din, innleggene, svarene, likerklikkene og delingene dine"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Meldingene dine, også de du har sendt til andre, og bildene og talemeldingene i dem"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Følgerne dine, personene du følger, og innstillingene dine"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Fellesskap du har startet, går til moderatoren eller medlemmet som har vært med lengst. Et fellesskap uten andre medlemmer stenges."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Vil du slette kontoen din?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Du får ikke tilbake noe av det."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Kontoen din er slettet."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Slettet konto"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Denne kontoen er slettet, så det kan ikke lenger sendes meldinger hit."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Registrert med Google? Bruk «Sign in with Google» i stedet."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Den linsen kunne ikke lastes inn."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Videoen kunne ikke tas opp."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Linsen kunne ikke legges til i videoen, så den publiseres slik den ble filmet."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Innlegget ditt har allerede så mange vedlegg som det kan ha."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Legger til linsen din…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Blits"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("Ta opp en video"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Bilde"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Video"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Pålogging med Google ble avbrutt."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("GAVER"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Ingen har sendt dette innlegget en gave ennå."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Gave"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Gaver"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Mynter"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Avsender"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Avsendere"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Testmynter: de kan ikke tas ut ennå."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Lagret"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Innlegg"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Kommentarer"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Se flere svar"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Redigert"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Mer"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Følger"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Topp"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Nyeste"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Sorter kommentarer: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "sendte en gave til innlegget ditt"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "sendte en \$gift til kommentaren din"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "sendte en \$gift til innlegget ditt"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Send en gave"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Rediger innlegg"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Du kan redigere det i \$n min til"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Lagre"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Ingenting er publisert under #\$tab ennå."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Velg en gave"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Ikke nok mynter"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Testmynter: de kan ikke kjøpes og har ingen pengeverdi."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Fylles på \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 mynt"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count mynter"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("Du har \$coins"),
      "ui_gift_send_named": MessageLookupByLibrary.simpleMessage("Send \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift sendt"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Prøv igjen"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "I 15 minutter etter publisering"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Redigert"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn de lagrede kommentarene dine"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Ingen lagrede kommentarer"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Trykk på arkivikonet under en kommentar for å beholde den her. Bare du ser det du lagrer."),
      "ui_replying_to": MessageLookupByLibrary.simpleMessage("Svarer \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Kopier"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Søk"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Merk alt"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count gaver"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 gave"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn flere innlegg."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Påminnelser"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Hva som er nytt når du har vært borte, og når myntene dine er tilbake. Aldri mer enn én om dagen."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Gaver"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("fra 1 person"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("fra \$count personer"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Største giver"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn hvem som sendte gaver."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Nyheter"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Skjønner"),
      "ui_check_in_thanks":
          MessageLookupByLibrary.simpleMessage("Takk. Vi leser hvert svar."),
      "ui_check_in_title": MessageLookupByLibrary.simpleMessage(
          "Hva synes du om Kyron så langt?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Dag \$day av testen din. Ett trykk er nok."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Noe vi bør fikse eller legge til? (valgfritt)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Send"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Ikke nå"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Trykk tilbake igjen for å forlate Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Bekreft at det er deg"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Skriv inn passordet ditt for å slette kontoen."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Logg på med Google igjen for å slette kontoen."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Det fungerte ikke. Sjekk og prøv igjen."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Denne siden vil åpne en annen app"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Den ber om å åpne en {scheme}-lenke."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("Bygg"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "{size} med bufrede bilder og filer"),
      "ui_about_freed": MessageLookupByLibrary.simpleMessage("{size} frigjort"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("Måler …"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("Ingenting å tømme"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("Lagring"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("Versjon {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("Blokkerte"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("Du publiserer som deg selv"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "Vedleggene ble ikke lastet opp. Trykk på ett for å prøve igjen, eller fjern det."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke endre e-postadressen. Prøv igjen."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "Adressen endres når du følger lenken vi sender."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "Se etter en bekreftelseslenke i {email}."),
      "ui_email_enter":
          MessageLookupByLibrary.simpleMessage("Skriv inn en e-postadresse."),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage(
          "Det ser ikke ut som en e-postadresse."),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "Det er allerede e-postadressen din."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "Hva du gjorde, hva du forventet, og hva som skjedde i stedet."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "La meg feste et innlegg på profilen min"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "Hva du ønsker deg, og hva det ville la deg gjøre."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("Hva ville hjulpet"),
      "ui_feedback_kind_bug":
          MessageLookupByLibrary.simpleMessage("Et problem"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("En idé"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("Et spørsmål"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "Bare Kyron-teamet leser dette. Det sendes med kontoen din, så vi kan svare på e-post, og med versjonen av appen du bruker. Sletter du kontoen, slettes det også."),
      "ui_feedback_question_example":
          MessageLookupByLibrary.simpleMessage("Hvordan demper jeg et ord?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "Hva du prøver å gjøre, og hvor du står fast."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("Spørsmålet ditt"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke nå Kyron. Sjekk tilkoblingen og prøv igjen. Ingenting er skrevet ennå, så ingenting går tapt."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("Tøm"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Mislykkede forespørsler og andre viktige hendelser vises her."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("Dempet"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "Legg til et ord eller en tagg ovenfor. Innlegg med det holdes unna feeden din."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "Innlegg som inneholder noen av disse holdes unna feeden din. Store og små bokstaver ignoreres, og et ord treffer også inne i lengre ord, så «spoiler» fanger også «spoilers»."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("Ingen blokkert"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "Blokkering skjuler dere for hverandre, begge veier. Blokker noen fra menyen på profilen deres."),
      "ui_nobody_muted": MessageLookupByLibrary.simpleMessage("Ingen dempet"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "Å dempe en konto skjuler innleggene deres uten å si fra. Demp noen fra menyen på profilen deres eller et innlegg."),
      "ui_password": MessageLookupByLibrary.simpleMessage("Passord"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("De samsvarer ikke."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "Du forblir pålogget på denne enheten. Andre enheter logges ut."),
      "ui_password_too_short":
          MessageLookupByLibrary.simpleMessage("Bruk minst 8 tegn."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke oppdatere passordet. Prøv igjen."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("Passordet er oppdatert."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID kopiert"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "Innlegg du liker, tas vare på her, bare for deg."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "Du har ikke publisert noen bilder eller klipp."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} har ikke publisert noen bilder eller klipp."),
      "ui_profile_empty_posts_mine":
          MessageLookupByLibrary.simpleMessage("Alt du publiserer, vises her."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} har ikke publisert noe ennå."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn profilen din"),
      "ui_profile_load_failed_other": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn @{handle}"),
      "ui_pw_rule_length": MessageLookupByLibrary.simpleMessage("Minst 8 tegn"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("Liten bokstav (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("Minst ett tall"),
      "ui_pw_rule_symbol":
          MessageLookupByLibrary.simpleMessage("Symbol (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("Stor bokstav (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "{count} nylige oppføringer. Se gjennom dem under Om › Systemlogg før du sender."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "Bare Kyron-teamet leser dette. Det sendes med kontoen din, så vi kan følge opp. Les loggen først under Om › Systemlogg hvis du vil se nøyaktig hva som sendes med."),
      "ui_report_sent": MessageLookupByLibrary.simpleMessage("Sendt, takk."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "Sendt, takk. Det er rapport #{number}."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("Hva gikk galt?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "Versjon, retningslinjer, status og systemloggen"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "Ikke la videoer spille av seg selv mens du blar"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "Din desentraliserte identifikator"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("Moderering"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "Rapporter og klager som venter på gjennomgang"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "Hold innlegg med disse unna feeden din"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("Ikke pålogget"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("Varslingsinnstillinger"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("Personvern og sikkerhet"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "Avgjørelser om kontoen din, og klager"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("Juster tekststørrelse"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("Kontoen din"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "Opptak og publisering av AR-linser er fortsatt under arbeid. Ingenting du tar opp, ville blitt lagret ennå, så kameraet forblir lukket."),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("Linser er ikke klare ennå"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR-linse"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "Å gå direkte krever en medieserver Kyron ikke kjører ennå. Å starte en sending nå ville satt deg i et rom ingen kan bli med i. Å ta opp et lydinnlegg fungerer allerede i dag."),
      "ui_soon_live_heading": MessageLookupByLibrary.simpleMessage(
          "Direktesending er ikke klart ennå"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("Gå direkte"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Avstemninger trenger et sted å lagre alternativene og telle stemmene. Det er ikke på plass ennå, så en avstemning publisert i dag ville mistet hvert svar."),
      "ui_soon_poll_heading": MessageLookupByLibrary.simpleMessage(
          "Avstemninger er ikke klare ennå"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("Avstemning"),
      "ui_soon_write_instead": MessageLookupByLibrary.simpleMessage(
          "Skriv et tekstinnlegg i stedet"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("Sjekk igjen"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("Detalj"),
      "ui_status_mirror": MessageLookupByLibrary.simpleMessage("Speiltabeller"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron svarte, men noe er ikke som det skal."),
      "ui_status_round_trip": MessageLookupByLibrary.simpleMessage("Tur-retur"),
      "ui_support_ask":
          MessageLookupByLibrary.simpleMessage("Still et spørsmål"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Om kontoen din, eller hvordan noe fungerer"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("På e-post"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Hvis Kyron krasjet: sender appens logg med"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("I appen"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "Skriv til Kyron-teamet herfra. Det når oss privat, med kontoen din, og vi svarer til e-postadressen på den."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "Ingen e-postapp åpnet seg. {address} er kopiert."),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("Personvern og dataene dine"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("Rapporter et problem"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "Noe er ødelagt eller gjør ikke det det skal"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "Bruk menyen på et innlegg eller en konto for å rapportere det: da vet vi nøyaktig hvilken du mener."),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("Sikkerhet og misbruk"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Om Kyron er nede for alle, eller bare for deg"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("Stor"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("Større"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("Middels"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron er et sted for å si noe som er verdt å lese."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("Liten"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Alltid mørk"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("Dempet"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "En mykere mørk, blågrå i stedet for svart"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Alltid lys"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Følg telefonens egen innstilling for lys eller mørk"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("Opphev blokkering"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("Opphev demping"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("Hvem du er"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "Med dine egne ord: hva den som vurderer, bør vite."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "Jeg skriver om fugler her og på min egen nettside."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("Legg til en lenke til"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "Du kan spørre igjen fra {date}."),
      "ui_verify_ask":
          MessageLookupByLibrary.simpleMessage("Be om verifisering"),
      "ui_verify_before": MessageLookupByLibrary.simpleMessage("Før du spør"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("Skaper"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("Journalist"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("Organisasjon eller merkevare"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("Noe annet"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("Offentlig person"),
      "ui_verify_denied": MessageLookupByLibrary.simpleMessage(
          "Forespørsel {number} ble ikke godkjent"),
      "ui_verify_done":
          MessageLookupByLibrary.simpleMessage("Du er verifisert"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("Rediger profilen din"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("Skriv inn den 6-sifrede koden"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "Send koden på nytt om {seconds} sekunder"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("Vi sendte den til {email}"),
      "ui_verify_email_verify": MessageLookupByLibrary.simpleMessage("Bekreft"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Bli verifisert på Kyron"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Bli"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("verifisert"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("på Kyron."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "Merket viser at noen i Kyron-teamet har sjekket at kontoen er den den sier den er. Det gir ingen ekstra rekkevidde, og det er ikke til salgs."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "Merket blir værende så lenge navnet ditt gjør det. Bytter du navn, forsvinner det til noen har sjekket det nye."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("Hvor vi kan sjekke"),
      "ui_verify_link_more":
          MessageLookupByLibrary.simpleMessage("En lenke til"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "En nettside eller en annen profil som sier at denne Kyron-kontoen er din: legg Kyron-navnet ditt, eller en lenke til profilen din, der. Kyron ber aldri om ID-dokumenter."),
      "ui_verify_load_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke laste inn statusen din"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "Alt ovenfor må være huket av før du kan spørre."),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "En konto som er minst {days} dager gammel"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("En bio som sier hvem du er"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("Navnet ditt på profilen"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("Et profilbilde"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "Ingenting på deg de siste {days} dagene"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "Sendt. Et menneske ser på det."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("Siden {date}."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("Spør"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Hvem du er, og en lenke\nsom beviser det"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("Merket"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "Ved siden av navnet ditt,\noveralt der det vises"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("Et menneske\nsjekker"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "Noen i teamet\nfølger lenkene dine"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("Verifisering"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "Forespørsel {number} ligger hos et menneske"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "Sendt {date}, som {category}. Du får et varsel når det er avgjort."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("Trekk tilbake forespørselen"),
      "ui_verify_withdrawn": MessageLookupByLibrary.simpleMessage(
          "Forespørselen er trukket tilbake."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke fullføre opptaket: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("Opptil ti minutter."),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("Lytter …"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron trenger tillatelse til å bruke mikrofonen for å ta opp. Du kan gi den i enhetsinnstillingene."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke starte opptaket: {error}"),
      "ui_2fa_title": MessageLookupByLibrary.simpleMessage("Totrinnspålogging"),
      "ui_2fa_help": MessageLookupByLibrary.simpleMessage(
          "En autentiseringskode for verktøy for ansatte"),
      "ui_2fa_intro": MessageLookupByLibrary.simpleMessage(
          "Verktøy for ansatte ber om en kode fra en autentiseringsapp i tillegg til påloggingen din, slik at et stjålet passord alene ikke kan bruke dem."),
      "ui_2fa_on":
          MessageLookupByLibrary.simpleMessage("Totrinnspålogging er på."),
      "ui_2fa_remove": MessageLookupByLibrary.simpleMessage("Fjern"),
      "ui_2fa_set_up": MessageLookupByLibrary.simpleMessage("Konfigurer"),
      "ui_2fa_scan": MessageLookupByLibrary.simpleMessage(
          "Skann dette med autentiseringsappen din, eller skriv inn nøkkelen nedenfor. Legg den til i to apper hvis du kan: mister du den eneste, må du be brukerstøtte om å fjerne den."),
      "ui_2fa_key": MessageLookupByLibrary.simpleMessage("Oppsettsnøkkel"),
      "ui_2fa_copied":
          MessageLookupByLibrary.simpleMessage("Oppsettsnøkkel kopiert"),
      "ui_2fa_confirm": MessageLookupByLibrary.simpleMessage("Bekreft"),
      "ui_2fa_failed": MessageLookupByLibrary.simpleMessage(
          "Kunne ikke starte oppsettet. Prøv igjen."),
      "ui_2fa_wrong": MessageLookupByLibrary.simpleMessage(
          "Den koden fungerte ikke. Sjekk klokkeslettet på telefonen og prøv igjen."),
      "ui_2fa_code": MessageLookupByLibrary.simpleMessage("6-sifret kode"),
      "ui_2fa_enter": MessageLookupByLibrary.simpleMessage(
          "Skriv inn koden fra autentiseringsappen din"),
      "ui_2fa_verify": MessageLookupByLibrary.simpleMessage("Bekreft"),
      "ui_password_breached": MessageLookupByLibrary.simpleMessage(
          "Dette passordet har dukket opp i en datalekkasje, så det er blant de første angripere prøver. Velg et annet."),
    };

final messageLookup = MessageLookup();
