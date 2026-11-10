import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ur';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("لفظ، جملہ یا #ٹیگ"),
      "about": MessageLookupByLibrary.simpleMessage("تعارف"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("جواب شامل کریں"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("زبانیں شامل کریں…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("متفق ہوں اور جاری رکھیں"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("پہلے سے Kyron اکاؤنٹ ہے؟"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("تبصرے"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "مختلف لوگ، کھولنے کی تعداد نہیں"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("مشغولیت"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("لائکس"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی ناظر نہیں"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "اس پوسٹ کو ابھی کسی نے نہیں کھولا۔"),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("پوسٹ کیا گیا"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("محفوظ کیے گئے"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("ناظرین"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("روزانہ ناظرین"),
      "and": MessageLookupByLibrary.simpleMessage("اور"),
      "answerNumber": (Object a0) => "جواب ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR لینز"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("ایپ لاگ منسلک کریں"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("آنے جانے کا وقت"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ٹوکن کی تصدیق"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("دوبارہ کوشش کریں"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("دوبارہ کوشش کریں"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "ابھی نشریات شروع کرنے سے آپ ایسے کمرے میں ہوں گے جس میں کوئی نہیں"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("کمیونٹی شروع کریں"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("یہ کس لیے ہے؟ (اختیاری)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("دوبارہ آ سکے گا۔"),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("اس فہرست سے دوبارہ آ سکے گا۔"),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("اسے بند کرنے پر"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("پہلے شامل ہوں"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("جلد آ رہا ہے"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage(
              "آپ اپنے نام سے پوسٹ کر رہے ہیں"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("اس کمیونٹی میں پوسٹ کریں"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("ابھی ابھی"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("دوبارہ کوشش کریں"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("موضوع 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("آپ کے لیے"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("میں کچھ ہے۔"),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("ابھی وہاں جا رہا ہے۔"),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage("، نہیں"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("کیا میں حرکت کر رہا ہوں"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("آواز بند کریں"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("آواز آن کریں"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("آپ کے لیے"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("آپ کے ٹیبز"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("دوبارہ کوشش کریں"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("علامت (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("روزانہ ناظرین"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("لوڈ نہیں ہو سکا"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("یہ پوسٹ"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("کچھ شامل کرنا ہے؟ (اختیاری)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("یہ پوسٹ"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("کسی اکاؤنٹ سے"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("لاگ آؤٹ"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("آپ کا اکاؤنٹ"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ کی تصدیق کریں"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("ابھی نہیں"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("لوڈ ہو رہا ہے…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("پوسٹ ہو رہا ہے…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 گھنٹے پہلے"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("اسٹوری کا لنک کاپی کریں"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("آپ کی اسٹوری"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "آپ کا اکاؤنٹ، آپ کی پوسٹس اور جن پر آپ ٹیپ کرتے ہیں، تاکہ"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("موضوع شامل کریں"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("اپنا۔"),
      "authorBlocked": (Object a0) => "${a0} کو بلاک کر دیا گیا",
      "authorPostsHidden": (Object a0) =>
          "آپ کو ${a0} کی پوسٹس نظر نہیں آئیں گی",
      "block": MessageLookupByLibrary.simpleMessage("بلاک کریں"),
      "blockAuthor": (Object a0) => "${a0} کو بلاک کریں؟",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("بلڈ کی تفصیلات کاپی ہو گئیں"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("جاری رکھ کر آپ متفق ہوتے ہیں"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "جاری رکھ کر آپ ہماری سروس کی شرائط اور رازداری کی پالیسی سے متفق ہوتے ہیں"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "سائن اپ کر کے آپ متفق ہوتے ہیں"),
      "cancel": MessageLookupByLibrary.simpleMessage("منسوخ کریں"),
      "change": MessageLookupByLibrary.simpleMessage("تبدیل کریں"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("ای میل تبدیل کریں"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "اپنی ای میل سے اکاؤنٹ کی تصدیق کریں۔"),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "دیکھیں کہ Kyron قابل رسائی ہے یا نہیں"),
      "clear": MessageLookupByLibrary.simpleMessage("صاف کریں"),
      "close": MessageLookupByLibrary.simpleMessage("بند کریں"),
      "closeCommunity": (Object a0) => "${a0} بند کریں؟",
      "closeIt": MessageLookupByLibrary.simpleMessage("اسے بند کریں"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("یہ کمیونٹی بند کریں"),
      "communities": MessageLookupByLibrary.simpleMessage("کمیونٹیز"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "دریافت کریں میں کوئی ڈھونڈیں، یا اپنی شروع کریں۔"),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "کوئی گرما گرم رائے دیں (یا نیم گرم)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("آپ کے ذہن میں کیا ہے؟"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "کچھ ایسا کہیں جو صرف آپ کہہ سکتے ہیں…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("یہی اشارہ ہے: پوسٹ کر دیں"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "لکھیں، بولیں یا بلند آواز میں سوچیں"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ کی تصدیق کریں"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("سپورٹ سے رابطہ کریں"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "پوسٹس کی ابھی کوئی زبان نہیں ہوتی، اس لیے یہ ابھی آپ کی فیڈ فلٹر نہیں کرتا۔ تب تک آپ کے انتخاب محفوظ رہتے ہیں۔"),
      "continueAction": MessageLookupByLibrary.simpleMessage("جاری رکھیں"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("ای میل کے ساتھ جاری رکھیں"),
      "copy": MessageLookupByLibrary.simpleMessage("کاپی کریں"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("اس کے بجائے رپورٹ کاپی کریں"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google سائن ان نہیں کھل سکا۔ ${a0}",
      "couldNotSignOut": (Object a0) => "لاگ آؤٹ نہیں ہو سکا: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("تصویر نہیں لی جا سکی۔"),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "آپ کی پروفائل پر اور آپ کی پوسٹس کے نیچے دکھایا جاتا ہے۔"),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "“{query}” سے کوئی ملک میل نہیں کھاتا۔"),
      "country_none":
          MessageLookupByLibrary.simpleMessage("کوئی ملک نہ دکھائیں"),
      "country_search": MessageLookupByLibrary.simpleMessage("ممالک تلاش کریں"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "آپ کی پروفائل پر اور آپ کی پوسٹس کے نیچے دکھایا جاتا ہے۔ جب آپ کسی کی پوسٹس دیکھتے ہیں تو آپ کا ملک ان کی بصیرتوں میں گنا جاتا ہے، صرف پانچ یا زیادہ کے گروپوں میں اور کبھی نام سے نہیں۔"),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("آپ کے فون کی ترتیبات سے"),
      "create": MessageLookupByLibrary.simpleMessage("بنائیں"),
      "createAccount": MessageLookupByLibrary.simpleMessage("اکاؤنٹ بنائیں"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("اپنا اکاؤنٹ بنائیں"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("اپنی پروفائل بنائیں"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR لینز"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("لائیو جائیں"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("متنی پوسٹ"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("صوتی پوسٹ"),
      "delete": MessageLookupByLibrary.simpleMessage("حذف کریں"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("یہ تبصرہ حذف کریں؟"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("یہ پوسٹ حذف کریں؟"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("اس منسلکہ کی وضاحت کریں"),
      "description": MessageLookupByLibrary.simpleMessage("تفصیل"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID کلپ بورڈ پر کاپی ہو گیا"),
      "done": MessageLookupByLibrary.simpleMessage("ہو گیا"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "کچھ لکھنے کے بعد ایڈیٹر بند کریں، آپ کو مسودے کی پیشکش ہوگی۔"),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} دن پہلے"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} گھنٹے پہلے"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("ابھی ابھی"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} منٹ پہلے"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("ابھی کچھ نہیں لکھا گیا"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("پول، ابھی کوئی سوال نہیں"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("اقتباس، ابھی کوئی متن نہیں"),
      "drafts": MessageLookupByLibrary.simpleMessage("مسودے"),
      "editProfile":
          MessageLookupByLibrary.simpleMessage("پروفائل میں ترمیم کریں"),
      "email": MessageLookupByLibrary.simpleMessage("ای میل"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("ای میل اطلاعات"),
      "explore": MessageLookupByLibrary.simpleMessage("دریافت کریں"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "اس ڈیوائس پر چہرے کی ٹریکنگ دستیاب نہیں۔"),
      "feedTagDetail": (Object a0) => "#${a0} کے ساتھ ابھی کچھ پوسٹ نہیں ہوا۔",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("{name} کو فالو کریں"),
      "followers": MessageLookupByLibrary.simpleMessage("فالوورز"),
      "following": MessageLookupByLibrary.simpleMessage("فالو کیے گئے"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ بھول گئے؟"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("مدد حاصل کرنا"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Google کے ساتھ جاری رکھیں"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Google کے ساتھ سائن ان کریں"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google مکمل سائن ان Kyron کو ایسے لنک کے ذریعے واپس کرتا ہے جس کا جواب صرف Android اور iOS دیتے ہیں، اس لیے ${a0} پر براؤزر کے پاس اسے واپس کرنے کی کوئی جگہ نہیں۔\\n\\nاگر Google کے ذریعے آپ کا پہلے سے Kyron اکاؤنٹ ہے، تو اسی پتے کے ساتھ ای میل کے ساتھ جاری رکھیں منتخب کریں اور پاس ورڈ بھول گئے پر ٹیپ کریں: آپ کو پاس ورڈ سیٹ کرنے کا لنک ملے گا۔",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google سائن ان کے لیے فون ایپ چاہیے"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Google کے ساتھ سائن اپ کریں"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "رہنما اور عام سوالات کے جوابات"),
      "handle": MessageLookupByLibrary.simpleMessage("ہینڈل"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("مدد اور معاونت"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("مدد مرکز"),
      "home": MessageLookupByLibrary.simpleMessage("ہوم"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("ایک سطر میں"),
      "ins_account": MessageLookupByLibrary.simpleMessage("آپ کا اکاؤنٹ"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("کمیونٹی کھولیں"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("پوسٹ لکھیں"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("پوسٹ دیکھیں"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("اپنی پروفائل میں ترمیم کریں"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("وہ کب موجود ہوتے ہیں"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("آپ کے ٹائم زون میں۔"),
      "ins_ages": MessageLookupByLibrary.simpleMessage("عمریں"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "سالگرہ بتانے والے، پہنچے ہوئے {known} لوگوں میں سے۔"),
      "ins_chart": MessageLookupByLibrary.simpleMessage("ہر دن پہنچے ہوئے لوگ"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("وہ جن کمیونٹیز میں ہیں"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("ممالک"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "ان {known} لوگوں میں سے جن تک پہنچے اور جن کی پروفائل پر ملک ہے۔"),
      "ins_days": MessageLookupByLibrary.simpleMessage("پچھلے {days} دن"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("بصیرتیں لوڈ نہیں ہو سکیں"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("فالوورز"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "دکھانے کے لائق بڑا کوئی گروپ ابھی نہیں۔"),
      "ins_grow": MessageLookupByLibrary.simpleMessage("کیسے بڑھیں"),
      "ins_interests": MessageLookupByLibrary.simpleMessage(
          "وہ جن موضوعات کو فالو کرتے ہیں"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("پسندیدگیاں"),
      "ins_new": MessageLookupByLibrary.simpleMessage("نیا"),
      "ins_new_followers": MessageLookupByLibrary.simpleMessage("نئے فالوورز"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "اس عرصے میں آپ کی کوئی پوسٹ کسی تک نہیں پہنچی۔"),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("آپ کو فالو نہیں کرتے"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "ممالک وہ ہیں جو لوگوں نے اپنی پروفائل پر چنے ہیں۔ Kyron کسی کا شہر یا جنس جمع نہیں کرتا، اس لیے ان کے لیے دکھانے کو کچھ نہیں ہے۔"),
      "ins_opens": MessageLookupByLibrary.simpleMessage("کھولے گئے"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} تک پہنچی · {likes} پسند · {replies} جواب"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("پہنچے ہوئے لوگ"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "ہر شخص ایک بار گنا جاتا ہے: آپ کی کوئی پوسٹ پہلی بار اسے دکھائی گئی یا اس نے کھولی۔ نئے فالوورز اب بھی آپ کو فالو کرتے ہیں؛ ان فالو نہیں گنے جاتے۔"),
      "ins_replies": MessageLookupByLibrary.simpleMessage("جوابات"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("ری پوسٹس"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("محفوظ"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "اس عرصے میں {floor} لوگوں کے آپ کی پوسٹس دیکھنے کے بعد دکھایا جاتا ہے کہ آپ کے ناظرین کون ہیں۔ اس سے کم ہوں تو یہ کسی ایک کی طرف اشارہ کر سکتا ہے۔"),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("ابھی کافی لوگ نہیں"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "ان میں سے {pct}% پہلے ہی آپ کو فالو کرتے ہیں: آپ کی پوسٹس زیادہ تر جاننے والوں تک پہنچتی ہیں۔"),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "ان میں سے {pct}% ابھی آپ کو فالو نہیں کرتے: آپ کی پوسٹس دریافت ہو رہی ہیں۔"),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "آپ {reach} لوگوں تک پہنچے، پچھلے عرصے سے {pct}% کم۔"),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "پچھلے {days} دنوں میں آپ {reach} لوگوں تک پہنچے۔"),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "آپ {reach} لوگوں تک پہنچے، تقریباً پچھلے عرصے جتنے۔"),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "پچھلے {days} دنوں میں کسی نئے شخص نے آپ کی پوسٹس نہیں دیکھیں۔"),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "آپ {reach} لوگوں تک پہنچے، پچھلے عرصے سے {pct}% زیادہ۔"),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "آپ {reach} لوگوں تک پہنچے، پچھلے عرصے کے {times}×۔"),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "کسی بھی دوسرے موضوع سے زیادہ لوگ {name} کو فالو کرتے ہیں۔"),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("ناظرین"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("جائزہ"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "جو لوگ آپ کی کوئی پوسٹ پاتے ہیں وہ فالو کرنے سے پہلے آپ کی پروفائل دیکھتے ہیں۔ چہرہ یا لوگو بتاتا ہے کہ وہاں کوئی ہے۔"),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("پروفائل تصویر شامل کریں"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "ایک سطر میں بتائیں کہ آپ کس بارے میں پوسٹ کرتے ہیں، تاکہ اجنبی جانے کہ آپ کو فالو کرنے سے اسے کیا ملے گا۔"),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("بایو لکھیں"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "آپ کی {total} پوسٹس میں سے {without} کا کوئی موضوع نہیں تھا۔ موضوع پوسٹ کو اس موضوع کی فیڈ میں اور اسے فالو کرنے والوں کے سامنے رکھتا ہے۔"),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("پوسٹس میں موضوعات شامل کریں"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} لوگوں نے آپ کی پوسٹس پر جواب دیا اور آپ نے {answered} کا جواب دیا۔ انہیں لکھنے جتنی پروا تھی: ایک جواب قاری کو باقاعدہ بنا دیتا ہے۔"),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("جوابات کا جواب دیں"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "آپ کے ناظرین {when} سب سے زیادہ فعال ہوتے ہیں۔ اس سے ذرا پہلے کی گئی پوسٹ کو خوش آمدید کہنے والے مل جاتے ہیں۔"),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("جب وہ موجود ہوں تب پوسٹ کریں"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "آپ کو فالو نہ کرنے والے {reached} لوگوں نے آپ کی پوسٹس دیکھیں، اور {gained} نے فالو کیا۔ آپ کا بایو اور نئی پوسٹس بتائیں کہ وہ آپ سے کیا توقع رکھ سکتے ہیں۔"),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("قارئین کو فالوورز بنائیں"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "ایک پوسٹ آپ کی دوسری پوسٹس کی عام پہنچ سے {times}× لوگوں تک پہنچی۔ دیکھیں اس نے کیا مختلف کیا، اور وہی زیادہ کریں۔"),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("جو کام آیا وہ زیادہ کریں"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "آپ کی پوسٹس دیکھنے والوں میں سے بہت سے {name} میں ہیں۔ وہاں پوسٹ کرنے سے آپ باقیوں کے سامنے بھی آتے ہیں۔"),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("{name} میں پوسٹ کریں"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "آپ نے {days} دنوں میں {posts} بار پوسٹ کیا۔ ہر پوسٹ ڈھونڈے جانے کا ایک اور موقع ہے، اور باقاعدہ ردھم آپ کو فالوورز کی فیڈ میں رکھتا ہے۔"),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("زیادہ بار پوسٹ کریں"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "پچھلے {days} دنوں میں آپ نے پوسٹ نہیں کیا۔ پوسٹ کے بغیر کچھ بھی کسی تک نہیں پہنچتا۔"),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("کچھ پوسٹ کریں"),
      "ins_title": MessageLookupByLibrary.simpleMessage("بصیرتیں"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("بہترین پوسٹس"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "پچھلے {days} دنوں کے مقابلے میں"),
      "interest_add": MessageLookupByLibrary.simpleMessage("دلچسپی شامل کریں"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("ترتیب بدلنے کے لیے گھسیٹیں"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "بار میں زیادہ سے زیادہ پانچ ٹیب آتے ہیں۔ دوسرا شامل کرنے کے لیے ایک ہٹائیں۔"),
      "interest_following":
          MessageLookupByLibrary.simpleMessage("فالو کیے گئے"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("آپ کے لیے"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "جب لوگ ہیش ٹیگ استعمال کرنا شروع کریں گے تو وہ یہاں دکھائی دیں گے۔"),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("ابھی ٹرینڈ میں"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("ویڈیوز"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("آپ کے ٹیبز"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
          "یہ آپ دونوں کے لیے غائب ہو جائے گا۔"),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("اسے تھریڈ سے ہٹا دیا جائے گا۔"),
      "join": MessageLookupByLibrary.simpleMessage("شامل ہوں"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("ترمیم جاری رکھیں"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron کی اسکرینیں آپ کی زبان میں ہیں۔ اگر کوئی لفظ غلط لگے تو رائے بھیجیں کے ذریعے ہمیں بتائیں۔"),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("زبانیں"),
      "leave": MessageLookupByLibrary.simpleMessage("چھوڑیں"),
      "leaveCommunity": (Object a0) => "${a0} چھوڑیں؟",
      "letBackIn": MessageLookupByLibrary.simpleMessage("واپس آنے دیں"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 صفحہ کھلا ہے"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("کلپ شامل کریں"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF شامل کریں"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("ہیش ٹیگ شامل کریں"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("تصویر شامل کریں"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("پول شامل کریں"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("ویڈیو شامل کریں"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("دلچسپی شامل کریں"),
      "literaladdLabelAsATab": (Object a0) =>
          "${a0} کو ٹیب کے طور پر شامل کریں",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("ایپ کی زبان"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("ایپ ورژن"),
      "literalblockAuthor": (Object a0) => "${a0} کو بلاک کریں",
      "literalblockAuthor2": (Object a0) => "${a0} کو بلاک کریں؟",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("اس اکاؤنٹ کو بلاک کریں؟"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("جواب ترک کریں"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("دوبارہ جانچیں"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("گیلری سے منتخب کریں"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("کیش صاف کریں"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("تمام صفحات بند کریں"),
      "literalcloseTabLabel": (Object a0) => "${a0} بند کریں",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("براؤزر بند کریں"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0} بند کریں؟",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("معاونت سے رابطہ کریں"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("مواد کی زبانیں"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("لنک کاپی کریں"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("پوسٹ کا لنک کاپی کریں"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("پوسٹ کا متن کاپی کریں"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("متن کاپی کریں"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("کمیونٹیز لوڈ نہیں ہو سکیں"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF لوڈ نہیں ہو سکے"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("اطلاعات لوڈ نہیں ہو سکیں"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("اراکین لوڈ نہیں ہو سکے"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("یہ پوسٹس لوڈ نہیں ہو سکیں"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("یہ گفتگو لوڈ نہیں ہو سکی"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("یہ فہرست لوڈ نہیں ہو سکی"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("یہ پوسٹ لوڈ نہیں ہو سکی"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("یہ جواب لوڈ نہیں ہو سکا"),
      "literalcouldNotLoadTrendingTags":
          MessageLookupByLibrary.simpleMessage("مقبول ٹیگز لوڈ نہیں ہو سکے"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "آپ کی کمیونٹیز لوڈ نہیں ہو سکیں"),
      "literalcouldNotLoadYourMessages":
          MessageLookupByLibrary.simpleMessage("آپ کے پیغامات لوڈ نہیں ہو سکے"),
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("یہ کمیونٹی نہیں کھل سکی"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("جواب پوسٹ نہیں ہو سکا۔"),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("تلاش کام نہیں آئی"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "لاگ آؤٹ نہیں ہو سکا: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} صفحات کھلے ہیں",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("کور تصویر"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("ڈیٹا سیور"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("پوسٹ حذف کریں"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("لوگ تلاش کریں"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("جواب نہ دیں"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("مسودہ محفوظ ہو گیا"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage("ابھی رائے نہیں بھیجی جا سکتی"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("متن کا سائز"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF سیٹ اپ نہیں ہیں"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("کسی دوسری ایپ کو دیں"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ چھپائیں"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("یہ پوسٹ چھپائیں"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "اسے چھپاتا ہے اور ہم سے ایسی کم دکھانے کو کہتا ہے"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("کیسا برتاؤ کریں"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("لکھنا جاری رکھیں"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron نے جواب نہیں دیا"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} تاریخ",
      "literalleaveCommunityName": (Object a0) => "${a0} چھوڑیں؟",
      "literallensNameFaceLens": (Object a0) => "${a0}، چہرے کا لینز",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("پسند کی گئی پوسٹس"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("لنک کاپی ہو گیا"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("ماڈریٹر بنائیں"),
      "literalmuteAuthor": (Object a0) => "${a0} کو خاموش کریں",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("یہ تھریڈ خاموش کریں"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("الفاظ یا ٹیگز خاموش کریں"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "خاموش اور بلاک کیے گئے اکاؤنٹس"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "خاموش کر دیا گیا۔ آپ کو اطلاعات نہیں ملیں گی۔"),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "اس ڈیوائس کی کوئی ایپ ${a0} لنکس نہیں کھولتی۔",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "اس ڈیوائس کے کسی براؤزر نے لنک قبول نہیں کیا۔"),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی DID نہیں"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("کوئی مسودہ نہیں"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی دلچسپی نہیں"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی لائک نہیں"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی پیغام نہیں"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("کوئی نیا فالوور نہیں"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی پوسٹ نہیں"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی جواب نہیں"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی ری پوسٹ نہیں"),
      "literalnoTrendingTagMatchesThat":
          MessageLookupByLibrary.simpleMessage("کوئی مقبول ٹیگ مماثل نہیں"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("کوئی نہیں ملا"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("کسی کو نہیں ہٹایا گیا"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("یہاں ابھی کوئی نہیں"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("دلچسپی نہیں"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("کچھ نہیں ملا"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("ابھی کچھ ٹرینڈ میں نہیں"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("لاگ میں ابھی کچھ نہیں"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("کوئی مماثلت نہیں"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("کچھ خاموش نہیں"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("ابھی دیکھنے کو کچھ نہیں"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("کوئی بغیر پڑھا نہیں"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("اسے صرف مالک تبدیل کر سکتا ہے"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("جواب کھولیں"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Kyron کی ای میل کھولیں"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ اور لاگ ان"),
      "literalpostInCommunityName": (Object a0) => "${a0} میں پوسٹ کریں",
      "literalpostInWidgetCommunityName": (Object a0) => "${a0} میں پوسٹ کریں",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "اوپر اپنے الفاظ کے ساتھ پوسٹ کریں"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("بنیادی زبان"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("پش اطلاعات"),
      "literalreading": MessageLookupByLibrary.simpleMessage("جانچ ہو رہی ہے…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("صوتی پوسٹ ریکارڈ کریں"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("دوبارہ ریکارڈ کریں"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("ماڈریٹر سے ہٹائیں"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("کمیونٹی سے ہٹائیں"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("محفوظ شدہ سے ہٹائیں"),
      "literalremoveLabel": (Object a0) => "${a0} ہٹائیں",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0} ہٹائیں",
      "literalremoveMemberDisplayname": (Object a0) => "${a0} کو ہٹائیں؟",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("پول ہٹائیں"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("یہ جواب ہٹائیں"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("یہ گفتگو حذف کریں"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("یہ پول ہٹائیں"),
      "literalreportAuthor": (Object a0) => "${a0} کی رپورٹ کریں",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("پوسٹ کی رپورٹ کریں"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("کوڈ دوبارہ بھیجیں"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("محفوظ کردہ پوسٹس"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("کچھ کہیں"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "${a0} میں کچھ کہیں",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("تلاش ناکام رہی"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("دوبارہ بھیجیں"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "${a0} سیکنڈ میں دوبارہ بھیجیں",
      "literalsendFeedback": MessageLookupByLibrary.simpleMessage("رائے دیں"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("لنک بھیجیں"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "بھیج دیا گیا۔ یہ رپورٹ #${a0} ہے۔",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "پاس ورڈ سیٹ کریں اور جاری رکھیں"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("لاگ معاونت کے ساتھ شیئر کریں"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("یہ کمیونٹی شیئر کریں"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("یہ صفحہ شیئر کریں"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("یہ پروفائل شیئر کریں"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("شیئر کریں…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("اقتباس کے ساتھ شیئر کریں"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("ایسی مزید دکھائیں"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ دکھائیں"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("نتائج دکھائیں"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("کمیونٹی شروع کریں"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("ریکارڈنگ شروع کریں"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("لوڈ ہونا روکیں"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "یہ پوسٹ اور اس کے جوابات دیکھنا بند کریں"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "اسٹوری پٹی، ${a0} آئٹمز",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("کیمرہ تبدیل کریں"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("کسی کو ٹیگ کریں"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("تصویر لیں"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "تبدیل کرنے کے لیے بینر یا تصویر پر ٹیپ کریں"),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
          "اس کے اندر موجود لنک پر ٹیپ کریں"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "تصویر اور کور شامل کرنے کے لیے ٹیپ کریں"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "یہ نہیں ہو سکا۔ دوبارہ کوشش کریں۔"),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("وہ GIF لوڈ نہیں ہو سکا۔"),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage("یہ لنک یہاں نہیں کھل سکتا۔"),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("کیمرہ بند ہے"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("یہ کمیونٹی"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("یہ جواب اب موجود نہیں"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("پوسٹ کا ترجمہ کریں"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("آواز بند کریں"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("آواز آن کریں"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("ہماری کوئی ایک استعمال کریں"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "تصدیقی کوڈ دوبارہ بھیج دیا گیا۔"),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "تصدیق ناکام: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("ای میل کی تصدیق کریں"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "ناظرین، لائکس، محفوظ کیے گئے اور تبصرے"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kyron کیا رکھتا ہے"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("یہ ایپ کیا کر رہی تھی"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "آپ نے کیا کیا، کیا توقع تھی، کیا ہوا "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
          "آپ جو پوسٹ کرتے ہیں وہ آپ کا ہے"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("کیا Kyron ابھی قابل رسائی ہے"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("کون جواب دے سکتا ہے"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("آپ کسے ٹیگ کرنا چاہتے ہیں؟"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "آپ پہلے سے تمام مقبول ٹیگز فالو کر رہے ہیں"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("آپ نے سب دیکھ لیا"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("آپ کسی کمیونٹی میں نہیں ہیں"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("آپ لاگ آؤٹ ہو گئے ہیں۔"),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "آپ نے ${a0} چھوڑ دی",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "آپ نے ابھی تک کچھ پوسٹ نہیں کیا"),
      "loadMore": MessageLookupByLibrary.simpleMessage("مزید لوڈ کریں"),
      "logCleared": MessageLookupByLibrary.simpleMessage("لاگ صاف ہو گیا"),
      "logCopied": MessageLookupByLibrary.simpleMessage("لاگ کاپی ہو گیا"),
      "logIn": MessageLookupByLibrary.simpleMessage("لاگ ان کریں"),
      "logOut": MessageLookupByLibrary.simpleMessage("لاگ آؤٹ"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("لاگ آؤٹ کریں؟"),
      "login": MessageLookupByLibrary.simpleMessage("لاگ ان"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "لاگ ان نہیں ہو سکا۔ اپنی تفصیلات چیک کریں۔"),
      "manage": MessageLookupByLibrary.simpleMessage("نظم کریں"),
      "menu": MessageLookupByLibrary.simpleMessage("مینو"),
      "message": MessageLookupByLibrary.simpleMessage("پیغام"),
      "messages": MessageLookupByLibrary.simpleMessage("پیغامات"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("آپ نے تمام گفتگو پڑھ لی ہے۔"),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "کسی کی پروفائل کھولیں اور گفتگو شروع کرنے کے لیے پیغام پر ٹیپ کریں۔"),
      "mute": MessageLookupByLibrary.simpleMessage("خاموش کریں"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("خاموش اور بلاک کیے گئے"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("خاموش کیے گئے الفاظ اور ٹیگز"),
      "name": MessageLookupByLibrary.simpleMessage("نام"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> اسکرین"),
      "newEmailAddress": MessageLookupByLibrary.simpleMessage("نیا ای میل پتہ"),
      "newPassword": MessageLookupByLibrary.simpleMessage("نیا پاس ورڈ"),
      "newPost": MessageLookupByLibrary.simpleMessage("نئی پوسٹ"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("ابھی نہیں"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "نہیں بھیجا گیا۔ دوبارہ کوشش کے لیے ٹیپ کریں"),
      "nothingMatchesQuery": (Object a0) =>
          "Kyron پر \"${a0}\" سے کچھ مماثل نہیں",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("کاپی کرنے کو کچھ نہیں"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "لائکس، جوابات اور نئے فالوورز یہاں آتے ہیں۔"),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "آپ کو فالو کرنے والے لوگ یہاں دکھائی دیں گے۔"),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "جب کوئی آپ کی پوسٹ لائک کرے گا تو یہ یہاں دکھائی دے گا۔"),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "آپ کی پوسٹس کے جوابات یہاں آتے ہیں۔"),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "جب کوئی آپ کو ری پوسٹ کرے گا تو یہ یہاں دکھائی دے گا۔"),
      "notifications": MessageLookupByLibrary.simpleMessage("اطلاعات"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("براؤزر میں کھولیں"),
      "or": MessageLookupByLibrary.simpleMessage("یا"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("صفحہ نہیں ملا"),
      "password": MessageLookupByLibrary.simpleMessage("پاس ورڈ"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ بہت چھوٹا ہے"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("اپنی دلچسپیاں منتخب کریں"),
      "post": MessageLookupByLibrary.simpleMessage("پوسٹ کریں"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("پوسٹ کے اعداد و شمار"),
      "postInCommunity": (Object a0) => "${a0} میں پوسٹ کریں",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("پوسٹ کریں، کہیں، دکھائیں۔"),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("پوسٹ کا متن کاپی ہو گیا"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("رازداری کی پالیسی"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("پروفائل اپ ڈیٹ ہو گئی"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("تعارف"),
      "profile_country": MessageLookupByLibrary.simpleMessage("ملک"),
      "profile_display_name": MessageLookupByLibrary.simpleMessage("ڈسپلے نام"),
      "profile_location": MessageLookupByLibrary.simpleMessage("مقام"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("تبدیل کرنے کے لیے ٹیپ کریں"),
      "profile_website": MessageLookupByLibrary.simpleMessage("ویب سائٹ"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage("پش اطلاعات"),
      "quote": MessageLookupByLibrary.simpleMessage("اقتباس کریں"),
      "quotePost": MessageLookupByLibrary.simpleMessage("پوسٹ کا اقتباس کریں"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("کسی انسان سے رابطہ کریں"),
      "remove": MessageLookupByLibrary.simpleMessage("ہٹائیں"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("یہ گفتگو حذف کریں؟"),
      "removeMember": (Object a0) => "${a0} کو ہٹائیں؟",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("یہ پیغام حذف کریں؟"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("جوابات، فالوز اور تذکرے"),
      "repliesPolicy": (Object a0) => "جوابات: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("جواب دیں"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("کوئی بھی شامل ہو سکتا ہے"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "کوئی بھی اب بھی اس پوسٹ کو دیکھ، ری پوسٹ اور اقتباس کر سکتا ہے۔"),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron پر کوئی بھی اس پوسٹ کا جواب دے سکتا ہے۔"),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("آپ کو فالو کرنے والے"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "صرف آپ کو فالو کرنے والے اس پوسٹ کا جواب دے سکتے ہیں۔"),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("جن کا آپ تذکرہ کرتے ہیں"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "اس پوسٹ میں جن کا آپ @تذکرہ کرتے ہیں صرف وہی جواب دے سکتے ہیں۔"),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("کوئی جواب نہیں دے سکتا"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "جوابات بند ہیں۔ آپ پھر بھی خود جواب دے سکتے ہیں۔"),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("کون جواب دے سکتا ہے؟"),
      "report": MessageLookupByLibrary.simpleMessage("رپورٹ کریں"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "رپورٹ کاپی ہو گئی۔ اسے معاونت کو بھیجی جانے والی ای میل میں پیسٹ کریں۔"),
      "reportSent": MessageLookupByLibrary.simpleMessage("رپورٹ بھیج دی گئی"),
      "repost": MessageLookupByLibrary.simpleMessage("ری پوسٹ کریں"),
      "reset": MessageLookupByLibrary.simpleMessage("ری سیٹ کریں"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("اپنا پاس ورڈ ری سیٹ کریں"),
      "retry": MessageLookupByLibrary.simpleMessage("دوبارہ کوشش کریں"),
      "save": MessageLookupByLibrary.simpleMessage("محفوظ کریں"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("مسودہ محفوظ کریں"),
      "saySomething": (Object a0) => "${a0} میں کچھ کہیں",
      "search": MessageLookupByLibrary.simpleMessage("تلاش کریں"),
      "searchByNameOrHandle":
          MessageLookupByLibrary.simpleMessage("نام یا ہینڈل سے تلاش کریں"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("کمیونٹیز تلاش کریں"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF تلاش کریں"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("زبانیں تلاش کریں"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("مقبول ٹیگز تلاش کریں"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "سیکیورٹی الرٹس اور اکاؤنٹ میں تبدیلیاں"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "ایپ انٹرفیس کی زبان منتخب کریں۔"),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "منتخب کریں کہ آپ کی فیڈز میں کون سی زبانیں دکھائی دیں۔ کوئی نہ چننے پر سب زبانیں دکھائی جاتی ہیں۔"),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "فیڈ میں ترجموں کے لیے اپنی بنیادی زبان منتخب کریں۔"),
      "send": MessageLookupByLibrary.simpleMessage("بھیجیں"),
      "sendConfirmation": MessageLookupByLibrary.simpleMessage("تصدیق بھیجیں"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("خرابی کی رپورٹ بھیجیں"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("رائے بھیجیں"),
      "sendReport": MessageLookupByLibrary.simpleMessage("رپورٹ بھیجیں"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("معاونت کو بھیجیں"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("سروس کی حالت"),
      "settings": MessageLookupByLibrary.simpleMessage("ترتیبات"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "ایپ لاگ معاونت کے ساتھ شیئر کریں"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Kyron میں سائن ان کریں"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("بطور سائن ان"),
      "signupFailed": (Object a0) => "سائن اپ نہیں ہو سکا: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("رکیں"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron ابھی ابتدائی مرحلے میں ہے، اور کسی ایسے شخص تک پہنچنے کا تیز ترین طریقہ جو واقعی اسے ٹھیک کر سکے، ٹکٹ کھولنا ہے۔ بتائیں آپ کیا کر رہے تھے اور کیا ہوا۔"),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "ایپ میں ابھی معاونت کا ان باکس نہیں ہے، اس لیے یہ اسکرین آپ کو ایسی جگہ لے جاتی ہے جس پر واقعی نظر رکھی جاتی ہے، نہ کہ کسی ایسے فارم پر جو کہیں نہیں جاتا۔"),
      "systemLog": MessageLookupByLibrary.simpleMessage("ایپ لاگ"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "بتائیں کیا کمی ہے یا کیا خراب ہے"),
      "terms": MessageLookupByLibrary.simpleMessage("سروس کی شرائط"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "متن، آواز اور ویڈیو، انہیں بنانے والے لوگ، اور وہ کمرے جہاں وہ بات کرتے ہیں۔"),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "ایڈیٹر میں پوسٹ کا بٹن نہیں ہے"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("گہرا"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("ہمیشہ گہرا"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("مدھم"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "نرم گہرا، سیاہ کے بجائے نیلا سرمئی"),
      "theme_light": MessageLookupByLibrary.simpleMessage("ہلکا"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("ہمیشہ ہلکا"),
      "theme_system": MessageLookupByLibrary.simpleMessage("سسٹم"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "فون کی ہلکی یا گہری ترتیب کے مطابق"),
      "translate": MessageLookupByLibrary.simpleMessage("ترجمہ کریں"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "ترجمہ ابھی آن نہیں ہے۔ آپ کی فیڈ میں ابھی کچھ ترجمہ نہیں ہوتا؛ تب تک یہ یاد رکھا جاتا ہے۔"),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "یہ Kyron کے اپنے الفاظ، انٹرفیس کے وہ حصے جو Flutter خود بناتا ہے، تاریخیں اور اعداد، اور دائیں سے بائیں لکھی جانے والی زبانوں کے لیے ایپ کی ترتیب کی سمت کو تبدیل کرتا ہے۔"),
      "tryAgain": MessageLookupByLibrary.simpleMessage("دوبارہ کوشش کریں"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("رازداری کی پالیسی"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("سروس کی شرائط"),
      "ui_account": MessageLookupByLibrary.simpleMessage("اکاؤنٹ"),
      "ui_after": MessageLookupByLibrary.simpleMessage("بعد"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("ایپ اور ڈیوائس"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "یہ اقتباس لوگوں کو فراڈ سے خبردار کرنے کے لیے تھا۔"),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "بتائیں کہ آپ کے خیال میں فیصلہ کیوں غلط تھا: پوسٹ کا مطلب کیا تھا، ٹیم سے کیا چھوٹ گیا ہو سکتا ہے، یا قاعدہ کیوں لاگو نہیں ہوتا۔ اسے فیصلہ کرنے والے کے علاوہ کوئی اور پڑھتا ہے۔"),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("آپ کی اپیل"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "کم از کم \$count حروف لکھیں۔ آپ ہر فیصلے پر ایک بار اپیل کر سکتے ہیں۔"),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("اپیل بھیجیں"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "اپیل بھیج دی گئی۔ فیصلہ ہونے پر آپ کو اطلاع ملے گی۔"),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("کیس \$number پر اپیل"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("ظاہری شکل"),
      "ui_appearance_detail":
          MessageLookupByLibrary.simpleMessage("ہلکا، گہرا یا فون کے مطابق"),
      "ui_before": MessageLookupByLibrary.simpleMessage("پہلے"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "آپ دونوں Kyron پر ایک دوسرے کو نہیں دیکھیں گے، اور آپ کے درمیان فالوز ہٹا دیے جائیں گے۔ انہیں بتایا نہیں جاتا۔"),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("اس میں شامل ہے"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("یہ کس لیے ہے (اختیاری)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("صرف ناظمین لکھ سکتے ہیں"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "اعلانات کے لیے۔ کمیونٹی میں سب اب بھی پڑھ اور ردعمل دے سکتے ہیں۔"),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("تصویر یا رائے شماری شامل کریں"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("تصاویر اور ویڈیوز"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("چیٹ بند کریں"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "اس میں کوئی بھی پڑھ یا لکھ نہیں سکے گا۔ اسے واپس نہیں لیا جا سکتا۔"),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("یہ چیٹ بند کریں؟"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("کاپی ہو گیا"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "پیغام سب کے لیے ہٹا دیا جاتا ہے۔ Kyron جائزے کے لیے ایک نقل رکھتا ہے۔"),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "پیغام چیٹ میں سب کے لیے ہٹا دیا جاتا ہے۔"),
      "ui_cchat_edit":
          MessageLookupByLibrary.simpleMessage("چیٹ میں ترمیم کریں"),
      "ui_cchat_edit_message":
          MessageLookupByLibrary.simpleMessage("ترمیم کریں"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("ترمیم شدہ"),
      "ui_cchat_editing": MessageLookupByLibrary.simpleMessage(
          "آپ اپنا پیغام ترمیم کر رہے ہیں"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("یہ چیٹ نہیں کھل سکی۔"),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("چیٹس"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("چیٹ میں شامل ہوں"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "کمیونٹی کی چیٹس دیکھنے اور ان میں حصہ لینے کے لیے کمیونٹی میں شامل ہوں۔"),
      "ui_cchat_joined": MessageLookupByLibrary.simpleMessage("شامل: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("چیٹ چھوڑیں"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "جب تک آپ کمیونٹی میں ہیں، آپ اسے پڑھ سکتے ہیں۔"),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "یہاں صرف مالک اور ناظمین لکھ سکتے ہیں۔"),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("خاموش کریں"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "اس سے کوئی اطلاعات نہیں آئیں گی، اور یہ پیغامات کی گنتی میں شامل نہیں ہوگی۔"),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("چیٹ کا نام"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("نئی چیٹ"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی چیٹ نہیں۔"),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "ابھی کوئی چیٹ نہیں۔ کمیونٹی کے لیے ایک کھولیں۔"),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "کمیونٹی چیٹس اینڈ ٹو اینڈ انکرپٹڈ نہیں ہیں۔ کمیونٹی کے ناظمین اور Kyron انہیں پڑھ سکتے ہیں۔"),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("اوپر پن کریں"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("جواب شامل کریں"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("رائے شماری بند کریں"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("بند"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "سب دیکھ سکتے ہیں کہ ہر جواب کتنوں نے چنا، کبھی یہ نہیں کہ کس نے۔"),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("کئی جوابات چننے دیں"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("نئی رائے شماری"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("ایک چنیں"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("جواب \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("رائے شماری: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("سوال"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "ہر جواب رائے شماری میں صرف ایک بار ہو سکتا ہے۔"),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("ایک یا زیادہ چنیں"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count نے جواب دیا"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("اس چیٹ میں تلاش کریں"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("اس چیٹ میں تلاش کریں"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("کچھ نہیں ملا۔"),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("آپ اب یہ چیٹ نہیں دیکھ سکتے۔"),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("سست موڈ"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "پیغامات کے درمیان کتنا انتظار کرنا ہے۔ ناظمین پر لاگو نہیں۔"),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 گھنٹہ"),
      "ui_cchat_slow_minutes": MessageLookupByLibrary.simpleMessage("منٹ: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "سست موڈ: ہر \$seconds سیکنڈ میں ایک پیغام"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("بند"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("سیکنڈ: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "آپ ناظر کے طور پر پڑھ اور ردعمل دے سکتے ہیں۔ لکھنے کے لیے شامل ہوں۔"),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "یہ پیغام دکھانے کے لیے بہت پرانا ہے۔"),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "آپ کی چنی ہوئی کوئی چیز بھیجنے کے لیے بہت بڑی ہے اور چھوڑ دی گئی۔"),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("آواز بحال کریں"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("ان پن کریں"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("صوتی پیغام ریکارڈ کریں"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("آپ"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("کمیونٹیز"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("یہ کس لیے ہے؟ (اختیاری)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("پوسٹس:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("مواد اور ڈسپلے"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("آپ کی فیڈ لوڈ نہیں ہو سکی"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "آپ کی پسند کی گئی پوسٹس لوڈ نہیں ہو سکیں"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("آپ کی پروفائل لوڈ نہیں ہو سکی"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "آپ کی محفوظ کردہ پوسٹس لوڈ نہیں ہو سکیں"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("غیر مرکزی ID"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("خرابیوں کا ازالہ"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("گروپس"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("کوئی گروپ نہیں"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "جن گروپس میں آپ ہیں اور جن کمیونٹی چیٹس میں آپ شامل ہوتے ہیں، وہ یہاں دکھائے جاتے ہیں۔"),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "آپ زیادہ سے زیادہ \$count چیٹس پن کر سکتے ہیں۔ پہلے ایک کو ان پن کریں۔"),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("پن شدہ"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("پسندیدہ"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("محفوظ شدہ"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("یہاں ابھی کچھ نہیں"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "کچھ اکاؤنٹس فالو کریں اور ان کی پوسٹس یہاں دکھائی دیں گی۔"),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "جنہیں آپ فالو کرتے ہیں ان سے کچھ نہیں"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "جیسے جیسے لوگ لکھیں گے، پوسٹس یہاں دکھائی دیں گی۔"),
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("مدھم ہو رہا ہے"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("دلچسپی نہیں"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("اس جیسی مزید دکھائیں"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("ہٹا دیا گیا"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("آپ کے فیڈ سگنلز"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "کسی پوسٹ پر اس جیسی مزید پوسٹس دکھائیں یا اس میں دلچسپی نہیں پر ٹیپ کریں، اور یہ یہاں نظر آئے گی۔"),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("یہاں ابھی کچھ نہیں"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "مزید دکھائیں اور دلچسپی نہیں آپ کی فیڈز کو کیا بتا رہے ہیں"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "یہ ہوم اور ایکسپلور کو تشکیل دیتے ہیں، زیادہ تر اس بات سے کہ ہر پوسٹ کس بارے میں تھی۔ ہر ایک ہر مہینے آدھا ہو جاتا ہے اور چھ ماہ کے بعد شمار نہیں ہوتا۔ ابھی روکنے کے لیے ایک ہٹائیں۔"),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "کلپ والی پوسٹس یہاں دکھائی دیں گی۔"),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی ویڈیو نہیں"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("رائے"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Kyron پر لوگ تلاش کریں"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("کسی اکاؤنٹ سے"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("لوگ شامل کریں"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("شامل کریں"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("گروپ کا نام شامل کریں"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("مسترد کریں"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "اس گروپ کے پیغامات کسی بھی دوسری گفتگو کی طرح اینڈ ٹو اینڈ انکرپٹڈ ہیں۔"),
      "ui_group_event_added": MessageLookupByLibrary.simpleMessage(
          "\$actor نے \$users کو شامل کیا"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor نے \$users کو ایڈمن بنایا"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor نے گروپ بنایا"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor نے نئے لوگوں کو بطور ممبر شامل ہونے پر رکھا"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor نے نئے لوگوں کو بطور ناظر شامل ہونے پر رکھا"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor چلے گئے"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor نے \$users کو ممبر بنایا"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor نے \$users کو مالک بنایا"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor نے \$users کو ہٹایا"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor نے گروپ کا نام بدل کر \$title رکھا"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor نے \$users کو ناظر بنایا"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "ایک گروپ میں زیادہ سے زیادہ \$count لوگ ہو سکتے ہیں۔"),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "ہاتھ اٹھا دیا گیا۔ ایڈمنز کو بتا دیا گیا ہے۔"),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count لکھنا چاہتے ہیں"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("لکھنا چاہتے ہیں"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "بعد میں شامل کیے گئے لوگ بطور ناظر شامل ہوتے ہیں"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("گروپ چھوڑیں"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "یہ آپ کی فہرست سے ہٹ جائے گا اور آپ بعد کی باتیں نہیں دیکھیں گے۔ کسی کو آپ کو دوبارہ شامل کرنا ہوگا۔"),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("یہ گروپ چھوڑیں؟"),
      "ui_group_let_write": MessageLookupByLibrary.simpleMessage("لکھنے دیں"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("ہاتھ نیچے کریں"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("ایڈمن بنائیں"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("مالک بنائیں"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("ناظر بنائیں"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count ممبرز"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("ممبرز"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("گروپ کا نام"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("پہلے گروپ کا نام رکھیں۔"),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("گروپ چیٹ بنائیں"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "مالک ایک ہی ہوتا ہے۔ آپ ایڈمن رہیں گے۔"),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("\$name کو مالک بنائیں؟"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("ہاتھ اٹھائیں"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("گروپ سے ہٹائیں"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("ایڈمن سے ہٹائیں"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("آپ اب اس گروپ میں نہیں ہیں۔"),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("نام بدلیں"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("ایڈمن"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("ممبر"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("ناظر"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "بطور ناظر آپ یہاں پڑھ اور ردعمل دے سکتے ہیں۔"),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "ناظر پڑھ سکتے ہیں، ردعمل دے سکتے ہیں اور لکھنے کی اجازت کے لیے ہاتھ اٹھا سکتے ہیں۔"),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("تجاویز"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("پروفائل دیکھیں"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("آپ"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("آپ ناظر ہیں"),
      "ui_help": MessageLookupByLibrary.simpleMessage("مدد"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "نوٹ کر لیا گیا۔ اس سے یہ چننے میں مدد ملتی ہے کہ آپ کو کیا دکھایا جائے۔"),
      "ui_join": MessageLookupByLibrary.simpleMessage("شامل ہوں"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("شامل ہوئے"),
      "ui_language": MessageLookupByLibrary.simpleMessage("زبان"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("اپنی زبان منتخب کریں"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("قانونی"),
      "ui_like": MessageLookupByLibrary.simpleMessage("پسند"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("پسند کی گئی پوسٹس"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "آپ کی پسند کی گئی پوسٹس یہاں دکھائی دیتی ہیں، نئی پہلے۔"),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("لنک کاپی ہو گیا"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "آپ اب ان کی پوسٹس نہیں دیکھیں گے۔ انہیں بتایا نہیں جاتا۔"),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی لائک نہیں"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "ان فلٹرز سے کوئی پوسٹ مماثل نہیں۔"),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("ابھی کچھ محفوظ نہیں"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("آپ کا اکاؤنٹ اپ ڈیٹ ہو گیا"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "کیس \$number پر آپ کی اپیل منظور ہو گئی"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "ہم نے کیس \$number پر آپ کی اپیل کا دوبارہ جائزہ لیا، اور فیصلہ برقرار ہے"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "آپ کا اکاؤنٹ مستقل طور پر بند کر دیا گیا"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("کیس \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("نے آپ کو فالو کیا"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("نے آپ کی پوسٹ پسند کی"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("نے آپ کا ذکر کیا"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی ذکر نہیں"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "جب کوئی کسی پوسٹ یا جواب میں آپ کا @ہینڈل لکھے گا، تو وہ یہاں نظر آئے گا۔"),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("پرانے"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "کمیونٹی چیٹ میں آپ کا پیغام ہٹا دیا گیا"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "آپ کی شائع کی ہوئی کوئی چیز ہٹا دی گئی"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("آپ کی پوسٹ ہٹا دی گئی"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("آپ کا جواب ہٹا دیا گیا"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("نے آپ کی پوسٹ کا جواب دیا"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "ہم نے آپ کی رپورٹ کردہ چیز پر کارروائی کی۔ بتانے کا شکریہ۔"),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "ہم نے آپ کی رپورٹ کردہ چیز کا جائزہ لیا اور اسے اپنے قواعد کی خلاف ورزی نہیں پایا۔"),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("رپورٹ کی وجہ: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("نے آپ کی پوسٹ دوبارہ شیئر کی"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "ہم نے کیس \$number کا فیصلہ واپس لے لیا"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("آپ کا اکاؤنٹ معطل ہے"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "آپ کا اکاؤنٹ \$date تک معطل ہے"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("سب"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("فالوورز"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("پسندیدگیاں"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("ذکر"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("جوابات"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("اس ہفتے"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("آج"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("آپ کے اکاؤنٹ کو انتباہ ملا ہے"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("کل"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("ہو گیا"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("چھوڑیں"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("یہ پہلے ہی کھولا جا چکا ہے۔"),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("میعاد ختم"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("یہ کھولا نہیں جا سکا۔"),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "ایک بار کھلتا ہے، پھر Kyron سے حذف ہو جاتا ہے۔"),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("ایک بار دیکھیں"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("کھول لیا گیا"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "\$total میں سے \$count نے کھولا"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "صرف وہی لوگ جنہیں آپ نے بھیجا ہے اسے ایک بار کھول سکتے ہیں۔"),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("ایک بار دیکھنے کے لیے بھیجیں"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("دیکھنے کے لیے تھپتھپائیں"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("توقف"),
      "ui_play": MessageLookupByLibrary.simpleMessage("چلائیں"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "اسے آپ کی پروفائل اور سب کی فیڈز سے ہٹا دیا جائے گا۔ اس کے جوابات بھی اس کے ساتھ چلے جائیں گے۔"),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("پوسٹ حذف کر دی گئی"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("پوسٹ چھپا دی گئی"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("پوسٹ کا متن کاپی ہو گیا"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("اس دوران پوسٹ کیا گیا"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "چھپا دیا گیا۔ ہم ایسی کم دکھائیں گے۔"),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("ترجیحات"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("رازداری"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "کچھ اور شامل کرنا ہے؟ (اختیاری)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "جب ٹیم فیصلہ کرے گی تو آپ کو اطلاع ملے گی، اور آپ اسے اپنی رپورٹس میں دیکھ سکتے ہیں۔"),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "اگر آپ اس شخص کو بھی نہیں دیکھنا چاہتے تو اسی مینو سے اسے میوٹ یا بلاک کر سکتے ہیں۔"),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "ایک ہی چیز کو دو بار رپورٹ کرنے سے اس کا وزن نہیں بڑھتا: ہم ہر شخص کی ایک رپورٹ رکھتے ہیں۔"),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "آپ کی رپورٹ اس شخص کے ساتھ شیئر نہیں کی جاتی۔ ہم رپورٹ کی گئی چیز کی ایک کاپی رکھتے ہیں تاکہ حذف ہونے کے بعد بھی اس کا جائزہ لیا جا سکے۔"),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "آپ کی رپورٹ موصول ہو گئی ہے اور جائزے کی قطار میں ہے۔ ہم اس شخص کو نہیں بتاتے کہ رپورٹ کس نے کی۔"),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("اپنی رپورٹس دیکھیں"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("ہمیں بتائیں کہ کیا غلط ہے"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("بتانے کا شکریہ"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("\$name میں کیا مسئلہ ہے؟"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("اس پیغام میں کیا مسئلہ ہے؟"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("اس پوسٹ میں کیا مسئلہ ہے؟"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("اس جواب میں کیا مسئلہ ہے؟"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("کمیونٹی چیٹ کا ایک پیغام"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("ایک پوسٹ"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("ایک جواب"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("کارروائی کی گئی"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("ایک اکاؤنٹ"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("فیصلہ \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("کوئی قاعدہ نہیں ٹوٹا"),
      "ui_reports_failed":
          MessageLookupByLibrary.simpleMessage("آپ کی رپورٹس لوڈ نہیں ہو سکیں"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "پچھلے 90 دنوں میں آپ نے کیا رپورٹ کیا اور اس کا کیا نتیجہ نکلا۔ ٹیم کے فیصلے پر آپ کو اطلاع ملتی ہے۔ جسے آپ رپورٹ کرتے ہیں اسے کبھی پتا نہیں چلتا کہ رپورٹ کس نے کی۔"),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("کوئی رپورٹ نہیں"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "جب آپ کسی پوسٹ، جواب، پیغام یا اکاؤنٹ کو رپورٹ کرتے ہیں، تو وہ یہاں نتیجے کے ساتھ دکھایا جاتا ہے۔"),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("زیرِ جائزہ"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("رپورٹ کیا گیا \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "آپ نے کیا رپورٹ کیا اور اس کا کیا نتیجہ نکلا"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("آپ کی رپورٹس"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("بچوں کی حفاظت"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "کوئی بھی چیز جو کسی نابالغ کو خطرے میں ڈالے یا اسے جنسی انداز میں پیش کرے۔"),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "نشانہ بنا کر بدسلوکی، دھمکیاں یا ناپسندیدہ رابطہ۔"),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "لوگوں پر ان کی شناخت کی وجہ سے حملے۔"),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "کسی غیر قانونی چیز کی فروخت یا تشہیر۔"),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("کسی اور ہونے کا دعویٰ کرنا۔"),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "آپ کا کام یا ٹریڈ مارک اجازت کے بغیر استعمال کرتا ہے۔"),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "صحت، انتخابات یا واقعات کے بارے میں گمراہ کن دعوے۔"),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "خود کو نقصان پہنچانے کی ترغیب یا اس کی عکاسی۔"),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "بغیر انتباہ کے دکھایا گیا جنسی مواد۔"),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "ان میں سے کوئی نہیں۔ ہمیں بتائیں کہ کیا غلط ہے۔"),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "بار بار، گمراہ کن یا ناپسندیدہ تشہیر۔"),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "تشدد کی دھمکی، اس کی تعریف یا اس پر اکسانا۔"),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("ہراسانی یا دھونس"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("نفرت انگیز تقریر"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("غیر قانونی اشیا یا خدمات"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("کسی اور کا روپ دھارنا"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("دانشورانہ ملکیت"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("غلط معلومات"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "خودکشی یا خود کو نقصان پہنچانا"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("بالغوں کے لیے مواد"),
      "ui_rule_something_else": MessageLookupByLibrary.simpleMessage("کچھ اور"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("اسپام"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("تشدد یا دھمکیاں"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("محفوظ کردہ پوسٹس"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "کسی پوسٹ کو یہاں رکھنے کے لیے اس کے آرکائیو آئیکن پر ٹیپ کریں۔ محفوظ چیزیں صرف آپ کو نظر آتی ہیں۔"),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "ہینڈل یا ڈسپلے نام سے تلاش کریں۔"),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("صاف کریں"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "پوسٹ کی گئی ہر چیز میں تلاش کریں"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("فلٹرز"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("لوگ تلاش کریں"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("پوسٹس تلاش کریں"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("ترتیبات"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("ایپ اور ڈیوائس"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("مواد اور ڈسپلے"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("ڈیٹا سیور"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("اپنی رائے دیں"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("مدد کے مضامین دیکھیں"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("اپنی زبان منتخب کریں"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "آپ نے کسے خاموش یا بلاک کیا ہے"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("اطلاعات کی ترجیحات"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "آپ کی پروفائل اور رابطے کی تفصیلات"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "اپنے اکاؤنٹ میں واپس آنے کے لیے آپ کو دوبارہ سائن ان کرنا ہوگا۔"),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("سیکیورٹی ترتیبات"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ کی تصدیق کریں"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("ایک سطر میں"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("نیا ای میل پتہ"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("نیا پاس ورڈ"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("کیا ہوا"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("ہماری ٹیم سے مدد لیں"),
      "ui_share": MessageLookupByLibrary.simpleMessage("شیئر کریں"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("اقتباس کریں"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("پیغام میں بھیجیں"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron پر لوگوں کو"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("یہ پوسٹ شیئر کریں"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("معاملہ کیا تھا"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "آپ کا اکاؤنٹ مستقل طور پر بند ہے"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("جواب، \$date کو:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("اپیل"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("اس فیصلے پر اپیل کریں"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "اس فیصلے پر اب اپیل نہیں ہو سکتی۔ اگر کچھ غلط ہے تو سپورٹ سے رابطہ کریں۔"),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("اپیل زیرِ غور ہے"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("اپیل منظور ہو گئی"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "ٹیم کا کوئی اور رکن اسے دوبارہ دیکھ رہا ہے۔ فیصلہ ہونے پر آپ کو اطلاع ملے گی۔"),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "اگر آپ کے خیال میں یہ غلطی تھی تو آپ \$date تک دوبارہ جائزے کی درخواست کر سکتے ہیں۔ فیصلہ ٹیم کا کوئی اور رکن کرتا ہے۔"),
      "ui_standing_appeal_upheld":
          MessageLookupByLibrary.simpleMessage("اپیل کے بعد: فیصلہ برقرار ہے"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "کیس \$number۔ قاعدہ: \$rule۔ ٹیم نے لکھا:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "اکاؤنٹ حذف کرنے سے پابندی ختم نہیں ہوتی: اسی ای میل پتے والا نیا اکاؤنٹ بھی پابندی کے ساتھ شروع ہوتا ہے۔"),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("مستقل پابندی"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "صرف یہ صفحہ، اپیلیں، سپورٹ اور اکاؤنٹ حذف کرنا اب بھی کام کرتے ہیں۔"),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("اپیل ہو سکتی ہے"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("کیس \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("فیصلہ \$date کو ہوا"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "آپ کے اکاؤنٹ کے بارے میں فیصلے"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("اپنا اکاؤنٹ حذف کریں"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("تفصیلات دیکھیں"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("تفصیلات دیکھیں اور اپیل کریں"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("\$date کو ختم ہوگا"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("آپ کا اکاؤنٹ اچھی حالت میں ہے"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("اس پر کوئی پابندی نہیں۔"),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "اکاؤنٹ کی حالت لوڈ نہیں ہو سکی"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("پیغام ہٹا دیا گیا"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "آپ کے اکاؤنٹ کے بارے میں کوئی فیصلہ نہیں ہوا۔ اگر ٹیم کبھی آپ کی کوئی چیز ہٹائے یا آپ کے اکاؤنٹ پر پابندی لگائے تو وہ وجہ کے ساتھ یہاں درج ہوگی، اور آپ اپیل کر سکیں گے۔"),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "اپیل کے لیے کچھ نہیں: فیصلہ واپس لے لیا گیا۔"),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("پوسٹ ہٹا دی گئی"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "دوبارہ چیک کرنے کے لیے نیچے کھینچیں۔"),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Kyron کے قواعد پڑھیں"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("جواب ہٹا دیا گیا"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("واپس لیا گیا"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "\$date کو واپس لیا گیا۔ جو کچھ ہٹایا گیا تھا وہ واپس آ گیا ہے، اور اب کوئی پابندی لاگو نہیں۔"),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("قاعدہ: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("سائن آؤٹ"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("معطل"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "آپ پڑھ سکتے ہیں، لیکن پوسٹ، جواب، فالو یا پیغام نہیں بھیج سکتے۔ رپورٹ، بلاک اور میوٹ اب بھی کام کرتے ہیں۔"),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "آپ کا اکاؤنٹ معطل ہے: آپ پڑھ سکتے ہیں، لیکن پوسٹ نہیں کر سکتے۔"),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("\$date تک معطل"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "آپ کا اکاؤنٹ \$date تک معطل ہے: آپ پڑھ سکتے ہیں، لیکن پوسٹ نہیں کر سکتے۔"),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("ٹیم نے کیا لکھا"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("اکاؤنٹ کی حالت"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("انتباہ"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("کیوں؟"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("آپ نے \$date کو لکھا:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("آپ کا پیغام"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("آپ کی پوسٹ"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("آپ کا جواب"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("سروس کی شرائط"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("یہ پوسٹ"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("تھریڈ خاموش کر دیا گیا"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("دوبارہ کوشش کریں"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("آواز بند کریں"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("آواز آن کریں"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("کم از کم دو حروف۔"),
      "ui_undo": MessageLookupByLibrary.simpleMessage("کالعدم کریں"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "الفاظ، یا فلٹر: کوئی اکاؤنٹ، تاریخ کی حد، یا پوسٹ میں کیا ہے۔"),
      "undoRepost": MessageLookupByLibrary.simpleMessage("ری پوسٹ واپس لیں"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("پاس ورڈ اپ ڈیٹ کریں"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("کوئی دوسرا پتہ استعمال کریں"),
      "username": MessageLookupByLibrary.simpleMessage("صارف نام"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "صارف نام چھوٹے حروف میں ہونا چاہیے (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("ویڈیو"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("منسلک کریں"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("منسلک کرنے کے لیے تیار"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("صوتی پوسٹ ریکارڈ کریں"),
      "voice_recording":
          MessageLookupByLibrary.simpleMessage("محفوظ ہو رہا ہے…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("روکیں"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("کیا ہوا"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "کیا ہوا، اور ہمیں کیا دیکھنا چاہیے؟",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("اس تصویر میں کیا ہے؟"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("یہ کس لیے ہے؟ (اختیاری)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "آپ نے کیا کیا، کیا توقع تھی، کیا ہوا"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "جب یہ ہوا تو آپ کیا کر رہے تھے۔"),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("آپ نے جواب دیا"),
      "dmReplied": (Object a0) => "$a0 نے جواب دیا",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("پیغام میں شامل کریں"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("نیا پیغام"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "ابھی تک کچھ نہیں کہا گیا۔ ہاتھ ہلانا ایک اچھی شروعات ہے۔"),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  ہاتھ ہلائیں"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("نئے پیغامات"),
      "dmTyping": (Object a0) => "$a0 ٹائپ کر رہے ہیں",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("اپنا ردعمل ہٹائیں"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("کوئی"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("پیغام"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("منسلکہ"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "یہ پیغام اس آلے پر نہیں پڑھا جا سکتا۔"),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "اس پیغام کا انتظار ہے۔ اس میں کچھ وقت لگ سکتا ہے۔"),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("مرموز کردہ پیغام"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "پیغامات اینڈ ٹو اینڈ مرموز ہیں"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("اینڈ ٹو اینڈ مرموز نہیں"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("بھیج دیا گیا"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("دیکھ لیا گیا"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("بھیجا جا رہا ہے…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("تصویر لیں"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("مزید اختیارات"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("آلے میں محفوظ کریں"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("شیئر کریں"),
      "ui_media_saving":
          MessageLookupByLibrary.simpleMessage("محفوظ ہو رہا ہے…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("آپ کی تصاویر میں محفوظ ہو گیا"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "محفوظ نہیں ہو سکا۔ دوبارہ کوشش کریں۔"),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "اسے محفوظ کرنے کے لیے Kyron کو اپنی تصاویر میں شامل کرنے کی اجازت دیں۔"),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("تمام نظام کام کر رہے ہیں"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("اپ ٹائم"),
      "ui_status_last_60": MessageLookupByLibrary.simpleMessage("پچھلے 60 دن"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 دن پہلے"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("آج"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("ڈیٹا بیس"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("سائن ان"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("حالیہ واقعات"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "پچھلے 60 دنوں میں کوئی واقعہ نہیں ہوا۔"),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("جاری ہے"),
      "ui_status_no_data":
          MessageLookupByLibrary.simpleMessage("کوئی ڈیٹا نہیں"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("تفصیلات"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron چلتے ہوئے ہر 5 منٹ بعد اپنی جانچ کرتا ہے۔ سرمئی دن کوئی جانچ نہیں ہوئی۔"),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "اپ ٹائم کی تاریخ ابھی دستیاب نہیں۔"),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("کچھ نظاموں میں مسائل ہیں"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("وائس نوٹ ریکارڈ کریں"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("بھیجنے کے لیے تیار"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("وہ پیغام اب یہاں نہیں ہے۔"),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("پیغام پر جائیں"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("وائس نوٹ"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("مصنف کو پسند آیا"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("تصویر یا کلپ شامل کریں"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("میڈیا"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("وائس نوٹس"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("چیٹ"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("وال پیپر"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("اطلاعات خاموش کریں"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "اس گفتگو کے بارے میں اطلاعات لینا بند کریں"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "وہ اب آپ کو پیغام نہیں بھیج سکتے"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("کوئی نہیں"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("تصویر"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("آواز بحال کر دی گئی۔"),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "ہٹایا نہیں جا سکا۔ دوبارہ کوشش کریں۔"),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("پروفائل"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("آواز بحال کریں"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "آپ جو تصاویر اور کلپس شیئر کرتے ہیں وہ یہاں دکھائی دیتی ہیں۔"),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("سب دیکھیں"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("تصاویر اور کلپس"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("آپ کی چیٹ ایسی دکھائی دے گی۔"),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("اچھا لگ رہا ہے۔"),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("دھند"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("شام"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("سیج"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("ریت"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("نقطے"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("لاگو کریں"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("موجودہ"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("پیش منظر کے بغیر بھیجیں"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("تلاش کریں"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("پوسٹ کریں"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("پیغام لکھیں…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("بھیجیں"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("بھیج دیا گیا"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "بھیج دیا گیا، لیکن سب کو نہیں۔"),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "بھیجا نہیں جا سکا۔ دوبارہ کوشش کریں۔"),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("فالوور"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("فلٹر"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("سب"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("بغیر پڑھے"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("بغیر جواب"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("چھپائے گئے"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("کچھ چھپایا نہیں گیا"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "جو گفتگو آپ اپنی فہرست سے ہٹاتے ہیں وہ یہاں انتظار کرتی ہیں، اگر آپ انہیں واپس چاہیں۔"),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "یہ چھپائے گئے میں چلی جاتی ہے۔ دوسرا شخص اپنی گفتگو رکھتا ہے، اور اگر آپ میں سے کوئی دوبارہ لکھے تو یہ واپس آ جاتی ہے۔"),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("واپس رکھیں"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("دوبارہ آپ کی فہرست میں۔"),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("کوئی مماثل گفتگو نہیں۔"),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("آپ کا کوئی انتظار نہیں کر رہا"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "ہر گفتگو آپ کے لفظ پر ختم ہوتی ہے۔"),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("تصویر"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("تصاویر"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("ویڈیو"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی پیغام نہیں"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("آپ:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("کل"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("پیغامات"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("پیغام کی ترتیبات"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("رازداری"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("پڑھنے کی رسیدیں"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "جب یہ بند ہو تو لوگ نہیں دیکھ سکیں گے کہ آپ نے ان کے پیغامات کب پڑھے، اور آپ بھی نہیں دیکھ سکیں گے کہ انہوں نے آپ کے کب پڑھے۔"),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("ٹائپ کرتے وقت دکھائیں"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "جس شخص کو آپ لکھ رہے ہیں وہ دیکھتا ہے کہ آپ لکھ رہے ہیں۔"),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("لنک کے پیش منظر"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "پیش منظر بنانے کے لیے آپ کا فون آپ کا بھیجا ہوا لنک کھولتا ہے، اس لیے سائٹ آپ کے فون کی درخواست دیکھتی ہے۔ Kyron کا سرور لنک کبھی نہیں دیکھتا۔"),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("پیغامات کی اطلاعات"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "پیغامات اینڈ ٹو اینڈ انکرپٹڈ ہیں۔ Kyron انہیں نہیں پڑھ سکتا، اور یہاں کی کوئی چیز اسے نہیں بدلتی۔"),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("بنام:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("حالیہ"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("لوگ"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("اس نام کا کوئی نہیں۔"),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("آزمائشی اطلاع بھیجیں"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron کا سرور ابھی اطلاعات بھیجنے کے لیے ترتیب نہیں دیا گیا، اس لیے کوئی اطلاع نہیں پہنچ سکتی۔ مسئلہ ہماری طرف ہے، آپ کے فون میں نہیں۔"),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "یہ فون اطلاعات کے لیے رجسٹرڈ نہیں ہے۔ فون کی ترتیبات میں دیکھیں کہ Kyron کی اطلاعات کی اجازت ہے، پھر دوبارہ کوشش کریں۔"),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "اطلاع اس فون تک نہیں پہنچائی جا سکی۔ ایک منٹ بعد دوبارہ کوشش کریں۔"),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "بھیج دی گئی۔ چند سیکنڈ میں پہنچ جانی چاہیے۔"),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("اطلاعات کام کر رہی ہیں۔"),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("ابھی کوئی پوسٹ نہیں"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("نئی کمیونٹی"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("نام"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("اس کا پتہ نام سے بنتا ہے۔"),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("لوگ اسے یہاں پائیں گے:"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "آپ اس کے مالک ہوں گے۔ بننے کے بعد اس کے صفحے سے تصویر، بینر اور ناظم شامل کیے جا سکتے ہیں۔"),
      "ui_community_settings_home": MessageLookupByLibrary.simpleMessage("ہوم"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("ہوم میں کمیونٹی کی پوسٹس"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "آپ کی کمیونٹیز کی پوسٹس ہوم میں بھی نظر آتی ہیں۔ بند ہونے پر وہ یہیں کمیونٹیز میں رہتی ہیں، جہاں ہر ایک دکھاتی ہے کہ نیا کیا ہے۔"),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("آپ کی فہرست"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("نئی پوسٹس کی تعداد"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "دکھائیں کہ آخری بار کھولنے کے بعد سے ہر کمیونٹی میں کتنی پوسٹس نئی ہیں۔"),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("آپ کی چلائی کمیونٹیز"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "جو کمیونٹیز آپ شروع کرتے ہیں یا جن کی نظامت کرتے ہیں وہ یہاں ہیں۔"),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("مالک"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("ناظم"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("نئی پوسٹس"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("آپ کی چلائی"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("کمیونٹی کی ترتیبات"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("دریافت کریں"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("کوئی مماثل کمیونٹی نہیں۔"),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("کچھ نیا نہیں"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "ہر کمیونٹی ویسی ہی ہے جیسی آپ نے چھوڑی تھی۔"),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("آپ ابھی کوئی نہیں چلاتے"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("شامل ہونے کو کچھ نہیں بچا"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "آپ Kyron کی ہر کمیونٹی میں ہیں۔ ایک اور شروع کریں۔"),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "کوئی اور لفظ آزمائیں، یا اس نام سے کمیونٹی شروع کریں۔"),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("پوسٹ لکھیں"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("اراکین:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("پوسٹ ہو گئی"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("دیکھیں"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("کھولیں"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("آن لائن"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("آن لائن ہونے پر دکھائیں"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "جن لوگوں کو آپ پیغام بھیجتے ہیں، وہ آپ کے Kyron کھلا ہونے پر ایک سبز نقطہ دیکھتے ہیں۔ جب یہ بند ہو تو آپ بھی ان کا نہیں دیکھ سکیں گے۔"),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("لوگ اور پوسٹس تلاش کریں"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("شامل ہونے کے لیے کمیونٹیز"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("ابھی دیکھنے کو کچھ نہیں"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "لوگ جو تصاویر اور کلپس پوسٹ کرتے ہیں وہ یہاں نظر آئیں گی۔"),
      "ui_follow": MessageLookupByLibrary.simpleMessage("فالو کریں"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("اکاؤنٹ حذف کریں"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "اس سے آپ کا Kyron اکاؤنٹ مستقل طور پر حذف ہو جائے گا۔ اسے واپس نہیں لایا جا سکتا۔"),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "آپ کی پروفائل، پوسٹس، جوابات، لائکس اور ری پوسٹس"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "آپ کے پیغامات، دوسروں کو بھیجے گئے پیغامات سمیت، اور ان میں موجود تصاویر اور وائس نوٹس"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "آپ کے فالوورز، وہ لوگ جنہیں آپ فالو کرتے ہیں، اور آپ کی ترتیبات"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "آپ کی شروع کی گئی کمیونٹیز سب سے پرانے موڈریٹر یا رکن کو سونپ دی جائیں گی۔ جس میں کوئی اور نہ ہو وہ بند کر دی جائے گی۔"),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("اپنا اکاؤنٹ حذف کریں؟"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "آپ اس میں سے کچھ بھی واپس حاصل نہیں کر سکیں گے۔"),
      "ui_delete_account_done": MessageLookupByLibrary.simpleMessage(
          "آپ کا اکاؤنٹ حذف کر دیا گیا ہے۔"),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("حذف شدہ اکاؤنٹ"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "یہ اکاؤنٹ حذف ہو چکا ہے، اس لیے یہاں مزید پیغامات نہیں بھیجے جا سکتے۔"),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google سے سائن اپ کیا تھا؟ اس کے بجائے «Sign in with Google» استعمال کریں۔"),
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("یہ لینز لوڈ نہیں ہو سکا۔"),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("ویڈیو ریکارڈ نہیں ہو سکی۔"),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "لینز اس ویڈیو میں شامل نہیں ہو سکا، اس لیے یہ ویسے ہی پوسٹ ہو گی جیسے فلمائی گئی۔"),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "آپ کی پوسٹ میں پہلے ہی زیادہ سے زیادہ اٹیچمنٹس ہیں۔"),
      "ar_applying_lens": MessageLookupByLibrary.simpleMessage(
          "آپ کا لینز شامل کیا جا رہا ہے…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("فلیش"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("ویڈیو ریکارڈ کریں"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("تصویر"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("ویڈیو"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Google سائن اِن منسوخ کر دیا گیا۔"),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("تحائف"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "ابھی تک کسی نے اس پوسٹ کو تحفہ نہیں بھیجا۔"),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("تحفہ"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("تحائف"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("سکے"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("بھیجنے والا"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("بھیجنے والے"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "آزمائشی سکے: ابھی نکالے نہیں جا سکتے۔"),
      "ui_saved": MessageLookupByLibrary.simpleMessage("محفوظ شدہ"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("پوسٹس"),
      "ui_saved_tab_comments": MessageLookupByLibrary.simpleMessage("تبصرے"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("مزید جوابات دیکھیں"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("ترمیم شدہ"),
      "ui_more": MessageLookupByLibrary.simpleMessage("مزید"),
      "ui_following": MessageLookupByLibrary.simpleMessage("فالو کردہ"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("نمایاں"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("تازہ ترین"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("تبصروں کی ترتیب: \$order"),
      "ui_notif_gift":
          MessageLookupByLibrary.simpleMessage("نے آپ کی پوسٹ کو تحفہ بھیجا"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "نے آپ کے تبصرے کو \$gift بھیجا"),
      "ui_notif_gift_named":
          MessageLookupByLibrary.simpleMessage("نے آپ کی پوسٹ کو \$gift بھیجا"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("تحفہ بھیجیں"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("پوسٹ میں ترمیم کریں"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "آپ مزید \$n منٹ تک اس میں ترمیم کر سکتے ہیں"),
      "ui_save": MessageLookupByLibrary.simpleMessage("محفوظ کریں"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "#\$tab کے تحت ابھی کچھ پوسٹ نہیں ہوا۔"),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("ایک تحفہ چنیں"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("سکے کافی نہیں"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "آزمائشی سکے: یہ خریدے نہیں جا سکتے اور ان کی کوئی نقد قیمت نہیں۔"),
      "ui_gift_refills_on": MessageLookupByLibrary.simpleMessage(
          "\$date کو دوبارہ بھر جائیں گے۔"),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 سکہ"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count سکے"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("آپ کے پاس \$coins ہیں"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift بھیجیں"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift بھیج دیا گیا"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("دوبارہ کوشش کریں"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("پوسٹ کرنے کے بعد 15 منٹ تک"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("ترمیم ہو گئی"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "آپ کے محفوظ کردہ تبصرے لوڈ نہیں ہو سکے"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("کوئی محفوظ تبصرہ نہیں"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "کسی تبصرے کے نیچے آرکائیو آئیکن پر ٹیپ کریں تاکہ اسے یہاں رکھ سکیں۔ آپ جو محفوظ کرتے ہیں وہ صرف آپ دیکھ سکتے ہیں۔"),
      "ui_replying_to": MessageLookupByLibrary.simpleMessage("\$name کو جواب"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("کاپی کریں"),
      "ui_search": MessageLookupByLibrary.simpleMessage("تلاش کریں"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("سب منتخب کریں"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count تحائف"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 تحفہ"),
      "ui_feed_more_failed":
          MessageLookupByLibrary.simpleMessage("مزید پوسٹس لوڈ نہیں ہو سکیں۔"),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("یاد دہانیاں"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "آپ کی غیر موجودگی کے بعد نیا کیا ہے، اور جب آپ کے سکے واپس آئیں۔ دن میں ایک سے زیادہ کبھی نہیں۔"),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("تحائف"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("1 شخص سے"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count لوگوں سے"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("سب سے بڑا تحفہ دینے والا"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "تحفے بھیجنے والے لوڈ نہیں ہو سکے۔"),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("نیا کیا ہے"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("سمجھ گیا"),
      "ui_check_in_thanks":
          MessageLookupByLibrary.simpleMessage("شکریہ۔ ہم ہر جواب پڑھتے ہیں۔"),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("اب تک Kyron کیسا لگا؟"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "آپ کے ٹیسٹ کا دن \$day۔ ایک ٹیپ کافی ہے۔"),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "کچھ ٹھیک کرنا یا شامل کرنا چاہیے؟ (اختیاری)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("بھیجیں"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("ابھی نہیں"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Kyron چھوڑنے کے لیے دوبارہ واپس دبائیں"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("تصدیق کریں کہ یہ آپ ہیں"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "اپنا اکاؤنٹ حذف کرنے کے لیے پاس ورڈ درج کریں۔"),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "اپنا اکاؤنٹ حذف کرنے کے لیے دوبارہ Google سے سائن ان کریں۔"),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "یہ کام نہیں ہوا۔ جانچ کر دوبارہ کوشش کریں۔"),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "یہ صفحہ کوئی دوسری ایپ کھولنا چاہتا ہے"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "یہ {scheme} لنک کھولنے کا کہہ رہا ہے۔"),
    };

final messageLookup = MessageLookup();
