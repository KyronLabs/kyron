import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'eu';

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
      "change": MessageLookupByLibrary.simpleMessage("Aldatu"),
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
      "contactSupport": MessageLookupByLibrary.simpleMessage(
          "Jarri harremanetan laguntzarekin"),
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
      "done": MessageLookupByLibrary.simpleMessage("Eginda"),
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
      "report": MessageLookupByLibrary.simpleMessage("Salatu"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Salaketa bidalita"),
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
      "sendReport": MessageLookupByLibrary.simpleMessage("Bidali salaketa"),
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
      "tryAgain": MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
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
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "ui_community_posts":
          MessageLookupByLibrary.simpleMessage("Argitalpenak:"),
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
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Taldeak"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("Ez dago talderik"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Hemen agertzen dira zauden taldeak eta batzen zaren komunitateko txatak."),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Gustukoak"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Gordetakoak"),
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
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Admin"),
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
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Aukeratu zure hizkuntza"),
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
      "ui_notif_tab_replies":
          MessageLookupByLibrary.simpleMessage("Erantzunak"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Aste honetan"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Gaur"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Zure kontuak ohartarazpen bat du"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Atzo"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
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
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Saiatu berriro"),
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
        "Zer gertatu da, eta zer begiratu behar dugu?",
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
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
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
    };

final messageLookup = MessageLookup();
