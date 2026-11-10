import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'lv';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Vārds, frāze vai #birka"),
      "about": MessageLookupByLibrary.simpleMessage("Par"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Pievienot atbildi"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Pievienot valodas…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Piekrist un turpināt"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Jau ir Kyron konts?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Komentāri"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Dažādi cilvēki, nevis atvēršanas reizes"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("Iesaiste"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Patīk"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Vēl nav skatītāju"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Šo ziņu vēl neviens nav atvēris."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Publicēts"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Saglabājumi"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Skatītāji"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("SKATĪTĀJI DIENĀ"),
      "and": MessageLookupByLibrary.simpleMessage("un"),
      "answerNumber": (Object a0) => "${a0}. atbilde",
      "arLens": MessageLookupByLibrary.simpleMessage("AR lēca"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Pievienot lietotnes žurnālu"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Turp un atpakaļ laiks"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("MARĶIERA PĀRBAUDE"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Mēģināt vēlreiz"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Mēģināt vēlreiz"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Sākot raidījumu tagad, jūs nonāktu telpā, kurā neviens nevarētu"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Izveidot kopienu"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage(
              "Kam tas paredzēts? (neobligāti)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("atgriezties."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("atgriezties no šī saraksta."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Ja to slēgsiet,"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("vispirms pievienojieties"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("drīzumā"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Publicējat savā vārdā"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("publicēt šajā kopienā"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Tikko"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Mēģināt vēlreiz"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("1. tēma"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Jums"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("kaut kas ir."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("jau ir ceļā."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", nevis"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("vai es kustos"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Izslēgt skaņu"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Ieslēgt skaņu"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Jums"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Jūsu cilnes"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Mēģināt vēlreiz"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Simbols (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("SKATĪTĀJI DIENĀ"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("neizdevās ielādēt"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("šī ziņa"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Vai ko vēlaties piebilst? (neobligāti)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("šī ziņa"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("No konta"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Izrakstīties"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Jūsu konts"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Apstipriniet paroli"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("ne tagad"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Notiek ielāde…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Notiek publicēšana…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("pirms 3 h"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Kopēt stāsta saiti"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Jūsu stāsts"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Jūsu konts, jūsu ziņas un tas, ko pieskaraties, lai"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Pievienot tēmu"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("savu."),
      "authorBlocked": (Object a0) => "${a0} bloķēts",
      "authorPostsHidden": (Object a0) => "Jūs neredzēsiet ${a0} ziņas",
      "block": MessageLookupByLibrary.simpleMessage("Bloķēt"),
      "blockAuthor": (Object a0) => "Bloķēt ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Būvējuma informācija nokopēta"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Turpinot jūs piekrītat"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Turpinot jūs piekrītat mūsu Pakalpojuma noteikumiem un Privātuma politikai"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Reģistrējoties jūs piekrītat"),
      "cancel": MessageLookupByLibrary.simpleMessage("Atcelt"),
      "change": MessageLookupByLibrary.simpleMessage("Mainīt"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Mainīt e-pastu"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Apstipriniet kontu no e-pasta."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Pārbaudīt, vai Kyron ir sasniedzams"),
      "clear": MessageLookupByLibrary.simpleMessage("Notīrīt"),
      "close": MessageLookupByLibrary.simpleMessage("Aizvērt"),
      "closeCommunity": (Object a0) => "Slēgt ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Slēgt"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Slēgt šo kopienu"),
      "communities": MessageLookupByLibrary.simpleMessage("Kopienas"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Atrodiet kādu sadaļā Izpētīt vai izveidojiet savu."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Izsakiet karstu viedokli (vai remdenu)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Ko jūs domājat?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Sakiet to, ko varat pateikt tikai jūs…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("Šī ir jūsu zīme: publicējiet"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Rakstiet, runājiet vai domājiet skaļi"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Apstipriniet paroli"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Sazināties ar atbalstu"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Ziņām vēl nav valodas, tāpēc tas vēl nefiltrē jūsu plūsmu. Jūsu izvēle līdz tam tiek saglabāta."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Turpināt"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Turpināt ar e-pastu"),
      "copy": MessageLookupByLibrary.simpleMessage("Kopēt"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Tā vietā kopēt ziņojumu"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Neizdevās atvērt Google pierakstīšanos. ${a0}",
      "couldNotSignOut": (Object a0) => "Izrakstīšanās neizdevās: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Neizdevās uzņemt fotoattēlu."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Tiek rādīta tavā profilā un zem taviem ierakstiem."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Neviena valsts neatbilst “{query}”."),
      "country_none": MessageLookupByLibrary.simpleMessage("Nerādīt valsti"),
      "country_search": MessageLookupByLibrary.simpleMessage("Meklēt valstis"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Tiek rādīta tavā profilā un zem taviem ierakstiem. Kad redzi kāda ierakstus, tava valsts tiek ieskaitīta viņa Ieskatos, tikai vismaz piecu cilvēku grupās un nekad ar vārdu."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("No tava tālruņa iestatījumiem"),
      "create": MessageLookupByLibrary.simpleMessage("Izveidot"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Izveidot kontu"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Izveidojiet kontu"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Izveidojiet profilu"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR lēca"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Sākt tiešraidi"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("Teksta ziņa"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("Balss ziņa"),
      "delete": MessageLookupByLibrary.simpleMessage("Dzēst"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Dzēst šo komentāru?"),
      "deleteThisPost": MessageLookupByLibrary.simpleMessage("Dzēst šo ziņu?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Aprakstiet šo pielikumu"),
      "description": MessageLookupByLibrary.simpleMessage("Apraksts"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID nokopēts starpliktuvē"),
      "done": MessageLookupByLibrary.simpleMessage("Gatavs"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Aizveriet redaktoru pēc tam, kad kaut ko uzrakstāt, un jums tiks piedāvāts melnraksts."),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("pirms {days} d."),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("pirms {hours} h"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Tikko"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("pirms {minutes} min"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Vēl nekas nav uzrakstīts"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Aptauja, vēl bez jautājuma"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Citāts, vēl bez teksta"),
      "drafts": MessageLookupByLibrary.simpleMessage("Melnraksti"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Rediģēt profilu"),
      "email": MessageLookupByLibrary.simpleMessage("E-pasts"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("E-pasta paziņojumi"),
      "explore": MessageLookupByLibrary.simpleMessage("Izpētīt"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Sejas izsekošana šajā ierīcē nav pieejama."),
      "feedTagDetail": (Object a0) => "Ar #${a0} vēl nekas nav publicēts.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Sekot {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Sekotāji"),
      "following": MessageLookupByLibrary.simpleMessage("Sekojat"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Aizmirsāt paroli?"),
      "gettingHelp":
          MessageLookupByLibrary.simpleMessage("Kā saņemt palīdzību"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Turpināt ar Google"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Pierakstīties ar Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google atgriež pabeigto pierakstīšanos Kyron, izmantojot saiti, uz kuru atbild tikai Android un iOS, tāpēc platformā ${a0} pārlūkam nav kur to atgriezt.\\n\\nJa jums jau ir Kyron konts ar Google, izvēlieties Turpināt ar e-pastu ar to pašu adresi un pieskarieties Aizmirsāt paroli: saņemsiet saiti paroles iestatīšanai.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google pierakstīšanās darbojas tālruņa lietotnē"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Reģistrēties ar Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Ceļveži un atbildes uz biežiem jautājumiem"),
      "handle": MessageLookupByLibrary.simpleMessage("lietotājvārds"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Palīdzība un atbalsts"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Palīdzības centrs"),
      "home": MessageLookupByLibrary.simpleMessage("Sākums"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("Vienā rindā"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Jūsu konts"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Atvērt kopienu"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Rakstīt ierakstu"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Skatīt ierakstu"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Rediģēt profilu"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Kad viņi ir klāt"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Jūsu laika joslā."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Vecumi"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "No {known} sasniegtajiem cilvēkiem, kuri norādījuši dzimšanas dienu."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Sasniegtie cilvēki dienā"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Kopienas, kurās viņi ir"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Valstis"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "No {known} sasniegtajiem cilvēkiem, kuru profilā ir norādīta valsts."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Pēdējās {days} dienas"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("Ieskatus neizdevās ielādēt"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Sekotāji"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Vēl nav pietiekami lielas grupas, ko parādīt."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Kā augt"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Tēmas, kurām viņi seko"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Patīk"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Jauns"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Jauni sekotāji"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Šajā periodā neviens jūsu ieraksts nevienu nesasniedza."),
      "ins_non_followers": MessageLookupByLibrary.simpleMessage("Jums neseko"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Valstis ir tās, ko cilvēki izvēlējušies savos profilos. Kyron nevāc neviena pilsētu vai dzimumu, tāpēc par tiem nav ko parādīt."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Atvēršanas"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "sasniegti {reach} · {likes} patīk · {replies} atbildes"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Sasniegtie cilvēki"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Katrs cilvēks tiek skaitīts vienreiz: viņam pirmo reizi parādīta vai viņš pirmo reizi atvēra kādu jūsu ierakstu. Jaunie sekotāji jums joprojām seko; sekošanas pārtraukšana netiek skaitīta."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Atbildes"),
      "ins_reposts":
          MessageLookupByLibrary.simpleMessage("Atkārtotas publicēšanas"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Saglabāšanas"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Kas ir jūsu auditorija, tiek parādīts, kad šajā periodā jūsu ierakstus redzējuši {floor} cilvēki. Ar mazāku skaitu tas varētu norādīt uz kādu konkrētu."),
      "ins_small_title": MessageLookupByLibrary.simpleMessage(
          "Vēl nav pietiekami daudz cilvēku"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% no viņiem jums jau seko: jūsu ieraksti galvenokārt sasniedz pazīstamus cilvēkus."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% no viņiem jums vēl neseko: jūsu ierakstus atrod."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Sasniedzāt {reach} cilvēkus, par {pct}% mazāk nekā iepriekšējā periodā."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Pēdējās {days} dienās sasniedzāt {reach} cilvēkus."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Sasniedzāt {reach} cilvēkus, aptuveni tikpat kā iepriekšējā periodā."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Pēdējās {days} dienās neviens jauns jūsu ierakstus neredzēja."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Sasniedzāt {reach} cilvēkus, par {pct}% vairāk nekā iepriekšējā periodā."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Sasniedzāt {reach} cilvēkus, {times}× vairāk nekā iepriekšējā periodā."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Vairāk no viņiem seko tēmai {name} nekā jebkurai citai."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Auditorija"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Pārskats"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Cilvēki, kas atrod kādu jūsu ierakstu, pirms sekošanas apskata jūsu profilu. Seja vai logotips viņiem pasaka, ka tur kāds ir."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Pievienojiet profila attēlu"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Vienā rindā pasakiet, par ko publicējat, lai svešinieks zinātu, ko viņam dos sekot jums."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Uzrakstiet aprakstu"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} no jūsu {total} ierakstiem nebija tēmas. Tēma ieliek ierakstu tēmas plūsmā un to sekotāju priekšā."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Pievienojiet ierakstiem tēmas"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} cilvēki atbildēja uz jūsu ierakstiem, un jūs atbildējāt {answered}. Viņiem rūpēja pietiekami, lai rakstītu: atbilde lasītāju padara par pastāvīgu apmeklētāju."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Atbildiet uz atbildēm"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Jūsu auditorija ir visaktīvākā {when}. Ierakstam, kas publicēts nedaudz pirms tam, būs, kas to sagaida."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Publicējiet, kad viņi ir klāt"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} cilvēki, kas jums neseko, redzēja jūsu ierakstus, un {gained} sāka sekot. Lai jūsu apraksts un jaunākie ieraksti pasaka, ko no jums gaidīt."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Pārvērtiet lasītājus sekotājos"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Viens ieraksts sasniedza {times}× vairāk cilvēku nekā parasti citi. Paskatieties, ko tas darīja citādi, un dariet to vairāk."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Dariet vairāk tā, kas izdevās"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Daudzi, kas redz jūsu ierakstus, ir kopienā {name}. Publicējot tur, jūs nonāksiet arī pārējo priekšā."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Publicējiet kopienā {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "{days} dienās publicējāt {posts} reizes. Katrs ieraksts ir vēl viena iespēja tikt atrastam, un vienmērīgs ritms notur jūs sekotāju plūsmās."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Publicējiet biežāk"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Pēdējās {days} dienās neko neesat publicējis. Bez ieraksta nekas nevienu nesasniedz."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Publicējiet kaut ko"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Ieskati"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Labākie ieraksti"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Salīdzinot ar iepriekšējām {days} dienām"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Pievienot interesi"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Velciet, lai pārkārtotu"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Joslā ietilpst ne vairāk kā piecas cilnes. Noņemiet vienu, lai pievienotu citu."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Sekojat"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Jums"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Tēmturi parādīsies šeit, kad cilvēki tos sāks izmantot."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Tagad populārs"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Video"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Jūsu cilnes"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Tā pazudīs jums abiem."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Tā tiks noņemta no pavediena."),
      "join": MessageLookupByLibrary.simpleMessage("Pievienoties"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Turpināt rediģēšanu"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron ekrāni ir jūsu valodā. Ja kāds vārds izklausās nepareizi, pastāstiet mums sadaļā Sūtīt atsauksmi."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Valodas"),
      "leave": MessageLookupByLibrary.simpleMessage("Pamest"),
      "leaveCommunity": (Object a0) => "Pamest ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Ielaist atpakaļ"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("Atvērta 1 lapa"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Pievienot klipu"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Pievienot GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Pievienot tēmturi"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Pievienot foto"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Pievienot aptauju"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Pievienot video"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Pievienot interesi"),
      "literaladdLabelAsATab": (Object a0) => "Pievienot ${a0} kā cilni",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Lietotnes valoda"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Lietotnes versija"),
      "literalblockAuthor": (Object a0) => "Bloķēt ${a0}",
      "literalblockAuthor2": (Object a0) => "Bloķēt ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Bloķēt šo kontu?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Atmest atbildi"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Pārbaudīt vēlreiz"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Izvēlēties no galerijas"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Notīrīt kešatmiņu"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Aizvērt visas lapas"),
      "literalcloseTabLabel": (Object a0) => "Aizvērt ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Aizvērt pārlūku"),
      "literalcloseWidgetCommunityName": (Object a0) => "Slēgt ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Sazināties ar atbalstu"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Satura valodas"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Kopēt saiti"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Kopēt ziņas saiti"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Kopēt ziņas tekstu"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Kopēt tekstu"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt kopienas"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt GIF"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt paziņojumus"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt dalībniekus"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt šīs ziņas"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt šo sarunu"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt šo sarakstu"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt šo ziņu"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt šo atbildi"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt populārās birkas"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Neizdevās ielādēt jūsu kopienas"),
      "literalcouldNotLoadYourMessages":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt jūsu ziņas"),
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("Neizdevās atvērt šo kopienu"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("Neizdevās publicēt atbildi."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Meklēšana nedarbojās"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Izrakstīšanās neizdevās: ${a0}",
      "literalcountPagesOpen": (Object a0) => "Atvērtas lapas: ${a0}",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Vāka foto"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Datu taupīšana"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("Dzēst ziņu"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Atrast cilvēkus"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Neatbildēt"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Melnraksts saglabāts"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Atsauksmi pašlaik nevar nosūtīt"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Teksta lielums"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF nav iestatīti"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Nodot citai lietotnei"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Slēpt paroli"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Paslēpt šo ziņu"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Paslēpj to un lūdz mums rādīt mazāk šādu"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Kā uzvesties"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Turpināt rakstīt"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron neatbildēja"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} datums",
      "literalleaveCommunityName": (Object a0) => "Pamest ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, sejas lēca",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Patikušās ziņas"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Saite nokopēta"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Padarīt par moderatoru"),
      "literalmuteAuthor": (Object a0) => "Apklusināt ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Apklusināt šo pavedienu"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Apklusināt vārdus vai birkas"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Apklusinātie un bloķētie konti"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Apklusināts. Jūs nesaņemsiet paziņojumus."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Neviena lietotne šajā ierīcē neatver ${a0} saites.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Neviens pārlūks šajā ierīcē nepieņēma saiti."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Vēl nav DID"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Nav melnrakstu"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Vēl nav interešu"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Vēl nav patīk"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Vēl nav ziņu"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Nav jaunu sekotāju"),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage("Vēl nav ziņu"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Vēl nav atbilžu"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Vēl nav atkārtotu publikāciju"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Neviena populāra birka neatbilst"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Neviens netika atrasts"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Neviens nav noņemts"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Šeit vēl neviena nav"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Neinteresē"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Nekas netika atrasts"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Pagaidām nekas nav populārs"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Žurnālā vēl nekā nav"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Nav atbilstību"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Nekas nav apklusināts"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Vēl nav ko skatīties"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Nav nelasītu"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("To var mainīt tikai īpašnieks"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Atvērt atbildi"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Atveriet Kyron e-pastu"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Parole un pierakstīšanās"),
      "literalpostInCommunityName": (Object a0) => "Publicēt ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Publicēt ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Publicējiet to ar saviem vārdiem virs tās"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Galvenā valoda"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push paziņojumi"),
      "literalreading":
          MessageLookupByLibrary.simpleMessage("Notiek pārbaude…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Ierakstīt balss ziņu"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Ierakstīt vēlreiz"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Noņemt no moderatoriem"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Noņemt no kopienas"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Noņemt no saglabātajiem"),
      "literalremoveLabel": (Object a0) => "Noņemt ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Noņemt ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Noņemt ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Noņemt aptauju"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Noņemt šo atbildi"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Dzēst šo sarunu"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Noņemt šo aptauju"),
      "literalreportAuthor": (Object a0) => "Ziņot par ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Ziņot par ziņu"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Sūtīt kodu vēlreiz"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Saglabātās ziņas"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Sakiet kaut ko"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Sakiet kaut ko ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Meklēšana neizdevās"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Sūtīt vēlreiz"),
      "literalsendAgainInCooldownS": (Object a0) => "Sūtīt vēlreiz pēc ${a0} s",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Sniegt atsauksmi"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("Sūtīt saiti"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Nosūtīts. Tas ir ziņojums Nr. ${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Iestatiet paroli un turpiniet"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("Kopīgot žurnālu ar atbalstu"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Kopīgot šo kopienu"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Kopīgot šo lapu"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Kopīgot šo profilu"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Kopīgot…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Kopīgot ar citātu"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Rādīt vairāk šādu"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Rādīt paroli"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Rādīt rezultātus"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Izveidot kopienu"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Sākt ierakstu"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Apturēt ielādi"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Pārtraukt redzēt šo ziņu un tās atbildes"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Stāstu josla, vienumi: ${a0}",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Pārslēgt kameru"),
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("Atzīmēt kādu"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Uzņemt foto"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Pieskarieties reklāmkarogam vai foto, lai mainītu"),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
          "Pieskarieties tajā esošajai saitei"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Pieskarieties, lai pievienotu foto un vāku"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("Neizdevās. Mēģiniet vēlreiz."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt šo GIF."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage("Šo saiti šeit nevar atvērt."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Kamera ir aizvērta"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Šī kopiena"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Šīs atbildes vairs nav"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Tulkot ziņu"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Izslēgt skaņu"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Ieslēgt skaņu"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Izmantot kādu no mūsējiem"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Apstiprinājuma kods nosūtīts vēlreiz."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Apstiprināšana neizdevās: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Apstiprināt e-pastu"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Skatītāji, patīk, saglabājumi un komentāri"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Ko Kyron saglabā"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Ko šī lietotne darīja"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Ko jūs darījāt, ko gaidījāt, kas notika "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
          "Tas, ko publicējat, pieder jums"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Vai Kyron šobrīd ir sasniedzams"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Kas var atbildēt"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Ko vēlaties atzīmēt?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Jūs jau sekojat visām populārajām birkām"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Viss izlasīts"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("Jūs neesat nevienā kopienā"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Jūs esat izrakstījies."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Jūs pametāt ${a0}",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "Jūs vēl neko neesat publicējis"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Ielādēt vairāk"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Žurnāls notīrīts"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Žurnāls nokopēts"),
      "logIn": MessageLookupByLibrary.simpleMessage("Pierakstīties"),
      "logOut": MessageLookupByLibrary.simpleMessage("Izrakstīties"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Izrakstīties?"),
      "login": MessageLookupByLibrary.simpleMessage("Pierakstīšanās"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Pierakstīšanās neizdevās. Pārbaudiet datus."),
      "manage": MessageLookupByLibrary.simpleMessage("Pārvaldīt"),
      "menu": MessageLookupByLibrary.simpleMessage("Izvēlne"),
      "message": MessageLookupByLibrary.simpleMessage("Ziņa"),
      "messages": MessageLookupByLibrary.simpleMessage("Ziņas"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("Visas sarunas izlasītas."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Atveriet kāda profilu un pieskarieties Ziņa, lai sāktu sarunu."),
      "mute": MessageLookupByLibrary.simpleMessage("Apklusināt"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Apklusinātie un bloķētie"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Apklusinātie vārdi un birkas"),
      "name": MessageLookupByLibrary.simpleMessage("Vārds"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> ekrāns"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Jauna e-pasta adrese"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Jauna parole"),
      "newPost": MessageLookupByLibrary.simpleMessage("Jauna ziņa"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Ne tagad"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Nav nosūtīts. Pieskarieties, lai mēģinātu vēlreiz"),
      "nothingMatchesQuery": (Object a0) => "Kyron nekas neatbilst \"${a0}\"",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("Nav ko kopēt"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Šeit nonāk patīk, atbildes un jauni sekotāji."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Šeit parādīsies cilvēki, kas jums seko."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Kad kādam patiks jūsu ziņa, tas parādīsies šeit."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Šeit nonāk atbildes uz jūsu ziņām."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Kad kāds jūs publicēs atkārtoti, tas parādīsies šeit."),
      "notifications": MessageLookupByLibrary.simpleMessage("Paziņojumi"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("Atvērt pārlūkā"),
      "or": MessageLookupByLibrary.simpleMessage("vai"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("Lapa nav atrasta"),
      "password": MessageLookupByLibrary.simpleMessage("Parole"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Parole ir pārāk īsa"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Izvēlieties intereses"),
      "post": MessageLookupByLibrary.simpleMessage("Publicēt"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("Ziņas statistika"),
      "postInCommunity": (Object a0) => "Publicēt ${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Publicē, saki, parādi."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Ziņas teksts nokopēts"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Privātuma politika"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profils atjaunināts"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Par sevi"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Valsts"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Parādāmais vārds"),
      "profile_location":
          MessageLookupByLibrary.simpleMessage("Atrašanās vieta"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Pieskarieties, lai mainītu"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Tīmekļa vietne"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push paziņojumi"),
      "quote": MessageLookupByLibrary.simpleMessage("Citēt"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Citēt ziņu"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Sazināties ar cilvēku"),
      "remove": MessageLookupByLibrary.simpleMessage("Noņemt"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Dzēst šo sarunu?"),
      "removeMember": (Object a0) => "Noņemt ${a0}?",
      "removeMessage": MessageLookupByLibrary.simpleMessage("Dzēst šo ziņu?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Atbildes, sekošana un pieminējumi"),
      "repliesPolicy": (Object a0) => "Atbildes: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Atbildēt"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Pievienoties var ikviens"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Ikviens joprojām var redzēt, atkārtoti publicēt un citēt šo ziņu."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Ikviens Kyron var atbildēt uz šo ziņu."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Cilvēki, kas jums seko"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Uz šo ziņu var atbildēt tikai jūsu sekotāji."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Pieminētie cilvēki"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Atbildēt var tikai cilvēki, kurus šajā ziņā @pieminat."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Neviens nevar atbildēt"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Atbildes ir izslēgtas. Jūs joprojām varat atbildēt."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Kas var atbildēt?"),
      "report": MessageLookupByLibrary.simpleMessage("Ziņot"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Ziņojums nokopēts. Ielīmējiet to e-pastā atbalstam."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Sūdzība nosūtīta"),
      "repost": MessageLookupByLibrary.simpleMessage("Publicēt atkārtoti"),
      "reset": MessageLookupByLibrary.simpleMessage("Atiestatīt"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Atiestatiet paroli"),
      "retry": MessageLookupByLibrary.simpleMessage("Mēģināt vēlreiz"),
      "save": MessageLookupByLibrary.simpleMessage("Saglabāt"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Saglabāt melnrakstu"),
      "saySomething": (Object a0) => "Sakiet kaut ko ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Meklēt"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Meklēt pēc vārda vai lietotājvārda"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Meklēt kopienas"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Meklēt GIF"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Meklēt valodas"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Meklēt populāras birkas"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Drošības brīdinājumi un konta izmaiņas"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Izvēlieties lietotnes saskarnes valodu."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Izvēlieties, kuras valodas parādās jūsu plūsmās. Ja neizvēlaties nevienu, tiek rādītas visas valodas."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Izvēlieties galveno valodu plūsmas tulkojumiem."),
      "send": MessageLookupByLibrary.simpleMessage("Sūtīt"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Sūtīt apstiprinājumu"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Sūtīt kļūdas ziņojumu"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Sūtīt atsauksmi"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Nosūtīt sūdzību"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("Sūtīt atbalstam"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("Pakalpojuma statuss"),
      "settings": MessageLookupByLibrary.simpleMessage("Iestatījumi"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Kopīgot lietotnes žurnālu ar atbalstu"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Pierakstīties Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Pierakstījies kā"),
      "signupFailed": (Object a0) => "Reģistrācija neizdevās: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Palikt"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron tikai sāk darbu, un ātrākais veids, kā sasniegt kādu, kas tiešām var to salabot, ir atvērt pieteikumu. Pastāstiet, ko darījāt un kas notika."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Lietotnei vēl nav atbalsta pastkastes, tāpēc šis ekrāns novirza uz vietu, ko tiešām uzrauga, nevis uz veidlapu, kas nekur neved."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Lietotnes žurnāls"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Pastāstiet, kas trūkst vai kas nedarbojas"),
      "terms": MessageLookupByLibrary.simpleMessage("Pakalpojuma noteikumiem"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Teksts, balss un video, cilvēki, kas tos veido, un telpas, kur viņi sarunājas."),
      "theComposerNoPostButton":
          MessageLookupByLibrary.simpleMessage("Redaktorā nav pogas Publicēt"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Tumšs"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Vienmēr tumšs"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Blāvs"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Maigāks tumšs, zilgani pelēks melnā vietā"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Gaišs"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Vienmēr gaišs"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Sistēmas"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Sekot tālruņa gaišajam vai tumšajam iestatījumam"),
      "translate": MessageLookupByLibrary.simpleMessage("Tulkot"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Tulkošana vēl nav ieslēgta. Jūsu plūsmā vēl nekas netiek tulkots; tas tiks atcerēts līdz tam."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Tas maina paša Kyron vārdus, saskarnes daļas, ko Flutter zīmē pats, datumus un skaitļus, kā arī lietotnes izkārtojuma virzienu valodām, kuras raksta no labās uz kreiso."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Mēģināt vēlreiz"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Privātuma politika"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Pakalpojuma noteikumi"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Konts"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Pēc"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Lietotne un ierīce"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Citāts bija domāts, lai brīdinātu citus par krāpšanu."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Paskaidrojiet, kāpēc uzskatāt, ka lēmums bija nepareizs: ko ieraksts nozīmēja, ko komanda varēja nepamanīt vai kāpēc noteikums neder. To izlasīs kāds cits, nevis tas, kurš pieņēma lēmumu."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Jūsu apelācija"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Uzrakstiet vismaz \$count rakstzīmes. Katru lēmumu varat pārsūdzēt vienu reizi."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Nosūtīt apelāciju"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Apelācija nosūtīta. Kad lēmums būs pieņemts, saņemsiet paziņojumu."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Apelācija lietā \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Izskats"),
      "ui_appearance_detail":
          MessageLookupByLibrary.simpleMessage("Gaišs, tumšs vai kā tālrunī"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Pirms"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron jūs viens otru neredzēsiet, un sekošana starp jums tiks noņemta. Viņam netiek paziņots."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Satur"),
      "ui_cchat_about": MessageLookupByLibrary.simpleMessage(
          "Kam tā paredzēta (nav obligāti)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Rakstīt var tikai moderatori"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Paziņojumiem. Visi kopienā joprojām var lasīt un reaģēt."),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "Pievienot fotoattēlu vai aptauju"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Fotoattēli un video"),
      "ui_cchat_close":
          MessageLookupByLibrary.simpleMessage("Aizvērt tērzēšanu"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Neviens tajā vairs nevarēs ne lasīt, ne rakstīt. To nevar atsaukt."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Vai aizvērt šo tērzēšanu?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Nokopēts"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Ziņa tiek noņemta visiem. Kyron patur kopiju pārskatīšanai."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Ziņa tiek noņemta visiem tērzēšanā."),
      "ui_cchat_edit":
          MessageLookupByLibrary.simpleMessage("Rediģēt tērzēšanu"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Rediģēt"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("rediģēts"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Jūs rediģējat savu ziņu"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās atvērt šo tērzēšanu."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Tērzēšanas"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Pievienoties tērzēšanai"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Pievienojieties kopienai, lai redzētu tās tērzēšanas un piedalītos."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Pievienojušies: \$count"),
      "ui_cchat_leave":
          MessageLookupByLibrary.simpleMessage("Pamest tērzēšanu"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Jūs to joprojām varat lasīt, kamēr esat kopienā."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Šeit rakstīt var tikai īpašnieks un moderatori."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Izslēgt skaņu"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Nebūs paziņojumu no tās, un tā netiek ieskaitīta Ziņu skaitā."),
      "ui_cchat_name":
          MessageLookupByLibrary.simpleMessage("Tērzēšanas nosaukums"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Jauna tērzēšana"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Vēl nav tērzēšanu."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Vēl nav tērzēšanu. Atveriet vienu kopienai."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Kopienas tērzēšanas nav šifrētas pilnībā. Kopienas moderatori un Kyron tās var lasīt."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Piespraust augšā"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Pievienot atbildi"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Slēgt aptauju"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Slēgta"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Visi redz, cik cilvēku izvēlējās katru atbildi, bet nekad – kas."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Ļaut izvēlēties vairākas"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Jauna aptauja"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Izvēlieties vienu"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Atbilde \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Aptauja: \$question"),
      "ui_cchat_poll_question":
          MessageLookupByLibrary.simpleMessage("Jautājums"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Katra atbilde aptaujā var būt tikai vienreiz."),
      "ui_cchat_poll_several": MessageLookupByLibrary.simpleMessage(
          "Izvēlieties vienu vai vairākas"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("Atbildējuši: \$count"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Meklēt šajā tērzēšanā"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Meklēt šajā tērzēšanā"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Nekas netika atrasts."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Jūs vairs nevarat redzēt šo tērzēšanu."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Lēnais režīms"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Cik ilgi jāgaida starp ziņām. Neattiecas uz moderatoriem."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 stunda"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Minūtes: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Lēnais režīms: viena ziņa ik pēc \$seconds s"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Izslēgts"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Sekundes: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Kā skatītājs jūs varat lasīt un reaģēt. Pievienojieties, lai rakstītu."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Šī ziņa ir pārāk tālu pagātnē, lai to parādītu."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Kaut kas no izvēlētā ir pārāk liels nosūtīšanai un tika izlaists."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("Ieslēgt skaņu"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Atspraust"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Ierakstīt balss ziņu"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Jūs"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Kopienas"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage(
              "Kam tas paredzēts? (neobligāti)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Ieraksti:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Saturs un attēlojums"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt jūsu plūsmu"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt patikušās ziņas"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt jūsu profilu"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt saglabātās ziņas"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Decentralizēts ID"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("Problēmu novēršana"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Grupas"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Nav grupu"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Šeit redzamas grupas, kurās esat, un kopienu tērzēšanas, kurām pievienojaties."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Varat piespraust līdz \$count tērzēšanām. Vispirms atspraudiet vienu."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Piesprausts"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Patīk"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Saglabātie"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Šeit vēl nekā nav"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Sekojiet dažiem kontiem, un to ziņas parādīsies šeit."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Nekā no tiem, kam sekojat"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Ziņas parādīsies šeit, kad cilvēki tās rakstīs."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Vājinās"),
      "ui_feed_signal_less": MessageLookupByLibrary.simpleMessage("Neinteresē"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Rādīt vairāk līdzīgu"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("Noņemts"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Jūsu plūsmas signāli"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Pieskarieties ziņai Rādīt vairāk līdzīgu ziņu vai Mani tas neinteresē, un tā parādīsies šeit."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Šeit vēl nekā nav"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Ko jūsu plūsmām saka Rādīt vairāk un Neinteresē"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Tie veido Sākumu un Izpēti, galvenokārt pēc katras ziņas tēmas. Katrs ik mēnesi kļūst uz pusi vājāks un pēc sešiem vairs netiek skaitīts. Noņemiet kādu, lai to apturētu tūlīt."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Ziņas ar klipu parādīsies šeit."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Vēl nav video"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Atsauksmes"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Atrodiet cilvēkus Kyron"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("No konta"),
      "ui_group_add":
          MessageLookupByLibrary.simpleMessage("Pievienot cilvēkus"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Pievienot"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Pievienot grupas nosaukumu"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Noraidīt"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Ziņas šajā grupā ir pilnībā šifrētas, tāpat kā jebkura cita saruna."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor pievienoja: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor iecēla par administratoru: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor izveidoja grupu"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor iestatīja, ka jauni cilvēki pievienojas kā dalībnieki"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor iestatīja, ka jauni cilvēki pievienojas kā skatītāji"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor aizgāja"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor iecēla par dalībnieku: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor nodeva īpašumtiesības: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor noņēma: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor pārdēvēja grupu par \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor iecēla par skatītāju: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Grupā var būt ne vairāk kā \$count cilvēki."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Roka pacelta. Administratori ir informēti."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Vēlas rakstīt: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Vēlas rakstīt"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Vēlāk pievienotie pievienojas kā skatītāji"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Pamest grupu"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Tā pazudīs no jūsu saraksta, un jūs neredzēsiet, kas tiks rakstīts pēc tam. Kādam jūs būtu jāpievieno vēlreiz."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Pamest šo grupu?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Ļaut rakstīt"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Nolaist roku"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Iecelt par administratoru"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Nodot īpašumtiesības"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Padarīt par skatītāju"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Dalībnieki: \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Dalībnieki"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Grupas nosaukums"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Vispirms nosauciet grupu."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Izveidot grupas tērzēšanu"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Īpašnieks ir viens. Jūs paliksiet administrators."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Nodot īpašumtiesības: \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Pacelt roku"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Noņemt no grupas"),
      "ui_group_remove_admin": MessageLookupByLibrary.simpleMessage(
          "Atņemt administratora tiesības"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Jūs vairs neesat šajā grupā."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Pārdēvēt"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Administrators"),
      "ui_group_role_member":
          MessageLookupByLibrary.simpleMessage("Dalībnieks"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Skatītājs"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Kā skatītājs šeit varat lasīt un reaģēt."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Skatītāji var lasīt, reaģēt un pacelt roku, lai lūgtu atļauju rakstīt."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Ieteiktie"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Skatīt profilu"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("jūs"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Jūs esat skatītājs"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Palīdzība"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Atzīmēts. Tas palīdz izvēlēties, ko jums rādīt."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Pievienoties"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Pievienojās"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Valoda"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Izvēlieties valodu"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Juridiskā informācija"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Patīk"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("Patikušās ziņas"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Patikušās ziņas parādās šeit, jaunākās vispirms."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Saite nokopēta"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Jūs vairs neredzēsiet viņa ziņas. Viņam netiek paziņots."),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage("Vēl nav patīk"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Neviena ziņa neatbilst šiem filtriem."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Vēl nav saglabājumu"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Jūsu konts ir atjaunināts"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Jūsu apelācija lietā \$number ir apmierināta"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Mēs vēlreiz izskatījām jūsu apelāciju lietā \$number, un lēmums paliek spēkā"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Jūsu konts ir neatgriezeniski bloķēts"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Lieta \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("sāka jums sekot"),
      "ui_notif_liked": MessageLookupByLibrary.simpleMessage(
          "atzīmēja ar “patīk” jūsu ierakstu"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("jūs pieminēja"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Vēl nav pieminējumu"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Kad kāds ierakstā vai atbildē uzrakstīs jūsu @lietotājvārdu, tas parādīsies šeit."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Vecāki"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Jūsu ziņa kopienas tērzēšanā ir noņemta"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Kaut kas, ko publicējāt, ir noņemts"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Jūsu ieraksts ir noņemts"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Jūsu atbilde ir noņemta"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("atbildēja uz jūsu ierakstu"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Mēs rīkojāmies saistībā ar jūsu sūdzību. Paldies, ka ziņojāt."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Mēs izskatījām jūsu sūdzību un nekonstatējām mūsu noteikumu pārkāpumu."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Sūdzības iemesls: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("kopīgoja jūsu ierakstu"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Mēs atcēlām lēmumu lietā \$number"),
      "ui_notif_suspended": MessageLookupByLibrary.simpleMessage(
          "Jūsu konta darbība ir apturēta"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Jūsu konta darbība ir apturēta līdz \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Visi"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Sekotāji"),
      "ui_notif_tab_likes":
          MessageLookupByLibrary.simpleMessage("Patīk atzīmes"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Pieminējumi"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Atbildes"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Šonedēļ"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Šodien"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Jūsu konts saņēma brīdinājumu"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Vakar"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Gatavs"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Izlaist"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Tas jau ir atvērts."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Beidzies"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("To neizdevās atvērt."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Atveras vienreiz, pēc tam tiek dzēsts no Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Skatīt vienreiz"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Atvērts"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Atvēra: \$count no \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "To var atvērt tikai tie, kam to nosūtījāt, un tikai vienreiz."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Sūtīt vienreizējai skatīšanai"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Pieskarieties, lai skatītu"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pauze"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Atskaņot"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Tā tiks noņemta no jūsu profila un visu plūsmām. Tās atbildes pazudīs kopā ar to."),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("Ziņa dzēsta"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("Ziņa paslēpta"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Ziņas teksts nokopēts"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Publicēts laikā no"),
      "ui_posts_hidden":
          MessageLookupByLibrary.simpleMessage("Paslēpts. Rādīsim mazāk šādu."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Privātums"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Vai vēlaties ko piebilst? (neobligāti)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Jūs saņemsiet paziņojumu, kad komanda pieņems lēmumu, un to varat sekot sadaļā “Jūsu sūdzības”."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Ja arī nevēlaties vairs redzēt šo personu, apklusiniet vai bloķējiet to tajā pašā izvēlnē."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Ziņojot par to pašu divreiz, tam netiek piešķirts lielāks svars: mēs glabājam vienu sūdzību no katras personas."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Jūsu sūdzība netiek kopīgota ar šo personu. Mēs glabājam kopiju tam, par ko ziņojāt, lai to varētu izskatīt arī tad, ja tas tiek izdzēsts."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Jūsu sūdzība ir saņemta un gaida izskatīšanu. Mēs nesakām šai personai, kas par to ziņoja."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Skatīt savas sūdzības"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Pastāstiet, kas nav kārtībā"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Paldies, ka pastāstījāt"),
      "ui_report_what_account": MessageLookupByLibrary.simpleMessage(
          "Kas nav kārtībā ar kontu \$name?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("Kas nav kārtībā ar šo ziņu?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Kas nav kārtībā ar šo ierakstu?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Kas nav kārtībā ar šo atbildi?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Ziņa kopienas tērzēšanā"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Ieraksts"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Atbilde"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Veikti pasākumi"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Konts"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Izlemts \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Noteikumi nav pārkāpti"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt jūsu sūdzības"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Jūsu sūdzības pēdējās 90 dienās un to iznākums. Jūs saņemat paziņojumu, kad komanda pieņem lēmumu. Neviens, par kuru sūdzaties, neuzzina, kas iesniedza sūdzību."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Sūdzību nav"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kad iesniegsiet sūdzību par ierakstu, atbildi, ziņu vai kontu, tā parādīsies šeit kopā ar iznākumu."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("Tiek izskatīta"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Iesniegta \$date"),
      "ui_reports_settings_help":
          MessageLookupByLibrary.simpleMessage("Jūsu sūdzības un to iznākums"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Jūsu sūdzības"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Bērnu drošība"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Viss, kas apdraud vai seksualizē nepilngadīgos."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Mērķtiecīga aizskaršana, draudi vai nevēlams kontakts."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Uzbrukumi cilvēkiem par to, kas viņi ir."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Kaut kā nelikumīga pārdošana vai reklamēšana."),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("Uzdošanās par kādu citu."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Izmanto jūsu darbu vai preču zīmi bez atļaujas."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Maldinoši apgalvojumi par veselību, vēlēšanām vai notikumiem."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Pašsavainošanās veicināšana vai attēlošana."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Seksuāls saturs, kas parādīts bez brīdinājuma."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Nekas no minētā. Pastāstiet, kas nav kārtībā."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Atkārtota, maldinoša vai nevēlama reklāma."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Draudi ar vardarbību, tās slavināšana vai kūdīšana uz to."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Uzmākšanās vai iebiedēšana"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Naida runa"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Nelegālas preces vai pakalpojumi"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Uzdošanās par citu personu"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Intelektuālais īpašums"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Nepatiesa informācija"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Pašnāvība vai paškaitējums"),
      "ui_rule_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Pieaugušajiem paredzēts saturs"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Kas cits"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Mēstules"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Vardarbība vai draudi"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Saglabātās ziņas"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Pieskarieties ziņas arhīva ikonai, lai to paturētu šeit. Saglabāto redzat tikai jūs."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Meklējiet pēc lietotājvārda vai parādāmā vārda."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Notīrīt"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Meklēt visā publicētajā"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filtri"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("Meklēt cilvēkus"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("Meklēt ziņas"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Iestatījumi"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Lietotne un ierīce"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Saturs un attēlojums"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Datu taupīšana"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Dalieties ar domām"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Pārlūkot palīdzības rakstus"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Izvēlieties valodu"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Ko esat apklusinājis vai bloķējis"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Paziņojumu preferences"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Jūsu profils un kontaktinformācija"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Lai atgrieztos kontā, jums būs jāpierakstās vēlreiz."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Drošības iestatījumi"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Apstipriniet paroli"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("Vienā rindā"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Jauna e-pasta adrese"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Jauna parole"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Kas notika"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "Saņemt palīdzību no mūsu komandas"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Kopīgot"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Citēt"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Sūtīt ziņā"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Cilvēkiem Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Kopīgot šo ziņu"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Par ko bija runa"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Jūsu konts ir neatgriezeniski bloķēts"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Atbilde, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Apelācija"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Pārsūdzēt šo lēmumu"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Šo lēmumu vairs nevar pārsūdzēt. Ja kaut kas nav kārtībā, sazinieties ar atbalsta dienestu."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Apelācija tiek izskatīta"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Apelācija apmierināta"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Kāds cits no komandas to izskata vēlreiz. Kad lēmums būs pieņemts, saņemsiet paziņojumu."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Ja uzskatāt, ka tā bija kļūda, līdz \$date varat lūgt to izskatīt vēlreiz. Lēmumu pieņem kāds cits no komandas."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Pārsūdzēts: lēmums paliek spēkā"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Lieta \$number. Noteikums: \$rule. Komanda rakstīja:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Konta dzēšana neatceļ bloķēšanu: arī jauns konts ar to pašu e-pasta adresi būs bloķēts."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Neatgriezeniski bloķēts"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Darbojas tikai šī lapa, apelācijas, atbalsts un konta dzēšana."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Var pārsūdzēt"),
      "ui_standing_case":
          MessageLookupByLibrary.simpleMessage("Lieta \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Lemts \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Lēmumi par jūsu kontu"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Dzēst kontu"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Skatīt informāciju"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "Skatīt informāciju un pārsūdzēt"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Beidzas \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Jūsu konts ir kārtībā"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Nekas to neierobežo."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt konta statusu"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Ziņa noņemta"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Par jūsu kontu nekas nav lemts. Ja komanda kādreiz noņems kaut ko jūsu vai ierobežos jūsu kontu, tas būs redzams šeit ar iemeslu, un jūs varēsiet to pārsūdzēt."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Nav ko pārsūdzēt: lēmums ir atcelts."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Ieraksts noņemts"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Velciet uz leju, lai pārbaudītu vēlreiz."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Lasīt Kyron noteikumus"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Atbilde noņemta"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Atcelts"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Atcelts \$date. Viss noņemtais ir atgriezts, un neviens ierobežojums vairs nav spēkā."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Noteikums: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("Izrakstīties"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Darbība apturēta"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Varat lasīt, bet nevarat publicēt, atbildēt, sekot vai sūtīt ziņas. Ziņošana, bloķēšana un apklusināšana joprojām darbojas."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Jūsu konta darbība ir apturēta: varat lasīt, bet ne publicēt."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Apturēts līdz \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Jūsu konta darbība ir apturēta līdz \$date: varat lasīt, bet ne publicēt."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Ko rakstīja komanda"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Konta statuss"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Brīdinājums"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Kāpēc?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Jūs rakstījāt \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Jūsu ziņa"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Jūsu ieraksts"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Jūsu atbilde"),
      "ui_terms":
          MessageLookupByLibrary.simpleMessage("Pakalpojuma noteikumiem"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("šī ziņa"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Pavediens apklusināts"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Mēģināt vēlreiz"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Izslēgt skaņu"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Ieslēgt skaņu"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Vismaz divas rakstzīmes."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Atsaukt"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Vārdi vai filtrs: konts, datumu diapazons vai ziņas saturs."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Atsaukt atkārtoto publikāciju"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Atjaunināt paroli"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Izmantot citu adresi"),
      "username": MessageLookupByLibrary.simpleMessage("Lietotājvārds"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Lietotājvārdam jābūt ar mazajiem burtiem (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Pievienot"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Gatavs pievienošanai"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Ierakstīt balss ziņu"),
      "voice_recording":
          MessageLookupByLibrary.simpleMessage("Notiek saglabāšana…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Apturēt"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Kas notika"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Kas notika, un ko mums vajadzētu apskatīt?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Kas ir šajā attēlā?"),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage(
          "Kam tas paredzēts? (neobligāti)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Ko jūs darījāt, ko gaidījāt, kas notika"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Ko jūs darījāt, kad tas notika."),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("Jūs atbildējāt"),
      "dmReplied": (Object a0) => "$a0 atbildēja",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Pievienot ziņai"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Jauna ziņa"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Vēl nekas nav teikts. Pamāšana ir labs sākums."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Pamāt"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Jaunas ziņas"),
      "dmTyping": (Object a0) => "$a0 raksta",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Noņemt savu reakciju"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Kāds"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Ziņa"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Pielikums"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Šo ziņojumu nevar izlasīt šajā ierīcē."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Gaida šo ziņojumu. Tas var aizņemt kādu laiku."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Šifrēts ziņojums"),
      "ui_dm_e2ee_notice":
          MessageLookupByLibrary.simpleMessage("Ziņojumi ir pilnībā šifrēti"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Nav pilnībā šifrēts"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Nosūtīts"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Redzēts"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Sūta…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Uzņemt fotoattēlu"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Vairāk iespēju"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("Saglabāt ierīcē"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Kopīgot"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Saglabā…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Saglabāts jūsu fotoattēlos"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās saglabāt. Mēģiniet vēlreiz."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Atļaujiet Kyron pievienot jūsu fotoattēliem, lai to saglabātu."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Visas sistēmas darbojas"),
      "ui_status_uptime":
          MessageLookupByLibrary.simpleMessage("Darbspējas laiks"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Pēdējās 60 dienas"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Pirms 60 dienām"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Šodien"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Datubāze"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Pierakstīšanās"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Nesenie incidenti"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Pēdējo 60 dienu laikā incidentu nav bijis."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Notiek"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Nav datu"),
      "ui_status_details":
          MessageLookupByLibrary.simpleMessage("Sīkāka informācija"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron darbības laikā pārbauda sevi ik pēc 5 minūtēm. Pelēkā dienā pārbaužu nebija."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Darbspējas vēsture vēl nav pieejama."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Dažām sistēmām ir problēmas"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Ierakstīt balss ziņu"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Gatavs sūtīšanai"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Šīs ziņas te vairs nav."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Pāriet uz ziņu"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("Balss ziņa"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Autoram patīk"),
      "ui_add_photo_or_clip": MessageLookupByLibrary.simpleMessage(
          "Pievienot fotoattēlu vai klipu"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Multivide"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Balss ziņas"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Tērzēšana"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("Fona attēls"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Izslēgt paziņojumus"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Pārtraukt saņemt paziņojumus par šo sarunu"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("Viņi vairs nevar jums rakstīt"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Nav"),
      "ui_dm_wallpaper_photo":
          MessageLookupByLibrary.simpleMessage("Fotoattēls"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("Skaņa ieslēgta."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās noņemt. Mēģiniet vēlreiz."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profils"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Ieslēgt skaņu"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Šeit tiek rādīti jūsu kopīgotie fotoattēli un klipi."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("Skatīt visu"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Fotoattēli un klipi"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Šādi izskatīsies jūsu tērzēšana."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Izskatās labi."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Migla"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Krēsla"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Salvija"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Smiltis"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Punktiņi"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Lietot"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Pašreizējais"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Sūtīt bez priekšskatījuma"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Meklēt"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Publicēt"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Rakstiet ziņu…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Sūtīt"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Nosūtīts"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Nosūtīts, bet ne visiem."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās nosūtīt. Mēģiniet vēlreiz."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Sekotājs"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtrs"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Visas"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Nelasītās"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Neatbildētās"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Paslēptās"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Nekas nav paslēpts"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Sarunas, ko noņemat no saraksta, gaida šeit, ja gribēsiet tās atgūt."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Tā pāriet uz Paslēptajām. Otrs cilvēks patur savējo, un tā atgriežas, ja kāds no jums atkal raksta."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Atjaunot"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Atkal jūsu sarakstā."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Nav atbilstošu sarunu."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Nekas jūs negaida"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Katra saruna beidzas ar jūsu vārdu."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Vēl nav ziņu"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Jūs:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Vakar"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Ziņas"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Ziņu iestatījumi"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Privātums"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Izlasīšanas apstiprinājumi"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Kad tas ir izslēgts, citi neredzēs, kad esat izlasījis viņu ziņas, un jūs neredzēsiet, kad viņi izlasījuši jūsējās."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Rādīt, kad rakstāt"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Cilvēks, kuram rakstāt, redz, ka rakstāt."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Saišu priekšskatījumi"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Jūsu tālrunis atver nosūtīto saiti, lai izveidotu priekšskatījumu, tāpēc vietne redz jūsu tālruņa pieprasījumu. Kyron serveris saiti nekad neredz."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Ziņu paziņojumi"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Ziņas ir pilnībā šifrētas. Kyron tās nevar izlasīt, un nekas šeit to nemaina."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Kam:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Nesenās"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Cilvēki"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Nav neviena ar šādu vārdu."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Sūtīt testa paziņojumu"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron serveris vēl nav iestatīts paziņojumu sūtīšanai, tāpēc neviens nevar pienākt. Problēma ir mūsu pusē, nevis jūsu tālrunī."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Šis tālrunis nav reģistrēts paziņojumiem. Pārbaudiet, vai tālruņa iestatījumos Kyron paziņojumi ir atļauti, un mēģiniet vēlreiz."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Paziņojumu neizdevās piegādāt uz šo tālruni. Mēģiniet vēlreiz pēc minūtes."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Nosūtīts. Tam vajadzētu pienākt pēc dažām sekundēm."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Paziņojumi darbojas."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Vēl nav ierakstu"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("Jauna kopiena"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Nosaukums"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Adrese tiek veidota no nosaukuma."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Cilvēki to atradīs adresē"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Jūs būsiet tās īpašnieks. Attēlu, baneri un moderatorus var pievienot tās lapā, kad tā būs izveidota."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Sākums"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Kopienu ieraksti Sākumā"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Jūsu kopienu ieraksti redzami arī Sākumā. Izslēdzot tie paliek šeit, Kopienās, kur katra rāda, kas jauns."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Jūsu saraksts"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Jauno ierakstu skaits"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Rādīt, cik ierakstu katrā kopienā ir jauni kopš pēdējās reizes, kad to atvērāt."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Jūsu vadītās kopienas"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Šeit ir kopienas, ko izveidojat vai moderējat."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Īpašnieks"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderators"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Jauni ieraksti"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Jūsu vadītās"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Kopienu iestatījumi"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Atklāt"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Neviena kopiena neatbilst."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Nekā jauna"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Katra kopiena ir tāda, kādu to atstājāt."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Jūs vēl nevadāt nevienu"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Vairs nav kam pievienoties"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Jūs esat visās Kyron kopienās. Izveidojiet vēl vienu."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Mēģiniet citu vārdu vai izveidojiet kopienu ar šo nosaukumu."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Rakstīt ierakstu"),
      "ui_community_members":
          MessageLookupByLibrary.simpleMessage("Dalībnieki:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Publicēts"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Skatīt"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Atvērt"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Tiešsaistē"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Rādīt, kad esat tiešsaistē"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Cilvēki, kuriem rakstāt, redz zaļu punktu, kamēr jums ir atvērts Kyron. Kad tas ir izslēgts, arī jūs neredzēsiet viņējo."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Meklēt cilvēkus un ierakstus"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Kopienas, kurām pievienoties"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Vēl nav ko skatīties"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Šeit parādīsies cilvēku publicētie fotoattēli un klipi."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Sekot"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("Dzēst kontu"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Tādējādi jūsu Kyron konts tiks neatgriezeniski dzēsts. To nevar atsaukt."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Jūsu profils, ieraksti, atbildes, patīk atzīmes un atkārtotās publikācijas"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Jūsu ziņas, arī tās, ko nosūtījāt citiem, un tajās esošie foto un balss ziņas"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Jūsu sekotāji, cilvēki, kuriem sekojat, un jūsu iestatījumi"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Jūsu izveidotās kopienas tiek nodotas moderatoram vai dalībniekam, kurš tajā ir visilgāk. Kopiena, kurā nav neviena cita, tiek slēgta."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Vai dzēst jūsu kontu?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Neko no tā vairs nevarēsiet atgūt."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Jūsu konts ir dzēsts."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Dzēsts konts"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Šis konts ir dzēsts, tāpēc šeit vairs nevar sūtīt ziņas."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Reģistrējāties ar Google? Izmantojiet “Sign in with Google”."),
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("Šo filtru nevarēja ielādēt."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Video nevarēja ierakstīt."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Filtru nevarēja pievienot šim video, tāpēc tas tiek publicēts tāds, kāds tika nofilmēts."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Jūsu ierakstam jau ir maksimālais pielikumu skaits."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Pievieno filtru…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Zibspuldze"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("Ierakstīt video"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Video"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Pieteikšanās ar Google tika atcelta."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("DĀVANAS"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Šim ierakstam vēl neviens nav nosūtījis dāvanu."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Dāvana"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Dāvanas"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Monētas"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Sūtītājs"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Sūtītāji"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Testa monētas: tās vēl nevar izņemt."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Saglabāts"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Ieraksti"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Komentāri"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Skatīt vairāk atbilžu"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Rediģēts"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Vairāk"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Sekoju"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Populārākie"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Jaunākie"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Kārtot komentārus: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "nosūtīja dāvanu jūsu ierakstam"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "nosūtīja \$gift jūsu komentāram"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "nosūtīja \$gift jūsu ierakstam"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Sūtīt dāvanu"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Rediģēt ierakstu"),
      "ui_edit_post_left":
          MessageLookupByLibrary.simpleMessage("Varat to rediģēt vēl \$n min"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Saglabāt"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Zem #\$tab vēl nekas nav publicēts."),
      "ui_gift_pick":
          MessageLookupByLibrary.simpleMessage("Izvēlieties dāvanu"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Nepietiek monētu"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Testa monētas: tās nevar nopirkt, un tām nav naudas vērtības."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Papildinās \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 monēta"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("Monētas: \$count"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("Jums ir \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Sūtīt \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift nosūtīts"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Mēģināt vēlreiz"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("15 minūtes pēc publicēšanas"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Rediģēts"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt saglabātos komentārus"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Nav saglabātu komentāru"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Pieskarieties arhīva ikonai zem komentāra, lai to saglabātu šeit. To, ko saglabājat, redzat tikai jūs."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Atbilde lietotājam \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Kopēt"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Meklēt"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Atlasīt visu"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("Dāvanas: \$count"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 dāvana"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt vairāk ierakstu."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Atgādinājumi"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Kas jauns pēc jūsu prombūtnes un kad monētas atgriežas. Ne vairāk kā viens dienā."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Dāvanas"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("no 1 cilvēka"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("no \$count cilvēkiem"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Dāsnākais"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt, kas sūtīja dāvanas."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Jaunumi"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Skaidrs"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Paldies. Mēs izlasām katru atbildi."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Kā jums līdz šim patīk Kyron?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Jūsu testa \$day. diena. Pietiek ar vienu pieskārienu."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Ko mums labot vai pievienot? (pēc izvēles)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Sūtīt"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Ne tagad"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Vēlreiz nospiediet Atpakaļ, lai izietu no Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Apstipriniet, ka tas esat jūs"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Ievadiet paroli, lai dzēstu kontu."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Vēlreiz pierakstieties ar Google, lai dzēstu kontu."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās. Pārbaudiet un mēģiniet vēlreiz."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Šī lapa vēlas atvērt citu lietotni"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Tā lūdz atvērt {scheme} saiti."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("Būvējums"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "{size} kešatmiņā saglabātu attēlu un failu"),
      "ui_about_freed":
          MessageLookupByLibrary.simpleMessage("Atbrīvoti {size}"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("Mēra…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("Nav ko notīrīt"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("Krātuve"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("Versija {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("Bloķētie"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("Publicē sava vārdā"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "Šie pielikumi netika augšupielādēti. Pieskaries vienam, lai mēģinātu vēlreiz, vai noņem to."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās mainīt e-pastu. Mēģini vēlreiz."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "Adrese mainīsies, kad atvērsi saiti, ko nosūtīsim."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "Apstiprinājuma saiti meklē {email}."),
      "ui_email_enter":
          MessageLookupByLibrary.simpleMessage("Ievadi e-pasta adresi."),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage(
          "Tas neizskatās pēc e-pasta adreses."),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "Tā jau ir tava e-pasta adrese."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "Ko tu darīji, ko gaidīji un kas notika tā vietā."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "Ļauj man piespraust ierakstu profilam"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "Ko tu vēlētos un ko tas ļautu tev darīt."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("Kas palīdzētu"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("Problēma"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("Ideja"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("Jautājums"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "To lasa tikai Kyron komanda. Tas tiek nosūtīts kopā ar tavu kontu, lai mēs varētu atbildēt pa e-pastu, un ar tavu lietotnes versiju. Dzēšot kontu, tiek dzēsts arī tas."),
      "ui_feedback_question_example":
          MessageLookupByLibrary.simpleMessage("Kā apklusināt vārdu?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "Ko tu mēģini izdarīt un kur iestrēgi."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("Tavs jautājums"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Neizdevās sazināties ar Kyron. Pārbaudi savienojumu un mēģini vēlreiz. Nekas vēl nav uzrakstīts, tāpēc nekas nav zaudēts."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("Notīrīt"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Šeit tiek rādīti neizdevušies pieprasījumi un citi svarīgi notikumi."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("Apklusinātie"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "Pievieno vārdu vai tagu augšā. Ieraksti ar to netiks rādīti tavā plūsmā."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "Ieraksti, kas satur kaut ko no šī, netiek rādīti tavā plūsmā. Lielajiem un mazajiem burtiem nav nozīmes, un vārds sakrīt arī garāku vārdu iekšienē, tāpēc „spoiler” notver arī „spoilers”."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("Neviens nav bloķēts"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "Bloķēšana jūs paslēpj vienu no otra abos virzienos. Bloķē kādu no izvēlnes viņa profilā."),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("Neviens nav apklusināts"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "Konta apklusināšana paslēpj tā ierakstus, viņam to nepaziņojot. Apklusini kādu no izvēlnes viņa profilā vai ierakstā."),
      "ui_password": MessageLookupByLibrary.simpleMessage("Parole"),
      "ui_password_mismatch": MessageLookupByLibrary.simpleMessage("Nesakrīt."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "Šajā ierīcē tu paliksi pierakstījies. Citās ierīcēs tiks veikta izrakstīšanās."),
      "ui_password_too_short":
          MessageLookupByLibrary.simpleMessage("Izmanto vismaz 8 rakstzīmes."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās atjaunināt paroli. Mēģini vēlreiz."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("Parole atjaunināta."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID nokopēts"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "Ieraksti, kas tev patīk, tiek glabāti šeit tikai tev."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "Tu vēl neesi publicējis fotoattēlus vai klipus."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} vēl nav publicējis fotoattēlus vai klipus."),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "Viss, ko publicēsi, tiks rādīts šeit."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} vēl neko nav publicējis."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt tavu profilu"),
      "ui_profile_load_failed_other":
          MessageLookupByLibrary.simpleMessage("Neizdevās ielādēt @{handle}"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("Vismaz 8 rakstzīmes"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("Mazais burts (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("Vismaz viens cipars"),
      "ui_pw_rule_symbol":
          MessageLookupByLibrary.simpleMessage("Simbols (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("Lielais burts (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "Nesenie ieraksti: {count}. Pirms sūtīšanas pārskati tos sadaļā Par › Sistēmas žurnāls."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "To lasa tikai Kyron komanda. Tas tiek nosūtīts kopā ar tavu kontu, lai mēs varētu sazināties. Ja vēlies redzēt, kas tieši tiek nosūtīts, vispirms izlasi žurnālu sadaļā Par › Sistēmas žurnāls."),
      "ui_report_sent":
          MessageLookupByLibrary.simpleMessage("Nosūtīts, paldies."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "Nosūtīts, paldies. Tas ir ziņojums Nr. {number}."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("Kas nogāja greizi?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "Versija, politikas, statuss un sistēmas žurnāls"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "Neļaut video atskaņoties pašiem ritinot"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "Tavs decentralizētais identifikators"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("Moderācija"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "Ziņojumi un pārsūdzības, kas gaida pārskatīšanu"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "Neļaut ierakstiem ar šo nonākt plūsmā"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("Nav pierakstījies"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("Paziņojumu preferences"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("Privātums un drošība"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "Lēmumi par tavu kontu un pārsūdzības"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("Pielāgot teksta lielumu"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("Tavs konts"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "AR lēcu ierakstīšana un publicēšana vēl tiek veidota. Nekas, ko uzņemsi, vēl netiktu saglabāts, tāpēc kamera paliek aizvērta."),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("Lēcas vēl nav gatavas"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR lēca"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "Tiešraidei vajag mediju serveri, ko Kyron vēl nedarbina. Ja sāktu translāciju tagad, tu būtu telpā, kurā neviens nevar ienākt. Balss ieraksta ierakstīšana darbojas jau šodien."),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("Tiešraide vēl nav gatava"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("Tiešraide"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Aptaujām vajag vietu, kur glabāt atbilžu variantus un skaitīt balsis. Tās vēl nav, tāpēc šodien publicēta aptauja zaudētu katru atbildi."),
      "ui_soon_poll_heading":
          MessageLookupByLibrary.simpleMessage("Aptaujas vēl nav gatavas"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("Aptauja"),
      "ui_soon_write_instead": MessageLookupByLibrary.simpleMessage(
          "Tā vietā raksti teksta ierakstu"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("Pārbaudīt vēlreiz"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("Detaļa"),
      "ui_status_mirror": MessageLookupByLibrary.simpleMessage("Spoguļtabulas"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron atbildēja, bet kaut kas nav kārtībā."),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("Atbildes laiks"),
      "ui_support_ask": MessageLookupByLibrary.simpleMessage("Uzdot jautājumu"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Par tavu kontu vai to, kā kaut kas darbojas"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("Pa e-pastu"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Ja Kyron avarēja: nosūta arī lietotnes žurnālu"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("Lietotnē"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "Raksti Kyron komandai no šejienes. Ziņa nonāk pie mums privāti, kopā ar tavu kontu, un mēs atbildam uz tā e-pasta adresi."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "Neviena e-pasta lietotne netika atvērta. {address} ir nokopēta."),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("Privātums un tavi dati"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("Ziņot par problēmu"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "Kaut kas ir salūzis vai nedarbojas, kā vajadzētu"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "Lai ziņotu par ierakstu vai kontu, izmanto tā izvēlni: tā mēs precīzi zinām, kuru tu domā."),
      "ui_support_safety": MessageLookupByLibrary.simpleMessage(
          "Drošība un ļaunprātīga izmantošana"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Vai Kyron nedarbojas visiem vai tikai tev"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("Liels"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("Lielāks"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("Vidējs"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron ir vieta, kur pateikt kaut ko lasīšanas vērtu."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("Mazs"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Vienmēr tumšs"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("Blāvs"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Maigāks tumšais, zilganpelēks melnā vietā"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Vienmēr gaišs"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Sekot tālruņa gaišajam vai tumšajam iestatījumam"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("Atbloķēt"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("Atcelt apklusināšanu"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("Kas tu esi"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "Savos vārdos: kas jāzina pārskatītājam."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "Es rakstu par putniem šeit un savā vietnē."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("Pievienot vēl vienu saiti"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "Atkal pieprasīt vari no {date}."),
      "ui_verify_ask":
          MessageLookupByLibrary.simpleMessage("Pieprasīt verifikāciju"),
      "ui_verify_before":
          MessageLookupByLibrary.simpleMessage("Pirms pieprasīšanas"),
      "ui_verify_cat_creator":
          MessageLookupByLibrary.simpleMessage("Satura veidotājs"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("Žurnālists"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("Organizācija vai zīmols"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("Kas cits"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("Publiska persona"),
      "ui_verify_denied": MessageLookupByLibrary.simpleMessage(
          "Pieprasījums {number} netika apstiprināts"),
      "ui_verify_done":
          MessageLookupByLibrary.simpleMessage("Tu esi verificēts"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("Rediģēt profilu"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("Ievadi 6 ciparu kodu"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "Atkārtoti sūtīt kodu pēc {seconds} sekundēm"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("Mēs to nosūtījām uz {email}"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("Verificēt"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Kļūsti verificēts Kyron"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Kļūsti"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("verificēts"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("Kyron."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "Nozīmīte nozīmē, ka kāds no Kyron komandas pārbaudīja, ka šis konts ir tas, par ko uzdodas. Tā nedod papildu sasniedzamību un nav pārdošanā."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "Nozīmīte paliek, kamēr paliek tavs vārds. Ja maini vārdu, tā pazūd, līdz kāds pārbauda jauno."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("Kur varam pārbaudīt"),
      "ui_verify_link_more":
          MessageLookupByLibrary.simpleMessage("Vēl viena saite"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "Vietne vai cits profils, kurā teikts, ka šis Kyron konts ir tavs: ievieto tur savu Kyron vārdu vai saiti uz profilu. Kyron nekad neprasa personu apliecinošus dokumentus."),
      "ui_verify_load_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās ielādēt tavu statusu"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "Pirms pieprasīšanas visam augstāk jābūt atzīmētam."),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "Konts, kas ir vismaz {days} dienas vecs"),
      "ui_verify_req_bio": MessageLookupByLibrary.simpleMessage(
          "Apraksts, kas pasaka, kas tu esi"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("Tavs vārds profilā"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("Profila fotoattēls"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "Nekas tavā vēsturē pēdējās {days} dienās"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "Nosūtīts. To apskatīs cilvēks."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("Kopš {date}."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("Pieprasīt"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Kas tu esi, un saite,\nkas to pierāda"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("Nozīmīte"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "Blakus tavam vārdam,\nvisur, kur tas redzams"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("Cilvēks\npārbauda"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "Kāds no komandas\natver tavas saites"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("Verifikācija"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "Pieprasījums {number} ir pie cilvēka"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "Nosūtīts {date} kā {category}. Kad būs lēmums, saņemsi paziņojumu."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("Atsaukt pieprasījumu"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("Pieprasījums atsaukts."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās pabeigt ierakstu: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("Līdz desmit minūtēm."),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("Klausos…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron ir nepieciešama atļauja izmantot mikrofonu ierakstīšanai. To vari piešķirt ierīces iestatījumos."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "Neizdevās sākt ierakstu: {error}"),
    };

final messageLookup = MessageLookup();
