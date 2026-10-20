import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ml';

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
      "change": MessageLookupByLibrary.simpleMessage("Change"),
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
      "contactSupport": MessageLookupByLibrary.simpleMessage("Contact support"),
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
      "done": MessageLookupByLibrary.simpleMessage("Done"),
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
      "report": MessageLookupByLibrary.simpleMessage("Report"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Report sent"),
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
      "sendReport": MessageLookupByLibrary.simpleMessage("Send report"),
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
      "tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
      "ui_about_privacy_policy": MessageLookupByLibrary.simpleMessage(
        "Privacy Policy",
      ),
      "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage(
        "Terms of Service",
      ),
      "ui_account": MessageLookupByLibrary.simpleMessage("Account"),
      "ui_after": MessageLookupByLibrary.simpleMessage("After"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("App & Device"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "Light, dark, or whatever the phone is set to",
      ),
      "ui_before": MessageLookupByLibrary.simpleMessage("Before"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "Neither of you will see the other on Kyron, and any follow between you is removed. They are not told.",
      ),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Carrying"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
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
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("ഇഷ്ടപ്പെട്ടവ"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("സംരക്ഷിച്ചവ"),
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
      "ui_group_add": MessageLookupByLibrary.simpleMessage("ആളുകളെ ചേർക്കുക"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("ചേർക്കുക"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("നിരസിക്കുക"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "ഈ ഗ്രൂപ്പിലെ സന്ദേശങ്ങൾ മറ്റേതൊരു സംഭാഷണത്തെയും പോലെ എൻഡ്-ടു-എൻഡ് എൻക്രിപ്റ്റ് ചെയ്തതാണ്."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor ചേർത്തു: \$users"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor അഡ്മിനാക്കി: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor ഗ്രൂപ്പ് സൃഷ്ടിച്ചു"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "പുതിയവർ അംഗങ്ങളായി ചേരുന്ന രീതിയിൽ \$actor ക്രമീകരിച്ചു"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "പുതിയവർ കാഴ്ചക്കാരായി ചേരുന്ന രീതിയിൽ \$actor ക്രമീകരിച്ചു"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor പോയി"),
      "ui_group_event_member":
          MessageLookupByLibrary.simpleMessage("\$actor അംഗമാക്കി: \$users"),
      "ui_group_event_owner":
          MessageLookupByLibrary.simpleMessage("\$actor ഉടമയാക്കി: \$users"),
      "ui_group_event_removed": MessageLookupByLibrary.simpleMessage(
          "\$actor നീക്കം ചെയ്തു: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor ഗ്രൂപ്പിന്റെ പേര് \$title എന്നാക്കി"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor കാഴ്ചക്കാരനാക്കി: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "ഒരു ഗ്രൂപ്പിൽ പരമാവധി \$count പേർ ആകാം."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "കൈ ഉയർത്തി. അഡ്മിൻമാരെ അറിയിച്ചു."),
      "ui_group_hands": MessageLookupByLibrary.simpleMessage(
          "\$count പേർ എഴുതാൻ ആഗ്രഹിക്കുന്നു"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("എഴുതാൻ ആഗ്രഹിക്കുന്നു"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "പിന്നീട് ചേർക്കുന്നവർ കാഴ്ചക്കാരായി ചേരും"),
      "ui_group_leave":
          MessageLookupByLibrary.simpleMessage("ഗ്രൂപ്പിൽ നിന്ന് പുറത്തുപോകുക"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "ഇത് നിങ്ങളുടെ പട്ടികയിൽ നിന്ന് മാറും, പിന്നീട് പറയുന്നത് നിങ്ങൾ കാണില്ല. ആരെങ്കിലും നിങ്ങളെ വീണ്ടും ചേർക്കേണ്ടി വരും."),
      "ui_group_leave_title": MessageLookupByLibrary.simpleMessage(
          "ഈ ഗ്രൂപ്പിൽ നിന്ന് പുറത്തുപോകണോ?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("എഴുതാൻ അനുവദിക്കുക"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("കൈ താഴ്ത്തുക"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("അഡ്മിനാക്കുക"),
      "ui_group_make_owner": MessageLookupByLibrary.simpleMessage("ഉടമയാക്കുക"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("കാഴ്ചക്കാരനാക്കുക"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count അംഗങ്ങൾ"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("അംഗങ്ങൾ"),
      "ui_group_name":
          MessageLookupByLibrary.simpleMessage("ഗ്രൂപ്പിന്റെ പേര്"),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("ഗ്രൂപ്പ് ചാറ്റ് സൃഷ്ടിക്കുക"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "ഉടമ ഒരാൾ മാത്രം. നിങ്ങൾ അഡ്മിനായി തുടരും."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("\$name ഉടമയാകണോ?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("കൈ ഉയർത്തുക"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("ഗ്രൂപ്പിൽ നിന്ന് നീക്കുക"),
      "ui_group_remove_admin": MessageLookupByLibrary.simpleMessage(
          "അഡ്മിൻ സ്ഥാനത്ത് നിന്ന് നീക്കുക"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ ഇനി ഈ ഗ്രൂപ്പിൽ ഇല്ല."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("പേരുമാറ്റുക"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("അഡ്മിൻ"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("അംഗം"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("കാഴ്ചക്കാരൻ"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "കാഴ്ചക്കാരനായി നിങ്ങൾക്ക് ഇവിടെ വായിക്കാനും പ്രതികരിക്കാനും കഴിയും."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "കാഴ്ചക്കാർക്ക് വായിക്കാനും പ്രതികരിക്കാനും എഴുതാൻ അനുമതി ചോദിച്ച് കൈ ഉയർത്താനും കഴിയും."),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ കാണുക"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("നിങ്ങൾ"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ കാഴ്ചക്കാരനാണ്"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
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
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("ഇത് ഇതിനകം തുറന്നു."),
      "ui_once_expired":
          MessageLookupByLibrary.simpleMessage("കാലാവധി കഴിഞ്ഞു"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("ഇത് തുറക്കാനായില്ല."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "ഒരിക്കൽ തുറക്കും, പിന്നെ Kyron-ൽ നിന്ന് ഇല്ലാതാക്കും."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("ഒരിക്കൽ കാണുക"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("തുറന്നു"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "\$total പേരിൽ \$count പേർ തുറന്നു"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ അയച്ചവർക്ക് മാത്രമേ ഇത് ഒരിക്കൽ തുറക്കാനാകൂ."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("ഒരിക്കൽ കാണാൻ അയയ്ക്കുക"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("കാണാൻ ടാപ്പ് ചെയ്യുക"),
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
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Two characters or more.",
      ),
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
        "What happened, and what should we look at?",
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
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ മറുപടി നൽകി"),
      "dmReplied": (Object a0) => "$a0 മറുപടി നൽകി",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("സന്ദേശത്തിലേക്ക് ചേർക്കുക"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("പുതിയ സന്ദേശം"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "ഇതുവരെ ഒന്നും പറഞ്ഞിട്ടില്ല. കൈവീശൽ നല്ലൊരു തുടക്കമാണ്."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  കൈവീശുക"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("പുതിയ സന്ദേശങ്ങൾ"),
      "dmTyping": (Object a0) => "$a0 ടൈപ്പ് ചെയ്യുന്നു",
      "ui_dm_reaction_remove": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പ്രതികരണം നീക്കം ചെയ്യുക"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("ആരോ"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("സന്ദേശം"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("അറ്റാച്ച്മെന്റ്"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "ഈ സന്ദേശം ഈ ഉപകരണത്തിൽ വായിക്കാൻ കഴിയില്ല."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "ഈ സന്ദേശത്തിനായി കാത്തിരിക്കുന്നു. ഇതിന് കുറച്ച് സമയമെടുത്തേക്കാം."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("എൻക്രിപ്റ്റ് ചെയ്ത സന്ദേശം"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "സന്ദേശങ്ങൾ എൻഡ്-ടു-എൻഡ് എൻക്രിപ്റ്റ് ചെയ്തവയാണ്"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "എൻഡ്-ടു-എൻഡ് എൻക്രിപ്റ്റ് ചെയ്തിട്ടില്ല"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("അയച്ചു"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("കണ്ടു"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("അയയ്ക്കുന്നു…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("ഫോട്ടോ എടുക്കുക"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("കൂടുതൽ ഓപ്ഷനുകൾ"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("ഉപകരണത്തിൽ സംരക്ഷിക്കുക"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("പങ്കിടുക"),
      "ui_media_saving":
          MessageLookupByLibrary.simpleMessage("സംരക്ഷിക്കുന്നു…"),
      "ui_media_saved": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ ഫോട്ടോകളിൽ സംരക്ഷിച്ചു"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "സംരക്ഷിക്കാനായില്ല. വീണ്ടും ശ്രമിക്കുക."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "ഇത് സംരക്ഷിക്കാൻ നിങ്ങളുടെ ഫോട്ടോകളിലേക്ക് ചേർക്കാൻ Kyron-നെ അനുവദിക്കുക."),
      "ui_status_all_ok": MessageLookupByLibrary.simpleMessage(
          "എല്ലാ സിസ്റ്റങ്ങളും പ്രവർത്തിക്കുന്നു"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("അപ്‌ടൈം"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("കഴിഞ്ഞ 60 ദിവസം"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 ദിവസം മുമ്പ്"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("ഇന്ന്"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("ഡാറ്റാബേസ്"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("സൈൻ ഇൻ"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("സമീപകാല സംഭവങ്ങൾ"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "കഴിഞ്ഞ 60 ദിവസത്തിൽ സംഭവങ്ങളൊന്നുമില്ല."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("തുടരുന്നു"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("ഡാറ്റയില്ല"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("വിശദാംശങ്ങൾ"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron പ്രവർത്തിക്കുമ്പോൾ ഓരോ 5 മിനിറ്റിലും സ്വയം പരിശോധിക്കുന്നു. ചാരനിറമുള്ള ദിവസം പരിശോധനകളൊന്നും ഉണ്ടായിരുന്നില്ല."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "അപ്‌ടൈം ചരിത്രം ഇതുവരെ ലഭ്യമല്ല."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "ചില സിസ്റ്റങ്ങളിൽ പ്രശ്നങ്ങളുണ്ട്"),
      "ui_dm_voice": MessageLookupByLibrary.simpleMessage(
          "വോയ്‌സ് നോട്ട് റെക്കോർഡ് ചെയ്യുക"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("അയയ്ക്കാൻ തയ്യാറാണ്"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("ആ സന്ദേശം ഇനി ഇവിടെയില്ല."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("സന്ദേശത്തിലേക്ക് പോകുക"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("വോയ്‌സ് നോട്ട്"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("രചയിതാവിന് ഇഷ്ടപ്പെട്ടു"),
      "ui_add_photo_or_clip": MessageLookupByLibrary.simpleMessage(
          "ഫോട്ടോ അല്ലെങ്കിൽ ക്ലിപ്പ് ചേർക്കുക"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("മീഡിയ"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("വോയ്‌സ് നോട്ടുകൾ"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("ചാറ്റ്"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("വാൾപേപ്പർ"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("അറിയിപ്പുകൾ മ്യൂട്ട് ചെയ്യുക"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "ഈ സംഭാഷണത്തെക്കുറിച്ചുള്ള അറിയിപ്പുകൾ ലഭിക്കുന്നത് നിർത്തുക"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "അവർക്ക് ഇനി നിങ്ങൾക്ക് സന്ദേശം അയയ്ക്കാനാകില്ല"),
      "ui_dm_wallpaper_none":
          MessageLookupByLibrary.simpleMessage("ഒന്നുമില്ല"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("ഫോട്ടോ"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("അൺമ്യൂട്ട് ചെയ്തു."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "നീക്കം ചെയ്യാനായില്ല. വീണ്ടും ശ്രമിക്കുക."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ"),
      "ui_dm_unmute":
          MessageLookupByLibrary.simpleMessage("അൺമ്യൂട്ട് ചെയ്യുക"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ പങ്കിടുന്ന ഫോട്ടോകളും ക്ലിപ്പുകളും ഇവിടെ കാണാം."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("എല്ലാം കാണുക"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("ഫോട്ടോകളും ക്ലിപ്പുകളും"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ ചാറ്റ് ഇങ്ങനെയായിരിക്കും."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("നന്നായിട്ടുണ്ട്."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("മൂടൽമഞ്ഞ്"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("സന്ധ്യ"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("സേജ്"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("മണൽ"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("കുത്തുകൾ"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("പ്രയോഗിക്കുക"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("നിലവിലുള്ളത്"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("പ്രിവ്യൂ ഇല്ലാതെ അയയ്ക്കുക"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("തിരയുക"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ചെയ്യുക"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("ഒരു സന്ദേശം എഴുതുക…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("അയയ്ക്കുക"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("അയച്ചു"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "അയച്ചു, പക്ഷേ എല്ലാവർക്കുമല്ല."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "അയയ്ക്കാനായില്ല. വീണ്ടും ശ്രമിക്കുക."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("ഫിൽട്ടർ"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("എല്ലാം"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("വായിക്കാത്തവ"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("മറുപടി നൽകാത്തവ"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("മറച്ചവ"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("ഒന്നും മറച്ചിട്ടില്ല"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "പട്ടികയിൽ നിന്ന് നീക്കിയ സംഭാഷണങ്ങൾ തിരികെ വേണമെങ്കിൽ ഇവിടെ കാത്തിരിക്കുന്നു."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "ഇത് മറച്ചവയിലേക്ക് മാറുന്നു. മറ്റേയാൾ തന്റേത് സൂക്ഷിക്കും, നിങ്ങളിൽ ആരെങ്കിലും വീണ്ടും എഴുതിയാൽ ഇത് തിരിച്ചുവരും."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("തിരികെ വെക്കുക"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും നിങ്ങളുടെ പട്ടികയിൽ."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "പൊരുത്തപ്പെടുന്ന സംഭാഷണങ്ങളില്ല."),
      "ui_dm_unanswered_none": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളെ ഒന്നും കാത്തിരിക്കുന്നില്ല"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "എല്ലാ സംഭാഷണവും നിങ്ങളുടെ വാക്കിൽ അവസാനിക്കുന്നു."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("ഫോട്ടോ"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("ഫോട്ടോകൾ"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("വീഡിയോ"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ സന്ദേശങ്ങളില്ല"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("നിങ്ങൾ:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("ഇന്നലെ"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("സന്ദേശങ്ങൾ"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("സന്ദേശ ക്രമീകരണങ്ങൾ"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("സ്വകാര്യത"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("വായിച്ചതിന്റെ രസീതുകൾ"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "ഇത് ഓഫാണെങ്കിൽ, നിങ്ങൾ അവരുടെ സന്ദേശങ്ങൾ വായിച്ചത് മറ്റുള്ളവർ കാണില്ല, അവർ നിങ്ങളുടേത് വായിച്ചത് നിങ്ങളും കാണില്ല."),
      "ui_dm_typing_setting": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ടൈപ്പ് ചെയ്യുമ്പോൾ കാണിക്കുക"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ എഴുതുന്നയാൾ നിങ്ങൾ എഴുതുകയാണെന്ന് കാണുന്നു."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("ലിങ്ക് പ്രിവ്യൂകൾ"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "പ്രിവ്യൂ ഉണ്ടാക്കാൻ നിങ്ങൾ അയയ്ക്കുന്ന ലിങ്ക് നിങ്ങളുടെ ഫോൺ തുറക്കുന്നു, അതിനാൽ സൈറ്റ് നിങ്ങളുടെ ഫോണിന്റെ അഭ്യർത്ഥന കാണുന്നു. Kyron-ന്റെ സെർവർ ലിങ്ക് ഒരിക്കലും കാണുന്നില്ല."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("സന്ദേശങ്ങളുടെ അറിയിപ്പുകൾ"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "സന്ദേശങ്ങൾ എൻഡ്-ടു-എൻഡ് എൻക്രിപ്റ്റ് ചെയ്തവയാണ്. Kyron-ന് അവ വായിക്കാനാവില്ല, ഇവിടെയുള്ള ഒന്നും അത് മാറ്റുന്നില്ല."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("സ്വീകർത്താവ്:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("സമീപകാലം"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("ആളുകൾ"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("ആ പേരിൽ ആരുമില്ല."),
      "ui_push_test": MessageLookupByLibrary.simpleMessage(
          "ഒരു ടെസ്റ്റ് അറിയിപ്പ് അയയ്ക്കുക"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron-ന്റെ സെർവർ ഇതുവരെ അറിയിപ്പുകൾ അയയ്ക്കാൻ സജ്ജമാക്കിയിട്ടില്ല, അതിനാൽ ഒന്നും എത്തില്ല. പ്രശ്നം ഞങ്ങളുടെ ഭാഗത്താണ്, നിങ്ങളുടെ ഫോണിലല്ല."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "ഈ ഫോൺ അറിയിപ്പുകൾക്കായി രജിസ്റ്റർ ചെയ്തിട്ടില്ല. ഫോണിന്റെ ക്രമീകരണങ്ങളിൽ Kyron-ന് അറിയിപ്പുകൾ അനുവദിച്ചിട്ടുണ്ടോ എന്ന് പരിശോധിച്ച് വീണ്ടും ശ്രമിക്കുക."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "അറിയിപ്പ് ഈ ഫോണിലേക്ക് എത്തിക്കാനായില്ല. ഒരു മിനിറ്റിന് ശേഷം വീണ്ടും ശ്രമിക്കുക."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "അയച്ചു. കുറച്ച് സെക്കൻഡിനുള്ളിൽ എത്തണം."),
      "ui_push_working": MessageLookupByLibrary.simpleMessage(
          "അറിയിപ്പുകൾ പ്രവർത്തിക്കുന്നു."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ പോസ്റ്റുകളില്ല"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("പുതിയ കമ്മ്യൂണിറ്റി"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("പേര്"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "അതിന്റെ വിലാസം പേരിൽ നിന്ന് ഉണ്ടാകുന്നു."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("ആളുകൾ ഇത് ഇവിടെ കണ്ടെത്തും:"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളായിരിക്കും ഉടമ. ഉണ്ടായിക്കഴിഞ്ഞാൽ അതിന്റെ പേജിൽ നിന്ന് ചിത്രം, ബാനർ, മോഡറേറ്റർമാർ എന്നിവ ചേർക്കാം."),
      "ui_community_settings_home": MessageLookupByLibrary.simpleMessage("ഹോം"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "ഹോമിൽ കമ്മ്യൂണിറ്റി പോസ്റ്റുകൾ"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ കമ്മ്യൂണിറ്റികളിലെ പോസ്റ്റുകൾ ഹോമിലും കാണാം. ഓഫാക്കിയാൽ അവ ഇവിടെ കമ്മ്യൂണിറ്റികളിൽ നിൽക്കും, ഓരോന്നിലും പുതിയത് എന്തെന്ന് കാണിക്കും."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ലിസ്റ്റ്"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("പുതിയ പോസ്റ്റുകളുടെ എണ്ണം"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "അവസാനം തുറന്നതിനുശേഷം ഓരോ കമ്മ്യൂണിറ്റിയിലും എത്ര പോസ്റ്റുകൾ പുതിയതാണെന്ന് കാണിക്കുക."),
      "ui_community_settings_running": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ നടത്തുന്ന കമ്മ്യൂണിറ്റികൾ"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ തുടങ്ങുന്നതോ മോഡറേറ്റ് ചെയ്യുന്നതോ ആയ കമ്മ്യൂണിറ്റികൾ ഇവിടെയുണ്ട്."),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("ഉടമ"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("മോഡറേറ്റർ"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("പുതിയ പോസ്റ്റുകൾ"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ നടത്തുന്നവ"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("കമ്മ്യൂണിറ്റി ക്രമീകരണങ്ങൾ"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("കണ്ടെത്തുക"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "പൊരുത്തപ്പെടുന്ന കമ്മ്യൂണിറ്റികളില്ല."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("പുതിയതൊന്നുമില്ല"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "ഓരോ കമ്മ്യൂണിറ്റിയും നിങ്ങൾ വിട്ടതുപോലെ തന്നെ."),
      "ui_community_running_none": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ഇതുവരെ ഒന്നും നടത്തുന്നില്ല"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("ചേരാൻ ഒന്നും ബാക്കിയില്ല"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-ലെ എല്ലാ കമ്മ്യൂണിറ്റികളിലും നിങ്ങളുണ്ട്. മറ്റൊന്ന് തുടങ്ങുക."),
      "ui_community_discover_search_detail": MessageLookupByLibrary.simpleMessage(
          "മറ്റൊരു വാക്ക് ശ്രമിക്കുക, അല്ലെങ്കിൽ ആ പേരിൽ ഒരു കമ്മ്യൂണിറ്റി തുടങ്ങുക."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് എഴുതുക"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("അംഗങ്ങൾ:"),
      "ui_toast_posted":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ചെയ്തു"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("കാണുക"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("തുറക്കുക"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("ഓൺലൈൻ"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("ഓൺലൈനായിരിക്കുമ്പോൾ കാണിക്കുക"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ സന്ദേശം അയയ്ക്കുന്നവർക്ക്, നിങ്ങൾ Kyron തുറന്നിരിക്കുമ്പോൾ ഒരു പച്ച കുത്ത് കാണാം. ഇത് ഓഫാണെങ്കിൽ, അവരുടേത് നിങ്ങളും കാണില്ല."),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "ആളുകളെയും പോസ്റ്റുകളെയും തിരയുക"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("ചേരാവുന്ന കമ്മ്യൂണിറ്റികൾ"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ കാണാൻ ഒന്നുമില്ല"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "ആളുകൾ പോസ്റ്റ് ചെയ്യുന്ന ഫോട്ടോകളും ക്ലിപ്പുകളും ഇവിടെ കാണാം."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("ഫോളോ ചെയ്യുക"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("അക്കൗണ്ട് ഇല്ലാതാക്കുക"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "ഇത് നിങ്ങളുടെ Kyron അക്കൗണ്ട് സ്ഥിരമായി ഇല്ലാതാക്കും. ഇത് പഴയപടിയാക്കാനാകില്ല."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പ്രൊഫൈൽ, പോസ്റ്റുകൾ, മറുപടികൾ, ലൈക്കുകൾ, റീപോസ്റ്റുകൾ"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ സന്ദേശങ്ങൾ, മറ്റുള്ളവർക്ക് അയച്ചവ ഉൾപ്പെടെ, അവയിലെ ഫോട്ടോകളും വോയ്സ് നോട്ടുകളും"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ ഫോളോവർമാർ, നിങ്ങൾ ഫോളോ ചെയ്യുന്നവർ, നിങ്ങളുടെ ക്രമീകരണങ്ങൾ"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ തുടങ്ങിയ കമ്മ്യൂണിറ്റികൾ ഏറ്റവും കൂടുതൽ കാലമായുള്ള മോഡറേറ്റർക്കോ അംഗത്തിനോ കൈമാറും. മറ്റാരുമില്ലാത്ത കമ്മ്യൂണിറ്റി അടയ്ക്കും."),
      "ui_delete_account_confirm_title": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് ഇല്ലാതാക്കണോ?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "ഇതിൽ ഒന്നും നിങ്ങൾക്ക് തിരികെ ലഭിക്കില്ല."),
      "ui_delete_account_done": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് ഇല്ലാതാക്കി."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("ഇല്ലാതാക്കിയ അക്കൗണ്ട്"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "ഈ അക്കൗണ്ട് ഇല്ലാതാക്കിയതിനാൽ ഇവിടേക്ക് ഇനി സന്ദേശങ്ങൾ അയയ്ക്കാനാകില്ല."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google ഉപയോഗിച്ചാണോ സൈൻ അപ്പ് ചെയ്തത്? പകരം «Sign in with Google» ഉപയോഗിക്കുക."),
    };

final messageLookup = MessageLookup();
