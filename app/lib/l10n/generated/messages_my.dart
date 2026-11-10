import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'my';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
          "စကားလုံး၊ စကားစု သို့မဟုတ် #တဂ်"),
      "about": MessageLookupByLibrary.simpleMessage("အကြောင်း"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("အဖြေ ထည့်ရန်"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("ဘာသာစကားများ ထည့်ရန်…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("သဘောတူပြီး ဆက်လုပ်ရန်"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Kyron အကောင့် ရှိပြီးသားလား။"),
      "analytics_comments":
          MessageLookupByLibrary.simpleMessage("မှတ်ချက်များ"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "မတူညီသော လူများ၊ ဖွင့်သည့်အကြိမ် မဟုတ်"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("ပါဝင်ဆောင်ရွက်မှု"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("လိုက်ခ်များ"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("ကြည့်ရှုသူ မရှိသေးပါ"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "ဤပို့စ်ကို မည်သူမျှ မဖွင့်ရသေးပါ။"),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("တင်ပြီး"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("သိမ်းမှုများ"),
      "analytics_viewers":
          MessageLookupByLibrary.simpleMessage("ကြည့်ရှုသူများ"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("တစ်ရက်လျှင် ကြည့်ရှုသူ"),
      "and": MessageLookupByLibrary.simpleMessage("နှင့်"),
      "answerNumber": (Object a0) => "အဖြေ ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR မှန်ဘီလူး"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("အက်ပ် မှတ်တမ်း ပူးတွဲရန်"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("အသွားအပြန် အချိန်"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("တိုကင် အတည်ပြုခြင်း"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("ထပ်ကြိုးစားရန်"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("ထပ်ကြိုးစားရန်"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "ယခု ထုတ်လွှင့်မှု စတင်ပါက မည်သူမျှ မဝင်နိုင်သော အခန်းထဲ ရောက်သွားပါမည်"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်း စတင်ရန်"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("ဘာအတွက်လဲ။ (ရွေးချယ်နိုင်)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("ပြန်မဝင်နိုင်ပါ။"),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("ဤစာရင်းမှ ပြန်မဝင်နိုင်ပါ။"),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("၎င်းကို ပိတ်ပါက"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("ဦးစွာ ပါဝင်ပါ"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("မကြာမီ"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("သင့်အမည်ဖြင့် ပို့စ်တင်နေသည်"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage(
              "ဤအသိုင်းအဝိုင်းတွင် ပို့စ်တင်ရန်"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("ယခုလေးတင်"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("ထပ်ကြိုးစားရန်"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("ခေါင်းစဉ် 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("သင့်အတွက်"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("တစ်ခုခု ရှိသည်။"),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("ယခု ထိုနေရာသို့ သွားနေသည်။"),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage("၊ မဟုတ်"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("ကျွန်ုပ် ရွေ့နေသလား"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("အသံပိတ်ရန်"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("အသံဖွင့်ရန်"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("သင့်အတွက်"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("သင့်တက်ဘ်များ"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("ထပ်ကြိုးစားရန်"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("သင်္ကေတ (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("တစ်ရက်လျှင် ကြည့်ရှုသူ"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("ဖွင့်၍ မရပါ"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ဤပို့စ်"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "ထပ်ဖြည့်စရာ ရှိပါသလား။ (ရွေးချယ်နိုင်)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ဤပို့စ်"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("အကောင့်တစ်ခုမှ"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("ထွက်ရန်"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("သင့်အကောင့်"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် အတည်ပြုပါ"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("ယခု မဟုတ်"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("ဖွင့်နေသည်…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("ပို့စ်တင်နေသည်…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 နာရီ အကြာက"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("စတိုရီ လင့်ခ် ကူးယူရန်"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("သင့်စတိုရီ"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "သင့်အကောင့်၊ သင့်ပို့စ်များနှင့် သင်နှိပ်သည့်အရာများ၊ ထို့ကြောင့်"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("ခေါင်းစဉ် ထည့်ရန်"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("ကိုယ်ပိုင်။"),
      "authorBlocked": (Object a0) => "${a0} ကို ပိတ်ဆို့ပြီး",
      "authorPostsHidden": (Object a0) => "${a0} ၏ ပို့စ်များကို မမြင်ရတော့ပါ",
      "block": MessageLookupByLibrary.simpleMessage("ပိတ်ဆို့ရန်"),
      "blockAuthor": (Object a0) => "${a0} ကို ပိတ်ဆို့မလား။",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("ဗားရှင်း အသေးစိတ် ကူးယူပြီး"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "ဆက်လုပ်ခြင်းဖြင့် သင်သဘောတူပါသည်"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "ဆက်လုပ်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ ဝန်ဆောင်မှု စည်းမျဉ်းများနှင့် ကိုယ်ရေးအချက်အလက် မူဝါဒကို သဘောတူပါသည်"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "စာရင်းသွင်းခြင်းဖြင့် သင်သဘောတူပါသည်"),
      "cancel": MessageLookupByLibrary.simpleMessage("မလုပ်တော့ပါ"),
      "change": MessageLookupByLibrary.simpleMessage("ပြောင်းရန်"),
      "changeEmail":
          MessageLookupByLibrary.simpleMessage("အီးမေးလ် ပြောင်းရန်"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "သင့်အီးမေးလ်မှ အကောင့်ကို အတည်ပြုပါ။"),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Kyron ချိတ်ဆက်နိုင်မနိုင် စစ်ရန်"),
      "clear": MessageLookupByLibrary.simpleMessage("ရှင်းရန်"),
      "close": MessageLookupByLibrary.simpleMessage("ပိတ်ရန်"),
      "closeCommunity": (Object a0) => "${a0} ကို ပိတ်မလား။",
      "closeIt": MessageLookupByLibrary.simpleMessage("ပိတ်ရန်"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("ဤအသိုင်းအဝိုင်းကို ပိတ်ရန်"),
      "communities": MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်းများ"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "စူးစမ်းရန် တွင် ရှာပါ သို့မဟုတ် ကိုယ်ပိုင် စတင်ပါ။"),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "ပူပြင်းသော အမြင်တစ်ခု ပစ်လိုက်ပါ (သို့မဟုတ် နွေးနွေး)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("ဘာတွေ တွေးနေလဲ။"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "သင်သာ ပြောနိုင်သည့်အရာကို ပြောပါ…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "ဤသည်မှာ သင့်အတွက် အချက်ပြ- တင်လိုက်ပါ"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "ရိုက်ပါ၊ ပြောပါ သို့မဟုတ် အသံထွက် စဉ်းစားပါ"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် အတည်ပြုပါ"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("အကူအညီဌာနကို ဆက်သွယ်ရန်"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "ပို့စ်များတွင် ဘာသာစကား မရှိသေးသောကြောင့် ၎င်းသည် သင့်ဖိဒ်ကို မစစ်ထုတ်သေးပါ။ ထိုအချိန်အထိ သင့်ရွေးချယ်မှုများကို သိမ်းထားပါမည်။"),
      "continueAction": MessageLookupByLibrary.simpleMessage("ဆက်လုပ်ရန်"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("အီးမေးလ်ဖြင့် ဆက်လုပ်ရန်"),
      "copy": MessageLookupByLibrary.simpleMessage("ကူးယူရန်"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("အစား အစီရင်ခံစာ ကူးယူရန်"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google ဝင်ရောက်မှု ဖွင့်၍ မရပါ။ ${a0}",
      "couldNotSignOut": (Object a0) => "ထွက်၍ မရပါ: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံ ရိုက်၍ မရပါ။"),
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
      "create": MessageLookupByLibrary.simpleMessage("ဖန်တီးရန်"),
      "createAccount":
          MessageLookupByLibrary.simpleMessage("အကောင့် ဖန်တီးရန်"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("သင့်အကောင့် ဖန်တီးပါ"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("သင့်ပရိုဖိုင် ဖန်တီးပါ"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR မှန်ဘီလူး"),
      "create_go_live":
          MessageLookupByLibrary.simpleMessage("တိုက်ရိုက်ထုတ်လွှင့်ရန်"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("စာသား ပို့စ်"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("အသံ ပို့စ်"),
      "delete": MessageLookupByLibrary.simpleMessage("ဖျက်ရန်"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("ဤမှတ်ချက်ကို ဖျက်မလား။"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("ဤပို့စ်ကို ဖျက်မလား။"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("ဤပူးတွဲဖိုင်ကို ဖော်ပြပါ"),
      "description": MessageLookupByLibrary.simpleMessage("ဖော်ပြချက်"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
          "DID ကို ကလစ်ဘုတ်သို့ ကူးယူပြီး"),
      "done": MessageLookupByLibrary.simpleMessage("ပြီးပါပြီ"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "တစ်ခုခု ရေးပြီးနောက် တည်းဖြတ်ကိရိယာကို ပိတ်ပါ၊ မူကြမ်း ကမ်းလှမ်းပါမည်။"),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} ရက် အကြာက"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} နာရီ အကြာက"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("ယခုလေးတင်"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} မိနစ် အကြာက"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("ဘာမျှ မရေးရသေးပါ"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("စစ်တမ်း၊ မေးခွန်း မရှိသေး"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("ကိုးကားချက်၊ စာသား မရှိသေး"),
      "drafts": MessageLookupByLibrary.simpleMessage("မူကြမ်းများ"),
      "editProfile": MessageLookupByLibrary.simpleMessage("ပရိုဖိုင် ပြင်ရန်"),
      "email": MessageLookupByLibrary.simpleMessage("အီးမေးလ်"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("အီးမေးလ် အသိပေးချက်များ"),
      "explore": MessageLookupByLibrary.simpleMessage("စူးစမ်းရန်"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "ဤစက်တွင် မျက်နှာ ခြေရာခံခြင်း မရနိုင်ပါ။"),
      "feedTagDetail": (Object a0) => "#${a0} ဖြင့် ဘာမျှ မတင်ရသေးပါ။",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("{name} ကို စောင့်ကြည့်ရန်"),
      "followers": MessageLookupByLibrary.simpleMessage("ဖော်လိုဝါများ"),
      "following": MessageLookupByLibrary.simpleMessage("ဖော်လိုလုပ်ထားသည်"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် မေ့နေပါသလား။"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("အကူအညီ ရယူခြင်း"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Google ဖြင့် ဆက်လုပ်ရန်"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Google ဖြင့် ဝင်ရန်"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google သည် ပြီးဆုံးသော ဝင်ရောက်မှုကို Android နှင့် iOS သာ တုံ့ပြန်သော လင့်ခ်မှတစ်ဆင့် Kyron သို့ ပြန်ပေးသောကြောင့် ${a0} ပေါ်တွင် ဘရောက်ဇာအတွက် ပြန်ပေးစရာ နေရာ မရှိပါ။\\n\\nGoogle မှတစ်ဆင့် Kyron အကောင့် ရှိပြီးသားဆိုလျှင် တူညီသော လိပ်စာဖြင့် အီးမေးလ်ဖြင့် ဆက်လုပ်ရန် ကို ရွေးပြီး စကားဝှက် မေ့နေပါသလား ကို နှိပ်ပါ- စကားဝှက် သတ်မှတ်ရန် လင့်ခ် ရရှိပါမည်။",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google ဝင်ရောက်မှုအတွက် ဖုန်းအက်ပ် လိုအပ်သည်"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Google ဖြင့် စာရင်းသွင်းရန်"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "လမ်းညွှန်များနှင့် အမေးများသော မေးခွန်းများ၏ အဖြေ"),
      "handle": MessageLookupByLibrary.simpleMessage("အသုံးပြုသူအမည်"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("အကူအညီနှင့် ပံ့ပိုးမှု"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("အကူအညီ စင်တာ"),
      "home": MessageLookupByLibrary.simpleMessage("ပင်မ"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("တစ်ကြောင်းတည်းဖြင့်"),
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
      "interest_add":
          MessageLookupByLibrary.simpleMessage("စိတ်ဝင်စားမှု ထည့်ရန်"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("အစီအစဉ် ပြောင်းရန် ဆွဲပါ"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "ဘားတွင် တက်ဘ် ငါးခုအထိသာ ဆံ့သည်။ နောက်တစ်ခု ထည့်ရန် တစ်ခု ဖယ်ရှားပါ။"),
      "interest_following":
          MessageLookupByLibrary.simpleMessage("ဖော်လိုလုပ်ထားသည်"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("သင့်အတွက်"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "လူများ ဟက်ရှ်တဂ်များ သုံးစတင်သောအခါ ဤနေရာတွင် ပေါ်ပါမည်။"),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("ယခု ခေတ်စားနေသည်"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("ဗီဒီယိုများ"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("သင့်တက်ဘ်များ"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
          "၎င်းသည် သင်တို့နှစ်ဦးစလုံးအတွက် ပျောက်သွားပါမည်။"),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
          "၎င်းကို ချည်တန်းမှ ဖယ်ရှားပါမည်။"),
      "join": MessageLookupByLibrary.simpleMessage("ပါဝင်ရန်"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("ဆက်ပြင်ရန်"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron မျက်နှာပြင်များသည် သင့်ဘာသာစကားဖြင့် ဖြစ်သည်။ စကားလုံးတစ်ခု မှားနေသလို ထင်ရပါက အကြံပြုချက် ပို့ရန် မှတစ်ဆင့် ပြောပြပါ။"),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("ဘာသာစကားများ"),
      "leave": MessageLookupByLibrary.simpleMessage("ထွက်ရန်"),
      "leaveCommunity": (Object a0) => "${a0} မှ ထွက်မလား။",
      "letBackIn": MessageLookupByLibrary.simpleMessage("ပြန်ဝင်ခွင့်ပေးရန်"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("စာမျက်နှာ 1 ခု ဖွင့်ထားသည်"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("ကလစ် ထည့်ရန်"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF ထည့်ရန်"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("ဟက်ရှ်တဂ် ထည့်ရန်"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံ ထည့်ရန်"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("စစ်တမ်း ထည့်ရန်"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("ဗီဒီယို ထည့်ရန်"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("စိတ်ဝင်စားမှု ထည့်ရန်"),
      "literaladdLabelAsATab": (Object a0) => "${a0} ကို တက်ဘ်အဖြစ် ထည့်ရန်",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("အက်ပ် ဘာသာစကား"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("အက်ပ် ဗားရှင်း"),
      "literalblockAuthor": (Object a0) => "${a0} ကို ပိတ်ဆို့ရန်",
      "literalblockAuthor2": (Object a0) => "${a0} ကို ပိတ်ဆို့မလား။",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("ဤအကောင့်ကို ပိတ်ဆို့မလား။"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("ပြန်စာ ပယ်ရန်"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("ထပ်စစ်ရန်"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("ပြခန်းမှ ရွေးရန်"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("ကက်ရှ် ရှင်းရန်"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("စာမျက်နှာအားလုံး ပိတ်ရန်"),
      "literalcloseTabLabel": (Object a0) => "${a0} ပိတ်ရန်",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("ဘရောက်ဇာ ပိတ်ရန်"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0} ကို ပိတ်မလား။",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("ပံ့ပိုးမှုကို ဆက်သွယ်ရန်"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("အကြောင်းအရာ ဘာသာစကားများ"),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("လင့်ခ် ကူးယူရန်"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("ပို့စ် လင့်ခ် ကူးယူရန်"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("ပို့စ် စာသား ကူးယူရန်"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("စာသား ကူးယူရန်"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "အသိုင်းအဝိုင်းများ ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF များ ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("အသိပေးချက်များ ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("အဖွဲ့ဝင်များ ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("ဤပို့စ်များကို ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("ဤစကားဝိုင်းကို ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("ဤစာရင်းကို ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("ဤပို့စ်ကို ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("ဤပြန်စာကို ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "လူကြိုက်များသော တဂ်များ ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "သင့်အသိုင်းအဝိုင်းများကို ဖွင့်၍ မရပါ"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "သင့်မက်ဆေ့ချ်များကို ဖွင့်၍ မရပါ"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "ဤအသိုင်းအဝိုင်းကို ဖွင့်၍ မရပါ"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("ပြန်စာ ပို့စ်တင်၍ မရပါ။"),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("ရှာဖွေမှု အလုပ်မလုပ်ပါ"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "ထွက်၍ မရပါ: ${a0}",
      "literalcountPagesOpen": (Object a0) => "စာမျက်နှာ ${a0} ခု ဖွင့်ထားသည်",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("မျက်နှာဖုံး ဓာတ်ပုံ"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("ဒေတာ ချွေတာရေး"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("ပို့စ် ဖျက်ရန်"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("လူများ ရှာရန်"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("ပြန်မဖြေပါနှင့်"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("မူကြမ်း သိမ်းပြီး"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage("ယခု အကြံပြုချက် ပို့၍ မရပါ"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("စာသား အရွယ်အစား"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF သတ်မှတ်မထားပါ"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("အခြားအက်ပ်သို့ ပေးရန်"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် ဖျောက်ရန်"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("ဤပို့စ်ကို ဖျောက်ရန်"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "၎င်းကို ဖျောက်ပြီး ဤကဲ့သို့ လျှော့ပြရန် တောင်းဆိုသည်"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("မည်သို့ ပြုမူရမည်"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("ဆက်ရေးရန်"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron မတုံ့ပြန်ပါ"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} ရက်စွဲ",
      "literalleaveCommunityName": (Object a0) => "${a0} မှ ထွက်မလား။",
      "literallensNameFaceLens": (Object a0) => "${a0}၊ မျက်နှာ မှန်ဘီလူး",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("လိုက်ခ်လုပ်ထားသော ပို့စ်များ"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("လင့်ခ် ကူးယူပြီး"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("ထိန်းညှိသူ ခန့်ရန်"),
      "literalmuteAuthor": (Object a0) => "${a0} ကို အသံပိတ်ရန်",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("ဤချည်တန်းကို အသံပိတ်ရန်"),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
          "စကားလုံး သို့မဟုတ် တဂ်များ အသံပိတ်ရန်"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "အသံပိတ်ထားသောနှင့် ပိတ်ဆို့ထားသော အကောင့်များ"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "အသံပိတ်ပြီး။ အသိပေးချက် ရရှိမည် မဟုတ်ပါ။"),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "ဤစက်ရှိ မည်သည့်အက်ပ်ကမျှ ${a0} လင့်ခ်များကို မဖွင့်ပါ။",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "ဤစက်ရှိ မည်သည့် ဘရောက်ဇာကမျှ လင့်ခ်ကို လက်မခံပါ။"),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("DID မရှိသေးပါ"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("မူကြမ်း မရှိပါ"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("စိတ်ဝင်စားမှု မရှိသေးပါ"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("လိုက်ခ် မရှိသေးပါ"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ် မရှိသေးပါ"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("ဖော်လိုဝါ အသစ် မရှိပါ"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("ပို့စ် မရှိသေးပါ"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("ပြန်စာ မရှိသေးပါ"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("ပြန်တင်မှု မရှိသေးပါ"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "ကိုက်ညီသော လူကြိုက်များ တဂ် မရှိပါ"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("မည်သူ့ကိုမျှ မတွေ့ပါ"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("မည်သူ့ကိုမျှ မဖယ်ရှားရသေးပါ"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("ဤနေရာတွင် မည်သူမျှ မရှိသေးပါ"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("စိတ်မဝင်စားပါ"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("ဘာမျှ မတွေ့ပါ"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("ခေတ်စား နေသည့်အရာ မရှိသေးပါ"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("မှတ်တမ်းတွင် ဘာမျှ မရှိသေးပါ"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("ကိုက်ညီမှု မရှိပါ"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("အသံပိတ်ထားသည် မရှိပါ"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("ကြည့်စရာ မရှိသေးပါ"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("မဖတ်ရသေးသည် မရှိပါ"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "ပိုင်ရှင်သာ ဤအရာကို ပြောင်းနိုင်သည်"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("ပြန်စာ ဖွင့်ရန်"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Kyron မှ အီးမေးလ်ကို ဖွင့်ပါ"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("စကားဝှက်နှင့် ဝင်ရောက်မှု"),
      "literalpostInCommunityName": (Object a0) => "${a0} တွင် ပို့စ်တင်ရန်",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "${a0} တွင် ပို့စ်တင်ရန်",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "အပေါ်တွင် ကိုယ်ပိုင်စကားဖြင့် ပို့စ်တင်ပါ"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("အဓိက ဘာသာစကား"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("ပုရှ် အသိပေးချက်များ"),
      "literalreading": MessageLookupByLibrary.simpleMessage("စစ်နေသည်…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("အသံပို့စ် မှတ်တမ်းတင်ရန်"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("ထပ်မှတ်တမ်းတင်ရန်"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("ထိန်းညှိသူမှ ဖယ်ရှားရန်"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်းမှ ဖယ်ရှားရန်"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("သိမ်းထားသည်မှ ဖယ်ရှားရန်"),
      "literalremoveLabel": (Object a0) => "${a0} ဖယ်ရှားရန်",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0} ဖယ်ရှားရန်",
      "literalremoveMemberDisplayname": (Object a0) => "${a0} ကို ဖယ်ရှားမလား။",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("စစ်တမ်း ဖယ်ရှားရန်"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("ဤအဖြေကို ဖယ်ရှားရန်"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("ဤစကားဝိုင်းကို ဖျက်ရန်"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("ဤစစ်တမ်းကို ဖယ်ရှားရန်"),
      "literalreportAuthor": (Object a0) => "${a0} ကို တိုင်ကြားရန်",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("ပို့စ်ကို တိုင်ကြားရန်"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("ကုဒ် ပြန်ပို့ရန်"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("သိမ်းထားသော ပို့စ်များ"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("တစ်ခုခု ပြောပါ"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "${a0} တွင် တစ်ခုခု ပြောပါ",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("ရှာဖွေမှု မအောင်မြင်ပါ"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("ပြန်ပို့ရန်"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "${a0} စက္ကန့်အတွင်း ပြန်ပို့ရန်",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("အကြံပြုချက် ပေးရန်"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("လင့်ခ် ပို့ရန်"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "ပို့ပြီးပါပြီ။ ၎င်းမှာ အစီရင်ခံစာ #${a0} ဖြစ်သည်။",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "စကားဝှက် သတ်မှတ်ပြီး ဆက်လုပ်ပါ"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "မှတ်တမ်းကို ပံ့ပိုးမှုနှင့် မျှဝေရန်"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("ဤအသိုင်းအဝိုင်းကို မျှဝေရန်"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("ဤစာမျက်နှာကို မျှဝေရန်"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("ဤပရိုဖိုင်ကို မျှဝေရန်"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("မျှဝေရန်…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("ကိုးကားချက်ဖြင့် မျှဝေရန်"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("ဤကဲ့သို့ ပိုပြရန်"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် ပြရန်"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("ရလဒ်များ ပြရန်"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်း စတင်ရန်"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("မှတ်တမ်းတင်ခြင်း စတင်ရန်"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("ဖွင့်ခြင်း ရပ်ရန်"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "ဤပို့စ်နှင့် ၎င်း၏ ပြန်စာများကို မမြင်တော့ရန်"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "စတိုရီ တန်း၊ ${a0} ခု",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("ကင်မရာ ပြောင်းရန်"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("တစ်စုံတစ်ယောက်ကို တဂ်လုပ်ရန်"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံ ရိုက်ရန်"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "ပြောင်းရန် နဖူးစည်း သို့မဟုတ် ဓာတ်ပုံကို နှိပ်ပါ"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("၎င်းထဲရှိ လင့်ခ်ကို နှိပ်ပါ"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "ဓာတ်ပုံနှင့် မျက်နှာဖုံး ထည့်ရန် နှိပ်ပါ"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("မအောင်မြင်ပါ။ ထပ်ကြိုးစားပါ။"),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("ထို GIF ကို ဖွင့်၍ မရပါ။"),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "ဤလင့်ခ်ကို ဤနေရာတွင် ဖွင့်၍ မရပါ။"),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("ကင်မရာ ပိတ်ထားသည်"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("ဤအသိုင်းအဝိုင်း"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("ဤပြန်စာ မရှိတော့ပါ"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("ပို့စ် ဘာသာပြန်ရန်"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("အသံပိတ်ရန်"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("အသံဖွင့်ရန်"),
      "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage(
          "ကျွန်ုပ်တို့ထံမှ တစ်ခု သုံးရန်"),
      "literalverificationCodeResent":
          MessageLookupByLibrary.simpleMessage("အတည်ပြုကုဒ် ပြန်ပို့ပြီး။"),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "အတည်ပြု၍ မရပါ: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("အီးမေးလ် အတည်ပြုရန်"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "ကြည့်ရှုသူ၊ လိုက်ခ်၊ သိမ်းမှုနှင့် မှတ်ချက်များ"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kyron ဘာသိမ်းထားသလဲ"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("ဤအက်ပ် ဘာလုပ်နေခဲ့သလဲ"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "သင်ဘာလုပ်ခဲ့သလဲ၊ ဘာမျှော်လင့်ခဲ့သလဲ၊ ဘာဖြစ်ခဲ့သလဲ "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("သင်တင်သည့်အရာ သင့်ပိုင်"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Kyron ယခု ချိတ်ဆက်နိုင်မနိုင်"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("မည်သူ ပြန်စာရေးနိုင်သလဲ"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("မည်သူ့ကို တဂ်လုပ်လိုသလဲ။"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "လူကြိုက်များသော တဂ်အားလုံးကို ဖော်လိုလုပ်ပြီးပါပြီ"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("အားလုံးကို ကြည့်ပြီးပါပြီ"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "သင် မည်သည့်အသိုင်းအဝိုင်းတွင်မျှ မရှိပါ"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("သင် ထွက်ပြီးပါပြီ။"),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) =>
          "သင် ${a0} မှ ထွက်ခဲ့သည်",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("သင် ဘာမျှ ပို့စ်မတင်ရသေးပါ"),
      "loadMore": MessageLookupByLibrary.simpleMessage("ထပ်ဖွင့်ရန်"),
      "logCleared": MessageLookupByLibrary.simpleMessage("မှတ်တမ်း ရှင်းပြီး"),
      "logCopied": MessageLookupByLibrary.simpleMessage("မှတ်တမ်း ကူးယူပြီး"),
      "logIn": MessageLookupByLibrary.simpleMessage("ဝင်ရန်"),
      "logOut": MessageLookupByLibrary.simpleMessage("ထွက်ရန်"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("ထွက်မလား။"),
      "login": MessageLookupByLibrary.simpleMessage("ဝင်ရောက်မှု"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "ဝင်၍ မရပါ။ သင့်အချက်အလက်များကို စစ်ပါ။"),
      "manage": MessageLookupByLibrary.simpleMessage("စီမံရန်"),
      "menu": MessageLookupByLibrary.simpleMessage("မီနူး"),
      "message": MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်"),
      "messages": MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်များ"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "စကားဝိုင်းအားလုံးကို ဖတ်ပြီးပါပြီ။"),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "တစ်စုံတစ်ယောက်၏ ပရိုဖိုင်ကို ဖွင့်ပြီး စကားဝိုင်း စတင်ရန် မက်ဆေ့ချ် ကို နှိပ်ပါ။"),
      "mute": MessageLookupByLibrary.simpleMessage("အသံပိတ်ရန်"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
          "အသံပိတ်ထားသူများနှင့် ပိတ်ဆို့ထားသူများ"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
          "အသံပိတ်ထားသော စကားလုံးနှင့် တဂ်များ"),
      "name": MessageLookupByLibrary.simpleMessage("အမည်"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> မျက်နှာပြင်"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("အီးမေးလ် လိပ်စာ အသစ်"),
      "newPassword": MessageLookupByLibrary.simpleMessage("စကားဝှက် အသစ်"),
      "newPost": MessageLookupByLibrary.simpleMessage("ပို့စ်အသစ်"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("ယခု မဟုတ်"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "မပို့ရသေးပါ။ ထပ်ကြိုးစားရန် နှိပ်ပါ"),
      "nothingMatchesQuery": (Object a0) =>
          "Kyron တွင် \"${a0}\" နှင့် ကိုက်ညီသည် မရှိပါ",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("ကူးယူစရာ မရှိပါ"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "လိုက်ခ်များ၊ ပြန်စာများနှင့် ဖော်လိုဝါအသစ်များ ဤနေရာသို့ ရောက်လာသည်။"),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "သင့်ကို ဖော်လိုလုပ်သူများ ဤနေရာတွင် ပေါ်ပါမည်။"),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "တစ်စုံတစ်ယောက်က သင့်ပို့စ်ကို လိုက်ခ်လုပ်သောအခါ ဤနေရာတွင် ပေါ်ပါမည်။"),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "သင့်ပို့စ်များအတွက် ပြန်စာများ ဤနေရာသို့ ရောက်လာသည်။"),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "တစ်စုံတစ်ယောက်က သင့်ကို ပြန်တင်သောအခါ ဤနေရာတွင် ပေါ်ပါမည်။"),
      "notifications": MessageLookupByLibrary.simpleMessage("အသိပေးချက်များ"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("ဘရောက်ဇာတွင် ဖွင့်ရန်"),
      "or": MessageLookupByLibrary.simpleMessage("သို့မဟုတ်"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("စာမျက်နှာ မတွေ့ပါ"),
      "password": MessageLookupByLibrary.simpleMessage("စကားဝှက်"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် တိုလွန်းသည်"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("သင့်စိတ်ဝင်စားမှုများ ရွေးပါ"),
      "post": MessageLookupByLibrary.simpleMessage("ပို့စ်တင်ရန်"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("ပို့စ် စာရင်းအင်း"),
      "postInCommunity": (Object a0) => "${a0} တွင် ပို့စ်တင်ရန်",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("ပို့စ်တင်ပါ၊ ပြောပါ၊ ပြပါ။"),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("ပို့စ် စာသား ကူးယူပြီး"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("ကိုယ်ရေးအချက်အလက် မူဝါဒ"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("ပရိုဖိုင် အပ်ဒိတ်လုပ်ပြီး"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("ကိုယ်ရေးအကျဉ်း"),
      "profile_country": MessageLookupByLibrary.simpleMessage("နိုင်ငံ"),
      "profile_display_name": MessageLookupByLibrary.simpleMessage("ပြသအမည်"),
      "profile_location": MessageLookupByLibrary.simpleMessage("တည်နေရာ"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("ပြောင်းရန် နှိပ်ပါ"),
      "profile_website": MessageLookupByLibrary.simpleMessage("ဝဘ်ဆိုက်"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("ပုရှ် အသိပေးချက်များ"),
      "quote": MessageLookupByLibrary.simpleMessage("ကိုးကားရန်"),
      "quotePost": MessageLookupByLibrary.simpleMessage("ပို့စ်ကို ကိုးကားရန်"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("လူနှင့် ဆက်သွယ်ရန်"),
      "remove": MessageLookupByLibrary.simpleMessage("ဖယ်ရှားရန်"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("ဤစကားဝိုင်းကို ဖျက်မလား။"),
      "removeMember": (Object a0) => "${a0} ကို ဖယ်ရှားမလား။",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("ဤမက်ဆေ့ချ်ကို ဖျက်မလား။"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "ပြန်စာများ၊ ဖော်လိုများနှင့် ဖော်ပြချက်များ"),
      "repliesPolicy": (Object a0) => "ပြန်စာများ: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("ပြန်စာရေးရန်"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("မည်သူမဆို ပါဝင်နိုင်သည်"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "မည်သူမဆို ဤပို့စ်ကို ကြည့်၊ ပြန်တင်နှင့် ကိုးကားနိုင်ဆဲ ဖြစ်သည်။"),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron ရှိ မည်သူမဆို ဤပို့စ်ကို ပြန်စာရေးနိုင်သည်။"),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("သင့်ကို ဖော်လိုလုပ်သူများ"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "သင့်ကို ဖော်လိုလုပ်သူများသာ ဤပို့စ်ကို ပြန်စာရေးနိုင်သည်။"),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("သင်ဖော်ပြသူများ"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "ဤပို့စ်တွင် သင် @ဖော်ပြသူများသာ ပြန်စာရေးနိုင်သည်။"),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("မည်သူမျှ ပြန်စာမရေးနိုင်ပါ"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "ပြန်စာများ ပိတ်ထားသည်။ သင်ကိုယ်တိုင် ပြန်စာရေးနိုင်ဆဲ ဖြစ်သည်။"),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("မည်သူ ပြန်စာရေးနိုင်သလဲ။"),
      "report": MessageLookupByLibrary.simpleMessage("တိုင်ကြားရန်"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "အစီရင်ခံစာ ကူးယူပြီး။ ပံ့ပိုးမှုထံ ပို့မည့် အီးမေးလ်တွင် ကပ်ပါ။"),
      "reportSent":
          MessageLookupByLibrary.simpleMessage("တိုင်ကြားချက် ပို့ပြီးပါပြီ"),
      "repost": MessageLookupByLibrary.simpleMessage("ပြန်တင်ရန်"),
      "reset": MessageLookupByLibrary.simpleMessage("ပြန်သတ်မှတ်ရန်"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("သင့်စကားဝှက် ပြန်သတ်မှတ်ပါ"),
      "retry": MessageLookupByLibrary.simpleMessage("ထပ်ကြိုးစားရန်"),
      "save": MessageLookupByLibrary.simpleMessage("သိမ်းရန်"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("မူကြမ်း သိမ်းရန်"),
      "saySomething": (Object a0) => "${a0} တွင် တစ်ခုခု ပြောပါ",
      "search": MessageLookupByLibrary.simpleMessage("ရှာရန်"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "အမည် သို့မဟုတ် အသုံးပြုသူအမည်ဖြင့် ရှာရန်"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်းများ ရှာရန်"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF ရှာရန်"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("ဘာသာစကားများ ရှာရန်"),
      "searchTrendingTags": MessageLookupByLibrary.simpleMessage(
          "လူကြိုက်များသော တဂ်များ ရှာရန်"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "လုံခြုံရေး သတိပေးချက်များနှင့် အကောင့် ပြောင်းလဲမှုများ"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "အက်ပ် မျက်နှာပြင်၏ ဘာသာစကားကို ရွေးပါ။"),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "သင့်ဖိဒ်များတွင် ပေါ်မည့် ဘာသာစကားများကို ရွေးပါ။ မရွေးပါက ဘာသာစကားအားလုံး ပြပါမည်။"),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "ဖိဒ်ရှိ ဘာသာပြန်ချက်များအတွက် အဓိက ဘာသာစကားကို ရွေးပါ။"),
      "send": MessageLookupByLibrary.simpleMessage("ပို့ရန်"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("အတည်ပြုချက် ပို့ရန်"),
      "sendErrorReport": MessageLookupByLibrary.simpleMessage(
          "ချို့ယွင်းချက် အစီရင်ခံစာ ပို့ရန်"),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("အကြံပြုချက် ပို့ရန်"),
      "sendReport":
          MessageLookupByLibrary.simpleMessage("တိုင်ကြားချက် ပို့ရန်"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("ပံ့ပိုးမှုထံ ပို့ရန်"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("ဝန်ဆောင်မှု အခြေအနေ"),
      "settings": MessageLookupByLibrary.simpleMessage("ဆက်တင်များ"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "အက်ပ် မှတ်တမ်းကို ပံ့ပိုးမှုနှင့် မျှဝေရန်"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Kyron သို့ ဝင်ရန်"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("ဤအဖြစ် ဝင်ထားသည်"),
      "signupFailed": (Object a0) => "စာရင်းသွင်း၍ မရပါ: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("နေရန်"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron သည် စတင်ခါစ ဖြစ်ပြီး ၎င်းကို အမှန်တကယ် ပြင်ပေးနိုင်သူထံ အမြန်ဆုံး ရောက်ရန်နည်းမှာ လက်မှတ်ဖွင့်ခြင်း ဖြစ်သည်။ သင်ဘာလုပ်နေခဲ့သလဲ၊ ဘာဖြစ်ခဲ့သလဲ ပြောပြပါ။"),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "အက်ပ်တွင် ပံ့ပိုးမှု ဝင်စာပုံး မရှိသေးသောကြောင့် ဤမျက်နှာပြင်သည် ဘယ်မှမရောက်သော ဖောင်အစား အမှန်တကယ် စောင့်ကြည့်သော နေရာသို့ ညွှန်ပြသည်။"),
      "systemLog": MessageLookupByLibrary.simpleMessage("အက်ပ် မှတ်တမ်း"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "ဘာလိုနေသလဲ သို့မဟုတ် ဘာပျက်နေသလဲ ပြောပါ"),
      "terms":
          MessageLookupByLibrary.simpleMessage("ဝန်ဆောင်မှု စည်းမျဉ်းများ"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "စာသား၊ အသံနှင့် ဗီဒီယို၊ ၎င်းတို့ကို ဖန်တီးသူများနှင့် သူတို့ စကားပြောကြသော အခန်းများ။"),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "တည်းဖြတ်ကိရိယာတွင် ပို့စ်တင် ခလုတ် မရှိပါ"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("အမှောင်"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("အမြဲ အမှောင်"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("မှိန်"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "ပိုနူးညံ့သော အမှောင်၊ အနက်အစား အပြာရောင်သန်း မီးခိုး"),
      "theme_light": MessageLookupByLibrary.simpleMessage("အလင်း"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("အမြဲ အလင်း"),
      "theme_system": MessageLookupByLibrary.simpleMessage("စနစ်"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "ဖုန်း၏ အလင်း သို့မဟုတ် အမှောင် ဆက်တင်အတိုင်း"),
      "translate": MessageLookupByLibrary.simpleMessage("ဘာသာပြန်ရန်"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "ဘာသာပြန်ခြင်း မဖွင့်ရသေးပါ။ သင့်ဖိဒ်တွင် ဘာမျှ ဘာသာမပြန်ရသေးပါ၊ ထိုအချိန်အထိ မှတ်ထားပါမည်။"),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "ဤအရာသည် Kyron ၏ ကိုယ်ပိုင်စကားလုံးများ၊ Flutter ကိုယ်တိုင် ဆွဲသော မျက်နှာပြင် အစိတ်အပိုင်းများ၊ ရက်စွဲနှင့် ဂဏန်းများနှင့် ညာမှဘယ်သို့ ရေးသော ဘာသာစကားများအတွက် အက်ပ် အပြင်အဆင် လမ်းကြောင်းကို ပြောင်းသည်။"),
      "tryAgain": MessageLookupByLibrary.simpleMessage("ထပ်စမ်းကြည့်ရန်"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("ကိုယ်ရေးအချက်အလက် မူဝါဒ"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("ဝန်ဆောင်မှု စည်းမျဉ်းများ"),
      "ui_account": MessageLookupByLibrary.simpleMessage("အကောင့်"),
      "ui_after": MessageLookupByLibrary.simpleMessage("ပြီးနောက်"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("အက်ပ်နှင့် စက်"),
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
      "ui_appearance": MessageLookupByLibrary.simpleMessage("အသွင်အပြင်"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "အလင်း၊ အမှောင် သို့မဟုတ် ဖုန်းအတိုင်း"),
      "ui_before": MessageLookupByLibrary.simpleMessage("မတိုင်မီ"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron တွင် သင်တို့ တစ်ဦးကိုတစ်ဦး မမြင်ရတော့ဘဲ သင်တို့ကြားရှိ ဖော်လိုများကို ဖယ်ရှားပါမည်။ ၎င်းတို့ကို အသိမပေးပါ။"),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("ပါဝင်သည်"),
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
      "ui_communities":
          MessageLookupByLibrary.simpleMessage("အသိုင်းအဝိုင်းများ"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("ဘာအတွက်လဲ။ (ရွေးချယ်နိုင်)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("ပို့စ်များ-"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("အကြောင်းအရာနှင့် ပြသမှု"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("သင့်ဖိဒ်ကို ဖွင့်၍ မရပါ"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "လိုက်ခ်လုပ်ထားသော ပို့စ်များကို ဖွင့်၍ မရပါ"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("သင့်ပရိုဖိုင်ကို ဖွင့်၍ မရပါ"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "သိမ်းထားသော ပို့စ်များကို ဖွင့်၍ မရပါ"),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage("ဗဟိုမဲ့ ID"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("ပြဿနာဖြေရှင်းခြင်း"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("အဖွဲ့များ"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("အဖွဲ့ မရှိပါ"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "သင်ပါဝင်သော အဖွဲ့များနှင့် သင်ဝင်ရောက်သော အသိုင်းအဝိုင်း ချက်တ်များကို ဤနေရာတွင် ပြသည်။"),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "ချတ်များကို \$count ခုအထိ ပင်ထိုးနိုင်သည်။ တစ်ခုကို အရင် ပင်ဖြုတ်ပါ။"),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("ပင်ထိုးထားသည်"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("နှစ်သက်သည်"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("သိမ်းထားသည်"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("ဤနေရာတွင် ဘာမျှ မရှိသေးပါ"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "အကောင့်အချို့ကို ဖော်လိုလုပ်ပါ၊ ၎င်းတို့၏ ပို့စ်များ ဤနေရာတွင် ပေါ်ပါမည်။"),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "သင်ဖော်လိုလုပ်ထားသူများထံမှ ဘာမျှ မရှိပါ"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "လူများ ရေးသားသည်နှင့်အမျှ ပို့စ်များ ဤနေရာတွင် ပေါ်ပါမည်။"),
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
          "ကလစ်ပါသော ပို့စ်များ ဤနေရာတွင် ပေါ်ပါမည်။"),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("ဗီဒီယို မရှိသေးပါ"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("အကြံပြုချက်"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Kyron တွင် လူများ ရှာပါ"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("အကောင့်တစ်ခုမှ"),
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
      "ui_help": MessageLookupByLibrary.simpleMessage("အကူအညီ"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "မှတ်သားပြီး။ ၎င်းသည် သင့်ကို ဘာပြရမည် ရွေးရာတွင် ကူညီသည်။"),
      "ui_join": MessageLookupByLibrary.simpleMessage("ပါဝင်ရန်"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("ပါဝင်ခဲ့သည်"),
      "ui_language": MessageLookupByLibrary.simpleMessage("ဘာသာစကား"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("သင့်ဘာသာစကားကို ရွေးပါ"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("ဥပဒေဆိုင်ရာ"),
      "ui_like": MessageLookupByLibrary.simpleMessage("လိုက်ခ်"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("လိုက်ခ်လုပ်ထားသော ပို့စ်များ"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "သင်လိုက်ခ်လုပ်ထားသော ပို့စ်များ ဤနေရာတွင် ပေါ်သည်၊ အသစ်ဆုံး အရင်။"),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("လင့်ခ် ကူးယူပြီး"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "၎င်းတို့၏ ပို့စ်များကို မမြင်ရတော့ပါ။ ၎င်းတို့ကို အသိမပေးပါ။"),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("လိုက်ခ် မရှိသေးပါ"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "ထိုစစ်ထုတ်မှုများနှင့် ကိုက်ညီသော ပို့စ် မရှိပါ။"),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("သိမ်းထားသည် မရှိသေးပါ"),
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
          MessageLookupByLibrary.simpleMessage("ပြီးပါပြီ"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("ကျော်ရန်"),
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
      "ui_pause": MessageLookupByLibrary.simpleMessage("ခဏရပ်"),
      "ui_play": MessageLookupByLibrary.simpleMessage("ဖွင့်ရန်"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "၎င်းကို သင့်ပရိုဖိုင်နှင့် လူတိုင်း၏ ဖိဒ်များမှ ဖယ်ရှားပါမည်။ ၎င်း၏ ပြန်စာများလည်း ၎င်းနှင့်အတူ ပါသွားမည်။"),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("ပို့စ် ဖျက်ပြီး"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("ပို့စ် ဖျောက်ပြီး"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("ပို့စ် စာသား ကူးယူပြီး"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("ကြားတွင် တင်ခဲ့သည်"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "ဖျောက်ပြီး။ ဤကဲ့သို့ လျှော့ပြပါမည်။"),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("ရွေးချယ်မှုများ"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("ကိုယ်ရေးအချက်အလက်"),
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
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("သိမ်းထားသော ပို့စ်များ"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "ပို့စ်ကို ဤနေရာတွင် ထားရန် ၎င်း၏ မှတ်တမ်းတိုက် အိုင်ကွန်ကို နှိပ်ပါ။ သိမ်းထားသည်များကို သင်သာ မြင်ရသည်။"),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "အသုံးပြုသူအမည် သို့မဟုတ် ပြသအမည်ဖြင့် ရှာပါ။"),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("ရှင်းရန်"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("တင်ထားသမျှတွင် ရှာရန်"),
      "ui_search_filters":
          MessageLookupByLibrary.simpleMessage("စစ်ထုတ်မှုများ"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("လူများ ရှာရန်"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("ပို့စ်များ ရှာရန်"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("ဆက်တင်များ"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("အက်ပ်နှင့် စက်"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("အကြောင်းအရာနှင့် ပြသမှု"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("ဒေတာ ချွေတာရေး"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("သင့်အမြင် မျှဝေပါ"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("အကူအညီ ဆောင်းပါးများ ကြည့်ရန်"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("သင့်ဘာသာစကား ရွေးပါ"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "သင် အသံပိတ်ထား သို့မဟုတ် ပိတ်ဆို့ထားသူများ"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("အသိပေးချက် ရွေးချယ်မှုများ"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "သင့်ပရိုဖိုင်နှင့် ဆက်သွယ်ရန် အချက်အလက်"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "သင့်အကောင့်သို့ ပြန်ဝင်ရန် ထပ်မံ ဝင်ရောက်ရပါမည်။"),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("လုံခြုံရေး ဆက်တင်များ"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် အတည်ပြုပါ"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("တစ်ကြောင်းတည်းဖြင့်"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("အီးမေးလ် လိပ်စာ အသစ်"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် အသစ်"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("ဘာဖြစ်ခဲ့သလဲ"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "ကျွန်ုပ်တို့အဖွဲ့ထံမှ အကူအညီ ရယူပါ"),
      "ui_share": MessageLookupByLibrary.simpleMessage("မျှဝေရန်"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("ကိုးကားရန်"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("မက်ဆေ့ချ်ဖြင့် ပို့ရန်"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron ရှိ လူများထံ"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("ဤပို့စ်ကို မျှဝေရန်"),
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
      "ui_terms":
          MessageLookupByLibrary.simpleMessage("ဝန်ဆောင်မှု စည်းမျဉ်းများ"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ဤပို့စ်"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("ချည်တန်း အသံပိတ်ပြီး"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("ထပ်စမ်းကြည့်ရန်"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("အသံပိတ်ရန်"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("အသံဖွင့်ရန်"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("အနည်းဆုံး စာလုံးနှစ်လုံး။"),
      "ui_undo": MessageLookupByLibrary.simpleMessage("ပြန်ဖျက်ရန်"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "စကားလုံးများ သို့မဟုတ် စစ်ထုတ်မှု- အကောင့်၊ ရက်စွဲ အပိုင်းအခြား သို့မဟုတ် ပို့စ်တွင် ပါဝင်သည့်အရာ။"),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("ပြန်တင်မှု ပယ်ဖျက်ရန်"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("စကားဝှက် အပ်ဒိတ်လုပ်ရန်"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("အခြားလိပ်စာ သုံးရန်"),
      "username": MessageLookupByLibrary.simpleMessage("အသုံးပြုသူအမည်"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "အသုံးပြုသူအမည်သည် စာလုံးအသေး ဖြစ်ရမည် (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("ဗီဒီယို"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("ပူးတွဲရန်"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("ပူးတွဲရန် အသင့်"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("အသံပို့စ် မှတ်တမ်းတင်ရန်"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("သိမ်းနေသည်…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("ရပ်ရန်"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("ဘာဖြစ်ခဲ့သလဲ"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "ဘာဖြစ်ခဲ့သနည်း၊ ကျွန်ုပ်တို့ ဘာကို ကြည့်သင့်သနည်း။",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("ဤပုံတွင် ဘာရှိသလဲ။"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("ဘာအတွက်လဲ။ (ရွေးချယ်နိုင်)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "သင်ဘာလုပ်ခဲ့သလဲ၊ ဘာမျှော်လင့်ခဲ့သလဲ၊ ဘာဖြစ်ခဲ့သလဲ"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "ထိုသို့ဖြစ်စဉ် သင်ဘာလုပ်နေခဲ့သလဲ။"),
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
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("ဖော်လိုဝါ"),
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
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("ထိုမှန်ဘီလူးကို ဖွင့်၍မရပါ။"),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("ဗီဒီယိုကို ရိုက်ကူး၍မရပါ။"),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "ဤဗီဒီယိုတွင် မှန်ဘီလူး ထည့်၍မရသဖြင့် ရိုက်ထားသည့်အတိုင်း တင်ပါမည်။"),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "သင့်ပို့စ်တွင် ပူးတွဲဖိုင် အများဆုံးအရေအတွက် ရှိနေပြီ။"),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("သင့်မှန်ဘီလူးကို ထည့်နေသည်…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("ဖလက်ရှ်"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("ဗီဒီယို ရိုက်ရန်"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("ဓာတ်ပုံ"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("ဗီဒီယို"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Google ဖြင့် ဝင်ရောက်ခြင်းကို ပယ်ဖျက်ခဲ့သည်။"),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("လက်ဆောင်များ"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "ဤပို့စ်ကို မည်သူမျှ လက်ဆောင် မပို့ရသေးပါ။"),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("လက်ဆောင်"),
      "analytics_gifts_label":
          MessageLookupByLibrary.simpleMessage("လက်ဆောင်များ"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("ဒင်္ဂါးများ"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("ပို့သူ"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("ပို့သူများ"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "စမ်းသပ်ဒင်္ဂါးများ- ယခု ငွေထုတ်၍ မရသေးပါ။"),
      "ui_saved": MessageLookupByLibrary.simpleMessage("သိမ်းထားသည်"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("ပို့စ်များ"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("မှတ်ချက်များ"),
      "ui_view_more_replies": MessageLookupByLibrary.simpleMessage(
          "နောက်ထပ် အကြောင်းပြန်ချက်များ ကြည့်ရန်"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("တည်းဖြတ်ထားသည်"),
      "ui_more": MessageLookupByLibrary.simpleMessage("ပိုမို"),
      "ui_following": MessageLookupByLibrary.simpleMessage("ဖော်လိုလုပ်ထားသည်"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("ထိပ်တန်း"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("နောက်ဆုံး"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("မှတ်ချက်များ စီရန်- \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "က သင့်ပို့စ်ကို လက်ဆောင် ပို့ခဲ့သည်"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "က သင့်မှတ်ချက်ကို \$gift ပို့ခဲ့သည်"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "က သင့်ပို့စ်ကို \$gift ပို့ခဲ့သည်"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("လက်ဆောင် ပို့ရန်"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("ပို့စ် တည်းဖြတ်ရန်"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "နောက်ထပ် \$n မိနစ် တည်းဖြတ်နိုင်သည်"),
      "ui_save": MessageLookupByLibrary.simpleMessage("သိမ်းရန်"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "#\$tab အောက်တွင် ဘာမျှ မတင်ရသေးပါ။"),
      "ui_gift_pick":
          MessageLookupByLibrary.simpleMessage("လက်ဆောင်တစ်ခု ရွေးပါ"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("ဒင်္ဂါး မလုံလောက်ပါ"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "စမ်းသပ်ဒင်္ဂါးများ- ဝယ်၍မရ၊ ငွေတန်ဖိုး မရှိပါ။"),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("\$date တွင် ပြန်ဖြည့်မည်။"),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("ဒင်္ဂါး 1 ခု"),
      "ui_gift_coins":
          MessageLookupByLibrary.simpleMessage("ဒင်္ဂါး \$count ခု"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("သင့်တွင် \$coins ရှိသည်"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift ပို့ရန်"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift ပို့ပြီး"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("ထပ်စမ်းကြည့်ပါ"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("တင်ပြီးနောက် မိနစ် 15 အတွင်း"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("တည်းဖြတ်ပြီး"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "သိမ်းထားသော မှတ်ချက်များကို ဖွင့်၍မရပါ"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("သိမ်းထားသော မှတ်ချက် မရှိပါ"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "မှတ်ချက်ကို ဤနေရာတွင် ထားရန် ၎င်းအောက်ရှိ မော်ကွန်းအိုင်ကွန်ကို တို့ပါ။ သင်သိမ်းသည်ကို သင်သာ မြင်ရသည်။"),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("\$name ကို အကြောင်းပြန်နေသည်"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("ကူးယူရန်"),
      "ui_search": MessageLookupByLibrary.simpleMessage("ရှာရန်"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("အားလုံး ရွေးရန်"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("လက်ဆောင် \$count ခု"),
      "ui_gifts_count_one":
          MessageLookupByLibrary.simpleMessage("လက်ဆောင် 1 ခု"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "နောက်ထပ် ပို့စ်များ ဖွင့်၍မရပါ။"),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("သတိပေးချက်များ"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "သင်မရှိစဉ် ဘာအသစ်ရှိလဲ၊ သင့်ဒင်္ဂါးများ ပြန်ရောက်ချိန်။ တစ်ရက်လျှင် တစ်ခုထက် ပိုမပို့ပါ။"),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("လက်ဆောင်များ"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("လူ 1 ဦးထံမှ"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("လူ \$count ဦးထံမှ"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("အများဆုံးပေးသူ"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "လက်ဆောင်ပို့သူများကို ဖွင့်၍မရပါ။"),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("အသစ်များ"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("နားလည်ပြီ"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "ကျေးဇူးတင်ပါသည်။ အဖြေတိုင်းကို ဖတ်ပါသည်။"),
      "ui_check_in_title": MessageLookupByLibrary.simpleMessage(
          "Kyron ကို ယခုထိ ဘယ်လိုသဘောရလဲ။"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "သင့်စမ်းသပ်မှု၏ \$day ရက်မြောက်နေ့။ တစ်ချက်နှိပ်ရုံ လုံလောက်ပါသည်။"),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "ပြင်ရန် သို့မဟုတ် ထည့်ရန် ရှိပါသလား။ (ရွေးချယ်ခွင့်)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("ပို့ရန်"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("နောက်မှ"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Kyron မှ ထွက်ရန် နောက်သို့ ထပ်နှိပ်ပါ"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("သင်ဖြစ်ကြောင်း အတည်ပြုပါ"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "အကောင့်ကို ဖျက်ရန် စကားဝှက်ထည့်ပါ။"),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "အကောင့်ကို ဖျက်ရန် Google ဖြင့် ထပ်မံဝင်ပါ။"),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "မအောင်မြင်ပါ။ စစ်ဆေးပြီး ထပ်ကြိုးစားပါ။"),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "ဤစာမျက်နှာသည် အခြားအက်ပ်ကို ဖွင့်လိုသည်"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "{scheme} လင့်ခ်ကို ဖွင့်ရန် တောင်းဆိုနေသည်။"),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("တည်ဆောက်မှု"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "ကက်ရှ်ထဲရှိ ပုံနှင့်ဖိုင် {size}"),
      "ui_about_freed":
          MessageLookupByLibrary.simpleMessage("{size} ရှင်းလိုက်ပြီ"),
      "ui_about_measuring":
          MessageLookupByLibrary.simpleMessage("တိုင်းနေသည်…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("ရှင်းစရာ မရှိပါ"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("သိုလှောင်မှု"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("ဗားရှင်း {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("ပိတ်ထားသူများ"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("သင့်အမည်ဖြင့် ပို့စ်တင်နေသည်"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "ထိုပူးတွဲဖိုင်များ အပ်လုဒ်မလုပ်ရပါ။ ထပ်စမ်းရန် တစ်ခုကို နှိပ်ပါ၊ သို့မဟုတ် ဖယ်ရှားပါ။"),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "သင့်အီးမေးလ်ကို ပြောင်း၍မရပါ။ ထပ်စမ်းကြည့်ပါ။"),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "ကျွန်ုပ်တို့ပို့သော လင့်ခ်ကို ဖွင့်လိုက်သည့်အခါ သင့်လိပ်စာ ပြောင်းပါမည်။"),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "အတည်ပြုလင့်ခ်အတွက် {email} ကို စစ်ကြည့်ပါ။"),
      "ui_email_enter":
          MessageLookupByLibrary.simpleMessage("အီးမေးလ်လိပ်စာ ထည့်ပါ။"),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage(
          "ထိုအရာသည် အီးမေးလ်လိပ်စာနှင့် မတူပါ။"),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "၎င်းသည် သင့်အီးမေးလ်လိပ်စာ ဖြစ်ပြီးသားပါ။"),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "သင်ဘာလုပ်ခဲ့သည်၊ ဘာမျှော်လင့်ခဲ့သည်၊ အစား ဘာဖြစ်ခဲ့သည်။"),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "ကျွန်ုပ်၏ ပရိုဖိုင်တွင် ပို့စ်တစ်ခု ပင်ထိုးခွင့်ပေးပါ"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "သင်ဘာလိုချင်သည်၊ ၎င်းက သင့်ကို ဘာလုပ်နိုင်စေမည်။"),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("ဘာက အထောက်အကူဖြစ်မည်"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("ပြဿနာ"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("အကြံ"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("မေးခွန်း"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "ဤအရာကို Kyron အဖွဲ့သာ ဖတ်ပါသည်။ အီးမေးလ်ဖြင့် ပြန်ကြားနိုင်ရန် သင့်အကောင့်နှင့်အတူ၊ သင်သုံးသော အက်ပ်ဗားရှင်းနှင့်အတူ ပို့ပါသည်။ အကောင့်ဖျက်လျှင် ဤအရာလည်း ပျက်ပါမည်။"),
      "ui_feedback_question_example": MessageLookupByLibrary.simpleMessage(
          "စကားလုံးတစ်လုံးကို ဘယ်လို အသံပိတ်မလဲ?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "သင်ဘာလုပ်ရန် ကြိုးစားနေသည်၊ ဘယ်နေရာတွင် ပိတ်မိနေသည်။"),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("သင့်မေးခွန်း"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "Kyron ကို ချိတ်ဆက်၍မရပါ။ ချိတ်ဆက်မှုကို စစ်ပြီး ထပ်စမ်းပါ။ ဘာမှ မရေးရသေးသဖြင့် ဘာမှ မဆုံးရှုံးပါ။"),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("ရှင်းမည်"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "မအောင်မြင်သော တောင်းဆိုမှုများနှင့် အခြားထူးခြားသော ဖြစ်ရပ်များ ဤနေရာတွင် ပေါ်ပါသည်။"),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("အသံပိတ်ထားသူများ"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "အပေါ်တွင် စကားလုံး သို့မဟုတ် တဂ်ထည့်ပါ။ ၎င်းပါသော ပို့စ်များ သင့်ဖိဒ်တွင် မပေါ်တော့ပါ။"),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "ဤအရာများထဲမှ တစ်ခုခုပါသော ပို့စ်များ သင့်ဖိဒ်တွင် မပေါ်ပါ။ စာလုံးအကြီးအသေး အရေးမပါ၊ စကားလုံးသည် ပိုရှည်သော စကားလုံးများအတွင်းတွင်လည်း ကိုက်ညီသဖြင့် “spoiler” က “spoilers” ကိုပါ ဖမ်းပါသည်။"),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("မည်သူ့ကိုမျှ မပိတ်ထားပါ"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "ပိတ်ခြင်းသည် သင်တို့နှစ်ဦးကို အပြန်အလှန် နှစ်ဖက်စလုံး ဖျောက်ထားပါသည်။ တစ်စုံတစ်ယောက်ကို ၎င်း၏ ပရိုဖိုင်မီနူးမှ ပိတ်ပါ။"),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("မည်သူ့ကိုမျှ အသံမပိတ်ထားပါ"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "အကောင့်ကို အသံပိတ်ခြင်းသည် သူတို့ကို မပြောဘဲ ၎င်းတို့၏ ပို့စ်များကို ဖျောက်ပါသည်။ ပရိုဖိုင် သို့မဟုတ် ပို့စ်မီနူးမှ အသံပိတ်ပါ။"),
      "ui_password": MessageLookupByLibrary.simpleMessage("စကားဝှက်"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("မကိုက်ညီပါ။"),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "ဤစက်တွင် ဝင်ထားဆဲ ဖြစ်ပါမည်။ အခြားစက်များမှ ထွက်သွားပါမည်။"),
      "ui_password_too_short": MessageLookupByLibrary.simpleMessage(
          "အနည်းဆုံး စာလုံး 8 လုံး သုံးပါ။"),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "စကားဝှက်ကို အပ်ဒိတ်လုပ်၍မရပါ။ ထပ်စမ်းကြည့်ပါ။"),
      "ui_password_updated": MessageLookupByLibrary.simpleMessage(
          "စကားဝှက် အပ်ဒိတ်လုပ်ပြီးပါပြီ။"),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("DID ကူးယူပြီး"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "သင်နှစ်သက်သော ပို့စ်များကို သင့်အတွက်သာ ဤနေရာတွင် ထားပါသည်။"),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "သင် ဓာတ်ပုံ သို့မဟုတ် ကလစ် မတင်ရသေးပါ။"),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} သည် ဓာတ်ပုံ သို့မဟုတ် ကလစ် မတင်ရသေးပါ။"),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "သင်တင်သမျှ ဤနေရာတွင် ပေါ်ပါမည်။"),
      "ui_profile_empty_posts_other":
          MessageLookupByLibrary.simpleMessage("{name} သည် ဘာမှ မတင်ရသေးပါ။"),
      "ui_profile_load_failed_mine":
          MessageLookupByLibrary.simpleMessage("သင့်ပရိုဖိုင်ကို ဖွင့်၍မရပါ"),
      "ui_profile_load_failed_other":
          MessageLookupByLibrary.simpleMessage("@{handle} ကို ဖွင့်၍မရပါ"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("အနည်းဆုံး စာလုံး 8 လုံး"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("စာလုံးသေး (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("အနည်းဆုံး ဂဏန်းတစ်လုံး"),
      "ui_pw_rule_symbol":
          MessageLookupByLibrary.simpleMessage("သင်္ကေတ (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("စာလုံးကြီး (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "မကြာသေးမီ ထည့်သွင်းမှု {count} ခု။ မပို့မီ အကြောင်း › စနစ်မှတ်တမ်း တွင် စစ်ကြည့်ပါ။"),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "ဤအရာကို Kyron အဖွဲ့သာ ဖတ်ပါသည်။ ဆက်သွယ်နိုင်ရန် သင့်အကောင့်နှင့်အတူ ပို့ပါသည်။ အတူပါသွားမည့်အရာကို အတိအကျ ကြည့်လိုလျှင် အကြောင်း › စနစ်မှတ်တမ်း တွင် မှတ်တမ်းကို အရင်ဖတ်ပါ။"),
      "ui_report_sent": MessageLookupByLibrary.simpleMessage(
          "ပို့ပြီးပါပြီ၊ ကျေးဇူးတင်ပါသည်။"),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "ပို့ပြီးပါပြီ၊ ကျေးဇူးတင်ပါသည်။ ၎င်းသည် အစီရင်ခံစာ #{number} ဖြစ်သည်။"),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("ဘာမှားသွားသလဲ?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "ဗားရှင်း၊ မူဝါဒများ၊ အခြေအနေနှင့် စနစ်မှတ်တမ်း"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "လှိမ့်နေစဉ် ဗီဒီယိုများ အလိုအလျောက် မဖွင့်ပါစေနှင့်"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "သင်၏ ဗဟိုချုပ်ကိုင်မှုမဲ့ အမှတ်အသား"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("စိစစ်ထိန်းချုပ်မှု"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "စစ်ဆေးရန် စောင့်နေသော အစီရင်ခံစာများနှင့် အယူခံများ"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "ဤအရာများပါသော ပို့စ်များကို ဖိဒ်မှ ဝေးဝေးထားပါ"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("မဝင်ရသေးပါ"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("အသိပေးချက် စိတ်ကြိုက်များ"),
      "ui_settings_privacy_safety": MessageLookupByLibrary.simpleMessage(
          "ကိုယ်ရေးလုံခြုံမှုနှင့် ဘေးကင်းရေး"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်ဆိုင်ရာ ဆုံးဖြတ်ချက်များနှင့် အယူခံများ"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("စာသားအရွယ်အစား ချိန်ညှိရန်"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("သင့်အကောင့်"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "AR မှန်ဘီလူးများ ရိုက်ကူးခြင်းနှင့် ထုတ်ဝေခြင်းကို တည်ဆောက်နေဆဲ ဖြစ်သည်။ သင်ရိုက်သမျှ မသိမ်းနိုင်သေးသဖြင့် ကင်မရာ ပိတ်ထားပါသည်။"),
      "ui_soon_lens_heading": MessageLookupByLibrary.simpleMessage(
          "မှန်ဘီလူးများ အဆင်သင့် မဖြစ်သေးပါ"),
      "ui_soon_lens_title":
          MessageLookupByLibrary.simpleMessage("AR မှန်ဘီလူး"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "တိုက်ရိုက်ထုတ်လွှင့်ရန် Kyron မလည်ပတ်ရသေးသော မီဒီယာဆာဗာ လိုအပ်သည်။ ယခု ထုတ်လွှင့်ပါက မည်သူမျှ ဝင်မရသော အခန်းထဲတွင် ရှိနေပါမည်။ အသံပို့စ် ရိုက်ကူးခြင်းကမူ ယနေ့ အလုပ်လုပ်ပါသည်။"),
      "ui_soon_live_heading": MessageLookupByLibrary.simpleMessage(
          "တိုက်ရိုက်ထုတ်လွှင့်မှု အဆင်သင့် မဖြစ်သေးပါ"),
      "ui_soon_live_title":
          MessageLookupByLibrary.simpleMessage("တိုက်ရိုက်ထုတ်လွှင့်ရန်"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "စစ်တမ်းများသည် ရွေးချယ်စရာများ သိမ်းရန်နှင့် မဲရေတွက်ရန် နေရာ လိုအပ်သည်။ ၎င်း မရှိသေးသဖြင့် ယနေ့တင်သော စစ်တမ်းသည် အဖြေတိုင်းကို ဆုံးရှုံးပါမည်။"),
      "ui_soon_poll_heading": MessageLookupByLibrary.simpleMessage(
          "စစ်တမ်းများ အဆင်သင့် မဖြစ်သေးပါ"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("စစ်တမ်း"),
      "ui_soon_write_instead":
          MessageLookupByLibrary.simpleMessage("အစား စာသားပို့စ် ရေးပါ"),
      "ui_status_check_again": MessageLookupByLibrary.simpleMessage("ထပ်စစ်ပါ"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("အသေးစိတ်"),
      "ui_status_mirror":
          MessageLookupByLibrary.simpleMessage("မှန်ပြင်ဇယားများ"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron ပြန်ဖြေသော်လည်း တစ်ခုခု မှားနေသည်။"),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("အသွားအပြန်"),
      "ui_support_ask": MessageLookupByLibrary.simpleMessage("မေးခွန်းမေးရန်"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "သင့်အကောင့်အကြောင်း သို့မဟုတ် တစ်ခုခု ဘယ်လိုအလုပ်လုပ်သလဲ"),
      "ui_support_by_email":
          MessageLookupByLibrary.simpleMessage("အီးမေးလ်ဖြင့်"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron ပျက်ခဲ့လျှင်- အက်ပ်မှတ်တမ်းပါ ပို့ပါသည်"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("အက်ပ်တွင်"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "ဤနေရာမှ Kyron အဖွဲ့ထံ စာရေးပါ။ ၎င်းသည် သင့်အကောင့်နှင့်အတူ ကိုယ်ပိုင်အနေဖြင့် ကျွန်ုပ်တို့ထံ ရောက်ပြီး ၎င်းပေါ်ရှိ အီးမေးလ်လိပ်စာသို့ ပြန်ကြားပါသည်။"),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "မေးလ်အက်ပ် မပွင့်ပါ။ {address} ကို ကူးယူပြီးပါပြီ။"),
      "ui_support_privacy": MessageLookupByLibrary.simpleMessage(
          "ကိုယ်ရေးလုံခြုံမှုနှင့် သင့်ဒေတာ"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("ပြဿနာ အစီရင်ခံရန်"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "တစ်ခုခု ပျက်နေသည် သို့မဟုတ် လုပ်သင့်သည်ကို မလုပ်ပါ"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "ပို့စ် သို့မဟုတ် အကောင့်ကို အစီရင်ခံရန် ၎င်း၏ မီနူးကို သုံးပါ- ထိုသို့ဆိုလျှင် သင်ဘယ်ဟာကို ဆိုလိုသည်ကို ကျွန်ုပ်တို့ အတိအကျ သိပါသည်။"),
      "ui_support_safety": MessageLookupByLibrary.simpleMessage(
          "ဘေးကင်းရေးနှင့် အလွဲသုံးစားမှု"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron အားလုံးအတွက် ပျက်နေသလား၊ သင့်အတွက်သာလား"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("ကြီး"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("ပိုကြီး"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("အလယ်အလတ်"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron သည် ဖတ်ရကျိုးနပ်သော အရာကို ပြောရာ နေရာ ဖြစ်သည်။"),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("သေး"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("အမြဲ မှောင်"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("မှိန်"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "ပိုနူးညံ့သော အမှောင်၊ အနက်အစား အပြာနုမီးခိုး"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("အမြဲ လင်း"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "ဖုန်း၏ လင်း သို့မဟုတ် မှောင် ဆက်တင်အတိုင်း"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("ပိတ်ခြင်း ဖြုတ်ရန်"),
      "ui_unmute":
          MessageLookupByLibrary.simpleMessage("အသံပိတ်ခြင်း ဖြုတ်ရန်"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("သင်မည်သူလဲ"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "သင့်စကားဖြင့် စစ်ဆေးသူ သိသင့်သည့်အရာ။"),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "ကျွန်ုပ်သည် ဤနေရာနှင့် ကိုယ်ပိုင်ဆိုက်တွင် ငှက်များအကြောင်း ရေးပါသည်။"),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("နောက်လင့်ခ်တစ်ခု ထည့်ရန်"),
      "ui_verify_again": MessageLookupByLibrary.simpleMessage(
          "{date} မှစ၍ ထပ်တောင်းနိုင်ပါသည်။"),
      "ui_verify_ask":
          MessageLookupByLibrary.simpleMessage("အတည်ပြုရန် တောင်းဆိုပါ"),
      "ui_verify_before": MessageLookupByLibrary.simpleMessage("မတောင်းဆိုမီ"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("ဖန်တီးသူ"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("သတင်းထောက်"),
      "ui_verify_cat_org": MessageLookupByLibrary.simpleMessage(
          "အဖွဲ့အစည်း သို့မဟုတ် အမှတ်တံဆိပ်"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("အခြားအရာ"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("လူသိများသူ"),
      "ui_verify_denied": MessageLookupByLibrary.simpleMessage(
          "တောင်းဆိုချက် {number} ကို အတည်မပြုပါ"),
      "ui_verify_done":
          MessageLookupByLibrary.simpleMessage("သင် အတည်ပြုပြီး ဖြစ်သည်"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("ပရိုဖိုင် တည်းဖြတ်ရန်"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("ဂဏန်း 6 လုံးကုဒ် ထည့်ပါ"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "{seconds} စက္ကန့်အတွင်း ကုဒ်ပြန်ပို့ရန်"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("{email} သို့ ပို့လိုက်ပါပြီ"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("အတည်ပြုရန်"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Kyron တွင် အတည်ပြုခံပါ"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Kyron တွင်"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("အတည်ပြု"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("ခံပါ။"),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "တံဆိပ်သည် Kyron အဖွဲ့မှ တစ်ဦးက ဤအကောင့်သည် ၎င်းပြောသူ အစစ်အမှန် ဖြစ်ကြောင်း စစ်ဆေးပြီးကြောင်း ပြသည်။ ၎င်းသည် အပိုရောက်ရှိမှု မပေးပါ၊ ရောင်းရန်လည်း မဟုတ်ပါ။"),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "သင့်အမည် မပြောင်းသရွေ့ တံဆိပ် ရှိနေပါမည်။ အမည်ပြောင်းပါက အသစ်ကို တစ်စုံတစ်ဦး စစ်ဆေးသည်အထိ ဖြုတ်ထားပါမည်။"),
      "ui_verify_link_first": MessageLookupByLibrary.simpleMessage(
          "ကျွန်ုပ်တို့ စစ်ဆေးနိုင်သည့်နေရာ"),
      "ui_verify_link_more":
          MessageLookupByLibrary.simpleMessage("နောက်လင့်ခ်"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "ဤ Kyron အကောင့်သည် သင့်ဟာ ဖြစ်ကြောင်း ဖော်ပြသော ဆိုက် သို့မဟုတ် အခြားပရိုဖိုင်- ထိုနေရာတွင် သင့် Kyron အမည် သို့မဟုတ် ပရိုဖိုင်လင့်ခ် ထည့်ပါ။ Kyron သည် မည်သည့်အခါမျှ သက်သေခံကတ် မတောင်းပါ။"),
      "ui_verify_load_failed":
          MessageLookupByLibrary.simpleMessage("သင့်အခြေအနေကို ဖွင့်၍မရပါ"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "မတောင်းဆိုမီ အပေါ်ရှိ အရာအားလုံးကို အမှန်ခြစ်ထားရပါမည်။"),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "အနည်းဆုံး {days} ရက် သက်တမ်းရှိ အကောင့်"),
      "ui_verify_req_bio": MessageLookupByLibrary.simpleMessage(
          "သင်မည်သူဖြစ်ကြောင်း ပြောသော ကိုယ်ရေးအကျဉ်း"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("ပရိုဖိုင်ပေါ်ရှိ သင့်အမည်"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("ပရိုဖိုင်ဓာတ်ပုံ"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "နောက်ဆုံး {days} ရက်အတွင်း သင့်မှတ်တမ်းတွင် ဘာမှမရှိ"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "ပို့ပြီးပါပြီ။ လူတစ်ဦးက ကြည့်ပါမည်။"),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("{date} မှစ၍။"),
      "ui_verify_step_ask":
          MessageLookupByLibrary.simpleMessage("တောင်းဆိုရန်"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "သင်မည်သူဖြစ်ကြောင်းနှင့်\nသက်သေပြသော လင့်ခ်"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("တံဆိပ်"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "သင့်အမည်ဘေးတွင်၊\nပေါ်သည့်နေရာတိုင်း"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("လူတစ်ဦး\nစစ်ဆေးသည်"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "အဖွဲ့ဝင်တစ်ဦး\nသင့်လင့်ခ်များကို ဖွင့်သည်"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("အတည်ပြုခြင်း"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "တောင်းဆိုချက် {number} သည် လူတစ်ဦးထံ ရှိသည်"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "{date} တွင် {category} အဖြစ် ပို့ခဲ့သည်။ ဆုံးဖြတ်ပြီးသည့်အခါ အသိပေးချက် ရပါမည်။"),
      "ui_verify_withdraw": MessageLookupByLibrary.simpleMessage(
          "တောင်းဆိုချက် ပြန်ရုပ်သိမ်းရန်"),
      "ui_verify_withdrawn": MessageLookupByLibrary.simpleMessage(
          "တောင်းဆိုချက် ပြန်ရုပ်သိမ်းပြီး။"),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "အသံဖမ်းခြင်း မပြီးဆုံးနိုင်ပါ- {error}"),
      "ui_voice_limit": MessageLookupByLibrary.simpleMessage("ဆယ်မိနစ်အထိ။"),
      "ui_voice_listening":
          MessageLookupByLibrary.simpleMessage("နားထောင်နေသည်…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "အသံဖမ်းရန် Kyron သည် မိုက်ခရိုဖုန်းခွင့်ပြုချက် လိုအပ်သည်။ စက်ဆက်တင်တွင် ပေးနိုင်ပါသည်။"),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "အသံဖမ်းခြင်း စတင်၍မရပါ- {error}"),
    };

final messageLookup = MessageLookup();
