import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'it';

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
      "change": MessageLookupByLibrary.simpleMessage("Cambia"),
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
          MessageLookupByLibrary.simpleMessage("Contatta l'assistenza"),
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
      "done": MessageLookupByLibrary.simpleMessage("Fatto"),
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
      "report": MessageLookupByLibrary.simpleMessage("Segnala"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent":
          MessageLookupByLibrary.simpleMessage("Segnalazione inviata"),
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
      "sendReport": MessageLookupByLibrary.simpleMessage("Invia segnalazione"),
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
      "tryAgain": MessageLookupByLibrary.simpleMessage("Riprova"),
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
          "Stavo citando la truffa per mettere in guardia le persone."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Spiega perché pensi che la decisione sia sbagliata: cosa intendeva il post, cosa potrebbe essere sfuggito al team o perché la regola non è adatta. Lo legge una persona diversa da chi ha deciso."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Il tuo ricorso"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Scrivi almeno \$count caratteri. Puoi fare ricorso contro ogni decisione una sola volta."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Invia ricorso"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Ricorso inviato. Riceverai una notifica quando verrà presa una decisione."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Ricorso sul caso \$number"),
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
          MessageLookupByLibrary.simpleMessage("A cosa serve (facoltativo)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Solo i moderatori possono scrivere"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Per gli annunci. Tutti nella community possono comunque leggere e reagire."),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "Aggiungi una foto o un sondaggio"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Foto e video"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Chiudi chat"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Nessuno potrà più leggerla né scriverci. L’azione non si può annullare."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Chiudere questa chat?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Copiato"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Il messaggio viene rimosso per tutti. Kyron ne conserva una copia per la revisione."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Il messaggio viene rimosso per tutti nella chat."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Modifica chat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Modifica"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("modificato"),
      "ui_cchat_editing": MessageLookupByLibrary.simpleMessage(
          "Stai modificando il tuo messaggio"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile aprire questa chat."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Unisciti alla chat"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Unisciti alla community per vedere le sue chat e partecipare."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count iscritti"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Esci dalla chat"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Potrai comunque leggerla finché sei nella community."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Solo il proprietario e i moderatori possono scrivere qui."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Silenzia"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Nessuna notifica da questa chat, e non viene contata nei Messaggi."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Nome della chat"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Nuova chat"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Ancora nessuna chat."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Ancora nessuna chat. Aprine una per la community."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Le chat della community non sono crittografate end-to-end. I moderatori della community e Kyron possono leggerle."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Fissa in alto"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Aggiungi una risposta"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Chiudi sondaggio"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Chiuso"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Tutti vedono quante persone hanno scelto ogni risposta, mai chi."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Consenti più scelte"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Nuovo sondaggio"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Scegline una"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Risposta \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Sondaggio: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Domanda"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Ogni risposta può comparire una sola volta in un sondaggio."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Scegline una o più"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count hanno risposto"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Cerca in questa chat"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Cerca in questa chat"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Nessun risultato."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Non puoi più vedere questa chat."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Modalità lenta"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Quanto si aspetta tra un messaggio e l’altro. Non vale per i moderatori."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 ora"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minuti"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Modalità lenta: un messaggio ogni \$seconds secondi"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Disattivata"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n secondi"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Puoi leggere e reagire come spettatore. Unisciti per scrivere."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Quel messaggio è troppo indietro per essere mostrato."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Qualcosa che hai scelto è troppo grande da inviare ed è stato escluso."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Riattiva notifiche"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Non fissare più"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Registra un messaggio vocale"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Tu"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Post:"),
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
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Gruppi"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("Nessun gruppo"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Qui trovi i gruppi di cui fai parte e le chat delle community a cui ti unisci."),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Mi piace"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Salvati"),
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
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Aggiungi persone"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Aggiungi"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Aggiungi nome del gruppo"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Ignora"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "I messaggi in questo gruppo sono crittografati end-to-end, come in ogni altra conversazione."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor ha aggiunto \$users"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor ha reso \$users admin"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor ha creato il gruppo"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor fa entrare le nuove persone come membri"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor fa entrare le nuove persone come spettatori"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor è uscito"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor ha reso \$users membro"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor ha reso \$users proprietario"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor ha rimosso \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor ha rinominato il gruppo in \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor ha reso \$users spettatore"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Un gruppo può avere al massimo \$count persone."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Mano alzata. Gli admin sono stati avvisati."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count chiedono di scrivere"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Chiedono di scrivere"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Chi viene aggiunto dopo entra come spettatore"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Esci dal gruppo"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Sparisce dalla tua lista e non vedrai cosa verrà detto dopo. Qualcuno dovrebbe aggiungerti di nuovo."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Uscire da questo gruppo?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Lascia scrivere"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Abbassa la mano"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Rendi admin"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Rendi proprietario"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Rendi spettatore"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count membri"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Membri"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Nome del gruppo"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Prima dai un nome al gruppo."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Crea chat di gruppo"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "C’è un solo proprietario. Resterai admin."),
      "ui_group_owner_title": MessageLookupByLibrary.simpleMessage(
          "Rendere \$name il proprietario?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Alza la mano"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Rimuovi dal gruppo"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Rimuovi da admin"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Non fai più parte di questo gruppo."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Rinomina"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Admin"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Membro"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Spettatore"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Come spettatore, qui puoi leggere e reagire."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Gli spettatori possono leggere, reagire e alzare la mano per chiedere di scrivere."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Suggeriti"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Vedi profilo"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("tu"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Sei uno spettatore"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Scegli la tua lingua"),
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
          "Il tuo account è stato aggiornato"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Il tuo ricorso sul caso \$number è stato accolto"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Abbiamo riesaminato il tuo ricorso sul caso \$number e la decisione resta valida"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è stato bannato"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Caso \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("ha iniziato a seguirti"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("ha messo mi piace al tuo post"),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Meno recenti"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Il tuo messaggio in una chat della community è stato rimosso"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Qualcosa che hai pubblicato è stato rimosso"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Il tuo post è stato rimosso"),
      "ui_notif_removed_reply": MessageLookupByLibrary.simpleMessage(
          "La tua risposta è stata rimossa"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("ha risposto al tuo post"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Abbiamo preso provvedimenti su qualcosa che hai segnalato. Grazie per avercelo detto."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Abbiamo esaminato qualcosa che hai segnalato e non abbiamo riscontrato violazioni delle nostre regole."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Segnalato per: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("ha ripubblicato il tuo post"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Abbiamo annullato il caso \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Il tuo account è sospeso"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è sospeso fino al \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Tutte"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Mi piace"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Risposte"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Questa settimana"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Oggi"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Il tuo account ha ricevuto un avvertimento"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Ieri"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("È già stato aperto."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Scaduto"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Impossibile aprirlo."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Si apre una volta, poi viene eliminato da Kyron."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Visualizza una volta"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Aperto"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Aperto da \$count su \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Solo le persone a cui l’hai inviato possono aprirlo, una volta."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Invia con visualizzazione singola"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Tocca per vedere"),
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
          "Qualcosa da aggiungere? (facoltativo)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Riceverai una notifica quando il team avrà deciso e puoi seguire la segnalazione in Le tue segnalazioni."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Se vuoi anche smettere di vedere questa persona, silenziala o bloccala dallo stesso menu."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Segnalare due volte la stessa cosa non le dà più peso: teniamo una segnalazione per persona."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "La tua segnalazione non viene condivisa con l'altra persona. Conserviamo una copia di ciò che hai segnalato, così può essere esaminato anche se viene eliminato."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "La tua segnalazione è stata ricevuta ed è in coda per la revisione. Non diciamo all'altra persona chi l'ha segnalata."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Vedi le tue segnalazioni"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Dicci cosa non va"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Grazie per avercelo detto"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Cosa non va con \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Cosa non va in questo messaggio?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("Cosa non va in questo post?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Cosa non va in questa risposta?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Un messaggio in una chat della community"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Un post"),
      "ui_reports_a_reply":
          MessageLookupByLibrary.simpleMessage("Una risposta"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Provvedimento preso"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("Un account"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Deciso il \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Nessuna regola violata"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare le tue segnalazioni"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Quello che hai segnalato negli ultimi 90 giorni e com'è andata. Ricevi una notifica quando il team decide. Chi segnali non sa mai chi l'ha segnalato."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Nessuna segnalazione"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Quando segnali un post, una risposta, un messaggio o un account, compare qui con com'è andata."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("In revisione"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Segnalato il \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Cosa hai segnalato e com'è andata"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Le tue segnalazioni"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Sicurezza dei minori"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Qualsiasi cosa che metta in pericolo o sessualizzi un minore."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Abusi mirati, minacce o contatti indesiderati."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Attacchi alle persone per ciò che sono."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Vendita o promozione di qualcosa di illegale."),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("Fingersi qualcun altro."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Usa la tua opera o il tuo marchio senza permesso."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Affermazioni fuorvianti su salute, elezioni o eventi."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Incoraggiare o mostrare l'autolesionismo."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Contenuti sessuali mostrati senza avviso."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Nessuna delle precedenti. Dicci cosa non va."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Promozione ripetitiva, ingannevole o indesiderata."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Minacciare, esaltare o incitare a fare del male."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Molestie o bullismo"),
      "ui_rule_hate":
          MessageLookupByLibrary.simpleMessage("Incitamento all'odio"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Beni o servizi illegali"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Sostituzione di persona"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Proprietà intellettuale"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Informazioni false"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Suicidio o autolesionismo"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Contenuti per adulti"),
      "ui_rule_something_else": MessageLookupByLibrary.simpleMessage("Altro"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spam"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Violenza o minacce"),
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
          MessageLookupByLibrary.simpleMessage("Di cosa si trattava"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è stato bannato"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("La risposta, il \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Ricorso"),
      "ui_standing_appeal_button": MessageLookupByLibrary.simpleMessage(
          "Fai ricorso contro questa decisione"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Non è più possibile fare ricorso contro questa decisione. Se qualcosa non va, contatta l'assistenza."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Ricorso in esame"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Ricorso accolto"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Un'altra persona del team la sta riesaminando. Riceverai una notifica quando verrà presa una decisione."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Se pensi che sia un errore, puoi chiedere un riesame fino al \$date. Decide un'altra persona del team."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Ricorso esaminato: la decisione resta valida"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Caso \$number. Regola: \$rule. Il team ha scritto:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Eliminare il tuo account non revoca un ban: anche un nuovo account con lo stesso indirizzo email parte bannato."),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("Bannato"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Funzionano ancora solo questa pagina, i ricorsi, l'assistenza e l'eliminazione dell'account."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Puoi fare ricorso"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Caso \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Deciso il \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Decisioni sul tuo account"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Elimina il tuo account"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Vedi dettagli"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Vedi dettagli e fai ricorso"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Termina il \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Il tuo account è in regola"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Nessuna limitazione attiva."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare lo stato dell'account"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Messaggio rimosso"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Non è stato deciso nulla sul tuo account. Se il team dovesse rimuovere qualcosa di tuo o limitare il tuo account, lo troverai qui con il motivo e potrai fare ricorso."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Niente da contestare: la decisione è stata annullata."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Post rimosso"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Trascina verso il basso per ricontrollare."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Leggi le regole di Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Risposta rimossa"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Annullata"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Annullata il \$date. Tutto ciò che era stato rimosso è tornato e nessuna limitazione è più in vigore."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Regola: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Esci"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("Sospeso"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Puoi leggere, ma non pubblicare, rispondere, seguire o inviare messaggi. Segnalare, bloccare e silenziare funzionano ancora."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è sospeso: puoi leggere, ma non pubblicare."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Sospeso fino al \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è sospeso fino al \$date: puoi leggere, ma non pubblicare."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Cosa ha detto il team"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Stato dell'account"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Avvertimento"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Perché?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Hai scritto, il \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Il tuo messaggio"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Il tuo post"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("La tua risposta"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Riprova"),
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
        "Cosa è successo e cosa dovremmo controllare?",
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
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Hai risposto"),
      "dmReplied": (Object a0) => "$a0 ha risposto",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Aggiungi al messaggio"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Nuovo messaggio"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Non è stato ancora detto nulla. Un saluto è un buon inizio."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Saluta"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Nuovi messaggi"),
      "dmTyping": (Object a0) => "$a0 sta scrivendo",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Rimuovi la tua reazione"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Qualcuno"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Messaggio"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Allegato"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Questo messaggio non può essere letto su questo dispositivo."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "In attesa di questo messaggio. Potrebbe volerci un po’."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Messaggio crittografato"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "I messaggi sono crittografati end-to-end"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Non crittografato end-to-end"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Inviato"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Visualizzato"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Invio in corso…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Scatta una foto"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Altre opzioni"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Salva sul dispositivo"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Condividi"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Salvataggio…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Salvato nelle tue foto"),
      "ui_media_save_failed":
          MessageLookupByLibrary.simpleMessage("Impossibile salvare. Riprova."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Consenti a Kyron di aggiungere alle tue foto per salvarlo."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Tutti i sistemi operativi"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Disponibilità"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Ultimi 60 giorni"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 giorni fa"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Oggi"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Database"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Accesso"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Incidenti recenti"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Nessun incidente negli ultimi 60 giorni."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("In corso"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Nessun dato"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Dettagli"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron si controlla ogni 5 minuti mentre è in funzione. Un giorno grigio non ha avuto controlli."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "La cronologia della disponibilità non è ancora disponibile."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Alcuni sistemi hanno problemi"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Registra un messaggio vocale"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Pronto da inviare"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Quel messaggio non c'è più."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Vai al messaggio"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Messaggio vocale"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Piace all'autore"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Aggiungi una foto o un clip"),
      "ui_dm_info_media":
          MessageLookupByLibrary.simpleMessage("Contenuti multimediali"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Messaggi vocali"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Sfondo"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Silenzia le notifiche"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Non ricevere più notifiche su questa conversazione"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("Non possono più scriverti"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Nessuno"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Notifiche riattivate."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile rimuoverla. Riprova."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profilo"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Riattiva"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Le foto e i clip che condividi compaiono qui."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Mostra tutto"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("Foto e clip"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Ecco come apparirà la tua chat."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Sta bene."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Foschia"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Crepuscolo"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Salvia"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Sabbia"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Puntini"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Applica"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Attuale"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Invia senza anteprima"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Cerca"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Pubblica"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Scrivi un messaggio…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Invia"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Inviato"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Inviato, ma non a tutti."),
      "ui_share_failed":
          MessageLookupByLibrary.simpleMessage("Impossibile inviare. Riprova."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtro"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Tutte"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Da leggere"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Senza risposta"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Nascoste"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Niente di nascosto"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Le conversazioni che togli dall'elenco aspettano qui, nel caso tu le voglia riavere."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Passa tra le Nascoste. L'altra persona tiene la sua, e torna se uno di voi due scrive di nuovo."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Ripristina"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Di nuovo nel tuo elenco."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "Nessuna conversazione corrisponde."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Niente ti aspetta"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ogni conversazione finisce con la tua parola."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Ancora nessun messaggio"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Tu:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Ieri"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Messaggi"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Impostazioni dei messaggi"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Conferme di lettura"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Se disattivate, gli altri non vedranno quando hai letto i loro messaggi, e tu non vedrai quando loro hanno letto i tuoi."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Mostra quando scrivi"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "La persona a cui scrivi vede che stai scrivendo."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Anteprime dei link"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Il tuo telefono apre il link che invii per crearne l'anteprima, quindi il sito vede la richiesta del tuo telefono. Il server di Kyron non vede mai il link."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Notifiche dei messaggi"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "I messaggi sono crittografati end-to-end. Kyron non può leggerli, e niente qui lo cambia."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("A:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Recenti"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Persone"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Nessuno con questo nome."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Invia una notifica di prova"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Il server di Kyron non è ancora configurato per inviare notifiche, quindi non ne può arrivare nessuna. Il problema è nostro, non del tuo telefono."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Questo telefono non è registrato per le notifiche. Controlla che le notifiche di Kyron siano consentite nelle impostazioni del telefono, poi riprova."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Impossibile recapitare la notifica a questo telefono. Riprova tra un minuto."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Inviata. Dovrebbe arrivare in pochi secondi."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Le notifiche funzionano."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Ancora nessun post"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Nuova community"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Nome"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Il suo indirizzo nasce dal nome."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("La troveranno all'indirizzo"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Ne sarai il proprietario. Un'immagine, un banner e i moderatori si aggiungono dalla sua pagina, una volta creata."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Home"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Post delle community nella Home"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "I post delle tue community compaiono anche nella Home. Se disattivato, restano qui in Community, dove ognuna mostra cosa c'è di nuovo."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("La tua lista"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Conteggio dei nuovi post"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Mostra quanti post sono nuovi in ogni community dall'ultima volta che l'hai aperta."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Community che gestisci"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Qui trovi le community che crei o moderi."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Proprietario"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderatore"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Nuovi post"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Gestite da te"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Impostazioni community"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Scopri"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "Nessuna community corrisponde."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Niente di nuovo"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ogni community è come l'hai lasciata."),
      "ui_community_running_none": MessageLookupByLibrary.simpleMessage(
          "Non ne gestisci ancora nessuna"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Non resta nulla a cui unirsi"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Sei in ogni community di Kyron. Creane un'altra."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Prova un'altra parola, o crea una community con quel nome."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Scrivi un post"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Membri:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Pubblicato"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Vedi"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Apri"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Online"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Mostra quando sei online"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Le persone a cui scrivi vedono un punto verde mentre hai Kyron aperto. Se lo disattivi, nemmeno tu vedrai il loro."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Cerca persone e post"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Community a cui unirti"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Ancora niente da vedere"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Le foto e le clip pubblicate dalle persone appariranno qui."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Segui"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Elimina account"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "In questo modo il tuo account Kyron viene eliminato per sempre. L'operazione non può essere annullata."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Il tuo profilo, i post, le risposte, i Mi piace e le ricondivisioni"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "I tuoi messaggi, compresi quelli che hai inviato ad altri, con le foto e i messaggi vocali che contengono"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "I tuoi follower, le persone che segui e le tue impostazioni"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Le community che hai creato passano al moderatore o al membro presente da più tempo. Una community senza nessun altro viene chiusa."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Eliminare il tuo account?"),
      "ui_delete_account_confirm_detail":
          MessageLookupByLibrary.simpleMessage("Non potrai recuperarne nulla."),
      "ui_delete_account_done": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è stato eliminato."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Account eliminato"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Questo account è stato eliminato, quindi non è più possibile inviare messaggi qui."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Ti sei registrato con Google? Usa invece «Sign in with Google»."),
    };

final messageLookup = MessageLookup();
