import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'eu';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Hitza, esaldia edo #etiketa"),
      "about": MessageLookupByLibrary.simpleMessage("Honi buruz"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Gehitu erantzuna"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Gehitu hizkuntzak…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Onartu eta jarraitu"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Baduzu Kyron kontu bat?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Iruzkinak"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Pertsona desberdinak, ez irekierak"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Parte-hartzea"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Atsegiteak"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago ikuslerik"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Inork ez du argitalpen hau ireki oraindik."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Argitaratua"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Gordetzeak"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Ikusleak"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("IKUSLEAK EGUNEKO"),
      "and": MessageLookupByLibrary.simpleMessage("eta"),
      "answerNumber": (Object a0) => "${a0}. erantzuna",
      "arLens": MessageLookupByLibrary.simpleMessage("EH lentea"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage(
          "Erantsi aplikazioaren erregistroa"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Joan-etorriko denbora"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("TOKENAREN EGIAZTAPENA"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Orain emanaldi bat hasiz gero, inork sartu ezingo lukeen gela batean egongo zinateke"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Sortu komunitate bat"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Zertarako da? (aukerakoa)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("berriro sartu."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage(
              "berriro sartu zerrenda honetatik."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Ixten baduzu"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("batu lehenik"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("laster"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Zeure izenean argitaratzen"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("argitaratu komunitate honetan"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Oraintxe"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("1. gaia"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Zuretzat"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("zerbait du."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("bidean da orain."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", ez"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("mugitzen ari naizen"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Desaktibatu soinua"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Aktibatu soinua"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Zuretzat"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Zure fitxak"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Ikurra (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("IKUSLEAK EGUNEKO"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("ezin izan da kargatu"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("argitalpen hau"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Zerbait gehitu nahi? (aukerakoa)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("argitalpen hau"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Kontu batetik"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Amaitu saioa"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Zure kontua"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Berretsi pasahitza"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("orain ez"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Kargatzen…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Argitaratzen…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("duela 3 h"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Kopiatu istorioaren esteka"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Zure istorioa"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Zure kontua, zure argitalpenak eta sakatzen duzuna, honetarako:"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Gehitu gai bat"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("berea."),
      "authorBlocked": (Object a0) => "${a0} blokeatu da",
      "authorPostsHidden": (Object a0) =>
          "Ez dituzu ${a0} erabiltzailearen argitalpenak ikusiko",
      "block": MessageLookupByLibrary.simpleMessage("Blokeatu"),
      "blockAuthor": (Object a0) => "${a0} blokeatu?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
          "Konpilazioaren xehetasunak kopiatu dira"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Jarraituz gero, onartu egiten dituzu"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Jarraituz gero, gure Zerbitzu-baldintzak eta Pribatutasun-gidalerroak onartzen dituzu"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Erregistratuz gero, onartu egiten dituzu"),
      "cancel": MessageLookupByLibrary.simpleMessage("Utzi"),
      "change": MessageLookupByLibrary.simpleMessage("Aldatu"),
      "changeEmail":
          MessageLookupByLibrary.simpleMessage("Aldatu helbide elektronikoa"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Egiaztatu kontua posta elektronikoaren bidez."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Egiaztatu Kyron eskuragarri dagoen"),
      "clear": MessageLookupByLibrary.simpleMessage("Garbitu"),
      "close": MessageLookupByLibrary.simpleMessage("Itxi"),
      "closeCommunity": (Object a0) => "${a0} itxi?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Itxi"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Itxi komunitate hau"),
      "communities": MessageLookupByLibrary.simpleMessage("Komunitateak"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Aurkitu bat Arakatu atalean edo sortu zurea."),
      "composer_placeholder_hot_take":
          MessageLookupByLibrary.simpleMessage("Bota iritzi beroa (edo epela)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Zer duzu buruan?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Esan zuk bakarrik esan dezakezun zerbait…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "Hau da zure seinalea: argitaratu"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Idatzi, hitz egin edo pentsatu ozen"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Berretsi pasahitza"),
      "contactSupport": MessageLookupByLibrary.simpleMessage(
          "Jarri harremanetan laguntzarekin"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Argitalpenek ez dute oraindik hizkuntzarik, beraz honek ez du oraindik zure jarioa iragazten. Zure aukerak orduan arte gordeko dira."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Jarraitu"),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage(
          "Jarraitu posta elektronikoarekin"),
      "copy": MessageLookupByLibrary.simpleMessage("Kopiatu"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Kopiatu txostena horren ordez"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Ezin izan da Google-ren saio-hasiera ireki. ${a0}",
      "couldNotSignOut": (Object a0) => "Ezin izan da saioa amaitu: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Ezin izan da argazkia atera."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Zure profilean eta zure argitalpenen azpian erakusten da."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Ez dago «{query}» bilaketarekin bat datorren herrialderik."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Ez erakutsi herrialderik"),
      "country_search":
          MessageLookupByLibrary.simpleMessage("Bilatu herrialdeak"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Zure profilean eta zure argitalpenen azpian erakusten da. Norbaiten argitalpenak ikustean, zure herrialdea haren Estatistiketan zenbatzen da, bost edo gehiagoko taldeetan bakarrik eta inoiz ez izenez."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Telefonoaren ezarpenetatik"),
      "create": MessageLookupByLibrary.simpleMessage("Sortu"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Sortu kontua"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Sortu zure kontua"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Sortu zure profila"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("EH lentea"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Hasi zuzenekoa"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Testu-argitalpena"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Ahots-argitalpena"),
      "delete": MessageLookupByLibrary.simpleMessage("Ezabatu"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Iruzkin hau ezabatu?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Argitalpen hau ezabatu?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Deskribatu eranskin hau"),
      "description": MessageLookupByLibrary.simpleMessage("Deskribapena"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DIDa arbelean kopiatu da"),
      "done": MessageLookupByLibrary.simpleMessage("Eginda"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Itxi editorea zerbait idatzi ondoren, eta zirriborro bat eskainiko zaizu."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("duela {days} egun"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("duela {hours} ordu"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Oraintxe"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("duela {minutes} minutu"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Oraindik ez da ezer idatzi"),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
          "Inkesta, galderarik gabe oraindik"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Aipua, testurik gabe oraindik"),
      "drafts": MessageLookupByLibrary.simpleMessage("Zirriborroak"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Editatu profila"),
      "email": MessageLookupByLibrary.simpleMessage("Posta elektronikoa"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Posta bidezko jakinarazpenak"),
      "explore": MessageLookupByLibrary.simpleMessage("Arakatu"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Aurpegiaren jarraipena ez dago erabilgarri gailu honetan."),
      "feedTagDetail": (Object a0) =>
          "Oraindik ez da ezer argitaratu #${a0} etiketarekin.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Jarraitu {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Jarraitzaileak"),
      "following": MessageLookupByLibrary.simpleMessage("Jarraitzen"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Pasahitza ahaztu duzu?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Laguntza lortzea"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Jarraitu Google-rekin"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Hasi saioa Google-rekin"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google-k amaitutako saio-hasiera Kyron-i itzultzen dio Android-ek eta iOS-ek soilik erantzuten duten esteka baten bidez; beraz, ${a0} plataforman arakatzaileak ez du non itzuli.\\n\\nGoogle bidez Kyron kontu bat baduzu, aukeratu Jarraitu posta elektronikoarekin helbide berarekin eta sakatu Pasahitza ahaztu duzu: pasahitz bat ezartzeko esteka jasoko duzu.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google bidezko saio-hasierak telefonoko aplikazioa behar du"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Erregistratu Google-rekin"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Gidak eta ohiko galderen erantzunak"),
      "handle": MessageLookupByLibrary.simpleMessage("erabiltzaile-izena"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Laguntza eta euskarria"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Laguntza-zentroa"),
      "home": MessageLookupByLibrary.simpleMessage("Hasiera"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("Lerro bakarrean"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Zure kontua"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Ireki komunitatea"),
      "ins_act_post":
          MessageLookupByLibrary.simpleMessage("Idatzi argitalpen bat"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Ikusi argitalpena"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Editatu zure profila"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Noiz dauden"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Zure ordu-eremuan."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Adinak"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Urtebetetzea eman duten {known} iritsitako pertsonetatik."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Egunero iritsitako pertsonak"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Zein komunitatetan dauden"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Herrialdeak"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Profilean herrialdea duten {known} pertsona iritsietatik."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Azken {days} egunak"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira estatistikak kargatu"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Jarraitzaileak"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez dago erakusteko bezain talde handirik."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Nola hazi"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Jarraitzen dituzten gaiak"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Atsegiteak"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Berria"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Jarraitzaile berriak"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Zure argitalpenetako batek ere ez du inor iritsi aldi honetan."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Ez dizute jarraitzen"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Herrialdeak jendeak bere profilean aukeratutakoak dira. Kyronek ez du inoren hiria edo generoa biltzen, beraz, ez dago haiei buruz ezer erakusteko."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Irekierak"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} iritsita · {likes} atsegite · {replies} erantzun"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Iritsitako pertsonak"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Pertsona bakoitza behin zenbatzen da: zure argitalpenetako bat lehen aldiz erakutsi zitzaion edo ireki zuen. Jarraitzaile berriek oraindik jarraitzen dizute; jarraitzeari uzteak ez dira zenbatzen."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Erantzunak"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Birbidalketak"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Gordetakoak"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Zure audientzia nor den {floor} pertsonak aldi honetan zure argitalpenak ikusi ondoren erakusten da. Gutxiagorekin, norbait seinala lezake."),
      "ins_small_title": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez dago jende nahikorik"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "% {pct}-k dagoeneko jarraitzen dizu: zure argitalpenak batez ere ezagutzen zaituztenengana iristen dira."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "% {pct}-k oraindik ez dizu jarraitzen: zure argitalpenak aurkitzen ari dira."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "{reach} pertsonarengana iritsi zara, aurreko aldian baino % {pct} gutxiago."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Azken {days} egunetan {reach} pertsonarengana iritsi zara."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "{reach} pertsonarengana iritsi zara, aurreko aldian beste gutxi gorabehera."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Azken {days} egunetan inor berrik ez ditu zure argitalpenak ikusi."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "{reach} pertsonarengana iritsi zara, aurreko aldian baino % {pct} gehiago."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "{reach} pertsonarengana iritsi zara, aurreko aldian baino {times}× gehiago."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Haietako gehiagok jarraitzen dute {name} beste edozein gai baino."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Audientzia"),
      "ins_tab_overview":
          MessageLookupByLibrary.simpleMessage("Ikuspegi orokorra"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Zure argitalpen bat aurkitzen dutenek zure profila begiratzen dute jarraitu aurretik. Aurpegi edo logo batek norbait badagoela esaten die."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Gehitu profileko argazkia"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Esan lerro batean zertaz argitaratzen duzun, ezezagun batek jakin dezan zer ematen dion zuri jarraitzeak."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Idatzi biografia"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "Zure {total} argitalpenetatik {without}-k ez zuten gairik. Gai batek argitalpena gai horren jarioan eta jarraitzen diotenen aurrean jartzen du."),
      "ins_tip_add_topics_t": MessageLookupByLibrary.simpleMessage(
          "Gehitu gaiak zure argitalpenei"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} pertsonak erantzun diete zure argitalpenei eta zuk {answered} erantzun dituzu. Idazteko adina axola zitzaien: erantzun batek irakurle bat ohiko bihurtzen du."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Erantzun zure erantzunei"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Zure audientzia aktiboena {when} da. Hori baino lehentxeago egindako argitalpenak jendea izango du zain."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Argitaratu daudenean"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "Jarraitzen ez dizuten {reached} pertsonak ikusi dituzte zure argitalpenak, eta {gained}-k jarraitu dizute. Zure biografiak eta argitalpen berrienek esan dezatela zer espero dezaketen zuregandik."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Bihurtu irakurleak jarraitzaile"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Argitalpen batek zure besteek normalean baino {times}× jende gehiago iritsi zuen. Begiratu zer egin zuen desberdin, eta egin hori gehiago."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "Egin gehiago funtzionatu duena"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Zure argitalpenak ikusten dituzten askok {name}-n daude. Han argitaratzeak gainerakoen aurrean jartzen zaitu."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Argitaratu {name}-n"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "{days} egunetan {posts} aldiz argitaratu duzu. Argitalpen bakoitza aurkitua izateko beste aukera bat da, eta erritmo jarraitu batek zure jarraitzaileen jarioetan mantentzen zaitu."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Argitaratu maizago"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Ez duzu argitaratu azken {days} egunetan. Argitalpenik gabe, ezer ez da inorengana iristen."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Argitaratu zerbait"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Estatistikak"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("Argitalpen onenak"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Aurreko {days} egunekin alderatuta"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Gehitu interes bat"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Arrastatu ordena aldatzeko"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Barran gehienez bost fitxa sartzen dira. Kendu bat beste bat gehitzeko."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Jarraitzen"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Zuretzat"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Traolak hemen agertuko dira jendea erabiltzen hasten denean."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Joera orain"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Bideoak"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Zure fitxak"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Biontzat desagertuko da."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Haritik kenduko da."),
      "join": MessageLookupByLibrary.simpleMessage("Batu"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Jarraitu editatzen"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron-en pantailak zure hizkuntzan daude. Hitzen batek oker ematen badu, esaguzu Bidali iritzia atalean."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Hizkuntzak"),
      "leave": MessageLookupByLibrary.simpleMessage("Irten"),
      "leaveCommunity": (Object a0) => "${a0} komunitatetik irten?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Utzi berriro sartzen"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("Orri 1 irekita"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Gehitu klipa"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Gehitu GIFa"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Gehitu traola"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Gehitu argazkia"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Gehitu inkesta"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Gehitu bideoa"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Gehitu interes bat"),
      "literaladdLabelAsATab": (Object a0) => "Gehitu ${a0} fitxa gisa",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Aplikazioaren hizkuntza"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Aplikazioaren bertsioa"),
      "literalblockAuthor": (Object a0) => "Blokeatu ${a0}",
      "literalblockAuthor2": (Object a0) => "${a0} blokeatu?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Kontu hau blokeatu?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Baztertu erantzuna"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Egiaztatu berriro"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Aukeratu galeriatik"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Garbitu cachea"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Itxi orri guztiak"),
      "literalcloseTabLabel": (Object a0) => "Itxi ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Itxi arakatzailea"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0} itxi?",
      "literalcontactSupport": MessageLookupByLibrary.simpleMessage(
          "Jarri harremanetan euskarriarekin"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Edukiaren hizkuntzak"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Kopiatu esteka"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Kopiatu argitalpenaren esteka"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Kopiatu argitalpenaren testua"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Kopiatu testua"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira komunitateak kargatu"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Ezin izan dira GIFak kargatu"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira jakinarazpenak kargatu"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("Ezin izan dira kideak kargatu"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira argitalpen hauek kargatu"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Ezin izan da elkarrizketa hau kargatu"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da zerrenda hau kargatu"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da argitalpen hau kargatu"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da erantzun hau kargatu"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira etiketa ezagunak kargatu"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Ezin izan dira zure komunitateak kargatu"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira zure mezuak kargatu"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da komunitate hau ireki"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da erantzuna argitaratu."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Bilaketak ez du funtzionatu"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Ezin izan da saioa amaitu: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} orri irekita",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Azaleko argazkia"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Datu-aurrezlea"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Ezabatu argitalpena"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Aurkitu jendea"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Ez erantzun"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Zirriborroa gorde da"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Ezin da iritzia bidali une honetan"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Testuaren tamaina"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIFak ez daude konfiguratuta"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Pasatu beste aplikazio bati"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Ezkutatu pasahitza"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Ezkutatu argitalpen hau"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Ezkutatu egiten du eta honelako gutxiago erakusteko eskatzen digu"),
      "literalhowToBehave": MessageLookupByLibrary.simpleMessage("Nola jokatu"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Jarraitu idazten"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron-ek ez du erantzun"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} data",
      "literalleaveCommunityName": (Object a0) => "${a0} komunitatetik irten?",
      "literallensNameFaceLens": (Object a0) => "${a0}, aurpegiko lentea",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Atsegin dituzun argitalpenak"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Esteka kopiatu da"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Egin moderatzaile"),
      "literalmuteAuthor": (Object a0) => "Isilarazi ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Isilarazi hari hau"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Isilarazi hitzak edo etiketak"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Isilarazitako eta blokeatutako kontuak"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Isilarazita. Ez duzu jakinarazpenik jasoko."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Gailu honetako aplikazioek ez dituzte ${a0} estekak irekitzen.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Gailu honetako arakatzaileek ez dute esteka onartu."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago DIDrik"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("Ez dago zirriborrorik"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago interesik"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago atsegiterik"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago mezurik"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Ez dago jarraitzaile berririk"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago argitalpenik"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago erantzunik"),
      "literalnoRepostsYet": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez dago birbidalketarik"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Ez dago bat datorren etiketa ezagunik"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Ez da inor aurkitu"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Ez da inor kendu"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago inor hemen"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Ez zait interesatzen"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Ez da ezer aurkitu"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago joerarik"),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez dago ezer erregistroan"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Ez dago bat-etortzerik"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Ez dago isilarazitakorik"),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez dago ikusteko ezer"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Ez dago irakurri gaberik"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("Jabeak soilik alda dezake hau"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Ireki erantzuna"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Ireki Kyron-en mezua"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Pasahitza eta saio-hasiera"),
      "literalpostInCommunityName": (Object a0) =>
          "Argitaratu ${a0} komunitatean",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "Argitaratu ${a0} komunitatean",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Argitaratu zure hitzekin gainean"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Hizkuntza nagusia"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push jakinarazpenak"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Egiaztatzen…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Grabatu ahots-argitalpena"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Grabatu berriro"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Kendu moderatzaile gisa"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Kendu komunitatetik"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Kendu gordetakoetatik"),
      "literalremoveLabel": (Object a0) => "Kendu ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Kendu ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "${a0} kendu?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Kendu inkesta"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Kendu erantzun hau"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Ezabatu elkarrizketa hau"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Kendu inkesta hau"),
      "literalreportAuthor": (Object a0) => "Salatu ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Salatu argitalpena"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Birbidali kodea"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Gordetako argitalpenak"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Esan zerbait"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Esan zerbait ${a0} komunitatean",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Bilaketak huts egin du"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Birbidali"),
      "literalsendAgainInCooldownS": (Object a0) => "Birbidali ${a0} s barru",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Eman iritzia"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Bidali esteka"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Bidalita. ${a0}. txostena da.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Ezarri pasahitza eta jarraitu"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Partekatu erregistroa euskarriarekin"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Partekatu komunitate hau"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Partekatu orri hau"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Partekatu profil hau"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Partekatu…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Partekatu aipuarekin"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Erakutsi honelako gehiago"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Erakutsi pasahitza"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Erakutsi emaitzak"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Sortu komunitate bat"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Hasi grabatzen"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Gelditu karga"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Utzi argitalpen hau eta haren erantzunak ikusteari"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Istorioen zinta, ${a0} elementu",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Aldatu kamera"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Etiketatu norbait"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Atera argazkia"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Sakatu banerra edo argazkia aldatzeko"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Sakatu barruko esteka"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Sakatu argazkia eta azala gehitzeko"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("Ez da atera. Saiatu berriro."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Ezin izan da GIF hori kargatu."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Esteka hau ezin da hemen ireki."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Kamera itxita dago"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Komunitate hau"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Erantzun hau jada ez dago"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Itzuli argitalpena"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Desaktibatu soinua"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Aktibatu soinua"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Erabili gureetako bat"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Egiaztapen-kodea berriro bidali da."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Egiaztapenak huts egin du: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Egiaztatu posta elektronikoa"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Ikusleak, atsegiteak, gordetzeak eta iruzkinak"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Zer gordetzen duen Kyron-ek"),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
          "Zer egiten aritu den aplikazio hau"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Zer egin duzun, zer espero zenuen, zer gertatu den "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Argitaratzen duzuna zurea da"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Kyron une honetan eskuragarri dagoen"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Nork erantzun dezake"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Nor etiketatu nahi duzu?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Etiketa ezagun guztiak jarraitzen dituzu dagoeneko"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Dena ikusi duzu"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("Ez zaude inongo komunitatetan"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Saioa amaitu duzu."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) =>
          "${a0} komunitatetik irten zara",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez duzu ezer argitaratu"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Kargatu gehiago"),
      "logCleared":
          MessageLookupByLibrary.simpleMessage("Erregistroa garbitu da"),
      "logCopied":
          MessageLookupByLibrary.simpleMessage("Erregistroa kopiatu da"),
      "logIn": MessageLookupByLibrary.simpleMessage("Hasi saioa"),
      "logOut": MessageLookupByLibrary.simpleMessage("Amaitu saioa"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Saioa amaitu?"),
      "login": MessageLookupByLibrary.simpleMessage("Saio-hasiera"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da saioa hasi. Egiaztatu kredentzialak."),
      "manage": MessageLookupByLibrary.simpleMessage("Kudeatu"),
      "menu": MessageLookupByLibrary.simpleMessage("Menua"),
      "message": MessageLookupByLibrary.simpleMessage("Mezua"),
      "messages": MessageLookupByLibrary.simpleMessage("Mezuak"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "Elkarrizketa guztiak irakurri dituzu."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Ireki norbaiten profila eta sakatu Mezua elkarrizketa bat hasteko."),
      "mute": MessageLookupByLibrary.simpleMessage("Isilarazi"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
          "Isilarazitakoak eta blokeatutakoak"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
          "Isilarazitako hitzak eta etiketak"),
      "name": MessageLookupByLibrary.simpleMessage("Izena"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> pantaila"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Helbide elektroniko berria"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Pasahitz berria"),
      "newPost": MessageLookupByLibrary.simpleMessage("Argitalpen berria"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Orain ez"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Ez da bidali. Sakatu berriro saiatzeko"),
      "nothingMatchesQuery": (Object a0) =>
          "Kyron-en ez dago \"${a0}\" bilaketarekin bat datorren ezer",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Ez dago ezer kopiatzeko"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Atsegiteak, erantzunak eta jarraitzaile berriak hona iristen dira."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Jarraitzen zaituztenak hemen agertuko dira."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Norbaitek zure argitalpena atsegin duenean, hemen agertuko da."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Zure argitalpenei emandako erantzunak hona iristen dira."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Norbaitek birbidaltzen zaituenean, hemen agertuko da."),
      "notifications": MessageLookupByLibrary.simpleMessage("Jakinarazpenak"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Ireki arakatzailean"),
      "or": MessageLookupByLibrary.simpleMessage("edo"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Ez da orria aurkitu"),
      "password": MessageLookupByLibrary.simpleMessage("Pasahitza"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Pasahitza laburregia da"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Aukeratu zure interesak"),
      "post": MessageLookupByLibrary.simpleMessage("Argitaratu"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Argitalpenaren estatistikak"),
      "postInCommunity": (Object a0) => "Argitaratu ${a0} komunitatean",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Argitaratu, esan, erakutsi."),
      "postTextCopied": MessageLookupByLibrary.simpleMessage(
          "Argitalpenaren testua kopiatu da"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Pribatutasun-gidalerroak"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profila eguneratu da"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Biografia"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Herrialdea"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Bistaratzeko izena"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Kokapena"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Sakatu aldatzeko"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Webgunea"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push jakinarazpenak"),
      "quote": MessageLookupByLibrary.simpleMessage("Aipatu"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Aipatu argitalpena"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage(
          "Jarri harremanetan pertsona batekin"),
      "remove": MessageLookupByLibrary.simpleMessage("Kendu"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Elkarrizketa hau ezabatu?"),
      "removeMember": (Object a0) => "${a0} kendu?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Mezu hau ezabatu?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Erantzunak, jarraipenak eta aipamenak"),
      "repliesPolicy": (Object a0) => "Erantzunak: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Erantzun"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Edonork parte har dezake"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Edonork ikus, birbidal eta aipa dezake argitalpen hau oraindik."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-eko edonork erantzun diezaioke argitalpen honi."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Jarraitzen zaituztenak"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Jarraitzen zaituztenek soilik erantzun diezaiokete argitalpen honi."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Aipatzen dituzunak"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Argitalpen honetan @aipatzen dituzunek soilik erantzun dezakete."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Inork ezin du erantzun"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Erantzunak desaktibatuta daude. Zuk erantzun dezakezu oraindik."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Nork erantzun dezake?"),
      "report": MessageLookupByLibrary.simpleMessage("Salatu"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Txostena kopiatu da. Itsatsi euskarriari bidaliko diozun mezu batean."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Salaketa bidalita"),
      "repost": MessageLookupByLibrary.simpleMessage("Birbidali"),
      "reset": MessageLookupByLibrary.simpleMessage("Berrezarri"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Berrezarri pasahitza"),
      "retry": MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
      "save": MessageLookupByLibrary.simpleMessage("Gorde"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Gorde zirriborroa"),
      "saySomething": (Object a0) => "Esan zerbait ${a0} komunitatean",
      "search": MessageLookupByLibrary.simpleMessage("Bilatu"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Bilatu izenaren edo erabiltzaile-izenaren arabera"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Bilatu komunitateak"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Bilatu GIFak"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("Bilatu hizkuntzak"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Bilatu etiketa ezagunak"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Segurtasun-alertak eta kontuko aldaketak"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Aukeratu aplikazioaren interfazearen hizkuntza."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Aukeratu zein hizkuntza agertzen diren zure jarioetan. Bat ere aukeratzen ez baduzu, hizkuntza guztiak erakutsiko dira."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Aukeratu jarioko itzulpenetarako hizkuntza nagusia."),
      "send": MessageLookupByLibrary.simpleMessage("Bidali"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Bidali egiaztapena"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Bidali akats-txostena"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Bidali iritzia"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Bidali salaketa"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Bidali euskarriari"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("Zerbitzuaren egoera"),
      "settings": MessageLookupByLibrary.simpleMessage("Ezarpenak"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Partekatu aplikazioaren erregistroa euskarriarekin"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Hasi saioa Kyron-en"),
      "signedInAs":
          MessageLookupByLibrary.simpleMessage("Saioa hasita honela:"),
      "signupFailed": (Object a0) => "Ezin izan da erregistratu: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Geratu"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron hasieran dago, eta hau benetan konpon dezakeen norbaitengana iristeko biderik azkarrena txartel bat irekitzea da. Esaguzu zer egiten ari zinen eta zer gertatu den."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Aplikazioak ez du oraindik euskarri-sarrerako ontzirik, beraz pantaila honek benetan zaintzen den lekura bidaltzen zaitu, inora ez doan inprimaki batera bidali beharrean."),
      "systemLog":
          MessageLookupByLibrary.simpleMessage("Aplikazioaren erregistroa"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Esaguzu zer falta den edo zer dagoen hautsita"),
      "terms": MessageLookupByLibrary.simpleMessage("Zerbitzu-baldintzak"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Testua, ahotsa eta bideoa, horiek sortzen dituzten pertsonak eta hizketan aritzen diren gelak."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "Editoreak ez du Argitaratu botoirik"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Iluna"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Beti iluna"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Ilundua"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Ilun leunagoa, gris urdinxka beltzaren ordez"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Argia"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("Beti argia"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Sistema"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Jarraitu telefonoaren ezarpen argiari edo ilunari"),
      "translate": MessageLookupByLibrary.simpleMessage("Itzuli"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Itzulpena ez dago aktibatuta oraindik. Zure jarioan ez da ezer itzultzen oraindik; orduan arte gogoratuko da."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Honek Kyron-en beraren hitzak, Flutter-ek berak marrazten dituen interfazearen zatiak, datak eta zenbakiak, eta eskuinetik ezkerrera idazten diren hizkuntzetan aplikazioaren diseinuaren norabidea aldatzen ditu."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Pribatutasun-gidalerroak"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Zerbitzu-baldintzak"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Kontua"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Ondoren"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Aplikazioa eta gailua"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Iruzurra aipatzen ari nintzen jendeari ohartarazteko."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Azaldu zergatik uste duzun erabakia okerra izan zela: zer esan nahi zuen argitalpenak, zer pasa zitzaion taldeari oharkabean edo zergatik ez datorren bat araua. Erabakia hartu ez zuen beste norbaitek irakurriko du."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Zure helegitea"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Idatzi gutxienez \$count karaktere. Erabaki bakoitzari behin aurkez diezaiokezu helegitea."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Bidali helegitea"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Helegitea bidali da. Erabakia hartzean jakinarazpena jasoko duzu."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("\$number kasuaren helegitea"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Itxura"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Argia, iluna edo telefonoaren arabera"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Aurretik"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Ez zarete elkar ikusiko Kyron-en, eta zuen arteko jarraipenak kenduko dira. Ez zaio jakinaraziko."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Barne hartzen du"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Zertarako den (aukerakoa)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Moderatzaileek bakarrik idatz dezakete"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Iragarpenetarako. Komunitateko guztiek irakurri eta erreakzionatu dezakete oraindik."),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "Gehitu argazki bat edo inkesta bat"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Argazkiak eta bideoak"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Itxi txata"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Inork ezingo du bertan irakurri edo idatzi. Ezin da desegin."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Txat hau itxi nahi duzu?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Kopiatuta"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Mezua guztientzat kentzen da. Kyronek kopia bat gordetzen du berrikusteko."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Mezua txateko guztientzat kentzen da."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Editatu txata"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Editatu"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("editatua"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Zure mezua editatzen ari zara"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Ezin izan da txat hau ireki."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Txatak"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("Batu txatera"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Batu komunitatera haren txatak ikusteko eta parte hartzeko."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count batu dira"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Irten txatetik"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Komunitatean zauden bitartean irakurtzen jarrai dezakezu."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Jabeak eta moderatzaileek bakarrik idatz dezakete hemen."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Isilarazi"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Ez duzu jakinarazpenik jasoko, eta ez da Mezuetan zenbatuko."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Txataren izena"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Txat berria"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Ez dago txatik oraindik."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Ez dago txatik oraindik. Ireki bat komunitatearentzat."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Komunitateko txatak ez daude muturretik muturrera enkriptatuta. Komunitateko moderatzaileek eta Kyronek irakur ditzakete."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Ainguratu goian"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Gehitu erantzun bat"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Itxi inkesta"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Itxita"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Denek ikusten dute zenbatek aukeratu duten erantzun bakoitza, inoiz ez nork."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Utzi hainbat aukeratzen"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Inkesta berria"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Aukeratu bat"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("\$n. erantzuna"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Inkesta: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Galdera"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Erantzun bakoitza behin bakarrik ager daiteke inkesta batean."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Aukeratu bat edo gehiago"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count lagunek erantzun dute"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Bilatu txat honetan"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Bilatu txat honetan"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Ez da ezer aurkitu."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Ezin duzu txat hau gehiago ikusi."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Modu motela"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Mezuen artean zenbat itxaron behar den. Ez da moderatzaileei aplikatzen."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("Ordu 1"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minutu"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Modu motela: mezu bat \$seconds segundoro"),
      "ui_cchat_slow_off":
          MessageLookupByLibrary.simpleMessage("Desaktibatuta"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n segundo"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Ikusle gisa irakurri eta erreakzionatu dezakezu. Batu idazteko."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Mezu hori atzeegi dago erakusteko."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Aukeratu duzun zerbait handiegia da bidaltzeko, eta kanpoan utzi da."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Desaktibatu isilarazpena"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Kendu aingura"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Grabatu ahots-ohar bat"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Zu"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Komunitateak"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Zertarako da? (aukerakoa)"),
      "ui_community_posts":
          MessageLookupByLibrary.simpleMessage("Argitalpenak:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Edukia eta bistaratzea"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da zure jarioa kargatu"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira atsegin dituzun argitalpenak kargatu"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da zure profila kargatu"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira gordetako argitalpenak kargatu"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("ID deszentralizatua"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("Arazoak konpontzea"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Taldeak"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("Ez dago talderik"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Hemen agertzen dira zauden taldeak eta batzen zaren komunitateko txatak."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Gehienez \$count txat aingura ditzakezu. Kendu bat lehenik."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Ainguratuta"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Gustukoak"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Gordetakoak"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago ezer hemen"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Jarraitu kontu batzuei eta haien argitalpenak hemen agertuko dira."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "Ezer ez jarraitzen dituzunengandik"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Argitalpenak hemen agertuko dira jendeak idatzi ahala."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Ahultzen"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Ez zait interesatzen"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Erakutsi honelako gehiago"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("Kendua"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Zure jarioaren seinaleak"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Sakatu Erakutsi honelako argitalpen gehiago edo Ez zait interesatzen argitalpen batean, eta hemen agertuko da."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago ezer"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Erakutsi gehiago eta Ez zait interesatzen zure jarioei esaten dietena"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Hasiera eta Arakatu moldatzen dituzte, batez ere argitalpen bakoitzaren gaiaren arabera. Bakoitza erdira ahultzen da hilero eta sei hilabeteren ondoren ez da kontatzen. Kendu bat orain gelditzeko."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Klipa duten argitalpenak hemen agertuko dira."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago bideorik"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Iritzia"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Aurkitu jendea Kyron-en"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Kontu batetik"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Gehitu jendea"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Gehitu"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Gehitu taldearen izena"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Baztertu"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Talde honetako mezuak muturretik muturrera enkriptatuta daude, beste edozein elkarrizketa bezala."),
      "ui_group_event_added": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak gehitu ditu: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak admin egin ditu: \$users"),
      "ui_group_event_created": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak taldea sortu du"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak ezarri du jende berria kide gisa sartzea"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak ezarri du jende berria ikusle gisa sartzea"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor irten da"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak kide egin ditu: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak jabe egin du: \$users"),
      "ui_group_event_removed": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak kendu ditu: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak taldeari izena aldatu dio: \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor erabiltzaileak ikusle egin ditu: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Talde batek gehienez \$count pertsona izan ditzake."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Eskua altxatuta. Adminei jakinarazi zaie."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count idazteko eskatzen"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Idazteko eskatzen"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Geroago gehitutakoak ikusle gisa sartzen dira"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Irten taldetik"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Zure zerrendatik desagertuko da eta ez duzu ikusiko gero esaten dena. Norbaitek berriro gehitu beharko zintuzke."),
      "ui_group_leave_title": MessageLookupByLibrary.simpleMessage(
          "Talde honetatik irten nahi duzu?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Utzi idazten"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Jaitsi eskua"),
      "ui_group_make_admin": MessageLookupByLibrary.simpleMessage("Egin admin"),
      "ui_group_make_owner": MessageLookupByLibrary.simpleMessage("Egin jabe"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Egin ikusle"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count kide"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Kideak"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Taldearen izena"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Eman izena taldeari lehenik."),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("Sortu talde-txata"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Jabe bakarra dago. Admin gisa jarraituko duzu."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("\$name jabe egin nahi duzu?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Altxatu eskua"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("Kendu taldetik"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Kendu admin gisa"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Jada ez zaude talde honetan."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Aldatu izena"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Administratzailea"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Kidea"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Ikuslea"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Ikusle gisa, hemen irakurri eta erreakzionatu dezakezu."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Ikusleek irakurri, erreakzionatu eta eskua altxa dezakete idazteko baimena eskatzeko."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Iradokiak"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Ikusi profila"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("zu"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Ikuslea zara"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Laguntza"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Jasota. Zuri zer erakutsi aukeratzen laguntzen du."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Batu"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Batu zen"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Hizkuntza"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Aukeratu zure hizkuntza"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Lege-oharra"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Atsegin dut"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Atsegin dituzun argitalpenak"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Atsegin dituzun argitalpenak hemen agertzen dira, berrienak lehenik."),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Esteka kopiatu da"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Ez dituzu haren argitalpenak gehiago ikusiko. Ez zaio jakinaraziko."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago atsegiterik"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Ez dago iragazki horiekin bat datorren argitalpenik."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago gordetakorik"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Zure kontua eguneratu da"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "\$number kasuari buruzko zure helegitea onartu da"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "\$number kasuari buruzko zure helegitea berriro aztertu dugu, eta erabakiak bere horretan dirau"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Zure kontua betiko debekatu da"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("\$number kasua · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("jarraitzen hasi zaizu"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("atsegin du zure argitalpena"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("aipatu zaitu"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago aipamenik"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Norbaitek zure @erabiltzailea argitalpen edo erantzun batean idazten duenean, hemen agertuko da."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Zaharragoak"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Komunitateko txat bateko zure mezua kendu da"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Argitaratu zenuen zerbait kendu da"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Zure argitalpena kendu da"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Zure erantzuna kendu da"),
      "ui_notif_replied": MessageLookupByLibrary.simpleMessage(
          "erantzun dio zure argitalpenari"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Salatu zenuen zerbaiten aurrean neurriak hartu ditugu. Eskerrik asko jakinarazteagatik."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Salatu zenuen zerbait aztertu dugu, eta ez dugu ikusi gure arauak hautsi zituenik."),
      "ui_notif_reported_for": MessageLookupByLibrary.simpleMessage(
          "Salaketaren arrazoia: \$reason"),
      "ui_notif_reposted": MessageLookupByLibrary.simpleMessage(
          "berriro argitaratu du zure argitalpena"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "\$number kasuko erabakia atzera bota dugu"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Zure kontua etenda dago"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Zure kontua \$date arte etenda dago"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Guztiak"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Jarraipenak"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Atsegiteak"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Aipamenak"),
      "ui_notif_tab_replies":
          MessageLookupByLibrary.simpleMessage("Erantzunak"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Aste honetan"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Gaur"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Zure kontuak ohartarazpen bat du"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Atzo"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Eginda"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Saltatu"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Hau dagoeneko ireki da."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Iraungita"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Ezin izan da ireki."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Behin irekitzen da, eta gero Kyronetik ezabatzen da."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Ikusi behin"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Irekita"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "\$total(e)tik \$count(e)k ireki dute"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Bidali diezunek bakarrik ireki dezakete, behin."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Bidali behin ikusteko"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Sakatu ikusteko"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pausatu"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Erreproduzitu"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Zure profiletik eta guztien jarioetatik kenduko da. Haren erantzunak ere berarekin joango dira."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Argitalpena ezabatu da"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Argitalpena ezkutatu da"),
      "ui_post_text_copied": MessageLookupByLibrary.simpleMessage(
          "Argitalpenaren testua kopiatu da"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Noiz argitaratua"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Ezkutatuta. Honelako gutxiago erakutsiko ditugu."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Hobespenak"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Pribatutasuna"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Zerbait gehitu nahi duzu? (aukerakoa)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Taldeak erabakitzen duenean jakinarazpen bat jasoko duzu, eta Zure salaketak atalean jarrai dezakezu."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Pertsona hori ere ikusi nahi ez baduzu, isildu edo blokeatu menu beretik."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Gauza bera bi aldiz salatzeak ez dio pisu gehiago ematen: pertsona bakoitzeko salaketa bat gordetzen dugu."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Zure salaketa ez zaio pertsona horri erakusten. Salatu duzunaren kopia bat gordetzen dugu, ezabatzen bada ere berrikusi ahal izateko."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Zure salaketa jaso dugu eta berrikusteko zain dago. Ez diogu pertsona horri esaten nork salatu duen."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Ikusi zure salaketak"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Esaguzu zer dagoen gaizki"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Eskerrik asko esateagatik"),
      "ui_report_what_account": MessageLookupByLibrary.simpleMessage(
          "Zer dago gaizki \$name kontuarekin?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("Zer dago gaizki mezu honekin?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Zer dago gaizki argitalpen honekin?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Zer dago gaizki erantzun honekin?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Komunitateko txat bateko mezu bat"),
      "ui_reports_a_post":
          MessageLookupByLibrary.simpleMessage("Argitalpen bat"),
      "ui_reports_a_reply":
          MessageLookupByLibrary.simpleMessage("Erantzun bat"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Neurriak hartu dira"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("Kontu bat"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Erabakia: \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Ez da araurik hautsi"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira kargatu zure salaketak"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Azken 90 egunetan salatu duzuna, eta zertan geratu den. Taldeak erabakitzen duenean jakinarazpen bat jasotzen duzu. Salatzen duzunari ez zaio inoiz esaten nork salatu duen."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Ez duzu ezer salatu"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Argitalpen, erantzun, mezu edo kontu bat salatzen duzunean, hemen agertzen da emaitzarekin batera."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("Berrikusten"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Salatua: \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Salatu duzuna, eta zertan geratu den"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Zure salaketak"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Haurren segurtasuna"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Adingabe bat arriskuan jartzen edo sexualizatzen duen edozer."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Jazarpen zuzendua, mehatxuak edo nahi ez den harremana."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Pertsonei diren bezalakoak izateagatik egindako erasoak."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Legez kanpoko zerbait saltzea edo sustatzea."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Beste norbait balitz bezala aurkeztea."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Zure lana edo marka baimenik gabe erabiltzen du."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Osasunari, hauteskundeei edo gertaerei buruzko baieztapen engainagarriak."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Autolesioa bultzatzea edo erakustea."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Abisurik gabe erakutsitako eduki sexuala."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Aurrekoetako bat ere ez. Esaguzu zer dagoen gaizki."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Sustapen errepikakorra, engainagarria edo nahi gabea."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Indarkeriaz mehatxatzea, goratzea edo hartara bultzatzea."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Jazarpena edo bullyinga"),
      "ui_rule_hate":
          MessageLookupByLibrary.simpleMessage("Gorroto-diskurtsoa"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Legez kanpoko ondasunak edo zerbitzuak"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Nortasun-ordezpena"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Jabetza intelektuala"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Informazio faltsua"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Suizidioa edo autolesioa"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Helduentzako edukia"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Beste zerbait"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spama"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Indarkeria edo mehatxuak"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Gordetako argitalpenak"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Sakatu argitalpen baten artxibo-ikonoa hemen gordetzeko. Zuk bakarrik ikusten dituzu gordetakoak."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Bilatu erabiltzaile-izenaren edo bistaratzeko izenaren arabera."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Garbitu"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Bilatu argitaratutako guztian"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Iragazkiak"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Bilatu jendea"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Bilatu argitalpenak"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Ezarpenak"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Aplikazioa eta gailua"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Edukia eta bistaratzea"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Datu-aurrezlea"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Partekatu zure iritzia"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Arakatu laguntza-artikuluak"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Aukeratu hizkuntza"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Nor isilarazi edo blokeatu duzun"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Jakinarazpen-hobespenak"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Zure profila eta harremanetarako datuak"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Berriro hasi beharko duzu saioa zure kontura itzultzeko."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Segurtasun-ezarpenak"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Berretsi pasahitza"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("Lerro bakarrean"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Helbide elektroniko berria"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Pasahitz berria"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Zer gertatu da"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Lortu laguntza gure taldetik"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Partekatu"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Aipatu"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Bidali mezu batean"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron-eko jendeari"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Partekatu argitalpen hau"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Zeri buruzkoa zen"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Zure kontua betiko debekatu da"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Erantzuna, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Helegitea"),
      "ui_standing_appeal_button": MessageLookupByLibrary.simpleMessage(
          "Aurkeztu helegitea erabaki honen aurka"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Erabaki honen aurka ezin da helegiterik aurkeztu. Zerbait gaizki badago, jarri harremanetan laguntzarekin."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Helegitea aztertzen"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Helegitea onartu da"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Taldeko beste norbait berriro aztertzen ari da. Erabakia hartzean jakinarazpena jasoko duzu."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Akats bat izan dela uste baduzu, berriro aztertzeko eska dezakezu \$date arte. Taldeko beste norbaitek erabakiko du."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Helegitea aurkeztuta: erabakiak bere horretan dirau"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "\$number kasua. Araua: \$rule. Taldeak idatzi zuen:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Kontua ezabatzeak ez du debekua kentzen: helbide elektroniko bera duen kontu berria ere debekatuta hasiko da."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Betiko debekatua"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Orri hau, helegiteak, laguntza eta kontua ezabatzea baino ez dabiltza."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Helegitea aurkez daiteke"),
      "ui_standing_case":
          MessageLookupByLibrary.simpleMessage("\$number kasua"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Erabakia: \$date"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "Zure kontuari buruzko erabakiak"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Ezabatu zure kontua"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Ikusi xehetasunak"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "Ikusi xehetasunak eta aurkeztu helegitea"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Amaiera: \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Zure kontua egoera onean dago"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Ez du murrizketarik."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da kargatu kontuaren egoera"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Mezua kendu da"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Ez da ezer erabaki zure kontuari buruz. Taldeak noizbait zurea den zerbait kentzen badu edo zure kontua mugatzen badu, hemen agertuko da arrazoiarekin, eta helegitea aurkeztu ahal izango duzu."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Ez dago ezer helegiteko: erabakia atzera bota da."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Argitalpena kendu da"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Arrastatu behera berriro egiaztatzeko."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Irakurri Kyronen arauak"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Erantzuna kendu da"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("Atzera bota da"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Atzera bota da \$date. Kendutako guztia itzuli da, eta ez dago murrizketarik indarrean."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("Araua: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("Amaitu saioa"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("Etenda"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Irakur dezakezu, baina ezin duzu argitaratu, erantzun, jarraitu edo mezurik bidali. Salatzea, blokeatzea eta isiltzea oraindik dabiltza."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Zure kontua etenda dago: irakur dezakezu, baina ez argitaratu."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Etenda \$date arte"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Zure kontua etenda dago \$date arte: irakur dezakezu, baina ez argitaratu."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Taldeak esandakoa"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Kontuaren egoera"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Abisua"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Zergatik?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Zuk idatzia, \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Zure mezua"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Zure argitalpena"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Zure erantzuna"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Zerbitzu-baldintzak"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("argitalpen hau"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Haria isilarazi da"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Desaktibatu soinua"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("Aktibatu soinua"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Gutxienez bi karaktere."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Desegin"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Hitzak edo iragazki bat: kontu bat, data-tarte bat edo argitalpen batek duena."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Desegin birbidalketa"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Eguneratu pasahitza"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Erabili beste helbide bat"),
      "username": MessageLookupByLibrary.simpleMessage("Erabiltzaile-izena"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Erabiltzaile-izenak minuskulaz izan behar du (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Bideoa"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Erantsi"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Eransteko prest"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Grabatu ahots-argitalpena"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Gordetzen…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Gelditu"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Zer gertatu da"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Zer gertatu da, eta zer begiratu behar dugu?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Zer dago irudi honetan?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Zertarako da? (aukerakoa)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Zer egin duzun, zer espero zenuen, zer gertatu den"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Zer egiten ari zinen gertatu zenean."),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("Erantzun duzu"),
      "dmReplied": (Object a0) => "$a0(e)k erantzun du",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Gehitu mezuari"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Mezu berria"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez da ezer esan. Agur bat hasiera ona da."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Agurtu"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Mezu berriak"),
      "dmTyping": (Object a0) => "$a0 idazten ari da",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Kendu zure erreakzioa"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Norbait"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Mezua"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Eranskina"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Mezu hau ezin da gailu honetan irakurri."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Mezu honen zain. Baliteke denbora pixka bat behar izatea."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Mezu enkriptatua"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Mezuak muturretik muturrera enkriptatuta daude"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Ez dago muturretik muturrera enkriptatuta"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Bidalita"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Ikusita"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Bidaltzen…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Atera argazki bat"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Aukera gehiago"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("Gorde gailuan"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Partekatu"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Gordetzen…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Zure argazkietan gorde da"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da gorde. Saiatu berriro."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Utzi Kyron-i zure argazkietara gehitzen hau gordetzeko."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Sistema guztiak martxan"),
      "ui_status_uptime":
          MessageLookupByLibrary.simpleMessage("Erabilgarritasuna"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Azken 60 egunak"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Duela 60 egun"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Gaur"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Datu-basea"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Saio-hasiera"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Azken gorabeherak"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Ez dago gorabeherarik azken 60 egunetan."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Martxan"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Daturik ez"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Xehetasunak"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyronek bere burua egiaztatzen du 5 minuturo martxan dagoen bitartean. Egun gris batek ez zuen egiaztapenik izan."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Erabilgarritasunaren historia ez dago oraindik erabilgarri."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Sistema batzuek arazoak dituzte"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Grabatu ahots-ohar bat"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Bidaltzeko prest"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Mezu hori jada ez dago hemen."),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("Joan mezura"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("Ahots-oharra"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Egileak atsegin du"),
      "ui_add_photo_or_clip": MessageLookupByLibrary.simpleMessage(
          "Gehitu argazki bat edo klip bat"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Multimedia"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Ahots-oharrak"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Txata"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("Horma-papera"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Isilarazi jakinarazpenak"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Utzi elkarrizketa honi buruzko jakinarazpenak jasotzeari"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Jada ezin dizute mezurik bidali"),
      "ui_dm_wallpaper_none":
          MessageLookupByLibrary.simpleMessage("Bat ere ez"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Argazkia"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Isilarazpena kendu da."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da kendu. Saiatu berriro."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profila"),
      "ui_dm_unmute":
          MessageLookupByLibrary.simpleMessage("Kendu isilarazpena"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Partekatzen dituzun argazkiak eta klipak hemen agertzen dira."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Ikusi guztiak"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Argazkiak eta klipak"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Horrela ikusiko da zure txata."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Ondo dago."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Lainoa"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Ilunabarra"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Salbia"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Harea"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Puntuak"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Aplikatu"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("Unekoa"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Bidali aurrebistarik gabe"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Bilatu"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Argitaratu"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Idatzi mezu bat…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Bidali"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Bidalita"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Bidalita, baina ez guztiei."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da bidali. Saiatu berriro."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Jarraitzailea"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Iragazkia"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Guztiak"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Irakurri gabeak"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Erantzunik gabeak"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Ezkutuak"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Ez dago ezer ezkutatuta"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Zerrendatik kentzen dituzun elkarrizketak hemen daude zain, berreskuratu nahi badituzu."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Ezkutuetara pasatzen da. Besteak berea gordetzen du, eta itzuli egiten da zuetako batek berriro idazten badu."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Berreskuratu"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Berriro zure zerrendan."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "Ez dago bat datorren elkarrizketarik."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Ezerk ez zaitu zain"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Elkarrizketa guztiak zure hitzarekin amaitzen dira."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Argazkia"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Argazkiak"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Bideoa"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago mezurik"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Zu:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Atzo"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Mezuak"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Mezuen ezarpenak"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Pribatutasuna"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Irakurketa-baieztapenak"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Desaktibatuta badago, besteek ez dute ikusiko noiz irakurri dituzun haien mezuak, eta zuk ez duzu ikusiko noiz irakurri dituzten zureak."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Erakutsi idazten ari zarenean"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Idazten diozun pertsonak ikusten du idazten ari zarela."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Esteken aurrebistak"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Zure telefonoak bidaltzen duzun esteka irekitzen du aurrebista egiteko, beraz guneak zure telefonoaren eskaera ikusten du. Kyronen zerbitzariak ez du inoiz esteka ikusten."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Mezuen jakinarazpenak"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Mezuak muturretik muturrera enkriptatuta daude. Kyronek ezin ditu irakurri, eta hemengo ezerk ez du hori aldatzen."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Nori:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Azkenak"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Pertsonak"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Ez dago izen horretako inor."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Bidali proba-jakinarazpen bat"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyronen zerbitzaria ez dago oraindik jakinarazpenak bidaltzeko konfiguratuta, beraz ezin da bat ere iritsi. Arazoa gurea da, ez zure telefonoarena."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Telefono hau ez dago jakinarazpenetarako erregistratuta. Egiaztatu telefonoaren ezarpenetan Kyronen jakinarazpenak baimenduta daudela, eta saiatu berriro."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da jakinarazpena telefono honetara bidali. Saiatu berriro minutu batean."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Bidalita. Segundo gutxitan iritsi beharko luke."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Jakinarazpenak badabiltza."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Oraindik ez dago argitalpenik"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Komunitate berria"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Izena"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Helbidea izenetik sortzen da."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Jendeak hemen aurkituko du:"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Zu izango zara jabea. Irudia, bannerra eta moderatzaileak bere orritik gehi daitezke sortu ondoren."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Hasiera"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Komunitateetako argitalpenak Hasieran"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Zure komunitateetako argitalpenak Hasieran ere agertzen dira. Desaktibatuta, hemen geratzen dira Komunitateetan, non bakoitzak zer den berria erakusten duen."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Zure zerrenda"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Argitalpen berrien kopurua"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Erakutsi komunitate bakoitzean zenbat argitalpen diren berriak azkenekoz ireki zenuenetik."),
      "ui_community_settings_running": MessageLookupByLibrary.simpleMessage(
          "Zuk kudeatzen dituzun komunitateak"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Sortzen edo moderatzen dituzun komunitateak hemen zerrendatzen dira."),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("Jabea"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderatzailea"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Argitalpen berriak"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Zuk kudeatuak"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Komunitateen ezarpenak"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Aurkitu"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "Ez dago bat datorren komunitaterik."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Ezer berririk ez"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Komunitate bakoitza utzi zenuen bezala dago."),
      "ui_community_running_none": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez duzu bat ere kudeatzen"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Ez da ezer geratzen batzeko"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-eko komunitate guztietan zaude. Sortu beste bat."),
      "ui_community_discover_search_detail": MessageLookupByLibrary.simpleMessage(
          "Saiatu beste hitz batekin, edo sortu izen horrekin komunitate bat."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Idatzi argitalpen bat"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Kideak:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Argitaratuta"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Ikusi"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Ireki"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Konektatuta"),
      "ui_dm_show_online": MessageLookupByLibrary.simpleMessage(
          "Erakutsi konektatuta zaudenean"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Idazten diezunek puntu berde bat ikusten dute Kyron irekita duzun bitartean. Desaktibatuta badago, zuk ere ez duzu haiena ikusiko."),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "Bilatu jendea eta argitalpenak"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Batzeko komunitateak"),
      "ui_explore_grid_empty": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez dago ezer ikusteko"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Jendeak argitaratzen dituen argazkiak eta klipak hemen agertuko dira."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Jarraitu"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Ezabatu kontua"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Honek betiko ezabatzen du zure Kyron kontua. Ezin da desegin."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Zure profila, argitalpenak, erantzunak, atsegiteak eta birbidalketak"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Zure mezuak, besteei bidalitakoak barne, eta haietako argazkiak eta ahots-oharrak"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Zure jarraitzaileak, jarraitzen dituzun pertsonak eta zure ezarpenak"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Sortu dituzun komunitateak antzinatasun handieneko moderatzaile edo kideari pasatzen zaizkio. Beste inor ez duen komunitatea itxi egiten da."),
      "ui_delete_account_confirm_title": MessageLookupByLibrary.simpleMessage(
          "Zure kontua ezabatu nahi duzu?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Ezin izango duzu ezer berreskuratu."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Zure kontua ezabatu da."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Ezabatutako kontua"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Kontu hau ezabatu egin da, beraz, ezin da hona mezurik bidali."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google-ekin erregistratu zinen? Erabili «Sign in with Google»."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da iragazki hori kargatu."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Ezin izan da bideoa grabatu."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Ezin izan zaio iragazkia bideo honi gehitu; beraz, grabatu zen bezala argitaratuko da."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Zure argitalpenak gehienezko eranskin kopurua du dagoeneko."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Iragazkia gehitzen…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Flasha"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("Grabatu bideo bat"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Argazkia"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Bideoa"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Google bidezko saioa hastea bertan behera utzi da."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("OPARIAK"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Inork ez dio oraindik oparirik bidali argitalpen honi."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Oparia"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Opariak"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Txanponak"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Igorlea"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Igorleak"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Proba-txanponak: oraindik ezin dira atera."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Gordeta"),
      "ui_saved_tab_posts":
          MessageLookupByLibrary.simpleMessage("Argitalpenak"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Iruzkinak"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Ikusi erantzun gehiago"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Editatuta"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Gehiago"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Jarraitzen"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Onenak"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Berrienak"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Ordenatu iruzkinak: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "opari bat bidali dio zure argitalpenari"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "\$gift bat bidali dio zure iruzkinari"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "\$gift bat bidali dio zure argitalpenari"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Bidali opari bat"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("Editatu argitalpena"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Beste \$n minutuz edita dezakezu"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Gorde"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez da ezer argitaratu #\$tab etiketan."),
      "ui_gift_pick":
          MessageLookupByLibrary.simpleMessage("Aukeratu opari bat"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Ez duzu txanpon nahikorik"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Proba-txanponak: ezin dira erosi eta ez dute diru-baliorik."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("\$date egunean betetzen da."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("Txanpon 1"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count txanpon"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("\$coins dituzu"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Bidali \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift bidalita"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("Argitaratu eta 15 minutuz"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Editatuta"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Ezin izan dira gordetako iruzkinak kargatu"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Ez dago gordetako iruzkinik"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Sakatu iruzkin baten azpiko artxibo-ikonoa hemen gordetzeko. Gordetzen duzuna zuk bakarrik ikusten duzu."),
      "ui_replying_to": MessageLookupByLibrary.simpleMessage(
          "\$name erabiltzaileari erantzuten"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Kopiatu"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Bilatu"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Hautatu guztiak"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count opari"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("Opari 1"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da argitalpen gehiago kargatu."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Gogorarazleak"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Zer dagoen berri kanpoan egon ondoren, eta txanponak noiz itzultzen diren. Inoiz ez bat baino gehiago egunean."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Opariak"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("pertsona batengandik"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count pertsonarengandik"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Emaile handiena"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da kargatu nork bidali dituen opariak."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Berritasunak"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Ulertuta"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Eskerrik asko. Erantzun guztiak irakurtzen ditugu."),
      "ui_check_in_title": MessageLookupByLibrary.simpleMessage(
          "Zer iruditzen zaizu Kyron orain arte?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Zure probaren \$day. eguna. Ukitu bat nahikoa da."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Zerbait konpondu edo gehitu beharko genuke? (aukerakoa)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Bidali"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Orain ez"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Sakatu atzera berriro Kyron uzteko"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Berretsi zu zarela"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Idatzi pasahitza kontua ezabatzeko."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Hasi saioa berriro Google-rekin kontua ezabatzeko."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Ez du funtzionatu. Egiaztatu eta saiatu berriro."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Orri honek beste aplikazio bat ireki nahi du"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "{scheme} esteka bat irekitzeko eskatzen du."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("Konpilazioa"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "Cachean gordetako {size} irudi eta fitxategi"),
      "ui_about_freed": MessageLookupByLibrary.simpleMessage("{size} askatuta"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("Neurtzen…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("Ez dago ezer garbitzeko"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("Biltegiratzea"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("{version} bertsioa"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("Blokeatuak"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("Zure izenean argitaratzen"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "Eranskin horiek ez dira kargatu. Sakatu bat berriro saiatzeko, edo kendu."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da helbide elektronikoa aldatu. Saiatu berriro."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "Bidaltzen dizugun esteka irekitzean aldatuko da helbidea."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "Begiratu {email} helbidean berrespen-esteka."),
      "ui_email_enter": MessageLookupByLibrary.simpleMessage(
          "Idatzi helbide elektroniko bat."),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage(
          "Hori ez dirudi helbide elektroniko bat."),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "Hori da dagoeneko zure helbide elektronikoa."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "Zer egin zenuen, zer espero zenuen eta zer gertatu zen horren ordez."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "Utzi argitalpen bat profilean ainguratzen"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "Zer nahiko zenukeen, eta horrek zer egiteko aukera emango lizukeen."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("Zerk lagunduko luke"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("Arazo bat"),
      "ui_feedback_kind_idea":
          MessageLookupByLibrary.simpleMessage("Ideia bat"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("Galdera bat"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "Kyron taldeak bakarrik irakurtzen du hau. Zure kontuarekin bidaltzen da, posta elektronikoz erantzun ahal izateko, eta erabiltzen duzun aplikazioaren bertsioarekin. Kontua ezabatzen baduzu, hau ere ezabatzen da."),
      "ui_feedback_question_example": MessageLookupByLibrary.simpleMessage(
          "Nola isilarazten dut hitz bat?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "Zer egin nahi duzun eta non trabatu zaren."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("Zure galdera"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da Kyron-ekin konektatu. Egiaztatu konexioa eta saiatu berriro. Oraindik ez da ezer idatzi, beraz ez da ezer galdu."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("Garbitu"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Huts egindako eskaerak eta beste gertaera nabarmen batzuk hemen agertzen dira."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("Isilaraziak"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "Gehitu hitz edo etiketa bat goian. Hori duten argitalpenak ez dira zure jarioan agertuko."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "Hauetako edozein duten argitalpenak ez dira zure jarioan agertzen. Maiuskulek eta minuskulek ez dute axola, eta hitz bat hitz luzeagoen barruan ere bat dator, beraz «spoiler»-ek «spoilers» ere harrapatzen du."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("Ez dago inor blokeatuta"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "Blokeatzeak elkarrengandik ezkutatzen zaituzte, bi noranzkoetan. Blokeatu norbait bere profileko menutik."),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("Ez dago inor isilarazita"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "Kontu bat isilarazteak haren argitalpenak ezkutatzen ditu, jakinarazi gabe. Isilarazi norbait bere profileko edo argitalpen bateko menutik."),
      "ui_password": MessageLookupByLibrary.simpleMessage("Pasahitza"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("Ez datoz bat."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "Gailu honetan saioa hasita jarraituko duzu. Beste gailuetan saioa amaituko da."),
      "ui_password_too_short": MessageLookupByLibrary.simpleMessage(
          "Erabili gutxienez 8 karaktere."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da pasahitza eguneratu. Saiatu berriro."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("Pasahitza eguneratu da."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DIDa kopiatu da"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "Gustuko dituzun argitalpenak hemen gordetzen dira, zuretzat bakarrik."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "Oraindik ez duzu argazki edo kliprik argitaratu."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name}(e)k oraindik ez du argazki edo kliprik argitaratu."),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "Argitaratzen duzun guztia hemen agertzen da."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name}(e)k oraindik ez du ezer argitaratu."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da zure profila kargatu"),
      "ui_profile_load_failed_other": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da @{handle} kargatu"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("Gutxienez 8 karaktere"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("Minuskula (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("Gutxienez zenbaki bat"),
      "ui_pw_rule_symbol":
          MessageLookupByLibrary.simpleMessage("Ikurra (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("Maiuskula (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "Azken {count} sarrera. Bidali aurretik, berrikusi Honi buruz › Sistemaren erregistroa atalean."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "Kyron taldeak bakarrik irakurtzen du hau. Zure kontuarekin bidaltzen da, jarraipena egin ahal izateko. Irakurri lehenik erregistroa Honi buruz › Sistemaren erregistroa atalean, harekin zer doan zehazki ikusi nahi baduzu."),
      "ui_report_sent":
          MessageLookupByLibrary.simpleMessage("Bidalita, eskerrik asko."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "Bidalita, eskerrik asko. {number}. txostena da."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("Zer joan da gaizki?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "Bertsioa, gidalerroak, egoera eta sistemaren erregistroa"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "Ez erreproduzitu bideoak berez korritzean"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "Zure identifikatzaile deszentralizatua"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("Moderazioa"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "Berrikusteko zain dauden salaketak eta helegiteak"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "Mantendu jariotik kanpo hauek dituzten argitalpenak"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("Saioa hasi gabe"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("Jakinarazpenen hobespenak"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("Pribatutasuna eta segurtasuna"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "Zure kontuari buruzko erabakiak eta helegiteak"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("Doitu testuaren tamaina"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("Zure kontua"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "AR lenteak grabatzea eta argitaratzea eraikitzen ari da oraindik. Hartzen duzun ezer ez litzateke oraindik gordeko, beraz kamera itxita geratzen da."),
      "ui_soon_lens_heading": MessageLookupByLibrary.simpleMessage(
          "Lenteak ez daude prest oraindik"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR lentea"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "Zuzenean emateko, Kyron-ek oraindik martxan ez duen multimedia-zerbitzari bat behar da. Orain emanaldi bat hasiz gero, inor sartu ezin den gela batean egongo zinateke. Ahots-argitalpen bat grabatzeak gaur bertan funtzionatzen du."),
      "ui_soon_live_heading": MessageLookupByLibrary.simpleMessage(
          "Zuzenekoa ez dago prest oraindik"),
      "ui_soon_live_title":
          MessageLookupByLibrary.simpleMessage("Zuzenean eman"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Inkestek aukerak gordetzeko eta botoak zenbatzeko leku bat behar dute. Hori ez dago oraindik, beraz gaur argitaratutako inkesta batek erantzun guztiak galduko lituzke."),
      "ui_soon_poll_heading": MessageLookupByLibrary.simpleMessage(
          "Inkestak ez daude prest oraindik"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("Inkesta"),
      "ui_soon_write_instead": MessageLookupByLibrary.simpleMessage(
          "Idatzi testu-argitalpen bat horren ordez"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("Egiaztatu berriro"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("Xehetasuna"),
      "ui_status_mirror": MessageLookupByLibrary.simpleMessage("Ispilu-taulak"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron-ek erantzun du, baina zerbait ez dago ondo."),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("Joan-etorria"),
      "ui_support_ask":
          MessageLookupByLibrary.simpleMessage("Egin galdera bat"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Zure kontuari buruz, edo zerbaitek nola funtzionatzen duen"),
      "ui_support_by_email":
          MessageLookupByLibrary.simpleMessage("Posta elektronikoz"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-ek huts egin badu: aplikazioaren erregistroa ere bidaltzen du"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("Aplikazioan"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "Idatzi Kyron taldeari hemendik. Modu pribatuan iristen zaigu, zure kontuarekin, eta bertako helbide elektronikora erantzuten dugu."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "Ez da posta-aplikaziorik ireki. {address} kopiatu da."),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("Pribatutasuna eta zure datuak"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("Jakinarazi arazo bat"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "Zerbait hautsita dago edo ez du egin beharrekoa egiten"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "Argitalpen edo kontu bat salatzeko, erabili haren menua: horrela badakigu zehazki zein esan nahi duzun."),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("Segurtasuna eta gehiegikeria"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron denentzat dagoen eroria, ala zuretzat bakarrik"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("Handia"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("Handiagoa"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("Ertaina"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron irakurtzea merezi duen zerbait esateko lekua da."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("Txikia"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Beti iluna"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("Ilundua"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Ilun leunagoa, gris urdinxka beltzaren ordez"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Beti argia"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Jarraitu telefonoaren ezarpen argi edo ilunari"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("Desblokeatu"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("Utzi isilarazteari"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("Nor zaren"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "Zure hitzekin, berrikusleak zer jakin beharko lukeen."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "Hegaztiei buruz idazten dut hemen eta nire webgunean."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("Gehitu beste esteka bat"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "{date}(e)tik aurrera eska dezakezu berriro."),
      "ui_verify_ask":
          MessageLookupByLibrary.simpleMessage("Eskatu egiaztapena"),
      "ui_verify_before":
          MessageLookupByLibrary.simpleMessage("Eskatu aurretik"),
      "ui_verify_cat_creator":
          MessageLookupByLibrary.simpleMessage("Sortzailea"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("Kazetaria"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("Erakundea edo marka"),
      "ui_verify_cat_other":
          MessageLookupByLibrary.simpleMessage("Beste zerbait"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("Pertsona publikoa"),
      "ui_verify_denied": MessageLookupByLibrary.simpleMessage(
          "{number}. eskaera ez da onartu"),
      "ui_verify_done":
          MessageLookupByLibrary.simpleMessage("Egiaztatuta zaude"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("Editatu profila"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("Idatzi 6 digituko kodea"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "Bidali kodea berriro {seconds} segundo barru"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("{email} helbidera bidali dugu"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("Egiaztatu"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Lortu egiaztapena Kyron-en"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Lortu"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("egiaztapena"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("Kyron-en."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "Bereizgarriak esan nahi du Kyron taldeko norbaitek egiaztatu duela kontu hau dela esaten duena. Ez du irismen gehigarririk ematen, eta ez dago salgai."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "Bereizgarria zure izena dagoen bitartean geratzen da. Izena aldatzen baduzu, kendu egiten da norbaitek berria egiaztatu arte."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("Non egiazta dezakegun"),
      "ui_verify_link_more":
          MessageLookupByLibrary.simpleMessage("Beste esteka bat"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "Kyron kontu hau zurea dela dioen webgune edo beste profil bat: jarri bertan zure Kyron izena edo zure profilerako esteka. Kyron-ek ez du inoiz nortasun-agiririk eskatzen."),
      "ui_verify_load_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da zure egoera kargatu"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "Goiko guztiak markatuta egon behar du eskatu aurretik."),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "Gutxienez {days} eguneko kontua"),
      "ui_verify_req_bio": MessageLookupByLibrary.simpleMessage(
          "Nor zaren esaten duen biografia"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("Zure izena profilean"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("Profileko argazkia"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "Ezer ez zure erregistroan azken {days} egunetan"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "Bidalita. Pertsona batek begiratuko du."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("{date}(e)tik."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("Eskatu"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Nor zaren, eta hori\nfrogatzen duen esteka"),
      "ui_verify_step_badge":
          MessageLookupByLibrary.simpleMessage("Bereizgarria"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "Zure izenaren ondoan,\nagertzen den toki orotan"),
      "ui_verify_step_check": MessageLookupByLibrary.simpleMessage(
          "Pertsona batek\negiaztatzen du"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "Taldeko norbaitek\nzure estekak irekitzen ditu"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("Egiaztapena"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "{number}. eskaera pertsona baten esku dago"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "{date}(e)an bidalia, {category} gisa. Erabakia hartzean jakinarazpen bat jasoko duzu."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("Erretiratu eskaera"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("Eskaera erretiratu da."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da grabazioa amaitu: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("Hamar minutu arte."),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("Entzuten…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron-ek mikrofonoa erabiltzeko baimena behar du grabatzeko. Gailuaren ezarpenetan eman dezakezu."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "Ezin izan da grabatzen hasi: {error}"),
    };

final messageLookup = MessageLookup();
