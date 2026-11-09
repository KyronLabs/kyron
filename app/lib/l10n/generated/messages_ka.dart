import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ka';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("სიტყვა, ფრაზა ან #თეგი"),
      "about": MessageLookupByLibrary.simpleMessage("შესახებ"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("პასუხის დამატება"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("ენების დამატება…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("დათანხმება და გაგრძელება"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("უკვე გაქვთ Kyron-ის ანგარიში?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("კომენტარები"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "სხვადასხვა ადამიანი, არა გახსნები"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("ჩართულობა"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("მოწონებები"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("მაყურებლები ჯერ არ არის"),
      "analytics_nobody_opened_post":
          MessageLookupByLibrary.simpleMessage("ეს პოსტი ჯერ არავის გაუხსნია."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("გამოქვეყნდა"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("შენახვები"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("მაყურებლები"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("მაყურებლები დღეში"),
      "and": MessageLookupByLibrary.simpleMessage("და"),
      "answerNumber": (Object a0) => "პასუხი ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR ლინზა"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("აპის ჟურნალის მიმაგრება"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("მიმოსვლის დრო"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ტოკენის დადასტურება"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("ხელახლა ცდა"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("ხელახლა ცდა"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "ახლა ტრანსლაციის დაწყება ისეთ ოთახში მოგათავსებთ, სადაც ვერავინ"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("საზოგადოების შექმნა"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("რისთვისაა? (არასავალდებულო)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("ვეღარ შემოვა."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("ამ სიიდან ვეღარ შემოვა."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("მისი დახურვის შემდეგ"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("ჯერ შემოუერთდით"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("მალე"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("აქვეყნებთ საკუთარი სახელით"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("გამოაქვეყნეთ ამ საზოგადოებაში"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("ახლახან"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("ხელახლა ცდა"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("თემა 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("თქვენთვის"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("რაღაც აქვს."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("ახლა იქით მიდის."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", არა"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("ვმოძრაობ თუ არა"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("ხმის გამორთვა"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("ხმის ჩართვა"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("თქვენთვის"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("თქვენი ჩანართები"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("ხელახლა ცდა"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("სიმბოლო (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("მაყურებლები დღეში"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("ვერ ჩაიტვირთა"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ეს პოსტი"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "გსურთ რამის დამატება? (არასავალდებულო)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ეს პოსტი"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("ანგარიშიდან"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("გასვლა"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("თქვენი ანგარიში"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("დაადასტურეთ პაროლი"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("ახლა არა"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("იტვირთება…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("ქვეყნდება…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 სთ წინ"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("ისტორიის ბმულის კოპირება"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("თქვენი ისტორია"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "თქვენი ანგარიში, პოსტები და ის, რასაც ეხებით, რათა"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("თემის დამატება"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("საკუთარი."),
      "authorBlocked": (Object a0) => "${a0} დაიბლოკა",
      "authorPostsHidden": (Object a0) => "${a0}-ის პოსტებს ვეღარ ნახავთ",
      "block": MessageLookupByLibrary.simpleMessage("დაბლოკვა"),
      "blockAuthor": (Object a0) => "დაიბლოკოს ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("ვერსიის დეტალები დაკოპირდა"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("გაგრძელებით ეთანხმებით"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "გაგრძელებით ეთანხმებით ჩვენს მომსახურების პირობებსა და კონფიდენციალურობის პოლიტიკას"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("რეგისტრაციით ეთანხმებით"),
      "cancel": MessageLookupByLibrary.simpleMessage("გაუქმება"),
      "change": MessageLookupByLibrary.simpleMessage("შეცვლა"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("ელფოსტის შეცვლა"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "დაადასტურეთ ანგარიში ელფოსტიდან."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "შემოწმება, ხელმისაწვდომია თუ არა Kyron"),
      "clear": MessageLookupByLibrary.simpleMessage("გასუფთავება"),
      "close": MessageLookupByLibrary.simpleMessage("დახურვა"),
      "closeCommunity": (Object a0) => "დაიხუროს ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("დახურვა"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("ამ საზოგადოების დახურვა"),
      "communities": MessageLookupByLibrary.simpleMessage("საზოგადოებები"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "იპოვეთ აღმოჩენაში ან შექმენით საკუთარი."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "ცხელი აზრი გამოთქვით (ან თბილი)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("რაზე ფიქრობთ?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "თქვით ის, რისი თქმაც მხოლოდ თქვენ შეგიძლიათ…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("ეს ნიშანია: გამოაქვეყნეთ"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "წერეთ, ილაპარაკეთ ან ხმამაღლა იფიქრეთ"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("დაადასტურეთ პაროლი"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("მხარდაჭერასთან დაკავშირება"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "პოსტებს ჯერ ენა არ აქვთ, ამიტომ ეს ჯერ არ ფილტრავს თქვენს არხს. თქვენი არჩევანი მანამდე შეინახება."),
      "continueAction": MessageLookupByLibrary.simpleMessage("გაგრძელება"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("ელფოსტით გაგრძელება"),
      "copy": MessageLookupByLibrary.simpleMessage("კოპირება"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("სანაცვლოდ ანგარიშის კოპირება"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google-ით შესვლა ვერ გაიხსნა. ${a0}",
      "couldNotSignOut": (Object a0) => "გასვლა ვერ მოხერხდა: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("ფოტოს გადაღება ვერ მოხერხდა."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "ჩანს შენს პროფილზე და შენი პოსტების ქვეშ."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "„{query}“-ს არცერთი ქვეყანა არ ემთხვევა."),
      "country_none": MessageLookupByLibrary.simpleMessage("არ აჩვენო ქვეყანა"),
      "country_search": MessageLookupByLibrary.simpleMessage("ქვეყნების ძიება"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "ჩანს შენს პროფილზე და შენი პოსტების ქვეშ. როცა ვინმეს პოსტებს ხედავ, შენი ქვეყანა ითვლება მის ანალიტიკაში, მხოლოდ ხუთი ან მეტი ადამიანის ჯგუფებში და არასდროს სახელით."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("შენი ტელეფონის პარამეტრებიდან"),
      "create": MessageLookupByLibrary.simpleMessage("შექმნა"),
      "createAccount": MessageLookupByLibrary.simpleMessage("ანგარიშის შექმნა"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("შექმენით ანგარიში"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("შექმენით პროფილი"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR ლინზა"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("პირდაპირი ეთერი"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("ტექსტური პოსტი"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("ხმოვანი პოსტი"),
      "delete": MessageLookupByLibrary.simpleMessage("წაშლა"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("წაიშალოს ეს კომენტარი?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("წაიშალოს ეს პოსტი?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("აღწერეთ ეს დანართი"),
      "description": MessageLookupByLibrary.simpleMessage("აღწერა"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID დაკოპირდა ბუფერში"),
      "done": MessageLookupByLibrary.simpleMessage("მზადაა"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "რამის დაწერის შემდეგ დახურეთ რედაქტორი და მონახაზს შემოგთავაზებთ."),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} დღის წინ"),
      "draft_hours_ago": MessageLookupByLibrary.simpleMessage("{hours} სთ წინ"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("ახლახან"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} წთ წინ"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("ჯერ არაფერი დაწერილა"),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
          "გამოკითხვა, ჯერ კითხვის გარეშე"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("ციტატა, ჯერ ტექსტის გარეშე"),
      "drafts": MessageLookupByLibrary.simpleMessage("მონახაზები"),
      "editProfile":
          MessageLookupByLibrary.simpleMessage("პროფილის რედაქტირება"),
      "email": MessageLookupByLibrary.simpleMessage("ელფოსტა"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("ელფოსტის შეტყობინებები"),
      "explore": MessageLookupByLibrary.simpleMessage("აღმოჩენა"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "სახის თვალყურის დევნება ამ მოწყობილობაზე მიუწვდომელია."),
      "feedTagDetail": (Object a0) => "#${a0}-ით ჯერ არაფერი გამოქვეყნებულა.",
      "follow_author": MessageLookupByLibrary.simpleMessage("გამოიწერე {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("გამომწერები"),
      "following": MessageLookupByLibrary.simpleMessage("გამოწერილები"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("დაგავიწყდათ პაროლი?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("დახმარების მიღება"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Google-ით გაგრძელება"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("Google-ით შესვლა"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google დასრულებულ შესვლას Kyron-ს უბრუნებს ბმულით, რომელსაც მხოლოდ Android და iOS პასუხობენ, ამიტომ ${a0}-ზე ბრაუზერს მისი დასაბრუნებელი ადგილი არ აქვს.\\n\\nთუ Google-ით უკვე გაქვთ Kyron-ის ანგარიში, აირჩიეთ ელფოსტით გაგრძელება იმავე მისამართით და შეეხეთ დაგავიწყდათ პაროლი: მიიღებთ პაროლის დაყენების ბმულს.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google-ით შესვლას ტელეფონის აპი სჭირდება"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Google-ით რეგისტრაცია"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "სახელმძღვანელოები და პასუხები ხშირ კითხვებზე"),
      "handle": MessageLookupByLibrary.simpleMessage("მომხმარებლის სახელი"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("დახმარება და მხარდაჭერა"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("დახმარების ცენტრი"),
      "home": MessageLookupByLibrary.simpleMessage("მთავარი"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("ერთ ხაზზე"),
      "ins_account": MessageLookupByLibrary.simpleMessage("თქვენი ანგარიში"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("საზოგადოების გახსნა"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("დაწერეთ პოსტი"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("პოსტის ნახვა"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("პროფილის რედაქტირება"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("როდის არიან აქტიურები"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("თქვენს დროის სარტყელში."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("ასაკი"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "მიღწეული {known} ადამიანიდან, ვინც დაბადების დღე მიუთითა."),
      "ins_chart": MessageLookupByLibrary.simpleMessage(
          "მიღწეული ადამიანები დღეების მიხედვით"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("საზოგადოებები, სადაც არიან"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("ქვეყნები"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "იმ {known} მიღწეული ადამიანიდან, ვისაც პროფილზე ქვეყანა აქვს."),
      "ins_days": MessageLookupByLibrary.simpleMessage("ბოლო {days} დღე"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "სტატისტიკის ჩატვირთვა ვერ მოხერხდა"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("გამომწერები"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "საჩვენებლად საკმარისად დიდი ჯგუფი ჯერ არ არის."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("როგორ გაიზარდოთ"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("თემები, რომლებსაც მიჰყვებიან"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("მოწონებები"),
      "ins_new": MessageLookupByLibrary.simpleMessage("ახალი"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("ახალი გამომწერები"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "ამ პერიოდში თქვენი არცერთი პოსტი არავის მიუღწევია."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("არ გამოგიწერენ"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "ქვეყნები ისაა, რაც ადამიანებმა თავიანთ პროფილზე აირჩიეს. Kyron არავის ქალაქს ან სქესს არ აგროვებს, ამიტომ მათთვის საჩვენებელი არაფერია."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("გახსნები"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "მიღწეულია {reach} · {likes} მოწონება · {replies} პასუხი"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("მიღწეული ადამიანები"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "თითოეული ადამიანი ერთხელ ითვლება: მას პირველად ეჩვენა ან პირველად გახსნა თქვენი რომელიმე პოსტი. ახალი გამომწერები ისევ გამოგიწერენ; გამოწერის გაუქმება არ ითვლება."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("პასუხები"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("გაზიარებები"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("შენახვები"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "ვინ არის თქვენი აუდიტორია, გამოჩნდება, როცა ამ პერიოდში {floor} ადამიანი ნახავს თქვენს პოსტებს. ნაკლების შემთხვევაში ეს შეიძლება კონკრეტულ ადამიანზე მიუთითებდეს."),
      "ins_small_title": MessageLookupByLibrary.simpleMessage(
          "ჯერ საკმარისი ადამიანი არ არის"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "მათი {pct}% უკვე გამოგიწერთ: თქვენი პოსტები ძირითადად ნაცნობებს აღწევს."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "მათი {pct}% ჯერ არ გამოგიწერთ: თქვენს პოსტებს პოულობენ."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "{reach} ადამიანს მიაღწიეთ, წინა პერიოდზე {pct}%-ით ნაკლებს."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "ბოლო {days} დღეში {reach} ადამიანს მიაღწიეთ."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "{reach} ადამიანს მიაღწიეთ, დაახლოებით იმდენს, რამდენსაც წინა პერიოდში."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "ბოლო {days} დღეში თქვენი პოსტები ახალ არავის უნახავს."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "{reach} ადამიანს მიაღწიეთ, წინა პერიოდზე {pct}%-ით მეტს."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "{reach} ადამიანს მიაღწიეთ, წინა პერიოდზე {times}×-ით მეტს."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "მათგან უფრო მეტი მიჰყვება {name}-ს, ვიდრე ნებისმიერ სხვა თემას."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("აუდიტორია"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("მიმოხილვა"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "ვინც თქვენს პოსტს იპოვის, გამოწერამდე თქვენს პროფილს ათვალიერებს. სახე ან ლოგო ეუბნება, რომ იქ ვიღაც არის."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("დაამატეთ პროფილის სურათი"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "ერთ ხაზში თქვით, რაზე წერთ, რომ უცნობმა იცოდეს, რას მისცემს თქვენი გამოწერა."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("დაწერეთ ბიოგრაფია"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "თქვენი {total} პოსტიდან {without}-ს თემა არ ჰქონდა. თემა პოსტს ამ თემის ლენტში და მის მიმდევრებთან ათავსებს."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("დაამატეთ თემები პოსტებს"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} ადამიანმა უპასუხა თქვენს პოსტებს, თქვენ კი {answered}-ს უპასუხეთ. მათ იმდენად აინტერესებდათ, რომ დაწერეს: პასუხი მკითხველს მუდმივ სტუმრად აქცევს."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("უპასუხეთ პასუხებს"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "თქვენი აუდიტორია ყველაზე აქტიურია {when}. ცოტა ადრე გამოქვეყნებულ პოსტს ექნება, ვინც დახვდება."),
      "ins_tip_best_time_t": MessageLookupByLibrary.simpleMessage(
          "გამოაქვეყნეთ, როცა ისინი აქ არიან"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} ადამიანმა, ვინც არ გამოგიწერთ, ნახა თქვენი პოსტები და {gained} გამოგიწერათ. დაე თქვენმა ბიოგრაფიამ და ახალმა პოსტებმა თქვას, რას შეიძლება ელოდონ თქვენგან."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "აქციეთ მკითხველები გამომწერებად"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "ერთმა პოსტმა {times}×-ით მეტ ადამიანს მიაღწია, ვიდრე ჩვეულებრივ სხვებმა. ნახეთ, რა გააკეთა სხვაგვარად, და ეს უფრო ხშირად გააკეთეთ."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "გააკეთეთ მეტი იმისა, რაც გამოვიდა"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "თქვენი პოსტების მნახველთაგან ბევრი {name}-შია. იქ გამოქვეყნება დანარჩენებსაც დაგანახებთ."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("გამოაქვეყნეთ {name}-ში"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "{days} დღეში {posts}-ჯერ გამოაქვეყნეთ. ყოველი პოსტი პოვნის კიდევ ერთი შანსია, ხოლო მუდმივი რიტმი გამომწერების ლენტში გტოვებთ."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("გამოაქვეყნეთ უფრო ხშირად"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "ბოლო {days} დღეში არაფერი გამოგიქვეყნებიათ. პოსტის გარეშე არაფერი აღწევს არავის."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("გამოაქვეყნეთ რამე"),
      "ins_title": MessageLookupByLibrary.simpleMessage("სტატისტიკა"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("საუკეთესო პოსტები"),
      "ins_vs_before":
          MessageLookupByLibrary.simpleMessage("წინა {days} დღესთან შედარებით"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("ინტერესის დამატება"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
          "გადაათრიეთ თანმიმდევრობის შესაცვლელად"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "ზოლში მაქსიმუმ ხუთი ჩანართი ეტევა. სხვის დასამატებლად ერთი ამოშალეთ."),
      "interest_following":
          MessageLookupByLibrary.simpleMessage("გამოწერილები"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("თქვენთვის"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "ჰეშთეგები აქ გამოჩნდება, როცა ადამიანები მათ გამოყენებას დაიწყებენ."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("ახლა ტრენდშია"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("ვიდეოები"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("თქვენი ჩანართები"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("ის ორივესთვის გაქრება."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("ის ნაკადიდან წაიშლება."),
      "join": MessageLookupByLibrary.simpleMessage("შემოერთება"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("რედაქტირების გაგრძელება"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron-ის ეკრანები თქვენს ენაზეა. თუ რომელიმე სიტყვა უცნაურად ჟღერს, გვითხარით გამოხმაურების გაგზავნით."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("ენები"),
      "leave": MessageLookupByLibrary.simpleMessage("დატოვება"),
      "leaveCommunity": (Object a0) => "დატოვოთ ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("უკან შემოშვება"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("გახსნილია 1 გვერდი"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("კლიპის დამატება"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF-ის დამატება"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("ჰეშთეგის დამატება"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("ფოტოს დამატება"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("გამოკითხვის დამატება"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("ვიდეოს დამატება"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("ინტერესის დამატება"),
      "literaladdLabelAsATab": (Object a0) => "${a0}-ის ჩანართად დამატება",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("აპის ენა"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("აპის ვერსია"),
      "literalblockAuthor": (Object a0) => "${a0}-ის დაბლოკვა",
      "literalblockAuthor2": (Object a0) => "დაიბლოკოს ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("დაიბლოკოს ეს ანგარიში?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("პასუხის გაუქმება"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("ხელახლა შემოწმება"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("გალერეიდან არჩევა"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("ქეშის გასუფთავება"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("ყველა გვერდის დახურვა"),
      "literalcloseTabLabel": (Object a0) => "${a0}-ის დახურვა",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("ბრაუზერის დახურვა"),
      "literalcloseWidgetCommunityName": (Object a0) => "დაიხუროს ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("მხარდაჭერასთან დაკავშირება"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("კონტენტის ენები"),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("ბმულის კოპირება"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("პოსტის ბმულის კოპირება"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("პოსტის ტექსტის კოპირება"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("ტექსტის კოპირება"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("საზოგადოებები ვერ ჩაიტვირთა"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF-ები ვერ ჩაიტვირთა"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("შეტყობინებები ვერ ჩაიტვირთა"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("წევრები ვერ ჩაიტვირთა"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("ეს პოსტები ვერ ჩაიტვირთა"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("ეს საუბარი ვერ ჩაიტვირთა"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("ეს სია ვერ ჩაიტვირთა"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("ეს პოსტი ვერ ჩაიტვირთა"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("ეს პასუხი ვერ ჩაიტვირთა"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "პოპულარული თეგები ვერ ჩაიტვირთა"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "თქვენი საზოგადოებები ვერ ჩაიტვირთა"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "თქვენი შეტყობინებები ვერ ჩაიტვირთა"),
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("ეს საზოგადოება ვერ გაიხსნა"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("პასუხი ვერ გამოქვეყნდა."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("ძიებამ არ იმუშავა"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "გასვლა ვერ მოხერხდა: ${a0}",
      "literalcountPagesOpen": (Object a0) => "გახსნილია ${a0} გვერდი",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("ყდის ფოტო"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("მონაცემების დაზოგვა"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("პოსტის წაშლა"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("ადამიანების პოვნა"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("ნუ უპასუხებთ"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("მონახაზი შეინახა"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "გამოხმაურების გაგზავნა ახლა შეუძლებელია"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("ტექსტის ზომა"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF-ები არ არის დაყენებული"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("სხვა აპისთვის გადაცემა"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("პაროლის დამალვა"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("ამ პოსტის დამალვა"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "მალავს და გვთხოვს, ნაკლები ასეთი ვაჩვენოთ"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("როგორ მოვიქცეთ"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("წერის გაგრძელება"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron-მა არ უპასუხა"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0} თარიღი",
      "literalleaveCommunityName": (Object a0) => "დატოვოთ ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, სახის ლინზა",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("მოწონებული პოსტები"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("ბმული დაკოპირდა"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("მოდერატორად დანიშვნა"),
      "literalmuteAuthor": (Object a0) => "${a0}-ის დადუმება",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("ამ ნაკადის დადუმება"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("სიტყვების ან თეგების დადუმება"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "დადუმებული და დაბლოკილი ანგარიშები"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "დადუმებულია. შეტყობინებებს არ მიიღებთ."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "ამ მოწყობილობის არცერთი აპი არ ხსნის ${a0} ბმულებს.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "ამ მოწყობილობის არცერთმა ბრაუზერმა ბმული არ მიიღო."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("DID ჯერ არ არის"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("მონახაზები არ არის"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("ინტერესები ჯერ არ არის"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("მოწონებები ჯერ არ არის"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("შეტყობინებები ჯერ არ არის"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("ახალი გამომწერები არ არის"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("პოსტები ჯერ არ არის"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("პასუხები ჯერ არ არის"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("გაზიარებები ჯერ არ არის"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "არცერთი პოპულარული თეგი არ ემთხვევა"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("ვერავინ მოიძებნა"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("არავინ ამოშლილა"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("აქ ჯერ არავინაა"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("არ მაინტერესებს"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("ვერაფერი მოიძებნა"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("ჯერ არაფერია ტრენდში"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("ჟურნალში ჯერ არაფერია"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("დამთხვევა არ არის"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("დადუმებული არაფერია"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("სანახავი ჯერ არაფერია"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("წაუკითხავი არ არის"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "ამის შეცვლა მხოლოდ მფლობელს შეუძლია"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("პასუხის გახსნა"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("გახსენით Kyron-ის წერილი"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("პაროლი და შესვლა"),
      "literalpostInCommunityName": (Object a0) => "გამოქვეყნება ${a0}-ში",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "გამოქვეყნება ${a0}-ში",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "გამოაქვეყნეთ საკუთარი სიტყვებით ზემოთ"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("მთავარი ენა"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push შეტყობინებები"),
      "literalreading": MessageLookupByLibrary.simpleMessage("მოწმდება…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("ხმოვანი პოსტის ჩაწერა"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("ხელახლა ჩაწერა"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("მოდერატორობიდან მოხსნა"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("საზოგადოებიდან ამოშლა"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("შენახულებიდან ამოშლა"),
      "literalremoveLabel": (Object a0) => "${a0}-ის ამოშლა",
      "literalremoveLanguageEnglishname": (Object a0) => "${a0}-ის ამოშლა",
      "literalremoveMemberDisplayname": (Object a0) => "ამოიშალოს ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("გამოკითხვის ამოშლა"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("ამ პასუხის ამოშლა"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("ამ საუბრის წაშლა"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("ამ გამოკითხვის ამოშლა"),
      "literalreportAuthor": (Object a0) => "${a0}-ის გასაჩივრება",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("პოსტის გასაჩივრება"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("კოდის ხელახლა გაგზავნა"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("შენახული პოსტები"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("თქვით რამე"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "თქვით რამე ${a0}-ში",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("ძიება ვერ მოხერხდა"),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("ხელახლა გაგზავნა"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "ხელახლა გაგზავნა ${a0} წმ-ში",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("გამოხმაურების მიცემა"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("ბმულის გაგზავნა"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "გაიგზავნა. ეს არის ანგარიში №${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("დააყენეთ პაროლი და გააგრძელეთ"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "ჟურნალის გაზიარება მხარდაჭერასთან"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("ამ საზოგადოების გაზიარება"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("ამ გვერდის გაზიარება"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("ამ პროფილის გაზიარება"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("გაზიარება…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("ციტატით გაზიარება"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("მეტი ასეთის ჩვენება"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("პაროლის ჩვენება"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("შედეგების ჩვენება"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("საზოგადოების შექმნა"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("ჩაწერის დაწყება"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("ჩატვირთვის შეჩერება"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "აღარ ვნახო ეს პოსტი და მისი პასუხები"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "ისტორიების ზოლი, ${a0} ელემენტი",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("კამერის შეცვლა"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("ვინმეს მონიშვნა"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("ფოტოს გადაღება"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "შესაცვლელად შეეხეთ ბანერს ან ფოტოს"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("შეეხეთ მასში არსებულ ბმულს"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "შეეხეთ ფოტოსა და ყდის დასამატებლად"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("არ გამოვიდა. სცადეთ ხელახლა."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("ეს GIF ვერ ჩაიტვირთა."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "ამ ბმულის აქ გახსნა შეუძლებელია."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("კამერა დახურულია"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("ეს საზოგადოება"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("ეს პასუხი აღარ არსებობს"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("პოსტის თარგმნა"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("ხმის გამორთვა"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("ხმის ჩართვა"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("ჩვენგან ერთ-ერთის გამოყენება"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "დადასტურების კოდი ხელახლა გაიგზავნა."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "დადასტურება ვერ მოხერხდა: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("ელფოსტის დადასტურება"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "მაყურებლები, მოწონებები, შენახვები და კომენტარები"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("რას ინახავს Kyron"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("რას აკეთებდა ეს აპი"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "რა გააკეთეთ, რას ელოდით, რა მოხდა "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("რასაც აქვეყნებთ, თქვენია"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "ხელმისაწვდომია თუ არა Kyron ახლა"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("ვის შეუძლია პასუხი"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("ვის მონიშვნა გსურთ?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "უკვე გამოწერილი გაქვთ ყველა პოპულარული თეგი"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("ყველაფერი ნახეთ"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("არცერთ საზოგადოებაში არ ხართ"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("გამოხვედით."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "დატოვეთ ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("ჯერ არაფერი გამოგიქვეყნებიათ"),
      "loadMore": MessageLookupByLibrary.simpleMessage("მეტის ჩატვირთვა"),
      "logCleared": MessageLookupByLibrary.simpleMessage("ჟურნალი გასუფთავდა"),
      "logCopied": MessageLookupByLibrary.simpleMessage("ჟურნალი დაკოპირდა"),
      "logIn": MessageLookupByLibrary.simpleMessage("შესვლა"),
      "logOut": MessageLookupByLibrary.simpleMessage("გასვლა"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("გახვიდეთ?"),
      "login": MessageLookupByLibrary.simpleMessage("შესვლა"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "შესვლა ვერ მოხერხდა. შეამოწმეთ მონაცემები."),
      "manage": MessageLookupByLibrary.simpleMessage("მართვა"),
      "menu": MessageLookupByLibrary.simpleMessage("მენიუ"),
      "message": MessageLookupByLibrary.simpleMessage("შეტყობინება"),
      "messages": MessageLookupByLibrary.simpleMessage("შეტყობინებები"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "ყველა საუბარი წაკითხული გაქვთ."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "გახსენით ვინმეს პროფილი და შეეხეთ შეტყობინებას საუბრის დასაწყებად."),
      "mute": MessageLookupByLibrary.simpleMessage("დადუმება"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("დადუმებული და დაბლოკილი"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("დადუმებული სიტყვები და თეგები"),
      "name": MessageLookupByLibrary.simpleMessage("სახელი"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> ეკრანი"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("ახალი ელფოსტის მისამართი"),
      "newPassword": MessageLookupByLibrary.simpleMessage("ახალი პაროლი"),
      "newPost": MessageLookupByLibrary.simpleMessage("ახალი პოსტი"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("ახლა არა"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "ვერ გაიგზავნა. შეეხეთ ხელახლა საცდელად"),
      "nothingMatchesQuery": (Object a0) =>
          "Kyron-ზე \"${a0}\"-ს არაფერი ემთხვევა",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("დასაკოპირებელი არაფერია"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "მოწონებები, პასუხები და ახალი გამომწერები აქ მოდის."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "ადამიანები, ვინც გამოგიწერთ, აქ გამოჩნდებიან."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "როცა ვინმე მოიწონებს თქვენს პოსტს, აქ გამოჩნდება."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "თქვენს პოსტებზე პასუხები აქ მოდის."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "როცა ვინმე გაგაზიარებთ, აქ გამოჩნდება."),
      "notifications": MessageLookupByLibrary.simpleMessage("შეტყობინებები"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("ბრაუზერში გახსნა"),
      "or": MessageLookupByLibrary.simpleMessage("ან"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("გვერდი ვერ მოიძებნა"),
      "password": MessageLookupByLibrary.simpleMessage("პაროლი"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("პაროლი ძალიან მოკლეა"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("აირჩიეთ ინტერესები"),
      "post": MessageLookupByLibrary.simpleMessage("გამოქვეყნება"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("პოსტის სტატისტიკა"),
      "postInCommunity": (Object a0) => "გამოქვეყნება ${a0}-ში",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("გამოაქვეყნე, თქვი, აჩვენე."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("პოსტის ტექსტი დაკოპირდა"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("კონფიდენციალურობის პოლიტიკა"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("პროფილი განახლდა"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("ბიო"),
      "profile_country": MessageLookupByLibrary.simpleMessage("ქვეყანა"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("საჩვენებელი სახელი"),
      "profile_location": MessageLookupByLibrary.simpleMessage("მდებარეობა"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("შეეხეთ შესაცვლელად"),
      "profile_website": MessageLookupByLibrary.simpleMessage("ვებსაიტი"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push შეტყობინებები"),
      "quote": MessageLookupByLibrary.simpleMessage("ციტირება"),
      "quotePost": MessageLookupByLibrary.simpleMessage("პოსტის ციტირება"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("ადამიანთან დაკავშირება"),
      "remove": MessageLookupByLibrary.simpleMessage("ამოშლა"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("წაიშალოს ეს საუბარი?"),
      "removeMember": (Object a0) => "ამოიშალოს ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("წაიშალოს ეს შეტყობინება?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "პასუხები, გამოწერები და მოხსენიებები"),
      "repliesPolicy": (Object a0) => "პასუხები: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("პასუხი"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("ნებისმიერს შეუძლია ჩართვა"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "ნებისმიერს კვლავ შეუძლია ამ პოსტის ნახვა, გაზიარება და ციტირება."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-ზე ნებისმიერს შეუძლია ამ პოსტზე პასუხი."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("თქვენი გამომწერები"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "ამ პოსტზე პასუხი მხოლოდ თქვენს გამომწერებს შეუძლიათ."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("ადამიანები, ვინც მოიხსენიეთ"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "პასუხი მხოლოდ მათ შეუძლიათ, ვინც ამ პოსტში @მოიხსენიეთ."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("პასუხი არავის შეუძლია"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "პასუხები გამორთულია. თქვენ მაინც შეგიძლიათ პასუხი."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("ვის შეუძლია პასუხი?"),
      "report": MessageLookupByLibrary.simpleMessage("დაჩივლება"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "ანგარიში დაკოპირდა. ჩასვით მხარდაჭერისთვის გასაგზავნ წერილში."),
      "reportSent": MessageLookupByLibrary.simpleMessage("საჩივარი გაიგზავნა"),
      "repost": MessageLookupByLibrary.simpleMessage("გაზიარება"),
      "reset": MessageLookupByLibrary.simpleMessage("გადაყენება"),
      "resetPassword": MessageLookupByLibrary.simpleMessage("აღადგინეთ პაროლი"),
      "retry": MessageLookupByLibrary.simpleMessage("ხელახლა ცდა"),
      "save": MessageLookupByLibrary.simpleMessage("შენახვა"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("მონახაზის შენახვა"),
      "saySomething": (Object a0) => "თქვით რამე ${a0}-ში",
      "search": MessageLookupByLibrary.simpleMessage("ძიება"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "ძიება სახელით ან მომხმარებლის სახელით"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("საზოგადოებების ძიება"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF-ების ძიება"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("ენების ძიება"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("პოპულარული თეგების ძიება"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "უსაფრთხოების გაფრთხილებები და ანგარიშის ცვლილებები"),
      "selectAppLanguage":
          MessageLookupByLibrary.simpleMessage("აირჩიეთ აპის ინტერფეისის ენა."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "აირჩიეთ, რომელი ენები გამოჩნდეს თქვენს არხებში. თუ არცერთს აირჩევთ, ყველა ენა გამოჩნდება."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "აირჩიეთ მთავარი ენა არხის თარგმანებისთვის."),
      "send": MessageLookupByLibrary.simpleMessage("გაგზავნა"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("დადასტურების გაგზავნა"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("ხარვეზის ანგარიშის გაგზავნა"),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("გამოხმაურების გაგზავნა"),
      "sendReport": MessageLookupByLibrary.simpleMessage("საჩივრის გაგზავნა"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("მხარდაჭერისთვის გაგზავნა"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("სერვისის სტატუსი"),
      "settings": MessageLookupByLibrary.simpleMessage("პარამეტრები"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "აპის ჟურნალის გაზიარება მხარდაჭერასთან"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Kyron-ში შესვლა"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("შესული ხართ როგორც"),
      "signupFailed": (Object a0) => "რეგისტრაცია ვერ მოხერხდა: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("დარჩენა"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron ახლა იწყებს, და ყველაზე სწრაფი გზა იმ ადამიანამდე, ვისაც ნამდვილად შეუძლია გამოსწორება, ბილეთის გახსნაა. გვითხარით, რას აკეთებდით და რა მოხდა."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "აპს ჯერ მხარდაჭერის საფოსტო ყუთი არ აქვს, ამიტომ ეს ეკრანი გაგზავნით იქ, სადაც ნამდვილად ადევნებენ თვალს, და არა ფორმაზე, რომელიც არსად მიდის."),
      "systemLog": MessageLookupByLibrary.simpleMessage("აპის ჟურნალი"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "გვითხარით, რა აკლია ან რა გაფუჭდა"),
      "terms": MessageLookupByLibrary.simpleMessage("მომსახურების პირობებს"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "ტექსტი, ხმა და ვიდეო, მათი შემქმნელები და ოთახები, სადაც ისინი საუბრობენ."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "რედაქტორში გამოქვეყნების ღილაკი არ არის"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("მუქი"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("ყოველთვის მუქი"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("ჩამქრალი"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "უფრო რბილი მუქი, შავის ნაცვლად მოლურჯო ნაცრისფერი"),
      "theme_light": MessageLookupByLibrary.simpleMessage("ღია"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("ყოველთვის ღია"),
      "theme_system": MessageLookupByLibrary.simpleMessage("სისტემა"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "ტელეფონის ღია ან მუქი პარამეტრის მიხედვით"),
      "translate": MessageLookupByLibrary.simpleMessage("თარგმნა"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "თარგმანი ჯერ ჩართული არ არის. თქვენს არხში ჯერ არაფერი ითარგმნება; ეს მანამდე დამახსოვრდება."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "ეს ცვლის Kyron-ის საკუთარ სიტყვებს, ინტერფეისის ნაწილებს, რომლებსაც Flutter თავად ხატავს, თარიღებსა და რიცხვებს, აგრეთვე აპის განლაგების მიმართულებას მარჯვნიდან მარცხნივ დაწერილი ენებისთვის."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("ხელახლა ცდა"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("კონფიდენციალურობის პოლიტიკა"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("მომსახურების პირობები"),
      "ui_account": MessageLookupByLibrary.simpleMessage("ანგარიში"),
      "ui_after": MessageLookupByLibrary.simpleMessage("შემდეგ"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("აპი და მოწყობილობა"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "ციტატა სხვების თაღლითობაზე გასაფრთხილებლად იყო."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "დაწერეთ, რატომ ფიქრობთ, რომ გადაწყვეტილება მცდარი იყო: რას ნიშნავდა პოსტი, რა შეიძლება გამორჩენოდა გუნდს ან რატომ არ შეესაბამება წესი. მას წაიკითხავს სხვა ადამიანი და არა ის, ვინც გადაწყვიტა."),
      "ui_appeal_label":
          MessageLookupByLibrary.simpleMessage("თქვენი გასაჩივრება"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "დაწერეთ მინიმუმ \$count სიმბოლო. თითოეული გადაწყვეტილების გასაჩივრება ერთხელ შეგიძლიათ."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("გასაჩივრების გაგზავნა"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "გასაჩივრება გაიგზავნა. როცა გადაწყვეტილება მიიღება, შეტყობინებას მიიღებთ."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("საქმე \$number-ის გასაჩივრება"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("იერსახე"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "ღია, მუქი ან ტელეფონის მიხედვით"),
      "ui_before": MessageLookupByLibrary.simpleMessage("მანამდე"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-ზე ერთმანეთს ვეღარ დაინახავთ და თქვენ შორის გამოწერები მოიხსნება. მას არ ეცნობება."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("შეიცავს"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("რისთვისაა (არასავალდებულო)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "წერა მხოლოდ მოდერატორებს შეუძლიათ"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "განცხადებებისთვის. თემის ყველა წევრს კვლავ შეუძლია წაკითხვა და რეაგირება."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("ფოტოს ან გამოკითხვის დამატება"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("ფოტოები და ვიდეოები"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("ჩატის დახურვა"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "მასში ვეღარავინ წაიკითხავს ან დაწერს. ამის გაუქმება შეუძლებელია."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("დაიხუროს ეს ჩატი?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("დაკოპირდა"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "შეტყობინება ყველასთვის წაიშლება. Kyron ინახავს ასლს განსახილველად."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "შეტყობინება ჩატში ყველასთვის წაიშლება."),
      "ui_cchat_edit":
          MessageLookupByLibrary.simpleMessage("ჩატის რედაქტირება"),
      "ui_cchat_edit_message":
          MessageLookupByLibrary.simpleMessage("რედაქტირება"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("რედაქტირებული"),
      "ui_cchat_editing": MessageLookupByLibrary.simpleMessage(
          "თქვენ არედაქტირებთ შეტყობინებას"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("ამ ჩატის გახსნა ვერ მოხერხდა."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("ჩატები"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("ჩატში შესვლა"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "შეუერთდით თემს, რომ ნახოთ მისი ჩატები და მონაწილეობა მიიღოთ."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("შემოუერთდა: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("ჩატიდან გასვლა"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "სანამ თემში ხართ, მისი კითხვა კვლავ შეგიძლიათ."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "აქ წერა მხოლოდ მფლობელსა და მოდერატორებს შეუძლიათ."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("დადუმება"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "მისგან შეტყობინებებს არ მიიღებთ და ის არ ჩაითვლება შეტყობინებების რაოდენობაში."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("ჩატის სახელი"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("ახალი ჩატი"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("ჯერ ჩატები არ არის."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "ჯერ ჩატები არ არის. გახსენით ერთი თემისთვის."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "თემის ჩატები არ არის ბოლომდე დაშიფრული. თემის მოდერატორებსა და Kyron-ს შეუძლიათ მათი წაკითხვა."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("ზემოთ მიმაგრება"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("პასუხის დამატება"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("გამოკითხვის დახურვა"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("დახურულია"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "ყველა ხედავს, რამდენმა აირჩია თითოეული პასუხი, მაგრამ არასდროს — ვინ."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("რამდენიმე არჩევანის დაშვება"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("ახალი გამოკითხვა"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("აირჩიეთ ერთი"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("პასუხი \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("გამოკითხვა: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("კითხვა"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "თითოეული პასუხი გამოკითხვაში მხოლოდ ერთხელ შეიძლება იყოს."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("აირჩიეთ ერთი ან მეტი"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("უპასუხა: \$count"),
      "ui_cchat_search": MessageLookupByLibrary.simpleMessage("ძიება ამ ჩატში"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("ძიება ამ ჩატში"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("ვერაფერი მოიძებნა."),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("ამ ჩატს ვეღარ ხედავთ."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("ნელი რეჟიმი"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "რამდენ ხანს უნდა დაელოდოთ შეტყობინებებს შორის. მოდერატორებზე არ ვრცელდება."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 საათი"),
      "ui_cchat_slow_minutes": MessageLookupByLibrary.simpleMessage("\$n წუთი"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "ნელი რეჟიმი: ერთი შეტყობინება ყოველ \$seconds წამში"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("გამორთული"),
      "ui_cchat_slow_seconds": MessageLookupByLibrary.simpleMessage("\$n წამი"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "როგორც მაყურებელს, შეგიძლიათ წაკითხვა და რეაგირება. დასაწერად შეუერთდით."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "ეს შეტყობინება ზედმეტად ძველია საჩვენებლად."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "თქვენ მიერ არჩეულთაგან ერთ-ერთი გასაგზავნად ზედმეტად დიდია და გამოტოვებულია."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("დადუმების მოხსნა"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("მოხსნა"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("ხმოვანი შეტყობინების ჩაწერა"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("თქვენ"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("საზოგადოებები"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("რისთვისაა? (არასავალდებულო)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("პოსტები:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("კონტენტი და ჩვენება"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("თქვენი არხი ვერ ჩაიტვირთა"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "მოწონებული პოსტები ვერ ჩაიტვირთა"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("თქვენი პროფილი ვერ ჩაიტვირთა"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "შენახული პოსტები ვერ ჩაიტვირთა"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("დეცენტრალიზებული ID"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("პრობლემების მოგვარება"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("ჯგუფები"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("ჯგუფები არ არის"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "აქ ჩანს ჯგუფები, რომლებშიც ხართ, და თემების ჩატები, რომლებსაც უერთდებით."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "შეგიძლიათ მიამაგროთ \$count ჩატამდე. ჯერ ერთი მოხსენით."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("მიმაგრებული"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("მოწონებული"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("შენახული"),
      "ui_feed_empty": MessageLookupByLibrary.simpleMessage("აქ ჯერ არაფერია"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "გამოიწერეთ რამდენიმე ანგარიში და მათი პოსტები აქ გამოჩნდება."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("გამოწერილებისგან არაფერია"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "პოსტები აქ გამოჩნდება, როცა ადამიანები დაწერენ."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("სუსტდება"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("არ მაინტერესებს"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("მსგავსის მეტის ჩვენება"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("წაიშალა"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("თქვენი არხის სიგნალები"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "შეეხეთ პოსტზე „მსგავსი პოსტების მეტის ჩვენებას“ ან „ეს არ მაინტერესებს“ და ის აქ გამოჩნდება."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("აქ ჯერ არაფერია"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "რას ეუბნება თქვენს არხებს „მეტის ჩვენება“ და „არ მაინტერესებს“"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "ისინი აყალიბებენ მთავარს და აღმოჩენას, ძირითადად თითოეული პოსტის თემის მიხედვით. თითოეული ყოველთვე ნახევრდება და ექვსი თვის შემდეგ აღარ ითვლება. წაშალეთ ერთ-ერთი, რომ ახლავე შეაჩეროთ."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "კლიპიანი პოსტები აქ გამოჩნდება."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("ვიდეოები ჯერ არ არის"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("გამოხმაურება"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("იპოვეთ ადამიანები Kyron-ზე"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("ანგარიშიდან"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("ხალხის დამატება"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("დამატება"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("ჯგუფის სახელის დამატება"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("უარყოფა"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "ამ ჯგუფის შეტყობინებები ბოლომდე დაშიფრულია, როგორც ნებისმიერი სხვა საუბარი."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor-მა დაამატა: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor-მა ადმინად დანიშნა: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor-მა შექმნა ჯგუფი"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor-მა დააყენა, რომ ახლები წევრებად შემოვიდნენ"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor-მა დააყენა, რომ ახლები მაყურებლებად შემოვიდნენ"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor გავიდა"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor-მა წევრად დანიშნა: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor-მა მფლობელობა გადასცა: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor-მა წაშალა: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor-მა ჯგუფს სახელი შეუცვალა: \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor-მა მაყურებლად დანიშნა: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "ჯგუფში შეიძლება იყოს მაქსიმუმ \$count ადამიანი."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "ხელი აწეულია. ადმინებს ეცნობათ."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("წერა სურთ: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("წერა სურთ"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "მოგვიანებით დამატებულები მაყურებლებად შემოდიან"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("ჯგუფიდან გასვლა"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "ის გაქრება თქვენი სიიდან და ვერ ნახავთ, რას იტყვიან შემდეგ. ვინმეს მოუწევს თქვენი ხელახლა დამატება."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("გახვალთ ამ ჯგუფიდან?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("წერის ნებართვა"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("ხელის დაშვება"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("ადმინად დანიშვნა"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("მფლობელად დანიშვნა"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("მაყურებლად დანიშვნა"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count წევრი"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("წევრები"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("ჯგუფის სახელი"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("ჯერ ჯგუფს სახელი დაარქვით."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("ჯგუფური ჩატის შექმნა"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "მფლობელი ერთია. თქვენ ადმინად დარჩებით."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("გადაეცეს მფლობელობა \$name-ს?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("ხელის აწევა"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("ჯგუფიდან წაშლა"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("ადმინობის მოხსნა"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("თქვენ აღარ ხართ ამ ჯგუფში."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("სახელის შეცვლა"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("ადმინი"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("წევრი"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("მაყურებელი"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "როგორც მაყურებელს, აქ შეგიძლიათ წაიკითხოთ და გამოეხმაუროთ."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "მაყურებლებს შეუძლიათ წაიკითხონ, გამოეხმაურონ და ხელი ასწიონ წერის სათხოვნელად."),
      "ui_group_suggested":
          MessageLookupByLibrary.simpleMessage("შემოთავაზებული"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("პროფილის ნახვა"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("თქვენ"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("თქვენ მაყურებელი ხართ"),
      "ui_help": MessageLookupByLibrary.simpleMessage("დახმარება"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "აღინიშნა. ეს გვეხმარება აგირჩიოთ, რა გაჩვენოთ."),
      "ui_join": MessageLookupByLibrary.simpleMessage("შემოერთება"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("შემოუერთდა"),
      "ui_language": MessageLookupByLibrary.simpleMessage("ენა"),
      "ui_language_detail": MessageLookupByLibrary.simpleMessage("აირჩიეთ ენა"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("სამართლებრივი"),
      "ui_like": MessageLookupByLibrary.simpleMessage("მოწონება"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("მოწონებული პოსტები"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "მოწონებული პოსტები აქ ჩანს, უახლესი პირველად."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("ბმული დაკოპირდა"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "მის პოსტებს აღარ დაინახავთ. მას არ ეცნობება."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("მოწონებები ჯერ არ არის"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "ამ ფილტრებს არცერთი პოსტი არ ემთხვევა."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("შენახული ჯერ არაფერია"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("თქვენი ანგარიში განახლდა"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "თქვენი გასაჩივრება საქმეზე \$number დაკმაყოფილდა"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "თქვენი გასაჩივრება საქმეზე \$number ხელახლა განვიხილეთ და გადაწყვეტილება ძალაში რჩება"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "თქვენი ანგარიში სამუდამოდ დაიბლოკა"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("საქმე \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("გამოგიწერათ"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("მოიწონა თქვენი პოსტი"),
      "ui_notif_mentioned": MessageLookupByLibrary.simpleMessage("მოგიხსენიათ"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("ჯერ მოხსენიებები არ არის"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "როცა ვინმე პოსტში ან პასუხში თქვენს @სახელს დაწერს, აქ გამოჩნდება."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("უფრო ძველი"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "თქვენი შეტყობინება თემის ჩატში წაიშალა"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "თქვენ მიერ გამოქვეყნებული რაღაც წაიშალა"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("თქვენი პოსტი წაიშალა"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("თქვენი პასუხი წაიშალა"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("უპასუხა თქვენს პოსტს"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "თქვენს საჩივარზე ზომები მივიღეთ. გმადლობთ, რომ შეგვატყობინეთ."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "თქვენი საჩივარი განვიხილეთ და ჩვენი წესების დარღვევა ვერ დავადგინეთ."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("საჩივრის მიზეზი: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("გააზიარა თქვენი პოსტი"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "საქმეზე \$number გადაწყვეტილება გავაუქმეთ"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("თქვენი ანგარიში შეჩერებულია"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "თქვენი ანგარიში შეჩერებულია \$date-მდე"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("ყველა"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("გამომწერები"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("მოწონებები"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("მოხსენიებები"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("პასუხები"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("ამ კვირაში"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("დღეს"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "თქვენმა ანგარიშმა გაფრთხილება მიიღო"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("გუშინ"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("მზადაა"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("გამოტოვება"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("ეს უკვე გაიხსნა."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("ვადა გაუვიდა"),
      "ui_once_failed": MessageLookupByLibrary.simpleMessage("ვერ გაიხსნა."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "იხსნება ერთხელ, შემდეგ იშლება Kyron-იდან."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("ერთხელ ნახვა"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("გახსნილია"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("გახსნა \$count-მა \$total-დან"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "მისი გახსნა მხოლოდ მათ შეუძლიათ, ვისაც გაუგზავნეთ, ერთხელ."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("ერთჯერადი ნახვისთვის გაგზავნა"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("შეეხეთ სანახავად"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("პაუზა"),
      "ui_play": MessageLookupByLibrary.simpleMessage("დაკვრა"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "ის წაიშლება თქვენი პროფილიდან და ყველას არხიდან. მისი პასუხებიც მასთან ერთად გაქრება."),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("პოსტი წაიშალა"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("პოსტი დაიმალა"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("პოსტის ტექსტი დაკოპირდა"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("გამოქვეყნდა შუალედში"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "დაიმალა. ნაკლებ ასეთს ვაჩვენებთ."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("პარამეტრები"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("კონფიდენციალურობა"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "გსურთ რამის დამატება? (არასავალდებულო)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "გუნდის გადაწყვეტილებისას შეტყობინებას მიიღებთ, ხოლო მიმდინარეობას „თქვენს საჩივრებში“ ნახავთ."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "თუ ამ ადამიანის ნახვაც აღარ გსურთ, იმავე მენიუდან შეგიძლიათ დაადუმოთ ან დაბლოკოთ."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "ერთი და იმავეზე ორჯერ საჩივარი მას მეტ წონას არ სძენს: თითო ადამიანისგან ერთ საჩივარს ვინახავთ."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "თქვენი საჩივარი ამ ადამიანს არ ეზიარება. ვინახავთ იმის ასლს, რაზეც იჩივლეთ, რომ წაშლის შემთხვევაშიც შემოწმდეს."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "თქვენი საჩივარი მიღებულია და შემოწმების რიგშია. ამ ადამიანს არ ვეუბნებით, ვინ იჩივლა."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("თქვენი საჩივრების ნახვა"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("გვითხარით, რა არის არასწორი"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("გმადლობთ, რომ გვაცნობეთ"),
      "ui_report_what_account": MessageLookupByLibrary.simpleMessage(
          "რა პრობლემაა ანგარიშთან \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "რა პრობლემაა ამ შეტყობინებასთან?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("რა პრობლემაა ამ პოსტთან?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("რა პრობლემაა ამ პასუხთან?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("შეტყობინება თემის ჩატში"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("პოსტი"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("პასუხი"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("ზომები მიღებულია"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("ანგარიში"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("გადაწყდა: \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("წესები არ დარღვეულა"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "თქვენი საჩივრები ვერ ჩაიტვირთა"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "რაზეც საჩივარი შეიტანეთ ბოლო 90 დღეში და რით დასრულდა. შეტყობინებას იღებთ, როცა გუნდი გადაწყვეტს. ვისზეც საჩივარს შეიტანთ, ვერასდროს გაიგებს, ვინ შეიტანა."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("საჩივრები არ არის"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "როცა საჩივარს შეიტანთ პოსტზე, პასუხზე, შეტყობინებაზე ან ანგარიშზე, ის აქ გამოჩნდება შედეგთან ერთად."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("განხილვის პროცესშია"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("შეტანილია: \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "რაზეც საჩივარი შეიტანეთ და რით დასრულდა"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("თქვენი საჩივრები"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("ბავშვების უსაფრთხოება"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "ყველაფერი, რაც საფრთხეს უქმნის ან სექსუალიზაციას უკეთებს არასრულწლოვანს."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "მიზანმიმართული შევიწროება, მუქარა ან არასასურველი კონტაქტი."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "თავდასხმა ადამიანებზე იმის გამო, თუ ვინ არიან."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "რაიმე უკანონოს გაყიდვა ან რეკლამირება."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "სხვა ადამიანად თავის გასაღება."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "იყენებს თქვენს ნამუშევარს ან სავაჭრო ნიშანს ნებართვის გარეშე."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "შეცდომაში შემყვანი მტკიცებები ჯანმრთელობაზე, არჩევნებზე ან მოვლენებზე."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "თვითდაზიანების წახალისება ან ჩვენება."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "გაფრთხილების გარეშე ნაჩვენები სექსუალური შინაარსი."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "არცერთი ზემოთ ჩამოთვლილი. გვითხარით, რა არის არასწორი."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "განმეორებადი, შეცდომაში შემყვანი ან არასასურველი რეკლამა."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "ძალადობით მუქარა, მისი განდიდება ან მისკენ წაქეზება."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("შევიწროება ან ბულინგი"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("სიძულვილის ენა"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "უკანონო საქონელი ან მომსახურება"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("სხვის სახელით გამოსვლა"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("ინტელექტუალური საკუთრება"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("ცრუ ინფორმაცია"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "თვითმკვლელობა ან თვითდაზიანება"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("ზრდასრულთა კონტენტი"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("სხვა რამ"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("სპამი"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("ძალადობა ან მუქარა"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("შენახული პოსტები"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "შეეხეთ პოსტის არქივის ხატულას, რომ აქ შეინახოთ. შენახულს მხოლოდ თქვენ ხედავთ."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "მოძებნეთ მომხმარებლის ან საჩვენებელი სახელით."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("გასუფთავება"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("ძიება ყველა გამოქვეყნებულში"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("ფილტრები"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("ადამიანების ძიება"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("პოსტების ძიება"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("პარამეტრები"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("აპი და მოწყობილობა"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("კონტენტი და ჩვენება"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("მონაცემების დაზოგვა"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("გაგვიზიარეთ აზრი"),
      "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage(
          "დახმარების სტატიების დათვალიერება"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("აირჩიეთ ენა"),
      "ui_settings_muted_blocked":
          MessageLookupByLibrary.simpleMessage("ვინ დაადუმეთ ან დაბლოკეთ"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("შეტყობინებების პარამეტრები"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "თქვენი პროფილი და საკონტაქტო მონაცემები"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "ანგარიშზე დასაბრუნებლად ხელახლა შესვლა დაგჭირდებათ."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("უსაფრთხოების პარამეტრები"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("დაადასტურეთ პაროლი"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("ერთ ხაზზე"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("ახალი ელფოსტის მისამართი"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("ახალი პაროლი"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("რა მოხდა"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "მიიღეთ დახმარება ჩვენი გუნდისგან"),
      "ui_share": MessageLookupByLibrary.simpleMessage("გაზიარება"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("ციტირება"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("გაგზავნა შეტყობინებით"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Kyron-ის ადამიანებს"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("ამ პოსტის გაზიარება"),
      "ui_standing_about": MessageLookupByLibrary.simpleMessage("რას ეხებოდა"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "თქვენი ანგარიში სამუდამოდ დაიბლოკა"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("პასუხი, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("გასაჩივრება"),
      "ui_standing_appeal_button": MessageLookupByLibrary.simpleMessage(
          "ამ გადაწყვეტილების გასაჩივრება"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "ამ გადაწყვეტილების გასაჩივრება აღარ შეიძლება. თუ რამე არასწორია, დაუკავშირდით მხარდაჭერას."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("გასაჩივრება განიხილება"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("გასაჩივრება დაკმაყოფილდა"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "გუნდის სხვა წევრი ამას ხელახლა განიხილავს. როცა გადაწყვეტილება მიიღება, შეტყობინებას მიიღებთ."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "თუ ფიქრობთ, რომ ეს შეცდომა იყო, \$date-მდე შეგიძლიათ ხელახალი განხილვა მოითხოვოთ. გადაწყვეტს გუნდის სხვა წევრი."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "გასაჩივრდა: გადაწყვეტილება ძალაში რჩება"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "საქმე \$number. წესი: \$rule. გუნდმა დაწერა:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "ანგარიშის წაშლა ბლოკს არ ხსნის: იმავე ელფოსტის მისამართით შექმნილი ახალი ანგარიშიც დაბლოკილი იწყება."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("სამუდამოდ დაბლოკილი"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "მუშაობს მხოლოდ ეს გვერდი, გასაჩივრებები, მხარდაჭერა და ანგარიშის წაშლა."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("შესაძლებელია გასაჩივრება"),
      "ui_standing_case":
          MessageLookupByLibrary.simpleMessage("საქმე \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("გადაწყდა \$date"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "გადაწყვეტილებები თქვენს ანგარიშზე"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("თქვენი ანგარიშის წაშლა"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("დეტალების ნახვა"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "დეტალების ნახვა და გასაჩივრება"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("მთავრდება \$date"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "თქვენი ანგარიში კარგ მდგომარეობაშია"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("არაფერი ზღუდავს მას."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "ანგარიშის სტატუსი ვერ ჩაიტვირთა"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("შეტყობინება წაიშალა"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "თქვენს ანგარიშზე გადაწყვეტილება არ მიღებულა. თუ გუნდი ოდესმე წაშლის თქვენს რამეს ან შეზღუდავს თქვენს ანგარიშს, ეს აქ მიზეზთან ერთად გამოჩნდება და შეძლებთ გასაჩივრებას."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "გასაჩივრებელი არაფერია: გადაწყვეტილება გაუქმდა."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("პოსტი წაიშალა"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "ხელახლა შესამოწმებლად ჩამოწიეთ."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Kyron-ის წესების წაკითხვა"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("პასუხი წაიშალა"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("გაუქმდა"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "გაუქმდა \$date. ყველაფერი წაშლილი დაბრუნდა და შეზღუდვა აღარ მოქმედებს."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("წესი: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("გასვლა"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("შეჩერებულია"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "შეგიძლიათ კითხვა, მაგრამ ვერ გამოაქვეყნებთ, ვერ უპასუხებთ, ვერ გამოიწერთ და ვერ გაგზავნით შეტყობინებებს. საჩივარი, დაბლოკვა და დადუმება კვლავ მუშაობს."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "თქვენი ანგარიში შეჩერებულია: შეგიძლიათ კითხვა, მაგრამ ვერ გამოაქვეყნებთ."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("შეჩერებულია \$date-მდე"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "თქვენი ანგარიში შეჩერებულია \$date-მდე: შეგიძლიათ კითხვა, მაგრამ ვერ გამოაქვეყნებთ."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("რა დაწერა გუნდმა"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("ანგარიშის სტატუსი"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("გაფრთხილება"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("რატომ?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("თქვენ დაწერეთ \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("თქვენი შეტყობინება"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("თქვენი პოსტი"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("თქვენი პასუხი"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("მომსახურების პირობებს"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ეს პოსტი"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("ნაკადი დადუმდა"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("ხელახლა ცდა"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("ხმის გამორთვა"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("ხმის ჩართვა"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("მინიმუმ ორი სიმბოლო."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("გაუქმება"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "სიტყვები ან ფილტრი: ანგარიში, თარიღების დიაპაზონი ან პოსტის შიგთავსი."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("გაზიარების გაუქმება"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("პაროლის განახლება"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("სხვა მისამართის გამოყენება"),
      "username": MessageLookupByLibrary.simpleMessage("მომხმარებლის სახელი"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "მომხმარებლის სახელი პატარა ასოებით უნდა იყოს (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("ვიდეო"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("მიმაგრება"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("მზადაა მისამაგრებლად"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("ხმოვანი პოსტის ჩაწერა"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("ინახება…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("შეჩერება"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("რა მოხდა"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "რა მოხდა და რას უნდა მივხედოთ?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("რა არის ამ სურათზე?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("რისთვისაა? (არასავალდებულო)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "რა გააკეთეთ, რას ელოდით, რა მოხდა"),
      "whatYouWereDoing":
          MessageLookupByLibrary.simpleMessage("რას აკეთებდით, როცა ეს მოხდა."),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("თქვენ უპასუხეთ"),
      "dmReplied": (Object a0) => "$a0 უპასუხა",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("შეტყობინებაში დამატება"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("ახალი შეტყობინება"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "ჯერ არაფერი თქმულა. ხელის დაქნევა კარგი დასაწყისია."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  ხელის დაქნევა"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("ახალი შეტყობინებები"),
      "dmTyping": (Object a0) => "$a0 წერს",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("თქვენი რეაქციის წაშლა"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("ვიღაც"),
      "ui_dm_quote_message":
          MessageLookupByLibrary.simpleMessage("შეტყობინება"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("დანართი"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "ამ შეტყობინების წაკითხვა ამ მოწყობილობაზე შეუძლებელია."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "ამ შეტყობინების მოლოდინში. ამას შეიძლება გარკვეული დრო დასჭირდეს."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("დაშიფრული შეტყობინება"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "შეტყობინებები დაშიფრულია ბოლოდან ბოლომდე"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "არ არის დაშიფრული ბოლოდან ბოლომდე"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("გაგზავნილია"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("ნანახია"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("იგზავნება…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("ფოტოს გადაღება"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("მეტი პარამეტრი"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("მოწყობილობაზე შენახვა"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("გაზიარება"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("ინახება…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("შეინახა თქვენს ფოტოებში"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "შენახვა ვერ მოხერხდა. სცადეთ ხელახლა."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "ამის შესანახად ნება დართეთ Kyron-ს, დაამატოს თქვენს ფოტოებში."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("ყველა სისტემა მუშაობს"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("მუშაობის დრო"),
      "ui_status_last_60": MessageLookupByLibrary.simpleMessage("ბოლო 60 დღე"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 დღის წინ"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("დღეს"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database":
          MessageLookupByLibrary.simpleMessage("მონაცემთა ბაზა"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("შესვლა"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("ბოლო ინციდენტები"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "ბოლო 60 დღეში ინციდენტი არ ყოფილა."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("მიმდინარეობს"),
      "ui_status_no_data":
          MessageLookupByLibrary.simpleMessage("მონაცემები არ არის"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("დეტალები"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron მუშაობისას ყოველ 5 წუთში ამოწმებს საკუთარ თავს. ნაცრისფერ დღეს შემოწმება არ ყოფილა."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "მუშაობის ისტორია ჯერ მიუწვდომელია."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "ზოგიერთ სისტემას პრობლემები აქვს"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("ხმოვანი შეტყობინების ჩაწერა"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("მზადაა გასაგზავნად"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("ეს შეტყობინება აქ აღარ არის."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("შეტყობინებაზე გადასვლა"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("ხმოვანი შეტყობინება"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("ავტორს მოეწონა"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("ფოტოს ან კლიპის დამატება"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("მედია"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("ხმოვანი შეტყობინებები"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("ჩატი"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("ფონი"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("შეტყობინებების დადუმება"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "ამ საუბრის შესახებ შეტყობინებების შეწყვეტა"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("მათ აღარ შეუძლიათ მოგწერონ"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("არცერთი"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("ფოტო"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("ხმა ჩაირთო."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "წაშლა ვერ მოხერხდა. სცადეთ ხელახლა."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("პროფილი"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("ხმის ჩართვა"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "თქვენ მიერ გაზიარებული ფოტოები და კლიპები აქ გამოჩნდება."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("ყველას ნახვა"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("ფოტოები და კლიპები"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("ასე გამოიყურება თქვენი ჩატი."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("კარგად გამოიყურება."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("ნისლი"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("ბინდი"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("სალბი"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("ქვიშა"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("წერტილები"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("გამოყენება"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("მიმდინარე"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("გაგზავნა გადახედვის გარეშე"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("ძიება"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("გამოქვეყნება"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("დაწერეთ შეტყობინება…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("გაგზავნა"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("გაიგზავნა"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "გაიგზავნა, მაგრამ არა ყველასთან."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "ვერ გაიგზავნა. სცადეთ ხელახლა."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("გამომწერი"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("ფილტრი"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("ყველა"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("წაუკითხავი"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("უპასუხო"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("დამალული"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("დამალული არაფერია"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "სიიდან ამოღებული საუბრები აქ გელოდებათ, თუ მათი დაბრუნება მოგინდებათ."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "ის დამალულებში გადადის. მეორე მხარე თავისას ინახავს და ის ბრუნდება, თუ რომელიმე თქვენგანი ისევ დაწერს."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("დაბრუნება"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("ისევ თქვენს სიაშია."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("შესაბამისი საუბრები არ არის."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("არაფერი გელოდებათ"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "ყველა საუბარი თქვენი სიტყვით მთავრდება."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("ფოტო"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("ფოტოები"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("ვიდეო"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("შეტყობინებები ჯერ არ არის"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("თქვენ:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("გუშინ"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("შეტყობინებები"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("შეტყობინებების პარამეტრები"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("კონფიდენციალურობა"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("წაკითხვის დადასტურება"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "როცა ეს გამორთულია, სხვები ვერ დაინახავენ, როდის წაიკითხეთ მათი შეტყობინებები, და თქვენც ვერ დაინახავთ, როდის წაიკითხეს მათ თქვენი."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("აჩვენე, როცა წერთ"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "ადამიანი, ვისაც წერთ, ხედავს, რომ წერთ."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("ბმულების გადახედვა"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "გადახედვის შესაქმნელად თქვენი ტელეფონი ხსნის გაგზავნილ ბმულს, ამიტომ საიტი ხედავს თქვენი ტელეფონის მოთხოვნას. Kyron-ის სერვერი ბმულს ვერასდროს ხედავს."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("შეტყობინებების ნოტიფიკაციები"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "შეტყობინებები დაშიფრულია ბოლოდან ბოლომდე. Kyron ვერ კითხულობს მათ და აქ არაფერი ცვლის ამას."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("ვის:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("ბოლო"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("ადამიანები"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("ამ სახელით არავინაა."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("საცდელი შეტყობინების გაგზავნა"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron-ის სერვერი ჯერ არ არის მომართული შეტყობინებების გასაგზავნად, ამიტომ ვერცერთი ვერ მოვა. პრობლემა ჩვენს მხარეზეა და არა თქვენს ტელეფონში."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "ეს ტელეფონი შეტყობინებებისთვის არ არის რეგისტრირებული. შეამოწმეთ, რომ ტელეფონის პარამეტრებში Kyron-ის შეტყობინებები დაშვებულია, და სცადეთ ხელახლა."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "შეტყობინება ამ ტელეფონზე ვერ მიიტანა. სცადეთ ერთ წუთში."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "გაიგზავნა. რამდენიმე წამში უნდა მოვიდეს."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("შეტყობინებები მუშაობს."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("პოსტები ჯერ არ არის"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("ახალი თემი"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("სახელი"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("მისამართი სახელისგან იქმნება."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("ხალხი მას იპოვის მისამართზე"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "თქვენ იქნებით მისი მფლობელი. სურათის, ბანერისა და მოდერატორების დამატება შეიძლება მისი გვერდიდან, როცა შეიქმნება."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("მთავარი"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("თემების პოსტები მთავარში"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "თქვენი თემების პოსტები მთავარშიც ჩანს. გამორთვისას ისინი აქ, თემებში რჩება, სადაც თითოეული აჩვენებს, რა არის ახალი."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("თქვენი სია"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("ახალი პოსტების რაოდენობა"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "აჩვენეთ, რამდენი პოსტია ახალი თითოეულ თემში მას შემდეგ, რაც ბოლოს გახსენით."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("თემები, რომლებსაც მართავთ"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "აქ არის თემები, რომლებიც შექმენით ან რომლებსაც მოდერირებთ."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("მფლობელი"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("მოდერატორი"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("ახალი პოსტები"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("თქვენ მიერ მართული"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("თემების პარამეტრები"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("აღმოჩენა"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("შესაბამისი თემი არ არის."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("ახალი არაფერია"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "ყველა თემი ისეა, როგორც დატოვეთ."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("ჯერ არცერთს მართავთ"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("შესაერთებელი აღარაფერი დარჩა"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron-ის ყველა თემში ხართ. შექმენით კიდევ ერთი."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "სცადეთ სხვა სიტყვა ან შექმენით თემი ამ სახელით."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("პოსტის დაწერა"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("წევრები:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("გამოქვეყნდა"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("ნახვა"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("გახსნა"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("ონლაინ"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("აჩვენე, როცა ონლაინ ხართ"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "ადამიანები, ვისაც წერთ, ხედავენ მწვანე წერტილს, სანამ Kyron გახსნილი გაქვთ. როცა ეს გამორთულია, თქვენც ვერ დაინახავთ მათსას."),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "მოძებნეთ ადამიანები და პოსტები"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "საზოგადოებები გასაწევრიანებლად"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("ჯერ სანახავი არაფერია"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "ადამიანების გამოქვეყნებული ფოტოები და კლიპები აქ გამოჩნდება."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("გამოწერა"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("ანგარიშის წაშლა"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "ეს სამუდამოდ წაშლის თქვენს Kyron ანგარიშს. მისი გაუქმება შეუძლებელია."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "თქვენი პროფილი, პოსტები, პასუხები, მოწონებები და გაზიარებები"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "თქვენი შეტყობინებები, სხვებისთვის გაგზავნილების ჩათვლით, და მათში არსებული ფოტოები და ხმოვანი შეტყობინებები"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "თქვენი გამომწერები, ადამიანები, რომლებსაც გამოიწერთ, და თქვენი პარამეტრები"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "თქვენ მიერ შექმნილი საზოგადოებები გადაეცემა ყველაზე დიდი ხნის მოდერატორს ან წევრს. საზოგადოება, რომელშიც სხვა არავინაა, დაიხურება."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("წაიშალოს თქვენი ანგარიში?"),
      "ui_delete_account_confirm_detail":
          MessageLookupByLibrary.simpleMessage("ვერაფერს დაიბრუნებთ."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("თქვენი ანგარიში წაიშალა."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("წაშლილი ანგარიში"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "ეს ანგარიში წაშლილია, ამიტომ აქ შეტყობინებების გაგზავნა აღარ შეიძლება."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Google-ით დარეგისტრირდით? ამის ნაცვლად გამოიყენეთ „Sign in with Google“."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "ამ ლინზის ჩატვირთვა ვერ მოხერხდა."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("ვიდეოს ჩაწერა ვერ მოხერხდა."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "ლინზის ამ ვიდეოზე დამატება ვერ მოხერხდა, ამიტომ ის ისე გამოქვეყნდება, როგორც გადაიღეს."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "თქვენს პოსტს უკვე აქვს დანართების მაქსიმალური რაოდენობა."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("ლინზა ემატება…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("ფლეში"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("ვიდეოს ჩაწერა"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("ფოტო"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("ვიდეო"),
      "googleSignInCancelled":
          MessageLookupByLibrary.simpleMessage("Google-ით შესვლა გაუქმდა."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("საჩუქრები"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "ამ პოსტისთვის ჯერ არავის გამოუგზავნია საჩუქარი."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("საჩუქარი"),
      "analytics_gifts_label":
          MessageLookupByLibrary.simpleMessage("საჩუქრები"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("მონეტები"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("გამგზავნი"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("გამგზავნები"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "სატესტო მონეტები: მათი გატანა ჯერ შეუძლებელია."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("შენახული"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("პოსტები"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("კომენტარები"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("მეტი პასუხის ნახვა"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("რედაქტირებული"),
      "ui_more": MessageLookupByLibrary.simpleMessage("მეტი"),
      "ui_following": MessageLookupByLibrary.simpleMessage("გამოწერილები"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("საუკეთესო"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("უახლესი"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage(
          "კომენტარების დალაგება: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "საჩუქარი გაუგზავნა თქვენს პოსტს"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "\$gift გაუგზავნა თქვენს კომენტარს"),
      "ui_notif_gift_named":
          MessageLookupByLibrary.simpleMessage("\$gift გაუგზავნა თქვენს პოსტს"),
      "ui_gift_title":
          MessageLookupByLibrary.simpleMessage("საჩუქრის გაგზავნა"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("პოსტის რედაქტირება"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "შეგიძლიათ დაარედაქტიროთ კიდევ \$n წთ"),
      "ui_save": MessageLookupByLibrary.simpleMessage("შენახვა"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "#\$tab-ში ჯერ არაფერი გამოქვეყნებულა."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("აირჩიეთ საჩუქარი"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("მონეტები არ გყოფნით"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "სატესტო მონეტები: მათი ყიდვა შეუძლებელია და ფულადი ღირებულება არ აქვთ."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("შეივსება \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 მონეტა"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count მონეტა"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("გაქვთ \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("\$gift-ის გაგზავნა"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift გაიგზავნა"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("ხელახლა ცდა"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "გამოქვეყნებიდან 15 წუთის განმავლობაში"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("რედაქტირდა"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "შენახული კომენტარების ჩატვირთვა ვერ მოხერხდა"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("შენახული კომენტარები არ არის"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "შეეხეთ არქივის ხატულას კომენტარის ქვეშ, რომ აქ შეინახოთ. რასაც ინახავთ, მხოლოდ თქვენ ხედავთ."),
      "ui_replying_to": MessageLookupByLibrary.simpleMessage("პასუხი \$name-ს"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("კოპირება"),
      "ui_search": MessageLookupByLibrary.simpleMessage("ძიება"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("ყველას მონიშვნა"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("\$count საჩუქარი"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 საჩუქარი"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "მეტი პოსტის ჩატვირთვა ვერ მოხერხდა."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("შეხსენებები"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "რა არის ახალი თქვენი არყოფნის შემდეგ და როდის ბრუნდება მონეტები. დღეში ერთზე მეტი არასდროს."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("საჩუქრები"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("1 ადამიანისგან"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count ადამიანისგან"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("ყველაზე გულუხვი"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "ვერ ჩაიტვირთა, ვინ გამოგზავნა საჩუქრები."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("რა არის ახალი"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("გასაგებია"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "გმადლობთ. ყველა პასუხს ვკითხულობთ."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("როგორ მოგწონთ Kyron აქამდე?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "თქვენი ტესტის \$day-ე დღე. ერთი შეხება საკმარისია."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "რამე უნდა გავასწოროთ ან დავამატოთ? (არასავალდებულო)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("გაგზავნა"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("ახლა არა"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Kyron-იდან გასასვლელად კვლავ დააჭირეთ უკან"),
    };

final messageLookup = MessageLookup();
