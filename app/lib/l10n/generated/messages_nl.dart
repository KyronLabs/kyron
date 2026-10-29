import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'nl';

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
      "change": MessageLookupByLibrary.simpleMessage("Wijzigen"),
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
          MessageLookupByLibrary.simpleMessage("Contact opnemen met support"),
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
          "Zichtbaar op je profiel en onder je berichten."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Geen land komt overeen met ‘{query}’."),
      "country_none": MessageLookupByLibrary.simpleMessage("Geen land tonen"),
      "country_search": MessageLookupByLibrary.simpleMessage("Landen zoeken"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Zichtbaar op je profiel en onder je berichten. Als je iemands berichten ziet, telt je land mee in diens Inzichten, alleen in groepen van vijf of meer en nooit bij naam."),
      "country_suggested": MessageLookupByLibrary.simpleMessage(
          "Uit de instellingen van je telefoon"),
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
      "done": MessageLookupByLibrary.simpleMessage("Klaar"),
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
      "follow_author": MessageLookupByLibrary.simpleMessage("{name} volgen"),
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
          MessageLookupByLibrary.simpleMessage("Post in {name}"),
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
      "profile_country": MessageLookupByLibrary.simpleMessage("Land"),
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
      "report": MessageLookupByLibrary.simpleMessage("Melden"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Melding verstuurd"),
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
      "sendReport": MessageLookupByLibrary.simpleMessage("Melding versturen"),
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
      "tryAgain": MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
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
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "Light, dark, or whatever the phone is set to",
      ),
      "ui_before": MessageLookupByLibrary.simpleMessage("Before"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "Neither of you will see the other on Kyron, and any follow between you is removed. They are not told.",
      ),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Carrying"),
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
          MessageLookupByLibrary.simpleMessage("Poll: \$question"),
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
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Berichten:"),
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
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Groepen"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Geen groepen"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Groepen waar je in zit en communitychats waar je lid van wordt, staan hier."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Je kunt maximaal \$count chats vastzetten. Maak er eerst een los."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Vastgezet"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Vind ik leuk"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Opgeslagen"),
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
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Kies je taal"),
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
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
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
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Citeren"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Versturen in een bericht"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Aan mensen op Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Share this post"),
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
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Opnieuw proberen"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Two characters or more.",
      ),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Ongedaan maken"),
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
        "Wat is er gebeurd, en waar moeten we naar kijken?",
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
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
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
    };

final messageLookup = MessageLookup();
