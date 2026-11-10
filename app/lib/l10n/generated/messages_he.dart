import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'he';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("מילה, ביטוי או #תג"),
      "about": MessageLookupByLibrary.simpleMessage("אודות"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("הוספת תשובה"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage("הוספת שפות…"),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage("הסכמה והמשך"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("כבר יש לכם חשבון Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("תגובות"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage("אנשים שונים, לא פתיחות"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("מעורבות"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("לייקים"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("עדיין אין צופים"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "אף אחד עוד לא פתח את הפוסט הזה."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("פורסם"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("שמירות"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("צופים"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("צופים ביום"),
      "and": MessageLookupByLibrary.simpleMessage("ו"),
      "answerNumber": (Object a0) => "תשובה ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("עדשת AR"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("צירוף יומן האפליקציה"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("זמן הלוך ושוב"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("אימות אסימון"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("ניסיון חוזר"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("ניסיון חוזר"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "התחלת שידור עכשיו תכניס אתכם לחדר שאף אחד לא יוכל"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("הקמת קהילה"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("למה זה? (לא חובה)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("להיכנס אליו שוב."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("להיכנס אליו שוב מהרשימה הזו."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("סגירתה"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("הצטרפו קודם"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("בקרוב"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("מפרסמים בשמכם"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("פרסום בקהילה הזו"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("עכשיו"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("ניסיון חוזר"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("נושא 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("בשבילך"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("יש בו משהו."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("בדרך לשם עכשיו."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", לא"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("האם אני זז"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("השתקת קול"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("הפעלת קול"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("בשבילך"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("הלשוניות שלך"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("ניסיון חוזר"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("סמל (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("צופים ביום"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("הפוסט הזה"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("משהו להוסיף? (לא חובה)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("הפוסט הזה"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("מחשבון"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("התנתקות"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("החשבון שלך"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("אישור סיסמה"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("לא עכשיו"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("טוען…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("מפרסם…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("לפני 3 שע׳"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("העתקת קישור לסטורי"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("הסטורי שלך"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "החשבון שלך, הפוסטים שלך ומה שאתם מקישים עליו, כדי ש"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("הוספת נושא"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("משלו."),
      "authorBlocked": (Object a0) => "${a0} נחסם",
      "authorPostsHidden": (Object a0) => "לא תראו פוסטים של ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("חסימה"),
      "blockAuthor": (Object a0) => "לחסום את ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("פרטי הגרסה הועתקו"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("בהמשך אתם מסכימים ל"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "בהמשך אתם מסכימים לתנאי השירות ולמדיניות הפרטיות שלנו"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("בהרשמה אתם מסכימים ל"),
      "cancel": MessageLookupByLibrary.simpleMessage("ביטול"),
      "change": MessageLookupByLibrary.simpleMessage("שינוי"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("שינוי אימייל"),
      "checkEmailConfirm":
          MessageLookupByLibrary.simpleMessage("אמתו את החשבון מהאימייל."),
      "checkKyronReachable":
          MessageLookupByLibrary.simpleMessage("בדיקה אם Kyron זמין"),
      "clear": MessageLookupByLibrary.simpleMessage("ניקוי"),
      "close": MessageLookupByLibrary.simpleMessage("סגירה"),
      "closeCommunity": (Object a0) => "לסגור את ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("סגירה"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("סגירת הקהילה הזו"),
      "communities": MessageLookupByLibrary.simpleMessage("קהילות"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "מצאו אחת בגילוי, או הקימו משלכם."),
      "composer_placeholder_hot_take":
          MessageLookupByLibrary.simpleMessage("זרקו דעה לוהטת (או פושרת)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("מה עובר לכם בראש?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "אמרו משהו שרק אתם יכולים לומר…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("זה הסימן: פרסמו"),
      "composer_placeholder_think":
          MessageLookupByLibrary.simpleMessage("הקלידו, דברו או חשבו בקול"),
      "confirmPassword": MessageLookupByLibrary.simpleMessage("אישור סיסמה"),
      "contactSupport": MessageLookupByLibrary.simpleMessage("פנייה לתמיכה"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "לפוסטים עדיין אין שפה, לכן זה עדיין לא מסנן את הפיד שלכם. הבחירות שלכם נשמרות עד אז."),
      "continueAction": MessageLookupByLibrary.simpleMessage("המשך"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("המשך עם אימייל"),
      "copy": MessageLookupByLibrary.simpleMessage("העתקה"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("העתקת הדוח במקום"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "לא ניתן לפתוח התחברות עם Google. ${a0}",
      "couldNotSignOut": (Object a0) => "ההתנתקות נכשלה: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("לא ניתן לצלם תמונה."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "מוצגת בפרופיל שלך ומתחת לפוסטים שלך."),
      "country_no_match":
          MessageLookupByLibrary.simpleMessage("אין מדינה שתואמת ל„{query}”."),
      "country_none": MessageLookupByLibrary.simpleMessage("לא להציג מדינה"),
      "country_search": MessageLookupByLibrary.simpleMessage("חיפוש מדינות"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "מוצגת בפרופיל שלך ומתחת לפוסטים שלך. כשאתה רואה פוסטים של מישהו, המדינה שלך נספרת בתובנות שלו, רק בקבוצות של חמישה ומעלה ואף פעם לא בשם."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("מההגדרות של הטלפון שלך"),
      "create": MessageLookupByLibrary.simpleMessage("יצירה"),
      "createAccount": MessageLookupByLibrary.simpleMessage("יצירת חשבון"),
      "createYourAccount": MessageLookupByLibrary.simpleMessage("צרו חשבון"),
      "createYourProfile": MessageLookupByLibrary.simpleMessage("צרו פרופיל"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("עדשת AR"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("שידור חי"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("פוסט טקסט"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("פוסט קולי"),
      "delete": MessageLookupByLibrary.simpleMessage("מחיקה"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("למחוק את התגובה הזו?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("למחוק את הפוסט הזה?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("תארו את הקובץ המצורף"),
      "description": MessageLookupByLibrary.simpleMessage("תיאור"),
      "didCopied": MessageLookupByLibrary.simpleMessage("ה-DID הועתק ללוח"),
      "done": MessageLookupByLibrary.simpleMessage("סיום"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "סגרו את העורך אחרי שכתבתם משהו ותוצע לכם טיוטה."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("לפני {days} ימים"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("לפני {hours} שעות"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("עכשיו"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("לפני {minutes} דקות"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("עדיין לא נכתב כלום"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("סקר, עדיין בלי שאלה"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("ציטוט, עדיין בלי טקסט"),
      "drafts": MessageLookupByLibrary.simpleMessage("טיוטות"),
      "editProfile": MessageLookupByLibrary.simpleMessage("עריכת פרופיל"),
      "email": MessageLookupByLibrary.simpleMessage("אימייל"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("התראות באימייל"),
      "explore": MessageLookupByLibrary.simpleMessage("גילוי"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "מעקב פנים אינו זמין במכשיר הזה."),
      "feedTagDetail": (Object a0) => "עדיין לא פורסם דבר עם #${a0}.",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("לעקוב אחרי {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("עוקבים"),
      "following": MessageLookupByLibrary.simpleMessage("נעקבים"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage("שכחתם סיסמה?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("קבלת עזרה"),
      "googleContinue": MessageLookupByLibrary.simpleMessage("המשך עם Google"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("התחברות עם Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google מחזירה את ההתחברות שהושלמה ל-Kyron דרך קישור שרק Android ו-iOS עונים לו, ולכן ב-${a0} לדפדפן אין לאן להחזיר אותה.\\n\\nאם כבר יש לכם חשבון Kyron דרך Google, בחרו המשך עם אימייל עם אותה כתובת והקישו על שכחתם סיסמה: תקבלו קישור להגדרת סיסמה.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "התחברות עם Google דורשת את אפליקציית הטלפון"),
      "googleSignUp": MessageLookupByLibrary.simpleMessage("הרשמה עם Google"),
      "guidesAndAnswers":
          MessageLookupByLibrary.simpleMessage("מדריכים ותשובות לשאלות נפוצות"),
      "handle": MessageLookupByLibrary.simpleMessage("כינוי"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("עזרה ותמיכה"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("מרכז העזרה"),
      "home": MessageLookupByLibrary.simpleMessage("בית"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("בשורה אחת"),
      "ins_account": MessageLookupByLibrary.simpleMessage("החשבון שלך"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("פתח את הקהילה"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("כתוב פוסט"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("צפה בפוסט"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("ערוך את הפרופיל שלך"),
      "ins_active": MessageLookupByLibrary.simpleMessage("מתי הם בסביבה"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("באזור הזמן שלך."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("גילים"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "מתוך {known} האנשים שהגעת אליהם ומסרו תאריך לידה."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("אנשים שהגעת אליהם בכל יום"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("קהילות שהם חברים בהן"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("מדינות"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "מתוך {known} האנשים שהגעת אליהם ויש להם מדינה בפרופיל."),
      "ins_days": MessageLookupByLibrary.simpleMessage("{days} הימים האחרונים"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן היה לטעון את התובנות"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("עוקבים"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "אין עדיין קבוצה גדולה מספיק כדי להציג אותה."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("איך לצמוח"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("נושאים שהם עוקבים אחריהם"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("לייקים"),
      "ins_new": MessageLookupByLibrary.simpleMessage("חדש"),
      "ins_new_followers": MessageLookupByLibrary.simpleMessage("עוקבים חדשים"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "אף אחד מהפוסטים שלך לא הגיע לאיש בתקופה הזו."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("לא עוקבים אחריך"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "המדינות הן אלה שאנשים בחרו בפרופילים שלהם. Kyron לא אוסף את העיר או המגדר של אף אחד, כך שאין מה להציג עבורם."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("פתיחות"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "הגיע ל־{reach} · {likes} לייקים · {replies} תגובות"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("אנשים שהגעת אליהם"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "כל אדם נספר פעם אחת: הוצג לו או שפתח לראשונה אחד מהפוסטים שלך. עוקבים חדשים עדיין עוקבים אחריך; הפסקות מעקב לא נספרות."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("תגובות"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("שיתופים מחדש"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("שמירות"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "מי הקהל שלך מוצג אחרי ש־{floor} אנשים ראו את הפוסטים שלך בתקופה הזו. בפחות מזה, זה עלול להצביע על מישהו."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("עדיין אין מספיק אנשים"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% מהם כבר עוקבים אחריך: הפוסטים שלך מגיעים בעיקר לאנשים שמכירים אותך."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% מהם עדיין לא עוקבים אחריך: מוצאים את הפוסטים שלך."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "הגעת ל־{reach} אנשים, {pct}% פחות מהתקופה הקודמת."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "הגעת ל־{reach} אנשים ב־{days} הימים האחרונים."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "הגעת ל־{reach} אנשים, בערך כמו בתקופה הקודמת."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "אף אחד חדש לא ראה את הפוסטים שלך ב־{days} הימים האחרונים."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "הגעת ל־{reach} אנשים, {pct}% יותר מהתקופה הקודמת."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "הגעת ל־{reach} אנשים, פי {times}× מהתקופה הקודמת."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "יותר מהם עוקבים אחרי {name} מאשר אחרי כל נושא אחר."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("קהל"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("סקירה"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "מי שמוצא אחד מהפוסטים שלך מסתכל בפרופיל שלך לפני שהוא עוקב. פנים או לוגו אומרים לו שיש שם מישהו."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("הוסף תמונת פרופיל"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "אמור בשורה אחת על מה אתה מפרסם, כדי שזר יידע מה ייתן לו לעקוב אחריך."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("כתוב ביוגרפיה"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "ל־{without} מתוך {total} הפוסטים שלך לא היה נושא. נושא מכניס פוסט לפיד של הנושא ומציב אותו מול מי שעוקב אחריו."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("הוסף נושאים לפוסטים"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} אנשים הגיבו לפוסטים שלך ועניתָ ל־{answered}. אכפת להם מספיק כדי לכתוב: תשובה הופכת קורא לקבוע."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("ענה לתגובות"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "הקהל שלך פעיל ביותר ב{when}. פוסט שמתפרסם קצת לפני כן מוצא אנשים שיקבלו אותו."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("פרסם כשהם בסביבה"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} אנשים שלא עוקבים אחריך ראו את הפוסטים שלך, ו־{gained} התחילו לעקוב. שהביוגרפיה והפוסטים החדשים שלך יגידו למה הם יכולים לצפות ממך."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("הפוך קוראים לעוקבים"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "פוסט אחד הגיע לפי {times}× יותר אנשים ממה שהאחרים שלך מגיעים בדרך כלל. בדוק מה הוא עשה אחרת, ועשה מזה יותר."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("עשה יותר ממה שעבד"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "רבים מהאנשים שרואים את הפוסטים שלך נמצאים ב־{name}. פרסום שם מציב אותך מול שאר החברים."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("פרסם ב־{name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "פרסמת {posts} פעמים ב־{days} ימים. כל פוסט הוא עוד הזדמנות להימצא, וקצב קבוע שומר אותך בפידים של העוקבים שלך."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("פרסם לעתים קרובות יותר"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "לא פרסמת ב־{days} הימים האחרונים. שום דבר לא מגיע לאיש בלי פוסט."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("פרסם משהו"),
      "ins_title": MessageLookupByLibrary.simpleMessage("תובנות"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("הפוסטים המובילים"),
      "ins_vs_before":
          MessageLookupByLibrary.simpleMessage("לעומת {days} הימים הקודמים"),
      "interest_add": MessageLookupByLibrary.simpleMessage("הוספת תחום עניין"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("גררו כדי לסדר מחדש"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "בסרגל נכנסות עד חמש לשוניות. הסירו אחת כדי להוסיף אחרת."),
      "interest_following": MessageLookupByLibrary.simpleMessage("נעקבים"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("בשבילך"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "האשטאגים יופיעו כאן כשאנשים יתחילו להשתמש בהם."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("בטרנד עכשיו"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("סרטונים"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("הלשוניות שלך"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("זה ייעלם לשניכם."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("זה יוסר מהשרשור."),
      "join": MessageLookupByLibrary.simpleMessage("הצטרפות"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("המשך עריכה"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "המסכים של Kyron בשפה שלכם. אם מילה נשמעת לא נכון, ספרו לנו דרך שליחת משוב."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("שפות"),
      "leave": MessageLookupByLibrary.simpleMessage("עזיבה"),
      "leaveCommunity": (Object a0) => "לעזוב את ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("החזרה פנימה"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("דף אחד פתוח"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("הוספת קליפ"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("הוספת GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("הוספת האשטאג"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("הוספת תמונה"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("הוספת סקר"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("הוספת וידאו"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("הוספת תחום עניין"),
      "literaladdLabelAsATab": (Object a0) => "הוספת ${a0} כלשונית",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("שפת האפליקציה"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("גרסת האפליקציה"),
      "literalblockAuthor": (Object a0) => "חסימת ${a0}",
      "literalblockAuthor2": (Object a0) => "לחסום את ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("לחסום את החשבון הזה?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("ביטול התגובה"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("בדיקה חוזרת"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("בחירה מהגלריה"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("ניקוי המטמון"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("סגירת כל הדפים"),
      "literalcloseTabLabel": (Object a0) => "סגירת ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("סגירת הדפדפן"),
      "literalcloseWidgetCommunityName": (Object a0) => "לסגור את ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("פנייה לתמיכה"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("שפות התוכן"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("העתקת קישור"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("העתקת קישור לפוסט"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("העתקת טקסט הפוסט"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("העתקת טקסט"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון קהילות"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון GIF"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון התראות"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון חברים"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את הפוסטים האלה"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את השיחה הזו"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את הרשימה הזו"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את הפוסט הזה"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את התגובה הזו"),
      "literalcouldNotLoadTrendingTags":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון תגים פופולריים"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את הקהילות שלך"),
      "literalcouldNotLoadYourMessages":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את ההודעות שלך"),
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("לא ניתן לפתוח את הקהילה הזו"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("לא ניתן לפרסם את התגובה."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("החיפוש לא הצליח"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "ההתנתקות נכשלה: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} דפים פתוחים",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("תמונת נושא"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("חיסכון בנתונים"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("מחיקת הפוסט"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("חיפוש אנשים"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("לא להגיב"),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage("הטיוטה נשמרה"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage("לא ניתן לשלוח משוב כרגע"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("גודל טקסט"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF לא הוגדרו"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("העברה לאפליקציה אחרת"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("הסתרת סיסמה"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("הסתרת הפוסט הזה"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "מסתיר אותו ומבקש מאיתנו להציג פחות כאלה"),
      "literalhowToBehave": MessageLookupByLibrary.simpleMessage("איך להתנהג"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("המשך כתיבה"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron לא הגיב"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "תאריך \\${a0}",
      "literalleaveCommunityName": (Object a0) => "לעזוב את ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, עדשת פנים",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("פוסטים שאהבתם"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("הקישור הועתק"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("הפיכה למנחה"),
      "literalmuteAuthor": (Object a0) => "השתקת ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("השתקת השרשור הזה"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("השתקת מילים או תגים"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("חשבונות מושתקים וחסומים"),
      "literalmutedYouWillNotBeNotified":
          MessageLookupByLibrary.simpleMessage("הושתק. לא תקבלו התראות."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "אף אפליקציה במכשיר לא פותחת קישורי ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "אף דפדפן במכשיר לא קיבל את הקישור."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("עדיין אין DID"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("אין טיוטות"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין תחומי עניין"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין לייקים"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין הודעות"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("אין עוקבים חדשים"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין פוסטים"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין תגובות"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין שיתופים חוזרים"),
      "literalnoTrendingTagMatchesThat":
          MessageLookupByLibrary.simpleMessage("אף תג פופולרי לא תואם"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("לא נמצא אף אחד"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("אף אחד לא הוסר"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין כאן אף אחד"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("לא מעניין אותי"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("לא נמצא דבר"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין טרנדים"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין כלום ביומן"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("אין התאמות"),
      "literalnothingMuted": MessageLookupByLibrary.simpleMessage("אין השתקות"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("עדיין אין מה לצפות"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("אין הודעות שלא נקראו"),
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("רק הבעלים יכולים לשנות את זה"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("פתיחת התגובה"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("פתחו את האימייל מ-Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("סיסמה והתחברות"),
      "literalpostInCommunityName": (Object a0) => "פרסום ב-${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "פרסום ב-${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage("פרסמו עם מילים משלכם מעליו"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("שפה ראשית"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("התראות פוש"),
      "literalreading": MessageLookupByLibrary.simpleMessage("בודק…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("הקלטת פוסט קולי"),
      "literalrecordAgain": MessageLookupByLibrary.simpleMessage("הקלטה מחדש"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("הסרה מתפקיד מנחה"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("הסרה מהקהילה"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("הסרה מהשמורים"),
      "literalremoveLabel": (Object a0) => "הסרת ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "הסרת ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "להסיר את ${a0}?",
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage("הסרת סקר"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("הסרת התשובה הזו"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("מחיקת השיחה הזו"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("הסרת הסקר הזה"),
      "literalreportAuthor": (Object a0) => "דיווח על ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("דיווח על הפוסט"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("שליחת הקוד שוב"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("פוסטים שמורים"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("אמרו משהו"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "אמרו משהו ב-${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("החיפוש נכשל"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("שליחה חוזרת"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "שליחה חוזרת בעוד ${a0} שנ׳",
      "literalsendFeedback": MessageLookupByLibrary.simpleMessage("מתן משוב"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("שליחת קישור"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "נשלח. זה דוח מס׳ ${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("הגדירו סיסמה והמשיכו"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("שיתוף היומן עם התמיכה"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("שיתוף הקהילה הזו"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("שיתוף הדף הזה"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("שיתוף הפרופיל הזה"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("שיתוף…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("שיתוף עם ציטוט"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("להציג עוד כאלה"),
      "literalshowPassword": MessageLookupByLibrary.simpleMessage("הצגת סיסמה"),
      "literalshowResults": MessageLookupByLibrary.simpleMessage("הצגת תוצאות"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("הקמת קהילה"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("התחלת הקלטה"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("עצירת הטעינה"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "להפסיק לראות את הפוסט הזה ואת התגובות אליו"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "רצועת סטוריז, ${a0} פריטים",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("החלפת מצלמה"),
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("תיוג מישהו"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("צילום תמונה"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "הקישו על הבאנר או התמונה כדי להחליף"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("הקישו על הקישור שבתוכו"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "הקישו כדי להוסיף תמונה ותמונת נושא"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("זה לא הצליח. נסו שוב."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את ה-GIF הזה."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "לא ניתן לפתוח את הקישור הזה כאן."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("המצלמה סגורה"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("הקהילה הזו"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("התגובה הזו כבר לא קיימת"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("תרגום הפוסט"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("השתקת קול"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("הפעלת קול"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("שימוש באחת שלנו"),
      "literalverificationCodeResent":
          MessageLookupByLibrary.simpleMessage("קוד האימות נשלח שוב."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "האימות נכשל: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("אימות אימייל"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage("צופים, לייקים, שמירות ותגובות"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("מה Kyron שומר"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("מה האפליקציה עשתה"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage("מה עשיתם, למה ציפיתם, מה קרה "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("מה שאתם מפרסמים שייך לכם"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("האם Kyron זמין כרגע"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("מי יכול להגיב"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("את מי לתייג?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "אתם כבר עוקבים אחרי כל התגים הפופולריים"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("ראיתם הכול"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("אינכם חברים באף קהילה"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("התנתקתם."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "עזבתם את ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("עדיין לא פרסמתם כלום"),
      "loadMore": MessageLookupByLibrary.simpleMessage("טעינת עוד"),
      "logCleared": MessageLookupByLibrary.simpleMessage("היומן נוקה"),
      "logCopied": MessageLookupByLibrary.simpleMessage("היומן הועתק"),
      "logIn": MessageLookupByLibrary.simpleMessage("התחברות"),
      "logOut": MessageLookupByLibrary.simpleMessage("התנתקות"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("להתנתק?"),
      "login": MessageLookupByLibrary.simpleMessage("התחברות"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "ההתחברות נכשלה. בדקו את הפרטים."),
      "manage": MessageLookupByLibrary.simpleMessage("ניהול"),
      "menu": MessageLookupByLibrary.simpleMessage("תפריט"),
      "message": MessageLookupByLibrary.simpleMessage("הודעה"),
      "messages": MessageLookupByLibrary.simpleMessage("הודעות"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("קראתם את כל השיחות."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "פתחו פרופיל של מישהו והקישו על הודעה כדי להתחיל שיחה."),
      "mute": MessageLookupByLibrary.simpleMessage("השתקה"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("מושתקים וחסומים"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("מילים ותגים מושתקים"),
      "name": MessageLookupByLibrary.simpleMessage("שם"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("מסך <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("כתובת אימייל חדשה"),
      "newPassword": MessageLookupByLibrary.simpleMessage("סיסמה חדשה"),
      "newPost": MessageLookupByLibrary.simpleMessage("פוסט חדש"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("לא עכשיו"),
      "notSentTapRetry":
          MessageLookupByLibrary.simpleMessage("לא נשלח. הקישו כדי לנסות שוב"),
      "nothingMatchesQuery": (Object a0) =>
          "שום דבר ב-Kyron לא תואם ל\"${a0}\"",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("אין מה להעתיק"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "לייקים, תגובות ועוקבים חדשים מגיעים לכאן."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "אנשים שעוקבים אחריכם יופיעו כאן."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "כשמישהו יעשה לייק לפוסט שלכם, זה יופיע כאן."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "תגובות לפוסטים שלכם מגיעות לכאן."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "כשמישהו ישתף אתכם מחדש, זה יופיע כאן."),
      "notifications": MessageLookupByLibrary.simpleMessage("התראות"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("פתיחה בדפדפן"),
      "or": MessageLookupByLibrary.simpleMessage("או"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("הדף לא נמצא"),
      "password": MessageLookupByLibrary.simpleMessage("סיסמה"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("הסיסמה קצרה מדי"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("בחרו תחומי עניין"),
      "post": MessageLookupByLibrary.simpleMessage("פרסום"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("נתוני הפוסט"),
      "postInCommunity": (Object a0) => "פרסום ב-${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("פרסמו, אמרו, הראו."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("טקסט הפוסט הועתק"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("מדיניות הפרטיות"),
      "profileUpdated": MessageLookupByLibrary.simpleMessage("הפרופיל עודכן"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("ביו"),
      "profile_country": MessageLookupByLibrary.simpleMessage("מדינה"),
      "profile_display_name": MessageLookupByLibrary.simpleMessage("שם תצוגה"),
      "profile_location": MessageLookupByLibrary.simpleMessage("מיקום"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("הקישו כדי להחליף"),
      "profile_website": MessageLookupByLibrary.simpleMessage("אתר"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage("התראות פוש"),
      "quote": MessageLookupByLibrary.simpleMessage("ציטוט"),
      "quotePost": MessageLookupByLibrary.simpleMessage("ציטוט הפוסט"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("פנייה לאדם"),
      "remove": MessageLookupByLibrary.simpleMessage("הסרה"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("למחוק את השיחה הזו?"),
      "removeMember": (Object a0) => "להסיר את ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("למחוק את ההודעה הזו?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("תגובות, מעקבים ואזכורים"),
      "repliesPolicy": (Object a0) => "תגובות: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("תגובה"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("כל אחד יכול להצטרף"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "כל אחד עדיין יכול לראות, לשתף מחדש ולצטט את הפוסט הזה."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "כל אחד ב-Kyron יכול להגיב לפוסט הזה."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("מי שעוקב אחריכם"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "רק מי שעוקב אחריכם יכול להגיב לפוסט הזה."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("אנשים שאתם מזכירים"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "רק אנשים שאתם מזכירים עם @ בפוסט הזה יכולים להגיב."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("אף אחד לא יכול להגיב"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "התגובות כבויות. אתם עדיין יכולים להגיב בעצמכם."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("מי יכול להגיב?"),
      "report": MessageLookupByLibrary.simpleMessage("דיווח"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "הדוח הועתק. הדביקו אותו באימייל לתמיכה."),
      "reportSent": MessageLookupByLibrary.simpleMessage("הדיווח נשלח"),
      "repost": MessageLookupByLibrary.simpleMessage("שיתוף חוזר"),
      "reset": MessageLookupByLibrary.simpleMessage("איפוס"),
      "resetPassword": MessageLookupByLibrary.simpleMessage("איפוס הסיסמה"),
      "retry": MessageLookupByLibrary.simpleMessage("ניסיון חוזר"),
      "save": MessageLookupByLibrary.simpleMessage("שמירה"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("שמירת טיוטה"),
      "saySomething": (Object a0) => "אמרו משהו ב-${a0}",
      "search": MessageLookupByLibrary.simpleMessage("חיפוש"),
      "searchByNameOrHandle":
          MessageLookupByLibrary.simpleMessage("חיפוש לפי שם או כינוי"),
      "searchCommunities": MessageLookupByLibrary.simpleMessage("חיפוש קהילות"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("חיפוש GIF"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("חיפוש שפות"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("חיפוש תגים פופולריים"),
      "securityAlerts":
          MessageLookupByLibrary.simpleMessage("התראות אבטחה ושינויים בחשבון"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "בחרו את שפת הממשק של האפליקציה."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "בחרו אילו שפות יופיעו בפידים שלכם. אם לא תבחרו אף אחת, יוצגו כל השפות."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "בחרו את השפה הראשית לתרגומים בפיד."),
      "send": MessageLookupByLibrary.simpleMessage("שליחה"),
      "sendConfirmation": MessageLookupByLibrary.simpleMessage("שליחת אימות"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("שליחת דיווח על באג"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("שליחת משוב"),
      "sendReport": MessageLookupByLibrary.simpleMessage("שליחת דיווח"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("שליחה לתמיכה"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("מצב השירות"),
      "settings": MessageLookupByLibrary.simpleMessage("הגדרות"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "שיתוף יומן האפליקציה עם התמיכה"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("התחברות ל-Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("מחובר בתור"),
      "signupFailed": (Object a0) => "ההרשמה נכשלה: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("להישאר"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron רק בתחילת דרכו, והדרך המהירה ביותר להגיע למי שבאמת יכול לתקן היא לפתוח פנייה. ספרו לנו מה עשיתם ומה קרה."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "לאפליקציה עדיין אין תיבת תמיכה, לכן המסך הזה מפנה אתכם למקום שבאמת עוקבים אחריו, ולא לטופס שלא מגיע לשום מקום."),
      "systemLog": MessageLookupByLibrary.simpleMessage("יומן האפליקציה"),
      "tellMissingBroken":
          MessageLookupByLibrary.simpleMessage("ספרו לנו מה חסר או מה שבור"),
      "terms": MessageLookupByLibrary.simpleMessage("תנאי השירות"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "טקסט, קול ווידאו, האנשים שיוצרים אותם והחדרים שבהם הם משוחחים."),
      "theComposerNoPostButton":
          MessageLookupByLibrary.simpleMessage("אין כפתור פרסום בעורך"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("כהה"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("תמיד כהה"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("מעומעם"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "כהה רך יותר, אפור-כחלחל במקום שחור"),
      "theme_light": MessageLookupByLibrary.simpleMessage("בהיר"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("תמיד בהיר"),
      "theme_system": MessageLookupByLibrary.simpleMessage("מערכת"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "לפי ההגדרה הבהירה או הכהה של הטלפון"),
      "translate": MessageLookupByLibrary.simpleMessage("תרגום"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "התרגום עדיין לא פעיל. שום דבר בפיד עדיין לא מתורגם; ההגדרה תיזכר עד אז."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "זה משנה את המילים של Kyron עצמו, את חלקי הממשק ש-Flutter מצייר בעצמו, תאריכים ומספרים, ואת כיוון הפריסה של האפליקציה בשפות שנכתבות מימין לשמאל."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("לנסות שוב"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("מדיניות הפרטיות"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("תנאי השירות"),
      "ui_account": MessageLookupByLibrary.simpleMessage("חשבון"),
      "ui_after": MessageLookupByLibrary.simpleMessage("אחרי"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("אפליקציה ומכשיר"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "ציטטתי את ההונאה כדי להזהיר אחרים."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "כדאי להסביר למה לדעתך ההחלטה שגויה: מה הפוסט התכוון לומר, מה הצוות אולי פספס או למה הכלל לא מתאים. מי שיקרא את זה הוא לא מי שהחליט."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("הערעור שלך"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "יש לכתוב לפחות \$count תווים. אפשר לערער על כל החלטה פעם אחת."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("שליחת ערעור"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "הערעור נשלח. תישלח אליך התראה כשתתקבל החלטה."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("ערעור על תיק \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("מראה"),
      "ui_appearance_detail":
          MessageLookupByLibrary.simpleMessage("בהיר, כהה או לפי הטלפון"),
      "ui_before": MessageLookupByLibrary.simpleMessage("לפני"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "לא תראו זה את זה ב-Kyron, והמעקבים ביניכם יוסרו. לא נודיע להם."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("מכיל"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("למה היא נועדה (לא חובה)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("רק מנחים יכולים לכתוב"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "להודעות. כל מי שבקהילה עדיין יכול לקרוא ולהגיב."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("הוספת תמונה או סקר"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("תמונות וסרטונים"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("סגירת הצ׳אט"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "אף אחד לא יוכל לקרוא או לכתוב בו. אי אפשר לבטל את זה."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("לסגור את הצ׳אט הזה?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("הועתק"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "ההודעה מוסרת אצל כולם. Kyron שומרת עותק לבדיקה."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "ההודעה מוסרת אצל כל מי שבצ׳אט."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("עריכת הצ׳אט"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("עריכה"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("נערכה"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("עריכת ההודעה שלך"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן לפתוח את הצ׳אט הזה."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("צ׳אטים"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("הצטרפות לצ׳אט"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "הצטרפו לקהילה כדי לראות את הצ׳אטים שלה ולהשתתף."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("הצטרפו: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("יציאה מהצ׳אט"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "אפשר להמשיך לקרוא אותו כל עוד נמצאים בקהילה."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "רק הבעלים והמנחים יכולים לכתוב כאן."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("השתקה"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "בלי התראות ממנו, והוא לא נספר בהודעות."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("שם הצ׳אט"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("צ׳אט חדש"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("אין עדיין צ׳אטים."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "אין עדיין צ׳אטים. פתחו אחד לקהילה."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "צ׳אטים של קהילות אינם מוצפנים מקצה לקצה. מנחי הקהילה ו-Kyron יכולים לקרוא אותם."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("הצמדה למעלה"),
      "ui_cchat_poll_add": MessageLookupByLibrary.simpleMessage("הוספת תשובה"),
      "ui_cchat_poll_close": MessageLookupByLibrary.simpleMessage("סגירת הסקר"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("נסגר"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "כולם רואים כמה בחרו בכל תשובה, אף פעם לא מי."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("לאפשר לבחור כמה תשובות"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("סקר חדש"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("יש לבחור תשובה אחת"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("תשובה \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("סקר: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("שאלה"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "כל תשובה יכולה להופיע בסקר פעם אחת בלבד."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("יש לבחור תשובה אחת או יותר"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count ענו"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("חיפוש בצ׳אט הזה"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("חיפוש בצ׳אט הזה"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("לא נמצא דבר."),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("אין לך יותר גישה לצ׳אט הזה."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("מצב איטי"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "כמה זמן ממתינים בין הודעות. לא חל על מנחים."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("שעה אחת"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("דקות: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "מצב איטי: הודעה אחת בכל \$seconds שניות"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("כבוי"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("שניות: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "אפשר לקרוא ולהגיב כצופה. הצטרפו כדי לכתוב."),
      "ui_cchat_too_far":
          MessageLookupByLibrary.simpleMessage("ההודעה הזו ישנה מדי להצגה."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "אחד הפריטים שנבחרו גדול מדי לשליחה ולא נכלל."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("ביטול השתקה"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("ביטול הצמדה"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("הקלטת הודעה קולית"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("את/ה"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("קהילות"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("למה זה? (לא חובה)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("פוסטים:"),
      "ui_content_display": MessageLookupByLibrary.simpleMessage("תוכן ותצוגה"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את הפיד שלך"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "לא ניתן לטעון את הפוסטים שאהבתם"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את הפרופיל שלך"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "לא ניתן לטעון את הפוסטים השמורים שלך"),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage("מזהה מבוזר"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("פתרון בעיות"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("קבוצות"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("אין קבוצות"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "כאן מופיעות הקבוצות שלך וצ׳אטים של קהילות שהצטרפת אליהם."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "אפשר להצמיד עד \$count צ'אטים. יש לבטל הצמדה של אחד קודם."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("מוצמד"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("אהבתי"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("שמורים"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("עדיין אין כאן כלום"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "עקבו אחרי כמה חשבונות והפוסטים שלהם יופיעו כאן."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "אין כלום ממי שאתם עוקבים אחריו"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "פוסטים יופיעו כאן כשאנשים יכתבו אותם."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("נחלש"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("לא מעניין אותי"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("הצג עוד כאלה"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("הוסר"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("האותות של הפיד שלך"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "הקש על הצג עוד פוסטים כאלה או לא מעניין אותי בפוסט, והוא יופיע כאן."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("עדיין אין כאן כלום"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "מה הצג עוד ולא מעניין אותי אומרים לפידים שלך"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "הם מעצבים את הבית ואת הגילוי, בעיקר לפי הנושא של כל פוסט. כל אחד נחלש בחצי בכל חודש ומפסיק להיחשב אחרי שישה. הסר אחד כדי לעצור אותו עכשיו."),
      "ui_feed_videos_detail":
          MessageLookupByLibrary.simpleMessage("פוסטים עם קליפ יופיעו כאן."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("עדיין אין סרטונים"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("משוב"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("מצאו אנשים ב-Kyron"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("מחשבון"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("הוספת אנשים"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("הוספה"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("הוספת שם לקבוצה"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("דחייה"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "ההודעות בקבוצה הזו מוצפנות מקצה לקצה, כמו בכל שיחה אחרת."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor הוסיף/ה את \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor הפך/ה את \$users למנהל/ת"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor יצר/ה את הקבוצה"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor קבע/ה שאנשים חדשים יצטרפו כחברים"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor קבע/ה שאנשים חדשים יצטרפו כצופים"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor עזב/ה"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor הפך/ה את \$users לחבר/ה"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor הפך/ה את \$users לבעלים"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor הסיר/ה את \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor שינה/תה את שם הקבוצה ל\$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor הפך/ה את \$users לצופה"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "בקבוצה יכולים להיות עד \$count אנשים."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "היד הורמה. המנהלים קיבלו הודעה."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count מבקשים לכתוב"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("מבקשים לכתוב"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "מי שנוסף מאוחר יותר מצטרף כצופה"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("יציאה מהקבוצה"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "היא תיעלם מהרשימה שלך ולא תראה/י מה ייאמר אחר כך. מישהו יצטרך להוסיף אותך שוב."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("לצאת מהקבוצה הזו?"),
      "ui_group_let_write": MessageLookupByLibrary.simpleMessage("לאפשר כתיבה"),
      "ui_group_lower_hand": MessageLookupByLibrary.simpleMessage("הורדת היד"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("מינוי למנהל/ת"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("מינוי לבעלים"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("הפיכה לצופה"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count חברים"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("חברים"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("שם הקבוצה"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("קודם צריך לתת לקבוצה שם."),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("יצירת צ׳אט קבוצתי"),
      "ui_group_owner_detail":
          MessageLookupByLibrary.simpleMessage("יש בעלים אחד. תישאר/י מנהל/ת."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("להפוך את \$name לבעלים?"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("הרמת יד"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("הסרה מהקבוצה"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("הסרה מניהול"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("את/ה כבר לא בקבוצה הזו."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("שינוי שם"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("מנהל/ת"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("חבר/ה"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("צופה"),
      "ui_group_spectator_note":
          MessageLookupByLibrary.simpleMessage("כצופה, אפשר לקרוא ולהגיב כאן."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "צופים יכולים לקרוא, להגיב ולהרים יד כדי לבקש לכתוב."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("הצעות"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("הצגת פרופיל"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("את/ה"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("את/ה צופה"),
      "ui_help": MessageLookupByLibrary.simpleMessage("עזרה"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "נרשם. זה עוזר לבחור מה להציג לכם."),
      "ui_join": MessageLookupByLibrary.simpleMessage("הצטרפות"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("הצטרף"),
      "ui_language": MessageLookupByLibrary.simpleMessage("שפה"),
      "ui_language_detail": MessageLookupByLibrary.simpleMessage("בחירת שפה"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("מידע משפטי"),
      "ui_like": MessageLookupByLibrary.simpleMessage("לייק"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("פוסטים שאהבתם"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "פוסטים שאהבתם מופיעים כאן, החדשים קודם."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("הקישור הועתק"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "לא תראו יותר את הפוסטים שלהם. לא נודיע להם."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("עדיין אין לייקים"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "אין פוסטים שתואמים למסננים האלה."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("עדיין אין שמורים"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("החשבון שלך עודכן"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "הערעור שלך בתיק \$number התקבל"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "בחנו שוב את הערעור שלך בתיק \$number, וההחלטה בעינה עומדת"),
      "ui_notif_banned":
          MessageLookupByLibrary.simpleMessage("החשבון שלך נחסם לצמיתות"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("תיק \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("התחיל/ה לעקוב אחריך"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("אהב/ה את הפוסט שלך"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("הזכיר/ה אותך"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("אין עדיין אזכורים"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "כשמישהו כותב את @שם המשתמש שלך בפוסט או בתגובה, זה יופיע כאן."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("ישנות יותר"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "ההודעה שלך בצ׳אט של קהילה הוסרה"),
      "ui_notif_removed_other":
          MessageLookupByLibrary.simpleMessage("משהו שפרסמת הוסר"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("הפוסט שלך הוסר"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("התגובה שלך הוסרה"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("הגיב/ה לפוסט שלך"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "נקטנו צעדים בעקבות דיווח שלך. תודה שסיפרת לנו."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "בדקנו דיווח שלך ולא מצאנו שהוא מפר את הכללים שלנו."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("דווח בגלל: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("שיתף/ה את הפוסט שלך"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "ביטלנו את ההחלטה בתיק \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("החשבון שלך מושעה"),
      "ui_notif_suspended_until":
          MessageLookupByLibrary.simpleMessage("החשבון שלך מושעה עד \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("הכול"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("עוקבים"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("לייקים"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("אזכורים"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("תגובות"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("השבוע"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("היום"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("החשבון שלך קיבל אזהרה"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("אתמול"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("סיום"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("דילוג"),
      "ui_once_already": MessageLookupByLibrary.simpleMessage("זה כבר נפתח."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("פג תוקף"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן היה לפתוח את זה."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "נפתח פעם אחת, ואז נמחק מ-Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("צפייה חד־פעמית"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("נפתח"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "נפתח על ידי \$count מתוך \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "רק מי ששלחת אליהם יכולים לפתוח את זה, פעם אחת."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("שליחה לצפייה חד־פעמית"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("הקשה לצפייה"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("השהיה"),
      "ui_play": MessageLookupByLibrary.simpleMessage("הפעלה"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "הוא יוסר מהפרופיל שלכם ומהפידים של כולם. התגובות אליו נעלמות איתו."),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("הפוסט נמחק"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("הפוסט הוסתר"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("טקסט הפוסט הועתק"),
      "ui_posted_between": MessageLookupByLibrary.simpleMessage("פורסם בין"),
      "ui_posts_hidden":
          MessageLookupByLibrary.simpleMessage("הוסתר. נציג פחות כאלה."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("העדפות"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("פרטיות"),
      "ui_report_add":
          MessageLookupByLibrary.simpleMessage("משהו להוסיף? (לא חובה)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "תתקבל התראה כשהצוות יחליט, ואפשר לעקוב בדיווחים שלך."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "אם גם אין לך רצון לראות את האדם הזה, אפשר להשתיק או לחסום אותו מאותו תפריט."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "דיווח על אותו דבר פעמיים לא מוסיף לו משקל: אנחנו שומרים דיווח אחד לכל אדם."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "הדיווח שלך לא משותף עם האדם הזה. אנחנו שומרים עותק של מה שדיווחת עליו, כדי שאפשר יהיה לבדוק אותו גם אם יימחק."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "הדיווח שלך התקבל וממתין לבדיקה. אנחנו לא מספרים לאדם הזה מי דיווח עליו."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("לדיווחים שלך"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("ספרו לנו מה לא בסדר"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("תודה שסיפרת לנו"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("מה הבעיה עם \$name?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("מה הבעיה עם ההודעה הזו?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("מה הבעיה עם הפוסט הזה?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("מה הבעיה עם התגובה הזו?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("הודעה בצ׳אט של קהילה"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("פוסט"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("תגובה"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("ננקטו צעדים"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("חשבון"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("הוחלט ב־\$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("לא הופר אף כלל"),
      "ui_reports_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את הדיווחים שלך"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "מה דיווחת ב־90 הימים האחרונים ומה יצא מזה. תתקבל התראה כשהצוות מחליט. מי שמדווחים עליו אף פעם לא יודע מי דיווח."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("אין דיווחים"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "כשמדווחים על פוסט, תגובה, הודעה או חשבון, הדיווח מופיע כאן יחד עם מה שיצא ממנו."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("בבדיקה"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("דווח ב־\$date"),
      "ui_reports_settings_help":
          MessageLookupByLibrary.simpleMessage("מה דיווחת ומה יצא מזה"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("הדיווחים שלך"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("בטיחות ילדים"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "כל דבר שמסכן קטינים או מציג אותם באופן מיני."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "התעללות ממוקדת, איומים או פנייה לא רצויה."),
      "ui_rule_detail_hate":
          MessageLookupByLibrary.simpleMessage("התקפות על אנשים בגלל מי שהם."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "מכירה או קידום של משהו לא חוקי."),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("התחזות למישהו אחר."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "שימוש ביצירה או בסימן המסחרי שלך ללא רשות."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "טענות מטעות על בריאות, בחירות או אירועים."),
      "ui_rule_detail_self_harm":
          MessageLookupByLibrary.simpleMessage("עידוד פגיעה עצמית או הצגתה."),
      "ui_rule_detail_sexual_content":
          MessageLookupByLibrary.simpleMessage("תוכן מיני שמוצג ללא אזהרה."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "אף אחד מאלה. ספרו לנו מה לא בסדר."),
      "ui_rule_detail_spam":
          MessageLookupByLibrary.simpleMessage("קידום חוזר, מטעה או לא רצוי."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "איום באלימות, האדרתה או הסתה אליה."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("הטרדה או בריונות"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("דברי שטנה"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("מוצרים או שירותים לא חוקיים"),
      "ui_rule_impersonation": MessageLookupByLibrary.simpleMessage("התחזות"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("קניין רוחני"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("מידע כוזב"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("התאבדות או פגיעה עצמית"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("תוכן למבוגרים"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("משהו אחר"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("ספאם"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("אלימות או איומים"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("פוסטים שמורים"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "הקישו על סמל הארכיון של פוסט כדי לשמור אותו כאן. רק אתם רואים את מה ששמרתם."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage("חפשו לפי כינוי או שם תצוגה."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("ניקוי"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("חיפוש בכל מה שפורסם"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("מסננים"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("חיפוש אנשים"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("חיפוש פוסטים"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("הגדרות"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("אפליקציה ומכשיר"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("תוכן ותצוגה"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("חיסכון בנתונים"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("שתפו את דעתכם"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("עיון במאמרי עזרה"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("בחרו שפה"),
      "ui_settings_muted_blocked":
          MessageLookupByLibrary.simpleMessage("את מי השתקתם או חסמתם"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("העדפות התראות"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("הפרופיל ופרטי הקשר שלך"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "תצטרכו להתחבר שוב כדי לחזור לחשבון."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("הגדרות אבטחה"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("אישור סיסמה"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("בשורה אחת"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("כתובת אימייל חדשה"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("סיסמה חדשה"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("מה קרה"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("קבלו עזרה מהצוות שלנו"),
      "ui_share": MessageLookupByLibrary.simpleMessage("שיתוף"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("ציטוט"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("שליחה בהודעה"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("לאנשים ב-Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("שיתוף הפוסט הזה"),
      "ui_standing_about": MessageLookupByLibrary.simpleMessage("במה מדובר"),
      "ui_standing_account_banned":
          MessageLookupByLibrary.simpleMessage("החשבון שלך נחסם לצמיתות"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("התשובה, ב-\$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("ערעור"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("ערעור על ההחלטה"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "אי אפשר לערער עוד על ההחלטה הזו. אם משהו לא בסדר, אפשר לפנות לתמיכה."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("הערעור בבדיקה"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("הערעור התקבל"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "מישהו אחר בצוות בודק את זה שוב. תישלח אליך התראה כשתתקבל החלטה."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "אם לדעתך זו טעות, אפשר לבקש בדיקה חוזרת עד \$date. מישהו אחר בצוות מחליט."),
      "ui_standing_appeal_upheld":
          MessageLookupByLibrary.simpleMessage("לאחר ערעור: ההחלטה בתוקף"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "תיק \$number. כלל: \$rule. הצוות כתב:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "מחיקת החשבון לא מבטלת חסימה: חשבון חדש עם אותה כתובת אימייל ייחסם גם הוא."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("חסום לצמיתות"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "רק הדף הזה, ערעורים, תמיכה ומחיקת החשבון עדיין פועלים."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("ניתן לערער"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("תיק \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("הוחלט ב-\$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("החלטות לגבי החשבון שלך"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("מחיקת החשבון"),
      "ui_standing_details": MessageLookupByLibrary.simpleMessage("הצגת פרטים"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("הצגת פרטים וערעור"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("מסתיים ב-\$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("החשבון שלך תקין"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("שום דבר לא מגביל אותו."),
      "ui_standing_load_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את מצב החשבון"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("ההודעה הוסרה"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "לא התקבלה שום החלטה לגבי החשבון שלך. אם הצוות יסיר אי פעם משהו שלך או יגביל את החשבון שלך, זה יופיע כאן עם הסיבה, ותהיה לך אפשרות לערער."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "אין על מה לערער: ההחלטה בוטלה."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("הפוסט הוסר"),
      "ui_standing_pull_to_check":
          MessageLookupByLibrary.simpleMessage("יש למשוך למטה כדי לבדוק שוב."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("קריאת הכללים של Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("התגובה הוסרה"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("בוטלה"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "בוטלה ב-\$date. כל מה שהוסר חזר, ואף הגבלה כבר לא חלה."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("כלל: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("התנתקות"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("מושעה"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "אפשר לקרוא, אבל לא לפרסם, להגיב, לעקוב או לשלוח הודעות. דיווח, חסימה והשתקה עדיין עובדים."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "החשבון שלך מושעה: אפשר לקרוא, אבל לא לפרסם."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("מושעה עד \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "החשבון שלך מושעה עד \$date: אפשר לקרוא, אבל לא לפרסם."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("מה הצוות כתב"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("מצב החשבון"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("אזהרה"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("למה?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("כתבת, ב-\$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("ההודעה שלך"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("הפוסט שלך"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("התגובה שלך"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("תנאי השירות"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("הפוסט הזה"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("השרשור הושתק"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("ניסיון נוסף"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("השתקת קול"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("הפעלת קול"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("לפחות שני תווים."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("ביטול"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "מילים, או מסנן: חשבון, טווח תאריכים או מה שיש בפוסט."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("ביטול השיתוף החוזר"),
      "updatePassword": MessageLookupByLibrary.simpleMessage("עדכון סיסמה"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("שימוש בכתובת אחרת"),
      "username": MessageLookupByLibrary.simpleMessage("שם משתמש"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "שם המשתמש חייב להיות באותיות קטנות (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("וידאו"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("צירוף"),
      "voice_ready_attach": MessageLookupByLibrary.simpleMessage("מוכן לצירוף"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("הקלטת פוסט קולי"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("שומר…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("עצירה"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("מה קרה"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "מה קרה, ועל מה כדאי לנו להסתכל?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("מה יש בתמונה הזו?"),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage("למה זה? (לא חובה)"),
      "whatYouDid":
          MessageLookupByLibrary.simpleMessage("מה עשיתם, למה ציפיתם, מה קרה"),
      "whatYouWereDoing":
          MessageLookupByLibrary.simpleMessage("מה עשיתם כשזה קרה."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("התשובה שלך"),
      "dmReplied": (Object a0) => "תשובה מאת $a0",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("הוספה להודעה"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("הודעה חדשה"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "עדיין לא נאמר דבר. נפנוף הוא התחלה טובה."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  נפנוף"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("הודעות חדשות"),
      "dmTyping": (Object a0) => "$a0 מקליד/ה",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("הסרת התגובה שלך"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("מישהו"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("הודעה"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("קובץ מצורף"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "לא ניתן לקרוא את ההודעה הזו במכשיר הזה."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "ממתינים להודעה הזו. זה עשוי להימשך זמן מה."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("הודעה מוצפנת"),
      "ui_dm_e2ee_notice":
          MessageLookupByLibrary.simpleMessage("ההודעות מוצפנות מקצה לקצה"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("לא מוצפנת מקצה לקצה"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("נשלחה"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("נצפתה"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("בשליחה…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("צילום תמונה"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("אפשרויות נוספות"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("שמירה במכשיר"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("שיתוף"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("בשמירה…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("נשמר בתמונות שלך"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "לא ניתן לשמור. אפשר לנסות שוב."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "יש לאפשר ל-Kyron להוסיף לתמונות שלך כדי לשמור את זה."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("כל המערכות פועלות"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("זמינות"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("60 הימים האחרונים"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("לפני 60 יום"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("היום"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("מסד נתונים"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("התחברות"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("תקלות אחרונות"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "אין תקלות ב-60 הימים האחרונים."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("בתהליך"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("אין נתונים"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("פרטים"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron בודק את עצמו כל 5 דקות כל עוד הוא פועל. ביום אפור לא היו בדיקות."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "היסטוריית הזמינות עדיין לא זמינה."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("בחלק מהמערכות יש בעיות"),
      "ui_dm_voice": MessageLookupByLibrary.simpleMessage("הקלטת הודעה קולית"),
      "voice_ready_send": MessageLookupByLibrary.simpleMessage("מוכנה לשליחה"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("ההודעה הזו כבר לא כאן."),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("מעבר להודעה"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("הודעה קולית"),
      "ui_liked_by_author": MessageLookupByLibrary.simpleMessage("הכותב אהב"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("הוספת תמונה או קליפ"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("מדיה"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("הודעות קוליות"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("צ'אט"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("טפט"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("השתקת התראות"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "הפסקת קבלת התראות על השיחה הזו"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "הם כבר לא יכולים לשלוח לך הודעות"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("ללא"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("תמונה"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("ההשתקה בוטלה."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "לא ניתן היה להסיר. כדאי לנסות שוב."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("פרופיל"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("ביטול השתקה"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "תמונות וקליפים שתשתפו יופיעו כאן."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("הצגת הכול"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("תמונות וקליפים"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("כך ייראה הצ'אט שלך."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("נראה טוב."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("ערפל"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("דמדומים"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("מרווה"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("חול"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("נקודות"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("החלה"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("נוכחי"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("שליחה בלי התצוגה המקדימה"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("חיפוש"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("פרסום"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("כתבו הודעה…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("שליחה"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("נשלח"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("נשלח, אבל לא לכולם."),
      "ui_share_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן היה לשלוח. נסו שוב."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("עוקב"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("סינון"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("הכול"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("לא נקראו"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("ללא מענה"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("מוסתרות"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("אין שום דבר מוסתר"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "שיחות שתסירו מהרשימה מחכות כאן, למקרה שתרצו אותן בחזרה."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "היא עוברת למוסתרות. הצד השני שומר את שלו, והיא חוזרת אם מישהו מכם כותב שוב."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("החזרה"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("חזרה לרשימה שלכם."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("אין שיחות תואמות."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("שום דבר לא מחכה לכם"),
      "ui_dm_unanswered_none_detail":
          MessageLookupByLibrary.simpleMessage("כל שיחה מסתיימת במילה שלכם."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("תמונה"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("תמונות"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("סרטון"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("אין עדיין הודעות"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("אתם:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("אתמול"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("הודעות"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("הגדרות הודעות"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("פרטיות"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("אישורי קריאה"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "כשזה כבוי, אחרים לא יראו מתי קראתם את ההודעות שלהם, ואתם לא תראו מתי הם קראו את שלכם."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("להציג כשאתם מקלידים"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "מי שאתם כותבים לו רואה שאתם כותבים."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("תצוגות מקדימות של קישורים"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "הטלפון שלכם פותח את הקישור שאתם שולחים כדי ליצור תצוגה מקדימה, ולכן האתר רואה את הבקשה של הטלפון שלכם. השרת של Kyron לעולם לא רואה את הקישור."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("התראות על הודעות"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "ההודעות מוצפנות מקצה לקצה. Kyron לא יכול לקרוא אותן, ושום דבר כאן לא משנה זאת."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("אל:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("אחרונים"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("אנשים"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("אין אף אחד בשם הזה."),
      "ui_push_test": MessageLookupByLibrary.simpleMessage("שליחת התראת בדיקה"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "השרת של Kyron עדיין לא מוגדר לשליחת התראות, ולכן אף אחת לא יכולה להגיע. הבעיה אצלנו, לא בטלפון שלכם."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "הטלפון הזה לא רשום להתראות. ודאו שההתראות של Kyron מותרות בהגדרות הטלפון, ונסו שוב."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "לא ניתן היה למסור את ההתראה לטלפון הזה. נסו שוב בעוד דקה."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "נשלחה. היא אמורה להגיע בעוד כמה שניות."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("ההתראות עובדות."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("עדיין אין פוסטים"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("קהילה חדשה"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("שם"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("הכתובת שלה נוצרת מהשם."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("אפשר יהיה למצוא אותה בכתובת"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "הקהילה תהיה בבעלותכם. אפשר להוסיף תמונה, באנר ומנחים מהדף שלה אחרי שתיווצר."),
      "ui_community_settings_home": MessageLookupByLibrary.simpleMessage("בית"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("פוסטים מקהילות בבית"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "פוסטים מהקהילות שלכם מופיעים גם בבית. כשזה כבוי, הם נשארים כאן בקהילות, שבהן כל אחת מראה מה חדש."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("הרשימה שלכם"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("מספר פוסטים חדשים"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "הצגת מספר הפוסטים החדשים בכל קהילה מאז שפתחתם אותה לאחרונה."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("קהילות בניהולכם"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "כאן מופיעות הקהילות שהקמתם או שאתם מנחים."),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("בעלים"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("מנחה"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("פוסטים חדשים"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("בניהולכם"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("הגדרות קהילות"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("גילוי"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("אין קהילות תואמות."),
      "ui_community_new_none": MessageLookupByLibrary.simpleMessage("אין חדש"),
      "ui_community_new_none_detail":
          MessageLookupByLibrary.simpleMessage("כל קהילה כפי שהשארתם אותה."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("עדיין אין קהילה בניהולכם"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("לא נשאר למה להצטרף"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "אתם בכל הקהילות ב-Kyron. הקימו עוד אחת."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "נסו מילה אחרת, או הקימו קהילה בשם הזה."),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("כתיבת פוסט"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("חברים:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("פורסם"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("הצגה"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("פתיחה"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("מחובר/ת"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("להציג כשאתם מחוברים"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "האנשים שאתם מתכתבים איתם רואים נקודה ירוקה כש-Kyron פתוח אצלכם. כשזה כבוי, גם אתם לא תראו את שלהם."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("חיפוש אנשים ופוסטים"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("קהילות להצטרף אליהן"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("אין עדיין מה לראות"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "תמונות וקליפים שאנשים מפרסמים יופיעו כאן."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("מעקב"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("מחיקת החשבון"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "פעולה זו מוחקת לצמיתות את חשבון ה-Kyron שלך. אי אפשר לבטל אותה."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "הפרופיל, הפוסטים, התגובות, הלייקים והשיתופים שלך"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "ההודעות שלך, כולל אלה ששלחת לאחרים, והתמונות וההודעות הקוליות שבהן"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "העוקבים שלך, האנשים שבמעקב שלך וההגדרות שלך"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "קהילות שהקמת יעברו למנהל או לחבר הוותיק ביותר בהן. קהילה שאין בה אף אחד אחר תיסגר."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("למחוק את החשבון?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "לא תהיה אפשרות לשחזר שום דבר מזה."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("החשבון שלך נמחק."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("חשבון שנמחק"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "החשבון הזה נמחק, ולכן אי אפשר לשלוח לכאן הודעות יותר."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "נרשמת עם Google? אפשר להשתמש ב«Sign in with Google» במקום."),
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון את העדשה הזו."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("לא ניתן להקליט את הסרטון."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "לא ניתן להוסיף את העדשה לסרטון הזה, ולכן הוא יפורסם כפי שצולם."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "בפוסט שלך כבר יש את מספר הקבצים המצורפים המרבי."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("מוסיפים את העדשה…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("פלאש"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("הקלטת סרטון"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("תמונה"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("סרטון"),
      "googleSignInCancelled":
          MessageLookupByLibrary.simpleMessage("ההתחברות עם Google בוטלה."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("מתנות"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "עדיין אף אחד לא שלח מתנה לפוסט הזה."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("מתנה"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("מתנות"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("מטבעות"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("שולח"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("שולחים"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "מטבעות ניסיון: עדיין אי אפשר למשוך אותם."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("שמורים"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("פוסטים"),
      "ui_saved_tab_comments": MessageLookupByLibrary.simpleMessage("תגובות"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("הצגת תגובות נוספות"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("נערך"),
      "ui_more": MessageLookupByLibrary.simpleMessage("עוד"),
      "ui_following": MessageLookupByLibrary.simpleMessage("נעקבים"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("מובילים"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("אחרונים"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("מיון תגובות: \$order"),
      "ui_notif_gift":
          MessageLookupByLibrary.simpleMessage("שלח/ה מתנה לפוסט שלך"),
      "ui_notif_gift_comment":
          MessageLookupByLibrary.simpleMessage("שלח/ה \$gift לתגובה שלך"),
      "ui_notif_gift_named":
          MessageLookupByLibrary.simpleMessage("שלח/ה \$gift לפוסט שלך"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("שליחת מתנה"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("עריכת פוסט"),
      "ui_edit_post_left":
          MessageLookupByLibrary.simpleMessage("אפשר לערוך אותו עוד \$n דק׳"),
      "ui_save": MessageLookupByLibrary.simpleMessage("שמירה"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "עדיין לא פורסם דבר תחת #\$tab."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("בחירת מתנה"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("אין מספיק מטבעות"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "מטבעות ניסיון: אי אפשר לקנות אותם ואין להם ערך כספי."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("מתמלא ב-\$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("מטבע אחד"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count מטבעות"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("יש לך \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("שליחת \$gift"),
      "ui_gift_sent_named": MessageLookupByLibrary.simpleMessage("\$gift נשלח"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("ניסיון חוזר"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("במשך 15 דקות אחרי הפרסום"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("נערך"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "לא ניתן לטעון את התגובות השמורות שלך"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("אין תגובות שמורות"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "יש להקיש על סמל הארכיון שמתחת לתגובה כדי לשמור אותה כאן. רק את/ה רואה מה ששמרת."),
      "ui_replying_to": MessageLookupByLibrary.simpleMessage("בתגובה ל-\$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("העתקה"),
      "ui_search": MessageLookupByLibrary.simpleMessage("חיפוש"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("בחירת הכול"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count מתנות"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("מתנה אחת"),
      "ui_feed_more_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון פוסטים נוספים."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("תזכורות"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "מה חדש אחרי שלא היית כאן, ומתי המטבעות חוזרים. לא יותר מאחת ביום."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("מתנות"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("מאדם אחד"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("מ-\$count אנשים"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("הנדיב ביותר"),
      "ui_gifts_load_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן לטעון מי שלח מתנות."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("מה חדש"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("הבנתי"),
      "ui_check_in_thanks":
          MessageLookupByLibrary.simpleMessage("תודה. אנחנו קוראים כל תשובה."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("איך Kyron עד עכשיו?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "יום \$day של הניסיון שלך. הקשה אחת מספיקה."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "משהו שכדאי לתקן או להוסיף? (לא חובה)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("שליחה"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("לא עכשיו"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "יש ללחוץ שוב על חזרה כדי לצאת מ-Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("אשרו שזה אתם"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "הזינו את הסיסמה כדי למחוק את החשבון."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "התחברו שוב עם Google כדי למחוק את החשבון."),
      "ui_confirm_its_you_failed":
          MessageLookupByLibrary.simpleMessage("זה לא הצליח. בדקו ונסו שוב."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "הדף הזה רוצה לפתוח אפליקציה אחרת"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "הוא מבקש לפתוח קישור {scheme}."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("גרסת בנייה"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "{size} של תמונות וקבצים במטמון"),
      "ui_about_freed": MessageLookupByLibrary.simpleMessage("פונו {size}"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("מודדים…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("אין מה לנקות"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("אחסון"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("גרסה {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("חסומים"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("מפרסמים בשמך"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "הקבצים המצורפים לא הועלו. אפשר להקיש על אחד כדי לנסות שוב, או להסיר אותו."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "לא ניתן היה לשנות את האימייל. כדאי לנסות שוב."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "הכתובת תשתנה אחרי שתפתחו את הקישור שנשלח."),
      "ui_email_check_link":
          MessageLookupByLibrary.simpleMessage("חפשו קישור אישור ב-{email}."),
      "ui_email_enter":
          MessageLookupByLibrary.simpleMessage("הזינו כתובת אימייל."),
      "ui_email_invalid":
          MessageLookupByLibrary.simpleMessage("זה לא נראה כמו כתובת אימייל."),
      "ui_email_same":
          MessageLookupByLibrary.simpleMessage("זו כבר כתובת האימייל שלך."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "מה עשית, למה ציפית ומה קרה במקום."),
      "ui_feedback_idea_example":
          MessageLookupByLibrary.simpleMessage("תנו לי להצמיד פוסט לפרופיל"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "מה הייתם רוצים, ומה זה היה מאפשר לכם לעשות."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("מה היה עוזר"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("בעיה"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("רעיון"),
      "ui_feedback_kind_question": MessageLookupByLibrary.simpleMessage("שאלה"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "רק צוות Kyron קורא את זה. זה נשלח עם החשבון שלך כדי שנוכל לענות באימייל, ועם גרסת האפליקציה שבה משתמשים. מחיקת החשבון מוחקת גם את זה."),
      "ui_feedback_question_example":
          MessageLookupByLibrary.simpleMessage("איך משתיקים מילה?"),
      "ui_feedback_question_hint":
          MessageLookupByLibrary.simpleMessage("מה ניסית לעשות, ואיפה נתקעת."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("השאלה שלך"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "לא ניתן להתחבר ל-Kyron. בדקו את החיבור ונסו שוב. עוד לא נכתב כלום, אז שום דבר לא אבד."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("ניקוי"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "בקשות שנכשלו ואירועים בולטים אחרים מופיעים כאן."),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("מושתקים"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "הוסיפו מילה או תגית למעלה. פוסטים שמכילים אותה לא יופיעו בפיד."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "פוסטים שמכילים משהו מאלה לא מופיעים בפיד. אותיות גדולות וקטנות לא משנות, ומילה נמצאת גם בתוך מילים ארוכות יותר, כך ש-„spoiler” תופסת גם „spoilers”."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("אף אחד לא חסום"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "חסימה מסתירה אתכם זה מזה, בשני הכיוונים. אפשר לחסום מישהו מהתפריט בפרופיל שלו."),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("אף אחד לא מושתק"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "השתקת חשבון מסתירה את הפוסטים שלו בלי ליידע אותו. אפשר להשתיק מישהו מהתפריט בפרופיל שלו או בפוסט."),
      "ui_password": MessageLookupByLibrary.simpleMessage("סיסמה"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("הן לא תואמות."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "החשבון יישאר מחובר במכשיר הזה. במכשירים אחרים תתבצע התנתקות."),
      "ui_password_too_short":
          MessageLookupByLibrary.simpleMessage("יש להשתמש לפחות ב-8 תווים."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "לא ניתן היה לעדכן את הסיסמה. כדאי לנסות שוב."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("הסיסמה עודכנה."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("ה-DID הועתק"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "פוסטים שאהבת נשמרים כאן, רק בשבילך."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "עוד לא פרסמת תמונות או קליפים."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} עוד לא פרסם/ה תמונות או קליפים."),
      "ui_profile_empty_posts_mine":
          MessageLookupByLibrary.simpleMessage("כל מה שמפרסמים מופיע כאן."),
      "ui_profile_empty_posts_other":
          MessageLookupByLibrary.simpleMessage("{name} עוד לא פרסם/ה כלום."),
      "ui_profile_load_failed_mine": MessageLookupByLibrary.simpleMessage(
          "לא ניתן היה לטעון את הפרופיל שלך"),
      "ui_profile_load_failed_other": MessageLookupByLibrary.simpleMessage(
          "לא ניתן היה לטעון את @{handle}"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("לפחות 8 תווים"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("אות קטנה (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("לפחות ספרה אחת"),
      "ui_pw_rule_symbol": MessageLookupByLibrary.simpleMessage("סמל (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("אות גדולה (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "{count} רשומות אחרונות. אפשר לעבור עליהן ב-אודות › יומן מערכת לפני השליחה."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "רק צוות Kyron קורא את זה. זה נשלח עם החשבון שלך כדי שנוכל לחזור אליך. כדי לראות בדיוק מה נשלח יחד, קראו קודם את היומן ב-אודות › יומן מערכת."),
      "ui_report_sent": MessageLookupByLibrary.simpleMessage("נשלח, תודה."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "נשלח, תודה. זה דיווח מס' {number}."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("מה השתבש?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "גרסה, מדיניות, סטטוס ויומן מערכת"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "לא להפעיל סרטונים מעצמם בזמן גלילה"),
      "ui_settings_did_help":
          MessageLookupByLibrary.simpleMessage("המזהה המבוזר שלך"),
      "ui_settings_moderation":
          MessageLookupByLibrary.simpleMessage("ניהול תוכן"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "דיווחים וערעורים שממתינים לבדיקה"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "להרחיק מהפיד פוסטים שמכילים את אלה"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("לא מחובר"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("העדפות התראות"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("פרטיות ובטיחות"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "החלטות לגבי החשבון שלך, וערעורים"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("התאמת גודל הטקסט"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("החשבון שלך"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "הקלטה ופרסום של עדשות AR עדיין בבנייה. שום דבר שתצלמו עוד לא יישמר, ולכן המצלמה נשארת סגורה."),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("העדשות עוד לא מוכנות"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("עדשת AR"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "שידור חי דורש שרת מדיה ש-Kyron עוד לא מפעילה. אם תתחילו שידור עכשיו, תהיו בחדר שאף אחד לא יכול להצטרף אליו. הקלטת פוסט קולי כבר עובדת היום."),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("שידור חי עוד לא מוכן"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("שידור חי"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "סקרים צריכים מקום לשמור את האפשרויות ולספור את ההצבעות. זה עוד לא קיים, אז סקר שיפורסם היום יאבד כל תשובה."),
      "ui_soon_poll_heading":
          MessageLookupByLibrary.simpleMessage("הסקרים עוד לא מוכנים"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("סקר"),
      "ui_soon_write_instead":
          MessageLookupByLibrary.simpleMessage("לכתוב פוסט טקסט במקום"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("בדיקה חוזרת"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("פרטים"),
      "ui_status_mirror": MessageLookupByLibrary.simpleMessage("טבלאות מראה"),
      "ui_status_not_right":
          MessageLookupByLibrary.simpleMessage("Kyron ענה, אבל משהו לא תקין."),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("זמן הלוך-חזור"),
      "ui_support_ask": MessageLookupByLibrary.simpleMessage("לשאול שאלה"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "על החשבון שלך, או איך משהו עובד"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("באימייל"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "אם Kyron קרס: נשלח גם יומן האפליקציה"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("באפליקציה"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "כתבו לצוות Kyron מכאן. ההודעה מגיעה אלינו באופן פרטי, עם החשבון שלך, ואנחנו עונים לכתובת האימייל שבו."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "לא נפתחה אפליקציית דואר. {address} הועתק."),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("פרטיות והנתונים שלך"),
      "ui_support_report":
          MessageLookupByLibrary.simpleMessage("דיווח על בעיה"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "משהו שבור או לא עושה מה שהוא אמור"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "כדי לדווח על פוסט או חשבון, השתמשו בתפריט שלו: כך נדע בדיוק למה הכוונה."),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("בטיחות ושימוש לרעה"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "האם Kyron לא עובד לכולם, או רק לך"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("גדול"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("גדול יותר"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("בינוני"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron הוא מקום להגיד משהו ששווה לקרוא."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("קטן"),
      "ui_theme_dark_detail": MessageLookupByLibrary.simpleMessage("תמיד כהה"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("מעומעם"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "כהה רך יותר, אפור-כחלחל במקום שחור"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("תמיד בהיר"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "לפי הגדרת הבהיר או הכהה של הטלפון"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("ביטול חסימה"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("ביטול השתקה"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("מי את/ה"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "במילים שלך: מה הבודק צריך לדעת."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "אני כותב/ת על ציפורים כאן ובאתר שלי."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("הוספת קישור נוסף"),
      "ui_verify_again":
          MessageLookupByLibrary.simpleMessage("אפשר לבקש שוב החל מ-{date}."),
      "ui_verify_ask": MessageLookupByLibrary.simpleMessage("בקשת אימות"),
      "ui_verify_before": MessageLookupByLibrary.simpleMessage("לפני הבקשה"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("יוצר/ת"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("עיתונאי/ת"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("ארגון או מותג"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("משהו אחר"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("אישיות ציבורית"),
      "ui_verify_denied":
          MessageLookupByLibrary.simpleMessage("בקשה {number} לא אושרה"),
      "ui_verify_done": MessageLookupByLibrary.simpleMessage("החשבון מאומת"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("עריכת הפרופיל"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("הזינו את הקוד בן 6 הספרות"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "שליחת הקוד מחדש בעוד {seconds} שניות"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("שלחנו אותו ל-{email}"),
      "ui_verify_email_verify": MessageLookupByLibrary.simpleMessage("אימות"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("קבלו אימות ב-Kyron"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("קבלו"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("אימות"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("ב-Kyron."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "התג אומר שמישהו מצוות Kyron בדק שהחשבון הזה הוא מי שהוא טוען שהוא. הוא לא נותן חשיפה נוספת, והוא לא למכירה."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "התג נשאר כל עוד השם נשאר. אם תשנו את השם, התג יוסר עד שמישהו יבדוק את השם החדש."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("איפה אפשר לבדוק"),
      "ui_verify_link_more": MessageLookupByLibrary.simpleMessage("קישור נוסף"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "אתר או פרופיל אחר שאומר שחשבון Kyron הזה שלך: שימו בו את שמך ב-Kyron, או קישור לפרופיל שלך. Kyron אף פעם לא מבקשת מסמכי זיהוי."),
      "ui_verify_load_failed":
          MessageLookupByLibrary.simpleMessage("לא ניתן היה לטעון את המצב שלך"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "צריך לסמן הכול למעלה לפני שאפשר לבקש."),
      "ui_verify_req_age":
          MessageLookupByLibrary.simpleMessage("חשבון בן {days} ימים לפחות"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("ביוגרפיה שאומרת מי את/ה"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("השם שלך בפרופיל"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("תמונת פרופיל"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "אין כלום ברשומות שלך ב-{days} הימים האחרונים"),
      "ui_verify_sent":
          MessageLookupByLibrary.simpleMessage("נשלח. אדם יעבור על זה."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("מאז {date}."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("לבקש"),
      "ui_verify_step_ask_detail":
          MessageLookupByLibrary.simpleMessage("מי את/ה, וקישור\nשמוכיח את זה"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("התג"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "ליד השם שלך,\nבכל מקום שהוא מופיע"),
      "ui_verify_step_check": MessageLookupByLibrary.simpleMessage("אדם\nבודק"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "מישהו מהצוות\nפותח את הקישורים שלך"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("אימות"),
      "ui_verify_waiting":
          MessageLookupByLibrary.simpleMessage("בקשה {number} נמצאת אצל אדם"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "נשלח ב-{date}, בתור {category}. תתקבל התראה כשתתקבל החלטה."),
      "ui_verify_withdraw": MessageLookupByLibrary.simpleMessage("משיכת הבקשה"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("הבקשה נמשכה."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "לא ניתן היה לסיים את ההקלטה: {error}"),
      "ui_voice_limit": MessageLookupByLibrary.simpleMessage("עד עשר דקות."),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("מקשיבים…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron צריכה הרשאה להשתמש במיקרופון כדי להקליט. אפשר לתת אותה בהגדרות המכשיר."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "לא ניתן היה להתחיל להקליט: {error}"),
    };

final messageLookup = MessageLookup();
