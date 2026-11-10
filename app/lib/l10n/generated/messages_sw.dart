import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sw';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Neno, kifungu au #lebo"),
      "about": MessageLookupByLibrary.simpleMessage("Kuhusu"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Ongeza jibu"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage("Ongeza lugha…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Kubali na uendelee"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Tayari una akaunti ya Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Maoni"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Watu tofauti, si mara za kufungua"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("Ushiriki"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Vipendwa"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna watazamaji"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Hakuna aliyefungua chapisho hili bado."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Imechapishwa"),
      "analytics_saves":
          MessageLookupByLibrary.simpleMessage("Vilivyohifadhiwa"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Watazamaji"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("WATAZAMAJI KWA SIKU"),
      "and": MessageLookupByLibrary.simpleMessage("na"),
      "answerNumber": (Object a0) => "Jibu ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("Lenzi ya AR"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage(
          "Ambatisha kumbukumbu ya programu"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Muda wa kwenda na kurudi"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("UTHIBITISHO WA TOKENI"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Kuanza tangazo sasa kungekuweka katika chumba ambacho hakuna mtu angeweza"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Anzisha jumuiya"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Ni ya nini? (si lazima)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("kuingia tena."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage(
              "kuingia tena kutoka orodha hii."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Ukiifunga,"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("jiunge kwanza"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("inakuja hivi karibuni"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Unachapisha kama wewe"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("chapisha katika jumuiya hii"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Sasa hivi"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Mada 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Kwa ajili yako"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("ina kitu."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("iko njiani sasa."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", si"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("ninasonga"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Zima sauti"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Washa sauti"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Kwa ajili yako"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Vichupo vyako"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Alama (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("WATAZAMAJI KWA SIKU"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("imeshindwa kupakia"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("chapisho hili"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("Una la kuongeza? (si lazima)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("chapisho hili"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Kutoka kwa akaunti"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Toka"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Akaunti yako"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Thibitisha nenosiri"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("si sasa"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Inapakia…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Inachapisha…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("saa 3 zilizopita"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Nakili kiungo cha hadithi"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Hadithi yako"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Akaunti yako, machapisho yako na unachogusa ili"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Ongeza mada"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("yake mwenyewe."),
      "authorBlocked": (Object a0) => "${a0} amezuiwa",
      "authorPostsHidden": (Object a0) => "Hutaona machapisho ya ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Zuia"),
      "blockAuthor": (Object a0) => "Umzuie ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Maelezo ya toleo yamenakiliwa"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Kwa kuendelea, unakubali"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Kwa kuendelea, unakubali Masharti yetu ya Huduma na Sera ya Faragha"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Kwa kujisajili, unakubali"),
      "cancel": MessageLookupByLibrary.simpleMessage("Ghairi"),
      "change": MessageLookupByLibrary.simpleMessage("Badilisha"),
      "changeEmail":
          MessageLookupByLibrary.simpleMessage("Badilisha barua pepe"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Thibitisha akaunti yako kupitia barua pepe."),
      "checkKyronReachable":
          MessageLookupByLibrary.simpleMessage("Angalia kama Kyron inafikika"),
      "clear": MessageLookupByLibrary.simpleMessage("Futa"),
      "close": MessageLookupByLibrary.simpleMessage("Funga"),
      "closeCommunity": (Object a0) => "Ufunge ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Ifunge"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Funga jumuiya hii"),
      "communities": MessageLookupByLibrary.simpleMessage("Jumuiya"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Tafuta moja kwenye Gundua, au anzisha yako."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Toa maoni motomoto (au vuguvugu)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Una nini akilini?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Sema kitu ambacho wewe pekee unaweza kusema…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "Hii ndiyo ishara yako: chapisha"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Andika, ongea au fikiri kwa sauti"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Thibitisha nenosiri"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Wasiliana na usaidizi"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Machapisho bado hayana lugha, kwa hivyo hili bado halichuji mlisho wako. Chaguo zako zinahifadhiwa hadi wakati huo."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Endelea"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Endelea kwa barua pepe"),
      "copy": MessageLookupByLibrary.simpleMessage("Nakili"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Nakili ripoti badala yake"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Imeshindwa kufungua kuingia kwa Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Imeshindwa kutoka: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kupiga picha."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Inaonyeshwa kwenye wasifu wako na chini ya machapisho yako."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Hakuna nchi inayolingana na “{query}”."),
      "country_none": MessageLookupByLibrary.simpleMessage("Usionyeshe nchi"),
      "country_search": MessageLookupByLibrary.simpleMessage("Tafuta nchi"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Inaonyeshwa kwenye wasifu wako na chini ya machapisho yako. Unapoona machapisho ya mtu, nchi yako huhesabiwa katika Maarifa yake, kwa makundi ya watu watano au zaidi tu na kamwe si kwa jina."),
      "country_suggested": MessageLookupByLibrary.simpleMessage(
          "Kutoka kwenye mipangilio ya simu yako"),
      "create": MessageLookupByLibrary.simpleMessage("Unda"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Fungua akaunti"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Fungua akaunti yako"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Unda wasifu wako"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("Lenzi ya AR"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Anza mubashara"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Chapisho la maandishi"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Chapisho la sauti"),
      "delete": MessageLookupByLibrary.simpleMessage("Futa"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Ufute maoni haya?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Ufute chapisho hili?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Eleza kiambatisho hiki"),
      "description": MessageLookupByLibrary.simpleMessage("Maelezo"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
          "DID imenakiliwa kwenye ubao wa kunakili"),
      "done": MessageLookupByLibrary.simpleMessage("Imekamilika"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Funga kihariri baada ya kuandika kitu na utapewa rasimu."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("siku {days} zilizopita"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("saa {hours} zilizopita"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Sasa hivi"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("dakika {minutes} zilizopita"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Bado hakuna kilichoandikwa"),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
          "Kura ya maoni, bado haina swali"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Nukuu, bado haina maandishi"),
      "drafts": MessageLookupByLibrary.simpleMessage("Rasimu"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Hariri wasifu"),
      "email": MessageLookupByLibrary.simpleMessage("Barua pepe"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Arifa za barua pepe"),
      "explore": MessageLookupByLibrary.simpleMessage("Gundua"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Ufuatiliaji wa uso haupatikani kwenye kifaa hiki."),
      "feedTagDetail": (Object a0) => "Bado hakuna kilichochapishwa na #${a0}.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Mfuate {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Wafuasi"),
      "following": MessageLookupByLibrary.simpleMessage("Unaowafuata"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Umesahau nenosiri?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Kupata usaidizi"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Endelea na Google"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("Ingia kwa Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google hurudisha kuingia kulikokamilika kwa Kyron kupitia kiungo ambacho Android na iOS pekee hukijibu, kwa hivyo kwenye ${a0} kivinjari hakina pa kukirudisha.\\n\\nIkiwa tayari una akaunti ya Kyron kupitia Google, chagua Endelea kwa barua pepe ukitumia anwani ileile, kisha gusa Umesahau nenosiri: utapata kiungo cha kuweka nenosiri.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Kuingia kwa Google kunahitaji programu ya simu"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Jisajili kwa Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Miongozo na majibu ya maswali ya kawaida"),
      "handle": MessageLookupByLibrary.simpleMessage("jina la mtumiaji"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Usaidizi na Msaada"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Kituo cha Usaidizi"),
      "home": MessageLookupByLibrary.simpleMessage("Mwanzo"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("Katika mstari mmoja"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Akaunti yako"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Fungua jumuiya"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Andika chapisho"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("Ona chapisho"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Hariri wasifu wako"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Wanapokuwepo"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Kwa saa za eneo lako."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Umri"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Kati ya watu {known} uliowafikia waliotoa siku ya kuzaliwa."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Watu uliowafikia kila siku"),
      "ins_communities": MessageLookupByLibrary.simpleMessage("Jumuiya walimo"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Nchi"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Kutoka kwa watu {known} waliofikiwa ambao wana nchi kwenye wasifu wao."),
      "ins_days":
          MessageLookupByLibrary.simpleMessage("Siku {days} zilizopita"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("Takwimu hazikuweza kupakiwa"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Wafuasi"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Bado hakuna kundi kubwa vya kutosha kuonyeshwa."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Jinsi ya kukua"),
      "ins_interests": MessageLookupByLibrary.simpleMessage("Mada wanazofuata"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Vipendwa"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Mpya"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Wafuasi wapya"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Hakuna chapisho lako lililomfikia mtu katika kipindi hiki."),
      "ins_non_followers": MessageLookupByLibrary.simpleMessage("Hawakufuati"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Nchi ni zile ambazo watu walichagua kwenye wasifu wao. Kyron haikusanyi jiji wala jinsia ya mtu yeyote, kwa hivyo hakuna cha kuonyesha kuhusu hayo."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Mafunguo"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "wamefikiwa {reach} · vipendwa {likes} · majibu {replies}"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Watu uliowafikia"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Kila mtu anahesabiwa mara moja: alionyeshwa au alifungua mojawapo ya machapisho yako kwa mara ya kwanza. Wafuasi wapya bado wanakufuata; walioacha kukufuata hawahesabiwi."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Majibu"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Machapisho upya"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Vilivyohifadhiwa"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Hadhira yako ni nani huonyeshwa watu {floor} wanapokuwa wameona machapisho yako katika kipindi hiki. Chini ya hapo, inaweza kumwonyesha mtu fulani."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Bado hakuna watu wa kutosha"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% yao tayari wanakufuata: machapisho yako mara nyingi huwafikia wanaokujua."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% yao bado hawakufuati: machapisho yako yanagunduliwa."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Uliwafikia watu {reach}, {pct}% chini ya kipindi kilichopita."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Uliwafikia watu {reach} katika siku {days} zilizopita."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Uliwafikia watu {reach}, takriban sawa na kipindi kilichopita."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Hakuna mtu mpya aliyeona machapisho yako katika siku {days} zilizopita."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Uliwafikia watu {reach}, {pct}% zaidi ya kipindi kilichopita."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Uliwafikia watu {reach}, mara {times}× ya kipindi kilichopita."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Wengi wao wanafuata {name} kuliko mada nyingine yoyote."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Hadhira"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Muhtasari"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Watu wanaopata chapisho lako hutazama wasifu wako kabla ya kukufuata. Uso au nembo huwaambia kuna mtu pale."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Ongeza picha ya wasifu"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Sema kwa mstari mmoja unachapisha kuhusu nini, ili mgeni ajue atapata nini kwa kukufuata."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Andika maelezo mafupi"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} kati ya machapisho yako {total} hayakuwa na mada. Mada huweka chapisho kwenye mlisho wa mada hiyo na mbele ya wanaoifuata."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Ongeza mada kwenye machapisho"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "Watu {received} walijibu machapisho yako na ulijibu {answered}. Walijali vya kutosha kuandika: jibu humgeuza msomaji kuwa mgeni wa kawaida."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Jibu majibu yako"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Hadhira yako huwa hai zaidi {when}. Chapisho lililowekwa kabla kidogo lina watu wa kulipokea."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Chapisha wanapokuwepo"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "Watu {reached} wasiokufuata waliona machapisho yako, na {gained} walikufuata. Acha maelezo yako mafupi na machapisho yako mapya yaseme wanachoweza kutarajia kutoka kwako."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("Geuza wasomaji kuwa wafuasi"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Chapisho moja liliwafikia watu mara {times}× ya wanaofikiwa kwa kawaida na mengine yako. Angalia lilifanya nini tofauti, na ufanye hivyo zaidi."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Fanya zaidi kilichofanikiwa"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Wengi wanaoona machapisho yako wako katika {name}. Kuchapisha huko kunakuweka mbele ya wengine."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Chapisha katika {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Ulichapisha mara {posts} katika siku {days}. Kila chapisho ni nafasi nyingine ya kupatikana, na mdundo thabiti hukuweka kwenye milisho ya wafuasi wako."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Chapisha mara nyingi zaidi"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Hujachapisha katika siku {days} zilizopita. Hakuna kinachomfikia mtu bila chapisho."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Chapisha kitu"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Takwimu"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Machapisho bora"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Ukilinganisha na siku {days} zilizotangulia"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Ongeza jambo linalokuvutia"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Buruta ili upange upya"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Upau unatosha vichupo vitano pekee. Ondoa kimoja ili uongeze kingine."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Unaowafuata"),
      "interest_for_you":
          MessageLookupByLibrary.simpleMessage("Kwa ajili yako"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Alama za reli zitaonekana hapa watu wanapoanza kuzitumia."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Inayovuma sasa"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Video"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Vichupo vyako"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Itatoweka kwenu nyote wawili."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Itaondolewa kwenye mfululizo."),
      "join": MessageLookupByLibrary.simpleMessage("Jiunge"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Endelea kuhariri"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Skrini za Kyron ziko katika lugha yako. Neno likisomeka vibaya, tuambie kupitia Tuma maoni."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Lugha"),
      "leave": MessageLookupByLibrary.simpleMessage("Ondoka"),
      "leaveCommunity": (Object a0) => "Uondoke ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Mruhusu arudi"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("Ukurasa 1 umefunguliwa"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Ongeza klipu"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Ongeza GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Ongeza alama ya reli"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Ongeza picha"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Ongeza kura ya maoni"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Ongeza video"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Ongeza jambo linalokuvutia"),
      "literaladdLabelAsATab": (Object a0) => "Ongeza ${a0} kama kichupo",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Lugha ya programu"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Toleo la programu"),
      "literalblockAuthor": (Object a0) => "Zuia ${a0}",
      "literalblockAuthor2": (Object a0) => "Uzuie ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Uzuie akaunti hii?"),
      "literalcancelReply": MessageLookupByLibrary.simpleMessage("Tupa jibu"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("Kagua tena"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Chagua kutoka matunzio"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Futa akiba"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Funga kurasa zote"),
      "literalcloseTabLabel": (Object a0) => "Funga ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Funga kivinjari"),
      "literalcloseWidgetCommunityName": (Object a0) => "Ufunge ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Wasiliana na usaidizi"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Lugha za maudhui"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Nakili kiungo"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Nakili kiungo cha chapisho"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Nakili maandishi ya chapisho"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("Nakili maandishi"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kupakia jumuiya"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kupakia GIF"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kupakia arifa"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kupakia wanachama"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia machapisho haya"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Imeshindwa kupakia mazungumzo haya"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kupakia orodha hii"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia chapisho hili"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kupakia jibu hili"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia lebo maarufu"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Imeshindwa kupakia jumuiya zako"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia ujumbe wako"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kufungua jumuiya hii"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kuchapisha jibu."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Utafutaji haukufanikiwa"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Imeshindwa kutoka: ${a0}",
      "literalcountPagesOpen": (Object a0) => "Kurasa ${a0} zimefunguliwa",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Picha ya jalada"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("Kiokoa data"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Futa chapisho"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Tafuta watu"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Usijibu"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Rasimu imehifadhiwa"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Maoni hayawezi kutumwa sasa hivi"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Ukubwa wa maandishi"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF hazijawekwa"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Ipe programu nyingine"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Ficha nenosiri"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Ficha chapisho hili"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Huificha na kutuomba tuonyeshe machache kama hii"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Jinsi ya kuenenda"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Endelea kuandika"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron haikujibu"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "Tarehe ya \\${a0}",
      "literalleaveCommunityName": (Object a0) => "Uondoke ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, lenzi ya uso",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Machapisho uliyopenda"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Kiungo kimenakiliwa"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Mfanye msimamizi"),
      "literalmuteAuthor": (Object a0) => "Nyamazisha ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Nyamazisha mfululizo huu"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Nyamazisha maneno au lebo"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Akaunti zilizonyamazishwa na zilizozuiwa"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Imenyamazishwa. Hutapokea arifa."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Hakuna programu kwenye kifaa hiki inayofungua viungo vya ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Hakuna kivinjari kwenye kifaa hiki kilichokubali kiungo."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna DID"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Hakuna rasimu"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
          "Bado hakuna mambo yanayokuvutia"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna vipendwa"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna ujumbe"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Hakuna wafuasi wapya"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna machapisho"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna majibu"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna machapisho upya"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Hakuna lebo maarufu inayolingana"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Hakuna aliyepatikana"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Hakuna aliyeondolewa"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna mtu hapa"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Sivutiwi"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Hakuna kilichopatikana"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna kinachovuma"),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
          "Bado hakuna kitu kwenye kumbukumbu"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Hakuna yanayolingana"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Hakuna aliyenyamazishwa"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna cha kutazama"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Hakuna ambao haujasomwa"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Mmiliki pekee ndiye anayeweza kubadilisha hili"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Fungua jibu"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
          "Fungua barua pepe kutoka Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Nenosiri na kuingia"),
      "literalpostInCommunityName": (Object a0) => "Chapisha kwenye ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "Chapisha kwenye ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Ichapishe na maneno yako juu yake"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Lugha kuu"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Arifa za papo hapo"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Inakagua…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Rekodi chapisho la sauti"),
      "literalrecordAgain": MessageLookupByLibrary.simpleMessage("Rekodi tena"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Ondoa kama msimamizi"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Ondoa kwenye jumuiya"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Ondoa kwenye vilivyohifadhiwa"),
      "literalremoveLabel": (Object a0) => "Ondoa ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Ondoa ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Umwondoe ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Ondoa kura ya maoni"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Ondoa jibu hili"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Futa mazungumzo haya"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Ondoa kura hii ya maoni"),
      "literalreportAuthor": (Object a0) => "Ripoti ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Ripoti chapisho"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Tuma msimbo tena"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Machapisho yaliyohifadhiwa"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("Sema kitu"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Sema kitu kwenye ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Utafutaji umeshindwa"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Tuma tena"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "Tuma tena baada ya sekunde ${a0}",
      "literalsendFeedback": MessageLookupByLibrary.simpleMessage("Toa maoni"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("Tuma kiungo"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Imetumwa. Hiyo ni ripoti #${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Weka nenosiri na uendelee"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Shiriki kumbukumbu na usaidizi"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Shiriki jumuiya hii"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Shiriki ukurasa huu"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Shiriki wasifu huu"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Shiriki…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Shiriki pamoja na nukuu"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Onyesha zaidi kama hii"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Onyesha nenosiri"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Onyesha matokeo"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Anzisha jumuiya"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Anza kurekodi"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Acha kupakia"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Acha kuona chapisho hili na majibu yake"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Utepe wa hadithi, vipengee ${a0}",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Badilisha kamera"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Mtambulishe mtu"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("Piga picha"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Gusa bango au picha ili ubadilishe"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Gusa kiungo kilichomo"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Gusa ili uongeze picha na jalada"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("Haikufanikiwa. Jaribu tena."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("Imeshindwa kupakia GIF hiyo."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Kiungo hiki hakiwezi kufunguliwa hapa."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Kamera imefungwa"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Jumuiya hii"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Jibu hili halipo tena"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Tafsiri chapisho"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("Zima sauti"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("Washa sauti"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Tumia mojawapo ya zetu"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Msimbo wa uthibitishaji umetumwa tena."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Uthibitishaji umeshindwa: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Thibitisha barua pepe"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Watazamaji, vipendwa, vilivyohifadhiwa na maoni"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kile Kyron huhifadhi"),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
          "Programu hii imekuwa ikifanya nini"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Ulichofanya, ulichotarajia, kilichotokea "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Unachochapisha ni chako"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Kama Kyron inafikika sasa hivi"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Nani anaweza kujibu"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Unataka kumtambulisha nani?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Tayari unafuata lebo zote maarufu"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Umeona yote"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("Huko katika jumuiya yoyote"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Umetoka."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Umeondoka ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Bado hujachapisha chochote"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Pakia zaidi"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Kumbukumbu imefutwa"),
      "logCopied":
          MessageLookupByLibrary.simpleMessage("Kumbukumbu imenakiliwa"),
      "logIn": MessageLookupByLibrary.simpleMessage("Ingia"),
      "logOut": MessageLookupByLibrary.simpleMessage("Toka"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Utoke?"),
      "login": MessageLookupByLibrary.simpleMessage("Kuingia"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kuingia. Kagua kitambulisho chako."),
      "manage": MessageLookupByLibrary.simpleMessage("Dhibiti"),
      "menu": MessageLookupByLibrary.simpleMessage("Menyu"),
      "message": MessageLookupByLibrary.simpleMessage("Ujumbe"),
      "messages": MessageLookupByLibrary.simpleMessage("Ujumbe"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("Umesoma mazungumzo yote."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Fungua wasifu wa mtu na ugusa Ujumbe ili kuanza mazungumzo."),
      "mute": MessageLookupByLibrary.simpleMessage("Nyamazisha"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
          "Walionyamazishwa na waliozuiwa"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
          "Maneno na lebo zilizonyamazishwa"),
      "name": MessageLookupByLibrary.simpleMessage("Jina"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Skrini ya <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Anwani mpya ya barua pepe"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Nenosiri jipya"),
      "newPost": MessageLookupByLibrary.simpleMessage("Chapisho jipya"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Si sasa"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Haijatumwa. Gusa ili ujaribu tena"),
      "nothingMatchesQuery": (Object a0) =>
          "Hakuna kwenye Kyron kinacholingana na \"${a0}\"",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Hakuna cha kunakili"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Vipendwa, majibu na wafuasi wapya huja hapa."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Watu wanaokufuata wataonekana hapa."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Mtu akipenda chapisho lako, itaonekana hapa."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Majibu kwa machapisho yako huja hapa."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Mtu akikuchapisha upya, itaonekana hapa."),
      "notifications": MessageLookupByLibrary.simpleMessage("Arifa"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Fungua kwenye kivinjari"),
      "or": MessageLookupByLibrary.simpleMessage("au"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Ukurasa haukupatikana"),
      "password": MessageLookupByLibrary.simpleMessage("Nenosiri"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Nenosiri ni fupi mno"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Chagua mambo yanayokuvutia"),
      "post": MessageLookupByLibrary.simpleMessage("Chapisha"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Takwimu za chapisho"),
      "postInCommunity": (Object a0) => "Chapisha kwenye ${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Chapisha, sema, onyesha."),
      "postTextCopied": MessageLookupByLibrary.simpleMessage(
          "Maandishi ya chapisho yamenakiliwa"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("Sera ya Faragha"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Wasifu umesasishwa"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Wasifu"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Nchi"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Jina la kuonyesha"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Mahali"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Gusa ili ubadilishe"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Tovuti"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Arifa za papo hapo"),
      "quote": MessageLookupByLibrary.simpleMessage("Nukuu"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Nukuu chapisho"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Wasiliana na mtu"),
      "remove": MessageLookupByLibrary.simpleMessage("Ondoa"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Ufute mazungumzo haya?"),
      "removeMember": (Object a0) => "Umwondoe ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Ufute ujumbe huu?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("Majibu, wafuasi na kutajwa"),
      "repliesPolicy": (Object a0) => "Majibu: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Jibu"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Mtu yeyote anaweza kushiriki"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Mtu yeyote bado anaweza kuona, kuchapisha upya na kunukuu chapisho hili."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Mtu yeyote kwenye Kyron anaweza kujibu chapisho hili."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Watu wanaokufuata"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Ni wanaokufuata pekee wanaoweza kujibu chapisho hili."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Watu unaowataja"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Ni watu unaowataja kwa @ katika chapisho hili pekee wanaoweza kujibu."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Hakuna anayeweza kujibu"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Majibu yamezimwa. Bado unaweza kujibu mwenyewe."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Nani anaweza kujibu?"),
      "report": MessageLookupByLibrary.simpleMessage("Ripoti"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Ripoti imenakiliwa. Ibandike kwenye barua pepe kwa timu ya usaidizi."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Ripoti imetumwa"),
      "repost": MessageLookupByLibrary.simpleMessage("Chapisha upya"),
      "reset": MessageLookupByLibrary.simpleMessage("Weka upya"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Weka upya nenosiri lako"),
      "retry": MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "save": MessageLookupByLibrary.simpleMessage("Hifadhi"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Hifadhi rasimu"),
      "saySomething": (Object a0) => "Sema kitu kwenye ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Tafuta"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Tafuta kwa jina au jina la mtumiaji"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Tafuta jumuiya"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Tafuta GIF"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Tafuta lugha"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Tafuta lebo maarufu"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Tahadhari za usalama na mabadiliko ya akaunti"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Chagua lugha ya kiolesura cha programu."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Chagua lugha zinazoonekana kwenye milisho yako. Usipochagua yoyote, lugha zote zitaonyeshwa."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Chagua lugha yako kuu kwa tafsiri kwenye mlisho."),
      "send": MessageLookupByLibrary.simpleMessage("Tuma"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Tuma uthibitisho"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Tuma ripoti ya hitilafu"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Tuma maoni"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Tuma ripoti"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Tuma kwa usaidizi"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Hali ya huduma"),
      "settings": MessageLookupByLibrary.simpleMessage("Mipangilio"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Shiriki kumbukumbu ya programu na usaidizi"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Ingia kwenye Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Umeingia kama"),
      "signupFailed": (Object a0) => "Imeshindwa kujisajili: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Baki"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron ni changa, na njia ya haraka zaidi ya kumfikia mtu anayeweza kurekebisha tatizo ni kufungua tiketi. Tuambie ulichokuwa ukifanya na kilichotokea."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Programu bado haina kikasha cha usaidizi, kwa hivyo skrini hii inakuelekeza mahali panapofuatiliwa kweli badala ya fomu isiyofika popote."),
      "systemLog":
          MessageLookupByLibrary.simpleMessage("Kumbukumbu ya programu"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Tuambie kinachokosekana au kilichoharibika"),
      "terms": MessageLookupByLibrary.simpleMessage("Masharti ya Huduma"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Maandishi, sauti na video, watu wanaovitengeneza na vyumba wanavyozungumzia."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "Hakuna kitufe cha Chapisha kwenye kihariri"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Giza"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Giza kila wakati"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Hafifu"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Giza laini zaidi, kijivu cha samawati badala ya nyeusi"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Angavu"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Angavu kila wakati"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Mfumo"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Fuata mpangilio wa angavu au giza wa simu yako"),
      "translate": MessageLookupByLibrary.simpleMessage("Tafsiri"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Tafsiri bado haijawashwa. Bado hakuna kinachotafsiriwa kwenye mlisho wako; hili litakumbukwa hadi wakati huo."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Hii hubadilisha maneno ya Kyron yenyewe, sehemu za kiolesura ambazo Flutter huchora yenyewe, tarehe na nambari, na mwelekeo wa mpangilio wa programu kwa lugha zinazoandikwa kutoka kulia kwenda kushoto."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Sera ya Faragha"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Masharti ya Huduma"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Akaunti"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Baada ya"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Programu na Kifaa"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Nilinukuu utapeli huo ili kuwaonya watu."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Eleza kwa nini unadhani uamuzi ulikuwa si sahihi: chapisho lilimaanisha nini, timu huenda ilikosa nini, au kwa nini sheria haifai. Anayeisoma ni mtu mwingine, si aliyefanya uamuzi."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Rufaa yako"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Andika angalau herufi \$count. Unaweza kukata rufaa kwa kila uamuzi mara moja."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Tuma rufaa"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Rufaa imetumwa. Utapokea arifa uamuzi utakapofanywa."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Rufaa ya kesi \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Mwonekano"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Angavu, giza, au fuata simu yako"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Kabla ya"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Hamtaonana kwenye Kyron, na ufuatiliaji kati yenu utaondolewa. Hataambiwa."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Ina"),
      "ui_cchat_about": MessageLookupByLibrary.simpleMessage(
          "Ni kwa ajili ya nini (si lazima)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Wasimamizi pekee wanaweza kuandika"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Kwa matangazo. Kila mtu katika jumuiya bado anaweza kusoma na kujibu kwa hisia."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Ongeza picha au kura"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Picha na video"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Funga gumzo"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Hakuna atakayeweza kusoma wala kuandika ndani yake. Hili haliwezi kutenduliwa."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Ufunge gumzo hili?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Imenakiliwa"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Ujumbe unaondolewa kwa kila mtu. Kyron huhifadhi nakala kwa ajili ya ukaguzi."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Ujumbe unaondolewa kwa kila mtu kwenye gumzo."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Hariri gumzo"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Hariri"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("imehaririwa"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Unahariri ujumbe wako"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Imeshindikana kufungua gumzo hili."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Gumzo"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("Jiunge na gumzo"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Jiunge na jumuiya ili uone na ushiriki katika magumzo yake."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count wamejiunga"),
      "ui_cchat_leave":
          MessageLookupByLibrary.simpleMessage("Ondoka kwenye gumzo"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Bado unaweza kulisoma ukiwa ndani ya jumuiya."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Mmiliki na wasimamizi pekee wanaweza kuandika hapa."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Nyamazisha"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Hakuna arifa kutoka kwake, na halihesabiwi kwenye Ujumbe."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Jina la gumzo"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Gumzo jipya"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Bado hakuna magumzo."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Bado hakuna magumzo. Fungua moja kwa ajili ya jumuiya."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Magumzo ya jumuiya hayajasimbwa kutoka mwanzo hadi mwisho. Wasimamizi wa jumuiya na Kyron wanaweza kuyasoma."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Bandika juu"),
      "ui_cchat_poll_add": MessageLookupByLibrary.simpleMessage("Ongeza jibu"),
      "ui_cchat_poll_close": MessageLookupByLibrary.simpleMessage("Funga kura"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Imefungwa"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Kila mtu huona wangapi walichagua kila jibu, kamwe si nani."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Ruhusu kuchagua kadhaa"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Kura mpya"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Chagua moja"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("Jibu \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Kura: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Swali"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Kila jibu linaweza kuwa kwenye kura mara moja tu."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Chagua moja au zaidi"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count wamejibu"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Tafuta kwenye gumzo hili"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Tafuta kwenye gumzo hili"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Hakuna kilichopatikana."),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("Huwezi tena kuona gumzo hili."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Hali ya polepole"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Muda wa kusubiri kati ya jumbe. Haiwahusu wasimamizi."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("Saa 1"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Dakika \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Hali ya polepole: ujumbe mmoja kila sekunde \$seconds"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Imezimwa"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Sekunde \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Unaweza kusoma na kujibu kwa hisia kama mtazamaji. Jiunge ili uandike."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Ujumbe huo ni wa zamani mno kuonyeshwa."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Kitu ulichochagua ni kikubwa mno kutumwa na kimeachwa."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("Rejesha sauti"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Bandua"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Rekodi ujumbe wa sauti"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Wewe"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Jumuiya"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Ni ya nini? (si lazima)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Machapisho:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Maudhui na Onyesho"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia mlisho wako"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia machapisho uliyopenda"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia wasifu wako"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia machapisho yako yaliyohifadhiwa"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Kitambulisho kilichogatuliwa"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Utatuzi"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Vikundi"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("Hakuna vikundi"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Vikundi ulivyomo, na gumzo za jumuiya unazojiunga nazo, vinaonyeshwa hapa."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Unaweza kubandika hadi soga \$count. Bandua moja kwanza."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Imebandikwa"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Zilizopendwa"),
      "ui_drawer_saved":
          MessageLookupByLibrary.simpleMessage("Zilizohifadhiwa"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Bado hakuna kitu hapa"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Fuata akaunti chache na machapisho yao yataonekana hapa."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Hakuna kutoka kwa unaowafuata"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Machapisho yataonekana hapa watu wanapoyaandika."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Inafifia"),
      "ui_feed_signal_less": MessageLookupByLibrary.simpleMessage("Sivutiwi"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Onyesha zaidi kama hili"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Imeondolewa"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Ishara za mlisho wako"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Gusa Onyesha machapisho zaidi kama haya au Sivutiwi na hili kwenye chapisho, na litaonekana hapa."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Bado hakuna kitu hapa"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Kile Onyesha zaidi na Sivutiwi vinaambia milisho yako"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Hizi huunda Nyumbani na Gundua, hasa kwa mada ya kila chapisho. Kila moja hufifia nusu kila mwezi na huacha kuhesabiwa baada ya miezi sita. Ondoa moja ili kuisimamisha sasa."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Machapisho yenye klipu yataonekana hapa."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Bado hakuna video"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Maoni"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Tafuta watu kwenye Kyron"),
      "ui_from_account":
          MessageLookupByLibrary.simpleMessage("Kutoka kwa akaunti"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Ongeza watu"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Ongeza"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Ongeza jina la kikundi"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Kataa"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Ujumbe katika kikundi hiki umesimbwa kutoka mwanzo hadi mwisho, kama mazungumzo mengine yoyote."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor amewaongeza \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor amemfanya \$users msimamizi"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor ameunda kikundi"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor ameweka watu wapya wajiunge kama wanachama"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor ameweka watu wapya wajiunge kama watazamaji"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor ameondoka"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor amemfanya \$users mwanachama"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor amemfanya \$users mmiliki"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor amemwondoa \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor amebadilisha jina la kikundi kuwa \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor amemfanya \$users mtazamaji"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Kikundi kinaweza kuwa na watu \$count zaidi."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Mkono umeinuliwa. Wasimamizi wamearifiwa."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count wanaomba kuandika"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Wanaomba kuandika"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Watakaoongezwa baadaye watajiunga kama watazamaji"),
      "ui_group_leave":
          MessageLookupByLibrary.simpleMessage("Ondoka kwenye kikundi"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Kitaondoka kwenye orodha yako na hutaona kinachosemwa baadaye. Mtu atahitaji kukuongeza tena."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Uondoke kwenye kikundi hiki?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Ruhusu kuandika"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Shusha mkono"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Fanya msimamizi"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Fanya mmiliki"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Fanya mtazamaji"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Wanachama \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Wanachama"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Jina la kikundi"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Kwanza lipe kikundi jina."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Unda gumzo la kikundi"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Kuna mmiliki mmoja. Utabaki kuwa msimamizi."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Umfanye \$name mmiliki?"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("Inua mkono"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Ondoa kwenye kikundi"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Ondoa kama msimamizi"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Huko tena kwenye kikundi hiki."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Badilisha jina"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Msimamizi"),
      "ui_group_role_member":
          MessageLookupByLibrary.simpleMessage("Mwanachama"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Mtazamaji"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Kama mtazamaji, unaweza kusoma na kutoa hisia hapa."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Watazamaji wanaweza kusoma, kutoa hisia na kuinua mkono kuomba kuandika."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Mapendekezo"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Tazama wasifu"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("wewe"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Wewe ni mtazamaji"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Usaidizi"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Imebainishwa. Hii husaidia kuchagua tunachokuonyesha."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Jiunge"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Alijiunga"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Lugha"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Chagua lugha yako"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Kisheria"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Penda"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Machapisho uliyopenda"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Machapisho unayopenda yanaonekana hapa, mapya kwanza."),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Kiungo kimenakiliwa"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Hutaona tena machapisho yake. Hataambiwa."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna vipendwa"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Hakuna machapisho yanayolingana na vichujio hivyo."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Bado hakuna vilivyohifadhiwa"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Akaunti yako imesasishwa"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Rufaa yako kwenye kesi \$number imekubaliwa"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Tumeiangalia tena rufaa yako kwenye kesi \$number, na uamuzi unabaki"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Akaunti yako imepigwa marufuku kabisa"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Kesi \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("amekufuata"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("amependa chapisho lako"),
      "ui_notif_mentioned": MessageLookupByLibrary.simpleMessage("amekutaja"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Bado hujatajwa"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Mtu anapoandika @jina lako kwenye chapisho au jibu, litaonekana hapa."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Za zamani"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Ujumbe wako kwenye gumzo la jumuiya umeondolewa"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Kitu ulichochapisha kimeondolewa"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Chapisho lako limeondolewa"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Jibu lako limeondolewa"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("amejibu chapisho lako"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Tumechukua hatua kuhusu kitu ulichoripoti. Asante kwa kutuambia."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Tumeangalia kitu ulichoripoti na hatukuona kwamba kilivunja sheria zetu."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Kimeripotiwa kwa: \$reason"),
      "ui_notif_reposted": MessageLookupByLibrary.simpleMessage(
          "amechapisha upya chapisho lako"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Tumebatilisha uamuzi wa kesi \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Akaunti yako imesimamishwa"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Akaunti yako imesimamishwa hadi \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Zote"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Wanaofuata"),
      "ui_notif_tab_likes":
          MessageLookupByLibrary.simpleMessage("Zilizopendwa"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("Kutajwa"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Majibu"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Wiki hii"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Leo"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Akaunti yako ina onyo"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Jana"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Imekamilika"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Ruka"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Hiki kimeshafunguliwa."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Muda umekwisha"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Haikuweza kufunguliwa."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Hufunguka mara moja, kisha hufutwa kwenye Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Tazama mara moja"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Imefunguliwa"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "Imefunguliwa na \$count kati ya \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Ni watu uliowatumia tu wanaoweza kukifungua, mara moja."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Tuma kutazamwa mara moja"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Gusa ili kutazama"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Sitisha"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Cheza"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Litaondolewa kwenye wasifu wako na kwenye milisho ya kila mtu. Majibu yake yanaondoka pamoja nalo."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Chapisho limefutwa"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Chapisho limefichwa"),
      "ui_post_text_copied": MessageLookupByLibrary.simpleMessage(
          "Maandishi ya chapisho yamenakiliwa"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Imechapishwa kati ya"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Imefichwa. Tutaonyesha machache kama hii."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Mapendeleo"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Faragha"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Una chochote cha kuongeza? (si lazima)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Utapata arifa timu itakapoamua, na unaweza kufuatilia katika Ripoti zako."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Ikiwa pia hutaki kumwona mtu huyu tena, unaweza kumnyamazisha au kumzuia kwenye menyu hiyo hiyo."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Kuripoti kitu kimoja mara mbili hakukipi uzito zaidi: tunahifadhi ripoti moja kwa kila mtu."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Ripoti yako haishirikiwi na mtu huyo. Tunahifadhi nakala ya ulichoripoti ili kiweze kukaguliwa hata kikifutwa."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Ripoti yako imepokelewa na inasubiri kukaguliwa. Hatumwambii mtu huyo nani aliyeripoti."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Tazama ripoti zako"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Tuambie kuna tatizo gani"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Asante kwa kutuambia"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("\$name ana tatizo gani?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("Ujumbe huu una tatizo gani?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Chapisho hili lina tatizo gani?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("Jibu hili lina tatizo gani?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Ujumbe wa gumzo la jumuiya"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Chapisho"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Jibu"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Hatua imechukuliwa"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Akaunti"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Imeamuliwa \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Hakuna sheria iliyovunjwa"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Ripoti zako hazikuweza kupakiwa"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Ulichoripoti katika siku 90 zilizopita, na matokeo yake. Unapata arifa timu inapoamua. Unayemripoti hataambiwa kamwe ni nani aliyemripoti."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Hakuna ulichoripoti"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Unaporipoti chapisho, jibu, ujumbe au akaunti, kinaonyeshwa hapa pamoja na matokeo yake."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("Inakaguliwa"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Kiliripotiwa \$date"),
      "ui_reports_settings_help":
          MessageLookupByLibrary.simpleMessage("Ulichoripoti, na matokeo yake"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Ripoti zako"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Usalama wa watoto"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Chochote kinachomhatarisha mtoto au kumtumia kingono."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Unyanyasaji unaomlenga mtu, vitisho au mawasiliano yasiyotakiwa."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Mashambulizi dhidi ya watu kwa sababu ya utambulisho wao."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Kuuza au kutangaza kitu kisicho halali."),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("Kujifanya kuwa mtu mwingine."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Inatumia kazi yako au chapa yako ya biashara bila ruhusa."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Madai ya kupotosha kuhusu afya, uchaguzi au matukio."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Kuhimiza au kuonyesha kujidhuru."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Maudhui ya ngono yanayoonyeshwa bila onyo."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Hakuna kati ya hivi. Tuambie kuna tatizo gani."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Matangazo yanayojirudia, ya kupotosha au yasiyotakiwa."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Kutishia, kusifu au kuchochea vurugu."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Unyanyasaji au uonevu"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Matamshi ya chuki"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Bidhaa au huduma haramu"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Kujifanya mtu mwingine"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Mali miliki"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Taarifa za uongo"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Kujiua au kujidhuru"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Maudhui ya watu wazima"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Kitu kingine"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Barua taka"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Vurugu au vitisho"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Machapisho yaliyohifadhiwa"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Gusa aikoni ya kumbukumbu ya chapisho ili ulihifadhi hapa. Ni wewe pekee unayeona ulivyohifadhi."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Tafuta kwa jina la mtumiaji au jina la kuonyesha."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Futa"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Tafuta kila kilichochapishwa"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Vichujio"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Tafuta watu"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Tafuta machapisho"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Mipangilio"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Programu na Kifaa"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Maudhui na Onyesho"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Kiokoa data"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Shiriki mawazo yako"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Vinjari makala za usaidizi"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Chagua lugha yako"),
      "ui_settings_muted_blocked":
          MessageLookupByLibrary.simpleMessage("Uliowanyamazisha au kuwazuia"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Mapendeleo ya arifa"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Wasifu wako na maelezo ya mawasiliano"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Utahitaji kuingia tena ili urudi kwenye akaunti yako."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Mipangilio ya usalama"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Thibitisha nenosiri"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("Katika mstari mmoja"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Anwani mpya ya barua pepe"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Nenosiri jipya"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Kilichotokea"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "Pata usaidizi kutoka kwa timu yetu"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Shiriki"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Nukuu"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Tuma kwa ujumbe"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kwa watu walio Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Shiriki chapisho hili"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Lilihusu nini"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Akaunti yako imepigwa marufuku kabisa"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Jibu, tarehe \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Rufaa"),
      "ui_standing_appeal_button": MessageLookupByLibrary.simpleMessage(
          "Kata rufaa dhidi ya uamuzi huu"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Uamuzi huu hauwezi tena kukatiwa rufaa. Ikiwa kuna tatizo, wasiliana na usaidizi."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Rufaa inakaguliwa"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Rufaa imekubaliwa"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Mtu mwingine kwenye timu analikagua tena. Utapokea arifa uamuzi utakapofanywa."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Ikiwa unadhani ni kosa, unaweza kuomba likaguliwe tena hadi \$date. Mtu mwingine kwenye timu ndiye anayeamua."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Rufaa imekatwa: uamuzi unabaki"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Kesi \$number. Sheria: \$rule. Timu iliandika:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Kufuta akaunti yako hakuondoi marufuku: akaunti mpya yenye anwani ile ile ya barua pepe nayo huanza ikiwa imepigwa marufuku."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Imepigwa marufuku"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Ni ukurasa huu tu, rufaa, usaidizi na kufuta akaunti yako ndivyo bado vinafanya kazi."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Inaweza kukatiwa rufaa"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Kesi \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Iliamuliwa \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Maamuzi kuhusu akaunti yako"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Futa akaunti yako"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Angalia maelezo"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "Angalia maelezo na ukate rufaa"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Inaisha \$date"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "Akaunti yako iko katika hali nzuri"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Hakuna kinachoizuia."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Hali ya akaunti haikuweza kupakiwa"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Ujumbe umeondolewa"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Hakuna kilichoamuliwa kuhusu akaunti yako. Timu ikiwahi kuondoa kitu chako au kuzuia akaunti yako, kitaonyeshwa hapa pamoja na sababu, na unaweza kukata rufaa."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Hakuna cha kukatia rufaa: uamuzi umebatilishwa."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Chapisho limeondolewa"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Vuta chini ili kuangalia tena."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Soma sheria za Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Jibu limeondolewa"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("Umebatilishwa"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Ulibatilishwa \$date. Kila kilichoondolewa kimerudishwa, na hakuna kizuizi kinachotumika tena."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Sheria: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Toka"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Imesimamishwa"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Unaweza kusoma, lakini huwezi kuchapisha, kujibu, kufuata au kutuma ujumbe. Kuripoti, kuzuia na kunyamazisha bado vinafanya kazi."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Akaunti yako imesimamishwa: unaweza kusoma, lakini huwezi kuchapisha."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Imesimamishwa hadi \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Akaunti yako imesimamishwa hadi \$date: unaweza kusoma, lakini huwezi kuchapisha."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Timu iliandika nini"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Hali ya akaunti"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Onyo"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Kwa nini?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Uliandika, tarehe \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Ujumbe wako"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Chapisho lako"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Jibu lako"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Masharti ya Huduma"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("chapisho hili"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Mfululizo umenyamazishwa"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("Zima sauti"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Washa sauti"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Angalau herufi mbili."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Tendua"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Maneno, au kichujio: akaunti, kipindi cha tarehe, au kilichomo kwenye chapisho."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Tendua uchapishaji upya"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Sasisha nenosiri"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Tumia anwani nyingine"),
      "username": MessageLookupByLibrary.simpleMessage("Jina la mtumiaji"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Jina la mtumiaji lazima liwe kwa herufi ndogo (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Ambatisha"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Tayari kuambatishwa"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Rekodi chapisho la sauti"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Inahifadhi…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Simamisha"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Kilichotokea"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Nini kilitokea, na tuangalie nini?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Kuna nini kwenye picha hii?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Ni ya nini? (si lazima)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Ulichofanya, ulichotarajia, kilichotokea"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Ulichokuwa ukifanya kilipotokea."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Ulijibu"),
      "dmReplied": (Object a0) => "$a0 alijibu",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Ongeza kwenye ujumbe"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Ujumbe mpya"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Hakuna kilichosemwa bado. Kupunga mkono ni mwanzo mzuri."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Punga mkono"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("Jumbe mpya"),
      "dmTyping": (Object a0) => "$a0 anaandika",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Ondoa itikio lako"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Mtu"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Ujumbe"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Kiambatisho"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Ujumbe huu hauwezi kusomwa kwenye kifaa hiki."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Inasubiri ujumbe huu. Huenda ikachukua muda."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Ujumbe uliosimbwa"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Ujumbe umesimbwa kwa njia fiche kutoka mwanzo hadi mwisho"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Haujasimbwa kwa njia fiche kutoka mwanzo hadi mwisho"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Umetumwa"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Umeonekana"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Inatuma…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Piga picha"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Chaguo zaidi"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Hifadhi kwenye kifaa"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Shiriki"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Inahifadhi…"),
      "ui_media_saved": MessageLookupByLibrary.simpleMessage(
          "Imehifadhiwa kwenye picha zako"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kuhifadhi. Jaribu tena."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Ruhusu Kyron iongeze kwenye picha zako ili kuhifadhi hii."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Mifumo yote inafanya kazi"),
      "ui_status_uptime":
          MessageLookupByLibrary.simpleMessage("Muda wa kufanya kazi"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Siku 60 zilizopita"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Siku 60 zilizopita"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Leo"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Hifadhidata"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Kuingia"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Matukio ya hivi karibuni"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Hakuna matukio katika siku 60 zilizopita."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Inaendelea"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Hakuna data"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Maelezo"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron hujikagua kila dakika 5 inapofanya kazi. Siku ya kijivu haikuwa na ukaguzi."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Historia ya muda wa kufanya kazi bado haipatikani."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Baadhi ya mifumo ina matatizo"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Rekodi ujumbe wa sauti"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Tayari kutumwa"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Ujumbe huo haupo hapa tena."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Nenda kwenye ujumbe"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Ujumbe wa sauti"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Mwandishi ameipenda"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Ongeza picha au klipu"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Midia"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Jumbe za sauti"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Gumzo"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Mandhari"),
      "ui_dm_info_mute_row": MessageLookupByLibrary.simpleMessage("Zima arifa"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Acha kupokea arifa kuhusu mazungumzo haya"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Hawawezi tena kukutumia ujumbe"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Hakuna"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Picha"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Sauti imerejeshwa."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kuondoa. Jaribu tena."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Wasifu"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Rejesha sauti"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Picha na klipu unazoshiriki huonekana hapa."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("Ona zote"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("Picha na klipu"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Hivi ndivyo gumzo lako litakavyoonekana."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Inaonekana vizuri."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Ukungu"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Machweo"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Kijani"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Mchanga"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Vitone"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Tumia"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Ya sasa"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Tuma bila onyesho la kukagua"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Tafuta"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Chapisha"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Andika ujumbe…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Tuma"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Imetumwa"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "Imetumwa, lakini si kwa kila mtu."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Haikuweza kutumwa. Jaribu tena."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Mfuasi"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Chuja"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Zote"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Hazijasomwa"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Hazijajibiwa"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Zilizofichwa"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Hakuna kilichofichwa"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Mazungumzo unayoondoa kwenye orodha yako yanasubiri hapa, iwapo utayataka tena."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Yanahamia Zilizofichwa. Mtu mwingine anabaki na yake, na yanarudi iwapo mmoja wenu ataandika tena."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Rudisha"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Yamerudi kwenye orodha yako."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "Hakuna mazungumzo yanayolingana."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Hakuna kinachokusubiri"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kila mazungumzo yanaishia kwa neno lako."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Picha"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Picha"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Bado hakuna ujumbe"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Wewe:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Jana"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Ujumbe"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Mipangilio ya ujumbe"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("Faragha"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Risiti za kusomwa"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Ikizimwa, watu hawataona ulipousoma ujumbe wao, nawe hutaona walipousoma wako."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Onyesha unapoandika"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Unayemwandikia anaona kwamba unaandika."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Maonyesho ya viungo"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Simu yako hufungua kiungo unachotuma ili kutengeneza onyesho lake, kwa hivyo tovuti huona ombi la simu yako. Seva ya Kyron haioni kiungo kamwe."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Arifa za ujumbe"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Ujumbe umesimbwa mwisho hadi mwisho. Kyron haiwezi kuusoma, na hakuna kitu hapa kinachobadilisha hilo."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Kwa:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Za karibuni"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Watu"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Hakuna mwenye jina hilo."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Tuma arifa ya majaribio"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Seva ya Kyron bado haijawekwa kutuma arifa, kwa hivyo hakuna inayoweza kufika. Tatizo liko upande wetu, si kwenye simu yako."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Simu hii haijasajiliwa kwa arifa. Hakikisha arifa za Kyron zimeruhusiwa kwenye mipangilio ya simu yako, kisha ujaribu tena."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Arifa haikuweza kufikishwa kwenye simu hii. Jaribu tena baada ya dakika moja."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Imetumwa. Inapaswa kufika ndani ya sekunde chache."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Arifa zinafanya kazi."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Bado hakuna machapisho"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("Jumuiya mpya"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Jina"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Anwani yake hutengenezwa kutokana na jina."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Watu wataipata kwenye"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Utakuwa mmiliki wake. Picha, bango na wasimamizi wanaweza kuongezwa kutoka ukurasa wake ikishakuwepo."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Nyumbani"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Machapisho ya jumuiya Nyumbani"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Machapisho kutoka jumuiya zako pia huonekana Nyumbani. Ikizimwa, hubaki hapa kwenye Jumuiya, ambapo kila moja huonyesha kilicho kipya."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Orodha yako"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Idadi ya machapisho mapya"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Onyesha ni machapisho mangapi mapya katika kila jumuiya tangu ulipoifungua mara ya mwisho."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Jumuiya unazoendesha"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Jumuiya unazoanzisha au kusimamia zimeorodheshwa hapa."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Mmiliki"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Msimamizi"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Machapisho mapya"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Unazoendesha"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Mipangilio ya jumuiya"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Gundua"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Hakuna jumuiya inayolingana."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Hakuna jipya"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kila jumuiya iko kama ulivyoiacha."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Bado huendeshi yoyote"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "Hakuna kilichobaki cha kujiunga"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Uko katika kila jumuiya kwenye Kyron. Anzisha nyingine."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Jaribu neno lingine, au anzisha jumuiya kwa jina hilo."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Andika chapisho"),
      "ui_community_members":
          MessageLookupByLibrary.simpleMessage("Wanachama:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Imechapishwa"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Tazama"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Fungua"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Mtandaoni"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Onyesha ukiwa mtandaoni"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Watu unaowatumia ujumbe huona kitone cha kijani wakati Kyron iko wazi kwako. Ikizimwa, nawe hutaona chao."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Tafuta watu na machapisho"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Jumuiya za kujiunga nazo"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Bado hakuna cha kutazama"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Picha na klipu ambazo watu huchapisha zitaonekana hapa."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Fuata"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("Futa akaunti"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Hii itafuta akaunti yako ya Kyron kabisa. Haiwezi kutenduliwa."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Wasifu wako, machapisho, majibu, vipendwa na machapisho uliyoshiriki tena"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Ujumbe wako, pamoja na ule uliowatumia wengine, na picha na ujumbe wa sauti ndani yake"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Wafuasi wako, watu unaowafuata na mipangilio yako"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Jumuiya ulizoanzisha zitakabidhiwa kwa msimamizi au mwanachama aliyedumu zaidi. Jumuiya isiyo na mtu mwingine itafungwa."),
      "ui_delete_account_confirm_title": MessageLookupByLibrary.simpleMessage(
          "Ungependa kufuta akaunti yako?"),
      "ui_delete_account_confirm_detail":
          MessageLookupByLibrary.simpleMessage("Hutaweza kurejesha chochote."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Akaunti yako imefutwa."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Akaunti iliyofutwa"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Akaunti hii imefutwa, kwa hivyo ujumbe hauwezi kutumwa hapa tena."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Ulijisajili kwa Google? Tumia «Sign in with Google» badala yake."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Lenzi hiyo haikuweza kupakiwa."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Video haikuweza kurekodiwa."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Lenzi haikuweza kuongezwa kwenye video hii, kwa hiyo inachapishwa kama ilivyorekodiwa."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Chapisho lako tayari lina viambatisho vingi kadri linavyoweza kubeba."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Inaongeza lenzi yako…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Mweko"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Rekodi video"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Picha"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Video"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Kuingia kwa Google kumeghairiwa."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("ZAWADI"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Hakuna aliyetuma zawadi kwenye chapisho hili bado."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Zawadi"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Zawadi"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Sarafu"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Mtumaji"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Watumaji"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Sarafu za majaribio: haziwezi kutolewa bado."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Zilizohifadhiwa"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Machapisho"),
      "ui_saved_tab_comments": MessageLookupByLibrary.simpleMessage("Maoni"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Tazama majibu zaidi"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Imehaririwa"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Zaidi"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Unaowafuata"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Bora"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Za karibuni"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Panga maoni: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "ametuma zawadi kwenye chapisho lako"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "ametuma \$gift kwenye maoni yako"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "ametuma \$gift kwenye chapisho lako"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Tuma zawadi"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Hariri chapisho"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Unaweza kulihariri kwa dakika \$n zaidi"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Hifadhi"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Hakuna kilichochapishwa chini ya #\$tab bado."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Chagua zawadi"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Sarafu hazitoshi"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Sarafu za majaribio: haziwezi kununuliwa na hazina thamani ya pesa."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Zinajazwa tena \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("Sarafu 1"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("Sarafu \$count"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("Una \$coins"),
      "ui_gift_send_named": MessageLookupByLibrary.simpleMessage("Tuma \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift imetumwa"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "Kwa dakika 15 baada ya kuchapisha"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Imehaririwa"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia maoni uliyohifadhi"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Hakuna maoni yaliyohifadhiwa"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Gusa aikoni ya kumbukumbu chini ya maoni ili kuyaweka hapa. Ni wewe tu unayeona unachohifadhi."),
      "ui_replying_to": MessageLookupByLibrary.simpleMessage("Unamjibu \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Nakili"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Tafuta"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Chagua zote"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("Zawadi \$count"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("Zawadi 1"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia machapisho zaidi."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Vikumbusho"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Kipya baada ya kuwa mbali, na sarafu zako zinaporudi. Kamwe zaidi ya kimoja kwa siku."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Zawadi"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("kutoka kwa mtu 1"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("kutoka kwa watu \$count"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Mtoaji mkuu"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Imeshindwa kupakia waliotuma zawadi."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Kipya"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Nimeelewa"),
      "ui_check_in_thanks":
          MessageLookupByLibrary.simpleMessage("Asante. Tunasoma kila jibu."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Kyron inaendeleaje hadi sasa?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Siku ya \$day ya majaribio yako. Mguso mmoja unatosha."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Kuna kitu tunachopaswa kurekebisha au kuongeza? (si lazima)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Tuma"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Si sasa"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Bonyeza nyuma tena ili kuondoka Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Thibitisha kuwa ni wewe"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Weka nenosiri lako ili kufuta akaunti yako."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Ingia tena kwa Google ili kufuta akaunti yako."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Hilo halikufanya kazi. Kagua kisha ujaribu tena."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Ukurasa huu unataka kufungua programu nyingine"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Unaomba kufungua kiungo cha {scheme}."),
    };

final messageLookup = MessageLookup();
