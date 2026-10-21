import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

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
          MessageLookupByLibrary.simpleMessage("À quoi il sert (facultatif)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Seuls les modérateurs peuvent écrire"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Pour les annonces. Tout le monde dans la communauté peut toujours lire et réagir."),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "Ajouter une photo ou un sondage"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Photos et vidéos"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Fermer le chat"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Plus personne ne pourra y lire ni y écrire. Cette action est irréversible."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Fermer ce chat ?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Copié"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Le message est retiré pour tout le monde. Kyron en garde une copie pour examen."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Le message est retiré pour tout le monde dans le chat."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Modifier le chat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Modifier"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("modifié"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Modification de votre message"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Impossible d’ouvrir ce chat."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Chats"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Rejoindre le chat"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Rejoignez la communauté pour voir ses chats et y participer."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count membres"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Quitter le chat"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Vous pourrez toujours le lire tant que vous êtes dans la communauté."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Seuls le propriétaire et les modérateurs peuvent écrire ici."),
      "ui_cchat_mute":
          MessageLookupByLibrary.simpleMessage("Mettre en sourdine"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Aucune notification de ce chat, et il n’est plus compté dans Messages."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Nom du chat"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Nouveau chat"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Aucun chat pour l’instant."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Aucun chat pour l’instant. Ouvrez-en un pour la communauté."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Les chats de communauté ne sont pas chiffrés de bout en bout. Les modérateurs de la communauté et Kyron peuvent les lire."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Épingler en haut"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Ajouter une réponse"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Clore le sondage"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Clos"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Tout le monde voit combien de personnes ont choisi chaque réponse, jamais qui."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Autoriser plusieurs choix"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Nouveau sondage"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Choisissez-en une"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Réponse \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Sondage : \$question"),
      "ui_cchat_poll_question":
          MessageLookupByLibrary.simpleMessage("Question"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Chaque réponse ne peut figurer qu’une fois dans un sondage."),
      "ui_cchat_poll_several": MessageLookupByLibrary.simpleMessage(
          "Choisissez-en une ou plusieurs"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count ont répondu"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Rechercher dans ce chat"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Rechercher dans ce chat"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Aucun résultat."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Vous ne pouvez plus voir ce chat."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Mode lent"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Le temps d’attente entre deux messages. Ne s’applique pas aux modérateurs."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 heure"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minutes"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Mode lent : un message toutes les \$seconds secondes"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Désactivé"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n secondes"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Vous pouvez lire et réagir en tant que spectateur. Rejoignez le chat pour écrire."),
      "ui_cchat_too_big": MessageLookupByLibrary.simpleMessage(
          "Un élément que vous avez choisi dépasse 25 Mo et a été retiré."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Ce message est trop ancien pour être affiché."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Réactiver le son"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Désépingler"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Enregistrer un message vocal"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Vous"),
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
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("J'aime"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Enregistrés"),
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
      "ui_group_add":
          MessageLookupByLibrary.simpleMessage("Ajouter des personnes"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Ajouter"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Ajouter un nom de groupe"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Ignorer"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Les messages de ce groupe sont chiffrés de bout en bout, comme toute autre conversation."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor a ajouté \$users"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor a nommé \$users admin"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor a créé le groupe"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor fait rejoindre les nouveaux en tant que membres"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor fait rejoindre les nouveaux en tant que spectateurs"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor est parti"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor a fait de \$users un membre"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor a fait de \$users le propriétaire"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor a retiré \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor a renommé le groupe \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor a fait de \$users un spectateur"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Un groupe peut compter au plus \$count personnes."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Main levée. Les admins ont été prévenus."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count demandent à écrire"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Demandent à écrire"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Les personnes ajoutées plus tard rejoignent en spectateurs"),
      "ui_group_leave":
          MessageLookupByLibrary.simpleMessage("Quitter le groupe"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Il disparaît de votre liste et vous ne verrez pas ce qui sera dit ensuite. Quelqu’un devra vous ajouter à nouveau."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Quitter ce groupe ?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Autoriser à écrire"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Baisser la main"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Nommer admin"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Nommer propriétaire"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Passer en spectateur"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count membres"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Membres"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Nom du groupe"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Nommez d’abord le groupe."),
      "ui_group_new": MessageLookupByLibrary.simpleMessage(
          "Créer une discussion de groupe"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Il n’y a qu’un propriétaire. Vous resterez admin."),
      "ui_group_owner_title": MessageLookupByLibrary.simpleMessage(
          "Faire de \$name le propriétaire ?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Lever la main"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Retirer du groupe"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Retirer des admins"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Vous ne faites plus partie de ce groupe."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Renommer"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Admin"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Membre"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Spectateur"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "En tant que spectateur, vous pouvez lire et réagir ici."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Les spectateurs peuvent lire, réagir et lever la main pour demander à écrire."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Suggestions"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Voir le profil"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("vous"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Vous êtes spectateur"),
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
          MessageLookupByLibrary.simpleMessage("Ceci a déjà été ouvert."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Expiré"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Impossible d’ouvrir ceci."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "S’ouvre une fois, puis est supprimé de Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Vue unique"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Ouvert"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "Ouvert par \$count sur \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Seules les personnes à qui vous l’avez envoyé peuvent l’ouvrir, une fois."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Envoyer en vue unique"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Touchez pour voir"),
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
          MessageLookupByLibrary.simpleMessage("Vous avez répondu"),
      "dmReplied": (Object a0) => "$a0 a répondu",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Ajouter au message"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Nouveau message"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Rien n'a encore été dit. Un petit coucou est un bon début."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Saluer"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Nouveaux messages"),
      "dmTyping": (Object a0) => "$a0 est en train d'écrire",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Retirer votre réaction"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Quelqu'un"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Message"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Pièce jointe"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Ce message ne peut pas être lu sur cet appareil."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "En attente de ce message. Cela peut prendre un certain temps."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Message chiffré"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Les messages sont chiffrés de bout en bout"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Non chiffré de bout en bout"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Envoyé"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Vu"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Envoi…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Prendre une photo"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Plus d'options"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Enregistrer sur l'appareil"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Partager"),
      "ui_media_saving":
          MessageLookupByLibrary.simpleMessage("Enregistrement…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Enregistré dans vos photos"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de l'enregistrer. Réessayez."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Autorisez Kyron à ajouter à vos photos pour enregistrer ceci."),
      "ui_status_all_ok": MessageLookupByLibrary.simpleMessage(
          "Tous les systèmes sont opérationnels"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Disponibilité"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("60 derniers jours"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Il y a 60 jours"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Aujourd'hui"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database":
          MessageLookupByLibrary.simpleMessage("Base de données"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Connexion"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Incidents récents"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Aucun incident au cours des 60 derniers jours."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("En cours"),
      "ui_status_no_data":
          MessageLookupByLibrary.simpleMessage("Aucune donnée"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Détails"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron se vérifie toutes les 5 minutes tant qu'il fonctionne. Un jour gris n'a eu aucune vérification."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "L'historique de disponibilité n'est pas encore disponible."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Certains systèmes rencontrent des problèmes"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Enregistrer un message vocal"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Prêt à envoyer"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Ce message n'est plus là."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Aller au message"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Message vocal"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Aimé par l'auteur"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Ajouter une photo ou un clip"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Médias"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Messages vocaux"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Discussion"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("Fond d'écran"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Désactiver les notifications"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Ne plus être notifié de cette conversation"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Cette personne ne peut plus vous écrire"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Aucun"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Photo"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("Son réactivé."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de la supprimer. Réessayez."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profil"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Réactiver"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Les photos et clips que vous partagez apparaissent ici."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("Tout voir"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Photos et clips"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Voici à quoi ressemblera votre discussion."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("C'est parfait."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Brume"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Crépuscule"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Sauge"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Sable"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Points"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("Appliquer"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("Actuel"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Envoyer sans l’aperçu"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Rechercher"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Publier"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Écrire un message…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Envoyer"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Envoyé"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "Envoyé, mais pas à tout le monde."),
      "ui_share_failed":
          MessageLookupByLibrary.simpleMessage("L’envoi a échoué. Réessayez."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtre"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Toutes"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Non lues"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Sans réponse"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Masquées"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Rien de masqué"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Les conversations que vous retirez de votre liste attendent ici, au cas où vous voudriez les récupérer."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Elle passe dans Masquées. L’autre personne garde la sienne, et elle revient si l’un de vous écrit à nouveau."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Remettre"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("De retour dans votre liste."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "Aucune conversation ne correspond."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Rien ne vous attend"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Chaque conversation se termine sur votre mot."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Photo"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Photos"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Vidéo"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Pas encore de messages"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Vous :"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Hier"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Messages"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Paramètres des messages"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Confidentialité"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Confirmations de lecture"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Désactivées, les autres ne verront pas quand vous avez lu leurs messages, et vous ne verrez pas quand ils ont lu les vôtres."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Indiquer quand vous écrivez"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "La personne à qui vous écrivez voit que vous êtes en train d’écrire."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Aperçus des liens"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Votre téléphone ouvre le lien que vous envoyez pour en faire l’aperçu : le site voit donc la demande de votre téléphone. Le serveur de Kyron ne voit jamais le lien."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Notifications des messages"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Les messages sont chiffrés de bout en bout. Kyron ne peut pas les lire, et rien ici n’y change rien."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("À :"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Récents"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Personnes"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Personne de ce nom."),
      "ui_push_test": MessageLookupByLibrary.simpleMessage(
          "Envoyer une notification de test"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Le serveur de Kyron n’est pas encore configuré pour envoyer des notifications, donc aucune ne peut arriver. Le problème vient de nous, pas de votre téléphone."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Ce téléphone n’est pas enregistré pour les notifications. Vérifiez que les notifications de Kyron sont autorisées dans les réglages du téléphone, puis réessayez."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "La notification n’a pas pu être remise à ce téléphone. Réessayez dans une minute."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Envoyée. Elle devrait arriver dans quelques secondes."),
      "ui_push_working": MessageLookupByLibrary.simpleMessage(
          "Les notifications fonctionnent."),
      "ui_community_no_posts": MessageLookupByLibrary.simpleMessage(
          "Aucune publication pour l'instant"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Nouvelle communauté"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Nom"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Son adresse est tirée du nom."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("On la trouvera à l'adresse"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Vous en serez propriétaire. Une image, une bannière et des modérateurs peuvent être ajoutés depuis sa page une fois créée."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Accueil"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Publications des communautés dans l'Accueil"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Les publications de vos communautés apparaissent aussi dans l'Accueil. Désactivé, elles restent ici dans Communautés, où chacune montre ce qui est nouveau."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Votre liste"),
      "ui_community_counts": MessageLookupByLibrary.simpleMessage(
          "Nombre de nouvelles publications"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Afficher combien de publications sont nouvelles dans chaque communauté depuis votre dernière visite."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Communautés que vous gérez"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Les communautés que vous créez ou modérez sont listées ici."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Propriétaire"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Modérateur"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Nouvelles publications"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Celles que vous gérez"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Paramètres des communautés"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("Découvrir"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "Aucune communauté ne correspond."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Rien de nouveau"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Chaque communauté est telle que vous l'avez laissée."),
      "ui_community_running_none": MessageLookupByLibrary.simpleMessage(
          "Vous n'en gérez aucune pour l'instant"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Plus rien à rejoindre"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Vous êtes dans toutes les communautés de Kyron. Créez-en une autre."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Essayez un autre mot, ou créez une communauté de ce nom."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Écrire une publication"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Membres :"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Publié"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Voir"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Ouvrir"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("En ligne"),
      "ui_dm_show_online": MessageLookupByLibrary.simpleMessage(
          "Indiquer quand vous êtes en ligne"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Les personnes à qui vous écrivez voient un point vert tant que Kyron est ouvert. Désactivé, vous ne verrez pas non plus le leur."),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "Rechercher des personnes et des publications"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Communautés à rejoindre"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Rien à voir pour l'instant"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Les photos et clips que les gens publient apparaîtront ici."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Suivre"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Supprimer le compte"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Cette action supprime définitivement votre compte Kyron. Elle est irréversible."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Votre profil, vos publications, réponses, mentions J'aime et republications"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Vos messages, y compris ceux que vous avez envoyés à d'autres personnes, ainsi que les photos et messages vocaux qu'ils contiennent"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Vos abonnés, les personnes que vous suivez et vos paramètres"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Les communautés que vous avez créées passent au modérateur ou au membre le plus ancien. Une communauté sans autre membre est fermée."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Supprimer votre compte ?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Vous ne pourrez rien en récupérer."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Votre compte a été supprimé."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Compte supprimé"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Ce compte a été supprimé : il n'est plus possible d'envoyer des messages ici."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Inscrit avec Google ? Utilisez plutôt « Sign in with Google »."),
    };

final messageLookup = MessageLookup();
