import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sw';

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
      "change": MessageLookupByLibrary.simpleMessage("Badilisha"),
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
          MessageLookupByLibrary.simpleMessage("Wasiliana na usaidizi"),
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
          "Inaonyeshwa kwenye wasifu wako na chini ya machapisho yako."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Hakuna nchi inayolingana na “{query}”."),
      "country_none": MessageLookupByLibrary.simpleMessage("Usionyeshe nchi"),
      "country_search": MessageLookupByLibrary.simpleMessage("Tafuta nchi"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Inaonyeshwa kwenye wasifu wako na chini ya machapisho yako. Unapoona machapisho ya mtu, nchi yako huhesabiwa katika Maarifa yake, kwa makundi ya watu watano au zaidi tu na kamwe si kwa jina."),
      "country_suggested": MessageLookupByLibrary.simpleMessage(
          "Kutoka kwenye mipangilio ya simu yako"),
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
      "done": MessageLookupByLibrary.simpleMessage("Imekamilika"),
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
      "follow_author": MessageLookupByLibrary.simpleMessage("Mfuate {name}"),
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
      "profile_country": MessageLookupByLibrary.simpleMessage("Nchi"),
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
      "report": MessageLookupByLibrary.simpleMessage("Ripoti"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Ripoti imetumwa"),
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
      "sendReport": MessageLookupByLibrary.simpleMessage("Tuma ripoti"),
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
      "tryAgain": MessageLookupByLibrary.simpleMessage("Jaribu tena"),
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
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "Light, dark, or whatever the phone is set to",
      ),
      "ui_before": MessageLookupByLibrary.simpleMessage("Before"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "Neither of you will see the other on Kyron, and any follow between you is removed. They are not told.",
      ),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Carrying"),
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
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Machapisho:"),
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
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Chagua lugha yako"),
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
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Majibu"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Wiki hii"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Leo"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Akaunti yako ina onyo"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Jana"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
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
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Share this post"),
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
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Jaribu tena"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Two characters or more.",
      ),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Tendua"),
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
        "Nini kilitokea, na tuangalie nini?",
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
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
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
    };

final messageLookup = MessageLookup();
