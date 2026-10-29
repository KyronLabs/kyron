import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'my';

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
      "change": MessageLookupByLibrary.simpleMessage("ပြောင်းရန်"),
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
          MessageLookupByLibrary.simpleMessage("အကူအညီဌာနကို ဆက်သွယ်ရန်"),
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
          "သင့်ပရိုဖိုင်နှင့် သင့်ပို့စ်များအောက်တွင် ပြသသည်။"),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "“{query}” နှင့် ကိုက်ညီသော နိုင်ငံ မရှိပါ။"),
      "country_none":
          MessageLookupByLibrary.simpleMessage("နိုင်ငံ မပြပါနှင့်"),
      "country_search":
          MessageLookupByLibrary.simpleMessage("နိုင်ငံများ ရှာရန်"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "သင့်ပရိုဖိုင်နှင့် သင့်ပို့စ်များအောက်တွင် ပြသသည်။ တစ်စုံတစ်ယောက်၏ ပို့စ်များကို သင်မြင်သောအခါ သင့်နိုင်ငံကို သူတို့၏ အချက်အလက်များတွင် ရေတွက်သည်၊ ငါးဦးနှင့်အထက် အုပ်စုများဖြင့်သာဖြစ်ပြီး အမည်ဖြင့် ဘယ်တော့မှ မဟုတ်ပါ။"),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("သင့်ဖုန်း၏ ဆက်တင်များမှ"),
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
      "done": MessageLookupByLibrary.simpleMessage("ပြီးပါပြီ"),
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
          MessageLookupByLibrary.simpleMessage("{name} ကို စောင့်ကြည့်ရန်"),
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
      "ins_account": MessageLookupByLibrary.simpleMessage("သင့်အကောင့်"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်းကို ဖွင့်ရန်"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("ပို့စ်ရေးရန်"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("ပို့စ်ကို ကြည့်ရန်"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("ပရိုဖိုင်ကို ပြင်ရန်"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("သူတို့ ဘယ်အချိန်ရှိသလဲ"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("သင့်အချိန်ဇုန်ဖြင့်။"),
      "ins_ages": MessageLookupByLibrary.simpleMessage("အသက်"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "မွေးနေ့ထည့်ထားသော ရောက်ရှိခဲ့သူ {known} ဦးထဲမှ။"),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("နေ့စဉ် ရောက်ရှိခဲ့သူများ"),
      "ins_communities": MessageLookupByLibrary.simpleMessage(
          "သူတို့ပါဝင်သော အသိုင်းအဝိုင်းများ"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("နိုင်ငံများ"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "ပရိုဖိုင်တွင် နိုင်ငံပါရှိသော ရောက်ရှိခဲ့သည့် လူ {known} ဦးထံမှ။"),
      "ins_days": MessageLookupByLibrary.simpleMessage("နောက်ဆုံး {days} ရက်"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "ထိုးထွင်းသိမြင်မှုများကို ဖွင့်၍မရပါ"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("နောက်လိုက်များ"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "ပြသလောက်အောင် ကြီးသောအုပ်စု မရှိသေးပါ။"),
      "ins_grow": MessageLookupByLibrary.simpleMessage("ကြီးထွားနည်း"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("သူတို့လိုက်သော ခေါင်းစဉ်များ"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("နှစ်သက်မှုများ"),
      "ins_new": MessageLookupByLibrary.simpleMessage("အသစ်"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("နောက်လိုက်အသစ်များ"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "ဤကာလအတွင်း သင့်ပို့စ်တစ်ခုမှ မည်သူ့ထံမျှ မရောက်ခဲ့ပါ။"),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("သင့်ကို မလိုက်သူများ"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "နိုင်ငံများသည် လူများ ၎င်းတို့၏ ပရိုဖိုင်တွင် ရွေးချယ်ထားသည်များ ဖြစ်သည်။ Kyron သည် မည်သူ၏ မြို့ သို့မဟုတ် လိင်ကိုမျှ မစုဆောင်းသဖြင့် ၎င်းတို့အတွက် ပြစရာ မရှိပါ။"),
      "ins_opens": MessageLookupByLibrary.simpleMessage("ဖွင့်ကြည့်မှုများ"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} ရောက် · နှစ်သက်မှု {likes} · ပြန်စာ {replies}"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("ရောက်ရှိခဲ့သူများ"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "လူတစ်ဦးကို တစ်ကြိမ်သာ ရေတွက်သည်- သင့်ပို့စ်တစ်ခုကို ပထမဆုံးအကြိမ် ပြသခံရသူ သို့မဟုတ် ဖွင့်ကြည့်သူ။ နောက်လိုက်အသစ်များသည် သင့်ကို ဆက်လက်လိုက်နေဆဲဖြစ်ပြီး လိုက်ခြင်းရပ်သူများကို မရေတွက်ပါ။"),
      "ins_replies": MessageLookupByLibrary.simpleMessage("ပြန်စာများ"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("ပြန်တင်မှုများ"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("သိမ်းဆည်းမှုများ"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "ဤကာလအတွင်း လူ {floor} ဦး သင့်ပို့စ်များကို မြင်ပြီးမှ သင့်ပရိသတ်မည်သူဖြစ်ကြောင်း ပြသပါမည်။ ထိုထက်နည်းပါက တစ်စုံတစ်ယောက်ကို ညွှန်ပြနိုင်သည်။"),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("လူအရေအတွက် မလုံလောက်သေးပါ"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "၎င်းတို့ထဲမှ {pct}% သည် သင့်ကို လိုက်ပြီးသားဖြစ်သည်- သင့်ပို့စ်များသည် အများအားဖြင့် သိကျွမ်းသူများထံ ရောက်သည်။"),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "၎င်းတို့ထဲမှ {pct}% သည် သင့်ကို မလိုက်သေးပါ- သင့်ပို့စ်များကို ရှာတွေ့နေကြသည်။"),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "လူ {reach} ဦးထံ ရောက်ခဲ့သည်၊ ယခင်ကာလထက် {pct}% လျော့သည်။"),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "နောက်ဆုံး {days} ရက်အတွင်း လူ {reach} ဦးထံ ရောက်ခဲ့သည်။"),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "လူ {reach} ဦးထံ ရောက်ခဲ့သည်၊ ယခင်ကာလနှင့် ခန့်မှန်းတူသည်။"),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "နောက်ဆုံး {days} ရက်အတွင်း မည်သူအသစ်မျှ သင့်ပို့စ်များကို မမြင်ခဲ့ပါ။"),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "လူ {reach} ဦးထံ ရောက်ခဲ့သည်၊ ယခင်ကာလထက် {pct}% ပိုသည်။"),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "လူ {reach} ဦးထံ ရောက်ခဲ့သည်၊ ယခင်ကာလ၏ {times}×။"),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "အခြားခေါင်းစဉ်များထက် {name} ကို ပိုလိုက်ကြသည်။"),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("ပရိသတ်"),
      "ins_tab_overview":
          MessageLookupByLibrary.simpleMessage("ခြုံငုံသုံးသပ်ချက်"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "သင့်ပို့စ်ကို တွေ့သူများသည် မလိုက်မီ သင့်ပရိုဖိုင်ကို ကြည့်သည်။ မျက်နှာ သို့မဟုတ် လိုဂိုက ထိုနေရာတွင် တစ်စုံတစ်ယောက်ရှိကြောင်း ပြောပြသည်။"),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("ပရိုဖိုင်ပုံ ထည့်ပါ"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "သင် ဘာအကြောင်းတင်သည်ကို တစ်ကြောင်းတည်းဖြင့် ပြောပါ၊ သူစိမ်းတစ်ဦး သင့်ကိုလိုက်လျှင် ဘာရမည်ကို သိစေရန်။"),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("ကိုယ်ရေးအကျဉ်း ရေးပါ"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "သင့်ပို့စ် {total} ခုထဲမှ {without} ခုတွင် ခေါင်းစဉ်မရှိပါ။ ခေါင်းစဉ်က ပို့စ်ကို ထိုခေါင်းစဉ်၏ ဖိဒ်နှင့် လိုက်သူများရှေ့သို့ ပို့ပေးသည်။"),
      "ins_tip_add_topics_t": MessageLookupByLibrary.simpleMessage(
          "ပို့စ်များတွင် ခေါင်းစဉ်ထည့်ပါ"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "လူ {received} ဦး သင့်ပို့စ်များကို ပြန်စာရေးခဲ့ပြီး သင် {answered} ခုကို ဖြေခဲ့သည်။ ရေးလောက်အောင် ဂရုစိုက်ကြသည်- ဖြေကြားချက်က စာဖတ်သူကို ပုံမှန်လာသူ ဖြစ်စေသည်။"),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("ပြန်စာများကို ဖြေပါ"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "သင့်ပရိသတ်သည် {when} တွင် အတက်ကြွဆုံးဖြစ်သည်။ ထိုမတိုင်မီ အနည်းငယ်တင်သော ပို့စ်တွင် ကြိုဆိုမည့်သူများ ရှိမည်။"),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("သူတို့ရှိချိန်တွင် တင်ပါ"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "သင့်ကို မလိုက်သူ {reached} ဦး သင့်ပို့စ်များကို မြင်ခဲ့ပြီး {gained} ဦး လိုက်ခဲ့သည်။ သင့်ထံမှ ဘာမျှော်လင့်နိုင်သည်ကို ကိုယ်ရေးအကျဉ်းနှင့် နောက်ဆုံးပို့စ်များက ပြောပါစေ။"),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "စာဖတ်သူများကို နောက်လိုက်ဖြစ်စေပါ"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "ပို့စ်တစ်ခုသည် သင့်အခြားပို့စ်များ ပုံမှန်ရောက်သည်ထက် {times}× လူများထံ ရောက်ခဲ့သည်။ ဘာကွဲပြားစွာ လုပ်ခဲ့သည်ကို ကြည့်ပြီး ထိုအရာကို ပိုလုပ်ပါ။"),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("အလုပ်ဖြစ်ခဲ့သည်ကို ပိုလုပ်ပါ"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "သင့်ပို့စ်များကို မြင်သူအများအပြားသည် {name} တွင် ရှိသည်။ ထိုနေရာတွင် တင်ခြင်းက ကျန်သူများရှေ့သို့ပါ ရောက်စေသည်။"),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("{name} တွင် တင်ပါ"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "{days} ရက်အတွင်း {posts} ကြိမ် တင်ခဲ့သည်။ ပို့စ်တိုင်းသည် ရှာတွေ့ခံရရန် အခွင့်အလမ်းတစ်ခုဖြစ်ပြီး ပုံမှန်စည်းချက်က နောက်လိုက်များ၏ ဖိဒ်တွင် သင့်ကို ထားရှိပေးသည်။"),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("ပိုမကြာခဏ တင်ပါ"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "နောက်ဆုံး {days} ရက်အတွင်း မတင်ခဲ့ပါ။ ပို့စ်မရှိဘဲ မည်သည့်အရာမျှ မည်သူ့ထံ မရောက်ပါ။"),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("တစ်ခုခု တင်ပါ"),
      "ins_title":
          MessageLookupByLibrary.simpleMessage("ထိုးထွင်းသိမြင်မှုများ"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("ထိပ်တန်းပို့စ်များ"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "ယခင် {days} ရက်နှင့် နှိုင်းယှဉ်လျှင်"),
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
      "profile_country": MessageLookupByLibrary.simpleMessage("နိုင်ငံ"),
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
      "report": MessageLookupByLibrary.simpleMessage("တိုင်ကြားရန်"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent":
          MessageLookupByLibrary.simpleMessage("တိုင်ကြားချက် ပို့ပြီးပါပြီ"),
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
      "sendReport":
          MessageLookupByLibrary.simpleMessage("တိုင်ကြားချက် ပို့ရန်"),
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
      "tryAgain": MessageLookupByLibrary.simpleMessage("ထပ်စမ်းကြည့်ရန်"),
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
          "ဤကိုးကားချက်သည် လိမ်လည်မှုအကြောင်း လူများကို သတိပေးရန်ဖြစ်သည်။"),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "ဆုံးဖြတ်ချက် မှားသည်ဟု သင်ထင်ရသည့် အကြောင်းကို ပြောပါ- ပို့စ်က ဘာကိုဆိုလိုသနည်း၊ အဖွဲ့က ဘာကို လွတ်သွားနိုင်သနည်း သို့မဟုတ် စည်းမျဉ်းက အဘယ်ကြောင့် မကိုက်ညီသနည်း။ ဆုံးဖြတ်သူမဟုတ်ဘဲ အခြားသူတစ်ဦးက ဖတ်ပါမည်။"),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("သင့်အယူခံ"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "အနည်းဆုံး စာလုံး \$count လုံး ရေးပါ။ ဆုံးဖြတ်ချက်တစ်ခုစီကို တစ်ကြိမ်သာ အယူခံနိုင်သည်။"),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("အယူခံ ပို့ရန်"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "အယူခံ ပို့ပြီးပါပြီ။ ဆုံးဖြတ်ပြီးသည့်အခါ အသိပေးချက် ရရှိပါမည်။"),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("အမှု \$number အတွက် အယူခံ"),
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
          MessageLookupByLibrary.simpleMessage("ဘာအတွက်လဲ (မဖြစ်မနေမဟုတ်)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("စီမံသူများသာ ရေးနိုင်သည်"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "ကြေညာချက်များအတွက်။ အသိုင်းအဝိုင်းရှိ လူတိုင်း ဆက်လက်ဖတ်ရှုပြီး တုံ့ပြန်နိုင်သည်။"),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "ဓာတ်ပုံ သို့မဟုတ် စစ်တမ်း ထည့်ရန်"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံများနှင့် ဗီဒီယိုများ"),
      "ui_cchat_close":
          MessageLookupByLibrary.simpleMessage("ချက်တ်ကို ပိတ်ရန်"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "မည်သူမျှ ယင်းတွင် ဖတ်ရန် သို့မဟုတ် ရေးရန် မရတော့ပါ။ ပြန်ပြင်၍ မရပါ။"),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("ဤချက်တ်ကို ပိတ်မလား။"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("ကူးယူပြီး"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "မက်ဆေ့ချ်ကို လူတိုင်းအတွက် ဖယ်ရှားသည်။ Kyron သည် စိစစ်ရန် မိတ္တူတစ်စောင် သိမ်းထားသည်။"),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "မက်ဆေ့ချ်ကို ချက်တ်ရှိ လူတိုင်းအတွက် ဖယ်ရှားသည်။"),
      "ui_cchat_edit":
          MessageLookupByLibrary.simpleMessage("ချက်တ်ကို တည်းဖြတ်ရန်"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("ပြင်ရန်"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("ပြင်ထားသည်"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("သင့်မက်ဆေ့ချ်ကို ပြင်နေသည်"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("ဤချက်တ်ကို ဖွင့်၍မရပါ။"),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("ချက်တ်များ"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("ချက်တ်သို့ ဝင်ရန်"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "၎င်း၏ ချက်တ်များကို ကြည့်ရှုပြီး ပါဝင်ရန် အသိုင်းအဝိုင်းသို့ ဝင်ပါ။"),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count ဦး ဝင်ထား"),
      "ui_cchat_leave":
          MessageLookupByLibrary.simpleMessage("ချက်တ်မှ ထွက်ရန်"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "အသိုင်းအဝိုင်းထဲ ရှိနေသရွေ့ ဆက်ဖတ်နိုင်ပါသည်။"),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "ဤနေရာတွင် ပိုင်ရှင်နှင့် စီမံသူများသာ ရေးနိုင်သည်။"),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("အသံပိတ်ရန်"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "၎င်းမှ အသိပေးချက်များ မလာတော့ဘဲ မက်ဆေ့ချ်များ အရေအတွက်တွင်လည်း မပါတော့ပါ။"),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("ချက်တ်အမည်"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("ချက်တ်အသစ်"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("ချက်တ် မရှိသေးပါ။"),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "ချက်တ် မရှိသေးပါ။ အသိုင်းအဝိုင်းအတွက် တစ်ခု ဖွင့်ပါ။"),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "အသိုင်းအဝိုင်း ချက်တ်များကို အစမှအဆုံး ကုဒ်ဝှက်မထားပါ။ အသိုင်းအဝိုင်း၏ စီမံသူများနှင့် Kyron ဖတ်နိုင်သည်။"),
      "ui_cchat_pin":
          MessageLookupByLibrary.simpleMessage("အပေါ်ဆုံးတွင် ပင်ထိုးရန်"),
      "ui_cchat_poll_add": MessageLookupByLibrary.simpleMessage("အဖြေ ထည့်ရန်"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("စစ်တမ်း ပိတ်ရန်"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("ပိတ်ပြီး"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "အဖြေတစ်ခုစီကို လူမည်မျှ ရွေးသည်ကို အားလုံးမြင်ရသော်လည်း မည်သူရွေးသည်ကို ဘယ်တော့မှ မမြင်ရပါ။"),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("အများအပြား ရွေးခွင့်ပြုရန်"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("စစ်တမ်းအသစ်"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("တစ်ခု ရွေးပါ"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("အဖြေ \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("စစ်တမ်း- \$question"),
      "ui_cchat_poll_question":
          MessageLookupByLibrary.simpleMessage("မေးခွန်း"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "အဖြေတစ်ခုစီသည် စစ်တမ်းတွင် တစ်ကြိမ်သာ ပါနိုင်သည်။"),
      "ui_cchat_poll_several": MessageLookupByLibrary.simpleMessage(
          "တစ်ခု သို့မဟုတ် ထို့ထက်ပို ရွေးပါ"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count ဦး ဖြေပြီး"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("ဤချက်တ်တွင် ရှာရန်"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("ဤချက်တ်တွင် ရှာရန်"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("ဘာမှ မတွေ့ပါ။"),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("ဤချက်တ်ကို သင် မမြင်ရတော့ပါ။"),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("နှေးကွေးမုဒ်"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "မက်ဆေ့ချ်များကြား မည်မျှ စောင့်ရမည်။ စီမံသူများနှင့် မသက်ဆိုင်ပါ။"),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 နာရီ"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n မိနစ်"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "နှေးကွေးမုဒ်- \$seconds စက္ကန့်တိုင်း မက်ဆေ့ချ်တစ်စောင်"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("ပိတ်"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n စက္ကန့်"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "ကြည့်ရှုသူအဖြစ် ဖတ်ရှုပြီး တုံ့ပြန်နိုင်သည်။ ရေးရန် ဝင်ပါ။"),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "ထိုမက်ဆေ့ချ်သည် ပြသရန် အလွန်ဟောင်းနေသည်။"),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "သင်ရွေးထားသည့်အရာတစ်ခုသည် ပို့ရန် အလွန်ကြီးသဖြင့် ချန်ထားခဲ့သည်။"),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("အသံဖွင့်ရန်"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("ပင်ဖြုတ်ရန်"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("အသံမက်ဆေ့ချ် မှတ်တမ်းတင်ရန်"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("သင်"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("ပို့စ်များ-"),
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
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("အဖွဲ့များ"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("အဖွဲ့ မရှိပါ"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "သင်ပါဝင်သော အဖွဲ့များနှင့် သင်ဝင်ရောက်သော အသိုင်းအဝိုင်း ချက်တ်များကို ဤနေရာတွင် ပြသည်။"),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "ချတ်များကို \$count ခုအထိ ပင်ထိုးနိုင်သည်။ တစ်ခုကို အရင် ပင်ဖြုတ်ပါ။"),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("ပင်ထိုးထားသည်"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("နှစ်သက်သည်"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("သိမ်းထားသည်"),
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
          MessageLookupByLibrary.simpleMessage("မှိန်လာနေသည်"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("စိတ်မဝင်စားပါ"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("ဤကဲ့သို့ ပိုပြပါ"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("ဖယ်ရှားပြီး"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("သင့်ဖိဒ်အချက်ပြမှုများ"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "ပို့စ်ပေါ်ရှိ ဤကဲ့သို့ပို့စ်များ ပိုပြပါ သို့မဟုတ် ဤအရာကို စိတ်မဝင်စားပါ ကို နှိပ်ပါ၊ ၎င်းသည် ဤနေရာတွင် ပေါ်လာမည်။"),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("ဤနေရာတွင် ဘာမျှမရှိသေးပါ"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "ပိုပြပါ နှင့် စိတ်မဝင်စားပါ က သင့်ဖိဒ်များကို ပြောနေသည့်အရာ"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "၎င်းတို့သည် ပင်မနှင့် ရှာဖွေရန်ကို ပို့စ်တစ်ခုချင်းစီ၏ အကြောင်းအရာအလိုက် အဓိကပုံဖော်သည်။ တစ်ခုချင်းစီသည် လစဉ် တစ်ဝက်လျော့ပြီး ခြောက်လအကြာတွင် မရေတွက်တော့ပါ။ ယခုရပ်ရန် တစ်ခုကို ဖယ်ရှားပါ။"),
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
      "ui_group_add": MessageLookupByLibrary.simpleMessage("လူထည့်ရန်"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("ထည့်ရန်"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("အဖွဲ့အမည် ထည့်ရန်"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("ပယ်ရန်"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "ဤအုပ်စုရှိ မက်ဆေ့ချ်များကို အခြားစကားဝိုင်းများကဲ့သို့ပင် အစမှအဆုံး ကုဒ်ဝှက်ထားသည်။"),
      "ui_group_event_added": MessageLookupByLibrary.simpleMessage(
          "\$actor က \$users ကို ထည့်ခဲ့သည်"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor က \$users ကို စီမံသူ ခန့်ခဲ့သည်"),
      "ui_group_event_created": MessageLookupByLibrary.simpleMessage(
          "\$actor က အုပ်စုကို ဖန်တီးခဲ့သည်"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor က လူသစ်များကို အဖွဲ့ဝင်အဖြစ် ပါဝင်စေရန် သတ်မှတ်ခဲ့သည်"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor က လူသစ်များကို ကြည့်ရှုသူအဖြစ် ပါဝင်စေရန် သတ်မှတ်ခဲ့သည်"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor ထွက်သွားသည်"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor က \$users ကို အဖွဲ့ဝင် ခန့်ခဲ့သည်"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor က \$users ကို ပိုင်ရှင် ခန့်ခဲ့သည်"),
      "ui_group_event_removed": MessageLookupByLibrary.simpleMessage(
          "\$actor က \$users ကို ဖယ်ရှားခဲ့သည်"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor က အုပ်စုအမည်ကို \$title သို့ ပြောင်းခဲ့သည်"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor က \$users ကို ကြည့်ရှုသူ ခန့်ခဲ့သည်"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "အုပ်စုတစ်ခုတွင် အများဆုံး \$count ဦး ရှိနိုင်သည်။"),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "လက်ထောင်ပြီးပါပြီ။ စီမံသူများကို အသိပေးပြီးပါပြီ။"),
      "ui_group_hands": MessageLookupByLibrary.simpleMessage(
          "\$count ဦး ရေးခွင့်တောင်းနေသည်"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("ရေးခွင့်တောင်းနေသည်"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "နောက်မှထည့်သူများ ကြည့်ရှုသူအဖြစ် ပါဝင်မည်"),
      "ui_group_leave":
          MessageLookupByLibrary.simpleMessage("အုပ်စုမှ ထွက်ရန်"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "သင့်စာရင်းမှ ပျောက်သွားမည်ဖြစ်ပြီး နောက်ပိုင်းပြောသည်များကို မမြင်ရတော့ပါ။ တစ်စုံတစ်ယောက်က သင့်ကို ပြန်ထည့်ရပါမည်။"),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("ဤအုပ်စုမှ ထွက်မလား။"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("ရေးခွင့်ပေးရန်"),
      "ui_group_lower_hand": MessageLookupByLibrary.simpleMessage("လက်ချရန်"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("စီမံသူ ခန့်ရန်"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("ပိုင်ရှင် ခန့်ရန်"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("ကြည့်ရှုသူ ခန့်ရန်"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("အဖွဲ့ဝင် \$count ဦး"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("အဖွဲ့ဝင်များ"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("အုပ်စုအမည်"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("အဖွဲ့ကို ဦးစွာ အမည်ပေးပါ။"),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("အုပ်စုချက်တ် ဖန်တီးရန်"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "ပိုင်ရှင်သည် တစ်ဦးတည်းသာ ဖြစ်သည်။ သင်သည် စီမံသူအဖြစ် ဆက်ရှိမည်။"),
      "ui_group_owner_title": MessageLookupByLibrary.simpleMessage(
          "\$name ကို ပိုင်ရှင် ခန့်မလား။"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("လက်ထောင်ရန်"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("အုပ်စုမှ ဖယ်ရှားရန်"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("စီမံသူမှ ဖယ်ရန်"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "သင်သည် ဤအုပ်စုတွင် မရှိတော့ပါ။"),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("အမည်ပြောင်းရန်"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("စီမံသူ"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("အဖွဲ့ဝင်"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("ကြည့်ရှုသူ"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "ကြည့်ရှုသူအဖြစ် ဤနေရာတွင် ဖတ်ရှုခြင်းနှင့် တုံ့ပြန်ခြင်း ပြုနိုင်သည်။"),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "ကြည့်ရှုသူများသည် ဖတ်ရှု၊ တုံ့ပြန်ပြီး ရေးခွင့်တောင်းရန် လက်ထောင်နိုင်သည်။"),
      "ui_group_suggested":
          MessageLookupByLibrary.simpleMessage("အကြံပြုထားသည်များ"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("ပရိုဖိုင် ကြည့်ရန်"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("သင်"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("သင်သည် ကြည့်ရှုသူ ဖြစ်သည်"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("သင့်ဘာသာစကားကို ရွေးပါ"),
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
      "ui_notif_account_update": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ကို အပ်ဒိတ်လုပ်ပြီးပါပြီ"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "အမှု \$number အပေါ် သင့်အယူခံကို လက်ခံလိုက်ပါပြီ"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "အမှု \$number အပေါ် သင့်အယူခံကို ထပ်မံစစ်ဆေးခဲ့ပြီး ဆုံးဖြတ်ချက် မပြောင်းလဲပါ"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ကို အပြီးအပိုင် ပိတ်ပင်လိုက်ပါပြီ"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("အမှု \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("က သင့်ကို ဖော်လိုလုပ်ခဲ့သည်"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("က သင့်ပို့စ်ကို ကြိုက်ခဲ့သည်"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("က သင့်ကို ဖော်ပြခဲ့သည်"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("ဖော်ပြချက် မရှိသေးပါ"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "တစ်စုံတစ်ယောက်က ပို့စ် သို့မဟုတ် ပြန်စာတွင် သင့် @အမည်ကို ရေးသောအခါ ဤနေရာတွင် ပေါ်လာမည်။"),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("ယခင်က"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "အသိုင်းအဝိုင်း ချက်တ်ထဲရှိ သင့်မက်ဆေ့ချ်ကို ဖယ်ရှားလိုက်ပါပြီ"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "သင်တင်ခဲ့သော တစ်ခုခုကို ဖယ်ရှားလိုက်ပါပြီ"),
      "ui_notif_removed_post": MessageLookupByLibrary.simpleMessage(
          "သင့်ပို့စ်ကို ဖယ်ရှားလိုက်ပါပြီ"),
      "ui_notif_removed_reply": MessageLookupByLibrary.simpleMessage(
          "သင့်ပြန်စာကို ဖယ်ရှားလိုက်ပါပြီ"),
      "ui_notif_replied": MessageLookupByLibrary.simpleMessage(
          "က သင့်ပို့စ်ကို ပြန်စာရေးခဲ့သည်"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "သင်တိုင်ကြားခဲ့သည့်အရာအပေါ် ကျွန်ုပ်တို့ အရေးယူခဲ့ပါသည်။ အသိပေးသည့်အတွက် ကျေးဇူးတင်ပါသည်။"),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "သင်တိုင်ကြားခဲ့သည့်အရာကို စစ်ဆေးခဲ့ပြီး ကျွန်ုပ်တို့၏ စည်းမျဉ်းများကို ချိုးဖောက်သည်ဟု မတွေ့ရှိပါ။"),
      "ui_notif_reported_for": MessageLookupByLibrary.simpleMessage(
          "တိုင်ကြားရသည့်အကြောင်းရင်း- \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("က သင့်ပို့စ်ကို ပြန်တင်ခဲ့သည်"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "အမှု \$number ၏ ဆုံးဖြတ်ချက်ကို ပြန်လည်ရုပ်သိမ်းလိုက်ပါပြီ"),
      "ui_notif_suspended": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ကို ဆိုင်းငံ့ထားသည်"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ကို \$date အထိ ဆိုင်းငံ့ထားသည်"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("အားလုံး"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("ဖော်လိုများ"),
      "ui_notif_tab_likes":
          MessageLookupByLibrary.simpleMessage("ကြိုက်နှစ်သက်မှုများ"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("ဖော်ပြချက်များ"),
      "ui_notif_tab_replies":
          MessageLookupByLibrary.simpleMessage("ပြန်စာများ"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("ဤအပတ်"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("ယနေ့"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်တွင် သတိပေးချက်ရှိသည်"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("မနေ့က"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("ဤအရာကို ဖွင့်ပြီးပါပြီ။"),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("သက်တမ်းကုန်ပြီ"),
      "ui_once_failed": MessageLookupByLibrary.simpleMessage("ဖွင့်၍ မရပါ။"),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "တစ်ကြိမ်သာ ဖွင့်နိုင်ပြီး ထို့နောက် Kyron မှ ဖျက်ပစ်မည်။"),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("တစ်ကြိမ်ကြည့်"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("ဖွင့်ပြီး"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "\$total ဦးအနက် \$count ဦး ဖွင့်ပြီး"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "သင်ပို့သူများသာ တစ်ကြိမ် ဖွင့်နိုင်သည်။"),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("တစ်ကြိမ်ကြည့်ရန် ပို့ရန်"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("ကြည့်ရန် နှိပ်ပါ"),
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
          "ထပ်ဖြည့်စရာ ရှိပါသလား။ (ရွေးချယ်နိုင်)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "အဖွဲ့က ဆုံးဖြတ်သည့်အခါ အသိပေးချက် ရရှိမည်ဖြစ်ပြီး သင့်တိုင်ကြားချက်များတွင် ဆက်လက်ကြည့်ရှုနိုင်သည်။"),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "ဤသူကိုလည်း ထပ်မမြင်လိုပါက တူညီသည့်မီနူးမှ အသံပိတ်ခြင်း သို့မဟုတ် ပိတ်ဆို့ခြင်း ပြုလုပ်နိုင်သည်။"),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "တူညီသည့်အရာကို နှစ်ကြိမ် တိုင်ကြားခြင်းက ပိုအလေးမပေးပါ- လူတစ်ဦးလျှင် တိုင်ကြားချက်တစ်ခုသာ သိမ်းထားပါသည်။"),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "သင့်တိုင်ကြားချက်ကို ထိုသူထံ မျှဝေမည်မဟုတ်ပါ။ ဖျက်လိုက်သော်လည်း ပြန်လည်စစ်ဆေးနိုင်ရန် သင်တိုင်ကြားခဲ့သည့်အရာ၏ မိတ္တူကို သိမ်းထားပါသည်။"),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "သင့်တိုင်ကြားချက်ကို လက်ခံရရှိပြီး စစ်ဆေးရန် စောင့်ဆိုင်းနေပါသည်။ မည်သူ တိုင်ကြားသည်ကို ထိုသူအား မပြောပါ။"),
      "ui_report_see_reports": MessageLookupByLibrary.simpleMessage(
          "သင့်တိုင်ကြားချက်များကို ကြည့်ရန်"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("ဘာမှားနေသည်ကို ပြောပြပါ"),
      "ui_report_thanks": MessageLookupByLibrary.simpleMessage(
          "ပြောပြပေးသည့်အတွက် ကျေးဇူးတင်ပါသည်"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("\$name တွင် ဘာပြဿနာရှိသနည်း။"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "ဤမက်ဆေ့ချ်တွင် ဘာပြဿနာရှိသနည်း။"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("ဤပို့စ်တွင် ဘာပြဿနာရှိသနည်း။"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("ဤပြန်စာတွင် ဘာပြဿနာရှိသနည်း။"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "အသိုင်းအဝိုင်း ချက်တ် မက်ဆေ့ချ်တစ်ခု"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("ပို့စ်တစ်ခု"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("ပြန်စာတစ်ခု"),
      "ui_reports_actioned": MessageLookupByLibrary.simpleMessage("အရေးယူပြီး"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("အကောင့်တစ်ခု"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("ဆုံးဖြတ်သည့်ရက် \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("စည်းမျဉ်း မချိုးဖောက်ပါ"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "သင့်တိုင်ကြားချက်များကို ဖွင့်၍မရပါ"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "ပြီးခဲ့သော ရက် 90 အတွင်း သင်တိုင်ကြားခဲ့သည့်အရာများနှင့် ရလဒ်။ အဖွဲ့က ဆုံးဖြတ်သည့်အခါ အသိပေးချက် ရရှိသည်။ သင်တိုင်ကြားသူကို မည်သူတိုင်ကြားသည်ကို ဘယ်တော့မှ မပြောပါ။"),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("တိုင်ကြားချက် မရှိပါ"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "ပို့စ်၊ ပြန်စာ၊ မက်ဆေ့ချ် သို့မဟုတ် အကောင့်ကို တိုင်ကြားသည့်အခါ ၎င်းကို ရလဒ်နှင့်အတူ ဤနေရာတွင် ပြသည်။"),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("စစ်ဆေးနေသည်"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("တိုင်ကြားသည့်ရက် \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "သင်တိုင်ကြားခဲ့သည့်အရာများနှင့် ရလဒ်"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("သင့်တိုင်ကြားချက်များ"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("ကလေးသူငယ် ဘေးကင်းရေး"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "အရွယ်မရောက်သေးသူကို အန္တရာယ်ဖြစ်စေသည့် သို့မဟုတ် လိင်ပိုင်းဆိုင်ရာ အသုံးချသည့် မည်သည့်အရာမဆို။"),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "ပစ်မှတ်ထား နှောင့်ယှက်ခြင်း၊ ခြိမ်းခြောက်ခြင်း သို့မဟုတ် မလိုလားသော ဆက်သွယ်မှု။"),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "လူများကို ၎င်းတို့မည်သူဖြစ်သည့်အတွက် တိုက်ခိုက်ခြင်း။"),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "တရားမဝင်သည့်အရာကို ရောင်းချခြင်း သို့မဟုတ် မြှင့်တင်ခြင်း။"),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("အခြားသူအဖြစ် ဟန်ဆောင်ခြင်း။"),
      "ui_rule_detail_intellectual_property": MessageLookupByLibrary.simpleMessage(
          "သင့်လက်ရာ သို့မဟုတ် ကုန်အမှတ်တံဆိပ်ကို ခွင့်ပြုချက်မရှိဘဲ အသုံးပြုသည်။"),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "ကျန်းမာရေး၊ ရွေးကောက်ပွဲ သို့မဟုတ် ဖြစ်ရပ်များအကြောင်း လွဲမှားစေသော ပြောဆိုချက်များ။"),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "ကိုယ့်ကိုယ်ကို ထိခိုက်စေခြင်းကို အားပေးခြင်း သို့မဟုတ် ပြသခြင်း။"),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "သတိပေးချက်မပါဘဲ ပြသသည့် လိင်ပိုင်းဆိုင်ရာ အကြောင်းအရာ။"),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "အထက်ပါတစ်ခုမှ မဟုတ်ပါ။ ဘာမှားနေသည်ကို ပြောပြပါ။"),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "ထပ်ခါထပ်ခါ၊ လွဲမှားစေသော သို့မဟုတ် မလိုလားသော ကြော်ငြာခြင်း။"),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "အကြမ်းဖက်မှုဖြင့် ခြိမ်းခြောက်ခြင်း၊ ချီးမွမ်းခြင်း သို့မဟုတ် လှုံ့ဆော်ခြင်း။"),
      "ui_rule_harassment": MessageLookupByLibrary.simpleMessage(
          "နှောင့်ယှက်ခြင်း သို့မဟုတ် အနိုင်ကျင့်ခြင်း"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("အမုန်းစကား"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "တရားမဝင် ကုန်ပစ္စည်း သို့မဟုတ် ဝန်ဆောင်မှု"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("အယောင်ဆောင်ခြင်း"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("ဉာဏပစ္စည်း"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("မှားယွင်းသော သတင်းအချက်အလက်"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "မိမိကိုယ်ကို သတ်သေခြင်း သို့မဟုတ် ထိခိုက်စေခြင်း"),
      "ui_rule_sexual_content": MessageLookupByLibrary.simpleMessage(
          "အရွယ်ရောက်သူများအတွက် အကြောင်းအရာ"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("အခြားတစ်ခုခု"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("စပမ်"),
      "ui_rule_violence": MessageLookupByLibrary.simpleMessage(
          "အကြမ်းဖက်မှု သို့မဟုတ် ခြိမ်းခြောက်မှု"),
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
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("ကိုးကားရန်"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်ဖြင့် ပို့ရန်"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron ရှိ လူများထံ"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Share this post"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("ဘာအကြောင်းဖြစ်ခဲ့သနည်း"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ကို အပြီးအပိုင် ပိတ်ပင်ထားသည်"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("အဖြေ၊ \$date တွင်-"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("အယူခံ"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("ဤဆုံးဖြတ်ချက်ကို အယူခံရန်"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "ဤဆုံးဖြတ်ချက်ကို အယူခံ၍ မရတော့ပါ။ တစ်ခုခု မှားနေပါက အကူအညီဌာနကို ဆက်သွယ်ပါ။"),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("အယူခံကို စစ်ဆေးနေသည်"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("အယူခံကို လက်ခံလိုက်သည်"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "အဖွဲ့ထဲမှ အခြားသူတစ်ဦးက ပြန်လည်စစ်ဆေးနေပါသည်။ ဆုံးဖြတ်ပြီးသည့်အခါ အသိပေးချက် ရရှိပါမည်။"),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "ဤသည်မှာ အမှားဟု ထင်ပါက \$date အထိ ပြန်လည်စစ်ဆေးရန် တောင်းဆိုနိုင်သည်။ အဖွဲ့ထဲမှ အခြားသူတစ်ဦးက ဆုံးဖြတ်ပါမည်။"),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "အယူခံပြီး- ဆုံးဖြတ်ချက် ဆက်လက်တည်သည်"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "အမှု \$number။ စည်းမျဉ်း- \$rule။ အဖွဲ့က ရေးသားသည်-"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "အကောင့်ကို ဖျက်လိုက်ခြင်းဖြင့် ပိတ်ပင်မှု မပြေပါ- တူညီသည့်အီးမေးလ်လိပ်စာဖြင့် အကောင့်အသစ်သည်လည်း ပိတ်ပင်ထားသည့်အခြေအနေဖြင့် စတင်ပါမည်။"),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("အပြီးအပိုင် ပိတ်ပင်ထားသည်"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "ဤစာမျက်နှာ၊ အယူခံများ၊ အကူအညီနှင့် အကောင့်ဖျက်ခြင်းသာ ဆက်လက်အလုပ်လုပ်ပါသည်။"),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("အယူခံနိုင်သည်"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("အမှု \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("\$date တွင် ဆုံးဖြတ်ခဲ့သည်"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ဆိုင်ရာ ဆုံးဖြတ်ချက်များ"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("သင့်အကောင့်ကို ဖျက်ရန်"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("အသေးစိတ် ကြည့်ရန်"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("အသေးစိတ်ကြည့်ပြီး အယူခံရန်"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("\$date တွင် ပြီးဆုံးမည်"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့် အခြေအနေကောင်းပါသည်"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("မည်သည့်ကန့်သတ်ချက်မှ မရှိပါ။"),
      "ui_standing_load_failed":
          MessageLookupByLibrary.simpleMessage("အကောင့်အခြေအနေကို ဖွင့်၍ မရပါ"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်ကို ဖယ်ရှားလိုက်သည်"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်နှင့်ပတ်သက်၍ မည်သည့်ဆုံးဖြတ်ချက်မှ မချရသေးပါ။ အဖွဲ့က သင့်အရာတစ်ခုခုကို ဖယ်ရှားခြင်း သို့မဟုတ် သင့်အကောင့်ကို ကန့်သတ်ခြင်း ပြုလုပ်ပါက အကြောင်းရင်းနှင့်အတူ ဤနေရာတွင် ပြသမည်ဖြစ်ပြီး သင် အယူခံနိုင်ပါသည်။"),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "အယူခံစရာ မရှိပါ- ဆုံးဖြတ်ချက်ကို ပယ်ဖျက်လိုက်ပါပြီ။"),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("ပို့စ်ကို ဖယ်ရှားလိုက်သည်"),
      "ui_standing_pull_to_check":
          MessageLookupByLibrary.simpleMessage("ပြန်စစ်ရန် အောက်သို့ ဆွဲချပါ။"),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Kyron စည်းမျဉ်းများကို ဖတ်ရန်"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("ပြန်စာကို ဖယ်ရှားလိုက်သည်"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("ပယ်ဖျက်ပြီး"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "\$date တွင် ပယ်ဖျက်ခဲ့သည်။ ဖယ်ရှားခဲ့သည့်အရာအားလုံး ပြန်ရောက်လာပြီး မည်သည့်ကန့်သတ်ချက်မှ မသက်ရောက်တော့ပါ။"),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("စည်းမျဉ်း- \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("ထွက်ရန်"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("ဆိုင်းငံ့ထားသည်"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "ဖတ်ရှုနိုင်သော်လည်း ပို့စ်တင်ခြင်း၊ ပြန်စာရေးခြင်း၊ ဖောလိုလုပ်ခြင်း သို့မဟုတ် မက်ဆေ့ချ်ပို့ခြင်း မပြုလုပ်နိုင်ပါ။ တိုင်ကြားခြင်း၊ ပိတ်ဆို့ခြင်းနှင့် အသံပိတ်ခြင်းတို့ ဆက်လက်အလုပ်လုပ်ပါသည်။"),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ကို ဆိုင်းငံ့ထားသည်- ဖတ်ရှုနိုင်သော်လည်း ပို့စ်တင်၍ မရပါ။"),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("\$date အထိ ဆိုင်းငံ့ထားသည်"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ကို \$date အထိ ဆိုင်းငံ့ထားသည်- ဖတ်ရှုနိုင်သော်လည်း ပို့စ်တင်၍ မရပါ။"),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("အဖွဲ့ ရေးသားခဲ့သည့်အရာ"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("အကောင့်အခြေအနေ"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("သတိပေးချက်"),
      "ui_standing_why":
          MessageLookupByLibrary.simpleMessage("အဘယ်ကြောင့်နည်း။"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("သင် \$date တွင် ရေးခဲ့သည်-"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("သင့်မက်ဆေ့ချ်"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("သင့်ပို့စ်"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("သင့်ပြန်စာ"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("ထပ်စမ်းကြည့်ရန်"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Two characters or more.",
      ),
      "ui_undo": MessageLookupByLibrary.simpleMessage("ပြန်ဖျက်ရန်"),
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
        "ဘာဖြစ်ခဲ့သနည်း၊ ကျွန်ုပ်တို့ ဘာကို ကြည့်သင့်သနည်း။",
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
          MessageLookupByLibrary.simpleMessage("သင် ပြန်စာပို့ခဲ့သည်"),
      "dmReplied": (Object a0) => "$a0 ပြန်စာပို့ခဲ့သည်",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်ထဲ ထည့်ရန်"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်အသစ်"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "ဘာမှ မပြောရသေးပါ။ လက်ပြခြင်းသည် ကောင်းမွန်သော အစတစ်ခုဖြစ်သည်။"),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  လက်ပြရန်"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်အသစ်များ"),
      "dmTyping": (Object a0) => "$a0 စာရိုက်နေသည်",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("သင့်တုံ့ပြန်မှုကို ဖယ်ရှားရန်"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("တစ်စုံတစ်ယောက်"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("ပူးတွဲဖိုင်"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "ဤမက်ဆေ့ချ်ကို ဤစက်ပေါ်တွင် ဖတ်၍မရပါ။"),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "ဤမက်ဆေ့ချ်ကို စောင့်နေသည်။ အချိန်အနည်းငယ် ကြာနိုင်ပါသည်။"),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("ကုဒ်ဝှက်ထားသော မက်ဆေ့ချ်"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "မက်ဆေ့ချ်များကို အစမှအဆုံး ကုဒ်ဝှက်ထားသည်"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("အစမှအဆုံး ကုဒ်ဝှက်မထားပါ"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("ပို့ပြီး"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("မြင်ပြီး"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("ပို့နေသည်…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံရိုက်ရန်"),
      "ui_media_more":
          MessageLookupByLibrary.simpleMessage("နောက်ထပ် ရွေးချယ်စရာများ"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("စက်ထဲ သိမ်းရန်"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("မျှဝေရန်"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("သိမ်းနေသည်…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("သင့်ဓာတ်ပုံများထဲ သိမ်းပြီး"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "မသိမ်းနိုင်ပါ။ ထပ်စမ်းကြည့်ပါ။"),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "၎င်းကို သိမ်းရန် Kyron ကို သင့်ဓာတ်ပုံများထဲ ထည့်ခွင့်ပြုပါ။"),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("စနစ်အားလုံး လည်ပတ်နေသည်"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("လည်ပတ်ချိန်"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("နောက်ဆုံး ရက် 60"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("ရက် 60 ကြာခဲ့ပြီ"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("ယနေ့"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("ဒေတာဘေ့စ်"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("အကောင့်ဝင်ခြင်း"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("မကြာသေးမီ ဖြစ်ရပ်များ"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "နောက်ဆုံး ရက် 60 အတွင်း ဖြစ်ရပ်မရှိပါ။"),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("ဆက်ဖြစ်နေသည်"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("ဒေတာမရှိ"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("အသေးစိတ်"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron သည် လည်ပတ်နေစဉ် 5 မိနစ်တိုင်း မိမိကိုယ်ကို စစ်ဆေးသည်။ မီးခိုးရောင်နေ့တွင် စစ်ဆေးမှု မရှိခဲ့ပါ။"),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "လည်ပတ်ချိန်မှတ်တမ်း မရရှိနိုင်သေးပါ။"),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("စနစ်အချို့တွင် ပြဿနာရှိနေသည်"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("အသံမှတ်စု မှတ်တမ်းတင်ရန်"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("ပို့ရန် အသင့်ဖြစ်ပြီ"),
      "ui_dm_quote_gone": MessageLookupByLibrary.simpleMessage(
          "ထိုမက်ဆေ့ချ် ဤနေရာတွင် မရှိတော့ပါ။"),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်သို့ သွားရန်"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("အသံမှတ်စု"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("ရေးသူက နှစ်သက်သည်"),
      "ui_add_photo_or_clip": MessageLookupByLibrary.simpleMessage(
          "ဓာတ်ပုံ သို့မဟုတ် ကလစ် ထည့်ရန်"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("မီဒီယာ"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("အသံမှတ်စုများ"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("ချက်"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("နောက်ခံပုံ"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("အသိပေးချက်များကို အသံပိတ်ရန်"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "ဤစကားဝိုင်းနှင့်ပတ်သက်သော အသိပေးချက်များ ရပ်ရန်"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "သူတို့ သင့်ထံ မက်ဆေ့ချ် ပို့၍ မရတော့ပါ"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("မရှိ"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံ"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("အသံပြန်ဖွင့်ပြီး။"),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "ဖယ်ရှား၍ မရပါ။ ထပ်စမ်းကြည့်ပါ။"),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("ပရိုဖိုင်"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("အသံပြန်ဖွင့်ရန်"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "သင်မျှဝေသော ဓာတ်ပုံနှင့် ကလစ်များ ဤနေရာတွင် ပေါ်လာမည်။"),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("အားလုံးကြည့်ရန်"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံနှင့် ကလစ်များ"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("သင့်ချက်သည် ဤသို့ ပေါ်လာမည်။"),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("ကြည့်ကောင်းပါသည်။"),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("မြူ"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("ဆည်းဆာ"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("စိမ်းနု"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("သဲ"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("အစက်များ"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("အသုံးပြုရန်"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("လက်ရှိ"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("အစမ်းကြည့်ရှုမှုမပါဘဲ ပို့ရန်"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("ရှာရန်"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("ပို့စ်တင်ရန်"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ် ရေးပါ…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("ပို့ရန်"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("ပို့ပြီး"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "ပို့ပြီးပါပြီ၊ သို့သော် လူတိုင်းထံ မရောက်ပါ။"),
      "ui_share_failed":
          MessageLookupByLibrary.simpleMessage("ပို့၍ မရပါ။ ထပ်စမ်းကြည့်ပါ။"),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("စစ်ထုတ်ရန်"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("အားလုံး"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("မဖတ်ရသေး"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("မပြန်ရသေး"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("ဝှက်ထားသည်"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("ဝှက်ထားသည့်အရာ မရှိပါ"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "စာရင်းမှ ဖယ်ထားသော စကားဝိုင်းများသည် ပြန်လိုချင်ပါက ဤနေရာတွင် စောင့်နေပါသည်။"),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "၎င်းသည် ဝှက်ထားသည်သို့ ရွှေ့သွားပါမည်။ တစ်ဖက်လူက သူ့ဟာကို သိမ်းထားပြီး သင်တို့ထဲမှ တစ်ယောက်ယောက် ထပ်ရေးလျှင် ပြန်ပေါ်လာပါမည်။"),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("ပြန်ထည့်ရန်"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("သင့်စာရင်းထဲ ပြန်ရောက်ပါပြီ။"),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("ကိုက်ညီသော စကားဝိုင်း မရှိပါ။"),
      "ui_dm_unanswered_none": MessageLookupByLibrary.simpleMessage(
          "သင့်ကို စောင့်နေသည့်အရာ မရှိပါ"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "စကားဝိုင်းတိုင်း သင့်စကားဖြင့် အဆုံးသတ်ထားပါသည်။"),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံ"),
      "ui_dm_preview_photos":
          MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံများ"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("ဗီဒီယို"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ် မရှိသေးပါ"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("သင်-"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("မနေ့က"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်များ"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ် ဆက်တင်များ"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("ကိုယ်ရေးလုံခြုံမှု"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("ဖတ်ပြီးကြောင်း အသိပေးချက်"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "ပိတ်ထားလျှင် သင်သူတို့၏ မက်ဆေ့ချ်ကို ဖတ်ပြီးကြောင်း အခြားသူများ မမြင်ရဘဲ သူတို့ သင့်ဟာကို ဖတ်ပြီးကြောင်းလည်း သင် မမြင်ရပါ။"),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("စာရိုက်နေချိန် ပြရန်"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "သင်ရေးနေသူက သင်ရေးနေကြောင်း မြင်ရပါသည်။"),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("လင့်ခ် အစမ်းကြည့်ရှုမှု"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "အစမ်းကြည့်ရှုမှု ပြုလုပ်ရန် သင့်ဖုန်းက သင်ပို့သော လင့်ခ်ကို ဖွင့်သဖြင့် ဆိုက်က သင့်ဖုန်း၏ တောင်းဆိုမှုကို မြင်ရပါသည်။ Kyron ၏ ဆာဗာက လင့်ခ်ကို ဘယ်တော့မှ မမြင်ရပါ။"),
      "ui_dm_settings_notifications": MessageLookupByLibrary.simpleMessage(
          "မက်ဆေ့ချ် အကြောင်းကြားချက်များ"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "မက်ဆေ့ချ်များကို အစမှအဆုံး ကုဒ်ပြောင်းထားပါသည်။ Kyron ဖတ်၍ မရနိုင်ပြီး ဤနေရာရှိ မည်သည့်အရာကမျှ ၎င်းကို မပြောင်းလဲပါ။"),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("သို့-"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("မကြာသေးမီက"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("လူများ"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("ထိုအမည်ဖြင့် မည်သူမျှ မရှိပါ။"),
      "ui_push_test": MessageLookupByLibrary.simpleMessage(
          "စမ်းသပ်အကြောင်းကြားချက် ပို့ရန်"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron ၏ ဆာဗာကို အကြောင်းကြားချက် ပို့ရန် မသတ်မှတ်ရသေးသဖြင့် မည်သည့်အကြောင်းကြားချက်မျှ ရောက်မလာနိုင်ပါ။ ပြဿနာသည် ကျွန်ုပ်တို့ဘက်တွင် ရှိပြီး သင့်ဖုန်းတွင် မဟုတ်ပါ။"),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "ဤဖုန်းကို အကြောင်းကြားချက်များအတွက် မှတ်ပုံမတင်ရသေးပါ။ ဖုန်းဆက်တင်တွင် Kyron အတွက် အကြောင်းကြားချက်များ ခွင့်ပြုထားကြောင်း စစ်ဆေးပြီး ထပ်စမ်းကြည့်ပါ။"),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "အကြောင်းကြားချက်ကို ဤဖုန်းသို့ ပို့၍ မရပါ။ တစ်မိနစ်အကြာတွင် ထပ်စမ်းကြည့်ပါ။"),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "ပို့ပြီးပါပြီ။ စက္ကန့်အနည်းငယ်အတွင်း ရောက်လာသင့်ပါသည်။"),
      "ui_push_working": MessageLookupByLibrary.simpleMessage(
          "အကြောင်းကြားချက်များ အလုပ်လုပ်နေပါသည်။"),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("ပို့စ်များ မရှိသေးပါ"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်းအသစ်"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("အမည်"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "၎င်း၏လိပ်စာကို အမည်မှ ပြုလုပ်သည်။"),
      "ui_community_address": MessageLookupByLibrary.simpleMessage(
          "လူများ ၎င်းကို ဤနေရာတွင် တွေ့ပါမည်-"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "သင်သည် ပိုင်ရှင်ဖြစ်မည်။ ဖန်တီးပြီးနောက် ၎င်း၏စာမျက်နှာမှ ပုံ၊ နဖူးစည်းနှင့် စီမံသူများ ထည့်နိုင်သည်။"),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("ပင်မ"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "ပင်မတွင် အသိုင်းအဝိုင်းပို့စ်များ"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "သင့်အသိုင်းအဝိုင်းများမှ ပို့စ်များသည် ပင်မတွင်လည်း ပေါ်သည်။ ပိတ်ထားလျှင် ဤနေရာ အသိုင်းအဝိုင်းများတွင်သာ ကျန်ပြီး တစ်ခုချင်းစီက အသစ်ကို ပြသည်။"),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("သင့်စာရင်း"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("ပို့စ်အသစ် အရေအတွက်"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "နောက်ဆုံးဖွင့်ပြီးကတည်းက အသိုင်းအဝိုင်းတစ်ခုစီတွင် ပို့စ်အသစ် ဘယ်နှစ်ခုရှိသည်ကို ပြပါ။"),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("သင်စီမံသော အသိုင်းအဝိုင်းများ"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "သင်စတင်သော သို့မဟုတ် စီမံသော အသိုင်းအဝိုင်းများကို ဤနေရာတွင် ဖော်ပြထားသည်။"),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("ပိုင်ရှင်"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("စီမံသူ"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("ပို့စ်အသစ်များ"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("သင်စီမံသည်များ"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်း ဆက်တင်များ"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("ရှာဖွေရန်"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "ကိုက်ညီသော အသိုင်းအဝိုင်း မရှိပါ။"),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("အသစ် မရှိပါ"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "အသိုင်းအဝိုင်းတိုင်း သင်ထားခဲ့သည့်အတိုင်း ရှိသည်။"),
      "ui_community_running_none": MessageLookupByLibrary.simpleMessage(
          "သင် မည်သည့်တစ်ခုကိုမျှ မစီမံရသေးပါ"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("ဝင်ရန် ဘာမျှ မကျန်တော့ပါ"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "သင်သည် Kyron ရှိ အသိုင်းအဝိုင်းတိုင်းတွင် ရှိနေသည်။ နောက်တစ်ခု စတင်ပါ။"),
      "ui_community_discover_search_detail": MessageLookupByLibrary.simpleMessage(
          "အခြားစကားလုံး စမ်းကြည့်ပါ သို့မဟုတ် ထိုအမည်ဖြင့် အသိုင်းအဝိုင်း စတင်ပါ။"),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("ပို့စ် ရေးရန်"),
      "ui_community_members":
          MessageLookupByLibrary.simpleMessage("အဖွဲ့ဝင်များ-"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("တင်ပြီးပါပြီ"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("ကြည့်ရန်"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("ဖွင့်ရန်"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("အွန်လိုင်း"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("အွန်လိုင်းဖြစ်နေချိန် ပြရန်"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "သင် မက်ဆေ့ချ်ပို့သူများသည် သင် Kyron ဖွင့်ထားချိန်တွင် အစိမ်းရောင်အစက်ကို မြင်ရပါသည်။ ပိတ်ထားလျှင် သူတို့၏ အစက်ကိုလည်း သင် မမြင်ရပါ။"),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "လူများနှင့် ပို့စ်များကို ရှာရန်"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "ပါဝင်နိုင်သော အသိုင်းအဝိုင်းများ"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("ကြည့်စရာ မရှိသေးပါ"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "လူများ တင်သော ဓာတ်ပုံနှင့် ကလစ်များကို ဤနေရာတွင် ပြပါမည်။"),
      "ui_follow": MessageLookupByLibrary.simpleMessage("ဖော်လိုလုပ်ရန်"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("အကောင့် ဖျက်ရန်"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "၎င်းသည် သင့် Kyron အကောင့်ကို အပြီးတိုင် ဖျက်ပါမည်။ ပြန်ပြင်၍ မရပါ။"),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "သင့်ပရိုဖိုင်၊ ပို့စ်များ၊ ပြန်စာများ၊ နှစ်သက်မှုများနှင့် ပြန်တင်မှုများ"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "အခြားသူများထံ ပို့ခဲ့သည်များအပါအဝင် သင့်မက်ဆေ့ချ်များနှင့် ၎င်းတို့ထဲရှိ ဓာတ်ပုံနှင့် အသံမှတ်စုများ"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "သင့်နောက်လိုက်များ၊ သင်လိုက်နေသူများနှင့် သင့်ဆက်တင်များ"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "သင်စတင်ခဲ့သော အသိုင်းအဝိုင်းများကို အကြာဆုံးရှိနေသော စီမံသူ သို့မဟုတ် အဖွဲ့ဝင်ထံ လွှဲပေးပါမည်။ အခြားမည်သူမျှ မရှိသော အသိုင်းအဝိုင်းကို ပိတ်ပါမည်။"),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("သင့်အကောင့်ကို ဖျက်မလား။"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "၎င်းမှ မည်သည့်အရာကိုမျှ ပြန်ရနိုင်မည် မဟုတ်ပါ။"),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("သင့်အကောင့်ကို ဖျက်ပြီးပါပြီ။"),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("ဖျက်ထားသော အကောင့်"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "ဤအကောင့်ကို ဖျက်ထားပြီးဖြစ်၍ ဤနေရာသို့ မက်ဆေ့ချ် ပို့၍ မရတော့ပါ။"),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google ဖြင့် စာရင်းသွင်းခဲ့ပါသလား။ «Sign in with Google» ကို အစားသုံးပါ။"),
    };

final messageLookup = MessageLookup();
