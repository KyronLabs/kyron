import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'am';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
        "አንድ ቃል፣ ንግግር ወይም #መለያ",
      ),
      "about": MessageLookupByLibrary.simpleMessage("ስለ እኛ"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("መልስ አክል"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("ተጨማሪ ቋንቋዎች ያክሉ…"),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage("ተስማምተው ይቀጥሉ"),
      "alreadyOnKyron": MessageLookupByLibrary.simpleMessage(
        "እስከ አሁን Kyron ላይ አለህ?",
      ),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("አስተያየቶች"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
        "የተለያዩ ሰዎች፣ አይከፈቱም",
      ),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("እርሳታ"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("ከፈለጉ"),
      "analytics_no_viewers_yet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን እይታዎች የሉም",
      ),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
        "ወደዚህ ጽሑፍ ማንም አልከፈተውም።",
      ),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("ታስተካለ"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("ተቀይረዋል"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("እይታዎች"),
      "analytics_viewers_per_day": MessageLookupByLibrary.simpleMessage(
        "VIEWERS PER DAY",
      ),
      "and": MessageLookupByLibrary.simpleMessage("እና"),
      "answerNumber": (Object a0) => "መልስ ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage("የስርዓት ሎግ ያስገቡ"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("ትራይፕ ወደ ወይም መጓዝ"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("TOKEN VERIFICATION"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("ደግሞ ይሞክሩ"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("ደግሞ ይሞክሩ"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
        "አሁን ስርጭት ጀምሮ ወደ ክፍል ያስገባዋል የማይችል ማንም ማዕከል እንዲያዩ",
      ),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("ማህበር ጀምር"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("ይህ ስለምንድን ነው? (አማራጭ)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("ወደ ቀረበው ይመለሳሉ።"),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("ከዚህ ዝርዝር ወደ ቀረው ይመለሳሉ።"),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("መዝጊያው"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("የመጀመሪያ ተቀላቀል"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("በቅርብ ይመጣል"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("እርስዎ እየታሰሩ ይለቀቃሉ"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("በዚህ ማህበር ውስጥ ይለቀቁ"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage(
        "አሁን ብቻ",
      ),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage(
        "ደግሞ ይሞክሩ",
      ),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage(
        "ርዕስ 1",
      ),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage(
        "እርስዎ ለዎ",
      ),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("ምንም አለ።"),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("እሱ አሁን በመንገዱ ነው።"),
      "audit_google_button_not_bbd76526": MessageLookupByLibrary.simpleMessage(
        ", አይደለም",
      ),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("እኔ እንደምትንቀሳቀስ ነው?"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("ድምጽን ዝም በል"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("ድምጽን አብስል"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage(
        "እርስዎ ለ",
      ),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("ያሉ ትክክለኛ ምርጫዎች"),
      "audit_media_tray_alt_784030d4": MessageLookupByLibrary.simpleMessage(
        "+ ALT",
      ),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("ደግሞ ይሞክሩ"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("ምልክት (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("VIEWERS PER DAY"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("ማስገባት አልቻለም"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ይህ ጽሑፍ"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("ለማከማቻ የሚጨምር ነገር? (አማራጭ)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ይህ ጽሑፍ"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("ከአካውንት ውስጥ"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("ውጣ"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("የእርስዎ መለያ"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("የይለፍ ቃል ያረጋግጡ"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("አሁን አይደለም"),
      "audit_skeleton_loading_18e82bcc": MessageLookupByLibrary.simpleMessage(
        "በማንቀሳቀስ…",
      ),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87": MessageLookupByLibrary.simpleMessage(
        "ማስቀምጥ…",
      ),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage(
        "3h በፊት",
      ),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("የታሪክ አገናኝ ቅዳ"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("የእርስዎ ታሪክ"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
        "የእርስዎ መለያ፣ የምታስቀምጡ ጽሑፎች እና ያጫኑት ነገሮች",
      ),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("ርዕስ ጨምር"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage(
        "የራሱ ነው።",
      ),
      "authorBlocked": (Object a0) => "${a0} ተከለ",
      "authorPostsHidden": (Object a0) => "ከ${a0} የተለዩ ጽሑፎች አልታያዎታም",
      "block": MessageLookupByLibrary.simpleMessage("አቋርጥ"),
      "blockAuthor": (Object a0) => "${a0}ን አቋርጥ?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
        "የግንባታ ዝርዝሮች ተቀይረዋል",
      ),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "ቀጥሎ የእኛን ውሎች ታስረዋል",
      ),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
        "ቀጥሎ በመቀጠል የእኛን ውልና የግላዊነት ፖሊሲ ታስረዋል።",
      ),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "በምዝገባ ውስጥ እርስዎ የእኛን ውሎች ታስረዋል",
      ),
      "cancel": MessageLookupByLibrary.simpleMessage("ይቅር"),
      "change": MessageLookupByLibrary.simpleMessage("ቀይር"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("ኢሜይል ቀይር"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
        "አካውንትዎን ለማረጋገጥ ኢሜይልዎን ይፈትሹ።",
      ),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
        "Kyron እዚያ ደርሶ ይደርሳል ወይስ እንደማይደርስ ይወቁ",
      ),
      "clear": MessageLookupByLibrary.simpleMessage("አጽዳ"),
      "close": MessageLookupByLibrary.simpleMessage("ዝግ"),
      "closeCommunity": (Object a0) => "${a0}ን ዝጉ?",
      "closeIt": MessageLookupByLibrary.simpleMessage("እሱን ዝጉ"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("እንዲህ ማህበር ዝግ"),
      "communities": MessageLookupByLibrary.simpleMessage("ማህበረሰቦች"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "በDiscover ውስጥ አንድ ይፈልጉ፣ ወይም የእርስዎን ያክሉ።",
      ),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
        "ሀይቅ የሆነ አስተያየት ያስገቡ (ወይም የምቹ ያለው)",
      ),
      "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
        "በራስዎ ውስጥ የሚንጋገር ምንድን ነው?",
      ),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
        "የእርስዎን የብቸኛ የሚገልጥ ነገር ይናገሩ…",
      ),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
        "ይህ ምልክትዎ ነው — ይላኩት",
      ),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
        "ይጻፉ፣ ይናገሩ፣ ወይም ከፍ ያሉ ሐሳቦችን ያስብ",
      ),
      "confirmPassword": MessageLookupByLibrary.simpleMessage("የይለፍ ቃል ያረጋግጡ"),
      "contactSupport": MessageLookupByLibrary.simpleMessage("ድጋፍ ያግኙ"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
        "ጽሑፎች እስካሁን ቋንቋ አልተሰጠም፣ ስለዚህ ዛሬ እርስዎን የሚሰናዳ ማረጋገጫ አይደለም። ምርጫዎቹ ለሚሆኑ ጊዜያት ይታያሉ።",
      ),
      "continueAction": MessageLookupByLibrary.simpleMessage("ቀጥል"),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage("በኢሜይል ቀጥሉ"),
      "copy": MessageLookupByLibrary.simpleMessage("ቅዳ"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("ነገር ግን ሪፖርቱን ይቅዱ"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google የመግባት ገጽ ሊክ ሊከፈት አልቻለም። ${a0}",
      "couldNotSignOut": (Object a0) => "ማግፈጫ ማውጣት አልተቻለም፦ ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
        "ያ ፎቶ ማንበብ አልተቻለም።",
      ),
      "create": MessageLookupByLibrary.simpleMessage("ፍጠር"),
      "createAccount": MessageLookupByLibrary.simpleMessage("መለያ ፍጠር"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("የእርስዎን መለያ ፍጠር"),
      "createYourProfile": MessageLookupByLibrary.simpleMessage("መገለጫዎን ፍጠር"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("ቀጥሎ ይቀርቡ"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("ጽሑፍ ፖስት"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("የድምጽ ፖስት ፍጠር"),
      "delete": MessageLookupByLibrary.simpleMessage("ይሰርዙ"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("ይህን አስተያየት ይሰርዙ?"),
      "deleteThisPost": MessageLookupByLibrary.simpleMessage("ይህን ጽሑፍ ይሰርዙ?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("ይህን አባሪ ይገልጹ"),
      "description": MessageLookupByLibrary.simpleMessage("መግለጫ"),
      "didCopied": MessageLookupByLibrary.simpleMessage("DID ወደ ቅፅ ተቀይሯል"),
      "done": MessageLookupByLibrary.simpleMessage("ተካሂዷል"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
        "ኮምፖዘሩን ከፈጽሙ እና ነገር በዝርዝር ከሆነ የንዑስ ሥያሜ እንደሚቀርብ ይገምቱ",
      ),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} ቀናት በፊት"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} ሰዓታት በፊት"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("አሁን ብቻ"),
      "draft_minutes_ago": MessageLookupByLibrary.simpleMessage(
        "{minutes} ደቂቃ በፊት",
      ),
      "draft_nothing_empty": MessageLookupByLibrary.simpleMessage(
        "እስካሁን ምንም አልተፃፈም",
      ),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("ምርጫ፣ ጥያቄ ያለው አልባ"),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage(
        "እባክዎን ጥቅስ፣ ምንም ከዚያ በፊት አልተጻፈም",
      ),
      "drafts": MessageLookupByLibrary.simpleMessage("ንዑሶች"),
      "editProfile": MessageLookupByLibrary.simpleMessage("መገለጫ አርትዕ"),
      "email": MessageLookupByLibrary.simpleMessage("ኢሜይል"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("የኢሜይል ማሳወቂያዎች"),
      "explore": MessageLookupByLibrary.simpleMessage("አስማሚ"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
        "በዚህ መሣሪያ የፊት መከታተያ አይገኝም።",
      ),
      "feedTagDetail": (Object a0) => "እስካሁን #${a0} በታች ምንም አልተቀረጠም።",
      "followers": MessageLookupByLibrary.simpleMessage("ተከታታዮች"),
      "following": MessageLookupByLibrary.simpleMessage("ታከታይ"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage("የይለፍ ቃልዎን ረሳታል?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("የሚረዱ ማግኘት"),
      "googleContinue": MessageLookupByLibrary.simpleMessage("በGoogle ቀጥሉ"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("በGoogle ይግቡ"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google የተጠናቀቀውን መግባት በአንድ አገናኝ በKyron ይደርሳል የሚባለውን በAndroid እና iOS ብቻ የሚመለስ፣ ስለዚህ በ${a0} አሣይ ሊመለስ የሌለው ነው።\\n\\nከGoogle ጋር አካውንት ካለዎት ከዚያ በተዛማጅ አድራሻ በ\"Continue with email\" ይጠቀሙ እና \"Forgot password\" ይጫኑ — የይለፍ ቃል ለመቀየር ሊሰጥዎት የሚችለውን አገናኝ ኢሜይል ይልካል።",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
        "Google የመግባት እርዳታ ስለሚፈልግ የስልክ መተግበሪያ ይፈልጋል",
      ),
      "googleSignUp": MessageLookupByLibrary.simpleMessage("በGoogle ይመዝገቡ"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
        "መመሪያዎች እና የተደጋጋሚ ጥያቄዎች መልሶች",
      ),
      "handle": MessageLookupByLibrary.simpleMessage("የእርስዎ ስም"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("ድጋፍ እና ዕጣ እገዛ"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("የእገዛ ማዕከል"),
      "home": MessageLookupByLibrary.simpleMessage("ቤት"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("በአንድ መስመር"),
      "interest_add": MessageLookupByLibrary.simpleMessage("ፈለግ ያክሉ"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
        "ቅደም ተከተል ለማድረግ ይጫኑ እና ያዘዋው",
      ),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
        "አርባዎቹ ከንፈር ከፍ ይወስዳሉ። ሌላ ለማክለት አንዱን ይወድቁ።",
      ),
      "interest_following": MessageLookupByLibrary.simpleMessage("የሚከተሉ"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("የእርስዎ ነው"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
        "ሰዎች ሲጀምሩ ሃሽታጎች እዚያ ይታያሉ።",
      ),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("አሁን በዘመን ላይ"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("ቪዲዮዎች"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("የእርስዎ ትይታዎች"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("ለሁለቱም ይሰረዛል።"),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage("ከዝርዝሩ ይወገዳል።"),
      "join": MessageLookupByLibrary.simpleMessage("ተቀላቀሉ"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("ማስተካከያን ቀጥሉ"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
        "የKyron ቃሎች እየተተረጉሙ ስለሆኑ አብዛኛዎቹ መስኮች በእንግሊዝኛ ናቸው።",
      ),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("ቋንቋዎች"),
      "leave": MessageLookupByLibrary.simpleMessage("ተተው"),
      "leaveCommunity": (Object a0) => "${a0}ን ትተዋለህ?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("እንድታስመለስ ፍቀድ"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("1 ገፅ ተክፈቷል"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("ክሊፕ አክል"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF አክል"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("መለያ ተጨማሪ አድርግ"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("ፎቶ አክል"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("ምርጫ ጨምር"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("ቪዲዮ አክል"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("አንድ ፈለግ ያክሉ"),
      "literaladdLabelAsATab": (Object a0) => "${a0}ን እንደ ማስታወቂያ ያክሉ",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("የመተግበሪያ ቋንቋ"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("የመተግበሪያ ትዕዛዝ"),
      "literalblockAuthor": (Object a0) => "${a0}ን አቋርጥ",
      "literalblockAuthor2": (Object a0) => "${a0}ን አቋርጥ?",
      "literalblockThisAccount": MessageLookupByLibrary.simpleMessage(
        "ይህን መለያ አቋርጥ?",
      ),
      "literalcancelReply": MessageLookupByLibrary.simpleMessage("መልስ ይቅር"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("ዳግም ይፈትሹ"),
      "literalchooseFromGallery": MessageLookupByLibrary.simpleMessage(
        "ከጋለሪው ይምረጡ",
      ),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("ካሽ አጽዳ"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("ሁሉንም ገፆች ዝግ"),
      "literalcloseTabLabel": (Object a0) => "${a0} ዝግ",
      "literalcloseTheBrowser": MessageLookupByLibrary.simpleMessage("አሣይን ዝግ"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0}ን ዝጉ?",
      "literalcontactSupport": MessageLookupByLibrary.simpleMessage("ድጋፍ ያግኙ"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("የይዘት ቋንቋዎች"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("አገናኝ ቅዳ"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
        "ወደ ጽሑፉ ያለውን አገናኝ ቅዳ",
      ),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("የጽሑፍ ጽሑፍ ቅዳ"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("ጽሑፍ ቅዳ"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
        "ማህበረሰቦችን ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadGifs": MessageLookupByLibrary.simpleMessage(
        "GIFs ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
        "ማሳወቂያዎችን ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
        "አባላቱን ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
        "እነዚህን ጽሑፎች ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
        "ይህን ውይይት ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
        "ይህን ዝርዝር ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
        "ይህን ጽሑፍ ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
        "ይህን መልስ ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
        "የሚስማሙ መለያዎችን ማስገባት አልቻለም",
      ),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
        "የእርስዎን ማህበረሰቦች ማካተት አልቻለም",
      ),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
        "መልዕክቶችዎን ማስገባት አልቻለም",
      ),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
        "ይህን ማህበር ሊክፈት አልቻለም",
      ),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
        "ያ መልስ ማስቀመጥ አልቻለም።",
      ),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("መፈለጊያ አልተሳካም"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "ማግፈጫ ማውጣት አልቻለም፦ ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} ገፆች ተክፈተዋል",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("ኮቨር ፎቶ"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("የውሂብ ቆጣቢ"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("ጽሑፉን ሰርዝ"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("ሰዎችን ይገናኙ"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("አትመለሱ"),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage("ንዑስ ተያዙ"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
        "አስተያየት አሁን ሊልካ አይችልም",
      ),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("የፊደል መጠን"),
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
        "GIFs አልተዘጋጁም",
      ),
      "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage(
        "እንደ ሌላ መተግበሪያ ልክ ሰጥተው",
      ),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("የይለፍ ቃል ደብቅ"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("ይህን ጽሑፍ ደብቅ"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
        "ይህን ይደበራል፣ እና እንዲሁ ያሉን ለመታየት የሚያሳይ ብዛት ይንሳፋፋል",
      ),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("እንዴት እንደሚያገለግሉ"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("ቀጥል በማስተዋል ይጻፉ"),
      "literalkyronDidNotAnswer": MessageLookupByLibrary.simpleMessage(
        "Kyron ምንም አልመለሰም",
      ),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} ቀን",
      "literalleaveCommunityName": (Object a0) => "${a0}ን ትተዋለህ?",
      "literallensNameFaceLens": (Object a0) => "${a0}, የፊት ሌንስ",
      "literallikedPosts": MessageLookupByLibrary.simpleMessage("የተፈለጉ ጽሑፎች"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("አገናኝ ተቀይሯል"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("ሞዴሬተር አድርግ"),
      "literalmuteAuthor": (Object a0) => "${a0}ን ዝም በል",
      "literalmuteThisThread": MessageLookupByLibrary.simpleMessage(
        "ይህን ገጽታ ዝም ብለው ያደርጉ",
      ),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
        "ቃላት ወይም መለያዎች ዝም በሉ",
      ),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
        "ዝም ብለው የታሰሩ እና የተከለ መለያዎች",
      ),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
        "ዝም ብለዋል። አሳውቀን አይቀርም።",
      ),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "በዚህ መሣሪያ ${a0} ያሉ አገናኝ የሚክፈቱ መተግበሪያ የለም።",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
        "በዚህ መሣሪያ ላይ የዚያን አገናኝ የሚከፈት አሣይ የለም።",
      ),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("DID እስካሁን የለም"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("ንዑሶች የሉም"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን ምንም ትወዳድሩ የሉም",
      ),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("እስካሁን ከፈለጉ የሉም"),
      "literalnoMessagesYet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን መልዕክቶች የሉም",
      ),
      "literalnoNewFollowers": MessageLookupByLibrary.simpleMessage(
        "አዲስ ተከታታዮች የሉም",
      ),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("እስካሁን ጽሑፎች የሉም"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("እስካሁን መልሶች የሉም"),
      "literalnoRepostsYet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን የተዘረጋ ፖስቶች የሉም",
      ),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
        "ማንኛውም የሚስማሙ መለያ አይደለም",
      ),
      "literalnobodyFound": MessageLookupByLibrary.simpleMessage("ማንም አላገኘም"),
      "literalnobodyHasBeenRemoved": MessageLookupByLibrary.simpleMessage(
        "አንድም ሰው አልወገደም",
      ),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("እስካሁን አይነቡም"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis": MessageLookupByLibrary.simpleMessage(
        "በዚህ እውቅ የለም",
      ),
      "literalnothingFound": MessageLookupByLibrary.simpleMessage("ምንም አልተገኘም"),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን ምንም አይታወቅም",
      ),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን ምንም ከተመዘገበ የለም",
      ),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("ምንም አልተመሳሰለም"),
      "literalnothingMuted": MessageLookupByLibrary.simpleMessage("ምንም አልተዝሙ"),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን ለማየት ነገር የለም",
      ),
      "literalnothingUnread": MessageLookupByLibrary.simpleMessage(
        "እንዲያም የማይታወቀው የለም",
      ),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
        "ይህን የሚቀይር ብቻ ባለቤት ነው",
      ),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("መልስ ክፈት"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
        "ከKyron የመላኪያውን ኢሜይል ክፈት",
      ),
      "literalpasswordLogin": MessageLookupByLibrary.simpleMessage(
        "የይለፍ ቃል እና መግባት",
      ),
      "literalpostInCommunityName": (Object a0) => "በ${a0} ውስጥ ይለቀቁ",
      "literalpostInWidgetCommunityName": (Object a0) => "በ${a0} ውስጥ ይለቀቁ",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
        "ከራስዎ ቃላት ጋር ከፍ አድርጉት እና ይለቀቁ",
      ),
      "literalprimaryLanguage": MessageLookupByLibrary.simpleMessage("ዋና ቋንቋ"),
      "literalpushNotifications": MessageLookupByLibrary.simpleMessage(
        "Push ማሳወቂያዎች",
      ),
      "literalreading": MessageLookupByLibrary.simpleMessage("በመነቃቃት…"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage(
        "የድምጽ ፖስት ቅርጸ ቃል አዘጋጅ",
      ),
      "literalrecordAgain": MessageLookupByLibrary.simpleMessage("ዳግም ይቅርጹ"),
      "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage(
        "ከሞዴሬተር ይወግዱ",
      ),
      "literalremoveFromCommunity": MessageLookupByLibrary.simpleMessage(
        "ከማህበሩ ውስጥ ይወግዱ",
      ),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("ከተቀምጡ ይወግዱ"),
      "literalremoveLabel": (Object a0) => "${a0} ን አስወግድ",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0}ን አስወግድ",
      "literalremoveMemberDisplayname": (Object a0) => "${a0}ን ይወግዱ?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("ምርጫውን አስወግድ"),
      "literalremoveThisAnswer": MessageLookupByLibrary.simpleMessage(
        "ይህን መልስ አስወግድ",
      ),
      "literalremoveThisConversation": MessageLookupByLibrary.simpleMessage(
        "ይህን ውይይት ይወግዱ",
      ),
      "literalremoveThisPoll": MessageLookupByLibrary.simpleMessage(
        "ይህን ምርጫ አስወግድ",
      ),
      "literalreportAuthor": (Object a0) => "${a0}ን ሪፖርት አድርግ",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("ጽሑፉን ሪፖርት አድርግ"),
      "literalresendCode": MessageLookupByLibrary.simpleMessage("ኮድን እንደገና ላክ"),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage("የተቀረጡ ጽሑፎች"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("ነገር ንገሩ"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "ለ${a0} ስለነገሩ ይናገሩ",
      "literalsearchFailed": MessageLookupByLibrary.simpleMessage("ፍለጋ አልተሳካም"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("እንደገና ላክ"),
      "literalsendAgainInCooldownS": (Object a0) => "እንደገና በ${a0}s ውስጥ ላክ",
      "literalsendFeedback": MessageLookupByLibrary.simpleMessage("አስተያየት ላክ"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("አገናኙን ላክ"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "ተልኳል። እሱ ሪፖርት #${a0} ነው።",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
        "የይለፍ ቃል ያወጣ እና ቀጥሉ",
      ),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
        "ሎጉን ከድጋፍ ጋር አጋራ",
      ),
      "literalshareThisCommunity": MessageLookupByLibrary.simpleMessage(
        "ይህን ማህበር አጋራ",
      ),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("ይህን ገፅ አጋራ"),
      "literalshareThisProfile": MessageLookupByLibrary.simpleMessage(
        "ይህን መገለጫ አጋራ",
      ),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("በ… አጋራ"),
      "literalshareWithAQuote": MessageLookupByLibrary.simpleMessage(
        "ከአንቀሳቃሽ ጋር አጋር",
      ),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
        "እንዲሁ ያሉ ተጨማሪ ጽሑፎችን አሳይ",
      ),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("የይለፍ ቃል አሳይ"),
      "literalshowResults": MessageLookupByLibrary.simpleMessage("ውጤቶችን አሳይ"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("ማህበር ጀምር"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("መቅረት ይጀምሩ"),
      "literalstopLoading": MessageLookupByLibrary.simpleMessage("ማጣሪያን አቁም"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
        "ይህን ጽሑፍ እና ወደ እሱ የሚመለሱ መልሶችን ማየት ይቆሙ",
      ),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "የታሪክ ሪብብን፣ ${a0} እቃዎች",
      "literalswitchCamera": MessageLookupByLibrary.simpleMessage("ካሜራውን ቀይር"),
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("ሰው ይማሩ"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("ፎቶ ይውሰዱ"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage("መለያውን ለማቀየር ባነር ወይም ፎቶውን ይጫኑ"),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
        "ውስጥ ያለውን አገናኝ ይጫኑ",
      ),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
        "ፎቶ እና ኮቨር ለማክለት ይጫኑ",
      ),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
        "ይህ አልደረሰም። ደግሞ ይሞክሩ።",
      ),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
        "ያ GIF ሊወሰድ አልቻለም።",
      ),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
        "ያ አገናኝ ይህ መተግበሪያ ሊክፈት የማይችለው አገናኝ ነው።",
      ),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("ካሜራው ዝግቷል"),
      "literalthisCommunity": MessageLookupByLibrary.simpleMessage("ይህ ማህበር"),
      "literalthisReplyIsGone": MessageLookupByLibrary.simpleMessage(
        "ይህ መልስ አልፎ ተረጎቷል",
      ),
      "literaltranslatePost": MessageLookupByLibrary.simpleMessage("ጽሑፉን ተርጉም"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage(
        "ድምጽን ዝም ብለው ያደርጉ",
      ),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("ድምጽን እንዲሰማ አብስሉ"),
      "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage(
        "ከእኛ ውስጥ አንዱን ጥቀም",
      ),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
        "የማረጋገጫ ኮድ እንደገና ተልኳል።",
      ),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "ማረጋገጫ አልተሳካም፦ ${a0}",
      "literalverifyEmail": MessageLookupByLibrary.simpleMessage("ኢሜይል አረጋግጥ"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
        "እይታዎች፣ ከፈለጉ፣ ተቀይረው የተቀመጡ እና አስተያየቶች",
      ),
      "literalwhatKyronKeeps": MessageLookupByLibrary.simpleMessage(
        "Kyron የሚጠብቅ ነገሮች",
      ),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
        "ይህ መተግበሪያ ምን እንደማደረገ እይታ",
      ),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage("ያደረጉት፣ ያስፈላጊው የነበረው፣ የተከሰተው "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
        "የምታስቀምጡ የእርስዎ ናቸው",
      ),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Kyron አሁን ደርሶ ይደርሳል ወይስ አይደርስም"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("ማን ሊመልስ ይችላል"),
      "literalwhoDoYouWantToTag": MessageLookupByLibrary.simpleMessage(
        "ማንን ማስታወሻ ይፈልጋሉ?",
      ),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
        "እስካሁን እያንዳንዱን የሚስማሙ መለያ አገናኙልና አሁን ካልተደረገ የለም",
      ),
      "literalyouAreAllCaughtUp": MessageLookupByLibrary.simpleMessage(
        "ሁሉንም ተከታታዮች አጥፋልዎታል",
      ),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
        "ከማንኛውም ማህበር ውስጥ አይኖሩም",
      ),
      "literalyouAreSignedOut": MessageLookupByLibrary.simpleMessage(
        "ከስርዓቱ ተወጥተዋል።",
      ),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "${a0}ን ተወውሃል",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን አልገገምም",
      ),
      "loadMore": MessageLookupByLibrary.simpleMessage("ከዚያ በላይ ጫን"),
      "logCleared": MessageLookupByLibrary.simpleMessage("ሎግ ተታገለ"),
      "logCopied": MessageLookupByLibrary.simpleMessage("ሎግ ተቀይሯል"),
      "logIn": MessageLookupByLibrary.simpleMessage("ግባ"),
      "logOut": MessageLookupByLibrary.simpleMessage("ውጣ"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("ውጣ?"),
      "login": MessageLookupByLibrary.simpleMessage("ግባ"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
        "መግባት አልተሳካም። እባክዎ ማረጋገጫዎችዎን ይክታተሉ።",
      ),
      "manage": MessageLookupByLibrary.simpleMessage("ያደርጉ"),
      "menu": MessageLookupByLibrary.simpleMessage("ምናሌ"),
      "message": MessageLookupByLibrary.simpleMessage("መልእክት"),
      "messages": MessageLookupByLibrary.simpleMessage("መልዕክቶች"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("ሁሉም ውይይቶች ተከፋፈሉ።"),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
        "የአንዱን መገለጫ ክፈት እና Message ይጫኑ ለመወያየት።",
      ),
      "mute": MessageLookupByLibrary.simpleMessage("ዝም ብለው ያደርጉ"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
        "ዝም ብለው ተከፍቷል እና ተከለ",
      ),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
        "ዝም ብለው የተደረጉ ቃላት እና መለያዎች",
      ),
      "name": MessageLookupByLibrary.simpleMessage("ስም"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> ክፍል"),
      "newEmailAddress": MessageLookupByLibrary.simpleMessage("አዲስ ኢሜይል አድራሻ"),
      "newPassword": MessageLookupByLibrary.simpleMessage("አዲስ የይለፍ ቃል"),
      "newPost": MessageLookupByLibrary.simpleMessage("አዲስ ጽሑፍ"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("አሁን አይደለም"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
        "አልተልኳም። ዳግም ለማሞከር ንዑር ይጫኑ",
      ),
      "nothingMatchesQuery": (Object a0) =>
          "በKyron ላይ \"${a0}\" ከሚመሳሰሉ ነገሮች ምንም አይነጋገርም",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("ምንም ለመቅዳት የለም"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "እየደረሱ ያሉ ፍለጋዎች፣ መልሶች እና አዲስ ተከታታዮች እዚህ ይገኛሉ።",
      ),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
        "እንዲከታተሉዎ የሚመጡ ሰዎች እዚህ ይታያሉ።",
      ),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
        "ማንም ከፈለገዎት ጽሑፍ ከሆነ እዚህ ይታያል።",
      ),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
        "ወደ ጽሑፎችዎ የሚልኩ መልሶች እዚህ ይወዳዳሉ።",
      ),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
        "ማንም እርስዎን እንደገና ከሆነ እዚህ ይታያል።",
      ),
      "notifications": MessageLookupByLibrary.simpleMessage("ማሳወቂያዎች"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("በአሣይ ይክፈቱ"),
      "or": MessageLookupByLibrary.simpleMessage("ወይም"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("ገፁ አልተገኘም"),
      "password": MessageLookupByLibrary.simpleMessage("የይለፍ ቃል"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("የይለፍ ቃል አጭር ነው"),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
        "እንፈልጋለን የሚፈልጉትን ይምረጡ",
      ),
      "post": MessageLookupByLibrary.simpleMessage("ወጣ"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("የፖስት ትንበያዎች"),
      "postInCommunity": (Object a0) => "በ${a0} ውስጥ ይለቀቁ",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("ያጻፉ፣ ይገልጹ፣ ይታዩ።"),
      "postTextCopied": MessageLookupByLibrary.simpleMessage("የጽሑፍ ጽሑፍ ተቀይሯል"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("የግላዊነት ፖሊሲ"),
      "profileUpdated": MessageLookupByLibrary.simpleMessage("መገለጫው ተዘምኗል"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("ባዮ"),
      "profile_display_name": MessageLookupByLibrary.simpleMessage("የማሳያ ስም"),
      "profile_location": MessageLookupByLibrary.simpleMessage("አካባቢ"),
      "profile_tap_to_change": MessageLookupByLibrary.simpleMessage("ለለወጥ ይጫኑ"),
      "profile_website": MessageLookupByLibrary.simpleMessage("ድህረገፅ"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage("Push ማሳወቂያዎች"),
      "quote": MessageLookupByLibrary.simpleMessage("እባክዎን ጥቅስ"),
      "quotePost": MessageLookupByLibrary.simpleMessage("ጽሑፉን እባክዎን አትገብሩ"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("ሰውን ያግኙ"),
      "remove": MessageLookupByLibrary.simpleMessage("ሰርዝ"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("ይህን ውይይት አስወግዱ?"),
      "removeMember": (Object a0) => "${a0}ን ከማህበሩ ይውጡ?",
      "removeMessage": MessageLookupByLibrary.simpleMessage("ይህን መልዕክት ይወግዱ?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
        "ምላሾች፣ ተከታዮች እና ማስታወሻዎች",
      ),
      "repliesPolicy": (Object a0) => "መልሶች፦ ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("መልስ"),
      "reply_anyone": MessageLookupByLibrary.simpleMessage("ማንም ሊገባ ይችላል"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
        "ማንም ጽሑፉን ሊያይ፣ ሊካፈል እና ሊወርድ ይችላል።",
      ),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
        "በKyron ላይ ማንም ይህን ጽሑፍ ሊመልስ ይችላል።",
      ),
      "reply_followers": MessageLookupByLibrary.simpleMessage("የሚከተሉ ሰዎች"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
        "ይህን ጽሑፍ ሊመልሱ የሚችሉ ብቻ የሚከተሉ ሰዎች ናቸው።",
      ),
      "reply_mentioned": MessageLookupByLibrary.simpleMessage("የምታጠሩት ሰዎች"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
        "በዚህ ጽሑፍ የምታጠሩትን @ የወረዳውን ሰዎች ብቻ ሊመልሱ ይችላሉ።",
      ),
      "reply_nobody": MessageLookupByLibrary.simpleMessage("ማንም ሊመልስ አይችልም"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
        "መልሶች ተዘጉ። እርስዎ ግን ማስመለስ ትችላላችሁ።",
      ),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("ማን ሊመልስ ይችላል?"),
      "report": MessageLookupByLibrary.simpleMessage("ሪፖርት"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "ሪፖርቱ ተቀይሯል። ወደ ድጋፍ ኢሜይል ለማስቀምጥ ያስገቡት።",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("ሪፖርት ተልኳል"),
      "repost": MessageLookupByLibrary.simpleMessage("እንደገና ያስቀምጡ"),
      "reset": MessageLookupByLibrary.simpleMessage("ታገል"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("የይለፍ ቃልዎን ዳግም ያቀናጁ"),
      "retry": MessageLookupByLibrary.simpleMessage("ድገፍ ይሞክሩ"),
      "save": MessageLookupByLibrary.simpleMessage("አስቀምጥ"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("የንዑስ ሥያሜ አስቀምጥ"),
      "saySomething": (Object a0) => "ለ${a0} ስለነገሩ ይናገሩ",
      "search": MessageLookupByLibrary.simpleMessage("ፈልግ"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
        "በስም ወይም በሁነታ ፈልግ",
      ),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("ማህበረሰቦችን ይፈልጉ"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIFs ን ይፈልጉ"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("ቋንቋዎችን ይፈልጉ"),
      "searchTrendingTags": MessageLookupByLibrary.simpleMessage(
        "በፈለጉት መለያዎች ይፈልጉ",
      ),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
        "የደህንነት ማስጠንቀቂያዎች እና የመለያ ለውጦች",
      ),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
        "ለመተግበሪያው የተጠቃሚ ቋንቋ ማምረጥ።",
      ),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
        "ለምድብ ያሉ ፈለጎች የሚጨምሩትን ቋንቋዎች ይምረጡ። ምንም ካልተመረጡ ሁሉም ቋንቋዎች ይታያሉ።",
      ),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "በፊደል ውስጥ ለትርጉም የሚቀበሉትን ዋና ቋንቋ ይምረጡ።",
      ),
      "send": MessageLookupByLibrary.simpleMessage("ላክ"),
      "sendConfirmation": MessageLookupByLibrary.simpleMessage("ማረጋገጫ ላክ"),
      "sendErrorReport": MessageLookupByLibrary.simpleMessage("የስህተት ሪፖርት ላክ"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("አስተያየት ላክ"),
      "sendReport": MessageLookupByLibrary.simpleMessage("ሪፖርት ላክ"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("ወደ ድጋፍ ላክ"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("የአገልግሎት ሁኔታ"),
      "settings": MessageLookupByLibrary.simpleMessage("ቅንብሮች"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
        "ከመተግበሪያው ሎግ ጋር ከድጋፍ ጋር እኩል ይጋራ",
      ),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("ወደ Kyron ይግቡ"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("እንደ ዚህ ገብተዋል"),
      "signupFailed": (Object a0) => "ምዝገባ አልተሳካም፦ ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("ቆይ"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
        "Kyron በጥቂት ደረጃ ላይ ነው፣ እና ችግኝ ለማስተካከል የሚችል ሰውን ለመድረስ እጅግ ፈጣን መንገድ ችግኝ መክፈት ነው። የእርስዎን የእየሰሩበት እና የሚሆነውን ያካትቱ።",
      ),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን በመተግበሪያ ውስጥ የድጋፍ ኢንቦክስ የለም፣ ስለዚህ ይህ ክፍል በእውነተኛው ማስተናገድ የሚታየውን ቦታ ይጠቆማል እና እሱ ወደ ወደ አልደርስ ቅጥ ይሆናል።",
      ),
      "systemLog": MessageLookupByLibrary.simpleMessage("የስርዓት መዝገብ"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
        "ምን እንዳልተገኘ ወይም የተሰበረ ይናገሩን",
      ),
      "terms": MessageLookupByLibrary.simpleMessage("ውሎች"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
        "ጽሑፍ፣ ድምፅ እና ቪዲዮ፣ እነዚያን የሚፈጥሩ ሰዎች እና የሚያገለግሉበት ክፍሎች።",
      ),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
        "ኮምፖዘሩ የPost አዝራር የለውም",
      ),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Dark"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("ሁልጊዜ ጨለማ"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Dim"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
        "ጥቂት የቀለም ጨለማ፣ ከጥቁር ይልቅ ሰማያዊ-ግራይ",
      ),
      "theme_light": MessageLookupByLibrary.simpleMessage("Light"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("ሁልጊዜ ብርሃን"),
      "theme_system": MessageLookupByLibrary.simpleMessage("System"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
        "የስልኩን ማብራሪያ ወይም ጨለማ ቅንብር ይከተላሉ",
      ),
      "translate": MessageLookupByLibrary.simpleMessage("ትርጉም"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
        "ትርጉም እስካሁን አልተዋቀረም። ዛሬ በእንግሊዝኛ የተገለጹ ነገሮች ይቆያሉ፤ ይህ እንደሚለው ለሚሆኑ ጊዜያት ይታያል።",
      ),
      "translation_description": MessageLookupByLibrary.simpleMessage(
        "የKyron የራሱ ቃሎች እየተተረጉሙ ናቸው፣ ስለዚህ አብዛኛዎቹ መስኮች ለአሁን በእንግሊዝኛ ናቸው። ዛሬ ይህ የሚለውን ይቀይራል፤ የFlutter ራሱ የሚያሳይ የባለሞያ ክፍሎች፣ ቀናት እና ቁጥሮች፣ እና መተግበሪያው ለቀኝ-እስከ-ግራ ቋንቋዎች የሚያቀርብበት አቀራረብ።",
      ),
      "tryAgain": MessageLookupByLibrary.simpleMessage("ደግሞ ይሞክሩ"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("የግላዊነት ፖሊሲ"),
      "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage(
        "የአገልግሎት ውሎች",
      ),
      "ui_account": MessageLookupByLibrary.simpleMessage("መለያ"),
      "ui_after": MessageLookupByLibrary.simpleMessage("ይበከላል"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("መተግበሪያ እና መሣሪያ"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("አይነት"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "ፍጥነት፣ ጨለማ፣ ወይም ስልኩ የተቀመጠውን ይከተላሉ",
      ),
      "ui_before": MessageLookupByLibrary.simpleMessage("በፊት"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "ሁለቱም በKyron ላይ አይገኙም፣ እና መካከላችሁ ያለው እርስዎ ይወገዳል። እነርሱ አይገልፁም።",
      ),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("ያዞረ"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("ማህበረሰቦች"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("ይህ ስለምንድን ነው? (አማራጭ)"),
      "ui_content_display": MessageLookupByLibrary.simpleMessage("ይዘት እና ማሳያ"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
        "የእርስዎን ፊድ ማስገባት አልቻለም",
      ),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
        "የተፈለጉ ጽሑፎችዎን ማስገባት አልቻለም",
      ),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
        "መገለጫዎን ማስገባት አልቻለም",
      ),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
        "የተቀረጡ ጽሑፎችዎን ማስገባት አልቻለም",
      ),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage(
        "Decentralized ID",
      ),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("መገለጫዎች"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("የወደድኳቸው"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("የተቀመጡ"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("እዚህ እስካሁን ምንም የለም"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
        "አንዳንድ መለያዎችን ይከታተሉ እና የእነሱ ጽሑፎች እዚህ ይታያሉ።",
      ),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
        "ከእርስዎ የተከታታዩ ሰዎች ምንም የለም",
      ),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
        "ሰዎች ሲጻፉ ጽሑፎች እዚህ ይታያሉ።",
      ),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
        "የክሊፕ ይዞ የሚለቀቁ ጽሑፎች እዚህ ይታያሉ።",
      ),
      "ui_feed_videos_empty": MessageLookupByLibrary.simpleMessage(
        "እስካሁን ቪዲዮዎች የሉም",
      ),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("አስተያየት"),
      "ui_find_people_on_kyron": MessageLookupByLibrary.simpleMessage(
        "በKyron ሰዎችን ፈልግ",
      ),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("ከአካውንት ውስጥ"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("ሰዎችን አክል"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("አክል"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("አትቀበል"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "በዚህ ቡድን ያሉ መልዕክቶች እንደማንኛውም ውይይት ከጫፍ እስከ ጫፍ የተመሰጠሩ ናቸው።"),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor \$users ን አከለ"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor \$users ን አስተዳዳሪ አደረገ"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor ቡድኑን ፈጠረ"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor አዳዲስ ሰዎች እንደ አባል እንዲቀላቀሉ አደረገ"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor አዳዲስ ሰዎች እንደ ተመልካች እንዲቀላቀሉ አደረገ"),
      "ui_group_event_left": MessageLookupByLibrary.simpleMessage("\$actor ወጣ"),
      "ui_group_event_member":
          MessageLookupByLibrary.simpleMessage("\$actor \$users ን አባል አደረገ"),
      "ui_group_event_owner":
          MessageLookupByLibrary.simpleMessage("\$actor \$users ን ባለቤት አደረገ"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor \$users ን አስወገደ"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor የቡድኑን ስም ወደ \$title ቀየረ"),
      "ui_group_event_spectator":
          MessageLookupByLibrary.simpleMessage("\$actor \$users ን ተመልካች አደረገ"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "አንድ ቡድን ቢበዛ \$count ሰዎች ሊኖሩት ይችላል።"),
      "ui_group_hand_raised":
          MessageLookupByLibrary.simpleMessage("እጅ ተነስቷል። አስተዳዳሪዎች ተነግሯቸዋል።"),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count ለመጻፍ ይጠይቃሉ"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("ለመጻፍ ይጠይቃሉ"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "በኋላ የሚታከሉ ሰዎች እንደ ተመልካች ይቀላቀላሉ"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("ከቡድኑ ውጣ"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "ከዝርዝርህ ይጠፋል፣ ከዚያ በኋላ የሚባለውንም አታይም። አንድ ሰው እንደገና ሊያክልህ ይገባል።"),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("ከዚህ ቡድን ልትወጣ ነው?"),
      "ui_group_let_write": MessageLookupByLibrary.simpleMessage("እንዲጽፉ ፍቀድ"),
      "ui_group_lower_hand": MessageLookupByLibrary.simpleMessage("እጅ አውርድ"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("አስተዳዳሪ አድርግ"),
      "ui_group_make_owner": MessageLookupByLibrary.simpleMessage("ባለቤት አድርግ"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("ተመልካች አድርግ"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count አባላት"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("አባላት"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("የቡድን ስም"),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("የቡድን ውይይት ፍጠር"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "ባለቤቱ አንድ ብቻ ነው። አንተ አስተዳዳሪ ሆነህ ትቆያለህ።"),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("\$name ባለቤት ይሁን?"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("እጅ አንሳ"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("ከቡድኑ አስወግድ"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("ከአስተዳዳሪነት አስወግድ"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("ከአሁን በኋላ በዚህ ቡድን ውስጥ የለህም።"),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("ስም ቀይር"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("አስተዳዳሪ"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("አባል"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("ተመልካች"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "እንደ ተመልካች እዚህ ማንበብ እና ምላሽ መስጠት ትችላለህ።"),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "ተመልካቾች ማንበብ፣ ምላሽ መስጠት እና ለመጻፍ ለመጠየቅ እጅ ማንሳት ይችላሉ።"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("መገለጫ ይመልከቱ"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("አንተ"),
      "ui_group_you_spectate": MessageLookupByLibrary.simpleMessage("ተመልካች ነህ"),
      "ui_help": MessageLookupByLibrary.simpleMessage("እገዛ"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "ታውቋል። ይህ የሚታየዎትን ነገር ይቀይራል።",
      ),
      "ui_join": MessageLookupByLibrary.simpleMessage("ተቀላቀሉ"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("ተቀላቀለ"),
      "ui_language": MessageLookupByLibrary.simpleMessage("ቋንቋ"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("ሕጋዊ"),
      "ui_like": MessageLookupByLibrary.simpleMessage("እፈልጋለሁ"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("የተፈለጉ ጽሑፎች"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
        "የምታወዱ ጽሑፎች እዚህ ይታያሉ፣ አቅዱ ከፊት ይጀምራሉ።",
      ),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("አገናኝ ተቀይሯል"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
        "የሚያሳዩትን ጽሑፎች ከማየት ትቆማላችሁ። እነርሱ አያሳውቁም።",
      ),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("እስካሁን የተፈለጉ የሉም"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
        "ማንኛውም ጽሑፍ ከእነዚህ ማጥፊያዎች ጋር አይዛመድም።",
      ),
      "ui_nothing_saved_yet": MessageLookupByLibrary.simpleMessage(
        "እስካሁን ምንም አልተቀረጠም",
      ),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "ጨርስ",
      ),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "ይውሰዱ",
      ),
      "ui_once_already": MessageLookupByLibrary.simpleMessage("ይህ ቀድሞ ተከፍቷል።"),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("ጊዜው አልፏል"),
      "ui_once_failed": MessageLookupByLibrary.simpleMessage("ሊከፈት አልቻለም።"),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "አንድ ጊዜ ይከፈታል፣ ከዚያ ከ Kyron ይሰረዛል።"),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("አንድ ጊዜ እይ"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("ተከፍቷል"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("ከ\$total ውስጥ \$count ከፈቱት"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "የላክህላቸው ሰዎች ብቻ አንድ ጊዜ ሊከፍቱት ይችላሉ።"),
      "ui_once_send": MessageLookupByLibrary.simpleMessage("ለአንድ ጊዜ እይታ ላክ"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("ለማየት ንካ"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("አቁም"),
      "ui_play": MessageLookupByLibrary.simpleMessage("ቀጥል"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
        "ከመገለጫዎ እና ከሁሉም ሌሎች የእያንዳንዱ ፊደል ይነገዳል። ወደ እሱ የሚመለሱ መልሶች ጋር ይሄዳሉ።",
      ),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("ጽሑፉ ከወገኖች ተሰርዟል"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("ጽሑፍ ደብቆ ተደርጓል"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("የጽሑፍ ጽሑፍ ተቀይሯል"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("በ… መካከል ታስተናገደ"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
        "ደብቅ ሆነ። እንዲሁ ያሉን እንዲታዩ ይንሳፋፋል።",
      ),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("ተመራማሪዎች"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("ግላዊነት"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("የተቀረጡ ጽሑፎች"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
        "በማንኛውም ጽሑፍ ላይ ያለውን አርክብ አዶ ይታያል። የምታደርጉትን ብቻ እርስዎ ብታዩ ትችላላችሁ።",
      ),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
        "በሁነታ ወይም በታይ ስም ፈልግ።",
      ),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("አጽዳ"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
        "የተለጠፈውን ሁሉ ፈልግ",
      ),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("ማጥፊያዎች"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("ሰዎችን ፈልግ"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("ጽሑፎችን ፈልግ"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("ቅንብሮች"),
      "ui_settings_app_device": MessageLookupByLibrary.simpleMessage(
        "መተግበሪያ እና መሣሪያ",
      ),
      "ui_settings_content_display": MessageLookupByLibrary.simpleMessage(
        "ይዘት እና ማሳያ",
      ),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("የውሂብ ቆጣቢ"),
      "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
        "ምን እንደምታስብ ይናገሩን",
      ),
      "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage(
        "የእገዛ ጽሁፎችን ያጣሉ",
      ),
      "ui_settings_language_detail": MessageLookupByLibrary.simpleMessage(
        "ቋንቋዎን ይምረጡ",
      ),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
        "የምታዝሙ ወይም የምታገድ ማን እንደሆኑ",
      ),
      "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
        "የማሳወቂያ ፈለጋዎች",
      ),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
        "የእርስዎ መገለጫ እና የእውቂያ መረጃ",
      ),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
        "ወደ መለያዎ ወደ ቀድሞው ለመመለስ እንደገና መግባት ይፈልጋሉ።",
      ),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("የደህንነት ቅንብሮች"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("የይለፍ ቃል ያረጋግጡ"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("በአንድ መስመር"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("አዲስ ኢሜይል አድራሻ"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("አዲስ የይለፍ ቃል"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("ምን አጋጥሟል?"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("ከቡድናችን ይረዱ"),
      "ui_share": MessageLookupByLibrary.simpleMessage("አጋራ"),
      "ui_share_this_post": MessageLookupByLibrary.simpleMessage("ይህን ጽሑፍ አጋራ"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("ውሎች"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ይህ ጽሑፍ"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("ገጽታ ዝም ብለዋል"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("ድምጽን ዝም በሉ"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("ድምጽን አብስሉ"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "ሁለት ፊደላት ወይም ከዚያ በላይ።",
      ),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
        "ቃላት፣ ወይም ማጥፊያ — መለያ፣ የቀን ክልል፣ ወይም ጽሑፉ የያዘው።",
      ),
      "undoRepost": MessageLookupByLibrary.simpleMessage("እንደገና ማስቀምጥ ያስወጉ"),
      "updatePassword": MessageLookupByLibrary.simpleMessage("የይለፍ ቃል ያዘምኑ"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("ሌላ አድራሻ ይጠቀሙ"),
      "username": MessageLookupByLibrary.simpleMessage("የተጠቃሚ ስም"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
        "የተጠቃሚ ስም አረብ ታካሽ ያለው ይሁን (a-z, 0-9, _)",
      ),
      "video": MessageLookupByLibrary.simpleMessage("ቪዲዮ"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("ያክሉ"),
      "voice_ready_attach": MessageLookupByLibrary.simpleMessage("ለማቀላጠፍ ዝግጁ"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("የድምጽ ፖስት ይመዝገቡ"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("በመቅረት…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("አቁም"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("ምን አጋጥሟል?"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "ምን አጋጥሟል እና ምን እንደሚመለከቱ እንመልከታለን?",
      ),
      "whatInPicture": MessageLookupByLibrary.simpleMessage("በዚህ ፎቶ ምን አለ?"),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage("ይህ ስለምን ነው? (አማራጭ)"),
      "whatYouDid":
          MessageLookupByLibrary.simpleMessage("ያደረጉት፣ ያሰባሉት፣ የተከሰተው"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
        "የምታደርጉት በሚሆንበት ጊዜ ምን እንደነበር።",
      ),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("እርስዎ መለሱ"),
      "dmReplied": (Object a0) => "$a0 መለሱ",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("ወደ መልእክት ያክሉ"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("አዲስ መልእክት"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "እስካሁን ምንም አልተባለም። ሰላምታ ጥሩ ጅምር ነው።"),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  ሰላም በሉ"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("አዲስ መልእክቶች"),
      "dmTyping": (Object a0) => "$a0 እየጻፉ ነው",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("ምላሽዎን ያስወግዱ"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("አንድ ሰው"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("መልእክት"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("አባሪ"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "ይህ መልእክት በዚህ መሣሪያ ላይ ሊነበብ አይችልም።"),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "ይህን መልእክት በመጠበቅ ላይ። ትንሽ ጊዜ ሊወስድ ይችላል።"),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("የተመሰጠረ መልእክት"),
      "ui_dm_e2ee_notice":
          MessageLookupByLibrary.simpleMessage("መልእክቶች ከጫፍ እስከ ጫፍ የተመሰጠሩ ናቸው"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("ከጫፍ እስከ ጫፍ አልተመሰጠረም"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("ተልኳል"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("ታይቷል"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("በመላክ ላይ…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("ፎቶ አንሳ"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("ተጨማሪ አማራጮች"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("ወደ መሣሪያ አስቀምጥ"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("አጋራ"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("በማስቀመጥ ላይ…"),
      "ui_media_saved": MessageLookupByLibrary.simpleMessage("ወደ ፎቶዎችዎ ተቀምጧል"),
      "ui_media_save_failed":
          MessageLookupByLibrary.simpleMessage("ማስቀመጥ አልተቻለም። እንደገና ይሞክሩ።"),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "ይህን ለማስቀመጥ Kyron ወደ ፎቶዎችዎ እንዲያክል ይፍቀዱ።"),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("ሁሉም ሥርዓቶች እየሠሩ ነው"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("የሥራ ጊዜ"),
      "ui_status_last_60": MessageLookupByLibrary.simpleMessage("ያለፉት 60 ቀናት"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("ከ60 ቀናት በፊት"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("ዛሬ"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("የውሂብ ጎታ"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("መግቢያ"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("የቅርብ ጊዜ ችግሮች"),
      "ui_status_no_incidents":
          MessageLookupByLibrary.simpleMessage("ባለፉት 60 ቀናት ምንም ችግር አልነበረም።"),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("በመካሄድ ላይ"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("ምንም ውሂብ የለም"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("ዝርዝሮች"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron በሚሠራበት ጊዜ በየ5 ደቂቃው ራሱን ይፈትሻል። ግራጫ ቀን ምንም ፍተሻ አልነበረውም።"),
      "ui_status_unavailable":
          MessageLookupByLibrary.simpleMessage("የሥራ ጊዜ ታሪክ ገና አይገኝም።"),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("አንዳንድ ሥርዓቶች ችግር ገጥሟቸዋል"),
      "ui_dm_voice": MessageLookupByLibrary.simpleMessage("የድምጽ መልእክት ይቅረጹ"),
      "voice_ready_send": MessageLookupByLibrary.simpleMessage("ለመላክ ዝግጁ"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("ያ መልእክት ከአሁን በኋላ እዚህ የለም።"),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("ወደ መልእክቱ ይሂዱ"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("የድምጽ መልእክት"),
      "ui_liked_by_author": MessageLookupByLibrary.simpleMessage("ደራሲው ወድዶታል"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("ፎቶ ወይም ቪዲዮ ያክሉ"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("ሚዲያ"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("የድምጽ መልእክቶች"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("ውይይት"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("የግድግዳ ወረቀት"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("ማሳወቂያዎችን ድምጸ-ከል አድርግ"),
      "ui_dm_info_mute_detail":
          MessageLookupByLibrary.simpleMessage("ስለዚህ ውይይት ማሳወቂያ መቀበል ያቁሙ"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("ከአሁን በኋላ መልእክት ሊልኩልዎ አይችሉም"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("ምንም"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("ፎቶ"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("ድምጸ-ከል ተነስቷል።"),
      "ui_dm_remove_failed":
          MessageLookupByLibrary.simpleMessage("ሊወገድ አልቻለም። እንደገና ይሞክሩ።"),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("መገለጫ"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("ድምጸ-ከል አንሳ"),
      "ui_dm_info_no_media":
          MessageLookupByLibrary.simpleMessage("የሚያጋሯቸው ፎቶዎችና ቪዲዮዎች እዚህ ይታያሉ።"),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("ሁሉንም ይመልከቱ"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("ፎቶዎችና ቪዲዮዎች"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("ውይይትዎ እንዲህ ይመስላል።"),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("ጥሩ ይመስላል።"),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("ጭጋግ"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("ምሽት"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("አረንጓዴ"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("አሸዋ"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("ነጥቦች"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("ተግብር"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("የአሁኑ"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("ያለ ቅድመ እይታው ላክ"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("ፈልግ"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("ለጥፍ"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("መልእክት ይጻፉ…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("ላክ"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("ተልኳል"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("ተልኳል፣ ግን ለሁሉም አይደለም።"),
      "ui_share_failed":
          MessageLookupByLibrary.simpleMessage("ሊላክ አልቻለም። እንደገና ይሞክሩ።"),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("ተከታይ"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("ማጣሪያ"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("ሁሉም"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("ያልተነበቡ"),
      "ui_dm_filter_unanswered": MessageLookupByLibrary.simpleMessage("ያልተመለሱ"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("የተደበቁ"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("ምንም የተደበቀ የለም"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "ከዝርዝርዎ ያስወገዷቸው ውይይቶች መልሰው ቢፈልጓቸው እዚህ ይጠብቃሉ።"),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "ወደ የተደበቁ ይዛወራል። ሌላኛው ሰው የራሱን ይይዛል፣ ከሁለታችሁ አንዱ እንደገና ከጻፈ ይመለሳል።"),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("መልስ"),
      "ui_dm_restored": MessageLookupByLibrary.simpleMessage("ወደ ዝርዝርዎ ተመልሷል።"),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("የሚዛመድ ውይይት የለም።"),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("እርስዎን የሚጠብቅ የለም"),
      "ui_dm_unanswered_none_detail":
          MessageLookupByLibrary.simpleMessage("እያንዳንዱ ውይይት በእርስዎ ቃል ይቋጫል።"),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("ፎቶ"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("ፎቶዎች"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("ቪዲዮ"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("እስካሁን ምንም መልእክት የለም"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("እርስዎ፦"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("ትናንት"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("መልእክቶች"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("የመልእክት ቅንብሮች"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("ግላዊነት"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("የንባብ ማረጋገጫዎች"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "ይህ ሲጠፋ ሰዎች መልእክታቸውን ማንበብዎን አያዩም፣ እርስዎም የእርስዎን ማንበባቸውን አያዩም።"),
      "ui_dm_typing_setting": MessageLookupByLibrary.simpleMessage("ሲተይቡ አሳይ"),
      "ui_dm_typing_setting_detail":
          MessageLookupByLibrary.simpleMessage("የሚጽፉለት ሰው እየጻፉ መሆንዎን ያያል።"),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("የአገናኝ ቅድመ እይታዎች"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "ስልክዎ ቅድመ እይታውን ለመፍጠር የሚልኩትን አገናኝ ይከፍታል፣ ስለዚህ ጣቢያው ስልክዎ ሲጠይቅ ያያል። የKyron አገልጋይ አገናኙን ፈጽሞ አያይም።"),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("የመልእክት ማሳወቂያዎች"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "መልእክቶች ከጫፍ እስከ ጫፍ የተመሰጠሩ ናቸው። Kyron ሊያነባቸው አይችልም፣ እዚህ ያለ ምንም ነገር ይህን አይቀይርም።"),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("ለ፦"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("የቅርብ ጊዜ"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("ሰዎች"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("በዚያ ስም ማንም የለም።"),
      "ui_push_test": MessageLookupByLibrary.simpleMessage("የሙከራ ማሳወቂያ ላክ"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "የKyron አገልጋይ ገና ማሳወቂያዎችን ለመላክ አልተዘጋጀም፣ ስለዚህ ምንም ሊደርስ አይችልም። ችግሩ በእኛ በኩል ነው እንጂ በስልክዎ አይደለም።"),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "ይህ ስልክ ለማሳወቂያዎች አልተመዘገበም። በስልክዎ ቅንብሮች ውስጥ ለKyron ማሳወቂያዎች መፈቀዳቸውን ያረጋግጡ፣ ከዚያ እንደገና ይሞክሩ።"),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "ማሳወቂያው ወደዚህ ስልክ ሊደርስ አልቻለም። ከአንድ ደቂቃ በኋላ እንደገና ይሞክሩ።"),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "ተልኳል። በጥቂት ሰከንዶች ውስጥ መድረስ አለበት።"),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("ማሳወቂያዎች እየሰሩ ነው።"),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("እስካሁን ልጥፎች የሉም"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("አዲስ ማህበረሰብ"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("ስም"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("አድራሻው ከስሙ ይሠራል።"),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("ሰዎች የሚያገኙት በ"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "ባለቤቱ እርስዎ ይሆናሉ። ምስል፣ ባነር እና አወያዮች ከተፈጠረ በኋላ ከገጹ ሊታከሉ ይችላሉ።"),
      "ui_community_settings_home": MessageLookupByLibrary.simpleMessage("ቤት"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("የማህበረሰብ ልጥፎች በቤት ውስጥ"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "ከማህበረሰቦችዎ የሚወጡ ልጥፎች በቤት ውስጥም ይታያሉ። ሲጠፋ፣ እዚህ በማህበረሰቦች ውስጥ ይቆያሉ፣ እያንዳንዱም አዲስ የሆነውን ያሳያል።"),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("የእርስዎ ዝርዝር"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("የአዲስ ልጥፎች ብዛት"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "ለመጨረሻ ጊዜ ከከፈቱት ወዲህ በእያንዳንዱ ማህበረሰብ ውስጥ ስንት ልጥፎች አዲስ እንደሆኑ አሳይ።"),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("የሚያስተዳድሯቸው ማህበረሰቦች"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "የሚጀምሯቸው ወይም የሚያወያዩዋቸው ማህበረሰቦች እዚህ ተዘርዝረዋል።"),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("ባለቤት"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("አወያይ"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("አዲስ ልጥፎች"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("የሚያስተዳድሯቸው"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("የማህበረሰብ ቅንብሮች"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("ያግኙ"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("የሚዛመዱ ማህበረሰቦች የሉም።"),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("አዲስ ነገር የለም"),
      "ui_community_new_none_detail":
          MessageLookupByLibrary.simpleMessage("እያንዳንዱ ማህበረሰብ እንደተዉት ነው።"),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("እስካሁን የሚያስተዳድሩት የለም"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("የሚቀላቀሉት የቀረ የለም"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "በKyron ላይ ባሉ ሁሉም ማህበረሰቦች ውስጥ ነዎት። ሌላ ይጀምሩ።"),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "ሌላ ቃል ይሞክሩ፣ ወይም በዚያ ስም ማህበረሰብ ይጀምሩ።"),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("ልጥፍ ይጻፉ"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("አባላት፦"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("ተለጥፏል"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("ይመልከቱ"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("ክፈት"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("መስመር ላይ"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("መስመር ላይ ሲሆኑ አሳይ"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "መልእክት የሚልኩላቸው ሰዎች Kyron ክፍት ሲሆን አረንጓዴ ነጥብ ያያሉ። ይህ ሲጠፋ የእነሱንም አያዩም።"),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("ሰዎችንና ልጥፎችን ይፈልጉ"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("ሊቀላቀሏቸው የሚችሉ ማህበረሰቦች"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("እስካሁን የሚታይ ነገር የለም"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "ሰዎች የሚለጥፏቸው ፎቶዎችና ቪዲዮዎች እዚህ ይታያሉ።"),
      "ui_follow": MessageLookupByLibrary.simpleMessage("ተከተል"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("መለያ ሰርዝ"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "ይህ የKyron መለያዎን እስከመጨረሻው ይሰርዘዋል። መቀልበስ አይቻልም።"),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "መገለጫዎ፣ ልጥፎችዎ፣ ምላሾችዎ፣ መውደዶችዎ እና ድጋሚ ልጥፎችዎ"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "መልእክቶችዎ፣ ለሌሎች የላኳቸውንም ጨምሮ፣ እና በውስጣቸው ያሉ ፎቶዎችና የድምፅ መልእክቶች"),
      "ui_delete_account_people":
          MessageLookupByLibrary.simpleMessage("ተከታዮችዎ፣ የሚከተሏቸው ሰዎች እና ቅንብሮችዎ"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "የጀመሯቸው ማህበረሰቦች ረጅም ጊዜ ላገለገለው አወያይ ወይም አባል ይተላለፋሉ። ሌላ ማንም የሌለበት ማህበረሰብ ይዘጋል።"),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("መለያዎን ይሰርዙ?"),
      "ui_delete_account_confirm_detail":
          MessageLookupByLibrary.simpleMessage("ምንም ነገር መልሰው ማግኘት አይችሉም።"),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("መለያዎ ተሰርዟል።"),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("የተሰረዘ መለያ"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "ይህ መለያ ተሰርዟል፣ ስለዚህ ከአሁን በኋላ እዚህ መልእክት መላክ አይቻልም።"),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "በGoogle ተመዝግበዋል? በምትኩ «በGoogle ይግቡ»ን ይጠቀሙ።"),
    };

final messageLookup = MessageLookup();
