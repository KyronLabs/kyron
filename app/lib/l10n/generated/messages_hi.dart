import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hi';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("शब्द, वाक्यांश या #टैग"),
      "about": MessageLookupByLibrary.simpleMessage("परिचय"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("जवाब जोड़ें"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("भाषाएँ जोड़ें…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("सहमत हों और जारी रखें"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("क्या पहले से Kyron खाता है?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("टिप्पणियाँ"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "अलग-अलग लोग, खोलने की संख्या नहीं"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("जुड़ाव"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("लाइक"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("अभी कोई दर्शक नहीं"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "इस पोस्ट को अभी किसी ने नहीं खोला।"),
      "analytics_posted":
          MessageLookupByLibrary.simpleMessage("पोस्ट किया गया"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("सेव"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("दर्शक"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("प्रतिदिन दर्शक"),
      "and": MessageLookupByLibrary.simpleMessage("और"),
      "answerNumber": (Object a0) => "जवाब ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR लेंस"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("ऐप लॉग संलग्न करें"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("आने-जाने का समय"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("टोकन सत्यापन"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("फिर कोशिश करें"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("फिर कोशिश करें"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "अभी प्रसारण शुरू करने पर आप ऐसे कमरे में होंगे जिसमें कोई नहीं"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी शुरू करें"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("यह किसलिए है? (वैकल्पिक)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("दोबारा आ सकेगा।"),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("इस सूची से दोबारा आ सकेगा।"),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("इसे बंद करने पर"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("पहले जुड़ें"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("जल्द आ रहा है"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage(
              "आप अपने नाम से पोस्ट कर रहे हैं"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("इस कम्युनिटी में पोस्ट करें"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("अभी-अभी"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("फिर कोशिश करें"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("विषय 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("आपके लिए"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("में कुछ है।"),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("अभी वहाँ जा रहा है।"),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", नहीं"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("क्या मैं हिल रहा हूँ"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("आवाज़ बंद करें"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("आवाज़ चालू करें"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("आपके लिए"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("आपके टैब"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("फिर कोशिश करें"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("चिह्न (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("प्रतिदिन दर्शक"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("लोड नहीं हो सका"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("यह पोस्ट"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("कुछ जोड़ना है? (वैकल्पिक)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("यह पोस्ट"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("किसी खाते से"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("लॉग आउट"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("आपका खाता"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("पासवर्ड की पुष्टि करें"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("अभी नहीं"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("लोड हो रहा है…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("पोस्ट हो रहा है…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 घंटे पहले"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("स्टोरी का लिंक कॉपी करें"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("आपकी स्टोरी"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "आपका खाता, आपकी पोस्ट और आप जिन पर टैप करते हैं, ताकि"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("विषय जोड़ें"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("अपना।"),
      "authorBlocked": (Object a0) => "${a0} को ब्लॉक किया गया",
      "authorPostsHidden": (Object a0) => "आपको ${a0} की पोस्ट नहीं दिखेंगी",
      "block": MessageLookupByLibrary.simpleMessage("ब्लॉक करें"),
      "blockAuthor": (Object a0) => "${a0} को ब्लॉक करें?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("बिल्ड विवरण कॉपी हुआ"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("जारी रखकर आप सहमत होते हैं"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "जारी रखकर आप हमारी सेवा की शर्तों और निजता नीति से सहमत होते हैं"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("साइन अप करके आप सहमत होते हैं"),
      "cancel": MessageLookupByLibrary.simpleMessage("रद्द करें"),
      "change": MessageLookupByLibrary.simpleMessage("बदलें"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("ईमेल बदलें"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "अपने ईमेल से खाते का सत्यापन करें।"),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "जाँचें कि Kyron पहुँच में है या नहीं"),
      "clear": MessageLookupByLibrary.simpleMessage("साफ़ करें"),
      "close": MessageLookupByLibrary.simpleMessage("बंद करें"),
      "closeCommunity": (Object a0) => "${a0} बंद करें?",
      "closeIt": MessageLookupByLibrary.simpleMessage("इसे बंद करें"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("यह कम्युनिटी बंद करें"),
      "communities": MessageLookupByLibrary.simpleMessage("कम्युनिटी"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "खोजें में कोई ढूँढें, या अपनी शुरू करें।"),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "कोई तीखी राय रखिए (या हल्की-फुल्की)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("आपके मन में क्या है?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "कुछ ऐसा कहें जो सिर्फ़ आप कह सकते हैं…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("यही संकेत है: पोस्ट कर दीजिए"),
      "composer_placeholder_think":
          MessageLookupByLibrary.simpleMessage("लिखें, बोलें या ज़ोर से सोचें"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("पासवर्ड की पुष्टि करें"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("सहायता से संपर्क करें"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "पोस्ट में अभी भाषा नहीं होती, इसलिए यह अभी आपकी फ़ीड फ़िल्टर नहीं करता। तब तक आपके चुनाव सहेजे रहते हैं।"),
      "continueAction": MessageLookupByLibrary.simpleMessage("जारी रखें"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("ईमेल से जारी रखें"),
      "copy": MessageLookupByLibrary.simpleMessage("कॉपी करें"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("इसके बजाय रिपोर्ट कॉपी करें"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google साइन-इन नहीं खुल सका। ${a0}",
      "couldNotSignOut": (Object a0) => "लॉग आउट नहीं हो सका: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("फ़ोटो नहीं ली जा सकी।"),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "आपकी प्रोफ़ाइल पर और आपकी पोस्ट के नीचे दिखता है।"),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "“{query}” से कोई देश मेल नहीं खाता।"),
      "country_none": MessageLookupByLibrary.simpleMessage("कोई देश न दिखाएँ"),
      "country_search": MessageLookupByLibrary.simpleMessage("देश खोजें"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "आपकी प्रोफ़ाइल पर और आपकी पोस्ट के नीचे दिखता है। जब आप किसी की पोस्ट देखते हैं, तो आपका देश उनकी इनसाइट्स में गिना जाता है, सिर्फ़ पाँच या उससे ज़्यादा के समूहों में और कभी नाम से नहीं।"),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("आपके फ़ोन की सेटिंग से"),
      "create": MessageLookupByLibrary.simpleMessage("बनाएँ"),
      "createAccount": MessageLookupByLibrary.simpleMessage("खाता बनाएँ"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("अपना खाता बनाएँ"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("अपनी प्रोफ़ाइल बनाएँ"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR लेंस"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("लाइव जाएँ"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("टेक्स्ट पोस्ट"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("वॉइस पोस्ट"),
      "delete": MessageLookupByLibrary.simpleMessage("हटाएँ"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("यह टिप्पणी हटाएँ?"),
      "deleteThisPost": MessageLookupByLibrary.simpleMessage("यह पोस्ट हटाएँ?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("इस अटैचमेंट का वर्णन करें"),
      "description": MessageLookupByLibrary.simpleMessage("विवरण"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID क्लिपबोर्ड पर कॉपी हुआ"),
      "done": MessageLookupByLibrary.simpleMessage("हो गया"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "कुछ लिखने के बाद एडिटर बंद करें, आपको ड्राफ़्ट का विकल्प मिलेगा।"),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} दिन पहले"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} घंटे पहले"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("अभी-अभी"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} मिनट पहले"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("अभी कुछ लिखा नहीं गया"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("पोल, अभी कोई सवाल नहीं"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("कोट, अभी कोई टेक्स्ट नहीं"),
      "drafts": MessageLookupByLibrary.simpleMessage("ड्राफ़्ट"),
      "editProfile":
          MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल संपादित करें"),
      "email": MessageLookupByLibrary.simpleMessage("ईमेल"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("ईमेल सूचनाएँ"),
      "explore": MessageLookupByLibrary.simpleMessage("खोजें"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "इस डिवाइस पर फ़ेस ट्रैकिंग उपलब्ध नहीं है।"),
      "feedTagDetail": (Object a0) => "#${a0} के साथ अभी कुछ पोस्ट नहीं हुआ।",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("{name} को फ़ॉलो करें"),
      "followers": MessageLookupByLibrary.simpleMessage("फ़ॉलोअर"),
      "following": MessageLookupByLibrary.simpleMessage("फ़ॉलो किए जा रहे"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage("पासवर्ड भूल गए?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("मदद पाना"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Google के साथ जारी रखें"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Google से साइन इन करें"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google पूरा हुआ साइन-इन Kyron को ऐसे लिंक से लौटाता है जिसका जवाब सिर्फ़ Android और iOS देते हैं, इसलिए ${a0} पर ब्राउज़र के पास उसे लौटाने की कोई जगह नहीं है।\\n\\nअगर Google के ज़रिए आपका पहले से Kyron खाता है, तो उसी पते के साथ ईमेल से जारी रखें चुनें और पासवर्ड भूल गए पर टैप करें: आपको पासवर्ड सेट करने का लिंक मिलेगा।",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google साइन-इन के लिए फ़ोन ऐप चाहिए"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Google से साइन अप करें"),
      "guidesAndAnswers":
          MessageLookupByLibrary.simpleMessage("गाइड और आम सवालों के जवाब"),
      "handle": MessageLookupByLibrary.simpleMessage("हैंडल"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("सहायता और समर्थन"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("सहायता केंद्र"),
      "home": MessageLookupByLibrary.simpleMessage("होम"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("एक पंक्ति में"),
      "ins_account": MessageLookupByLibrary.simpleMessage("आपका खाता"),
      "ins_act_community": MessageLookupByLibrary.simpleMessage("समुदाय खोलें"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("पोस्ट लिखें"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("पोस्ट देखें"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("अपनी प्रोफ़ाइल संपादित करें"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("वे कब सक्रिय रहते हैं"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("आपके समय क्षेत्र में।"),
      "ins_ages": MessageLookupByLibrary.simpleMessage("उम्र"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "पहुँचे {known} लोगों में से जिन्होंने जन्मदिन दिया है।"),
      "ins_chart": MessageLookupByLibrary.simpleMessage("हर दिन पहुँचे लोग"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("वे जिन समुदायों में हैं"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("देश"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "उन {known} लोगों में से जिन तक आप पहुँचे और जिनकी प्रोफ़ाइल पर देश है।"),
      "ins_days": MessageLookupByLibrary.simpleMessage("पिछले {days} दिन"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("इनसाइट्स लोड नहीं हो सकीं"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("फ़ॉलोअर"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "दिखाने लायक बड़ा कोई समूह अभी नहीं है।"),
      "ins_grow": MessageLookupByLibrary.simpleMessage("कैसे बढ़ें"),
      "ins_interests": MessageLookupByLibrary.simpleMessage(
          "वे जिन विषयों को फ़ॉलो करते हैं"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("लाइक"),
      "ins_new": MessageLookupByLibrary.simpleMessage("नया"),
      "ins_new_followers": MessageLookupByLibrary.simpleMessage("नए फ़ॉलोअर"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "इस अवधि में आपकी कोई पोस्ट किसी तक नहीं पहुँची।"),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("आपको फ़ॉलो नहीं करते"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "देश वे हैं जो लोगों ने अपनी प्रोफ़ाइल पर चुने हैं। Kyron किसी का शहर या लिंग इकट्ठा नहीं करता, इसलिए उनके लिए दिखाने को कुछ नहीं है।"),
      "ins_opens": MessageLookupByLibrary.simpleMessage("खोले गए"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} तक पहुँची · {likes} लाइक · {replies} जवाब"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("पहुँचे लोग"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "हर व्यक्ति एक बार गिना जाता है: आपकी कोई पोस्ट पहली बार उन्हें दिखाई गई या उन्होंने खोली। नए फ़ॉलोअर अब भी आपको फ़ॉलो करते हैं; अनफ़ॉलो नहीं गिने जाते।"),
      "ins_replies": MessageLookupByLibrary.simpleMessage("जवाब"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("रीपोस्ट"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("सेव"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "इस अवधि में {floor} लोगों के आपकी पोस्ट देखने के बाद दिखता है कि आपके दर्शक कौन हैं। इससे कम हों तो यह किसी खास व्यक्ति की ओर इशारा कर सकता है।"),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("अभी पर्याप्त लोग नहीं"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "उनमें से {pct}% पहले से आपको फ़ॉलो करते हैं: आपकी पोस्ट ज़्यादातर जानने वालों तक पहुँचती हैं।"),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "उनमें से {pct}% अभी आपको फ़ॉलो नहीं करते: आपकी पोस्ट खोजी जा रही हैं।"),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "आप {reach} लोगों तक पहुँचे, पिछली अवधि से {pct}% कम।"),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "पिछले {days} दिनों में आप {reach} लोगों तक पहुँचे।"),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "आप {reach} लोगों तक पहुँचे, लगभग पिछली अवधि जितने।"),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "पिछले {days} दिनों में किसी नए व्यक्ति ने आपकी पोस्ट नहीं देखी।"),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "आप {reach} लोगों तक पहुँचे, पिछली अवधि से {pct}% ज़्यादा।"),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "आप {reach} लोगों तक पहुँचे, पिछली अवधि के {times}× जितने।"),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "उनमें से ज़्यादा लोग किसी और विषय की तुलना में {name} को फ़ॉलो करते हैं।"),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("दर्शक"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("अवलोकन"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "जो लोग आपकी कोई पोस्ट पाते हैं, वे फ़ॉलो करने से पहले आपकी प्रोफ़ाइल देखते हैं। एक चेहरा या लोगो उन्हें बताता है कि वहाँ कोई है।"),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल फ़ोटो जोड़ें"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "एक पंक्ति में बताएँ कि आप किस बारे में पोस्ट करते हैं, ताकि अजनबी जान सके कि आपको फ़ॉलो करने से उसे क्या मिलेगा।"),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("बायो लिखें"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "आपकी {total} पोस्ट में से {without} का कोई विषय नहीं था। विषय पोस्ट को उस विषय की फ़ीड में और उसे फ़ॉलो करने वालों के सामने रखता है।"),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("पोस्ट में विषय जोड़ें"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} लोगों ने आपकी पोस्ट पर जवाब दिया और आपने {answered} का उत्तर दिया। उन्हें लिखने जितनी परवाह थी: एक उत्तर पाठक को नियमित बना देता है।"),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("अपने जवाबों का उत्तर दें"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "आपके दर्शक {when} सबसे ज़्यादा सक्रिय रहते हैं। उससे ठीक पहले की पोस्ट को अपनाने वाले लोग मिलते हैं।"),
      "ins_tip_best_time_t": MessageLookupByLibrary.simpleMessage(
          "जब वे सक्रिय हों तब पोस्ट करें"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "आपको फ़ॉलो न करने वाले {reached} लोगों ने आपकी पोस्ट देखीं, और {gained} ने फ़ॉलो किया। आपका बायो और नई पोस्ट बताएँ कि वे आपसे क्या उम्मीद कर सकते हैं।"),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("पाठकों को फ़ॉलोअर बनाएँ"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "एक पोस्ट आपकी बाकी पोस्ट की सामान्य पहुँच से {times}× ज़्यादा लोगों तक पहुँची। देखें उसने क्या अलग किया, और वही और करें।"),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("जो काम आया वह और करें"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "आपकी पोस्ट देखने वाले बहुत से लोग {name} में हैं। वहाँ पोस्ट करने से आप बाकी लोगों के सामने भी आते हैं।"),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("{name} में पोस्ट करें"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "आपने {days} दिनों में {posts} बार पोस्ट किया। हर पोस्ट खोजे जाने का एक और मौका है, और नियमित लय आपको फ़ॉलोअर की फ़ीड में बनाए रखती है।"),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("ज़्यादा बार पोस्ट करें"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "आपने पिछले {days} दिनों में पोस्ट नहीं किया। बिना पोस्ट के कुछ भी किसी तक नहीं पहुँचता।"),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("कुछ पोस्ट करें"),
      "ins_title": MessageLookupByLibrary.simpleMessage("इनसाइट्स"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("शीर्ष पोस्ट"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "पिछले {days} दिनों की तुलना में"),
      "interest_add": MessageLookupByLibrary.simpleMessage("रुचि जोड़ें"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("क्रम बदलने के लिए खींचें"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "बार में ज़्यादा से ज़्यादा पाँच टैब आते हैं। दूसरा जोड़ने के लिए एक हटाएँ।"),
      "interest_following":
          MessageLookupByLibrary.simpleMessage("फ़ॉलो किए जा रहे"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("आपके लिए"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "लोग जब हैशटैग इस्तेमाल करने लगेंगे, तो वे यहाँ दिखेंगे।"),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("अभी ट्रेंड में"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("वीडियो"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("आपके टैब"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
          "यह आप दोनों के लिए गायब हो जाएगा।"),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("इसे थ्रेड से हटा दिया जाएगा।"),
      "join": MessageLookupByLibrary.simpleMessage("जुड़ें"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("संपादन जारी रखें"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron की स्क्रीनें आपकी भाषा में हैं। अगर कोई शब्द गलत लगे, तो फ़ीडबैक भेजें से हमें बताएँ।"),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("भाषाएँ"),
      "leave": MessageLookupByLibrary.simpleMessage("छोड़ें"),
      "leaveCommunity": (Object a0) => "${a0} छोड़ें?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("वापस आने दें"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("1 पेज खुला है"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("क्लिप जोड़ें"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF जोड़ें"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("हैशटैग जोड़ें"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("फ़ोटो जोड़ें"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("पोल जोड़ें"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("वीडियो जोड़ें"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("रुचि जोड़ें"),
      "literaladdLabelAsATab": (Object a0) => "${a0} को टैब के रूप में जोड़ें",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("ऐप की भाषा"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("ऐप वर्शन"),
      "literalblockAuthor": (Object a0) => "${a0} को ब्लॉक करें",
      "literalblockAuthor2": (Object a0) => "${a0} को ब्लॉक करें?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("इस खाते को ब्लॉक करें?"),
      "literalcancelReply": MessageLookupByLibrary.simpleMessage("जवाब छोड़ें"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("फिर से जाँचें"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("गैलरी से चुनें"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("कैश साफ़ करें"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("सभी पेज बंद करें"),
      "literalcloseTabLabel": (Object a0) => "${a0} बंद करें",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("ब्राउज़र बंद करें"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0} बंद करें?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("सहायता से संपर्क करें"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("सामग्री की भाषाएँ"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("लिंक कॉपी करें"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("पोस्ट का लिंक कॉपी करें"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("पोस्ट का टेक्स्ट कॉपी करें"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("टेक्स्ट कॉपी करें"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी लोड नहीं हो सकीं"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF लोड नहीं हो सके"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("सूचनाएँ लोड नहीं हो सकीं"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("सदस्य लोड नहीं हो सके"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("ये पोस्ट लोड नहीं हो सकीं"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("यह बातचीत लोड नहीं हो सकी"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("यह सूची लोड नहीं हो सकी"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("यह पोस्ट लोड नहीं हो सकी"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("यह जवाब लोड नहीं हो सका"),
      "literalcouldNotLoadTrendingTags":
          MessageLookupByLibrary.simpleMessage("लोकप्रिय टैग लोड नहीं हो सके"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "आपकी कम्युनिटी लोड नहीं हो सकीं"),
      "literalcouldNotLoadYourMessages":
          MessageLookupByLibrary.simpleMessage("आपके संदेश लोड नहीं हो सके"),
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("यह कम्युनिटी नहीं खुल सकी"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("जवाब पोस्ट नहीं हो सका।"),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("खोज काम नहीं आई"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "लॉग आउट नहीं हो सका: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} पेज खुले हैं",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("कवर फ़ोटो"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("डेटा सेवर"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("पोस्ट हटाएँ"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("लोगों को खोजें"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("जवाब न दें"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("ड्राफ़्ट सहेजा गया"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage("अभी फ़ीडबैक नहीं भेजा जा सकता"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("टेक्स्ट का आकार"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF सेट अप नहीं हैं"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("किसी दूसरे ऐप को दें"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("पासवर्ड छिपाएँ"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("यह पोस्ट छिपाएँ"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "इसे छिपाता है और हमसे ऐसी कम दिखाने को कहता है"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("कैसे पेश आएँ"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("लिखना जारी रखें"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron ने जवाब नहीं दिया"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} तारीख",
      "literalleaveCommunityName": (Object a0) => "${a0} छोड़ें?",
      "literallensNameFaceLens": (Object a0) => "${a0}, फ़ेस लेंस",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("पसंद की गई पोस्ट"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("लिंक कॉपी हुआ"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("मॉडरेटर बनाएँ"),
      "literalmuteAuthor": (Object a0) => "${a0} को म्यूट करें",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("यह थ्रेड म्यूट करें"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("शब्द या टैग म्यूट करें"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("म्यूट और ब्लॉक किए गए खाते"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "म्यूट किया गया। आपको सूचनाएँ नहीं मिलेंगी।"),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "इस डिवाइस का कोई ऐप ${a0} लिंक नहीं खोलता।",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "इस डिवाइस के किसी ब्राउज़र ने लिंक स्वीकार नहीं किया।"),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("अभी कोई DID नहीं"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("कोई ड्राफ़्ट नहीं"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("अभी कोई रुचि नहीं"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("अभी कोई लाइक नहीं"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("अभी कोई संदेश नहीं"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("कोई नया फ़ॉलोअर नहीं"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("अभी कोई पोस्ट नहीं"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("अभी कोई जवाब नहीं"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("अभी कोई रीपोस्ट नहीं"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "कोई लोकप्रिय टैग मेल नहीं खाता"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("कोई नहीं मिला"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("किसी को नहीं हटाया गया"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("यहाँ अभी कोई नहीं है"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("दिलचस्पी नहीं"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("कुछ नहीं मिला"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("अभी कुछ ट्रेंड में नहीं"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("लॉग में अभी कुछ नहीं है"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("कोई मेल नहीं"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("कुछ म्यूट नहीं"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("अभी देखने को कुछ नहीं"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("कोई अपठित नहीं"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("इसे सिर्फ़ मालिक बदल सकता है"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("जवाब खोलें"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Kyron का ईमेल खोलें"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("पासवर्ड और लॉग इन"),
      "literalpostInCommunityName": (Object a0) => "${a0} में पोस्ट करें",
      "literalpostInWidgetCommunityName": (Object a0) => "${a0} में पोस्ट करें",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "ऊपर अपने शब्दों के साथ पोस्ट करें"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("मुख्य भाषा"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("पुश सूचनाएँ"),
      "literalreading": MessageLookupByLibrary.simpleMessage("जाँच हो रही है…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("वॉइस पोस्ट रिकॉर्ड करें"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("फिर से रिकॉर्ड करें"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("मॉडरेटर से हटाएँ"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी से हटाएँ"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("सहेजे गए से हटाएँ"),
      "literalremoveLabel": (Object a0) => "${a0} हटाएँ",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0} हटाएँ",
      "literalremoveMemberDisplayname": (Object a0) => "${a0} को हटाएँ?",
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage("पोल हटाएँ"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("यह जवाब हटाएँ"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("यह बातचीत हटाएँ"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("यह पोल हटाएँ"),
      "literalreportAuthor": (Object a0) => "${a0} की रिपोर्ट करें",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("पोस्ट की रिपोर्ट करें"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("कोड फिर से भेजें"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("सहेजी गई पोस्ट"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("कुछ कहें"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "${a0} में कुछ कहें",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("खोज विफल रही"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("फिर से भेजें"),
      "literalsendAgainInCooldownS": (Object a0) => "${a0} सेकंड में फिर भेजें",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("फ़ीडबैक दें"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("लिंक भेजें"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "भेजा गया। यह रिपोर्ट #${a0} है।",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("पासवर्ड सेट करें और जारी रखें"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("लॉग सहायता के साथ साझा करें"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("यह कम्युनिटी साझा करें"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("यह पेज साझा करें"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("यह प्रोफ़ाइल साझा करें"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("साझा करें…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("कोट के साथ साझा करें"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("ऐसी और दिखाएँ"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("पासवर्ड दिखाएँ"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("नतीजे दिखाएँ"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी शुरू करें"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("रिकॉर्डिंग शुरू करें"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("लोड होना रोकें"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "यह पोस्ट और इसके जवाब देखना बंद करें"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "स्टोरी पट्टी, ${a0} आइटम",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("कैमरा बदलें"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("किसी को टैग करें"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("फ़ोटो लें"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "बदलने के लिए बैनर या फ़ोटो पर टैप करें"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("उसके अंदर के लिंक पर टैप करें"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "फ़ोटो और कवर जोड़ने के लिए टैप करें"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "यह नहीं हो सका। फिर कोशिश करें।"),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("वह GIF लोड नहीं हो सका।"),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage("यह लिंक यहाँ नहीं खुल सकता।"),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("कैमरा बंद है"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("यह कम्युनिटी"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("यह जवाब अब मौजूद नहीं है"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("पोस्ट का अनुवाद करें"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("आवाज़ बंद करें"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("आवाज़ चालू करें"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("हमारी कोई एक इस्तेमाल करें"),
      "literalverificationCodeResent":
          MessageLookupByLibrary.simpleMessage("सत्यापन कोड फिर से भेजा गया।"),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "सत्यापन विफल: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("ईमेल सत्यापित करें"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "दर्शक, लाइक, सेव और टिप्पणियाँ"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kyron क्या रखता है"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("यह ऐप क्या कर रहा था"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "आपने क्या किया, क्या उम्मीद थी, क्या हुआ "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
          "आप जो पोस्ट करते हैं वह आपका है"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("क्या Kyron अभी पहुँच में है"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("कौन जवाब दे सकता है"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("आप किसे टैग करना चाहते हैं?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "आप पहले से सभी लोकप्रिय टैग फ़ॉलो कर रहे हैं"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("आपने सब देख लिया"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "आप किसी कम्युनिटी में नहीं हैं"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("आप लॉग आउट हो गए हैं।"),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "आपने ${a0} छोड़ दी",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "आपने अभी तक कुछ पोस्ट नहीं किया"),
      "loadMore": MessageLookupByLibrary.simpleMessage("और लोड करें"),
      "logCleared": MessageLookupByLibrary.simpleMessage("लॉग साफ़ हुआ"),
      "logCopied": MessageLookupByLibrary.simpleMessage("लॉग कॉपी हुआ"),
      "logIn": MessageLookupByLibrary.simpleMessage("लॉग इन करें"),
      "logOut": MessageLookupByLibrary.simpleMessage("लॉग आउट"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("लॉग आउट करें?"),
      "login": MessageLookupByLibrary.simpleMessage("लॉग इन"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "लॉग इन नहीं हो सका। अपनी जानकारी जाँचें।"),
      "manage": MessageLookupByLibrary.simpleMessage("प्रबंधित करें"),
      "menu": MessageLookupByLibrary.simpleMessage("मेनू"),
      "message": MessageLookupByLibrary.simpleMessage("संदेश"),
      "messages": MessageLookupByLibrary.simpleMessage("संदेश"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("आपने सभी बातचीत पढ़ ली हैं।"),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "किसी की प्रोफ़ाइल खोलें और बातचीत शुरू करने के लिए संदेश पर टैप करें।"),
      "mute": MessageLookupByLibrary.simpleMessage("म्यूट करें"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("म्यूट और ब्लॉक किए गए"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("म्यूट किए गए शब्द और टैग"),
      "name": MessageLookupByLibrary.simpleMessage("नाम"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> स्क्रीन"),
      "newEmailAddress": MessageLookupByLibrary.simpleMessage("नया ईमेल पता"),
      "newPassword": MessageLookupByLibrary.simpleMessage("नया पासवर्ड"),
      "newPost": MessageLookupByLibrary.simpleMessage("नई पोस्ट"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("अभी नहीं"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "नहीं भेजा गया। फिर से कोशिश करने के लिए टैप करें"),
      "nothingMatchesQuery": (Object a0) =>
          "Kyron पर \"${a0}\" से कुछ मेल नहीं खाता",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("कॉपी करने के लिए कुछ नहीं"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "लाइक, जवाब और नए फ़ॉलोअर यहाँ आते हैं।"),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "आपको फ़ॉलो करने वाले लोग यहाँ दिखेंगे।"),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "जब कोई आपकी पोस्ट लाइक करेगा, तो यह यहाँ दिखेगा।"),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "आपकी पोस्ट के जवाब यहाँ आते हैं।"),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "जब कोई आपको रीपोस्ट करेगा, तो यह यहाँ दिखेगा।"),
      "notifications": MessageLookupByLibrary.simpleMessage("सूचनाएँ"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("ब्राउज़र में खोलें"),
      "or": MessageLookupByLibrary.simpleMessage("या"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("पेज नहीं मिला"),
      "password": MessageLookupByLibrary.simpleMessage("पासवर्ड"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("पासवर्ड बहुत छोटा है"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("अपनी रुचियाँ चुनें"),
      "post": MessageLookupByLibrary.simpleMessage("पोस्ट करें"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("पोस्ट के आँकड़े"),
      "postInCommunity": (Object a0) => "${a0} में पोस्ट करें",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("पोस्ट करें, कहें, दिखाएँ।"),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("पोस्ट का टेक्स्ट कॉपी हुआ"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("निजता नीति"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल अपडेट हुई"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("परिचय"),
      "profile_country": MessageLookupByLibrary.simpleMessage("देश"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("डिस्प्ले नाम"),
      "profile_location": MessageLookupByLibrary.simpleMessage("स्थान"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("बदलने के लिए टैप करें"),
      "profile_website": MessageLookupByLibrary.simpleMessage("वेबसाइट"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage("पुश सूचनाएँ"),
      "quote": MessageLookupByLibrary.simpleMessage("कोट करें"),
      "quotePost": MessageLookupByLibrary.simpleMessage("पोस्ट कोट करें"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("किसी इंसान से बात करें"),
      "remove": MessageLookupByLibrary.simpleMessage("हटाएँ"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("यह बातचीत हटाएँ?"),
      "removeMember": (Object a0) => "${a0} को हटाएँ?",
      "removeMessage": MessageLookupByLibrary.simpleMessage("यह संदेश हटाएँ?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("जवाब, फ़ॉलो और उल्लेख"),
      "repliesPolicy": (Object a0) => "जवाब: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("जवाब दें"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("कोई भी शामिल हो सकता है"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "कोई भी अब भी इस पोस्ट को देख, रीपोस्ट और कोट कर सकता है।"),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron पर कोई भी इस पोस्ट का जवाब दे सकता है।"),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("आपको फ़ॉलो करने वाले"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "सिर्फ़ आपको फ़ॉलो करने वाले इस पोस्ट का जवाब दे सकते हैं।"),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("जिनका आप उल्लेख करते हैं"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "इस पोस्ट में जिनका आप @उल्लेख करते हैं, सिर्फ़ वही जवाब दे सकते हैं।"),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("कोई जवाब नहीं दे सकता"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "जवाब बंद हैं। आप फिर भी खुद जवाब दे सकते हैं।"),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("कौन जवाब दे सकता है?"),
      "report": MessageLookupByLibrary.simpleMessage("रिपोर्ट करें"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "रिपोर्ट कॉपी हुई। इसे सहायता टीम के ईमेल में पेस्ट करें।"),
      "reportSent": MessageLookupByLibrary.simpleMessage("रिपोर्ट भेजी गई"),
      "repost": MessageLookupByLibrary.simpleMessage("रीपोस्ट करें"),
      "reset": MessageLookupByLibrary.simpleMessage("रीसेट करें"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("अपना पासवर्ड रीसेट करें"),
      "retry": MessageLookupByLibrary.simpleMessage("फिर कोशिश करें"),
      "save": MessageLookupByLibrary.simpleMessage("सहेजें"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("ड्राफ़्ट सहेजें"),
      "saySomething": (Object a0) => "${a0} में कुछ कहें",
      "search": MessageLookupByLibrary.simpleMessage("खोजें"),
      "searchByNameOrHandle":
          MessageLookupByLibrary.simpleMessage("नाम या हैंडल से खोजें"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी खोजें"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF खोजें"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("भाषाएँ खोजें"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("लोकप्रिय टैग खोजें"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "सुरक्षा अलर्ट और खाते में बदलाव"),
      "selectAppLanguage":
          MessageLookupByLibrary.simpleMessage("ऐप इंटरफ़ेस की भाषा चुनें।"),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "चुनें कि आपकी फ़ीड में कौन-सी भाषाएँ दिखें। कोई न चुनने पर सभी भाषाएँ दिखेंगी।"),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "फ़ीड में अनुवाद के लिए अपनी मुख्य भाषा चुनें।"),
      "send": MessageLookupByLibrary.simpleMessage("भेजें"),
      "sendConfirmation": MessageLookupByLibrary.simpleMessage("सत्यापन भेजें"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("बग रिपोर्ट भेजें"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("फ़ीडबैक भेजें"),
      "sendReport": MessageLookupByLibrary.simpleMessage("रिपोर्ट भेजें"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("सहायता को भेजें"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("सेवा की स्थिति"),
      "settings": MessageLookupByLibrary.simpleMessage("सेटिंग"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "ऐप लॉग सहायता के साथ साझा करें"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Kyron में साइन इन करें"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("इस रूप में साइन इन"),
      "signupFailed": (Object a0) => "साइन अप नहीं हो सका: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("रुकें"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron अभी शुरुआती दौर में है, और ऐसे व्यक्ति तक पहुँचने का सबसे तेज़ तरीका जो सच में इसे ठीक कर सके, टिकट खोलना है। बताइए आप क्या कर रहे थे और क्या हुआ।"),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "ऐप में अभी सहायता इनबॉक्स नहीं है, इसलिए यह स्क्रीन आपको ऐसी जगह ले जाती है जिस पर सच में नज़र रखी जाती है, न कि किसी ऐसे फ़ॉर्म पर जो कहीं नहीं जाता।"),
      "systemLog": MessageLookupByLibrary.simpleMessage("ऐप लॉग"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "बताइए क्या कमी है या क्या टूटा है"),
      "terms": MessageLookupByLibrary.simpleMessage("सेवा की शर्तों"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "टेक्स्ट, आवाज़ और वीडियो, उन्हें बनाने वाले लोग, और वे कमरे जहाँ वे बातें करते हैं।"),
      "theComposerNoPostButton":
          MessageLookupByLibrary.simpleMessage("एडिटर में पोस्ट बटन नहीं है"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("गहरी"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("हमेशा गहरी"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("मद्धम"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "नरम गहरी, काले की जगह नीला-धूसर"),
      "theme_light": MessageLookupByLibrary.simpleMessage("हल्की"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("हमेशा हल्की"),
      "theme_system": MessageLookupByLibrary.simpleMessage("सिस्टम"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "फ़ोन की हल्की या गहरी सेटिंग के अनुसार"),
      "translate": MessageLookupByLibrary.simpleMessage("अनुवाद करें"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "अनुवाद अभी चालू नहीं है। आपकी फ़ीड में अभी कुछ अनुवादित नहीं होता; तब तक यह याद रखा जाता है।"),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "यह Kyron के अपने शब्दों, इंटरफ़ेस के उन हिस्सों को जिन्हें Flutter खुद बनाता है, तारीखों और संख्याओं, और दाएँ से बाएँ लिखी जाने वाली भाषाओं के लिए ऐप के लेआउट की दिशा को बदलता है।"),
      "tryAgain": MessageLookupByLibrary.simpleMessage("फिर से कोशिश करें"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("निजता नीति"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("सेवा की शर्तें"),
      "ui_account": MessageLookupByLibrary.simpleMessage("खाता"),
      "ui_after": MessageLookupByLibrary.simpleMessage("बाद"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("ऐप और डिवाइस"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "यह उद्धरण लोगों को धोखाधड़ी से सावधान करने के लिए था।"),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "बताएं कि आपको फ़ैसला गलत क्यों लगता है: पोस्ट का मतलब क्या था, टीम से क्या छूट गया होगा, या नियम क्यों लागू नहीं होता। इसे फ़ैसला करने वाले के अलावा कोई और पढ़ता है।"),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("आपकी अपील"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "कम से कम \$count अक्षर लिखें। आप हर फ़ैसले पर एक बार अपील कर सकते हैं।"),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("अपील भेजें"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "अपील भेज दी गई। फ़ैसला होने पर आपको सूचना मिलेगी।"),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("केस \$number पर अपील"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("रूप-रंग"),
      "ui_appearance_detail":
          MessageLookupByLibrary.simpleMessage("हल्की, गहरी या फ़ोन के अनुसार"),
      "ui_before": MessageLookupByLibrary.simpleMessage("पहले"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "आप दोनों Kyron पर एक-दूसरे को नहीं देखेंगे, और आपके बीच के फ़ॉलो हटा दिए जाएँगे। उन्हें बताया नहीं जाता।"),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("इसमें है"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("यह किसलिए है (वैकल्पिक)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("केवल मॉडरेटर लिख सकते हैं"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "घोषणाओं के लिए। समुदाय में सभी अब भी पढ़ और प्रतिक्रिया दे सकते हैं।"),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("फ़ोटो या पोल जोड़ें"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("फ़ोटो और वीडियो"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("चैट बंद करें"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "इसमें कोई भी पढ़ या लिख नहीं पाएगा। इसे पूर्ववत नहीं किया जा सकता।"),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("यह चैट बंद करें?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("कॉपी किया गया"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "संदेश सभी के लिए हटा दिया जाता है। Kyron समीक्षा के लिए एक प्रति रखता है।"),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "संदेश चैट में सभी के लिए हटा दिया जाता है।"),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("चैट संपादित करें"),
      "ui_cchat_edit_message":
          MessageLookupByLibrary.simpleMessage("संपादित करें"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("संपादित"),
      "ui_cchat_editing": MessageLookupByLibrary.simpleMessage(
          "आप अपना संदेश संपादित कर रहे हैं"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("यह चैट खोली नहीं जा सकी।"),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("चैट"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("चैट से जुड़ें"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "इसकी चैट देखने और भाग लेने के लिए समुदाय से जुड़ें।"),
      "ui_cchat_joined": MessageLookupByLibrary.simpleMessage("\$count जुड़े"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("चैट छोड़ें"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "जब तक आप समुदाय में हैं, आप इसे पढ़ सकते हैं।"),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "यहाँ केवल मालिक और मॉडरेटर लिख सकते हैं।"),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("म्यूट करें"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "इससे कोई सूचना नहीं आएगी, और यह संदेशों की गिनती में शामिल नहीं होगी।"),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("चैट का नाम"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("नई चैट"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("अभी कोई चैट नहीं।"),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "अभी कोई चैट नहीं। समुदाय के लिए एक खोलें।"),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "समुदाय चैट एंड-टू-एंड एन्क्रिप्टेड नहीं हैं। समुदाय के मॉडरेटर और Kyron इन्हें पढ़ सकते हैं।"),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("सबसे ऊपर पिन करें"),
      "ui_cchat_poll_add": MessageLookupByLibrary.simpleMessage("जवाब जोड़ें"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("पोल बंद करें"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("बंद"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "सभी देखते हैं कि हर जवाब कितनों ने चुना, यह कभी नहीं कि किसने।"),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("कई जवाब चुनने दें"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("नया पोल"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("एक चुनें"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("जवाब \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("पोल: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("सवाल"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "हर जवाब पोल में सिर्फ़ एक बार हो सकता है।"),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("एक या ज़्यादा चुनें"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count ने जवाब दिया"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("इस चैट में खोजें"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("इस चैट में खोजें"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("कुछ नहीं मिला।"),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("आप अब यह चैट नहीं देख सकते।"),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("धीमा मोड"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "संदेशों के बीच कितना इंतज़ार करना है। मॉडरेटर पर लागू नहीं।"),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 घंटा"),
      "ui_cchat_slow_minutes": MessageLookupByLibrary.simpleMessage("\$n मिनट"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "धीमा मोड: हर \$seconds सेकंड में एक संदेश"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("बंद"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n सेकंड"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "आप दर्शक के रूप में पढ़ और प्रतिक्रिया दे सकते हैं। लिखने के लिए जुड़ें।"),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "वह संदेश दिखाने के लिए बहुत पुराना है।"),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "आपकी चुनी हुई कोई चीज़ भेजने के लिए बहुत बड़ी है और छोड़ दी गई।"),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("अनम्यूट करें"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("अनपिन करें"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("वॉइस नोट रिकॉर्ड करें"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("आप"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("कम्युनिटी"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("यह किसलिए है? (वैकल्पिक)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("पोस्ट:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("सामग्री और डिस्प्ले"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("आपकी फ़ीड लोड नहीं हो सकी"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "आपकी पसंद की गई पोस्ट लोड नहीं हो सकीं"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "आपकी प्रोफ़ाइल लोड नहीं हो सकी"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "आपकी सहेजी गई पोस्ट लोड नहीं हो सकीं"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("विकेंद्रीकृत ID"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("समस्या निवारण"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("ग्रुप"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("कोई ग्रुप नहीं"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "आप जिन ग्रुप में हैं और जिन कम्युनिटी चैट से जुड़ते हैं, वे यहाँ दिखते हैं।"),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "आप ज़्यादा से ज़्यादा \$count चैट पिन कर सकते हैं। पहले एक अनपिन करें।"),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("पिन किया गया"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("पसंद किए गए"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("सहेजे गए"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("यहाँ अभी कुछ नहीं"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "कुछ खातों को फ़ॉलो करें और उनकी पोस्ट यहाँ दिखेंगी।"),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "जिन्हें आप फ़ॉलो करते हैं उनसे कुछ नहीं"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "जैसे-जैसे लोग लिखेंगे, पोस्ट यहाँ दिखेंगी।"),
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("फीका हो रहा है"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("दिलचस्पी नहीं"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("ऐसी और दिखाएँ"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("हटाया गया"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("आपके फ़ीड संकेत"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "किसी पोस्ट पर ऐसी और पोस्ट दिखाएँ या इसमें दिलचस्पी नहीं पर टैप करें, और यह यहाँ दिखेगा।"),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("अभी यहाँ कुछ नहीं है"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "और दिखाएँ और दिलचस्पी नहीं आपकी फ़ीड को क्या बता रहे हैं"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "ये होम और एक्सप्लोर को आकार देते हैं, ज़्यादातर इस आधार पर कि हर पोस्ट किस बारे में थी। हर संकेत हर महीने आधा हो जाता है और छह महीने बाद गिना नहीं जाता। अभी रोकने के लिए किसी को हटाएँ।"),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "क्लिप वाली पोस्ट यहाँ दिखेंगी।"),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("अभी कोई वीडियो नहीं"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("फ़ीडबैक"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Kyron पर लोगों को खोजें"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("किसी खाते से"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("लोग जोड़ें"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("जोड़ें"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("ग्रुप का नाम जोड़ें"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("खारिज करें"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "इस ग्रुप के मैसेज किसी भी दूसरी बातचीत की तरह एंड-टू-एंड एन्क्रिप्टेड हैं।"),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor ने \$users को जोड़ा"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor ने \$users को एडमिन बनाया"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor ने ग्रुप बनाया"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor ने नए लोगों को सदस्य के रूप में जुड़ने पर रखा"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor ने नए लोगों को दर्शक के रूप में जुड़ने पर रखा"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor ने ग्रुप छोड़ा"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor ने \$users को सदस्य बनाया"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor ने \$users को मालिक बनाया"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor ने \$users को हटाया"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor ने ग्रुप का नाम बदलकर \$title किया"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor ने \$users को दर्शक बनाया"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "एक ग्रुप में ज़्यादा से ज़्यादा \$count लोग हो सकते हैं।"),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "हाथ उठा दिया। एडमिन को बता दिया गया है।"),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count लिखना चाहते हैं"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("लिखना चाहते हैं"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "बाद में जोड़े गए लोग दर्शक के रूप में जुड़ते हैं"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("ग्रुप छोड़ें"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "यह आपकी सूची से हट जाएगा और आप बाद में कही गई बातें नहीं देख पाएँगे। किसी को आपको फिर से जोड़ना होगा।"),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("यह ग्रुप छोड़ें?"),
      "ui_group_let_write": MessageLookupByLibrary.simpleMessage("लिखने दें"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("हाथ नीचे करें"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("एडमिन बनाएँ"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("मालिक बनाएँ"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("दर्शक बनाएँ"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count सदस्य"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("सदस्य"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("ग्रुप का नाम"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("पहले ग्रुप का नाम रखें।"),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("ग्रुप चैट बनाएँ"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "मालिक एक ही होता है। आप एडमिन बने रहेंगे।"),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("\$name को मालिक बनाएँ?"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("हाथ उठाएँ"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("ग्रुप से हटाएँ"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("एडमिन से हटाएँ"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("अब आप इस ग्रुप में नहीं हैं।"),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("नाम बदलें"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("एडमिन"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("सदस्य"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("दर्शक"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "दर्शक के रूप में आप यहाँ पढ़ और प्रतिक्रिया दे सकते हैं।"),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "दर्शक पढ़ सकते हैं, प्रतिक्रिया दे सकते हैं और लिखने के लिए हाथ उठा सकते हैं।"),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("सुझाए गए"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल देखें"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("आप"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("आप दर्शक हैं"),
      "ui_help": MessageLookupByLibrary.simpleMessage("सहायता"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "नोट किया गया। इससे यह चुनने में मदद मिलती है कि आपको क्या दिखाया जाए।"),
      "ui_join": MessageLookupByLibrary.simpleMessage("जुड़ें"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("जुड़े"),
      "ui_language": MessageLookupByLibrary.simpleMessage("भाषा"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("अपनी भाषा चुनें"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("कानूनी"),
      "ui_like": MessageLookupByLibrary.simpleMessage("लाइक"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("पसंद की गई पोस्ट"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "आपकी पसंद की गई पोस्ट यहाँ दिखती हैं, नई पहले।"),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("लिंक कॉपी हुआ"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "अब आप उनकी पोस्ट नहीं देखेंगे। उन्हें बताया नहीं जाता।"),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("अभी कोई लाइक नहीं"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "उन फ़िल्टर से कोई पोस्ट मेल नहीं खाती।"),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("अभी कुछ सहेजा नहीं गया"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("आपका खाता अपडेट हुआ"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "केस \$number पर आपकी अपील स्वीकार कर ली गई"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "हमने केस \$number पर आपकी अपील को फिर से देखा, और फ़ैसला बरकरार है"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "आपका खाता स्थायी रूप से प्रतिबंधित कर दिया गया है"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("केस \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("ने आपको फ़ॉलो किया"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("ने आपकी पोस्ट पसंद की"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("ने आपका ज़िक्र किया"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("अभी कोई ज़िक्र नहीं"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "जब कोई किसी पोस्ट या जवाब में आपका @हैंडल लिखेगा, तो वह यहाँ दिखेगा।"),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("पुराने"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "कम्युनिटी चैट में आपका संदेश हटा दिया गया"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "आपकी पोस्ट की हुई कोई चीज़ हटा दी गई"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("आपकी पोस्ट हटा दी गई"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("आपका जवाब हटा दिया गया"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("ने आपकी पोस्ट का जवाब दिया"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "आपने जिस चीज़ की रिपोर्ट की थी, उस पर हमने कार्रवाई की। हमें बताने के लिए धन्यवाद।"),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "आपने जिस चीज़ की रिपोर्ट की थी, उसे हमने देखा और नहीं पाया कि उसने हमारे नियम तोड़े।"),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("रिपोर्ट का कारण: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("ने आपकी पोस्ट दोबारा शेयर की"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "हमने केस \$number का फ़ैसला पलट दिया"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("आपका खाता निलंबित है"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "आपका खाता \$date तक निलंबित है"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("सभी"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("फ़ॉलो"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("पसंद"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("ज़िक्र"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("जवाब"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("इस हफ़्ते"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("आज"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("आपके खाते को चेतावनी मिली है"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("कल"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("हो गया"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("छोड़ें"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("यह पहले ही खोला जा चुका है।"),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("समय समाप्त"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("यह खोला नहीं जा सका।"),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "एक बार खुलता है, फिर Kyron से मिटा दिया जाता है।"),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("एक बार देखें"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("खोला गया"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "\$total में से \$count ने खोला"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "इसे सिर्फ़ वही लोग खोल सकते हैं जिन्हें आपने भेजा है, एक बार।"),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("एक बार देखने के लिए भेजें"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("देखने के लिए टैप करें"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("रोकें"),
      "ui_play": MessageLookupByLibrary.simpleMessage("चलाएँ"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "इसे आपकी प्रोफ़ाइल और सबकी फ़ीड से हटा दिया जाएगा। इसके जवाब भी इसके साथ चले जाएँगे।"),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("पोस्ट हटाई गई"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("पोस्ट छिपाई गई"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("पोस्ट का टेक्स्ट कॉपी हुआ"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("इस अवधि में पोस्ट किया गया"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "छिपाया गया। हम ऐसी कम दिखाएँगे।"),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("प्राथमिकताएँ"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("निजता"),
      "ui_report_add":
          MessageLookupByLibrary.simpleMessage("कुछ और जोड़ना है? (वैकल्पिक)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "टीम के फ़ैसला करने पर आपको सूचना मिलेगी, और आप इसे अपनी रिपोर्ट में देख सकते हैं।"),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "अगर आप इस व्यक्ति को भी नहीं देखना चाहते, तो उसी मेनू से उन्हें म्यूट या ब्लॉक करें।"),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "एक ही चीज़ को दो बार रिपोर्ट करने से उसका वज़न नहीं बढ़ता: हम हर व्यक्ति की एक रिपोर्ट रखते हैं।"),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "आपकी रिपोर्ट उस व्यक्ति से साझा नहीं की जाती। हम रिपोर्ट की गई चीज़ की एक कॉपी रखते हैं, ताकि हटाए जाने पर भी उसकी समीक्षा हो सके।"),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "आपकी रिपोर्ट मिल गई है और समीक्षा की कतार में है। हम उस व्यक्ति को नहीं बताते कि रिपोर्ट किसने की।"),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("अपनी रिपोर्ट देखें"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("हमें बताएं कि क्या गलत है"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("बताने के लिए धन्यवाद"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("\$name में क्या गलत है?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("इस संदेश में क्या गलत है?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("इस पोस्ट में क्या गलत है?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("इस जवाब में क्या गलत है?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("कम्युनिटी चैट का एक संदेश"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("एक पोस्ट"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("एक जवाब"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("कार्रवाई की गई"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("एक खाता"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("फ़ैसला \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("कोई नियम नहीं टूटा"),
      "ui_reports_failed":
          MessageLookupByLibrary.simpleMessage("आपकी रिपोर्ट लोड नहीं हो सकीं"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "पिछले 90 दिनों में आपने क्या रिपोर्ट किया और उसका क्या हुआ। टीम के फ़ैसला करने पर आपको सूचना मिलती है। जिसकी आप रिपोर्ट करते हैं, उसे कभी नहीं बताया जाता कि रिपोर्ट किसने की।"),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("कोई रिपोर्ट नहीं"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "जब आप किसी पोस्ट, जवाब, संदेश या खाते की रिपोर्ट करते हैं, तो वह यहाँ उसके नतीजे के साथ दिखती है।"),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("समीक्षा में"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("रिपोर्ट किया \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "आपने क्या रिपोर्ट किया और उसका क्या हुआ"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("आपकी रिपोर्ट"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("बच्चों की सुरक्षा"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "कोई भी चीज़ जो किसी नाबालिग को खतरे में डाले या उसका यौन चित्रण करे।"),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "निशाना बनाकर दुर्व्यवहार, धमकियां या अनचाहा संपर्क।"),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "लोगों पर उनकी पहचान की वजह से हमले।"),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "किसी गैरकानूनी चीज़ को बेचना या उसका प्रचार करना।"),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("किसी और होने का दिखावा करना।"),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "आपका काम या ट्रेडमार्क बिना अनुमति इस्तेमाल करता है।"),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "स्वास्थ्य, चुनाव या घटनाओं के बारे में भ्रामक दावे।"),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "खुद को नुकसान पहुंचाने को बढ़ावा देना या दिखाना।"),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "बिना चेतावनी दिखाई गई यौन सामग्री।"),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "इनमें से कोई नहीं। हमें बताएं कि क्या गलत है।"),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "बार-बार, भ्रामक या अनचाहा प्रचार।"),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "हिंसा की धमकी देना, उसका महिमामंडन करना या उसके लिए उकसाना।"),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("उत्पीड़न या धमकाना"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("नफ़रत भरी बातें"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("अवैध सामान या सेवाएँ"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("किसी और का रूप धरना"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("बौद्धिक संपदा"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("झूठी जानकारी"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("आत्महत्या या ख़ुद को नुकसान"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("वयस्क सामग्री"),
      "ui_rule_something_else": MessageLookupByLibrary.simpleMessage("कुछ और"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("स्पैम"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("हिंसा या धमकियाँ"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("सहेजी गई पोस्ट"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "किसी पोस्ट को यहाँ रखने के लिए उसके आर्काइव आइकन पर टैप करें। सहेजी गई चीज़ें सिर्फ़ आपको दिखती हैं।"),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "हैंडल या डिस्प्ले नाम से खोजें।"),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("साफ़ करें"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("पोस्ट की गई हर चीज़ में खोजें"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("फ़िल्टर"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("लोगों को खोजें"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("पोस्ट खोजें"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("सेटिंग"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("ऐप और डिवाइस"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("सामग्री और डिस्प्ले"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("डेटा सेवर"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("अपने विचार साझा करें"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("सहायता लेख देखें"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("अपनी भाषा चुनें"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "आपने किसे म्यूट या ब्लॉक किया है"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("सूचना प्राथमिकताएँ"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "आपकी प्रोफ़ाइल और संपर्क विवरण"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "अपने खाते में लौटने के लिए आपको फिर से साइन इन करना होगा।"),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("सुरक्षा सेटिंग"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("पासवर्ड की पुष्टि करें"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("एक पंक्ति में"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("नया ईमेल पता"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("नया पासवर्ड"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("क्या हुआ"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("हमारी टीम से मदद लें"),
      "ui_share": MessageLookupByLibrary.simpleMessage("साझा करें"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("उद्धृत करें"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("मैसेज में भेजें"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron पर लोगों को"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("यह पोस्ट साझा करें"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("मामला किस बारे में था"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "आपका खाता स्थायी रूप से प्रतिबंधित है"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("जवाब, \$date को:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("अपील"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("इस फ़ैसले पर अपील करें"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "इस फ़ैसले पर अब अपील नहीं की जा सकती। अगर कुछ गलत है, तो सहायता से संपर्क करें।"),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("अपील की समीक्षा हो रही है"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("अपील स्वीकार हुई"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "टीम का कोई और सदस्य इसे फिर से देख रहा है। फ़ैसला होने पर आपको सूचना मिलेगी।"),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "अगर आपको लगता है कि यह गलती थी, तो आप \$date तक दोबारा समीक्षा का अनुरोध कर सकते हैं। फ़ैसला टीम का कोई और सदस्य करता है।"),
      "ui_standing_appeal_upheld":
          MessageLookupByLibrary.simpleMessage("अपील के बाद: फ़ैसला बरकरार है"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "केस \$number। नियम: \$rule। टीम ने लिखा:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "खाता हटाने से प्रतिबंध नहीं हटता: उसी ईमेल पते वाला नया खाता भी प्रतिबंधित ही शुरू होता है।"),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("स्थायी रूप से प्रतिबंधित"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "सिर्फ़ यह पेज, अपीलें, सहायता और खाता हटाना ही काम करते हैं।"),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("अपील की जा सकती है"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("केस \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("\$date को फ़ैसला हुआ"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("आपके खाते से जुड़े फ़ैसले"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("अपना खाता हटाएं"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("विवरण देखें"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("विवरण देखें और अपील करें"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("\$date को खत्म होगा"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("आपका खाता अच्छी स्थिति में है"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("उस पर कोई पाबंदी नहीं है।"),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "खाते की स्थिति लोड नहीं हो सकी"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("संदेश हटा दिया गया"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "आपके खाते के बारे में कोई फ़ैसला नहीं हुआ है। अगर टीम कभी आपकी कोई चीज़ हटाती है या आपके खाते पर पाबंदी लगाती है, तो वह कारण के साथ यहां दिखेगा, और आप अपील कर सकेंगे।"),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "अपील के लिए कुछ नहीं: फ़ैसला पलट दिया गया।"),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("पोस्ट हटा दी गई"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "फिर से जांचने के लिए नीचे खींचें।"),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Kyron के नियम पढ़ें"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("जवाब हटा दिया गया"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("पलट दिया गया"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "\$date को पलट दिया गया। जो कुछ हटाया गया था वह वापस आ गया है, और अब कोई पाबंदी लागू नहीं है।"),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("नियम: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("साइन आउट करें"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("निलंबित"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "आप पढ़ सकते हैं, लेकिन पोस्ट, जवाब, फ़ॉलो या संदेश नहीं भेज सकते। रिपोर्ट, ब्लॉक और म्यूट अब भी काम करते हैं।"),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "आपका खाता निलंबित है: आप पढ़ सकते हैं, लेकिन पोस्ट नहीं कर सकते।"),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("\$date तक निलंबित"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "आपका खाता \$date तक निलंबित है: आप पढ़ सकते हैं, लेकिन पोस्ट नहीं कर सकते।"),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("टीम ने क्या लिखा"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("खाते की स्थिति"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("चेतावनी"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("क्यों?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("आपने \$date को लिखा:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("आपका संदेश"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("आपकी पोस्ट"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("आपका जवाब"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("सेवा की शर्तों"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("यह पोस्ट"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("थ्रेड म्यूट किया गया"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("फिर से कोशिश करें"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("आवाज़ बंद करें"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("आवाज़ चालू करें"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("कम से कम दो अक्षर।"),
      "ui_undo": MessageLookupByLibrary.simpleMessage("पूर्ववत करें"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "शब्द, या फ़िल्टर: कोई खाता, तारीख की सीमा, या पोस्ट में क्या है।"),
      "undoRepost": MessageLookupByLibrary.simpleMessage("रीपोस्ट वापस लें"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("पासवर्ड अपडेट करें"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("कोई दूसरा पता इस्तेमाल करें"),
      "username": MessageLookupByLibrary.simpleMessage("उपयोगकर्ता नाम"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "उपयोगकर्ता नाम छोटे अक्षरों में होना चाहिए (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("वीडियो"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("संलग्न करें"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("संलग्न करने के लिए तैयार"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("वॉइस पोस्ट रिकॉर्ड करें"),
      "voice_recording":
          MessageLookupByLibrary.simpleMessage("सहेजा जा रहा है…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("रोकें"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("क्या हुआ"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "क्या हुआ, और हमें क्या देखना चाहिए?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("इस तस्वीर में क्या है?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("यह किसलिए है? (वैकल्पिक)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "आपने क्या किया, क्या उम्मीद थी, क्या हुआ"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "जब यह हुआ तब आप क्या कर रहे थे।"),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("आपने जवाब दिया"),
      "dmReplied": (Object a0) => "$a0 ने जवाब दिया",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("संदेश में जोड़ें"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("नया संदेश"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "अभी तक कुछ नहीं कहा गया। हाथ हिलाना एक अच्छी शुरुआत है।"),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  हाथ हिलाएं"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("नए संदेश"),
      "dmTyping": (Object a0) => "$a0 टाइप कर रहे हैं",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("अपनी प्रतिक्रिया हटाएं"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("कोई"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("संदेश"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("अटैचमेंट"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "यह संदेश इस डिवाइस पर नहीं पढ़ा जा सकता।"),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "इस संदेश की प्रतीक्षा की जा रही है। इसमें कुछ समय लग सकता है।"),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("एन्क्रिप्ट किया गया संदेश"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "संदेश एंड-टू-एंड एन्क्रिप्टेड हैं"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("एंड-टू-एंड एन्क्रिप्टेड नहीं"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("भेजा गया"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("देखा गया"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("भेजा जा रहा है…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("फ़ोटो लें"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("अधिक विकल्प"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("डिवाइस में सहेजें"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("शेयर करें"),
      "ui_media_saving":
          MessageLookupByLibrary.simpleMessage("सहेजा जा रहा है…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("आपकी फ़ोटो में सहेजा गया"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "सहेजा नहीं जा सका। फिर से कोशिश करें।"),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "इसे सहेजने के लिए Kyron को अपनी फ़ोटो में जोड़ने दें।"),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("सभी सिस्टम चालू हैं"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("अपटाइम"),
      "ui_status_last_60": MessageLookupByLibrary.simpleMessage("पिछले 60 दिन"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 दिन पहले"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("आज"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("डेटाबेस"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("साइन-इन"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("हाल की घटनाएँ"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "पिछले 60 दिनों में कोई घटना नहीं।"),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("जारी है"),
      "ui_status_no_data":
          MessageLookupByLibrary.simpleMessage("कोई डेटा नहीं"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("विवरण"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron चलते समय हर 5 मिनट में खुद की जाँच करता है। धूसर दिन में कोई जाँच नहीं हुई।"),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "अपटाइम का इतिहास अभी उपलब्ध नहीं है।"),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("कुछ सिस्टम में समस्या है"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("वॉइस नोट रिकॉर्ड करें"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("भेजने के लिए तैयार"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("वह मैसेज अब यहां नहीं है।"),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("मैसेज पर जाएं"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("वॉइस नोट"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("लेखक को पसंद आया"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("फ़ोटो या क्लिप जोड़ें"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("मीडिया"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("वॉइस नोट"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("चैट"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("वॉलपेपर"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("सूचनाएं म्यूट करें"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "इस बातचीत की सूचनाएं पाना बंद करें"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "वे अब आपको मैसेज नहीं भेज सकते"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("कोई नहीं"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("फ़ोटो"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("अनम्यूट किया गया।"),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "हटाया नहीं जा सका। फिर से कोशिश करें।"),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("अनम्यूट करें"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "आप जो फ़ोटो और क्लिप शेयर करते हैं, वे यहां दिखते हैं।"),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("सभी देखें"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("फ़ोटो और क्लिप"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("आपकी चैट ऐसी दिखेगी।"),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("अच्छा लग रहा है।"),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("धुंध"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("सांझ"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("सेज"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("रेत"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("बिंदु"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("लागू करें"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("मौजूदा"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("प्रीव्यू के बिना भेजें"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("खोजें"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("पोस्ट करें"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("संदेश लिखें…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("भेजें"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("भेजा गया"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("भेजा गया, पर सभी को नहीं।"),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "भेजा नहीं जा सका। फिर से कोशिश करें।"),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("फ़ॉलोअर"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("फ़िल्टर"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("सभी"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("अपठित"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("बिना जवाब"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("छिपी हुई"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("कुछ भी छिपा नहीं"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "सूची से हटाई गई बातचीतें यहाँ इंतज़ार करती हैं, अगर आप उन्हें वापस चाहें।"),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "यह छिपी हुई में चली जाती है। दूसरा व्यक्ति अपनी रखता है, और आप में से कोई फिर लिखे तो यह लौट आती है।"),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("वापस लाएँ"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("फिर से आपकी सूची में।"),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("कोई बातचीत मेल नहीं खाती।"),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("आपका कोई इंतज़ार नहीं कर रहा"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "हर बातचीत आपकी बात पर ख़त्म होती है।"),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("फ़ोटो"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("फ़ोटो"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("वीडियो"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("अभी कोई संदेश नहीं"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("आप:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("कल"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("संदेश"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("संदेश सेटिंग"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("निजता"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("पढ़ने की रसीदें"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "इसे बंद रखने पर लोग नहीं देख पाएँगे कि आपने उनके संदेश कब पढ़े, और आप भी नहीं देख पाएँगे कि उन्होंने आपके कब पढ़े।"),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("लिखते समय दिखाएँ"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "जिसे आप लिख रहे हैं, उसे दिखता है कि आप लिख रहे हैं।"),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("लिंक प्रीव्यू"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "प्रीव्यू बनाने के लिए आपका फ़ोन भेजा गया लिंक खोलता है, इसलिए साइट आपके फ़ोन का अनुरोध देखती है। Kyron का सर्वर लिंक कभी नहीं देखता।"),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("संदेशों की सूचनाएँ"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "संदेश एंड-टू-एंड एन्क्रिप्टेड हैं। Kyron उन्हें नहीं पढ़ सकता, और यहाँ की कोई सेटिंग इसे नहीं बदलती।"),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("प्रति:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("हाल के"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("लोग"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("इस नाम का कोई नहीं।"),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("एक टेस्ट सूचना भेजें"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron का सर्वर अभी सूचनाएँ भेजने के लिए सेट नहीं है, इसलिए कोई सूचना नहीं आ सकती। गड़बड़ी हमारी तरफ़ है, आपके फ़ोन में नहीं।"),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "यह फ़ोन सूचनाओं के लिए रजिस्टर नहीं है। फ़ोन की सेटिंग में Kyron की सूचनाओं की अनुमति देखें, फिर दोबारा कोशिश करें।"),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "सूचना इस फ़ोन तक नहीं पहुँच सकी। एक मिनट बाद फिर कोशिश करें।"),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "भेज दी गई। कुछ ही सेकंड में पहुँच जानी चाहिए।"),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("सूचनाएँ काम कर रही हैं।"),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("अभी कोई पोस्ट नहीं"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("नया समुदाय"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("नाम"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("इसका पता नाम से बनता है।"),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("लोग इसे यहाँ पाएँगे:"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "आप इसके मालिक होंगे। बन जाने के बाद इसके पेज से चित्र, बैनर और मॉडरेटर जोड़े जा सकते हैं।"),
      "ui_community_settings_home": MessageLookupByLibrary.simpleMessage("होम"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("होम में समुदाय की पोस्ट"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "आपके समुदायों की पोस्ट होम में भी दिखती हैं। बंद होने पर वे यहीं समुदायों में रहती हैं, जहाँ हर एक दिखाता है कि नया क्या है।"),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("आपकी सूची"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("नई पोस्ट की गिनती"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "दिखाएँ कि पिछली बार खोलने के बाद से हर समुदाय में कितनी पोस्ट नई हैं।"),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("आपके चलाए समुदाय"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "जिन समुदायों को आप शुरू या मॉडरेट करते हैं, वे यहाँ दिखते हैं।"),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("मालिक"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("मॉडरेटर"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("नई पोस्ट"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("आपके चलाए"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("समुदाय सेटिंग्स"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("खोजें"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("कोई समुदाय मेल नहीं खाता।"),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("कुछ नया नहीं"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "हर समुदाय वैसा ही है जैसा आपने छोड़ा था।"),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("आप अभी कोई नहीं चलाते"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("जुड़ने को कुछ नहीं बचा"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "आप Kyron के हर समुदाय में हैं। एक और शुरू करें।"),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "कोई दूसरा शब्द आज़माएँ, या उस नाम से समुदाय शुरू करें।"),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("पोस्ट लिखें"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("सदस्य:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("पोस्ट हो गई"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("देखें"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("खोलें"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("ऑनलाइन"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("ऑनलाइन होने पर दिखाएँ"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "जिन्हें आप संदेश भेजते हैं, वे आपका Kyron खुला होने पर एक हरा बिंदु देखते हैं। इसे बंद रखने पर आप भी उनका नहीं देख पाएँगे।"),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("लोग और पोस्ट खोजें"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("जुड़ने के लिए समुदाय"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("अभी देखने को कुछ नहीं है"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "लोग जो फ़ोटो और क्लिप पोस्ट करते हैं, वे यहाँ दिखेंगी।"),
      "ui_follow": MessageLookupByLibrary.simpleMessage("फ़ॉलो करें"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("अकाउंट हटाएँ"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "इससे आपका Kyron अकाउंट हमेशा के लिए हट जाएगा। इसे वापस नहीं लाया जा सकता।"),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "आपकी प्रोफ़ाइल, पोस्ट, जवाब, लाइक और रीपोस्ट"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "आपके संदेश, दूसरों को भेजे गए संदेशों सहित, और उनमें मौजूद फ़ोटो और वॉइस नोट"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "आपके फ़ॉलोअर, जिन्हें आप फ़ॉलो करते हैं वे लोग, और आपकी सेटिंग"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "आपके शुरू किए गए समुदाय सबसे पुराने मॉडरेटर या सदस्य को सौंप दिए जाएँगे। जिसमें कोई और नहीं है, वह बंद हो जाएगा।"),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("अपना अकाउंट हटाएँ?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "आप इसमें से कुछ भी वापस नहीं पा सकेंगे।"),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("आपका अकाउंट हटा दिया गया है।"),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("हटाया गया अकाउंट"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "यह अकाउंट हटा दिया गया है, इसलिए अब यहाँ संदेश नहीं भेजे जा सकते।"),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google से साइन अप किया था? इसके बजाय «Sign in with Google» इस्तेमाल करें।"),
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("वह लेंस लोड नहीं हो सका।"),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("वीडियो रिकॉर्ड नहीं हो सका।"),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "इस वीडियो में लेंस नहीं जोड़ा जा सका, इसलिए यह वैसे ही पोस्ट होगा जैसे फ़िल्माया गया।"),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "आपकी पोस्ट में पहले से ही अधिकतम अटैचमेंट हैं।"),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("आपका लेंस जोड़ा जा रहा है…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("फ़्लैश"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("वीडियो रिकॉर्ड करें"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("फ़ोटो"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("वीडियो"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Google साइन-इन रद्द कर दिया गया।"),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("उपहार"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "अभी तक किसी ने इस पोस्ट को उपहार नहीं भेजा है।"),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("उपहार"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("उपहार"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("सिक्के"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("भेजने वाला"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("भेजने वाले"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "टेस्ट सिक्के: इन्हें अभी निकाला नहीं जा सकता।"),
      "ui_saved": MessageLookupByLibrary.simpleMessage("सहेजे गए"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("पोस्ट"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("टिप्पणियाँ"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("और जवाब देखें"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("संपादित"),
      "ui_more": MessageLookupByLibrary.simpleMessage("और"),
      "ui_following": MessageLookupByLibrary.simpleMessage("फ़ॉलो किए जा रहे"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("टॉप"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("नवीनतम"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage(
          "टिप्पणियाँ क्रमित करें: \$order"),
      "ui_notif_gift":
          MessageLookupByLibrary.simpleMessage("ने आपकी पोस्ट को उपहार भेजा"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "ने आपकी टिप्पणी को \$gift भेजा"),
      "ui_notif_gift_named":
          MessageLookupByLibrary.simpleMessage("ने आपकी पोस्ट को \$gift भेजा"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("उपहार भेजें"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("पोस्ट संपादित करें"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "आप इसे \$n मिनट और संपादित कर सकते हैं"),
      "ui_save": MessageLookupByLibrary.simpleMessage("सहेजें"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "#\$tab के तहत अभी तक कुछ पोस्ट नहीं हुआ है।"),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("एक उपहार चुनें"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("पर्याप्त सिक्के नहीं"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "टेस्ट सिक्के: इन्हें खरीदा नहीं जा सकता और इनका कोई नकद मूल्य नहीं है।"),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("\$date को फिर से भरेंगे।"),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 सिक्का"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count सिक्के"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("आपके पास \$coins हैं"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift भेजें"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift भेजा गया"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("फिर से कोशिश करें"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("पोस्ट करने के बाद 15 मिनट तक"),
      "ui_post_edited":
          MessageLookupByLibrary.simpleMessage("संपादित किया गया"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "आपकी सहेजी गई टिप्पणियाँ लोड नहीं हो सकीं"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("कोई सहेजी गई टिप्पणी नहीं"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "किसी टिप्पणी को यहाँ रखने के लिए उसके नीचे संग्रह आइकन पर टैप करें। आप जो सहेजते हैं उसे सिर्फ़ आप देख सकते हैं।"),
      "ui_replying_to": MessageLookupByLibrary.simpleMessage("\$name को जवाब"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("कॉपी करें"),
      "ui_search": MessageLookupByLibrary.simpleMessage("खोजें"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("सभी चुनें"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count उपहार"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 उपहार"),
      "ui_feed_more_failed":
          MessageLookupByLibrary.simpleMessage("और पोस्ट लोड नहीं हो सकीं।"),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("रिमाइंडर"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "कुछ समय दूर रहने के बाद क्या नया है, और आपके सिक्के कब वापस आते हैं। दिन में एक से ज़्यादा कभी नहीं।"),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("उपहार"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("1 व्यक्ति से"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count लोगों से"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("सबसे बड़ा उपहारदाता"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "उपहार भेजने वालों को लोड नहीं किया जा सका।"),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("नया क्या है"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("समझ गया"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "धन्यवाद। हम हर जवाब पढ़ते हैं।"),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("अब तक Kyron कैसा लगा?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "आपके टेस्ट का दिन \$day। एक टैप काफ़ी है।"),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "कुछ ठीक करना या जोड़ना चाहिए? (वैकल्पिक)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("भेजें"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("अभी नहीं"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Kyron छोड़ने के लिए फिर से वापस दबाएँ"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("पुष्टि करें कि यह आप हैं"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "अपना खाता हटाने के लिए अपना पासवर्ड डालें।"),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "अपना खाता हटाने के लिए Google से फिर से साइन इन करें।"),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "यह काम नहीं किया। जाँचें और फिर से कोशिश करें।"),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "यह पेज कोई दूसरा ऐप खोलना चाहता है"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "यह एक {scheme} लिंक खोलना चाहता है।"),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("बिल्ड"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "कैश की गई इमेज और फ़ाइलें: {size}"),
      "ui_about_freed": MessageLookupByLibrary.simpleMessage("{size} खाली हुआ"),
      "ui_about_measuring":
          MessageLookupByLibrary.simpleMessage("माप रहे हैं…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("साफ़ करने को कुछ नहीं"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("स्टोरेज"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("वर्शन {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("ब्लॉक किए गए"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("आपके नाम से पोस्ट हो रहा है"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "ये अटैचमेंट अपलोड नहीं हुए। फिर से कोशिश करने के लिए किसी पर टैप करें, या उसे हटा दें।"),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "आपका ईमेल नहीं बदल सका। कृपया फिर से कोशिश करें।"),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "हमारे भेजे लिंक पर जाने के बाद आपका पता बदल जाएगा।"),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "पुष्टि के लिंक के लिए {email} देखें।"),
      "ui_email_enter": MessageLookupByLibrary.simpleMessage("ईमेल पता डालें।"),
      "ui_email_invalid":
          MessageLookupByLibrary.simpleMessage("यह ईमेल पते जैसा नहीं लगता।"),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "यह पहले से ही आपका ईमेल पता है।"),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "आपने क्या किया, आपको क्या उम्मीद थी, और इसके बजाय क्या हुआ।"),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "मुझे अपनी प्रोफ़ाइल पर एक पोस्ट पिन करने दें"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "आप क्या चाहते हैं, और उससे आप क्या कर पाएँगे।"),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("क्या मदद करेगा"),
      "ui_feedback_kind_bug":
          MessageLookupByLibrary.simpleMessage("कोई समस्या"),
      "ui_feedback_kind_idea":
          MessageLookupByLibrary.simpleMessage("कोई सुझाव"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("कोई सवाल"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "इसे सिर्फ़ Kyron टीम पढ़ती है। यह आपके खाते के साथ भेजा जाता है ताकि हम ईमेल से जवाब दे सकें, और आपके ऐप के वर्शन के साथ। खाता हटाने पर यह भी हट जाता है।"),
      "ui_feedback_question_example": MessageLookupByLibrary.simpleMessage(
          "मैं किसी शब्द को म्यूट कैसे करूँ?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "आप क्या करने की कोशिश कर रहे हैं, और कहाँ अटके हैं।"),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("आपका सवाल"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Kyron से कनेक्ट नहीं हो सका। अपना कनेक्शन जाँचें और फिर से कोशिश करें। अभी कुछ लिखा नहीं गया है, इसलिए कुछ नहीं खोया।"),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("साफ़ करें"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "विफल अनुरोध और दूसरी ख़ास घटनाएँ यहाँ दिखती हैं।"),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("म्यूट किए गए"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "ऊपर कोई शब्द या टैग जोड़ें। उसे रखने वाली पोस्ट आपकी फ़ीड में नहीं आएँगी।"),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "इनमें से कुछ भी रखने वाली पोस्ट आपकी फ़ीड में नहीं आतीं। बड़े-छोटे अक्षर मायने नहीं रखते, और शब्द लंबे शब्दों के अंदर भी मेल खाता है, इसलिए “spoiler” से “spoilers” भी पकड़ में आता है।"),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("किसी को ब्लॉक नहीं किया"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "ब्लॉक करने से आप दोनों एक-दूसरे से छिप जाते हैं। किसी की प्रोफ़ाइल के मेन्यू से उसे ब्लॉक करें।"),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("किसी को म्यूट नहीं किया"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "किसी खाते को म्यूट करने से उन्हें बताए बिना उनकी पोस्ट छिप जाती हैं। प्रोफ़ाइल या पोस्ट के मेन्यू से म्यूट करें।"),
      "ui_password": MessageLookupByLibrary.simpleMessage("पासवर्ड"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("ये मेल नहीं खाते।"),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "आप इस डिवाइस पर साइन इन रहेंगे। दूसरे डिवाइस से साइन आउट हो जाएगा।"),
      "ui_password_too_short": MessageLookupByLibrary.simpleMessage(
          "कम से कम 8 वर्ण इस्तेमाल करें।"),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "आपका पासवर्ड अपडेट नहीं हो सका। कृपया फिर से कोशिश करें।"),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("पासवर्ड अपडेट हो गया।"),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID कॉपी हुआ"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "आपकी पसंद की गई पोस्ट यहाँ रखी जाती हैं, सिर्फ़ आपके लिए।"),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "आपने कोई फ़ोटो या क्लिप पोस्ट नहीं की है।"),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} ने कोई फ़ोटो या क्लिप पोस्ट नहीं की है।"),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "आप जो भी पोस्ट करेंगे, वह यहाँ दिखेगा।"),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} ने अभी तक कुछ पोस्ट नहीं किया है।"),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "आपकी प्रोफ़ाइल लोड नहीं हो सकी"),
      "ui_profile_load_failed_other":
          MessageLookupByLibrary.simpleMessage("@{handle} लोड नहीं हो सका"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("कम से कम 8 वर्ण"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("छोटा अक्षर (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("कम से कम एक अंक"),
      "ui_pw_rule_symbol": MessageLookupByLibrary.simpleMessage("चिह्न (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("बड़ा अक्षर (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "{count} हाल की एंट्री। भेजने से पहले इन्हें जानकारी › सिस्टम लॉग में देखें।"),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "इसे सिर्फ़ Kyron टीम पढ़ती है। यह आपके खाते के साथ भेजा जाता है ताकि हम आगे संपर्क कर सकें। साथ में ठीक-ठीक क्या जाता है, यह देखना हो तो पहले जानकारी › सिस्टम लॉग में लॉग पढ़ें।"),
      "ui_report_sent":
          MessageLookupByLibrary.simpleMessage("भेज दिया, धन्यवाद।"),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "भेज दिया, धन्यवाद। यह रिपोर्ट #{number} है।"),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("क्या गड़बड़ हुई?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "वर्शन, नीतियाँ, स्थिति और सिस्टम लॉग"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "स्क्रॉल करते समय वीडियो अपने-आप न चलें"),
      "ui_settings_did_help":
          MessageLookupByLibrary.simpleMessage("आपका विकेंद्रीकृत पहचानकर्ता"),
      "ui_settings_moderation": MessageLookupByLibrary.simpleMessage("मॉडरेशन"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "समीक्षा के इंतज़ार में रिपोर्ट और अपीलें"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "इन्हें रखने वाली पोस्ट को अपनी फ़ीड से दूर रखें"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("साइन इन नहीं है"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("सूचना की प्राथमिकताएँ"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("निजता और सुरक्षा"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "आपके खाते से जुड़े फ़ैसले, और अपीलें"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("टेक्स्ट का आकार बदलें"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("आपका खाता"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "AR लेंस रिकॉर्ड और प्रकाशित करने की सुविधा अभी बन रही है। आप जो भी कैप्चर करेंगे वह अभी सेव नहीं होगा, इसलिए कैमरा बंद रहता है।"),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("लेंस अभी तैयार नहीं हैं"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR लेंस"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "लाइव जाने के लिए एक मीडिया सर्वर चाहिए, जो Kyron अभी नहीं चलाता। अभी ब्रॉडकास्ट शुरू करने पर आप ऐसे कमरे में होंगे जिसमें कोई नहीं आ सकता। वॉइस पोस्ट रिकॉर्ड करना आज भी काम करता है।"),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("लाइव जाना अभी तैयार नहीं है"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("लाइव जाएँ"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "पोल को विकल्प रखने और वोट गिनने के लिए एक जगह चाहिए। वह अभी तैयार नहीं है, इसलिए आज पोस्ट किया गया पोल हर जवाब खो देगा।"),
      "ui_soon_poll_heading":
          MessageLookupByLibrary.simpleMessage("पोल अभी तैयार नहीं हैं"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("पोल"),
      "ui_soon_write_instead":
          MessageLookupByLibrary.simpleMessage("इसके बजाय टेक्स्ट पोस्ट लिखें"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("फिर से जाँचें"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("विवरण"),
      "ui_status_mirror": MessageLookupByLibrary.simpleMessage("मिरर टेबल"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron ने जवाब दिया, लेकिन कुछ ठीक नहीं है।"),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("राउंड ट्रिप"),
      "ui_support_ask": MessageLookupByLibrary.simpleMessage("सवाल पूछें"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "आपके खाते के बारे में, या कोई चीज़ कैसे काम करती है"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("ईमेल से"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "अगर Kyron क्रैश हुआ: साथ में ऐप का लॉग भेजता है"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("ऐप में"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "यहाँ से Kyron टीम को लिखें। यह हमें निजी तौर पर आपके खाते के साथ मिलता है, और हम उस पर दिए ईमेल पते पर जवाब देते हैं।"),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "कोई मेल ऐप नहीं खुला। {address} कॉपी हो गया है।"),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("निजता और आपका डेटा"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("समस्या की रिपोर्ट करें"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "कुछ टूटा है या ठीक से काम नहीं कर रहा"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "किसी पोस्ट या खाते की रिपोर्ट करने के लिए उसके मेन्यू का इस्तेमाल करें: इससे हमें ठीक-ठीक पता चलता है कि आप किसकी बात कर रहे हैं।"),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("सुरक्षा और दुरुपयोग"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron सबके लिए बंद है या सिर्फ़ आपके लिए"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("बड़ा"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("और बड़ा"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("मध्यम"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron पढ़ने लायक बात कहने की जगह है।"),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("छोटा"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("हमेशा डार्क"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("धुंधला"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "नरम डार्क, काले के बजाय नीला-धूसर"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("हमेशा लाइट"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "फ़ोन की लाइट या डार्क सेटिंग के हिसाब से"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("अनब्लॉक करें"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("अनम्यूट करें"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("आप कौन हैं"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "अपने शब्दों में, समीक्षक को क्या जानना चाहिए।"),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "मैं यहाँ और अपनी साइट पर पक्षियों के बारे में लिखता हूँ।"),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("एक और लिंक जोड़ें"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "आप {date} से फिर से अनुरोध कर सकते हैं।"),
      "ui_verify_ask":
          MessageLookupByLibrary.simpleMessage("सत्यापन का अनुरोध करें"),
      "ui_verify_before":
          MessageLookupByLibrary.simpleMessage("अनुरोध से पहले"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("क्रिएटर"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("पत्रकार"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("संगठन या ब्रांड"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("कुछ और"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("सार्वजनिक हस्ती"),
      "ui_verify_denied": MessageLookupByLibrary.simpleMessage(
          "अनुरोध {number} स्वीकार नहीं हुआ"),
      "ui_verify_done": MessageLookupByLibrary.simpleMessage("आप सत्यापित हैं"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("अपनी प्रोफ़ाइल संपादित करें"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("6 अंकों का कोड डालें"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "{seconds} सेकंड में कोड दोबारा भेजें"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("हमने इसे {email} पर भेजा है"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("सत्यापित करें"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Kyron पर सत्यापित हों"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Kyron पर"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("सत्यापित"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("हों।"),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "बैज बताता है कि Kyron टीम के किसी सदस्य ने जाँचा है कि यह खाता वही है जो होने का दावा करता है। इससे अतिरिक्त पहुँच नहीं मिलती, और यह बिकाऊ नहीं है।"),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "जब तक आपका नाम वही रहता है, बैज बना रहता है। नाम बदलने पर यह तब तक हट जाता है जब तक कोई नया नाम नहीं जाँच लेता।"),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("हम कहाँ जाँच सकते हैं"),
      "ui_verify_link_more": MessageLookupByLibrary.simpleMessage("एक और लिंक"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "कोई साइट या दूसरी प्रोफ़ाइल जो बताए कि यह Kyron खाता आपका है: उस पर अपना Kyron नाम, या अपनी प्रोफ़ाइल का लिंक डालें। Kyron कभी पहचान पत्र नहीं माँगता।"),
      "ui_verify_load_failed":
          MessageLookupByLibrary.simpleMessage("आपकी स्थिति लोड नहीं हो सकी"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "अनुरोध करने से पहले ऊपर की हर चीज़ पर टिक होना चाहिए।"),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "कम से कम {days} दिन पुराना खाता"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("एक बायो जो बताए कि आप कौन हैं"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल पर आपका नाम"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल फ़ोटो"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "पिछले {days} दिनों में आपके रिकॉर्ड पर कुछ नहीं"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "भेज दिया। कोई व्यक्ति इसे देखेगा।"),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("{date} से।"),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("अनुरोध"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "आप कौन हैं, और एक लिंक\nजो इसे साबित करे"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("बैज"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "आपके नाम के पास,\nहर जगह जहाँ वह दिखे"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("एक व्यक्ति\nजाँचता है"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "टीम का कोई सदस्य\nआपके लिंक देखता है"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("सत्यापन"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "अनुरोध {number} किसी व्यक्ति के पास है"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "{date} को {category} के रूप में भेजा गया। फ़ैसला होने पर आपको सूचना मिलेगी।"),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("अनुरोध वापस लें"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("अनुरोध वापस लिया गया।"),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "रिकॉर्डिंग पूरी नहीं हो सकी: {error}"),
      "ui_voice_limit": MessageLookupByLibrary.simpleMessage("दस मिनट तक।"),
      "ui_voice_listening":
          MessageLookupByLibrary.simpleMessage("सुन रहे हैं…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "रिकॉर्ड करने के लिए Kyron को माइक्रोफ़ोन की अनुमति चाहिए। आप इसे अपने डिवाइस की सेटिंग में दे सकते हैं।"),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "रिकॉर्डिंग शुरू नहीं हो सकी: {error}"),
    };

final messageLookup = MessageLookup();
