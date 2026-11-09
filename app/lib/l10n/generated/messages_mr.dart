import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'mr';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("शब्द, वाक्यांश किंवा #टॅग"),
      "about": MessageLookupByLibrary.simpleMessage("माहिती"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("उत्तर जोडा"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage("भाषा जोडा…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("सहमत व्हा आणि सुरू ठेवा"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("आधीच Kyron खाते आहे?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("टिप्पण्या"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "वेगवेगळे लोक, उघडण्याची संख्या नाही"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("सहभाग"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("लाइक"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("अद्याप प्रेक्षक नाहीत"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "ही पोस्ट अद्याप कोणीही उघडलेली नाही."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("पोस्ट केले"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("सेव्ह"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("प्रेक्षक"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("दररोजचे प्रेक्षक"),
      "and": MessageLookupByLibrary.simpleMessage("आणि"),
      "answerNumber": (Object a0) => "उत्तर ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR लेन्स"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage("अ‍ॅप लॉग जोडा"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("जाऊन-येऊन वेळ"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("टोकन पडताळणी"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "आता प्रसारण सुरू केल्यास तुम्ही अशा खोलीत असाल जिथे कोणीही"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी सुरू करा"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("हे कशासाठी? (पर्यायी)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("पुन्हा येऊ शकणार नाही."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage(
              "या यादीतून पुन्हा येऊ शकणार नाही."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("ती बंद केल्यास"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("आधी सामील व्हा"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("लवकरच येत आहे"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage(
              "तुम्ही स्वतःच्या नावाने पोस्ट करत आहात"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("या कम्युनिटीमध्ये पोस्ट करा"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("आत्ताच"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("विषय 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("तुमच्यासाठी"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("मध्ये काहीतरी आहे."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("आता तिकडे जात आहे."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", नाही"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("मी हलत आहे का"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("आवाज बंद करा"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("आवाज चालू करा"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("तुमच्यासाठी"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("तुमचे टॅब"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("चिन्ह (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("दररोजचे प्रेक्षक"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("लोड करता आले नाही"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ही पोस्ट"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("काही जोडायचे आहे? (पर्यायी)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ही पोस्ट"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("एका खात्याकडून"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("लॉग आउट"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("तुमचे खाते"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("पासवर्डची पुष्टी करा"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("आत्ता नाही"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("लोड होत आहे…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("पोस्ट होत आहे…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 तासांपूर्वी"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("स्टोरीची लिंक कॉपी करा"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("तुमची स्टोरी"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "तुमचे खाते, तुमच्या पोस्ट आणि तुम्ही ज्यावर टॅप करता ते, जेणेकरून"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("विषय जोडा"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("स्वतःचे."),
      "authorBlocked": (Object a0) => "${a0} ब्लॉक केले",
      "authorPostsHidden": (Object a0) =>
          "तुम्हाला ${a0} च्या पोस्ट दिसणार नाहीत",
      "block": MessageLookupByLibrary.simpleMessage("ब्लॉक करा"),
      "blockAuthor": (Object a0) => "${a0} ला ब्लॉक करायचे?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("बिल्ड तपशील कॉपी झाले"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "पुढे सुरू ठेवून तुम्ही सहमत होता"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "पुढे सुरू ठेवून तुम्ही आमच्या सेवा अटी आणि गोपनीयता धोरणाशी सहमत होता"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("साइन अप करून तुम्ही सहमत होता"),
      "cancel": MessageLookupByLibrary.simpleMessage("रद्द करा"),
      "change": MessageLookupByLibrary.simpleMessage("बदला"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("ईमेल बदला"),
      "checkEmailConfirm":
          MessageLookupByLibrary.simpleMessage("तुमच्या ईमेलवरून खाते पडताळा."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Kyron पोहोचण्याजोगा आहे का ते तपासा"),
      "clear": MessageLookupByLibrary.simpleMessage("साफ करा"),
      "close": MessageLookupByLibrary.simpleMessage("बंद करा"),
      "closeCommunity": (Object a0) => "${a0} बंद करायची?",
      "closeIt": MessageLookupByLibrary.simpleMessage("ती बंद करा"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("ही कम्युनिटी बंद करा"),
      "communities": MessageLookupByLibrary.simpleMessage("कम्युनिटी"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "एक्सप्लोरमध्ये एखादी शोधा किंवा तुमची स्वतःची सुरू करा."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "एखादे तिखट मत मांडा (किंवा कोमट)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("तुमच्या मनात काय आहे?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "असे काहीतरी सांगा जे फक्त तुम्हीच सांगू शकता…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("हाच संकेत आहे: पोस्ट करा"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "टाइप करा, बोला किंवा मोठ्याने विचार करा"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("पासवर्डची पुष्टी करा"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("सपोर्टशी संपर्क साधा"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "पोस्टना अद्याप भाषा नसते, त्यामुळे हे अद्याप तुमचा फीड फिल्टर करत नाही. तोपर्यंत तुमच्या निवडी जतन राहतात."),
      "continueAction": MessageLookupByLibrary.simpleMessage("सुरू ठेवा"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("ईमेलसह सुरू ठेवा"),
      "copy": MessageLookupByLibrary.simpleMessage("कॉपी करा"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("त्याऐवजी अहवाल कॉपी करा"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google साइन-इन उघडता आले नाही. ${a0}",
      "couldNotSignOut": (Object a0) => "लॉग आउट अयशस्वी: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("फोटो काढता आला नाही."),
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
      "create": MessageLookupByLibrary.simpleMessage("तयार करा"),
      "createAccount": MessageLookupByLibrary.simpleMessage("खाते तयार करा"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("तुमचे खाते तयार करा"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("तुमची प्रोफाइल तयार करा"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR लेन्स"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("लाइव्ह जा"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("मजकूर पोस्ट"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("व्हॉइस पोस्ट"),
      "delete": MessageLookupByLibrary.simpleMessage("हटवा"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("ही टिप्पणी हटवायची?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("ही पोस्ट हटवायची?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("या जोडणीचे वर्णन करा"),
      "description": MessageLookupByLibrary.simpleMessage("वर्णन"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID क्लिपबोर्डवर कॉपी झाला"),
      "done": MessageLookupByLibrary.simpleMessage("झाले"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "काहीतरी लिहिल्यानंतर एडिटर बंद करा, तुम्हाला मसुदा सुचवला जाईल."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} दिवसांपूर्वी"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} तासांपूर्वी"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("आत्ताच"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} मिनिटांपूर्वी"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("अद्याप काहीही लिहिलेले नाही"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("पोल, अद्याप प्रश्न नाही"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("कोट, अद्याप मजकूर नाही"),
      "drafts": MessageLookupByLibrary.simpleMessage("मसुदे"),
      "editProfile":
          MessageLookupByLibrary.simpleMessage("प्रोफाइल संपादित करा"),
      "email": MessageLookupByLibrary.simpleMessage("ईमेल"),
      "emailNotifications": MessageLookupByLibrary.simpleMessage("ईमेल सूचना"),
      "explore": MessageLookupByLibrary.simpleMessage("एक्सप्लोर"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "या डिव्हाइसवर चेहरा ट्रॅकिंग उपलब्ध नाही."),
      "feedTagDetail": (Object a0) =>
          "#${a0} सह अद्याप काहीही पोस्ट झालेले नाही.",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("{name} यांना फॉलो करा"),
      "followers": MessageLookupByLibrary.simpleMessage("फॉलोअर"),
      "following": MessageLookupByLibrary.simpleMessage("फॉलो करत आहात"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("पासवर्ड विसरलात?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("मदत मिळवणे"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Google सह सुरू ठेवा"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Google ने साइन इन करा"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google पूर्ण झालेले साइन-इन Kyron ला अशा लिंकद्वारे परत करते ज्याला फक्त Android आणि iOS उत्तर देतात, त्यामुळे ${a0} वर ब्राउझरला ते परत करायला जागा नाही.\\n\\nGoogle द्वारे तुमचे आधीच Kyron खाते असल्यास, त्याच पत्त्यासह ईमेलसह सुरू ठेवा निवडा आणि पासवर्ड विसरलात वर टॅप करा: पासवर्ड सेट करण्याची लिंक मिळेल.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google साइन-इनसाठी फोन अ‍ॅप लागते"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Google ने साइन अप करा"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "मार्गदर्शक आणि नेहमीच्या प्रश्नांची उत्तरे"),
      "handle": MessageLookupByLibrary.simpleMessage("हँडल"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("मदत आणि सहाय्य"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("मदत केंद्र"),
      "home": MessageLookupByLibrary.simpleMessage("होम"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("एका ओळीत"),
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
      "interest_add": MessageLookupByLibrary.simpleMessage("आवड जोडा"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("क्रम बदलण्यासाठी ओढा"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "बारमध्ये जास्तीत जास्त पाच टॅब बसतात. दुसरा जोडण्यासाठी एक काढा."),
      "interest_following":
          MessageLookupByLibrary.simpleMessage("फॉलो करत आहात"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("तुमच्यासाठी"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "लोक हॅशटॅग वापरू लागल्यावर ते इथे दिसतील."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("आत्ता ट्रेंडिंग"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("व्हिडिओ"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("तुमचे टॅब"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
          "ते तुम्हा दोघांसाठी नाहीसे होईल."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("ते थ्रेडमधून काढले जाईल."),
      "join": MessageLookupByLibrary.simpleMessage("सामील व्हा"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("संपादन सुरू ठेवा"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron च्या स्क्रीन तुमच्या भाषेत आहेत. एखादा शब्द चुकीचा वाटल्यास, अभिप्राय पाठवा मधून आम्हाला सांगा."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("भाषा"),
      "leave": MessageLookupByLibrary.simpleMessage("सोडा"),
      "leaveCommunity": (Object a0) => "${a0} सोडायची?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("परत येऊ द्या"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 पेज उघडे आहे"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("क्लिप जोडा"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF जोडा"),
      "literaladdAHashtag": MessageLookupByLibrary.simpleMessage("हॅशटॅग जोडा"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("फोटो जोडा"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("पोल जोडा"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("व्हिडिओ जोडा"),
      "literaladdAnInterest": MessageLookupByLibrary.simpleMessage("आवड जोडा"),
      "literaladdLabelAsATab": (Object a0) => "${a0} टॅब म्हणून जोडा",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("अ‍ॅपची भाषा"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("अ‍ॅप आवृत्ती"),
      "literalblockAuthor": (Object a0) => "${a0} ला ब्लॉक करा",
      "literalblockAuthor2": (Object a0) => "${a0} ला ब्लॉक करायचे?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("हे खाते ब्लॉक करायचे?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("उत्तर रद्द करा"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("पुन्हा तपासा"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("गॅलरीतून निवडा"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("कॅशे साफ करा"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("सर्व पेज बंद करा"),
      "literalcloseTabLabel": (Object a0) => "${a0} बंद करा",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("ब्राउझर बंद करा"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0} बंद करायची?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("सहाय्याशी संपर्क साधा"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("मजकुराच्या भाषा"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("लिंक कॉपी करा"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("पोस्टची लिंक कॉपी करा"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("पोस्टचा मजकूर कॉपी करा"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("मजकूर कॉपी करा"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "कम्युनिटी लोड करता आल्या नाहीत"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF लोड करता आले नाहीत"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("सूचना लोड करता आल्या नाहीत"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("सदस्य लोड करता आले नाहीत"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("या पोस्ट लोड करता आल्या नाहीत"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("हे संभाषण लोड करता आले नाही"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("ही यादी लोड करता आली नाही"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("ही पोस्ट लोड करता आली नाही"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("हे उत्तर लोड करता आले नाही"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "लोकप्रिय टॅग लोड करता आले नाहीत"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "तुमच्या कम्युनिटी लोड करता आल्या नाहीत"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "तुमचे संदेश लोड करता आले नाहीत"),
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("ही कम्युनिटी उघडता आली नाही"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("उत्तर पोस्ट करता आले नाही."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("शोध चालला नाही"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "लॉग आउट अयशस्वी: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} पेज उघडी आहेत",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("कव्हर फोटो"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("डेटा बचत"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("पोस्ट हटवा"),
      "literaldiscoverPeople": MessageLookupByLibrary.simpleMessage("लोक शोधा"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("उत्तर देऊ नका"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("मसुदा जतन झाला"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "आत्ता अभिप्राय पाठवता येत नाही"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("मजकुराचा आकार"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF सेट केलेले नाहीत"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("दुसऱ्या अ‍ॅपला द्या"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("पासवर्ड लपवा"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("ही पोस्ट लपवा"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "ती लपवते आणि आम्हाला अशा कमी दाखवायला सांगते"),
      "literalhowToBehave": MessageLookupByLibrary.simpleMessage("कसे वागावे"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("लिहिणे सुरू ठेवा"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron ने उत्तर दिले नाही"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} तारीख",
      "literalleaveCommunityName": (Object a0) => "${a0} सोडायची?",
      "literallensNameFaceLens": (Object a0) => "${a0}, चेहरा लेन्स",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("आवडलेल्या पोस्ट"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("लिंक कॉपी झाली"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("मॉडरेटर बनवा"),
      "literalmuteAuthor": (Object a0) => "${a0} ला म्यूट करा",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("हा थ्रेड म्यूट करा"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("शब्द किंवा टॅग म्यूट करा"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("म्यूट आणि ब्लॉक केलेली खाती"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "म्यूट केले. तुम्हाला सूचना मिळणार नाहीत."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "या डिव्हाइसवरील कोणतेही अ‍ॅप ${a0} लिंक उघडत नाही.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "या डिव्हाइसवरील कोणत्याही ब्राउझरने लिंक स्वीकारली नाही."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("अद्याप DID नाही"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("मसुदे नाहीत"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("अद्याप आवडी नाहीत"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("अद्याप लाइक नाहीत"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("अद्याप संदेश नाहीत"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("नवीन फॉलोअर नाहीत"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("अद्याप पोस्ट नाहीत"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("अद्याप उत्तरे नाहीत"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("अद्याप रीपोस्ट नाहीत"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "कोणताही लोकप्रिय टॅग जुळत नाही"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("कोणीही सापडले नाही"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("कोणालाही काढलेले नाही"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("इथे अद्याप कोणी नाही"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("स्वारस्य नाही"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("काहीही सापडले नाही"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("अद्याप काही ट्रेंडिंग नाही"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("लॉगमध्ये अद्याप काही नाही"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("जुळणारे नाही"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("काही म्यूट नाही"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("अद्याप पाहण्यासारखे काही नाही"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("न वाचलेले काही नाही"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("हे फक्त मालक बदलू शकतो"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("उत्तर उघडा"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Kyron चा ईमेल उघडा"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("पासवर्ड आणि लॉग इन"),
      "literalpostInCommunityName": (Object a0) => "${a0} मध्ये पोस्ट करा",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "${a0} मध्ये पोस्ट करा",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage("वर तुमच्या शब्दांसह पोस्ट करा"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("मुख्य भाषा"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("पुश सूचना"),
      "literalreading": MessageLookupByLibrary.simpleMessage("तपासत आहे…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("व्हॉइस पोस्ट रेकॉर्ड करा"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("पुन्हा रेकॉर्ड करा"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("मॉडरेटरमधून काढा"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("कम्युनिटीतून काढा"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("जतन केलेल्यांतून काढा"),
      "literalremoveLabel": (Object a0) => "${a0} काढा",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0} काढा",
      "literalremoveMemberDisplayname": (Object a0) => "${a0} ला काढायचे?",
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage("पोल काढा"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("हे उत्तर काढा"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("हे संभाषण हटवा"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("हा पोल काढा"),
      "literalreportAuthor": (Object a0) => "${a0} ची तक्रार करा",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("पोस्टची तक्रार करा"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("कोड पुन्हा पाठवा"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("जतन केलेल्या पोस्ट"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("काहीतरी सांगा"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "${a0} मध्ये काहीतरी सांगा",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("शोध अयशस्वी"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("पुन्हा पाठवा"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "${a0} से. मध्ये पुन्हा पाठवा",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("अभिप्राय द्या"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("लिंक पाठवा"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "पाठवले. हा अहवाल क्र. ${a0} आहे.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("पासवर्ड सेट करा आणि सुरू ठेवा"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("लॉग सहाय्यासोबत शेअर करा"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("ही कम्युनिटी शेअर करा"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("हे पेज शेअर करा"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("ही प्रोफाइल शेअर करा"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("शेअर करा…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("कोटसह शेअर करा"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("अशा आणखी दाखवा"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("पासवर्ड दाखवा"),
      "literalshowResults": MessageLookupByLibrary.simpleMessage("निकाल दाखवा"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी सुरू करा"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("रेकॉर्डिंग सुरू करा"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("लोड होणे थांबवा"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "ही पोस्ट आणि तिची उत्तरे पाहणे थांबवा"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "स्टोरी पट्टी, ${a0} आयटम",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("कॅमेरा बदला"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("कोणालातरी टॅग करा"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("फोटो काढा"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "बदलण्यासाठी बॅनर किंवा फोटोवर टॅप करा"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("त्यातील लिंकवर टॅप करा"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "फोटो आणि कव्हर जोडण्यासाठी टॅप करा"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "ते जमले नाही. पुन्हा प्रयत्न करा."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("तो GIF लोड करता आला नाही."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage("ही लिंक इथे उघडता येत नाही."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("कॅमेरा बंद आहे"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("ही कम्युनिटी"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("हे उत्तर आता उपलब्ध नाही"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("पोस्टचे भाषांतर करा"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("आवाज बंद करा"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("आवाज चालू करा"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("आमच्यापैकी एक वापरा"),
      "literalverificationCodeResent":
          MessageLookupByLibrary.simpleMessage("पडताळणी कोड पुन्हा पाठवला."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "पडताळणी अयशस्वी: ${a0}",
      "literalverifyEmail": MessageLookupByLibrary.simpleMessage("ईमेल पडताळा"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "प्रेक्षक, लाइक, सेव्ह आणि टिप्पण्या"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kyron काय ठेवतो"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("हे अ‍ॅप काय करत होते"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "तुम्ही काय केले, काय अपेक्षित होते, काय झाले "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
          "तुम्ही पोस्ट करता ते तुमचे आहे"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Kyron आत्ता पोहोचण्याजोगा आहे का"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("कोण उत्तर देऊ शकतो"),
      "literalwhoDoYouWantToTag": MessageLookupByLibrary.simpleMessage(
          "तुम्हाला कोणाला टॅग करायचे आहे?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "तुम्ही आधीच सर्व लोकप्रिय टॅग फॉलो करत आहात"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("तुम्ही सगळे पाहिले"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "तुम्ही कोणत्याही कम्युनिटीत नाही"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("तुम्ही लॉग आउट झाला आहात."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "तुम्ही ${a0} सोडली",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "तुम्ही अद्याप काहीही पोस्ट केलेले नाही"),
      "loadMore": MessageLookupByLibrary.simpleMessage("अधिक लोड करा"),
      "logCleared": MessageLookupByLibrary.simpleMessage("लॉग साफ झाला"),
      "logCopied": MessageLookupByLibrary.simpleMessage("लॉग कॉपी झाला"),
      "logIn": MessageLookupByLibrary.simpleMessage("लॉग इन करा"),
      "logOut": MessageLookupByLibrary.simpleMessage("लॉग आउट"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("लॉग आउट करायचे?"),
      "login": MessageLookupByLibrary.simpleMessage("लॉग इन"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "लॉग इन अयशस्वी. तुमची माहिती तपासा."),
      "manage": MessageLookupByLibrary.simpleMessage("व्यवस्थापित करा"),
      "menu": MessageLookupByLibrary.simpleMessage("मेनू"),
      "message": MessageLookupByLibrary.simpleMessage("संदेश"),
      "messages": MessageLookupByLibrary.simpleMessage("संदेश"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "तुम्ही सर्व संभाषणे वाचली आहेत."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "कोणाचीतरी प्रोफाइल उघडा आणि संभाषण सुरू करण्यासाठी संदेशवर टॅप करा."),
      "mute": MessageLookupByLibrary.simpleMessage("म्यूट करा"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("म्यूट आणि ब्लॉक केलेले"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("म्यूट केलेले शब्द आणि टॅग"),
      "name": MessageLookupByLibrary.simpleMessage("नाव"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> स्क्रीन"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("नवीन ईमेल पत्ता"),
      "newPassword": MessageLookupByLibrary.simpleMessage("नवीन पासवर्ड"),
      "newPost": MessageLookupByLibrary.simpleMessage("नवीन पोस्ट"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("आत्ता नाही"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "पाठवले नाही. पुन्हा प्रयत्न करण्यासाठी टॅप करा"),
      "nothingMatchesQuery": (Object a0) =>
          "Kyron वर \"${a0}\" शी काहीही जुळत नाही",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("कॉपी करण्यासारखे काही नाही"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "लाइक, उत्तरे आणि नवीन फॉलोअर इथे येतात."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "तुम्हाला फॉलो करणारे लोक इथे दिसतील."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "कोणाला तुमची पोस्ट आवडल्यास ते इथे दिसेल."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "तुमच्या पोस्टची उत्तरे इथे येतात."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "कोणी तुम्हाला रीपोस्ट केल्यास ते इथे दिसेल."),
      "notifications": MessageLookupByLibrary.simpleMessage("सूचना"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("ब्राउझरमध्ये उघडा"),
      "or": MessageLookupByLibrary.simpleMessage("किंवा"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("पेज सापडले नाही"),
      "password": MessageLookupByLibrary.simpleMessage("पासवर्ड"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("पासवर्ड खूप लहान आहे"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("तुमच्या आवडी निवडा"),
      "post": MessageLookupByLibrary.simpleMessage("पोस्ट करा"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("पोस्ट आकडेवारी"),
      "postInCommunity": (Object a0) => "${a0} मध्ये पोस्ट करा",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("पोस्ट करा, बोला, दाखवा."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("पोस्टचा मजकूर कॉपी झाला"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("गोपनीयता धोरण"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("प्रोफाइल अपडेट झाली"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("परिचय"),
      "profile_country": MessageLookupByLibrary.simpleMessage("देश"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("डिस्प्ले नाव"),
      "profile_location": MessageLookupByLibrary.simpleMessage("स्थान"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("बदलण्यासाठी टॅप करा"),
      "profile_website": MessageLookupByLibrary.simpleMessage("वेबसाइट"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage("पुश सूचना"),
      "quote": MessageLookupByLibrary.simpleMessage("कोट करा"),
      "quotePost": MessageLookupByLibrary.simpleMessage("पोस्ट कोट करा"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("माणसाशी संपर्क साधा"),
      "remove": MessageLookupByLibrary.simpleMessage("काढा"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("हे संभाषण हटवायचे?"),
      "removeMember": (Object a0) => "${a0} ला काढायचे?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("हा संदेश हटवायचा?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("उत्तरे, फॉलो आणि उल्लेख"),
      "repliesPolicy": (Object a0) => "उत्तरे: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("उत्तर द्या"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("कोणीही सहभागी होऊ शकतो"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "कोणीही अजूनही ही पोस्ट पाहू, रीपोस्ट करू आणि कोट करू शकतो."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron वरील कोणीही या पोस्टला उत्तर देऊ शकतो."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("तुम्हाला फॉलो करणारे"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "फक्त तुम्हाला फॉलो करणारे या पोस्टला उत्तर देऊ शकतात."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("तुम्ही उल्लेख केलेले लोक"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "या पोस्टमध्ये तुम्ही @उल्लेख केलेले लोकच उत्तर देऊ शकतात."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("कोणीही उत्तर देऊ शकत नाही"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "उत्तरे बंद आहेत. तुम्ही तरीही स्वतः उत्तर देऊ शकता."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("कोण उत्तर देऊ शकतो?"),
      "report": MessageLookupByLibrary.simpleMessage("रिपोर्ट करा"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "अहवाल कॉपी झाला. सहाय्य टीमला पाठवायच्या ईमेलमध्ये पेस्ट करा."),
      "reportSent": MessageLookupByLibrary.simpleMessage("रिपोर्ट पाठवला"),
      "repost": MessageLookupByLibrary.simpleMessage("रीपोस्ट करा"),
      "reset": MessageLookupByLibrary.simpleMessage("रीसेट करा"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("तुमचा पासवर्ड रीसेट करा"),
      "retry": MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "save": MessageLookupByLibrary.simpleMessage("जतन करा"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("मसुदा जतन करा"),
      "saySomething": (Object a0) => "${a0} मध्ये काहीतरी सांगा",
      "search": MessageLookupByLibrary.simpleMessage("शोधा"),
      "searchByNameOrHandle":
          MessageLookupByLibrary.simpleMessage("नाव किंवा हँडलने शोधा"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी शोधा"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF शोधा"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("भाषा शोधा"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("लोकप्रिय टॅग शोधा"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "सुरक्षा सूचना आणि खात्यातील बदल"),
      "selectAppLanguage":
          MessageLookupByLibrary.simpleMessage("अ‍ॅप इंटरफेसची भाषा निवडा."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "तुमच्या फीडमध्ये कोणत्या भाषा दिसाव्यात ते निवडा. काहीच न निवडल्यास सर्व भाषा दाखवल्या जातात."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "फीडमधील भाषांतरांसाठी तुमची मुख्य भाषा निवडा."),
      "send": MessageLookupByLibrary.simpleMessage("पाठवा"),
      "sendConfirmation": MessageLookupByLibrary.simpleMessage("पडताळणी पाठवा"),
      "sendErrorReport": MessageLookupByLibrary.simpleMessage("बग अहवाल पाठवा"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("अभिप्राय पाठवा"),
      "sendReport": MessageLookupByLibrary.simpleMessage("रिपोर्ट पाठवा"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("सहाय्याला पाठवा"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("सेवेची स्थिती"),
      "settings": MessageLookupByLibrary.simpleMessage("सेटिंग्ज"),
      "shareAppLog":
          MessageLookupByLibrary.simpleMessage("अ‍ॅप लॉग सहाय्यासोबत शेअर करा"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Kyron मध्ये साइन इन करा"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("म्हणून साइन इन"),
      "signupFailed": (Object a0) => "साइन अप अयशस्वी: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("थांबा"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron अजून सुरुवातीच्या टप्प्यात आहे, आणि हे खरोखर दुरुस्त करू शकणाऱ्या व्यक्तीपर्यंत पोहोचण्याचा सर्वात जलद मार्ग म्हणजे तिकीट उघडणे. तुम्ही काय करत होता आणि काय झाले ते सांगा."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "अ‍ॅपमध्ये अद्याप सहाय्य इनबॉक्स नाही, त्यामुळे ही स्क्रीन तुम्हाला कुठेही न जाणाऱ्या फॉर्मऐवजी खरोखर लक्ष ठेवल्या जाणाऱ्या ठिकाणी नेते."),
      "systemLog": MessageLookupByLibrary.simpleMessage("अ‍ॅप लॉग"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "काय कमी आहे किंवा काय बिघडले ते सांगा"),
      "terms": MessageLookupByLibrary.simpleMessage("सेवा अटी"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "मजकूर, आवाज आणि व्हिडिओ, ते बनवणारे लोक आणि ते गप्पा मारतात त्या खोल्या."),
      "theComposerNoPostButton":
          MessageLookupByLibrary.simpleMessage("एडिटरमध्ये पोस्ट बटण नाही"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("गडद"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("नेहमी गडद"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("मंद"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "मऊ गडद, काळ्याऐवजी निळसर राखाडी"),
      "theme_light": MessageLookupByLibrary.simpleMessage("फिकट"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("नेहमी फिकट"),
      "theme_system": MessageLookupByLibrary.simpleMessage("सिस्टम"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "फोनच्या फिकट किंवा गडद सेटिंगनुसार"),
      "translate": MessageLookupByLibrary.simpleMessage("भाषांतर करा"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "भाषांतर अद्याप सुरू नाही. तुमच्या फीडमध्ये अद्याप काहीही भाषांतरित होत नाही; तोपर्यंत हे लक्षात ठेवले जाते."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "हे Kyron चे स्वतःचे शब्द, Flutter स्वतः काढतो ते इंटरफेसचे भाग, तारखा आणि संख्या, आणि उजवीकडून डावीकडे लिहिल्या जाणाऱ्या भाषांसाठी अ‍ॅपच्या मांडणीची दिशा बदलते."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("गोपनीयता धोरण"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("सेवा अटी"),
      "ui_account": MessageLookupByLibrary.simpleMessage("खाते"),
      "ui_after": MessageLookupByLibrary.simpleMessage("नंतर"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("अ‍ॅप आणि डिव्हाइस"),
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
      "ui_appearance": MessageLookupByLibrary.simpleMessage("स्वरूप"),
      "ui_appearance_detail":
          MessageLookupByLibrary.simpleMessage("फिकट, गडद किंवा फोननुसार"),
      "ui_before": MessageLookupByLibrary.simpleMessage("आधी"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्ही दोघे Kyron वर एकमेकांना दिसणार नाही, आणि तुमच्यातील फॉलो काढले जातील. त्यांना कळवले जात नाही."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("यामध्ये आहे"),
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
      "ui_communities": MessageLookupByLibrary.simpleMessage("कम्युनिटी"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("हे कशासाठी? (पर्यायी)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("पोस्ट:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("मजकूर आणि डिस्प्ले"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("तुमचा फीड लोड करता आला नाही"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "तुम्हाला आवडलेल्या पोस्ट लोड करता आल्या नाहीत"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "तुमची प्रोफाइल लोड करता आली नाही"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "तुमच्या जतन केलेल्या पोस्ट लोड करता आल्या नाहीत"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("विकेंद्रित ID"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("समस्यानिवारण"),
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
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("इथे अद्याप काही नाही"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "काही खाती फॉलो करा, त्यांच्या पोस्ट इथे दिसतील."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "तुम्ही फॉलो करता त्यांच्याकडून काही नाही"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "लोक लिहितील तशा पोस्ट इथे दिसतील."),
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
          "क्लिप असलेल्या पोस्ट इथे दिसतील."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("अद्याप व्हिडिओ नाहीत"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("अभिप्राय"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Kyron वर लोक शोधा"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("एका खात्याकडून"),
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
      "ui_help": MessageLookupByLibrary.simpleMessage("मदत"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "नोंद घेतली. यामुळे तुम्हाला काय दाखवायचे ते निवडायला मदत होते."),
      "ui_join": MessageLookupByLibrary.simpleMessage("सामील व्हा"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("सामील झाले"),
      "ui_language": MessageLookupByLibrary.simpleMessage("भाषा"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("तुमची भाषा निवडा"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("कायदेशीर"),
      "ui_like": MessageLookupByLibrary.simpleMessage("लाइक"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("आवडलेल्या पोस्ट"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्हाला आवडलेल्या पोस्ट इथे दिसतात, नवीन आधी."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("लिंक कॉपी झाली"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "तुम्हाला आता त्यांच्या पोस्ट दिसणार नाहीत. त्यांना कळवले जात नाही."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("अद्याप लाइक नाहीत"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "त्या फिल्टरशी कोणतीही पोस्ट जुळत नाही."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("अद्याप काही जतन केलेले नाही"),
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
          MessageLookupByLibrary.simpleMessage("पूर्ण"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("वगळा"),
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
      "ui_pause": MessageLookupByLibrary.simpleMessage("विराम"),
      "ui_play": MessageLookupByLibrary.simpleMessage("प्ले करा"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "ती तुमच्या प्रोफाइलमधून आणि सर्वांच्या फीडमधून काढली जाईल. तिची उत्तरेही तिच्यासोबत जातील."),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("पोस्ट हटवली"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("पोस्ट लपवली"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("पोस्टचा मजकूर कॉपी झाला"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("या कालावधीत पोस्ट केले"),
      "ui_posts_hidden":
          MessageLookupByLibrary.simpleMessage("लपवले. आम्ही अशा कमी दाखवू."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("प्राधान्ये"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("गोपनीयता"),
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
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("जतन केलेल्या पोस्ट"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "पोस्ट इथे ठेवण्यासाठी तिच्या आर्काइव्ह चिन्हावर टॅप करा. जतन केलेले फक्त तुम्हाला दिसते."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "हँडल किंवा डिस्प्ले नावाने शोधा."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("साफ करा"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "पोस्ट केलेल्या सर्वांमध्ये शोधा"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("फिल्टर"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("लोक शोधा"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("पोस्ट शोधा"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("सेटिंग्ज"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("अ‍ॅप आणि डिव्हाइस"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("मजकूर आणि डिस्प्ले"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("डेटा बचत"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("तुमचे विचार सांगा"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("मदत लेख पाहा"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("तुमची भाषा निवडा"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "तुम्ही कोणाला म्यूट किंवा ब्लॉक केले आहे"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("सूचना प्राधान्ये"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "तुमची प्रोफाइल आणि संपर्क तपशील"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "तुमच्या खात्यात परत येण्यासाठी तुम्हाला पुन्हा साइन इन करावे लागेल."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("सुरक्षा सेटिंग्ज"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("पासवर्डची पुष्टी करा"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("एका ओळीत"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("नवीन ईमेल पत्ता"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("नवीन पासवर्ड"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("काय झाले"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("आमच्या टीमकडून मदत मिळवा"),
      "ui_share": MessageLookupByLibrary.simpleMessage("शेअर करा"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("उद्धृत करा"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("मेसेजमध्ये पाठवा"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron वरील लोकांना"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("ही पोस्ट शेअर करा"),
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
      "ui_terms": MessageLookupByLibrary.simpleMessage("सेवा अटी"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ही पोस्ट"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("थ्रेड म्यूट केला"),
      "ui_try_again":
          MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("आवाज बंद करा"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("आवाज चालू करा"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("किमान दोन अक्षरे."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("पूर्ववत करा"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "शब्द, किंवा फिल्टर: खाते, तारखांची श्रेणी किंवा पोस्टमध्ये काय आहे."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("रीपोस्ट मागे घ्या"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("पासवर्ड अपडेट करा"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("दुसरा पत्ता वापरा"),
      "username": MessageLookupByLibrary.simpleMessage("वापरकर्ता नाव"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "वापरकर्ता नाव लहान अक्षरांत असावे (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("व्हिडिओ"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("जोडा"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("जोडण्यासाठी तयार"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("व्हॉइस पोस्ट रेकॉर्ड करा"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("जतन होत आहे…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("थांबवा"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("काय झाले"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "काय झाले, आणि आम्ही काय पाहावे?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("या प्रतिमेत काय आहे?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("हे कशासाठी? (पर्यायी)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "तुम्ही काय केले, काय अपेक्षित होते, काय झाले"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "हे घडले तेव्हा तुम्ही काय करत होता."),
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
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("फॉलोअर"),
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
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("ती लेन्स लोड होऊ शकली नाही."),
      "ar_could_not_record": MessageLookupByLibrary.simpleMessage(
          "व्हिडिओ रेकॉर्ड होऊ शकला नाही."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "या व्हिडिओमध्ये लेन्स जोडता आली नाही, त्यामुळे तो चित्रित केल्याप्रमाणेच पोस्ट होईल."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "तुमच्या पोस्टमध्ये आधीच कमाल संलग्नके आहेत."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("तुमची लेन्स जोडत आहे…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("फ्लॅश"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("व्हिडिओ रेकॉर्ड करा"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("फोटो"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("व्हिडिओ"),
      "googleSignInCancelled":
          MessageLookupByLibrary.simpleMessage("Google साइन-इन रद्द केले."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("भेटवस्तू"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "अजून कोणीही या पोस्टला भेटवस्तू पाठवलेली नाही."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("भेटवस्तू"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("भेटवस्तू"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("नाणी"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("पाठवणारा"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("पाठवणारे"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "चाचणी नाणी: ती अजून काढता येत नाहीत."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("जतन केलेले"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("पोस्ट"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("टिप्पण्या"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("आणखी उत्तरे पाहा"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("संपादित"),
      "ui_more": MessageLookupByLibrary.simpleMessage("आणखी"),
      "ui_following": MessageLookupByLibrary.simpleMessage("फॉलो करत आहात"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("टॉप"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("अलीकडील"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage(
          "टिप्पण्या क्रमवारी लावा: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "यांनी तुमच्या पोस्टला भेटवस्तू पाठवली"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "यांनी तुमच्या टिप्पणीला \$gift पाठवले"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "यांनी तुमच्या पोस्टला \$gift पाठवले"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("भेटवस्तू पाठवा"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("पोस्ट संपादित करा"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "तुम्ही ती आणखी \$n मिनिटे संपादित करू शकता"),
      "ui_save": MessageLookupByLibrary.simpleMessage("जतन करा"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "#\$tab अंतर्गत अजून काहीही पोस्ट झालेले नाही."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("एक भेटवस्तू निवडा"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("पुरेशी नाणी नाहीत"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "चाचणी नाणी: ती खरेदी करता येत नाहीत आणि त्यांना रोख मूल्य नाही."),
      "ui_gift_refills_on": MessageLookupByLibrary.simpleMessage(
          "\$date रोजी पुन्हा भरली जातील."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 नाणे"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count नाणी"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("तुमच्याकडे \$coins आहेत"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift पाठवा"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift पाठवले"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("पुन्हा प्रयत्न करा"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "पोस्ट केल्यानंतर 15 मिनिटांपर्यंत"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("संपादित केले"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "तुमच्या जतन केलेल्या टिप्पण्या लोड होऊ शकल्या नाहीत"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("जतन केलेल्या टिप्पण्या नाहीत"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "टिप्पणी येथे ठेवण्यासाठी तिच्या खालील संग्रह चिन्हावर टॅप करा. तुम्ही जे जतन करता ते फक्त तुम्हीच पाहू शकता."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("\$name यांना उत्तर"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("कॉपी करा"),
      "ui_search": MessageLookupByLibrary.simpleMessage("शोधा"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("सर्व निवडा"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("\$count भेटवस्तू"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 भेटवस्तू"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "आणखी पोस्ट लोड होऊ शकल्या नाहीत."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("स्मरणपत्रे"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "काही काळ दूर राहिल्यानंतर नवीन काय आहे, आणि तुमची नाणी परत आल्यावर. दिवसातून एकापेक्षा जास्त कधीच नाही."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("भेटवस्तू"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("1 व्यक्तीकडून"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count लोकांकडून"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("सर्वात मोठा देणगीदार"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "भेटवस्तू कोणी पाठवल्या ते लोड होऊ शकले नाही."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("नवीन काय"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("समजले"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "धन्यवाद. आम्ही प्रत्येक उत्तर वाचतो."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("आतापर्यंत Kyron कसे वाटले?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "तुमच्या चाचणीचा दिवस \$day. एक टॅप पुरेसा आहे."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "काही दुरुस्त किंवा जोडायला हवे? (पर्यायी)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("पाठवा"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("आता नाही"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Kyron सोडण्यासाठी पुन्हा मागे दाबा"),
    };

final messageLookup = MessageLookup();
