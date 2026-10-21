import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

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
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Для чого він (необов’язково)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Писати можуть лише модератори"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Для оголошень. Усі в спільноті й далі можуть читати та реагувати."),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Закрити чат"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Ніхто більше не зможе читати чи писати в ньому. Цю дію не можна скасувати."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Закрити цей чат?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Скопійовано"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Повідомлення видаляється для всіх. Kyron зберігає копію для перевірки."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Повідомлення видаляється для всіх у чаті."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Редагувати чат"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Не вдалося відкрити цей чат."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Чати"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Приєднатися до чату"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Приєднайтеся до спільноти, щоб бачити її чати й брати в них участь."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Учасників: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Вийти з чату"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Ви зможете читати його, доки перебуваєте в спільноті."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Писати тут можуть лише власник і модератори."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Назва чату"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Новий чат"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Чатів поки немає."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Чатів поки немає. Відкрийте перший для спільноти."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Чати спільнот не мають наскрізного шифрування. Модератори спільноти та Kyron можуть їх читати."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Закріпити вгорі"),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Ви більше не можете бачити цей чат."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Повільний режим"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Скільки потрібно чекати між повідомленнями. Не стосується модераторів."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 година"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Хвилин: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Повільний режим: одне повідомлення раз на \$seconds с"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Вимк."),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Секунд: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Ви можете читати й реагувати як глядач. Приєднайтеся, щоб писати."),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Відкріпити"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Ви"),
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
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Вподобане"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Збережене"),
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
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Додати людей"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Додати"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Відхилити"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Повідомлення в цій групі захищено наскрізним шифруванням, як і в будь-якій іншій розмові."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor додає: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor призначає адміністратором: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor створює групу"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor: нові люди приєднуються як учасники"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor: нові люди приєднуються як глядачі"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor виходить із групи"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor призначає учасником: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor передає власність: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor видаляє: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor перейменовує групу на \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor призначає глядачем: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "У групі може бути щонайбільше \$count людей."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Руку піднято. Адміністраторам повідомлено."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Хочуть писати: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Хочуть писати"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Додані пізніше приєднуються як глядачі"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Вийти з групи"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Вона зникне з вашого списку, і ви не побачите, що буде написано потім. Комусь доведеться додати вас знову."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Вийти з цієї групи?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Дозволити писати"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Опустити руку"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Призначити адміністратором"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Передати власність"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Зробити глядачем"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Учасників: \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Учасники"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Назва групи"),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Створити груповий чат"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Власник лише один. Ви залишитеся адміністратором."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Передати власність: \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Підняти руку"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Видалити з групи"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Зняти права адміністратора"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Ви більше не в цій групі."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Перейменувати"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Адміністратор"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Учасник"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("Глядач"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Як глядач ви можете читати й реагувати."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Глядачі можуть читати, реагувати й підняти руку, щоб попросити дозволу писати."),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Переглянути профіль"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("ви"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Ви глядач"),
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
          MessageLookupByLibrary.simpleMessage("Це вже відкривали."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Термін минув"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Не вдалося відкрити."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Відкривається один раз, потім видаляється з Kyron."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Одноразовий перегляд"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Відкрито"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Відкрили: \$count із \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Відкрити це можуть лише ті, кому ви надіслали, і лише раз."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Надіслати для одноразового перегляду"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Торкніться, щоб переглянути"),
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
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Ви відповіли"),
      "dmReplied": (Object a0) => "Відповідь від $a0",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Додати до повідомлення"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Нове повідомлення"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Ще нічого не сказано. Помахати рукою — гарний початок."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Помахати"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Нові повідомлення"),
      "dmTyping": (Object a0) => "$a0 друкує",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Прибрати вашу реакцію"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Хтось"),
      "ui_dm_quote_message":
          MessageLookupByLibrary.simpleMessage("Повідомлення"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Вкладення"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Це повідомлення неможливо прочитати на цьому пристрої."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Очікування цього повідомлення. Це може зайняти деякий час."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Зашифроване повідомлення"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Повідомлення захищені наскрізним шифруванням"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Без наскрізного шифрування"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Надіслано"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Переглянуто"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Надсилання…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Зробити фото"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Інші дії"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Зберегти на пристрій"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Поділитися"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Збереження…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Збережено у фото"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося зберегти. Спробуйте ще раз."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Дозвольте Kyron додавати до ваших фото, щоб зберегти це."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Усі системи працюють"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Доступність"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Останні 60 днів"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 днів тому"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Сьогодні"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("База даних"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Вхід"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Нещодавні інциденти"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "За останні 60 днів інцидентів не було."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Триває"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Немає даних"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Подробиці"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron перевіряє себе кожні 5 хвилин, поки працює. У сірий день перевірок не було."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Історія доступності ще недоступна."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("У деяких системах є проблеми"),
      "ui_dm_voice": MessageLookupByLibrary.simpleMessage(
          "Записати голосове повідомлення"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Готово до надсилання"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Цього повідомлення вже немає."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Перейти до повідомлення"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Голосове повідомлення"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Сподобалося авторові"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Додати фото або кліп"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Медіа"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Голосові повідомлення"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Чат"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Шпалери"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Вимкнути сповіщення"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Більше не отримувати сповіщень про цю розмову"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Вони більше не зможуть вам писати"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Немає"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Сповіщення увімкнено."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося видалити. Спробуйте ще раз."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Профіль"),
      "ui_dm_unmute":
          MessageLookupByLibrary.simpleMessage("Увімкнути сповіщення"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Тут з'являються фото та кліпи, якими ви ділитеся."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Переглянути все"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("Фото та кліпи"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Так виглядатиме ваш чат."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Виглядає добре."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Туман"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Сутінки"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Шавлія"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Пісок"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Цятки"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("Застосувати"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Поточні"),
      "ui_dm_link_card_remove": MessageLookupByLibrary.simpleMessage(
          "Надіслати без попереднього перегляду"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Пошук"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Опублікувати"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Напишіть повідомлення…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Надіслати"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Надіслано"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Надіслано, але не всім."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Не вдалося надіслати. Спробуйте ще раз."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Фільтр"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Усі"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Непрочитані"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Без відповіді"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Приховані"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Нічого не приховано"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Розмови, які ви прибираєте зі списку, чекають тут, якщо захочете їх повернути."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Вона переходить до Прихованих. Інша людина зберігає свою, а розмова повернеться, якщо хтось із вас знову напише."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Повернути"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Знову у вашому списку."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Немає відповідних розмов."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Ніщо не чекає на вас"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Кожна розмова закінчується вашим словом."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Фото"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Відео"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Ще немає повідомлень"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Ви:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Учора"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Повідомлення"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Налаштування повідомлень"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Конфіденційність"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Звіти про прочитання"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Коли це вимкнено, люди не бачитимуть, коли ви прочитали їхні повідомлення, а ви не бачитимете, коли вони прочитали ваші."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Показувати, що ви друкуєте"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Людина, якій ви пишете, бачить, що ви пишете."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Попередній перегляд посилань"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Ваш телефон відкриває посилання, яке ви надсилаєте, щоб створити попередній перегляд, тож сайт бачить запит вашого телефона. Сервер Kyron ніколи не бачить посилання."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Сповіщення про повідомлення"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Повідомлення мають наскрізне шифрування. Kyron не може їх читати, і ніщо тут цього не змінює."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Кому:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Нещодавні"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Люди"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Нікого з таким ім'ям."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Надіслати тестове сповіщення"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Сервер Kyron ще не налаштовано для надсилання сповіщень, тож жодне не може надійти. Проблема на нашому боці, а не у вашому телефоні."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Цей телефон не зареєстровано для сповіщень. Перевірте, чи дозволено сповіщення Kyron у налаштуваннях телефона, і спробуйте ще раз."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Не вдалося доставити сповіщення на цей телефон. Спробуйте ще раз за хвилину."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Надіслано. Має надійти за кілька секунд."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Сповіщення працюють."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Ще немає дописів"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Нова спільнота"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Назва"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Адреса утворюється з назви."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Її знайдуть за адресою"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Ви будете власником. Зображення, банер і модераторів можна додати на її сторінці, щойно вона з'явиться."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Головна"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Дописи спільнот на Головній"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Дописи з ваших спільнот видно й на Головній. Якщо вимкнути, вони залишаються тут, у Спільнотах, де кожна показує, що нового."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Ваш список"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Кількість нових дописів"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Показувати, скільки дописів нових у кожній спільноті відтоді, як ви її востаннє відкривали."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Спільноти, якими ви керуєте"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Тут спільноти, які ви створили або модеруєте."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Власник"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Модератор"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Нові дописи"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Під вашим керуванням"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Налаштування спільнот"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Огляд"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Немає відповідних спільнот."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Нічого нового"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Кожна спільнота така, якою ви її залишили."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Ви поки нічим не керуєте"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "Більше нема до чого приєднатися"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ви в усіх спільнотах Kyron. Створіть ще одну."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Спробуйте інше слово або створіть спільноту з такою назвою."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Написати допис"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Учасники:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Опубліковано"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Переглянути"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Відкрити"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("У мережі"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Показувати, коли ви в мережі"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Ті, з ким ви листуєтеся, бачать зелену крапку, поки у вас відкритий Kyron. Коли це вимкнено, ви теж не бачитимете їхньої."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Пошук людей і дописів"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Спільноти, до яких можна приєднатися"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Поки що нема на що дивитися"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Тут з'являтимуться фото та кліпи, які публікують люди."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Стежити"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Видалити обліковий запис"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Це назавжди видалить ваш обліковий запис Kyron. Цю дію не можна скасувати."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Ваш профіль, дописи, відповіді, вподобання та репости"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Ваші повідомлення, зокрема надіслані іншим, а також фото й голосові повідомлення в них"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Ваші підписники, люди, на яких ви підписані, і ваші налаштування"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Створені вами спільноти перейдуть до модератора або учасника, який перебуває в них найдовше. Спільноту, у якій більше нікого немає, буде закрито."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Видалити ваш обліковий запис?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Ви не зможете нічого з цього повернути."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Ваш обліковий запис видалено."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Видалений обліковий запис"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Цей обліковий запис видалено, тому сюди більше не можна надсилати повідомлення."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Реєструвалися через Google? Скористайтеся «Sign in with Google»."),
    };

final messageLookup = MessageLookup();
