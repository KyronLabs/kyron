import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ml';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
          "വാക്ക്, വാചകം അല്ലെങ്കിൽ #ടാഗ്"),
      "about": MessageLookupByLibrary.simpleMessage("വിവരം"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("ഉത്തരം ചേർക്കുക"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("ഭാഷകൾ ചേർക്കുക…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("അംഗീകരിച്ച് തുടരുക"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("ഇതിനകം Kyron അക്കൗണ്ട് ഉണ്ടോ?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("കമന്റുകൾ"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "വ്യത്യസ്ത ആളുകൾ, തുറക്കലുകളല്ല"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("ഇടപഴകൽ"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("ലൈക്കുകൾ"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ കാഴ്ചക്കാരില്ല"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "ഈ പോസ്റ്റ് ഇതുവരെ ആരും തുറന്നിട്ടില്ല."),
      "analytics_posted":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ചെയ്തു"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("സേവുകൾ"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("കാഴ്ചക്കാർ"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("പ്രതിദിന കാഴ്ചക്കാർ"),
      "and": MessageLookupByLibrary.simpleMessage("ഒപ്പം"),
      "answerNumber": (Object a0) => "ഉത്തരം ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR ലെൻസ്"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("ആപ്പ് ലോഗ് അറ്റാച്ച് ചെയ്യുക"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("പോയിവരാനുള്ള സമയം"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ടോക്കൺ സ്ഥിരീകരണം"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും ശ്രമിക്കുക"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും ശ്രമിക്കുക"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "ഇപ്പോൾ പ്രക്ഷേപണം തുടങ്ങിയാൽ ആർക്കും കടക്കാനാകാത്ത മുറിയിലായിരിക്കും നിങ്ങൾ"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("കമ്മ്യൂണിറ്റി തുടങ്ങുക"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("ഇത് എന്തിനാണ്? (ഓപ്ഷണൽ)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും കടക്കാനാകില്ല."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage(
              "ഈ ലിസ്റ്റിൽ നിന്ന് വീണ്ടും കടക്കാനാകില്ല."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("അത് അടച്ചാൽ"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("ആദ്യം ചേരുക"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("ഉടൻ വരുന്നു"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage(
              "നിങ്ങളുടെ പേരിൽ പോസ്റ്റ് ചെയ്യുന്നു"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage(
              "ഈ കമ്മ്യൂണിറ്റിയിൽ പോസ്റ്റ് ചെയ്യുക"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("ഇപ്പോൾ"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും ശ്രമിക്കുക"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("വിഷയം 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾക്കായി"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("എന്തോ ഉണ്ട്."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("ഇപ്പോൾ അങ്ങോട്ട് പോകുന്നു."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", അല്ല"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("ഞാൻ നീങ്ങുന്നുണ്ടോ"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("ശബ്ദം ഓഫാക്കുക"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("ശബ്ദം ഓണാക്കുക"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾക്കായി"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ടാബുകൾ"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും ശ്രമിക്കുക"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("ചിഹ്നം (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("പ്രതിദിന കാഴ്ചക്കാർ"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("ലോഡ് ചെയ്യാനായില്ല"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ഈ പോസ്റ്റ്"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "എന്തെങ്കിലും ചേർക്കാനുണ്ടോ? (ഓപ്ഷണൽ)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ഈ പോസ്റ്റ്"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("ഒരു അക്കൗണ്ടിൽ നിന്ന്"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("ലോഗ് ഔട്ട്"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ അക്കൗണ്ട്"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് സ്ഥിരീകരിക്കുക"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("ഇപ്പോൾ വേണ്ട"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("ലോഡ് ചെയ്യുന്നു…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ചെയ്യുന്നു…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 മണിക്കൂർ മുമ്പ്"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("സ്റ്റോറി ലിങ്ക് പകർത്തുക"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ സ്റ്റോറി"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "നിങ്ങളുടെ അക്കൗണ്ട്, പോസ്റ്റുകൾ, നിങ്ങൾ ടാപ്പ് ചെയ്യുന്നവ, അതുവഴി"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("വിഷയം ചേർക്കുക"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("സ്വന്തം."),
      "authorBlocked": (Object a0) => "${a0}-നെ ബ്ലോക്ക് ചെയ്തു",
      "authorPostsHidden": (Object a0) =>
          "${a0}-ന്റെ പോസ്റ്റുകൾ നിങ്ങൾ കാണില്ല",
      "block": MessageLookupByLibrary.simpleMessage("ബ്ലോക്ക് ചെയ്യുക"),
      "blockAuthor": (Object a0) => "${a0}-നെ ബ്ലോക്ക് ചെയ്യണോ?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("ബിൽഡ് വിവരങ്ങൾ പകർത്തി"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "തുടരുന്നതിലൂടെ നിങ്ങൾ അംഗീകരിക്കുന്നു"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "തുടരുന്നതിലൂടെ, ഞങ്ങളുടെ സേവന നിബന്ധനകളും സ്വകാര്യതാ നയവും നിങ്ങൾ അംഗീകരിക്കുന്നു"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "സൈൻ അപ്പ് ചെയ്യുന്നതിലൂടെ നിങ്ങൾ അംഗീകരിക്കുന്നു"),
      "cancel": MessageLookupByLibrary.simpleMessage("റദ്ദാക്കുക"),
      "change": MessageLookupByLibrary.simpleMessage("മാറ്റുക"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("ഇമെയിൽ മാറ്റുക"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ ഇമെയിലിൽ നിന്ന് അക്കൗണ്ട് സ്ഥിരീകരിക്കുക."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Kyron ലഭ്യമാണോ എന്ന് പരിശോധിക്കുക"),
      "clear": MessageLookupByLibrary.simpleMessage("മായ്ക്കുക"),
      "close": MessageLookupByLibrary.simpleMessage("അടയ്ക്കുക"),
      "closeCommunity": (Object a0) => "${a0} അടയ്ക്കണോ?",
      "closeIt": MessageLookupByLibrary.simpleMessage("അടയ്ക്കുക"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("ഈ കമ്മ്യൂണിറ്റി അടയ്ക്കുക"),
      "communities": MessageLookupByLibrary.simpleMessage("കമ്മ്യൂണിറ്റികൾ"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "പര്യവേക്ഷണത്തിൽ ഒന്ന് കണ്ടെത്തുക, അല്ലെങ്കിൽ സ്വന്തമായി തുടങ്ങുക."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "ഒരു ചൂടൻ അഭിപ്രായം എറിയൂ (അല്ലെങ്കിൽ ഇളംചൂടുള്ളത്)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ മനസ്സിൽ എന്താണ്?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾക്ക് മാത്രം പറയാനാകുന്നത് പറയൂ…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "ഇതാണ് നിങ്ങളുടെ സൂചന: പോസ്റ്റ് ചെയ്യൂ"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "ടൈപ്പ് ചെയ്യൂ, സംസാരിക്കൂ, ഉറക്കെ ചിന്തിക്കൂ"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് സ്ഥിരീകരിക്കുക"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("സപ്പോർട്ടുമായി ബന്ധപ്പെടുക"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "പോസ്റ്റുകൾക്ക് ഇതുവരെ ഭാഷയില്ല, അതിനാൽ ഇത് ഇതുവരെ നിങ്ങളുടെ ഫീഡ് ഫിൽട്ടർ ചെയ്യുന്നില്ല. അതുവരെ നിങ്ങളുടെ തിരഞ്ഞെടുപ്പുകൾ സൂക്ഷിക്കും."),
      "continueAction": MessageLookupByLibrary.simpleMessage("തുടരുക"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("ഇമെയിൽ ഉപയോഗിച്ച് തുടരുക"),
      "copy": MessageLookupByLibrary.simpleMessage("പകർത്തുക"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("പകരം റിപ്പോർട്ട് പകർത്തുക"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google സൈൻ ഇൻ തുറക്കാനായില്ല. ${a0}",
      "couldNotSignOut": (Object a0) => "ലോഗ് ഔട്ട് പരാജയപ്പെട്ടു: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("ഫോട്ടോ എടുക്കാനായില്ല."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പ്രൊഫൈലിലും പോസ്റ്റുകൾക്ക് താഴെയും കാണിക്കും."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "“{query}” എന്നതുമായി ഒരു രാജ്യവും പൊരുത്തപ്പെടുന്നില്ല."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("രാജ്യം കാണിക്കരുത്"),
      "country_search":
          MessageLookupByLibrary.simpleMessage("രാജ്യങ്ങൾ തിരയുക"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പ്രൊഫൈലിലും പോസ്റ്റുകൾക്ക് താഴെയും കാണിക്കും. നിങ്ങൾ ആരുടെയെങ്കിലും പോസ്റ്റുകൾ കാണുമ്പോൾ, നിങ്ങളുടെ രാജ്യം അവരുടെ ഇൻസൈറ്റുകളിൽ എണ്ണപ്പെടും, അഞ്ചോ അതിലധികമോ പേരുടെ ഗ്രൂപ്പുകളിൽ മാത്രം, ഒരിക്കലും പേരിലല്ല."),
      "country_suggested": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ ഫോണിന്റെ ക്രമീകരണങ്ങളിൽ നിന്ന്"),
      "create": MessageLookupByLibrary.simpleMessage("സൃഷ്ടിക്കുക"),
      "createAccount":
          MessageLookupByLibrary.simpleMessage("അക്കൗണ്ട് സൃഷ്ടിക്കുക"),
      "createYourAccount": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് സൃഷ്ടിക്കുക"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ പ്രൊഫൈൽ സൃഷ്ടിക്കുക"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR ലെൻസ്"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("ലൈവിൽ പോകുക"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("ടെക്സ്റ്റ് പോസ്റ്റ്"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("വോയ്സ് പോസ്റ്റ്"),
      "delete": MessageLookupByLibrary.simpleMessage("ഇല്ലാതാക്കുക"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("ഈ കമന്റ് ഇല്ലാതാക്കണോ?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("ഈ പോസ്റ്റ് ഇല്ലാതാക്കണോ?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("ഈ അറ്റാച്ച്‌മെന്റ് വിവരിക്കുക"),
      "description": MessageLookupByLibrary.simpleMessage("വിവരണം"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
          "DID ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി"),
      "done": MessageLookupByLibrary.simpleMessage("പൂർത്തിയായി"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "എന്തെങ്കിലും എഴുതിയ ശേഷം എഡിറ്റർ അടയ്ക്കുക, നിങ്ങൾക്ക് ഒരു ഡ്രാഫ്റ്റ് നൽകും."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} ദിവസം മുമ്പ്"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} മണിക്കൂർ മുമ്പ്"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("ഇപ്പോൾ"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} മിനിറ്റ് മുമ്പ്"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ ഒന്നും എഴുതിയിട്ടില്ല"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("പോൾ, ഇതുവരെ ചോദ്യമില്ല"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("ഉദ്ധരണി, ഇതുവരെ ടെക്സ്റ്റില്ല"),
      "drafts": MessageLookupByLibrary.simpleMessage("ഡ്രാഫ്റ്റുകൾ"),
      "editProfile":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ എഡിറ്റ് ചെയ്യുക"),
      "email": MessageLookupByLibrary.simpleMessage("ഇമെയിൽ"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("ഇമെയിൽ അറിയിപ്പുകൾ"),
      "explore": MessageLookupByLibrary.simpleMessage("പര്യവേക്ഷണം"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "ഈ ഉപകരണത്തിൽ മുഖ ട്രാക്കിംഗ് ലഭ്യമല്ല."),
      "feedTagDetail": (Object a0) =>
          "#${a0} ഉപയോഗിച്ച് ഇതുവരെ ഒന്നും പോസ്റ്റ് ചെയ്തിട്ടില്ല.",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("{name} എന്നയാളെ പിന്തുടരുക"),
      "followers": MessageLookupByLibrary.simpleMessage("ഫോളോവേഴ്സ്"),
      "following": MessageLookupByLibrary.simpleMessage("പിന്തുടരുന്നവ"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് മറന്നോ?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("സഹായം നേടൽ"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Google ഉപയോഗിച്ച് തുടരുക"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage(
          "Google ഉപയോഗിച്ച് സൈൻ ഇൻ ചെയ്യുക"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google പൂർത്തിയായ സൈൻ ഇൻ Android-ഉം iOS-ഉം മാത്രം പ്രതികരിക്കുന്ന ലിങ്ക് വഴി Kyron-ലേക്ക് തിരികെ നൽകുന്നു, അതിനാൽ ${a0}-ൽ ബ്രൗസറിന് അത് തിരികെ നൽകാൻ ഇടമില്ല.\\n\\nGoogle വഴി നിങ്ങൾക്ക് ഇതിനകം Kyron അക്കൗണ്ട് ഉണ്ടെങ്കിൽ, അതേ വിലാസത്തിൽ ഇമെയിൽ ഉപയോഗിച്ച് തുടരുക തിരഞ്ഞെടുത്ത് പാസ്‌വേഡ് മറന്നോ ടാപ്പ് ചെയ്യുക: പാസ്‌വേഡ് സജ്ജമാക്കാനുള്ള ലിങ്ക് ലഭിക്കും.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google സൈൻ ഇന്നിന് ഫോൺ ആപ്പ് വേണം"),
      "googleSignUp": MessageLookupByLibrary.simpleMessage(
          "Google ഉപയോഗിച്ച് സൈൻ അപ്പ് ചെയ്യുക"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "ഗൈഡുകളും സാധാരണ ചോദ്യങ്ങൾക്കുള്ള ഉത്തരങ്ങളും"),
      "handle": MessageLookupByLibrary.simpleMessage("ഹാൻഡിൽ"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("സഹായവും പിന്തുണയും"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("സഹായ കേന്ദ്രം"),
      "home": MessageLookupByLibrary.simpleMessage("ഹോം"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("ഒറ്റ വരിയിൽ"),
      "ins_account":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ അക്കൗണ്ട്"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("കമ്മ്യൂണിറ്റി തുറക്കുക"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് എഴുതുക"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് കാണുക"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ എഡിറ്റ് ചെയ്യുക"),
      "ins_active": MessageLookupByLibrary.simpleMessage("അവർ എപ്പോൾ സജീവമാണ്"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ സമയമേഖലയിൽ."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("പ്രായം"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "ജന്മദിനം നൽകിയ, എത്തിയ {known} പേരിൽ നിന്ന്."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("ഓരോ ദിവസവും എത്തിയ ആളുകൾ"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("അവരുള്ള കമ്മ്യൂണിറ്റികൾ"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("രാജ്യങ്ങൾ"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "എത്തിച്ചേർന്ന, പ്രൊഫൈലിൽ രാജ്യമുള്ള {known} പേരിൽ നിന്ന്."),
      "ins_days": MessageLookupByLibrary.simpleMessage("കഴിഞ്ഞ {days} ദിവസം"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("ഇൻസൈറ്റുകൾ ലോഡ് ചെയ്യാനായില്ല"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("പിന്തുടരുന്നവർ"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "കാണിക്കാൻ മതിയായ വലിയ ഗ്രൂപ്പ് ഇനിയും ഇല്ല."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("എങ്ങനെ വളരാം"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("അവർ പിന്തുടരുന്ന വിഷയങ്ങൾ"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("ലൈക്കുകൾ"),
      "ins_new": MessageLookupByLibrary.simpleMessage("പുതിയത്"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("പുതിയ പിന്തുടരുന്നവർ"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "ഈ കാലയളവിൽ നിങ്ങളുടെ ഒരു പോസ്റ്റും ആരിലും എത്തിയില്ല."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളെ പിന്തുടരാത്തവർ"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "ആളുകൾ അവരുടെ പ്രൊഫൈലുകളിൽ തിരഞ്ഞെടുത്തവയാണ് രാജ്യങ്ങൾ. Kyron ആരുടെയും നഗരമോ ലിംഗഭേദമോ ശേഖരിക്കുന്നില്ല, അതിനാൽ അവയ്ക്കായി കാണിക്കാൻ ഒന്നുമില്ല."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("തുറക്കലുകൾ"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} എത്തി · {likes} ലൈക്ക് · {replies} മറുപടി"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("എത്തിയ ആളുകൾ"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "ഓരോ ആളെയും ഒരിക്കൽ എണ്ണുന്നു: നിങ്ങളുടെ ഒരു പോസ്റ്റ് ആദ്യമായി കാണിക്കപ്പെട്ടു അല്ലെങ്കിൽ അവർ തുറന്നു. പുതിയ പിന്തുടരുന്നവർ ഇപ്പോഴും പിന്തുടരുന്നു; പിന്തുടരൽ നിർത്തിയവരെ എണ്ണുന്നില്ല."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("മറുപടികൾ"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("റീപോസ്റ്റുകൾ"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("സേവുകൾ"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "ഈ കാലയളവിൽ {floor} പേർ നിങ്ങളുടെ പോസ്റ്റുകൾ കണ്ടാൽ നിങ്ങളുടെ പ്രേക്ഷകർ ആരെന്ന് കാണിക്കും. അതിൽ കുറവാണെങ്കിൽ അത് ഒരാളെ ചൂണ്ടിക്കാണിച്ചേക്കാം."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("ഇനിയും മതിയായ ആളുകളില്ല"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "അവരിൽ {pct}% ഇതിനകം നിങ്ങളെ പിന്തുടരുന്നു: നിങ്ങളുടെ പോസ്റ്റുകൾ കൂടുതലും പരിചയക്കാരിലെത്തുന്നു."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "അവരിൽ {pct}% ഇനിയും നിങ്ങളെ പിന്തുടരുന്നില്ല: നിങ്ങളുടെ പോസ്റ്റുകൾ കണ്ടെത്തപ്പെടുന്നു."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ {reach} പേരിലെത്തി, മുൻ കാലയളവിനേക്കാൾ {pct}% കുറവ്."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "കഴിഞ്ഞ {days} ദിവസത്തിൽ നിങ്ങൾ {reach} പേരിലെത്തി."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ {reach} പേരിലെത്തി, മുൻ കാലയളവിനോളം."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "കഴിഞ്ഞ {days} ദിവസത്തിൽ പുതിയ ആരും നിങ്ങളുടെ പോസ്റ്റുകൾ കണ്ടില്ല."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ {reach} പേരിലെത്തി, മുൻ കാലയളവിനേക്കാൾ {pct}% കൂടുതൽ."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ {reach} പേരിലെത്തി, മുൻ കാലയളവിന്റെ {times}×."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "മറ്റേതൊരു വിഷയത്തേക്കാളും കൂടുതൽ പേർ {name} പിന്തുടരുന്നു."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("പ്രേക്ഷകർ"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("അവലോകനം"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റ് കണ്ടെത്തുന്നവർ പിന്തുടരുന്നതിന് മുമ്പ് പ്രൊഫൈൽ നോക്കുന്നു. ഒരു മുഖമോ ലോഗോയോ അവിടെ ആരോ ഉണ്ടെന്ന് പറയുന്നു."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ ചിത്രം ചേർക്കുക"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "എന്തിനെക്കുറിച്ചാണ് പോസ്റ്റ് ചെയ്യുന്നതെന്ന് ഒരു വരിയിൽ പറയൂ, അപരിചിതർക്ക് നിങ്ങളെ പിന്തുടർന്നാൽ എന്ത് കിട്ടുമെന്ന് അറിയാൻ."),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("ബയോ എഴുതുക"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ {total} പോസ്റ്റുകളിൽ {without} എണ്ണത്തിന് വിഷയമില്ലായിരുന്നു. വിഷയം പോസ്റ്റിനെ ആ വിഷയത്തിന്റെ ഫീഡിലും പിന്തുടരുന്നവരുടെ മുന്നിലും എത്തിക്കുന്നു."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റുകളിൽ വിഷയങ്ങൾ ചേർക്കൂ"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} പേർ നിങ്ങളുടെ പോസ്റ്റുകൾക്ക് മറുപടി നൽകി, നിങ്ങൾ {answered} എണ്ണത്തിന് മറുപടി നൽകി. എഴുതാൻ മാത്രം അവർ ശ്രദ്ധിച്ചു: ഒരു മറുപടി വായനക്കാരനെ സ്ഥിരം സന്ദർശകനാക്കുന്നു."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("മറുപടികൾക്ക് മറുപടി നൽകൂ"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പ്രേക്ഷകർ {when} ഏറ്റവും സജീവമാണ്. അതിന് തൊട്ടുമുമ്പ് ഇടുന്ന പോസ്റ്റിന് സ്വീകരിക്കാൻ ആളുകളുണ്ടാകും."),
      "ins_tip_best_time_t": MessageLookupByLibrary.simpleMessage(
          "അവർ സജീവമാകുമ്പോൾ പോസ്റ്റ് ചെയ്യൂ"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളെ പിന്തുടരാത്ത {reached} പേർ നിങ്ങളുടെ പോസ്റ്റുകൾ കണ്ടു, {gained} പേർ പിന്തുടർന്നു. നിങ്ങളിൽ നിന്ന് എന്ത് പ്രതീക്ഷിക്കാമെന്ന് ബയോയും പുതിയ പോസ്റ്റുകളും പറയട്ടെ."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "വായനക്കാരെ പിന്തുടരുന്നവരാക്കൂ"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "ഒരു പോസ്റ്റ് നിങ്ങളുടെ മറ്റു പോസ്റ്റുകൾ സാധാരണ എത്തുന്നതിന്റെ {times}× പേരിലെത്തി. അത് എന്താണ് വ്യത്യസ്തമായി ചെയ്തതെന്ന് നോക്കി അത് കൂടുതൽ ചെയ്യൂ."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("ഫലിച്ചത് കൂടുതൽ ചെയ്യൂ"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റുകൾ കാണുന്ന പലരും {name}-ലാണ്. അവിടെ പോസ്റ്റ് ചെയ്താൽ ബാക്കിയുള്ളവരുടെ മുന്നിലും നിങ്ങൾ എത്തും."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("{name}-ൽ പോസ്റ്റ് ചെയ്യൂ"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "{days} ദിവസത്തിൽ {posts} തവണ നിങ്ങൾ പോസ്റ്റ് ചെയ്തു. ഓരോ പോസ്റ്റും കണ്ടെത്തപ്പെടാനുള്ള മറ്റൊരു അവസരമാണ്, സ്ഥിരമായ താളം പിന്തുടരുന്നവരുടെ ഫീഡിൽ നിങ്ങളെ നിലനിർത്തുന്നു."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("കൂടുതൽ തവണ പോസ്റ്റ് ചെയ്യൂ"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "കഴിഞ്ഞ {days} ദിവസത്തിൽ നിങ്ങൾ പോസ്റ്റ് ചെയ്തിട്ടില്ല. പോസ്റ്റില്ലാതെ ഒന്നും ആരിലും എത്തില്ല."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("എന്തെങ്കിലും പോസ്റ്റ് ചെയ്യൂ"),
      "ins_title": MessageLookupByLibrary.simpleMessage("ഇൻസൈറ്റുകൾ"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("മികച്ച പോസ്റ്റുകൾ"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "മുമ്പത്തെ {days} ദിവസവുമായി താരതമ്യം"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("താൽപ്പര്യം ചേർക്കുക"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("ക്രമം മാറ്റാൻ വലിച്ചിടുക"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "ബാറിൽ പരമാവധി അഞ്ച് ടാബുകൾ ഉൾക്കൊള്ളും. മറ്റൊന്ന് ചേർക്കാൻ ഒന്ന് നീക്കം ചെയ്യുക."),
      "interest_following":
          MessageLookupByLibrary.simpleMessage("പിന്തുടരുന്നവ"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("നിങ്ങൾക്കായി"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "ആളുകൾ ഹാഷ്‌ടാഗുകൾ ഉപയോഗിച്ചുതുടങ്ങുമ്പോൾ അവ ഇവിടെ കാണിക്കും."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("ഇപ്പോൾ ട്രെൻഡിംഗ്"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("വീഡിയോകൾ"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ടാബുകൾ"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
          "ഇത് നിങ്ങൾ രണ്ടുപേർക്കും അപ്രത്യക്ഷമാകും."),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
          "ഇത് ത്രെഡിൽ നിന്ന് നീക്കം ചെയ്യും."),
      "join": MessageLookupByLibrary.simpleMessage("ചേരുക"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("എഡിറ്റിംഗ് തുടരുക"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron സ്ക്രീനുകൾ നിങ്ങളുടെ ഭാഷയിലാണ്. ഏതെങ്കിലും വാക്ക് തെറ്റായി തോന്നിയാൽ, ഫീഡ്‌ബാക്ക് അയയ്ക്കുക വഴി ഞങ്ങളെ അറിയിക്കൂ."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("ഭാഷകൾ"),
      "leave": MessageLookupByLibrary.simpleMessage("വിടുക"),
      "leaveCommunity": (Object a0) => "${a0} വിടണോ?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("തിരികെ അനുവദിക്കുക"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 പേജ് തുറന്നിരിക്കുന്നു"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("ക്ലിപ്പ് ചേർക്കുക"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF ചേർക്കുക"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("ഹാഷ്‌ടാഗ് ചേർക്കുക"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("ഫോട്ടോ ചേർക്കുക"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("പോൾ ചേർക്കുക"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("വീഡിയോ ചേർക്കുക"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("താൽപ്പര്യം ചേർക്കുക"),
      "literaladdLabelAsATab": (Object a0) => "${a0} ടാബായി ചേർക്കുക",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("ആപ്പ് ഭാഷ"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("ആപ്പ് പതിപ്പ്"),
      "literalblockAuthor": (Object a0) => "${a0}-നെ ബ്ലോക്ക് ചെയ്യുക",
      "literalblockAuthor2": (Object a0) => "${a0}-നെ ബ്ലോക്ക് ചെയ്യണോ?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("ഈ അക്കൗണ്ട് ബ്ലോക്ക് ചെയ്യണോ?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("മറുപടി ഉപേക്ഷിക്കുക"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും പരിശോധിക്കുക"),
      "literalchooseFromGallery": MessageLookupByLibrary.simpleMessage(
          "ഗാലറിയിൽ നിന്ന് തിരഞ്ഞെടുക്കുക"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("കാഷെ മായ്ക്കുക"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("എല്ലാ പേജുകളും അടയ്ക്കുക"),
      "literalcloseTabLabel": (Object a0) => "${a0} അടയ്ക്കുക",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("ബ്രൗസർ അടയ്ക്കുക"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0} അടയ്ക്കണോ?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("പിന്തുണയെ ബന്ധപ്പെടുക"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("ഉള്ളടക്ക ഭാഷകൾ"),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("ലിങ്ക് പകർത്തുക"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ലിങ്ക് പകർത്തുക"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ടെക്സ്റ്റ് പകർത്തുക"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("ടെക്സ്റ്റ് പകർത്തുക"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "കമ്മ്യൂണിറ്റികൾ ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF-കൾ ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "അറിയിപ്പുകൾ ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("അംഗങ്ങളെ ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "ഈ പോസ്റ്റുകൾ ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("ഈ സംഭാഷണം ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("ഈ ലിസ്റ്റ് ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("ഈ പോസ്റ്റ് ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("ഈ മറുപടി ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "ജനപ്രിയ ടാഗുകൾ ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "നിങ്ങളുടെ കമ്മ്യൂണിറ്റികൾ ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ സന്ദേശങ്ങൾ ലോഡ് ചെയ്യാനായില്ല"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "ഈ കമ്മ്യൂണിറ്റി തുറക്കാനായില്ല"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "മറുപടി പോസ്റ്റ് ചെയ്യാനായില്ല."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("തിരയൽ പ്രവർത്തിച്ചില്ല"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "ലോഗ് ഔട്ട് പരാജയപ്പെട്ടു: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} പേജുകൾ തുറന്നിരിക്കുന്നു",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("കവർ ഫോട്ടോ"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("ഡാറ്റ സേവർ"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ഇല്ലാതാക്കുക"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("ആളുകളെ കണ്ടെത്തുക"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("മറുപടി നൽകരുത്"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("ഡ്രാഫ്റ്റ് സേവ് ചെയ്തു"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "ഇപ്പോൾ ഫീഡ്‌ബാക്ക് അയയ്ക്കാനാകില്ല"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("ടെക്സ്റ്റ് വലുപ്പം"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF-കൾ സജ്ജമാക്കിയിട്ടില്ല"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("മറ്റൊരു ആപ്പിന് നൽകുക"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് മറയ്ക്കുക"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("ഈ പോസ്റ്റ് മറയ്ക്കുക"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "ഇത് മറച്ച് ഇതുപോലുള്ളവ കുറച്ച് കാണിക്കാൻ ഞങ്ങളോട് ആവശ്യപ്പെടുന്നു"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("എങ്ങനെ പെരുമാറണം"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("എഴുത്ത് തുടരുക"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron പ്രതികരിച്ചില്ല"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} തീയതി",
      "literalleaveCommunityName": (Object a0) => "${a0} വിടണോ?",
      "literallensNameFaceLens": (Object a0) => "${a0}, മുഖ ലെൻസ്",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("ലൈക്ക് ചെയ്ത പോസ്റ്റുകൾ"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("ലിങ്ക് പകർത്തി"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("മോഡറേറ്ററാക്കുക"),
      "literalmuteAuthor": (Object a0) => "${a0}-നെ മ്യൂട്ട് ചെയ്യുക",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("ഈ ത്രെഡ് മ്യൂട്ട് ചെയ്യുക"),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
          "വാക്കുകളോ ടാഗുകളോ മ്യൂട്ട് ചെയ്യുക"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "മ്യൂട്ട് ചെയ്തതും ബ്ലോക്ക് ചെയ്തതുമായ അക്കൗണ്ടുകൾ"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "മ്യൂട്ട് ചെയ്തു. നിങ്ങൾക്ക് അറിയിപ്പുകൾ ലഭിക്കില്ല."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "ഈ ഉപകരണത്തിലെ ഒരു ആപ്പും ${a0} ലിങ്കുകൾ തുറക്കില്ല.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "ഈ ഉപകരണത്തിലെ ഒരു ബ്രൗസറും ലിങ്ക് സ്വീകരിച്ചില്ല."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ DID ഇല്ല"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("ഡ്രാഫ്റ്റുകളില്ല"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ താൽപ്പര്യങ്ങളില്ല"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ ലൈക്കുകളില്ല"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ സന്ദേശങ്ങളില്ല"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("പുതിയ ഫോളോവേഴ്സില്ല"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ പോസ്റ്റുകളില്ല"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ മറുപടികളില്ല"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ റീപോസ്റ്റുകളില്ല"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "ഒരു ജനപ്രിയ ടാഗും പൊരുത്തപ്പെടുന്നില്ല"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("ആരെയും കണ്ടെത്തിയില്ല"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("ആരെയും നീക്കം ചെയ്തിട്ടില്ല"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("ഇവിടെ ഇതുവരെ ആരുമില്ല"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("താൽപ്പര്യമില്ല"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("ഒന്നും കണ്ടെത്തിയില്ല"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ ഒന്നും ട്രെൻഡിംഗിലില്ല"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("ലോഗിൽ ഇതുവരെ ഒന്നുമില്ല"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("പൊരുത്തങ്ങളില്ല"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("മ്യൂട്ട് ചെയ്തവയില്ല"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ കാണാൻ ഒന്നുമില്ല"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("വായിക്കാത്തവയില്ല"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "ഉടമയ്ക്ക് മാത്രമേ ഇത് മാറ്റാനാകൂ"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("മറുപടി തുറക്കുക"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
          "Kyron-ൽ നിന്നുള്ള ഇമെയിൽ തുറക്കുക"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡും ലോഗ് ഇന്നും"),
      "literalpostInCommunityName": (Object a0) => "${a0}-ൽ പോസ്റ്റ് ചെയ്യുക",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "${a0}-ൽ പോസ്റ്റ് ചെയ്യുക",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "മുകളിൽ നിങ്ങളുടെ സ്വന്തം വാക്കുകളോടെ പോസ്റ്റ് ചെയ്യുക"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("പ്രധാന ഭാഷ"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("പുഷ് അറിയിപ്പുകൾ"),
      "literalreading":
          MessageLookupByLibrary.simpleMessage("പരിശോധിക്കുന്നു…"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage(
          "വോയ്സ് പോസ്റ്റ് റെക്കോർഡ് ചെയ്യുക"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും റെക്കോർഡ് ചെയ്യുക"),
      "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage(
          "മോഡറേറ്റർ സ്ഥാനത്തുനിന്ന് നീക്കുക"),
      "literalremoveFromCommunity": MessageLookupByLibrary.simpleMessage(
          "കമ്മ്യൂണിറ്റിയിൽ നിന്ന് നീക്കം ചെയ്യുക"),
      "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage(
          "സേവ് ചെയ്തവയിൽ നിന്ന് നീക്കം ചെയ്യുക"),
      "literalremoveLabel": (Object a0) => "${a0} നീക്കം ചെയ്യുക",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0} നീക്കം ചെയ്യുക",
      "literalremoveMemberDisplayname": (Object a0) =>
          "${a0}-നെ നീക്കം ചെയ്യണോ?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("പോൾ നീക്കം ചെയ്യുക"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("ഈ ഉത്തരം നീക്കം ചെയ്യുക"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("ഈ സംഭാഷണം ഇല്ലാതാക്കുക"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("ഈ പോൾ നീക്കം ചെയ്യുക"),
      "literalreportAuthor": (Object a0) => "${a0}-നെ റിപ്പോർട്ട് ചെയ്യുക",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് റിപ്പോർട്ട് ചെയ്യുക"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("കോഡ് വീണ്ടും അയയ്ക്കുക"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("സേവ് ചെയ്ത പോസ്റ്റുകൾ"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("എന്തെങ്കിലും പറയൂ"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "${a0}-ൽ എന്തെങ്കിലും പറയൂ",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("തിരയൽ പരാജയപ്പെട്ടു"),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും അയയ്ക്കുക"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "${a0} സെ. കഴിഞ്ഞ് വീണ്ടും അയയ്ക്കുക",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("ഫീഡ്‌ബാക്ക് നൽകുക"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("ലിങ്ക് അയയ്ക്കുക"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "അയച്ചു. ഇത് റിപ്പോർട്ട് #${a0} ആണ്.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് സജ്ജമാക്കി തുടരുക"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("ലോഗ് പിന്തുണയുമായി പങ്കിടുക"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("ഈ കമ്മ്യൂണിറ്റി പങ്കിടുക"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("ഈ പേജ് പങ്കിടുക"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("ഈ പ്രൊഫൈൽ പങ്കിടുക"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("പങ്കിടുക…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("ഉദ്ധരണിയോടെ പങ്കിടുക"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("ഇതുപോലുള്ളവ കൂടുതൽ കാണിക്കുക"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് കാണിക്കുക"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("ഫലങ്ങൾ കാണിക്കുക"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("കമ്മ്യൂണിറ്റി തുടങ്ങുക"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("റെക്കോർഡിംഗ് തുടങ്ങുക"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("ലോഡിംഗ് നിർത്തുക"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "ഈ പോസ്റ്റും മറുപടികളും കാണുന്നത് നിർത്തുക"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "സ്റ്റോറി നിര, ${a0} ഇനങ്ങൾ",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("ക്യാമറ മാറ്റുക"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("ആരെയെങ്കിലും ടാഗ് ചെയ്യുക"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("ഫോട്ടോ എടുക്കുക"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "മാറ്റാൻ ബാനറിലോ ഫോട്ടോയിലോ ടാപ്പ് ചെയ്യുക"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("അതിലെ ലിങ്കിൽ ടാപ്പ് ചെയ്യുക"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "ഫോട്ടോയും കവറും ചേർക്കാൻ ടാപ്പ് ചെയ്യുക"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "അത് നടന്നില്ല. വീണ്ടും ശ്രമിക്കുക."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("ആ GIF ലോഡ് ചെയ്യാനായില്ല."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "ഈ ലിങ്ക് ഇവിടെ തുറക്കാനാകില്ല."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("ക്യാമറ അടച്ചിരിക്കുന്നു"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("ഈ കമ്മ്യൂണിറ്റി"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("ഈ മറുപടി ഇപ്പോൾ ഇല്ല"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് വിവർത്തനം ചെയ്യുക"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("ശബ്ദം ഓഫാക്കുക"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("ശബ്ദം ഓണാക്കുക"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("ഞങ്ങളുടേതിൽ ഒന്ന് ഉപയോഗിക്കുക"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "സ്ഥിരീകരണ കോഡ് വീണ്ടും അയച്ചു."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "സ്ഥിരീകരണം പരാജയപ്പെട്ടു: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("ഇമെയിൽ സ്ഥിരീകരിക്കുക"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "കാഴ്ചക്കാർ, ലൈക്കുകൾ, സേവുകൾ, കമന്റുകൾ"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kyron എന്ത് സൂക്ഷിക്കുന്നു"),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
          "ഈ ആപ്പ് എന്ത് ചെയ്യുകയായിരുന്നു"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "നിങ്ങൾ എന്ത് ചെയ്തു, എന്ത് പ്രതീക്ഷിച്ചു, എന്ത് സംഭവിച്ചു "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ പോസ്റ്റ് ചെയ്യുന്നത് നിങ്ങളുടേതാണ്"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Kyron ഇപ്പോൾ ലഭ്യമാണോ"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("ആർക്കൊക്കെ മറുപടി നൽകാം"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("ആരെയാണ് ടാഗ് ചെയ്യേണ്ടത്?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "നിങ്ങൾ ഇതിനകം എല്ലാ ജനപ്രിയ ടാഗുകളും പിന്തുടരുന്നു"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ എല്ലാം കണ്ടു"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ഒരു കമ്മ്യൂണിറ്റിയിലുമില്ല"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ ലോഗ് ഔട്ട് ചെയ്തു."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "നിങ്ങൾ ${a0} വിട്ടു",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ഇതുവരെ ഒന്നും പോസ്റ്റ് ചെയ്തിട്ടില്ല"),
      "loadMore": MessageLookupByLibrary.simpleMessage("കൂടുതൽ ലോഡ് ചെയ്യുക"),
      "logCleared": MessageLookupByLibrary.simpleMessage("ലോഗ് മായ്ച്ചു"),
      "logCopied": MessageLookupByLibrary.simpleMessage("ലോഗ് പകർത്തി"),
      "logIn": MessageLookupByLibrary.simpleMessage("ലോഗ് ഇൻ"),
      "logOut": MessageLookupByLibrary.simpleMessage("ലോഗ് ഔട്ട്"),
      "logOutQuestion":
          MessageLookupByLibrary.simpleMessage("ലോഗ് ഔട്ട് ചെയ്യണോ?"),
      "login": MessageLookupByLibrary.simpleMessage("ലോഗ് ഇൻ"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "ലോഗ് ഇൻ പരാജയപ്പെട്ടു. വിവരങ്ങൾ പരിശോധിക്കുക."),
      "manage": MessageLookupByLibrary.simpleMessage("നിയന്ത്രിക്കുക"),
      "menu": MessageLookupByLibrary.simpleMessage("മെനു"),
      "message": MessageLookupByLibrary.simpleMessage("സന്ദേശം"),
      "messages": MessageLookupByLibrary.simpleMessage("സന്ദേശങ്ങൾ"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ എല്ലാ സംഭാഷണങ്ങളും വായിച്ചു."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "ആരുടെയെങ്കിലും പ്രൊഫൈൽ തുറന്ന് സംഭാഷണം തുടങ്ങാൻ സന്ദേശം ടാപ്പ് ചെയ്യുക."),
      "mute": MessageLookupByLibrary.simpleMessage("മ്യൂട്ട് ചെയ്യുക"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
          "മ്യൂട്ട് ചെയ്തതും ബ്ലോക്ക് ചെയ്തതും"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
          "മ്യൂട്ട് ചെയ്ത വാക്കുകളും ടാഗുകളും"),
      "name": MessageLookupByLibrary.simpleMessage("പേര്"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> സ്ക്രീൻ"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("പുതിയ ഇമെയിൽ വിലാസം"),
      "newPassword": MessageLookupByLibrary.simpleMessage("പുതിയ പാസ്‌വേഡ്"),
      "newPost": MessageLookupByLibrary.simpleMessage("പുതിയ പോസ്റ്റ്"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("ഇപ്പോൾ വേണ്ട"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "അയച്ചില്ല. വീണ്ടും ശ്രമിക്കാൻ ടാപ്പ് ചെയ്യുക"),
      "nothingMatchesQuery": (Object a0) =>
          "Kyron-ൽ \"${a0}\"-മായി പൊരുത്തപ്പെടുന്ന ഒന്നുമില്ല",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("പകർത്താൻ ഒന്നുമില്ല"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "ലൈക്കുകളും മറുപടികളും പുതിയ ഫോളോവേഴ്സും ഇവിടെ വരും."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളെ പിന്തുടരുന്നവർ ഇവിടെ കാണിക്കും."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "ആരെങ്കിലും നിങ്ങളുടെ പോസ്റ്റ് ലൈക്ക് ചെയ്താൽ, അത് ഇവിടെ കാണിക്കും."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റുകൾക്കുള്ള മറുപടികൾ ഇവിടെ വരും."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "ആരെങ്കിലും നിങ്ങളെ റീപോസ്റ്റ് ചെയ്താൽ, അത് ഇവിടെ കാണിക്കും."),
      "notifications": MessageLookupByLibrary.simpleMessage("അറിയിപ്പുകൾ"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("ബ്രൗസറിൽ തുറക്കുക"),
      "or": MessageLookupByLibrary.simpleMessage("അല്ലെങ്കിൽ"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("പേജ് കണ്ടെത്തിയില്ല"),
      "password": MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ്"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് വളരെ ചെറുതാണ്"),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ താൽപ്പര്യങ്ങൾ തിരഞ്ഞെടുക്കുക"),
      "post": MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ചെയ്യുക"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് സ്ഥിതിവിവരക്കണക്കുകൾ"),
      "postInCommunity": (Object a0) => "${a0}-ൽ പോസ്റ്റ് ചെയ്യുക",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
          "പോസ്റ്റ് ചെയ്യൂ, പറയൂ, കാണിക്കൂ."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ടെക്സ്റ്റ് പകർത്തി"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("സ്വകാര്യതാ നയം"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ അപ്ഡേറ്റ് ചെയ്തു"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("ബയോ"),
      "profile_country": MessageLookupByLibrary.simpleMessage("രാജ്യം"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("ഡിസ്‌പ്ലേ നാമം"),
      "profile_location": MessageLookupByLibrary.simpleMessage("സ്ഥാനം"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("മാറ്റാൻ ടാപ്പ് ചെയ്യുക"),
      "profile_website": MessageLookupByLibrary.simpleMessage("വെബ്സൈറ്റ്"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("പുഷ് അറിയിപ്പുകൾ"),
      "quote": MessageLookupByLibrary.simpleMessage("ഉദ്ധരിക്കുക"),
      "quotePost": MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ഉദ്ധരിക്കുക"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("ഒരു വ്യക്തിയെ ബന്ധപ്പെടുക"),
      "remove": MessageLookupByLibrary.simpleMessage("നീക്കം ചെയ്യുക"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("ഈ സംഭാഷണം ഇല്ലാതാക്കണോ?"),
      "removeMember": (Object a0) => "${a0}-നെ നീക്കം ചെയ്യണോ?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("ഈ സന്ദേശം ഇല്ലാതാക്കണോ?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("മറുപടികൾ, ഫോളോകൾ, പരാമർശങ്ങൾ"),
      "repliesPolicy": (Object a0) => "മറുപടികൾ: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("മറുപടി നൽകുക"),
      "reply_anyone": MessageLookupByLibrary.simpleMessage("ആർക്കും ചേരാം"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "ആർക്കും ഇപ്പോഴും ഈ പോസ്റ്റ് കാണാനും റീപോസ്റ്റ് ചെയ്യാനും ഉദ്ധരിക്കാനും കഴിയും."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-ലെ ആർക്കും ഈ പോസ്റ്റിന് മറുപടി നൽകാം."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളെ പിന്തുടരുന്നവർ"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളെ പിന്തുടരുന്നവർക്ക് മാത്രമേ ഈ പോസ്റ്റിന് മറുപടി നൽകാനാകൂ."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ പരാമർശിക്കുന്നവർ"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "ഈ പോസ്റ്റിൽ നിങ്ങൾ @പരാമർശിക്കുന്നവർക്ക് മാത്രമേ മറുപടി നൽകാനാകൂ."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("ആർക്കും മറുപടി നൽകാനാകില്ല"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "മറുപടികൾ ഓഫാണ്. നിങ്ങൾക്ക് ഇപ്പോഴും മറുപടി നൽകാം."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("ആർക്കൊക്കെ മറുപടി നൽകാം?"),
      "report": MessageLookupByLibrary.simpleMessage("റിപ്പോർട്ട് ചെയ്യുക"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "റിപ്പോർട്ട് പകർത്തി. പിന്തുണയ്ക്കുള്ള ഇമെയിലിൽ ഒട്ടിക്കുക."),
      "reportSent": MessageLookupByLibrary.simpleMessage("റിപ്പോർട്ട് അയച്ചു"),
      "repost": MessageLookupByLibrary.simpleMessage("റീപോസ്റ്റ് ചെയ്യുക"),
      "reset": MessageLookupByLibrary.simpleMessage("റീസെറ്റ് ചെയ്യുക"),
      "resetPassword": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പാസ്‌വേഡ് റീസെറ്റ് ചെയ്യുക"),
      "retry": MessageLookupByLibrary.simpleMessage("വീണ്ടും ശ്രമിക്കുക"),
      "save": MessageLookupByLibrary.simpleMessage("സേവ് ചെയ്യുക"),
      "saveDraft":
          MessageLookupByLibrary.simpleMessage("ഡ്രാഫ്റ്റ് സേവ് ചെയ്യുക"),
      "saySomething": (Object a0) => "${a0}-ൽ എന്തെങ്കിലും പറയൂ",
      "search": MessageLookupByLibrary.simpleMessage("തിരയുക"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "പേര് അല്ലെങ്കിൽ ഹാൻഡിൽ ഉപയോഗിച്ച് തിരയുക"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("കമ്മ്യൂണിറ്റികൾ തിരയുക"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF-കൾ തിരയുക"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("ഭാഷകൾ തിരയുക"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("ജനപ്രിയ ടാഗുകൾ തിരയുക"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "സുരക്ഷാ അലേർട്ടുകളും അക്കൗണ്ട് മാറ്റങ്ങളും"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "ആപ്പ് ഇന്റർഫേസിന്റെ ഭാഷ തിരഞ്ഞെടുക്കുക."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ ഫീഡുകളിൽ ഏതൊക്കെ ഭാഷകൾ കാണണമെന്ന് തിരഞ്ഞെടുക്കുക. ഒന്നും തിരഞ്ഞെടുത്തില്ലെങ്കിൽ എല്ലാ ഭാഷകളും കാണിക്കും."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "ഫീഡിലെ വിവർത്തനങ്ങൾക്കായി നിങ്ങളുടെ പ്രധാന ഭാഷ തിരഞ്ഞെടുക്കുക."),
      "send": MessageLookupByLibrary.simpleMessage("അയയ്ക്കുക"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("സ്ഥിരീകരണം അയയ്ക്കുക"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("ബഗ് റിപ്പോർട്ട് അയയ്ക്കുക"),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("ഫീഡ്‌ബാക്ക് അയയ്ക്കുക"),
      "sendReport":
          MessageLookupByLibrary.simpleMessage("റിപ്പോർട്ട് അയയ്ക്കുക"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("പിന്തുണയ്ക്ക് അയയ്ക്കുക"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("സേവന നില"),
      "settings": MessageLookupByLibrary.simpleMessage("ക്രമീകരണങ്ങൾ"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "ആപ്പ് ലോഗ് പിന്തുണയുമായി പങ്കിടുക"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Kyron-ൽ സൈൻ ഇൻ ചെയ്യുക"),
      "signedInAs":
          MessageLookupByLibrary.simpleMessage("ഇങ്ങനെ സൈൻ ഇൻ ചെയ്തു"),
      "signupFailed": (Object a0) => "സൈൻ അപ്പ് പരാജയപ്പെട്ടു: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("തുടരുക"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron തുടക്കത്തിലാണ്, ഇത് ശരിക്കും പരിഹരിക്കാനാകുന്ന ഒരാളിലേക്ക് എത്താനുള്ള വേഗമേറിയ വഴി ടിക്കറ്റ് തുറക്കലാണ്. നിങ്ങൾ എന്ത് ചെയ്യുകയായിരുന്നുവെന്നും എന്ത് സംഭവിച്ചുവെന്നും പറയൂ."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "ആപ്പിന് ഇതുവരെ പിന്തുണാ ഇൻബോക്സ് ഇല്ല, അതിനാൽ ഈ സ്ക്രീൻ എവിടെയും എത്താത്ത ഫോമിന് പകരം ശരിക്കും നിരീക്ഷിക്കുന്ന ഇടത്തേക്ക് നിങ്ങളെ നയിക്കുന്നു."),
      "systemLog": MessageLookupByLibrary.simpleMessage("ആപ്പ് ലോഗ്"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "എന്താണ് ഇല്ലാത്തതെന്നോ തകരാറിലായതെന്നോ പറയൂ"),
      "terms": MessageLookupByLibrary.simpleMessage("സേവന നിബന്ധനകൾ"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "ടെക്സ്റ്റ്, ശബ്ദം, വീഡിയോ, അവ ഉണ്ടാക്കുന്ന ആളുകൾ, അവർ സംസാരിക്കുന്ന മുറികൾ."),
      "theComposerNoPostButton":
          MessageLookupByLibrary.simpleMessage("എഡിറ്ററിൽ പോസ്റ്റ് ബട്ടൺ ഇല്ല"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("ഡാർക്ക്"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("എപ്പോഴും ഡാർക്ക്"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("മങ്ങിയ"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "മൃദുവായ ഡാർക്ക്, കറുപ്പിന് പകരം നീല കലർന്ന ചാരം"),
      "theme_light": MessageLookupByLibrary.simpleMessage("ലൈറ്റ്"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("എപ്പോഴും ലൈറ്റ്"),
      "theme_system": MessageLookupByLibrary.simpleMessage("സിസ്റ്റം"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "ഫോണിന്റെ ലൈറ്റ് അല്ലെങ്കിൽ ഡാർക്ക് ക്രമീകരണം പിന്തുടരുക"),
      "translate": MessageLookupByLibrary.simpleMessage("വിവർത്തനം ചെയ്യുക"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "വിവർത്തനം ഇതുവരെ ഓണായിട്ടില്ല. നിങ്ങളുടെ ഫീഡിൽ ഇതുവരെ ഒന്നും വിവർത്തനം ചെയ്യുന്നില്ല; അതുവരെ ഇത് ഓർമ്മിക്കും."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "ഇത് Kyron-ന്റെ സ്വന്തം വാക്കുകൾ, Flutter സ്വയം വരയ്ക്കുന്ന ഇന്റർഫേസ് ഭാഗങ്ങൾ, തീയതികളും സംഖ്യകളും, വലത്തുനിന്ന് ഇടത്തോട്ട് എഴുതുന്ന ഭാഷകൾക്കുള്ള ആപ്പ് ലേഔട്ടിന്റെ ദിശ എന്നിവ മാറ്റുന്നു."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("വീണ്ടും ശ്രമിക്കുക"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("സ്വകാര്യതാ നയം"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("സേവന നിബന്ധനകൾ"),
      "ui_account": MessageLookupByLibrary.simpleMessage("അക്കൗണ്ട്"),
      "ui_after": MessageLookupByLibrary.simpleMessage("ശേഷം"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("ആപ്പും ഉപകരണവും"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "തട്ടിപ്പിനെക്കുറിച്ച് ആളുകൾക്ക് മുന്നറിയിപ്പ് നൽകാനായിരുന്നു ഈ ഉദ്ധരണി."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "തീരുമാനം തെറ്റാണെന്ന് നിങ്ങൾ കരുതുന്നത് എന്തുകൊണ്ടെന്ന് പറയുക: പോസ്റ്റിന്റെ അർത്ഥം എന്തായിരുന്നു, ടീം എന്ത് ശ്രദ്ധിക്കാതെ പോയിരിക്കാം, അല്ലെങ്കിൽ നിയമം എന്തുകൊണ്ട് യോജിക്കുന്നില്ല. തീരുമാനമെടുത്തയാളല്ല, മറ്റൊരാളാണ് ഇത് വായിക്കുക."),
      "ui_appeal_label":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ അപ്പീൽ"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "കുറഞ്ഞത് \$count അക്ഷരങ്ങൾ എഴുതുക. ഓരോ തീരുമാനത്തിനും ഒരിക്കൽ അപ്പീൽ നൽകാം."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("അപ്പീൽ അയയ്ക്കുക"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "അപ്പീൽ അയച്ചു. തീരുമാനമായാൽ നിങ്ങൾക്ക് അറിയിപ്പ് ലഭിക്കും."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("കേസ് \$number-ലെ അപ്പീൽ"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("രൂപം"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "ലൈറ്റ്, ഡാർക്ക് അല്ലെങ്കിൽ ഫോൺ പിന്തുടരുക"),
      "ui_before": MessageLookupByLibrary.simpleMessage("മുമ്പ്"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-ൽ നിങ്ങൾ പരസ്പരം കാണില്ല, നിങ്ങൾക്കിടയിലെ ഫോളോകൾ നീക്കം ചെയ്യും. അവരെ അറിയിക്കില്ല."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("ഉൾക്കൊള്ളുന്നു"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("ഇത് എന്തിനാണ് (ഓപ്ഷണൽ)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "മോഡറേറ്റർമാർക്ക് മാത്രമേ എഴുതാനാകൂ"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "അറിയിപ്പുകൾക്കായി. കമ്മ്യൂണിറ്റിയിലെ എല്ലാവർക്കും ഇപ്പോഴും വായിക്കാനും പ്രതികരിക്കാനും കഴിയും."),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "ഫോട്ടോയോ വോട്ടെടുപ്പോ ചേർക്കുക"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("ഫോട്ടോകളും വീഡിയോകളും"),
      "ui_cchat_close":
          MessageLookupByLibrary.simpleMessage("ചാറ്റ് അടയ്ക്കുക"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "ഇതിൽ ഇനി ആർക്കും വായിക്കാനോ എഴുതാനോ കഴിയില്ല. ഇത് പഴയപടിയാക്കാനാകില്ല."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("ഈ ചാറ്റ് അടയ്ക്കണോ?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("പകർത്തി"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "സന്ദേശം എല്ലാവർക്കും നീക്കം ചെയ്യപ്പെടും. അവലോകനത്തിനായി Kyron ഒരു പകർപ്പ് സൂക്ഷിക്കുന്നു."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "സന്ദേശം ചാറ്റിലെ എല്ലാവർക്കും നീക്കം ചെയ്യപ്പെടും."),
      "ui_cchat_edit":
          MessageLookupByLibrary.simpleMessage("ചാറ്റ് എഡിറ്റ് ചെയ്യുക"),
      "ui_cchat_edit_message":
          MessageLookupByLibrary.simpleMessage("എഡിറ്റ് ചെയ്യുക"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("എഡിറ്റ് ചെയ്തു"),
      "ui_cchat_editing": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ സന്ദേശം എഡിറ്റ് ചെയ്യുകയാണ്"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("ഈ ചാറ്റ് തുറക്കാനായില്ല."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("ചാറ്റുകൾ"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("ചാറ്റിൽ ചേരുക"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "ഇതിന്റെ ചാറ്റുകൾ കാണാനും പങ്കെടുക്കാനും കമ്മ്യൂണിറ്റിയിൽ ചേരുക."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count പേർ ചേർന്നു"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("ചാറ്റ് വിടുക"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ കമ്മ്യൂണിറ്റിയിൽ ഉള്ളിടത്തോളം ഇത് വായിക്കാം."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "ഇവിടെ ഉടമയ്ക്കും മോഡറേറ്റർമാർക്കും മാത്രമേ എഴുതാനാകൂ."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("മ്യൂട്ട് ചെയ്യുക"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "ഇതിൽ നിന്ന് അറിയിപ്പുകൾ വരില്ല, സന്ദേശങ്ങളുടെ എണ്ണത്തിലും ഇത് ഉൾപ്പെടില്ല."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("ചാറ്റിന്റെ പേര്"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("പുതിയ ചാറ്റ്"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ ചാറ്റുകളില്ല."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "ഇതുവരെ ചാറ്റുകളില്ല. കമ്മ്യൂണിറ്റിക്കായി ഒന്ന് തുറക്കുക."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "കമ്മ്യൂണിറ്റി ചാറ്റുകൾ എൻഡ്-ടു-എൻഡ് എൻക്രിപ്റ്റ് ചെയ്തതല്ല. കമ്മ്യൂണിറ്റിയുടെ മോഡറേറ്റർമാർക്കും Kyron-നും അവ വായിക്കാനാകും."),
      "ui_cchat_pin":
          MessageLookupByLibrary.simpleMessage("മുകളിൽ പിൻ ചെയ്യുക"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("ഉത്തരം ചേർക്കുക"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("വോട്ടെടുപ്പ് അവസാനിപ്പിക്കുക"),
      "ui_cchat_poll_closed":
          MessageLookupByLibrary.simpleMessage("അവസാനിച്ചു"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "ഓരോ ഉത്തരവും എത്രപേർ തിരഞ്ഞെടുത്തുവെന്ന് എല്ലാവരും കാണും, ആരെന്ന് ഒരിക്കലുമില്ല."),
      "ui_cchat_poll_multiple": MessageLookupByLibrary.simpleMessage(
          "ഒന്നിലധികം തിരഞ്ഞെടുക്കാൻ അനുവദിക്കുക"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("പുതിയ വോട്ടെടുപ്പ്"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("ഒന്ന് തിരഞ്ഞെടുക്കുക"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("ഉത്തരം \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("വോട്ടെടുപ്പ്: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("ചോദ്യം"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "ഓരോ ഉത്തരവും വോട്ടെടുപ്പിൽ ഒരിക്കൽ മാത്രമേ പാടുള്ളൂ."),
      "ui_cchat_poll_several": MessageLookupByLibrary.simpleMessage(
          "ഒന്നോ അതിലധികമോ തിരഞ്ഞെടുക്കുക"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count പേർ ഉത്തരം നൽകി"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("ഈ ചാറ്റിൽ തിരയുക"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("ഈ ചാറ്റിൽ തിരയുക"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("ഒന്നും കണ്ടെത്തിയില്ല."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾക്ക് ഇനി ഈ ചാറ്റ് കാണാനാകില്ല."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("സ്ലോ മോഡ്"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "സന്ദേശങ്ങൾക്കിടയിൽ എത്ര നേരം കാത്തിരിക്കണം. മോഡറേറ്റർമാർക്ക് ബാധകമല്ല."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 മണിക്കൂർ"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n മിനിറ്റ്"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "സ്ലോ മോഡ്: ഓരോ \$seconds സെക്കൻഡിലും ഒരു സന്ദേശം"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("ഓഫ്"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n സെക്കൻഡ്"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "കാഴ്ചക്കാരനായി വായിക്കാനും പ്രതികരിക്കാനും കഴിയും. എഴുതാൻ ചേരുക."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "ആ സന്ദേശം കാണിക്കാൻ കഴിയാത്തത്ര പഴയതാണ്."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ തിരഞ്ഞെടുത്ത ഒന്ന് അയയ്ക്കാൻ കഴിയാത്തത്ര വലുതാണ്, അതിനാൽ ഒഴിവാക്കി."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("അൺമ്യൂട്ട് ചെയ്യുക"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("അൺപിൻ ചെയ്യുക"),
      "ui_cchat_voice": MessageLookupByLibrary.simpleMessage(
          "വോയ്‌സ് നോട്ട് റെക്കോർഡ് ചെയ്യുക"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("നിങ്ങൾ"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("കമ്മ്യൂണിറ്റികൾ"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("ഇത് എന്തിനാണ്? (ഓപ്ഷണൽ)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("പോസ്റ്റുകൾ:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("ഉള്ളടക്കവും ഡിസ്‌പ്ലേയും"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ ഫീഡ് ലോഡ് ചെയ്യാനായില്ല"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "ലൈക്ക് ചെയ്ത പോസ്റ്റുകൾ ലോഡ് ചെയ്യാനായില്ല"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പ്രൊഫൈൽ ലോഡ് ചെയ്യാനായില്ല"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "സേവ് ചെയ്ത പോസ്റ്റുകൾ ലോഡ് ചെയ്യാനായില്ല"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("വികേന്ദ്രീകൃത ID"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("ട്രബിൾഷൂട്ടിംഗ്"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("ഗ്രൂപ്പുകൾ"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("ഗ്രൂപ്പുകളില്ല"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുള്ള ഗ്രൂപ്പുകളും നിങ്ങൾ ചേരുന്ന കമ്മ്യൂണിറ്റി ചാറ്റുകളും ഇവിടെ കാണാം."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "പരമാവധി \$count ചാറ്റുകൾ പിൻ ചെയ്യാം. ആദ്യം ഒന്ന് അൺപിൻ ചെയ്യുക."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("പിൻ ചെയ്തു"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("ഇഷ്ടപ്പെട്ടവ"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("സംരക്ഷിച്ചവ"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("ഇവിടെ ഇതുവരെ ഒന്നുമില്ല"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "കുറച്ച് അക്കൗണ്ടുകൾ പിന്തുടരുക, അവരുടെ പോസ്റ്റുകൾ ഇവിടെ കാണിക്കും."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ പിന്തുടരുന്നവരിൽ നിന്ന് ഒന്നുമില്ല"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "ആളുകൾ എഴുതുന്നതനുസരിച്ച് പോസ്റ്റുകൾ ഇവിടെ കാണിക്കും."),
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("മങ്ങുന്നു"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("താൽപ്പര്യമില്ല"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("ഇതുപോലുള്ളവ കൂടുതൽ കാണിക്കുക"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("നീക്കം ചെയ്തു"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ഫീഡ് സിഗ്നലുകൾ"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "ഒരു പോസ്റ്റിൽ ഇതുപോലുള്ള കൂടുതൽ പോസ്റ്റുകൾ കാണിക്കുക അല്ലെങ്കിൽ ഇതിൽ താൽപ്പര്യമില്ല ടാപ്പ് ചെയ്യുക, അത് ഇവിടെ കാണാം."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("ഇവിടെ ഇതുവരെ ഒന്നുമില്ല"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "കൂടുതൽ കാണിക്കുക, താൽപ്പര്യമില്ല എന്നിവ നിങ്ങളുടെ ഫീഡുകളോട് പറയുന്നത്"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "ഇവ ഹോമും എക്സ്പ്ലോറും രൂപപ്പെടുത്തുന്നു, പ്രധാനമായും ഓരോ പോസ്റ്റും എന്തിനെക്കുറിച്ചായിരുന്നു എന്നതനുസരിച്ച്. ഓരോന്നും ഓരോ മാസവും പകുതിയാകുന്നു, ആറ് മാസത്തിന് ശേഷം കണക്കാക്കില്ല. ഇപ്പോൾ നിർത്താൻ ഒന്ന് നീക്കം ചെയ്യുക."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "ക്ലിപ്പുള്ള പോസ്റ്റുകൾ ഇവിടെ കാണിക്കും."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ വീഡിയോകളില്ല"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("ഫീഡ്‌ബാക്ക്"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Kyron-ൽ ആളുകളെ കണ്ടെത്തുക"),
      "ui_from_account":
          MessageLookupByLibrary.simpleMessage("ഒരു അക്കൗണ്ടിൽ നിന്ന്"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("ആളുകളെ ചേർക്കുക"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("ചേർക്കുക"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("ഗ്രൂപ്പിന്റെ പേര് ചേർക്കുക"),
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
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("ആദ്യം ഗ്രൂപ്പിന് പേരിടുക."),
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
      "ui_group_suggested":
          MessageLookupByLibrary.simpleMessage("നിർദ്ദേശിച്ചവ"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ കാണുക"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("നിങ്ങൾ"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ കാഴ്ചക്കാരനാണ്"),
      "ui_help": MessageLookupByLibrary.simpleMessage("സഹായം"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "രേഖപ്പെടുത്തി. നിങ്ങൾക്ക് എന്ത് കാണിക്കണമെന്ന് തിരഞ്ഞെടുക്കാൻ ഇത് സഹായിക്കും."),
      "ui_join": MessageLookupByLibrary.simpleMessage("ചേരുക"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("ചേർന്നു"),
      "ui_language": MessageLookupByLibrary.simpleMessage("ഭാഷ"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ഭാഷ തിരഞ്ഞെടുക്കുക"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("നിയമപരം"),
      "ui_like": MessageLookupByLibrary.simpleMessage("ലൈക്ക്"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("ലൈക്ക് ചെയ്ത പോസ്റ്റുകൾ"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ലൈക്ക് ചെയ്ത പോസ്റ്റുകൾ ഇവിടെ കാണിക്കും, പുതിയവ ആദ്യം."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("ലിങ്ക് പകർത്തി"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ഇനി അവരുടെ പോസ്റ്റുകൾ കാണില്ല. അവരെ അറിയിക്കില്ല."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ ലൈക്കുകളില്ല"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "ആ ഫിൽട്ടറുകളുമായി പൊരുത്തപ്പെടുന്ന പോസ്റ്റുകളില്ല."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ സേവ് ചെയ്തവയില്ല"),
      "ui_notif_account_update": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് അപ്‌ഡേറ്റ് ചെയ്തു"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "കേസ് \$number-ലെ നിങ്ങളുടെ അപ്പീൽ അംഗീകരിച്ചു"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "കേസ് \$number-ലെ നിങ്ങളുടെ അപ്പീൽ ഞങ്ങൾ വീണ്ടും പരിശോധിച്ചു, തീരുമാനം മാറ്റമില്ല"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് സ്ഥിരമായി വിലക്കി"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("കേസ് \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളെ ഫോളോ ചെയ്തു"),
      "ui_notif_liked": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റ് ലൈക്ക് ചെയ്തു"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളെ പരാമർശിച്ചു"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ പരാമർശങ്ങളില്ല"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "ആരെങ്കിലും ഒരു പോസ്റ്റിലോ മറുപടിയിലോ നിങ്ങളുടെ @ഹാൻഡിൽ എഴുതുമ്പോൾ, അത് ഇവിടെ കാണിക്കും."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("പഴയവ"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "കമ്മ്യൂണിറ്റി ചാറ്റിലെ നിങ്ങളുടെ സന്ദേശം നീക്കം ചെയ്തു"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ പോസ്റ്റ് ചെയ്ത ഒന്ന് നീക്കം ചെയ്തു"),
      "ui_notif_removed_post": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റ് നീക്കം ചെയ്തു"),
      "ui_notif_removed_reply": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ മറുപടി നീക്കം ചെയ്തു"),
      "ui_notif_replied": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റിന് മറുപടി നൽകി"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ റിപ്പോർട്ട് ചെയ്ത ഒന്നിൽ ഞങ്ങൾ നടപടിയെടുത്തു. ഞങ്ങളെ അറിയിച്ചതിന് നന്ദി."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ റിപ്പോർട്ട് ചെയ്തത് ഞങ്ങൾ പരിശോധിച്ചു; അത് ഞങ്ങളുടെ നിയമങ്ങൾ ലംഘിച്ചതായി കണ്ടില്ല."),
      "ui_notif_reported_for": MessageLookupByLibrary.simpleMessage(
          "റിപ്പോർട്ടിന്റെ കാരണം: \$reason"),
      "ui_notif_reposted": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റ് റീപോസ്റ്റ് ചെയ്തു"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "കേസ് \$number-ലെ തീരുമാനം ഞങ്ങൾ പിൻവലിച്ചു"),
      "ui_notif_suspended": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് സസ്പെൻഡ് ചെയ്തിരിക്കുന്നു"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് \$date വരെ സസ്പെൻഡ് ചെയ്തിരിക്കുന്നു"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("എല്ലാം"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("ഫോളോകൾ"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("ലൈക്കുകൾ"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("പരാമർശങ്ങൾ"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("മറുപടികൾ"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("ഈ ആഴ്ച"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("ഇന്ന്"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ടിന് ഒരു മുന്നറിയിപ്പുണ്ട്"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("ഇന്നലെ"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("പൂർത്തിയായി"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("ഒഴിവാക്കുക"),
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
      "ui_pause":
          MessageLookupByLibrary.simpleMessage("താൽക്കാലികമായി നിർത്തുക"),
      "ui_play": MessageLookupByLibrary.simpleMessage("പ്ലേ ചെയ്യുക"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "ഇത് നിങ്ങളുടെ പ്രൊഫൈലിൽ നിന്നും എല്ലാവരുടെയും ഫീഡുകളിൽ നിന്നും നീക്കം ചെയ്യും. അതിന്റെ മറുപടികളും അതിനൊപ്പം പോകും."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ഇല്ലാതാക്കി"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് മറച്ചു"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് ടെക്സ്റ്റ് പകർത്തി"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("ഇടയിൽ പോസ്റ്റ് ചെയ്തത്"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "മറച്ചു. ഇതുപോലുള്ളവ കുറച്ച് കാണിക്കും."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("മുൻഗണനകൾ"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("സ്വകാര്യത"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "എന്തെങ്കിലും ചേർക്കാനുണ്ടോ? (ഓപ്ഷണൽ)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "ടീം തീരുമാനിക്കുമ്പോൾ നിങ്ങൾക്ക് അറിയിപ്പ് ലഭിക്കും, നിങ്ങളുടെ റിപ്പോർട്ടുകളിൽ അത് പിന്തുടരാം."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "ഈ വ്യക്തിയെ ഇനി കാണാനും ആഗ്രഹിക്കുന്നില്ലെങ്കിൽ, അതേ മെനുവിൽ നിന്ന് മ്യൂട്ട് ചെയ്യുകയോ ബ്ലോക്ക് ചെയ്യുകയോ ചെയ്യാം."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "ഒരേ കാര്യം രണ്ടുതവണ റിപ്പോർട്ട് ചെയ്യുന്നത് അതിന് കൂടുതൽ പ്രാധാന്യം നൽകുന്നില്ല: ഓരോ വ്യക്തിയുടെയും ഒരു റിപ്പോർട്ട് മാത്രമേ ഞങ്ങൾ സൂക്ഷിക്കൂ."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ റിപ്പോർട്ട് ആ വ്യക്തിയുമായി പങ്കിടില്ല. നിങ്ങൾ റിപ്പോർട്ട് ചെയ്തതിന്റെ ഒരു പകർപ്പ് ഞങ്ങൾ സൂക്ഷിക്കുന്നു, അത് ഇല്ലാതാക്കിയാലും പരിശോധിക്കാൻ കഴിയും."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ റിപ്പോർട്ട് ലഭിച്ചു, അവലോകനത്തിനായി കാത്തിരിക്കുന്നു. ആരാണ് റിപ്പോർട്ട് ചെയ്തതെന്ന് ഞങ്ങൾ ആ വ്യക്തിയോട് പറയില്ല."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ റിപ്പോർട്ടുകൾ കാണുക"),
      "ui_report_tell_us": MessageLookupByLibrary.simpleMessage(
          "എന്താണ് പ്രശ്നമെന്ന് ഞങ്ങളോട് പറയുക"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("അറിയിച്ചതിന് നന്ദി"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("\$name-ന് എന്താണ് പ്രശ്നം?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "ഈ സന്ദേശത്തിന് എന്താണ് പ്രശ്നം?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("ഈ പോസ്റ്റിന് എന്താണ് പ്രശ്നം?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("ഈ മറുപടിക്ക് എന്താണ് പ്രശ്നം?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "ഒരു കമ്മ്യൂണിറ്റി ചാറ്റ് സന്ദേശം"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("ഒരു പോസ്റ്റ്"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("ഒരു മറുപടി"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("നടപടിയെടുത്തു"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("ഒരു അക്കൗണ്ട്"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("തീരുമാനം \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("നിയമലംഘനമില്ല"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ റിപ്പോർട്ടുകൾ ലോഡ് ചെയ്യാനായില്ല"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "കഴിഞ്ഞ 90 ദിവസത്തിനുള്ളിൽ നിങ്ങൾ എന്ത് റിപ്പോർട്ട് ചെയ്തു, അതിന്റെ ഫലം എന്തായി. ടീം തീരുമാനിക്കുമ്പോൾ നിങ്ങൾക്ക് അറിയിപ്പ് ലഭിക്കും. നിങ്ങൾ റിപ്പോർട്ട് ചെയ്യുന്നയാളോട് ആരാണ് റിപ്പോർട്ട് ചെയ്തതെന്ന് ഒരിക്കലും പറയില്ല."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage(
          "ഒന്നും റിപ്പോർട്ട് ചെയ്തിട്ടില്ല"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ഒരു പോസ്റ്റ്, മറുപടി, സന്ദേശം അല്ലെങ്കിൽ അക്കൗണ്ട് റിപ്പോർട്ട് ചെയ്യുമ്പോൾ, അത് ഫലത്തോടൊപ്പം ഇവിടെ കാണാം."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("പരിശോധനയിൽ"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("റിപ്പോർട്ട് ചെയ്തത് \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ റിപ്പോർട്ട് ചെയ്തതും അതിന്റെ ഫലവും"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ റിപ്പോർട്ടുകൾ"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("കുട്ടികളുടെ സുരക്ഷ"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "പ്രായപൂർത്തിയാകാത്തവരെ അപകടത്തിലാക്കുന്നതോ ലൈംഗികവൽക്കരിക്കുന്നതോ ആയ എന്തും."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "ലക്ഷ്യമിട്ടുള്ള ഉപദ്രവം, ഭീഷണികൾ അല്ലെങ്കിൽ ആവശ്യമില്ലാത്ത സമ്പർക്കം."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "ആളുകൾ ആരാണെന്നതിന്റെ പേരിലുള്ള ആക്രമണങ്ങൾ."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "നിയമവിരുദ്ധമായ എന്തെങ്കിലും വിൽക്കുകയോ പ്രചരിപ്പിക്കുകയോ ചെയ്യുന്നത്."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "മറ്റൊരാളായി ആൾമാറാട്ടം നടത്തുന്നത്."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "നിങ്ങളുടെ സൃഷ്ടിയോ ട്രേഡ്‌മാർക്കോ അനുമതിയില്ലാതെ ഉപയോഗിക്കുന്നു."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "ആരോഗ്യം, തിരഞ്ഞെടുപ്പുകൾ അല്ലെങ്കിൽ സംഭവങ്ങളെക്കുറിച്ചുള്ള തെറ്റിദ്ധരിപ്പിക്കുന്ന അവകാശവാദങ്ങൾ."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "സ്വയം ഉപദ്രവിക്കുന്നതിനെ പ്രോത്സാഹിപ്പിക്കുകയോ ചിത്രീകരിക്കുകയോ ചെയ്യുന്നത്."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "മുന്നറിയിപ്പില്ലാതെ കാണിക്കുന്ന ലൈംഗിക ഉള്ളടക്കം."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "മുകളിലുള്ളവയൊന്നുമല്ല. എന്താണ് പ്രശ്നമെന്ന് ഞങ്ങളോട് പറയുക."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "ആവർത്തിച്ചുള്ളതോ തെറ്റിദ്ധരിപ്പിക്കുന്നതോ ആവശ്യമില്ലാത്തതോ ആയ പ്രചാരണം."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "അക്രമം ഭീഷണിപ്പെടുത്തൽ, മഹത്വവൽക്കരിക്കൽ അല്ലെങ്കിൽ പ്രേരിപ്പിക്കൽ."),
      "ui_rule_harassment": MessageLookupByLibrary.simpleMessage(
          "ഉപദ്രവം അല്ലെങ്കിൽ ഭീഷണിപ്പെടുത്തൽ"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("വിദ്വേഷ പ്രസംഗം"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "നിയമവിരുദ്ധ സാധനങ്ങളോ സേവനങ്ങളോ"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("ആൾമാറാട്ടം"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("ബൗദ്ധിക സ്വത്ത്"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("തെറ്റായ വിവരം"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "ആത്മഹത്യ അല്ലെങ്കിൽ സ്വയം ദോഷം"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("മുതിർന്നവർക്കുള്ള ഉള്ളടക്കം"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("മറ്റെന്തെങ്കിലും"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("സ്പാം"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("അക്രമം അല്ലെങ്കിൽ ഭീഷണി"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("സേവ് ചെയ്ത പോസ്റ്റുകൾ"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "ഒരു പോസ്റ്റ് ഇവിടെ സൂക്ഷിക്കാൻ അതിന്റെ ആർക്കൈവ് ഐക്കൺ ടാപ്പ് ചെയ്യുക. സേവ് ചെയ്തവ നിങ്ങൾക്ക് മാത്രമേ കാണാനാകൂ."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "ഹാൻഡിൽ അല്ലെങ്കിൽ ഡിസ്‌പ്ലേ നാമം ഉപയോഗിച്ച് തിരയുക."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("മായ്ക്കുക"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "പോസ്റ്റ് ചെയ്ത എല്ലാറ്റിലും തിരയുക"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("ഫിൽട്ടറുകൾ"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("ആളുകളെ തിരയുക"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റുകൾ തിരയുക"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("ക്രമീകരണങ്ങൾ"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("ആപ്പും ഉപകരണവും"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("ഉള്ളടക്കവും ഡിസ്‌പ്ലേയും"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("ഡാറ്റ സേവർ"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ അഭിപ്രായം പങ്കിടുക"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("സഹായ ലേഖനങ്ങൾ ബ്രൗസ് ചെയ്യുക"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ഭാഷ തിരഞ്ഞെടുക്കുക"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ആരെയൊക്കെ മ്യൂട്ട് അല്ലെങ്കിൽ ബ്ലോക്ക് ചെയ്തു"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("അറിയിപ്പ് മുൻഗണനകൾ"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പ്രൊഫൈലും ബന്ധപ്പെടാനുള്ള വിവരങ്ങളും"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "നിങ്ങളുടെ അക്കൗണ്ടിലേക്ക് മടങ്ങാൻ വീണ്ടും സൈൻ ഇൻ ചെയ്യണം."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("സുരക്ഷാ ക്രമീകരണങ്ങൾ"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് സ്ഥിരീകരിക്കുക"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("ഒറ്റ വരിയിൽ"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("പുതിയ ഇമെയിൽ വിലാസം"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("പുതിയ പാസ്‌വേഡ്"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("എന്ത് സംഭവിച്ചു"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "ഞങ്ങളുടെ ടീമിൽ നിന്ന് സഹായം നേടുക"),
      "ui_share": MessageLookupByLibrary.simpleMessage("പങ്കിടുക"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("ഉദ്ധരിക്കുക"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("സന്ദേശത്തിൽ അയയ്ക്കുക"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron-ലെ ആളുകൾക്ക്"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("ഈ പോസ്റ്റ് പങ്കിടുക"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("എന്തിനെക്കുറിച്ചായിരുന്നു"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് സ്ഥിരമായി വിലക്കിയിരിക്കുന്നു"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("മറുപടി, \$date-ന്:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("അപ്പീൽ"),
      "ui_standing_appeal_button": MessageLookupByLibrary.simpleMessage(
          "ഈ തീരുമാനത്തിനെതിരെ അപ്പീൽ നൽകുക"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "ഈ തീരുമാനത്തിനെതിരെ ഇനി അപ്പീൽ നൽകാനാവില്ല. എന്തെങ്കിലും തെറ്റുണ്ടെങ്കിൽ, സപ്പോർട്ടുമായി ബന്ധപ്പെടുക."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("അപ്പീൽ പരിശോധനയിലാണ്"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("അപ്പീൽ അംഗീകരിച്ചു"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "ടീമിലെ മറ്റൊരാൾ ഇത് വീണ്ടും പരിശോധിക്കുന്നു. തീരുമാനമായാൽ നിങ്ങൾക്ക് അറിയിപ്പ് ലഭിക്കും."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "ഇത് പിശകാണെന്ന് തോന്നുന്നുവെങ്കിൽ, \$date വരെ പുനഃപരിശോധന അഭ്യർത്ഥിക്കാം. ടീമിലെ മറ്റൊരാളാണ് തീരുമാനിക്കുക."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "അപ്പീലിന് ശേഷം: തീരുമാനം നിലനിൽക്കുന്നു"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "കേസ് \$number. നിയമം: \$rule. ടീം എഴുതിയത്:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "അക്കൗണ്ട് ഇല്ലാതാക്കിയാൽ വിലക്ക് നീങ്ങില്ല: അതേ ഇമെയിൽ വിലാസമുള്ള പുതിയ അക്കൗണ്ടും വിലക്കോടെയാണ് ആരംഭിക്കുക."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("സ്ഥിരമായ വിലക്ക്"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "ഈ പേജ്, അപ്പീലുകൾ, സപ്പോർട്ട്, അക്കൗണ്ട് ഇല്ലാതാക്കൽ എന്നിവ മാത്രമേ ഇപ്പോഴും പ്രവർത്തിക്കൂ."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("അപ്പീൽ നൽകാം"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("കേസ് \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("\$date-ന് തീരുമാനിച്ചു"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ടിനെക്കുറിച്ചുള്ള തീരുമാനങ്ങൾ"),
      "ui_standing_delete_account": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് ഇല്ലാതാക്കുക"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("വിശദാംശങ്ങൾ കാണുക"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "വിശദാംശങ്ങൾ കണ്ട് അപ്പീൽ നൽകുക"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("\$date-ന് അവസാനിക്കും"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് നല്ല നിലയിലാണ്"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("ഒരു നിയന്ത്രണവുമില്ല."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "അക്കൗണ്ട് നില ലോഡ് ചെയ്യാനായില്ല"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("സന്ദേശം നീക്കം ചെയ്തു"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ടിനെക്കുറിച്ച് ഒരു തീരുമാനവും എടുത്തിട്ടില്ല. ടീം എപ്പോഴെങ്കിലും നിങ്ങളുടെ എന്തെങ്കിലും നീക്കം ചെയ്യുകയോ അക്കൗണ്ട് നിയന്ത്രിക്കുകയോ ചെയ്താൽ, അത് കാരണം സഹിതം ഇവിടെ കാണിക്കും, നിങ്ങൾക്ക് അപ്പീൽ നൽകാം."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "അപ്പീൽ നൽകാൻ ഒന്നുമില്ല: തീരുമാനം റദ്ദാക്കി."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് നീക്കം ചെയ്തു"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "വീണ്ടും പരിശോധിക്കാൻ താഴേക്ക് വലിക്കുക."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Kyron നിയമങ്ങൾ വായിക്കുക"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("മറുപടി നീക്കം ചെയ്തു"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("റദ്ദാക്കി"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "\$date-ന് റദ്ദാക്കി. നീക്കം ചെയ്തതെല്ലാം തിരികെ വന്നു, ഇനി ഒരു നിയന്ത്രണവും ബാധകമല്ല."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("നിയമം: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("സൈൻ ഔട്ട്"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("സസ്പെൻഡ് ചെയ്തു"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾക്ക് വായിക്കാം, പക്ഷേ പോസ്റ്റ് ചെയ്യാനോ മറുപടി നൽകാനോ ഫോളോ ചെയ്യാനോ സന്ദേശം അയയ്ക്കാനോ കഴിയില്ല. റിപ്പോർട്ട്, ബ്ലോക്ക്, മ്യൂട്ട് എന്നിവ ഇപ്പോഴും പ്രവർത്തിക്കും."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് സസ്പെൻഡ് ചെയ്തിരിക്കുന്നു: നിങ്ങൾക്ക് വായിക്കാം, പക്ഷേ പോസ്റ്റ് ചെയ്യാനാവില്ല."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("\$date വരെ സസ്പെൻഡ് ചെയ്തു"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ട് \$date വരെ സസ്പെൻഡ് ചെയ്തിരിക്കുന്നു: നിങ്ങൾക്ക് വായിക്കാം, പക്ഷേ പോസ്റ്റ് ചെയ്യാനാവില്ല."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("ടീം എഴുതിയത്"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("അക്കൗണ്ട് നില"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("മുന്നറിയിപ്പ്"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("എന്തുകൊണ്ട്?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ \$date-ന് എഴുതിയത്:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ സന്ദേശം"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ പോസ്റ്റ്"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ മറുപടി"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("സേവന നിബന്ധനകൾ"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ഈ പോസ്റ്റ്"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("ത്രെഡ് മ്യൂട്ട് ചെയ്തു"),
      "ui_try_again":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും ശ്രമിക്കുക"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("ശബ്ദം ഓഫാക്കുക"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("ശബ്ദം ഓണാക്കുക"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("കുറഞ്ഞത് രണ്ട് പ്രതീകങ്ങൾ."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("പഴയപടിയാക്കുക"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "വാക്കുകൾ, അല്ലെങ്കിൽ ഫിൽട്ടർ: ഒരു അക്കൗണ്ട്, തീയതി പരിധി, അല്ലെങ്കിൽ പോസ്റ്റിലുള്ളത്."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("റീപോസ്റ്റ് പിൻവലിക്കുക"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് അപ്ഡേറ്റ് ചെയ്യുക"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("മറ്റൊരു വിലാസം ഉപയോഗിക്കുക"),
      "username": MessageLookupByLibrary.simpleMessage("ഉപയോക്തൃനാമം"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "ഉപയോക്തൃനാമം ചെറിയക്ഷരങ്ങളിലായിരിക്കണം (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("വീഡിയോ"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("അറ്റാച്ച് ചെയ്യുക"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("അറ്റാച്ച് ചെയ്യാൻ തയ്യാർ"),
      "voice_record_post": MessageLookupByLibrary.simpleMessage(
          "വോയ്സ് പോസ്റ്റ് റെക്കോർഡ് ചെയ്യുക"),
      "voice_recording":
          MessageLookupByLibrary.simpleMessage("സേവ് ചെയ്യുന്നു…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("നിർത്തുക"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("എന്ത് സംഭവിച്ചു"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "എന്താണ് സംഭവിച്ചത്, ഞങ്ങൾ എന്താണ് പരിശോധിക്കേണ്ടത്?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("ഈ ചിത്രത്തിൽ എന്താണ്?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("ഇത് എന്തിനാണ്? (ഓപ്ഷണൽ)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ എന്ത് ചെയ്തു, എന്ത് പ്രതീക്ഷിച്ചു, എന്ത് സംഭവിച്ചു"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "അത് സംഭവിച്ചപ്പോൾ നിങ്ങൾ എന്ത് ചെയ്യുകയായിരുന്നു."),
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
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("ഫോളോവർ"),
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
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("ആ ലെൻസ് ലോഡ് ചെയ്യാനായില്ല."),
      "ar_could_not_record": MessageLookupByLibrary.simpleMessage(
          "വീഡിയോ റെക്കോർഡ് ചെയ്യാനായില്ല."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "ഈ വീഡിയോയിൽ ലെൻസ് ചേർക്കാനായില്ല, അതിനാൽ ചിത്രീകരിച്ചതുപോലെ പോസ്റ്റ് ചെയ്യും."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റിൽ ഇതിനകം പരമാവധി അറ്റാച്ച്‌മെന്റുകളുണ്ട്."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ലെൻസ് ചേർക്കുന്നു…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("ഫ്ലാഷ്"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("വീഡിയോ റെക്കോർഡ് ചെയ്യുക"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("ഫോട്ടോ"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("വീഡിയോ"),
      "googleSignInCancelled":
          MessageLookupByLibrary.simpleMessage("Google സൈൻ-ഇൻ റദ്ദാക്കി."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("സമ്മാനങ്ങൾ"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "ഈ പോസ്റ്റിന് ഇതുവരെ ആരും സമ്മാനം അയച്ചിട്ടില്ല."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("സമ്മാനം"),
      "analytics_gifts_label":
          MessageLookupByLibrary.simpleMessage("സമ്മാനങ്ങൾ"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("നാണയങ്ങൾ"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("അയച്ചയാൾ"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("അയച്ചവർ"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "ടെസ്റ്റ് നാണയങ്ങൾ: ഇവ ഇതുവരെ പിൻവലിക്കാനാവില്ല."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("സംരക്ഷിച്ചവ"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("പോസ്റ്റുകൾ"),
      "ui_saved_tab_comments": MessageLookupByLibrary.simpleMessage("കമന്റുകൾ"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("കൂടുതൽ മറുപടികൾ കാണുക"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("എഡിറ്റ് ചെയ്തത്"),
      "ui_more": MessageLookupByLibrary.simpleMessage("കൂടുതൽ"),
      "ui_following": MessageLookupByLibrary.simpleMessage("ഫോളോ ചെയ്യുന്നവ"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("മികച്ചവ"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("പുതിയവ"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage(
          "കമന്റുകൾ ക്രമീകരിക്കുക: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റിന് ഒരു സമ്മാനം അയച്ചു"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ കമന്റിന് \$gift അയച്ചു"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പോസ്റ്റിന് \$gift അയച്ചു"),
      "ui_gift_title":
          MessageLookupByLibrary.simpleMessage("സമ്മാനം അയയ്ക്കുക"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("പോസ്റ്റ് എഡിറ്റ് ചെയ്യുക"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "ഇനി \$n മിനിറ്റ് കൂടി എഡിറ്റ് ചെയ്യാം"),
      "ui_save": MessageLookupByLibrary.simpleMessage("സംരക്ഷിക്കുക"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "#\$tab എന്നതിൽ ഇതുവരെ ഒന്നും പോസ്റ്റ് ചെയ്തിട്ടില്ല."),
      "ui_gift_pick":
          MessageLookupByLibrary.simpleMessage("ഒരു സമ്മാനം തിരഞ്ഞെടുക്കുക"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("ആവശ്യത്തിന് നാണയങ്ങളില്ല"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "ടെസ്റ്റ് നാണയങ്ങൾ: ഇവ വാങ്ങാനാവില്ല, പണമൂല്യവുമില്ല."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("\$date-ന് വീണ്ടും നിറയും."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 നാണയം"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count നാണയങ്ങൾ"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾക്ക് \$coins ഉണ്ട്"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift അയയ്ക്കുക"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift അയച്ചു"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("വീണ്ടും ശ്രമിക്കുക"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "പോസ്റ്റ് ചെയ്ത് 15 മിനിറ്റ് വരെ"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("എഡിറ്റ് ചെയ്തു"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "സംരക്ഷിച്ച കമന്റുകൾ ലോഡ് ചെയ്യാനായില്ല"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("സംരക്ഷിച്ച കമന്റുകളൊന്നുമില്ല"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "ഒരു കമന്റ് ഇവിടെ സൂക്ഷിക്കാൻ അതിനു താഴെയുള്ള ആർക്കൈവ് ഐക്കണിൽ ടാപ്പ് ചെയ്യുക. നിങ്ങൾ സംരക്ഷിക്കുന്നത് നിങ്ങൾക്ക് മാത്രമേ കാണാനാകൂ."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("\$name-ന് മറുപടി"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("പകർത്തുക"),
      "ui_search": MessageLookupByLibrary.simpleMessage("തിരയുക"),
      "ui_select_all":
          MessageLookupByLibrary.simpleMessage("എല്ലാം തിരഞ്ഞെടുക്കുക"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("\$count സമ്മാനങ്ങൾ"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 സമ്മാനം"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "കൂടുതൽ പോസ്റ്റുകൾ ലോഡ് ചെയ്യാനായില്ല."),
      "ui_reminders":
          MessageLookupByLibrary.simpleMessage("ഓർമ്മപ്പെടുത്തലുകൾ"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ കുറച്ചുകാലം ഇല്ലാതിരുന്നപ്പോൾ പുതിയതെന്ത്, നിങ്ങളുടെ നാണയങ്ങൾ തിരികെ വരുമ്പോൾ. ദിവസം ഒന്നിലധികം ഒരിക്കലുമില്ല."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("സമ്മാനങ്ങൾ"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("1 വ്യക്തിയിൽ നിന്ന്"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count പേരിൽ നിന്ന്"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("മികച്ച സമ്മാനദാതാവ്"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "സമ്മാനം അയച്ചവരെ ലോഡ് ചെയ്യാനായില്ല."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("പുതിയതെന്ത്"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("മനസ്സിലായി"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "നന്ദി. ഓരോ മറുപടിയും ഞങ്ങൾ വായിക്കുന്നു."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("ഇതുവരെ Kyron എങ്ങനെയുണ്ട്?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പരീക്ഷണത്തിന്റെ \$day-ാം ദിവസം. ഒരു ടാപ്പ് മതി."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "ഞങ്ങൾ ശരിയാക്കേണ്ടതോ ചേർക്കേണ്ടതോ എന്തെങ്കിലുമുണ്ടോ? (ഓപ്ഷണൽ)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("അയയ്ക്കുക"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("ഇപ്പോൾ വേണ്ട"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Kyron വിടാൻ വീണ്ടും പിന്നോട്ട് അമർത്തുക"),
      "ui_confirm_its_you_title": MessageLookupByLibrary.simpleMessage(
          "ഇത് നിങ്ങളാണെന്ന് സ്ഥിരീകരിക്കുക"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "അക്കൗണ്ട് ഇല്ലാതാക്കാൻ പാസ്‌വേഡ് നൽകുക."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "അക്കൗണ്ട് ഇല്ലാതാക്കാൻ Google ഉപയോഗിച്ച് വീണ്ടും സൈൻ ഇൻ ചെയ്യുക."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "അത് പ്രവർത്തിച്ചില്ല. പരിശോധിച്ച് വീണ്ടും ശ്രമിക്കുക."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "ഈ പേജ് മറ്റൊരു ആപ്പ് തുറക്കാൻ ആഗ്രഹിക്കുന്നു"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "ഇത് ഒരു {scheme} ലിങ്ക് തുറക്കാൻ ആവശ്യപ്പെടുന്നു."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("ബിൽഡ്"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "കാഷെയിൽ {size} ചിത്രങ്ങളും ഫയലുകളും"),
      "ui_about_freed": MessageLookupByLibrary.simpleMessage("{size} ഒഴിവായി"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("അളക്കുന്നു…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("മായ്ക്കാൻ ഒന്നുമില്ല"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("സ്റ്റോറേജ്"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("പതിപ്പ് {version}"),
      "ui_blocked_tab":
          MessageLookupByLibrary.simpleMessage("ബ്ലോക്ക് ചെയ്തവർ"),
      "ui_composer_posting_as_you": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പേരിൽ പോസ്റ്റ് ചെയ്യുന്നു"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "ഈ അറ്റാച്ച്മെന്റുകൾ അപ്‌ലോഡ് ആയില്ല. വീണ്ടും ശ്രമിക്കാൻ ഒന്നിൽ ടാപ്പ് ചെയ്യുക, അല്ലെങ്കിൽ അത് നീക്കം ചെയ്യുക."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ ഇമെയിൽ മാറ്റാനായില്ല. ദയവായി വീണ്ടും ശ്രമിക്കുക."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "ഞങ്ങൾ അയയ്ക്കുന്ന ലിങ്ക് തുറക്കുമ്പോൾ നിങ്ങളുടെ വിലാസം മാറും."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "സ്ഥിരീകരണ ലിങ്കിനായി {email} നോക്കുക."),
      "ui_email_enter":
          MessageLookupByLibrary.simpleMessage("ഒരു ഇമെയിൽ വിലാസം നൽകുക."),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage(
          "ഇത് ഇമെയിൽ വിലാസം പോലെ തോന്നുന്നില്ല."),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "ഇത് ഇതിനകം നിങ്ങളുടെ ഇമെയിൽ വിലാസമാണ്."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ എന്ത് ചെയ്തു, എന്ത് പ്രതീക്ഷിച്ചു, പകരം എന്ത് സംഭവിച്ചു."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "എന്റെ പ്രൊഫൈലിൽ ഒരു പോസ്റ്റ് പിൻ ചെയ്യാൻ അനുവദിക്കൂ"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾക്ക് എന്താണ് വേണ്ടത്, അത് നിങ്ങളെ എന്ത് ചെയ്യാൻ സഹായിക്കും."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("എന്ത് സഹായിക്കും"),
      "ui_feedback_kind_bug":
          MessageLookupByLibrary.simpleMessage("ഒരു പ്രശ്നം"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("ഒരു ആശയം"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("ഒരു ചോദ്യം"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "ഇത് Kyron ടീം മാത്രമേ വായിക്കൂ. ഇമെയിലിൽ മറുപടി നൽകാൻ ഇത് നിങ്ങളുടെ അക്കൗണ്ടിനൊപ്പം, നിങ്ങൾ ഉപയോഗിക്കുന്ന ആപ്പ് പതിപ്പിനൊപ്പം അയയ്ക്കുന്നു. അക്കൗണ്ട് ഇല്ലാതാക്കിയാൽ ഇതും ഇല്ലാതാകും."),
      "ui_feedback_question_example": MessageLookupByLibrary.simpleMessage(
          "ഒരു വാക്ക് എങ്ങനെ മ്യൂട്ട് ചെയ്യാം?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ എന്ത് ചെയ്യാൻ ശ്രമിക്കുന്നു, എവിടെ കുടുങ്ങി."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ചോദ്യം"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Kyron-ലേക്ക് എത്താനായില്ല. കണക്ഷൻ പരിശോധിച്ച് വീണ്ടും ശ്രമിക്കുക. ഇതുവരെ ഒന്നും എഴുതിയിട്ടില്ല, അതിനാൽ ഒന്നും നഷ്ടപ്പെട്ടില്ല."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("മായ്ക്കുക"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "പരാജയപ്പെട്ട അഭ്യർത്ഥനകളും മറ്റ് ശ്രദ്ധേയമായ സംഭവങ്ങളും ഇവിടെ കാണിക്കും."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("മ്യൂട്ട് ചെയ്തവ"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "മുകളിൽ ഒരു വാക്കോ ടാഗോ ചേർക്കുക. അതുള്ള പോസ്റ്റുകൾ നിങ്ങളുടെ ഫീഡിൽ വരില്ല."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "ഇവയിൽ ഏതെങ്കിലും ഉള്ള പോസ്റ്റുകൾ നിങ്ങളുടെ ഫീഡിൽ വരില്ല. വലിയ-ചെറിയ അക്ഷരങ്ങൾ പ്രശ്നമല്ല, വാക്ക് നീണ്ട വാക്കുകൾക്കുള്ളിലും പൊരുത്തപ്പെടും, അതിനാൽ “spoiler” “spoilers”-നെയും പിടിക്കും."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("ആരെയും ബ്ലോക്ക് ചെയ്തിട്ടില്ല"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "ബ്ലോക്ക് ചെയ്യുമ്പോൾ നിങ്ങൾ ഇരുവരും ഇരുവശത്തുനിന്നും പരസ്പരം മറയും. ഒരാളുടെ പ്രൊഫൈൽ മെനുവിൽ നിന്ന് അവരെ ബ്ലോക്ക് ചെയ്യുക."),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("ആരെയും മ്യൂട്ട് ചെയ്തിട്ടില്ല"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "ഒരു അക്കൗണ്ട് മ്യൂട്ട് ചെയ്യുന്നത് അവരെ അറിയിക്കാതെ അവരുടെ പോസ്റ്റുകൾ മറയ്ക്കും. പ്രൊഫൈലിലെയോ പോസ്റ്റിലെയോ മെനുവിൽ നിന്ന് മ്യൂട്ട് ചെയ്യുക."),
      "ui_password": MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ്"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("പൊരുത്തപ്പെടുന്നില്ല."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "ഈ ഉപകരണത്തിൽ നിങ്ങൾ സൈൻ ഇൻ ആയിത്തന്നെ തുടരും. മറ്റ് ഉപകരണങ്ങളിൽ നിന്ന് സൈൻ ഔട്ട് ആകും."),
      "ui_password_too_short": MessageLookupByLibrary.simpleMessage(
          "കുറഞ്ഞത് 8 പ്രതീകങ്ങൾ ഉപയോഗിക്കുക."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "പാസ്‌വേഡ് അപ്ഡേറ്റ് ചെയ്യാനായില്ല. ദയവായി വീണ്ടും ശ്രമിക്കുക."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("പാസ്‌വേഡ് അപ്ഡേറ്റ് ചെയ്തു."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID പകർത്തി"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ഇഷ്ടപ്പെട്ട പോസ്റ്റുകൾ നിങ്ങൾക്കായി മാത്രം ഇവിടെ സൂക്ഷിക്കുന്നു."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ഇതുവരെ ഫോട്ടോകളോ ക്ലിപ്പുകളോ പോസ്റ്റ് ചെയ്തിട്ടില്ല."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} ഇതുവരെ ഫോട്ടോകളോ ക്ലിപ്പുകളോ പോസ്റ്റ് ചെയ്തിട്ടില്ല."),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ പോസ്റ്റ് ചെയ്യുന്നതെല്ലാം ഇവിടെ കാണാം."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} ഇതുവരെ ഒന്നും പോസ്റ്റ് ചെയ്തിട്ടില്ല."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പ്രൊഫൈൽ ലോഡ് ചെയ്യാനായില്ല"),
      "ui_profile_load_failed_other":
          MessageLookupByLibrary.simpleMessage("@{handle} ലോഡ് ചെയ്യാനായില്ല"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("കുറഞ്ഞത് 8 പ്രതീകങ്ങൾ"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("ചെറിയക്ഷരം (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("കുറഞ്ഞത് ഒരു അക്കം"),
      "ui_pw_rule_symbol":
          MessageLookupByLibrary.simpleMessage("ചിഹ്നം (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("വലിയക്ഷരം (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "സമീപകാല {count} എൻട്രികൾ. അയയ്ക്കുന്നതിന് മുമ്പ് വിവരം › സിസ്റ്റം ലോഗ്-ൽ അവ പരിശോധിക്കുക."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "ഇത് Kyron ടീം മാത്രമേ വായിക്കൂ. ഫോളോ അപ്പ് ചെയ്യാൻ ഇത് നിങ്ങളുടെ അക്കൗണ്ടിനൊപ്പം അയയ്ക്കുന്നു. ഒപ്പം കൃത്യമായി എന്താണ് പോകുന്നതെന്ന് കാണണമെങ്കിൽ ആദ്യം വിവരം › സിസ്റ്റം ലോഗ്-ൽ ലോഗ് വായിക്കുക."),
      "ui_report_sent": MessageLookupByLibrary.simpleMessage("അയച്ചു, നന്ദി."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "അയച്ചു, നന്ദി. ഇത് റിപ്പോർട്ട് #{number} ആണ്."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("എന്താണ് തെറ്റിയത്?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "പതിപ്പ്, നയങ്ങൾ, നില, സിസ്റ്റം ലോഗ്"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "സ്ക്രോൾ ചെയ്യുമ്പോൾ വീഡിയോകൾ സ്വയം പ്ലേ ആകുന്നത് തടയുക"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ വികേന്ദ്രീകൃത ഐഡന്റിഫയർ"),
      "ui_settings_moderation": MessageLookupByLibrary.simpleMessage("മോഡറേഷൻ"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "അവലോകനത്തിനായി കാത്തിരിക്കുന്ന റിപ്പോർട്ടുകളും അപ്പീലുകളും"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "ഇവയുള്ള പോസ്റ്റുകൾ ഫീഡിൽ നിന്ന് അകറ്റി നിർത്തുക"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("സൈൻ ഇൻ ചെയ്തിട്ടില്ല"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("അറിയിപ്പ് മുൻഗണനകൾ"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("സ്വകാര്യതയും സുരക്ഷയും"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ടിനെക്കുറിച്ചുള്ള തീരുമാനങ്ങളും അപ്പീലുകളും"),
      "ui_settings_text_size_help": MessageLookupByLibrary.simpleMessage(
          "ടെക്സ്റ്റ് വലുപ്പം ക്രമീകരിക്കുക"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ അക്കൗണ്ട്"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "AR ലെൻസുകൾ റെക്കോർഡ് ചെയ്യലും പ്രസിദ്ധീകരിക്കലും ഇപ്പോഴും നിർമ്മാണത്തിലാണ്. നിങ്ങൾ പകർത്തുന്നതൊന്നും ഇപ്പോൾ സേവ് ആകില്ല, അതിനാൽ ക്യാമറ അടഞ്ഞുതന്നെ."),
      "ui_soon_lens_heading": MessageLookupByLibrary.simpleMessage(
          "ലെൻസുകൾ ഇതുവരെ തയ്യാറായിട്ടില്ല"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR ലെൻസ്"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "ലൈവ് പോകാൻ Kyron ഇതുവരെ പ്രവർത്തിപ്പിക്കാത്ത ഒരു മീഡിയ സെർവർ വേണം. ഇപ്പോൾ പ്രക്ഷേപണം തുടങ്ങിയാൽ ആർക്കും ചേരാനാകാത്ത മുറിയിലാകും നിങ്ങൾ. വോയ്‌സ് പോസ്റ്റ് റെക്കോർഡ് ചെയ്യുന്നത് ഇന്നുതന്നെ പ്രവർത്തിക്കും."),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("ലൈവ് ഇതുവരെ തയ്യാറായിട്ടില്ല"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("ലൈവ് പോകുക"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "പോളുകൾക്ക് ഓപ്ഷനുകൾ സൂക്ഷിക്കാനും വോട്ടുകൾ എണ്ണാനും ഒരിടം വേണം. അത് ഇതുവരെയില്ല, അതിനാൽ ഇന്ന് പോസ്റ്റ് ചെയ്യുന്ന പോൾ എല്ലാ ഉത്തരങ്ങളും നഷ്ടപ്പെടുത്തും."),
      "ui_soon_poll_heading": MessageLookupByLibrary.simpleMessage(
          "പോളുകൾ ഇതുവരെ തയ്യാറായിട്ടില്ല"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("പോൾ"),
      "ui_soon_write_instead": MessageLookupByLibrary.simpleMessage(
          "പകരം ടെക്സ്റ്റ് പോസ്റ്റ് എഴുതുക"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("വീണ്ടും പരിശോധിക്കുക"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("വിശദാംശം"),
      "ui_status_mirror": MessageLookupByLibrary.simpleMessage("മിറർ ടേബിളുകൾ"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron മറുപടി നൽകി, പക്ഷേ എന്തോ ശരിയല്ല."),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("റൗണ്ട് ട്രിപ്പ്"),
      "ui_support_ask":
          MessageLookupByLibrary.simpleMessage("ചോദ്യം ചോദിക്കുക"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ അക്കൗണ്ടിനെക്കുറിച്ച്, അല്ലെങ്കിൽ എന്തെങ്കിലും എങ്ങനെ പ്രവർത്തിക്കുന്നു എന്ന്"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("ഇമെയിൽ വഴി"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron ക്രാഷായെങ്കിൽ: ആപ്പ് ലോഗും ഒപ്പം അയയ്ക്കും"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("ആപ്പിൽ"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "ഇവിടെ നിന്ന് Kyron ടീമിന് എഴുതുക. ഇത് നിങ്ങളുടെ അക്കൗണ്ടിനൊപ്പം സ്വകാര്യമായി ഞങ്ങളിലെത്തും, അതിലെ ഇമെയിൽ വിലാസത്തിലേക്ക് ഞങ്ങൾ മറുപടി നൽകും."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "മെയിൽ ആപ്പൊന്നും തുറന്നില്ല. {address} പകർത്തി."),
      "ui_support_privacy": MessageLookupByLibrary.simpleMessage(
          "സ്വകാര്യതയും നിങ്ങളുടെ ഡാറ്റയും"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("പ്രശ്നം റിപ്പോർട്ട് ചെയ്യുക"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "എന്തോ തകർന്നിരിക്കുന്നു അല്ലെങ്കിൽ ചെയ്യേണ്ടത് ചെയ്യുന്നില്ല"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "ഒരു പോസ്റ്റോ അക്കൗണ്ടോ റിപ്പോർട്ട് ചെയ്യാൻ അതിന്റെ മെനു ഉപയോഗിക്കുക: നിങ്ങൾ ഏതിനെക്കുറിച്ചാണ് പറയുന്നതെന്ന് അപ്പോൾ ഞങ്ങൾക്ക് കൃത്യമായി അറിയാം."),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("സുരക്ഷയും ദുരുപയോഗവും"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron എല്ലാവർക്കും പ്രവർത്തനരഹിതമാണോ, അതോ നിങ്ങൾക്ക് മാത്രമോ"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("വലുത്"),
      "ui_text_size_larger":
          MessageLookupByLibrary.simpleMessage("കൂടുതൽ വലുത്"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("ഇടത്തരം"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "വായിക്കാൻ കൊള്ളാവുന്നത് പറയാനുള്ള ഇടമാണ് Kyron."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("ചെറുത്"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("എപ്പോഴും ഡാർക്ക്"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("മങ്ങിയത്"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "കറുപ്പിന് പകരം നീല-ചാരം, മൃദുവായ ഡാർക്ക്"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("എപ്പോഴും ലൈറ്റ്"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "ഫോണിന്റെ ലൈറ്റ് അല്ലെങ്കിൽ ഡാർക്ക് ക്രമീകരണം പിന്തുടരുക"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("ബ്ലോക്ക് നീക്കുക"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("അൺമ്യൂട്ട് ചെയ്യുക"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("നിങ്ങൾ ആരാണ്"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ വാക്കുകളിൽ, പരിശോധകൻ അറിയേണ്ടത്."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "ഞാൻ ഇവിടെയും എന്റെ സ്വന്തം സൈറ്റിലും പക്ഷികളെക്കുറിച്ച് എഴുതുന്നു."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("മറ്റൊരു ലിങ്ക് ചേർക്കുക"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "{date} മുതൽ വീണ്ടും അഭ്യർത്ഥിക്കാം."),
      "ui_verify_ask":
          MessageLookupByLibrary.simpleMessage("പരിശോധന അഭ്യർത്ഥിക്കുക"),
      "ui_verify_before":
          MessageLookupByLibrary.simpleMessage("അഭ്യർത്ഥിക്കുന്നതിന് മുമ്പ്"),
      "ui_verify_cat_creator":
          MessageLookupByLibrary.simpleMessage("സ്രഷ്ടാവ്"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("പത്രപ്രവർത്തകൻ"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("സ്ഥാപനം അല്ലെങ്കിൽ ബ്രാൻഡ്"),
      "ui_verify_cat_other":
          MessageLookupByLibrary.simpleMessage("മറ്റെന്തെങ്കിലും"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("പൊതു വ്യക്തിത്വം"),
      "ui_verify_denied": MessageLookupByLibrary.simpleMessage(
          "അഭ്യർത്ഥന {number} അംഗീകരിച്ചില്ല"),
      "ui_verify_done": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ പരിശോധിച്ചുറപ്പിക്കപ്പെട്ടു"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ എഡിറ്റ് ചെയ്യുക"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("6 അക്ക കോഡ് നൽകുക"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "{seconds} സെക്കൻഡിൽ കോഡ് വീണ്ടും അയയ്ക്കുക"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("അത് {email}-ലേക്ക് അയച്ചു"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("പരിശോധിക്കുക"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Kyron-ൽ പരിശോധന നേടുക"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Kyron-ൽ"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("പരിശോധന"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("നേടുക."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "ഈ അക്കൗണ്ട് അവകാശപ്പെടുന്ന ആൾ തന്നെയെന്ന് Kyron ടീമിലെ ആരോ പരിശോധിച്ചുവെന്ന് ബാഡ്ജ് സൂചിപ്പിക്കുന്നു. ഇത് അധിക റീച്ച് നൽകില്ല, വിൽപ്പനയ്ക്കുമില്ല."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പേര് നിലനിൽക്കുന്നിടത്തോളം ബാഡ്ജും നിലനിൽക്കും. പേര് മാറ്റിയാൽ, ആരെങ്കിലും പുതിയത് പരിശോധിക്കുന്നതുവരെ അത് നീക്കും."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("ഞങ്ങൾക്ക് എവിടെ പരിശോധിക്കാം"),
      "ui_verify_link_more":
          MessageLookupByLibrary.simpleMessage("മറ്റൊരു ലിങ്ക്"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "ഈ Kyron അക്കൗണ്ട് നിങ്ങളുടേതാണെന്ന് പറയുന്ന സൈറ്റോ മറ്റൊരു പ്രൊഫൈലോ: അവിടെ നിങ്ങളുടെ Kyron പേര്, അല്ലെങ്കിൽ പ്രൊഫൈൽ ലിങ്ക് ചേർക്കുക. Kyron ഒരിക്കലും തിരിച്ചറിയൽ രേഖകൾ ചോദിക്കില്ല."),
      "ui_verify_load_failed": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ നില ലോഡ് ചെയ്യാനായില്ല"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "അഭ്യർത്ഥിക്കുന്നതിന് മുമ്പ് മുകളിലുള്ളതെല്ലാം ടിക്ക് ചെയ്തിരിക്കണം."),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "കുറഞ്ഞത് {days} ദിവസം പഴക്കമുള്ള അക്കൗണ്ട്"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("നിങ്ങൾ ആരാണെന്ന് പറയുന്ന ബയോ"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈലിൽ നിങ്ങളുടെ പേര്"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ ഫോട്ടോ"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "കഴിഞ്ഞ {days} ദിവസത്തിൽ നിങ്ങളുടെ രേഖയിൽ ഒന്നുമില്ല"),
      "ui_verify_sent":
          MessageLookupByLibrary.simpleMessage("അയച്ചു. ഒരാൾ ഇത് നോക്കും."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("{date} മുതൽ."),
      "ui_verify_step_ask":
          MessageLookupByLibrary.simpleMessage("അഭ്യർത്ഥിക്കുക"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങൾ ആരാണ്, അത്\nതെളിയിക്കുന്ന ലിങ്ക്"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("ബാഡ്ജ്"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "നിങ്ങളുടെ പേരിനരികിൽ,\nഅത് കാണുന്നിടത്തെല്ലാം"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("ഒരാൾ\nപരിശോധിക്കുന്നു"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "ടീമിലെ ഒരാൾ\nനിങ്ങളുടെ ലിങ്കുകൾ തുറക്കുന്നു"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("പരിശോധന"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "അഭ്യർത്ഥന {number} ഒരാളുടെ പക്കലാണ്"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "{date}-ന് {category} ആയി അയച്ചു. തീരുമാനമാകുമ്പോൾ നിങ്ങൾക്ക് അറിയിപ്പ് ലഭിക്കും."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("അഭ്യർത്ഥന പിൻവലിക്കുക"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("അഭ്യർത്ഥന പിൻവലിച്ചു."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "റെക്കോർഡിംഗ് പൂർത്തിയാക്കാനായില്ല: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("പത്ത് മിനിറ്റ് വരെ."),
      "ui_voice_listening":
          MessageLookupByLibrary.simpleMessage("കേൾക്കുന്നു…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "റെക്കോർഡ് ചെയ്യാൻ Kyron-ന് മൈക്രോഫോൺ അനുമതി വേണം. ഉപകരണ ക്രമീകരണങ്ങളിൽ അത് നൽകാം."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "റെക്കോർഡിംഗ് തുടങ്ങാനായില്ല: {error}"),
    };

final messageLookup = MessageLookup();
