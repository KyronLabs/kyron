import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'mr';

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
      "change": MessageLookupByLibrary.simpleMessage("बदला"),
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
          MessageLookupByLibrary.simpleMessage("सपोर्टशी संपर्क साधा"),
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
          "तुमच्या प्रोफाइलवर आणि तुमच्या पोस्टखाली दाखवला जातो."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "“{query}” शी जुळणारा देश नाही."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("कोणताही देश दाखवू नका"),
      "country_search": MessageLookupByLibrary.simpleMessage("देश शोधा"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "तुमच्या प्रोफाइलवर आणि तुमच्या पोस्टखाली दाखवला जातो. तुम्ही कोणाच्या पोस्ट पाहता तेव्हा, तुमचा देश त्यांच्या इनसाइट्समध्ये मोजला जातो, फक्त पाच किंवा अधिकांच्या गटांत आणि कधीही नावाने नाही."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("तुमच्या फोनच्या सेटिंग्जमधून"),
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
      "done": MessageLookupByLibrary.simpleMessage("झाले"),
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
      "follow_author":
          MessageLookupByLibrary.simpleMessage("{name} यांना फॉलो करा"),
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
      "ins_account": MessageLookupByLibrary.simpleMessage("तुमचे खाते"),
      "ins_act_community": MessageLookupByLibrary.simpleMessage("समुदाय उघडा"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("पोस्ट लिहा"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("पोस्ट पहा"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("तुमचे प्रोफाइल संपादित करा"),
      "ins_active": MessageLookupByLibrary.simpleMessage("ते कधी सक्रिय असतात"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("तुमच्या टाइम झोनमध्ये."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("वय"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "वाढदिवस दिलेल्या, पोहोचलेल्या {known} लोकांपैकी."),
      "ins_chart": MessageLookupByLibrary.simpleMessage("दररोज पोहोचलेले लोक"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("ते असलेले समुदाय"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("देश"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "ज्यांच्यापर्यंत पोहोचलात आणि ज्यांच्या प्रोफाइलवर देश आहे अशा {known} लोकांमधून."),
      "ins_days": MessageLookupByLibrary.simpleMessage("मागील {days} दिवस"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("इनसाइट्स लोड करता आल्या नाहीत"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("फॉलोअर्स"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "दाखवण्याइतका मोठा कोणताही गट अजून नाही."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("कसे वाढावे"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("ते फॉलो करत असलेले विषय"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("लाइक्स"),
      "ins_new": MessageLookupByLibrary.simpleMessage("नवीन"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("नवीन फॉलोअर्स"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "या कालावधीत तुमची कोणतीही पोस्ट कोणापर्यंत पोहोचली नाही."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("तुम्हाला फॉलो करत नाहीत"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "देश हे लोकांनी आपल्या प्रोफाइलवर निवडलेले आहेत. Kyron कोणाचेही शहर किंवा लिंग गोळा करत नाही, त्यामुळे त्यांच्यासाठी दाखवण्यासारखे काही नाही."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("उघडणे"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} पर्यंत पोहोचली · {likes} लाइक · {replies} उत्तरे"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("पोहोचलेले लोक"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "प्रत्येक व्यक्ती एकदाच मोजली जाते: तुमची एखादी पोस्ट त्यांना पहिल्यांदा दाखवली गेली किंवा त्यांनी उघडली. नवीन फॉलोअर्स अजूनही तुम्हाला फॉलो करतात; अनफॉलो मोजले जात नाहीत."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("उत्तरे"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("रीपोस्ट"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("सेव्ह"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "या कालावधीत {floor} लोकांनी तुमच्या पोस्ट पाहिल्यानंतर तुमचे प्रेक्षक कोण आहेत ते दिसते. त्यापेक्षा कमी असल्यास ते एखाद्या व्यक्तीकडे बोट दाखवू शकते."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("अजून पुरेसे लोक नाहीत"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "त्यांपैकी {pct}% आधीच तुम्हाला फॉलो करतात: तुमच्या पोस्ट मुख्यतः ओळखीच्यांपर्यंत पोहोचतात."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "त्यांपैकी {pct}% अजून तुम्हाला फॉलो करत नाहीत: तुमच्या पोस्ट शोधल्या जात आहेत."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "तुम्ही {reach} लोकांपर्यंत पोहोचलात, मागील कालावधीपेक्षा {pct}% कमी."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "मागील {days} दिवसांत तुम्ही {reach} लोकांपर्यंत पोहोचलात."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "तुम्ही {reach} लोकांपर्यंत पोहोचलात, साधारण मागील कालावधीइतके."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "मागील {days} दिवसांत कोणत्याही नवीन व्यक्तीने तुमच्या पोस्ट पाहिल्या नाहीत."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "तुम्ही {reach} लोकांपर्यंत पोहोचलात, मागील कालावधीपेक्षा {pct}% जास्त."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "तुम्ही {reach} लोकांपर्यंत पोहोचलात, मागील कालावधीच्या {times}×."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "इतर कोणत्याही विषयापेक्षा जास्त जण {name} फॉलो करतात."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("प्रेक्षक"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("आढावा"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "तुमची पोस्ट सापडलेले लोक फॉलो करण्याआधी तुमचे प्रोफाइल पाहतात. चेहरा किंवा लोगो त्यांना सांगतो की तिथे कोणीतरी आहे."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("प्रोफाइल फोटो जोडा"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "तुम्ही कशाबद्दल पोस्ट करता ते एका ओळीत सांगा, म्हणजे अनोळखी व्यक्तीला कळेल की तुम्हाला फॉलो केल्याने काय मिळेल."),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("बायो लिहा"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "तुमच्या {total} पोस्टपैकी {without} ना विषय नव्हता. विषय पोस्टला त्या विषयाच्या फीडमध्ये आणि तो फॉलो करणाऱ्यांसमोर ठेवतो."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("पोस्टमध्ये विषय जोडा"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} लोकांनी तुमच्या पोस्टवर उत्तर दिले आणि तुम्ही {answered} ला प्रतिसाद दिला. लिहिण्याइतकी त्यांना काळजी होती: एक प्रतिसाद वाचकाला नियमित बनवतो."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("उत्तरांना प्रतिसाद द्या"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "तुमचे प्रेक्षक {when} सर्वाधिक सक्रिय असतात. त्याच्या थोडे आधी केलेल्या पोस्टला स्वागत करणारे लोक मिळतात."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("ते सक्रिय असताना पोस्ट करा"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "तुम्हाला फॉलो न करणाऱ्या {reached} लोकांनी तुमच्या पोस्ट पाहिल्या, आणि {gained} जणांनी फॉलो केले. तुमचा बायो आणि नवीन पोस्ट सांगू द्या की ते तुमच्याकडून काय अपेक्षा ठेवू शकतात."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("वाचकांना फॉलोअर बनवा"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "एका पोस्टने तुमच्या इतर पोस्ट सहसा पोहोचतात त्याच्या {times}× लोकांपर्यंत पोहोचली. तिने काय वेगळे केले ते पहा, आणि ते अधिक करा."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("जे यशस्वी झाले ते अधिक करा"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "तुमच्या पोस्ट पाहणारे अनेक जण {name} मध्ये आहेत. तिथे पोस्ट केल्याने तुम्ही उरलेल्यांसमोरही येता."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("{name} मध्ये पोस्ट करा"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "तुम्ही {days} दिवसांत {posts} वेळा पोस्ट केले. प्रत्येक पोस्ट सापडण्याची आणखी एक संधी आहे, आणि नियमित लय तुम्हाला फॉलोअर्सच्या फीडमध्ये ठेवते."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("अधिक वेळा पोस्ट करा"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "मागील {days} दिवसांत तुम्ही पोस्ट केलेले नाही. पोस्टशिवाय काहीही कोणापर्यंत पोहोचत नाही."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("काहीतरी पोस्ट करा"),
      "ins_title": MessageLookupByLibrary.simpleMessage("इनसाइट्स"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("सर्वोत्तम पोस्ट"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "आधीच्या {days} दिवसांच्या तुलनेत"),
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
      "profile_country": MessageLookupByLibrary.simpleMessage("देश"),
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
      "report": MessageLookupByLibrary.simpleMessage("रिपोर्ट करा"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("रिपोर्ट पाठवला"),
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
      "sendReport": MessageLookupByLibrary.simpleMessage("रिपोर्ट पाठवा"),
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
      "tryAgain": MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
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
          "हे उद्धरण लोकांना फसवणुकीबद्दल सावध करण्यासाठी होते."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "निर्णय चुकीचा का वाटतो ते सांगा: पोस्टचा अर्थ काय होता, टीमकडून काय सुटले असेल किंवा नियम का लागू होत नाही. निर्णय घेणाऱ्याऐवजी दुसरे कोणीतरी ते वाचते."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("तुमचे अपील"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "किमान \$count अक्षरे लिहा. प्रत्येक निर्णयावर तुम्ही एकदाच अपील करू शकता."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("अपील पाठवा"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "अपील पाठवले. निर्णय झाल्यावर तुम्हाला सूचना मिळेल."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("केस \$number वर अपील"),
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
          MessageLookupByLibrary.simpleMessage("हे कशासाठी आहे (ऐच्छिक)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("फक्त मॉडरेटर लिहू शकतात"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "घोषणांसाठी. समुदायातील सर्वजण अजूनही वाचू आणि प्रतिक्रिया देऊ शकतात."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("फोटो किंवा मतदान जोडा"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("फोटो आणि व्हिडिओ"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("चॅट बंद करा"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "यात कोणीही वाचू किंवा लिहू शकणार नाही. हे पूर्ववत करता येत नाही."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("ही चॅट बंद करायची?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("कॉपी केले"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "संदेश सर्वांसाठी काढला जातो. Kyron पुनरावलोकनासाठी एक प्रत ठेवते."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "संदेश चॅटमधील सर्वांसाठी काढला जातो."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("चॅट संपादित करा"),
      "ui_cchat_edit_message":
          MessageLookupByLibrary.simpleMessage("संपादित करा"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("संपादित"),
      "ui_cchat_editing": MessageLookupByLibrary.simpleMessage(
          "तुम्ही तुमचा संदेश संपादित करत आहात"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("ही चॅट उघडता आली नाही."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("चॅट"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("चॅटमध्ये सामील व्हा"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "समुदायाच्या चॅट पाहण्यासाठी आणि सहभागी होण्यासाठी समुदायात सामील व्हा."),
      "ui_cchat_joined": MessageLookupByLibrary.simpleMessage("\$count सामील"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("चॅट सोडा"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही समुदायात असेपर्यंत ती वाचू शकता."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "इथे फक्त मालक आणि मॉडरेटर लिहू शकतात."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("म्यूट करा"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "यातून सूचना येणार नाहीत, आणि हे संदेशांच्या मोजणीत धरले जाणार नाही."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("चॅटचे नाव"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("नवीन चॅट"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("अजून कोणत्याही चॅट नाहीत."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "अजून कोणत्याही चॅट नाहीत. समुदायासाठी एक उघडा."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "समुदाय चॅट एंड-टू-एंड एन्क्रिप्टेड नाहीत. समुदायाचे मॉडरेटर आणि Kyron त्या वाचू शकतात."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("सर्वात वर पिन करा"),
      "ui_cchat_poll_add": MessageLookupByLibrary.simpleMessage("उत्तर जोडा"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("मतदान बंद करा"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("बंद"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "प्रत्येक उत्तर किती जणांनी निवडले हे सर्वांना दिसते, कोणी ते कधीच नाही."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("अनेक निवडी करू द्या"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("नवीन मतदान"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("एक निवडा"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("उत्तर \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("मतदान: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("प्रश्न"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "प्रत्येक उत्तर मतदानात एकदाच असू शकते."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("एक किंवा अधिक निवडा"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count जणांनी उत्तर दिले"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("या चॅटमध्ये शोधा"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("या चॅटमध्ये शोधा"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("काहीही सापडले नाही."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "तुम्ही आता ही चॅट पाहू शकत नाही."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("मंद मोड"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "संदेशांमध्ये किती वेळ थांबायचे. मॉडरेटरना लागू नाही."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 तास"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n मिनिटे"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "मंद मोड: दर \$seconds सेकंदांनी एक संदेश"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("बंद"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n सेकंद"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "तुम्ही प्रेक्षक म्हणून वाचू आणि प्रतिक्रिया देऊ शकता. लिहिण्यासाठी सामील व्हा."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "तो संदेश दाखवण्यासाठी खूप जुना आहे."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "तुम्ही निवडलेले काहीतरी पाठवण्यासाठी खूप मोठे आहे आणि वगळले गेले."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("अनम्यूट करा"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("अनपिन करा"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("व्हॉइस नोट रेकॉर्ड करा"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("तुम्ही"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("पोस्ट:"),
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
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("ग्रुप"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("कोणतेही ग्रुप नाहीत"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही ज्या ग्रुपमध्ये आहात आणि ज्या कम्युनिटी चॅटमध्ये सामील होता, ते इथे दिसतात."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "तुम्ही जास्तीत जास्त \$count चॅट पिन करू शकता. आधी एक अनपिन करा."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("पिन केलेले"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("आवडलेले"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("जतन केलेले"),
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
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("फिकट होत आहे"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("स्वारस्य नाही"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("असे आणखी दाखवा"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("काढले"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("तुमचे फीड संकेत"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "पोस्टवर अशा आणखी पोस्ट दाखवा किंवा यात स्वारस्य नाही वर टॅप करा, आणि ते इथे दिसेल."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("अजून इथे काही नाही"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "आणखी दाखवा आणि स्वारस्य नाही तुमच्या फीडला काय सांगतात"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "हे होम आणि एक्सप्लोर घडवतात, मुख्यतः प्रत्येक पोस्ट कशाबद्दल होती यावरून. प्रत्येक संकेत दर महिन्याला निम्मा होतो आणि सहा महिन्यांनंतर मोजला जात नाही. आत्ताच थांबवण्यासाठी एक काढा."),
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
      "ui_group_add": MessageLookupByLibrary.simpleMessage("लोक जोडा"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("जोडा"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("गटाचे नाव जोडा"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("नाकारा"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "या ग्रुपमधील मेसेज इतर कोणत्याही संभाषणाप्रमाणे एंड-टू-एंड एन्क्रिप्टेड आहेत."),
      "ui_group_event_added": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी \$users यांना जोडले"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी \$users यांना ॲडमिन केले"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor यांनी ग्रुप तयार केला"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी नवीन लोक सदस्य म्हणून सामील होतील असे ठरवले"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी नवीन लोक प्रेक्षक म्हणून सामील होतील असे ठरवले"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor बाहेर पडले"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी \$users यांना सदस्य केले"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी \$users यांना मालक केले"),
      "ui_group_event_removed": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी \$users यांना काढले"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी ग्रुपचे नाव बदलून \$title केले"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor यांनी \$users यांना प्रेक्षक केले"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "एका ग्रुपमध्ये जास्तीत जास्त \$count लोक असू शकतात."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "हात वर केला. ॲडमिनना कळवले आहे."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count लिहू इच्छितात"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("लिहू इच्छितात"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "नंतर जोडलेले लोक प्रेक्षक म्हणून सामील होतात"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("ग्रुप सोडा"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "तो तुमच्या यादीतून जाईल आणि नंतर काय बोलले जाते ते तुम्हाला दिसणार नाही. कोणालातरी तुम्हाला पुन्हा जोडावे लागेल."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("हा ग्रुप सोडायचा?"),
      "ui_group_let_write": MessageLookupByLibrary.simpleMessage("लिहू द्या"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("हात खाली करा"),
      "ui_group_make_admin": MessageLookupByLibrary.simpleMessage("ॲडमिन करा"),
      "ui_group_make_owner": MessageLookupByLibrary.simpleMessage("मालक करा"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("प्रेक्षक करा"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count सदस्य"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("सदस्य"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("ग्रुपचे नाव"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("आधी गटाला नाव द्या."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("ग्रुप चॅट तयार करा"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "मालक एकच असतो. तुम्ही ॲडमिन राहाल."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("\$name यांना मालक करायचे?"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("हात वर करा"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("ग्रुपमधून काढा"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("ॲडमिनमधून काढा"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "तुम्ही आता या ग्रुपमध्ये नाही."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("नाव बदला"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("ॲडमिन"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("सदस्य"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("प्रेक्षक"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "प्रेक्षक म्हणून तुम्ही येथे वाचू आणि प्रतिक्रिया देऊ शकता."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "प्रेक्षक वाचू शकतात, प्रतिक्रिया देऊ शकतात आणि लिहिण्यासाठी हात वर करू शकतात."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("सुचवलेले"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("प्रोफाइल पाहा"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("तुम्ही"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("तुम्ही प्रेक्षक आहात"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("तुमची भाषा निवडा"),
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
          MessageLookupByLibrary.simpleMessage("तुमचे खाते अपडेट झाले"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "केस \$number वरील तुमचे अपील स्वीकारले गेले"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "केस \$number वरील तुमचे अपील आम्ही पुन्हा पाहिले, आणि निर्णय कायम आहे"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "तुमच्या खात्यावर कायमची बंदी घातली आहे"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("केस \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("यांनी तुम्हाला फॉलो केले"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("यांना तुमची पोस्ट आवडली"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("यांनी तुमचा उल्लेख केला"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("अजून कोणताही उल्लेख नाही"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "कोणी पोस्ट किंवा उत्तरात तुमचे @हँडल लिहिले की ते इथे दिसेल."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("जुने"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "कम्युनिटी चॅटमधील तुमचा संदेश काढून टाकला"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "तुम्ही पोस्ट केलेले काहीतरी काढून टाकले"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("तुमची पोस्ट काढून टाकली"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("तुमचे उत्तर काढून टाकले"),
      "ui_notif_replied": MessageLookupByLibrary.simpleMessage(
          "यांनी तुमच्या पोस्टला उत्तर दिले"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "तुम्ही रिपोर्ट केलेल्या गोष्टीवर आम्ही कारवाई केली. आम्हाला सांगितल्याबद्दल धन्यवाद."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "तुम्ही रिपोर्ट केलेली गोष्ट आम्ही पाहिली आणि तिने आमचे नियम मोडल्याचे आढळले नाही."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("रिपोर्टचे कारण: \$reason"),
      "ui_notif_reposted": MessageLookupByLibrary.simpleMessage(
          "यांनी तुमची पोस्ट पुन्हा शेअर केली"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "आम्ही केस \$number चा निर्णय मागे घेतला"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("तुमचे खाते निलंबित आहे"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "तुमचे खाते \$date पर्यंत निलंबित आहे"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("सर्व"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("फॉलो"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("लाइक"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("उल्लेख"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("उत्तरे"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("या आठवड्यात"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("आज"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "तुमच्या खात्याला इशारा मिळाला आहे"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("काल"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("हे आधीच उघडले गेले आहे."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("मुदत संपली"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("हे उघडता आले नाही."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "एकदाच उघडते, मग Kyron वरून हटवले जाते."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("एकदाच पाहा"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("उघडले"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "\$total पैकी \$count जणांनी उघडले"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "तुम्ही ज्यांना पाठवले तेच हे एकदा उघडू शकतात."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("एकदा पाहण्यासाठी पाठवा"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("पाहण्यासाठी टॅप करा"),
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
          "आणखी काही जोडायचे आहे? (पर्यायी)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "टीमने निर्णय घेतल्यावर तुम्हाला सूचना मिळेल, आणि तुम्ही ते तुमच्या रिपोर्टमध्ये पाहू शकता."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "तुम्हाला ही व्यक्तीही पाहायची नसेल, तर त्याच मेनूमधून म्यूट किंवा ब्लॉक करा."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "एकच गोष्ट दोनदा रिपोर्ट केल्याने तिचे वजन वाढत नाही: आम्ही प्रत्येक व्यक्तीचा एकच रिपोर्ट ठेवतो."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "तुमचा रिपोर्ट त्या व्यक्तीला दाखवला जात नाही. तुम्ही रिपोर्ट केलेल्या गोष्टीची प्रत आम्ही ठेवतो, जेणेकरून ती हटवली तरी तिचे पुनरावलोकन करता येईल."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "तुमचा रिपोर्ट मिळाला आहे आणि पुनरावलोकनाच्या रांगेत आहे. रिपोर्ट कोणी केला हे आम्ही त्या व्यक्तीला सांगत नाही."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("तुमचे रिपोर्ट पाहा"),
      "ui_report_tell_us": MessageLookupByLibrary.simpleMessage(
          "काय चुकीचे आहे ते आम्हाला सांगा"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("कळवल्याबद्दल धन्यवाद"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("\$name मध्ये काय चुकीचे आहे?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("या संदेशात काय चुकीचे आहे?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("या पोस्टमध्ये काय चुकीचे आहे?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("या उत्तरात काय चुकीचे आहे?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी चॅटमधील एक संदेश"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("एक पोस्ट"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("एक उत्तर"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("कारवाई केली"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("एक खाते"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("निर्णय \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("कोणताही नियम मोडला नाही"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "तुमचे रिपोर्ट लोड होऊ शकले नाहीत"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "गेल्या 90 दिवसांत तुम्ही काय रिपोर्ट केले आणि त्याचे काय झाले. टीमने निर्णय घेतल्यावर तुम्हाला सूचना मिळते. तुम्ही ज्याचा रिपोर्ट करता, त्याला कधीही सांगितले जात नाही की रिपोर्ट कोणी केला."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("काहीही रिपोर्ट केलेले नाही"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही एखादी पोस्ट, उत्तर, संदेश किंवा खाते रिपोर्ट करता, तेव्हा ते त्याच्या निकालासह इथे दिसते."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("पुनरावलोकनात"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("रिपोर्ट केले \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "तुम्ही काय रिपोर्ट केले आणि त्याचे काय झाले"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("तुमचे रिपोर्ट"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("मुलांची सुरक्षा"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "अल्पवयीन व्यक्तीला धोक्यात आणणारी किंवा तिचे लैंगिकीकरण करणारी कोणतीही गोष्ट."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "लक्ष्य करून केलेला छळ, धमक्या किंवा नको असलेला संपर्क."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "लोक कोण आहेत यावरून त्यांच्यावर केलेले हल्ले."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "बेकायदेशीर गोष्टीची विक्री किंवा प्रचार."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "दुसरे कोणीतरी असल्याचे भासवणे."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "तुमचे काम किंवा ट्रेडमार्क परवानगीशिवाय वापरते."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "आरोग्य, निवडणुका किंवा घटनांबद्दल दिशाभूल करणारे दावे."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "स्वतःला इजा करण्यास प्रोत्साहन देणे किंवा ते दाखवणे."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "इशाऱ्याशिवाय दाखवलेला लैंगिक मजकूर."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "यापैकी काहीही नाही. काय चुकीचे आहे ते आम्हाला सांगा."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "वारंवार, दिशाभूल करणारा किंवा नको असलेला प्रचार."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "हिंसेची धमकी देणे, तिचे उदात्तीकरण करणे किंवा तिला चिथावणी देणे."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("छळ किंवा दादागिरी"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("द्वेषपूर्ण भाषण"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("बेकायदेशीर वस्तू किंवा सेवा"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("दुसऱ्याचे सोंग घेणे"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("बौद्धिक संपदा"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("खोटी माहिती"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("आत्महत्या किंवा स्वतःला इजा"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("प्रौढांसाठी सामग्री"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("दुसरे काहीतरी"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("स्पॅम"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("हिंसा किंवा धमक्या"),
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
          MessageLookupByLibrary.simpleMessage("कशाबद्दल होते"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "तुमच्या खात्यावर कायमची बंदी आहे"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("उत्तर, \$date रोजी:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("अपील"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("या निर्णयावर अपील करा"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "या निर्णयावर आता अपील करता येणार नाही. काही चुकीचे असल्यास सपोर्टशी संपर्क साधा."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("अपीलचे पुनरावलोकन सुरू आहे"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("अपील स्वीकारले"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "टीममधील दुसरे कोणीतरी ते पुन्हा पाहत आहे. निर्णय झाल्यावर तुम्हाला सूचना मिळेल."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "ही चूक होती असे वाटत असल्यास, \$date पर्यंत पुन्हा पुनरावलोकनाची विनंती करू शकता. निर्णय टीममधील दुसरे कोणीतरी घेते."),
      "ui_standing_appeal_upheld":
          MessageLookupByLibrary.simpleMessage("अपीलनंतर: निर्णय कायम आहे"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "केस \$number. नियम: \$rule. टीमने लिहिले:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "खाते हटवल्याने बंदी उठत नाही: त्याच ईमेल पत्त्याचे नवीन खातेही बंदीसह सुरू होते."),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("कायमची बंदी"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "फक्त हे पेज, अपील, सपोर्ट आणि खाते हटवणे एवढेच अजून चालते."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("अपील करता येते"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("केस \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("\$date रोजी निर्णय"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("तुमच्या खात्याबद्दलचे निर्णय"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("तुमचे खाते हटवा"),
      "ui_standing_details": MessageLookupByLibrary.simpleMessage("तपशील पाहा"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("तपशील पाहा आणि अपील करा"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("\$date रोजी संपते"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "तुमचे खाते चांगल्या स्थितीत आहे"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("त्यावर कोणतेही बंधन नाही."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "खात्याची स्थिती लोड करता आली नाही"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("संदेश काढून टाकला"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "तुमच्या खात्याबद्दल कोणताही निर्णय झालेला नाही. टीमने कधी तुमचे काही काढून टाकले किंवा तुमच्या खात्यावर निर्बंध घातले, तर ते कारणासह इथे दिसेल आणि तुम्ही अपील करू शकाल."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "अपील करण्यासारखे काही नाही: निर्णय रद्द केला गेला."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("पोस्ट काढून टाकली"),
      "ui_standing_pull_to_check":
          MessageLookupByLibrary.simpleMessage("पुन्हा तपासण्यासाठी खाली ओढा."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Kyron चे नियम वाचा"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("उत्तर काढून टाकले"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("रद्द केले"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "\$date रोजी रद्द केले. काढून टाकलेले सर्व परत आले आहे आणि आता कोणतेही निर्बंध लागू नाहीत."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("नियम: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("साइन आउट करा"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("निलंबित"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही वाचू शकता, पण पोस्ट, उत्तर, फॉलो किंवा संदेश पाठवू शकत नाही. रिपोर्ट, ब्लॉक आणि म्यूट अजूनही चालतात."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "तुमचे खाते निलंबित आहे: तुम्ही वाचू शकता, पण पोस्ट करू शकत नाही."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("\$date पर्यंत निलंबित"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "तुमचे खाते \$date पर्यंत निलंबित आहे: तुम्ही वाचू शकता, पण पोस्ट करू शकत नाही."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("टीमने काय लिहिले"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("खात्याची स्थिती"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("चेतावणी"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("का?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("तुम्ही \$date रोजी लिहिले:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("तुमचा संदेश"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("तुमची पोस्ट"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("तुमचे उत्तर"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_try_again":
          MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Two characters or more.",
      ),
      "ui_undo": MessageLookupByLibrary.simpleMessage("पूर्ववत करा"),
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
        "काय झाले, आणि आम्ही काय पाहावे?",
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
          MessageLookupByLibrary.simpleMessage("तुम्ही उत्तर दिले"),
      "dmReplied": (Object a0) => "$a0 यांनी उत्तर दिले",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("संदेशात जोडा"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("नवीन संदेश"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "अजून काहीही बोलले गेले नाही. हात हलवणे ही चांगली सुरुवात आहे."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  हात हलवा"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("नवीन संदेश"),
      "dmTyping": (Object a0) => "$a0 टाइप करत आहेत",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("तुमची प्रतिक्रिया काढा"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("कोणीतरी"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("संदेश"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("जोडणी"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "हा संदेश या डिव्हाइसवर वाचता येत नाही."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "या संदेशाची प्रतीक्षा करत आहे. याला थोडा वेळ लागू शकतो."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("एन्क्रिप्ट केलेला संदेश"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "संदेश एंड-टू-एंड एन्क्रिप्ट केलेले आहेत"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "एंड-टू-एंड एन्क्रिप्ट केलेला नाही"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("पाठवला"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("पाहिला"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("पाठवत आहे…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("फोटो काढा"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("अधिक पर्याय"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("डिव्हाइसवर सेव्ह करा"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("शेअर करा"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("सेव्ह करत आहे…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("तुमच्या फोटोंमध्ये सेव्ह केले"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "सेव्ह करता आले नाही. पुन्हा प्रयत्न करा."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "हे सेव्ह करण्यासाठी Kyron ला तुमच्या फोटोंमध्ये जोडू द्या."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("सर्व प्रणाली कार्यरत आहेत"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("अपटाइम"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("मागील 60 दिवस"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 दिवसांपूर्वी"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("आज"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("डेटाबेस"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("साइन-इन"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("अलीकडील घटना"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "मागील 60 दिवसांत कोणतीही घटना नाही."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("सुरू आहे"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("डेटा नाही"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("तपशील"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron चालू असताना दर 5 मिनिटांनी स्वतःची तपासणी करते. राखाडी दिवशी कोणतीही तपासणी झाली नाही."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "अपटाइमचा इतिहास अद्याप उपलब्ध नाही."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "काही प्रणालींमध्ये समस्या आहेत"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("व्हॉइस नोट रेकॉर्ड करा"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("पाठवण्यासाठी तयार"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("तो संदेश आता येथे नाही."),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("संदेशावर जा"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("व्हॉइस नोट"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("लेखकाला आवडले"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("फोटो किंवा क्लिप जोडा"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("मीडिया"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("व्हॉइस नोट्स"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("चॅट"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("वॉलपेपर"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("सूचना म्यूट करा"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "या संभाषणाबद्दल सूचना मिळणे थांबवा"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "ते आता तुम्हाला संदेश पाठवू शकत नाहीत"),
      "ui_dm_wallpaper_none":
          MessageLookupByLibrary.simpleMessage("काहीही नाही"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("फोटो"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("अनम्यूट केले."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "काढता आले नाही. पुन्हा प्रयत्न करा."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("प्रोफाइल"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("अनम्यूट करा"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "तुम्ही शेअर केलेले फोटो आणि क्लिप्स येथे दिसतात."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("सर्व पहा"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("फोटो आणि क्लिप्स"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("तुमचे चॅट असे दिसेल."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("छान दिसते."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("धुके"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("संधिप्रकाश"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("सेज"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("वाळू"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("ठिपके"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("लागू करा"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("सध्याचा"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("पूर्वावलोकनाशिवाय पाठवा"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("शोधा"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("पोस्ट करा"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("संदेश लिहा…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("पाठवा"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("पाठवले"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("पाठवले, पण सर्वांना नाही."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "पाठवता आले नाही. पुन्हा प्रयत्न करा."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("फिल्टर"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("सर्व"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("न वाचलेले"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("उत्तर न दिलेले"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("लपवलेले"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("काहीही लपवलेले नाही"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "तुमच्या यादीतून काढलेली संभाषणे इथे थांबतात, तुम्हाला परत हवी असल्यास."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "ते लपवलेल्यांमध्ये जाते. समोरची व्यक्ती आपले ठेवते, आणि तुमच्यापैकी कोणी पुन्हा लिहिल्यास ते परत येते."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("परत आणा"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("पुन्हा तुमच्या यादीत."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("जुळणारे संभाषण नाही."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("तुमची वाट पाहणारे काही नाही"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "प्रत्येक संभाषण तुमच्या शब्दावर संपते."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("फोटो"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("फोटो"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("व्हिडिओ"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("अजून संदेश नाहीत"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("तुम्ही:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("काल"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("संदेश"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("संदेश सेटिंग्ज"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("गोपनीयता"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("वाचल्याच्या पावत्या"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "हे बंद असताना तुम्ही त्यांचे संदेश कधी वाचले हे इतरांना दिसणार नाही, आणि त्यांनी तुमचे कधी वाचले हे तुम्हालाही दिसणार नाही."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("तुम्ही टाइप करताना दाखवा"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही ज्यांना लिहित आहात त्यांना दिसते की तुम्ही लिहित आहात."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("लिंक पूर्वावलोकन"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "पूर्वावलोकन बनवण्यासाठी तुमचा फोन तुम्ही पाठवलेली लिंक उघडतो, त्यामुळे साइटला तुमच्या फोनची विनंती दिसते. Kyron चा सर्व्हर लिंक कधीच पाहत नाही."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("संदेशांच्या सूचना"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "संदेश एंड-टू-एंड एन्क्रिप्टेड आहेत. Kyron ते वाचू शकत नाही, आणि इथले काहीही ते बदलत नाही."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("प्रति:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("अलीकडील"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("लोक"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("त्या नावाचे कोणी नाही."),
      "ui_push_test": MessageLookupByLibrary.simpleMessage("चाचणी सूचना पाठवा"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron चा सर्व्हर अजून सूचना पाठवण्यासाठी सेट केलेला नाही, त्यामुळे एकही येऊ शकत नाही. अडचण आमच्या बाजूला आहे, तुमच्या फोनमध्ये नाही."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "हा फोन सूचनांसाठी नोंदणीकृत नाही. फोनच्या सेटिंग्जमध्ये Kyron च्या सूचनांना परवानगी आहे का ते तपासा, मग पुन्हा प्रयत्न करा."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "सूचना या फोनपर्यंत पोहोचवता आली नाही. एका मिनिटाने पुन्हा प्रयत्न करा."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "पाठवले. काही सेकंदांत यायला हवे."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("सूचना काम करत आहेत."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("अजून पोस्ट नाहीत"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("नवीन समुदाय"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("नाव"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "त्याचा पत्ता नावावरून तयार होतो."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("लोकांना तो इथे सापडेल:"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही त्याचे मालक असाल. तो तयार झाल्यावर त्याच्या पेजवरून चित्र, बॅनर आणि मॉडरेटर जोडता येतील."),
      "ui_community_settings_home": MessageLookupByLibrary.simpleMessage("होम"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("होममध्ये समुदायाच्या पोस्ट"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "तुमच्या समुदायांच्या पोस्ट होममध्येही दिसतात. बंद केल्यास त्या इथेच समुदायांमध्ये राहतात, जिथे प्रत्येक नवीन काय आहे ते दाखवतो."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("तुमची यादी"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("नवीन पोस्टची संख्या"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "शेवटचे उघडल्यापासून प्रत्येक समुदायात किती पोस्ट नवीन आहेत ते दाखवा."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("तुम्ही चालवता ते समुदाय"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही सुरू करता किंवा मॉडरेट करता ते समुदाय इथे दिसतात."),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("मालक"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("मॉडरेटर"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("नवीन पोस्ट"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("तुम्ही चालवता ते"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("समुदाय सेटिंग्ज"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("शोधा"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("कोणताही समुदाय जुळत नाही."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("काही नवीन नाही"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "प्रत्येक समुदाय तुम्ही सोडला तसाच आहे."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("तुम्ही अजून एकही चालवत नाही"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "सामील होण्यासारखे काही उरले नाही"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही Kyron वरील प्रत्येक समुदायात आहात. आणखी एक सुरू करा."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "दुसरा शब्द वापरून पाहा, किंवा त्या नावाने समुदाय सुरू करा."),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("पोस्ट लिहा"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("सदस्य:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("पोस्ट झाली"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("पहा"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("उघडा"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("ऑनलाइन"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("तुम्ही ऑनलाइन असताना दाखवा"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही ज्यांना संदेश पाठवता त्यांना, तुम्ही Kyron उघडे ठेवल्यावर हिरवा ठिपका दिसतो. हे बंद असताना तुम्हालाही त्यांचा दिसणार नाही."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("लोक आणि पोस्ट शोधा"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("सामील होण्यासाठी समुदाय"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("अजून पाहण्यासारखे काही नाही"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "लोक पोस्ट करत असलेले फोटो आणि क्लिप्स इथे दिसतील."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("फॉलो करा"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("खाते हटवा"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "यामुळे तुमचे Kyron खाते कायमचे हटवले जाईल. हे पूर्ववत करता येणार नाही."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "तुमचे प्रोफाइल, पोस्ट, उत्तरे, लाइक आणि रीपोस्ट"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "तुमचे संदेश, इतरांना पाठवलेल्या संदेशांसह, आणि त्यांतील फोटो व व्हॉइस नोट्स"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "तुमचे फॉलोअर्स, तुम्ही फॉलो करता ते लोक आणि तुमची सेटिंग्ज"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "तुम्ही सुरू केलेले समुदाय सर्वात जुन्या मॉडरेटर किंवा सदस्याकडे जातील. ज्यात इतर कोणी नाही तो बंद होईल."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("तुमचे खाते हटवायचे?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "यातील काहीही तुम्हाला परत मिळणार नाही."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("तुमचे खाते हटवले आहे."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("हटवलेले खाते"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "हे खाते हटवले गेले आहे, त्यामुळे येथे आता संदेश पाठवता येणार नाहीत."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google ने साइन अप केले होते? त्याऐवजी «Sign in with Google» वापरा."),
    };

final messageLookup = MessageLookup();
