import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'yo';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Ọ̀rọ̀, gbólóhùn tàbí #àmì"),
      "about": MessageLookupByLibrary.simpleMessage("Nípa"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Fi ìdáhùn kún un"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Fi àwọn èdè kún un…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Gbà kí o tẹ̀síwájú"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Ṣé o ti ní àkáǹtì Kyron?"),
      "analytics_comments":
          MessageLookupByLibrary.simpleMessage("Àwọn ọ̀rọ̀ ìwòye"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Ènìyàn ọ̀tọ̀ọ̀tọ̀, kì í ṣe iye ìṣí"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("Ìkópa"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Àwọn ìfẹ́ràn"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Kò sí olùwò síbẹ̀"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Kò sí ẹni tó tíì ṣí ìfiránṣẹ́ yìí."),
      "analytics_posted":
          MessageLookupByLibrary.simpleMessage("A ti fi ránṣẹ́"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Àwọn ìpamọ́"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Àwọn olùwò"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("ÀWỌN OLÙWÒ LÓJOOJÚMỌ́"),
      "and": MessageLookupByLibrary.simpleMessage("àti"),
      "answerNumber": (Object a0) => "Ìdáhùn ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("Lẹ́ńsì AR"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("So àkọsílẹ̀ áàpù mọ́ ọn"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Àkókò lọ-àti-bọ̀"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("ÌJẸ́RÌÍSÍ TÓKÌNÌ"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Gbìyànjú lẹ́ẹ̀kan sí i"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Gbìyànjú lẹ́ẹ̀kan sí i"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Bíbẹ̀rẹ̀ ìgbóhùnsáfẹ́fẹ́ báyìí yóò fi ọ́ sínú yàrá tí ẹnikẹ́ni kò lè"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Bẹ̀rẹ̀ àwùjọ kan"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Fún kí ni? (àṣàyàn)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("padà wọlé."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("padà wọlé láti inú àkójọ yìí."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Títì í"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("darapọ̀ ná"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("ń bọ̀ láìpẹ́"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("O ń fi ránṣẹ́ gẹ́gẹ́ bí ìwọ"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("fi ránṣẹ́ sí àwùjọ yìí"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Ní báyìí"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Gbìyànjú lẹ́ẹ̀kan sí i"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Kókó 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Fún ọ"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("ní nǹkan kan."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("ń lọ síbẹ̀ báyìí."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", kì í ṣe"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("ṣé mo ń rìn"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Pa ohùn"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Tan ohùn"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Fún ọ"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Àwọn táàbù rẹ"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Gbìyànjú lẹ́ẹ̀kan sí i"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Àmì (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("ÀWỌN OLÙWÒ LÓJOOJÚMỌ́"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("kò ṣeé gbé wá"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ìfiránṣẹ́ yìí"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Ṣé o ní nǹkan láti fi kún? (àṣàyàn)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ìfiránṣẹ́ yìí"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Láti àkáǹtì kan"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Jáde"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Àkáǹtì rẹ"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Jẹ́rìí ọ̀rọ̀ aṣínà"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("kì í ṣe báyìí"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Ó ń gbé wá…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Ó ń fi ránṣẹ́…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("wákàtí 3 sẹ́yìn"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Da ìjápọ̀ ìtàn kọ"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Ìtàn rẹ"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Àkáǹtì rẹ, àwọn ìfiránṣẹ́ rẹ, àti ohun tí o fọwọ́ kàn, kí"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Fi kókó kún un"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("tirẹ̀."),
      "authorBlocked": (Object a0) => "A ti dínà ${a0}",
      "authorPostsHidden": (Object a0) =>
          "O kò ní rí ìfiránṣẹ́ láti ọ̀dọ̀ ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Dínà"),
      "blockAuthor": (Object a0) => "Dínà ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("A ti da àlàyé ẹ̀dà kọ"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Nípa títẹ̀síwájú, o gbà"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Nípa títẹ̀síwájú, o gba Àwọn Òfin Iṣẹ́ àti Ìlànà Àṣírí wa"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Nípa fíforúkọsílẹ̀, o gbà"),
      "cancel": MessageLookupByLibrary.simpleMessage("Fagilé"),
      "change": MessageLookupByLibrary.simpleMessage("Yí padà"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Yí ímeèlì padà"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Jẹ́rìí àkáǹtì rẹ láti inú ímeèlì rẹ."),
      "checkKyronReachable":
          MessageLookupByLibrary.simpleMessage("Ṣàyẹ̀wò bóyá a lè dé Kyron"),
      "clear": MessageLookupByLibrary.simpleMessage("Pa rẹ́"),
      "close": MessageLookupByLibrary.simpleMessage("Tì í"),
      "closeCommunity": (Object a0) => "Ti ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Tì í"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Ti àwùjọ yìí"),
      "communities": MessageLookupByLibrary.simpleMessage("Àwọn àwùjọ"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Wá ọ̀kan nínú Ṣàwárí, tàbí bẹ̀rẹ̀ tìrẹ."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Ju èrò gbígbóná kan sílẹ̀ (tàbí èyí tó lọ́wọ́ọ́rọ́)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Kí ló wà lọ́kàn rẹ?"),
      "composer_placeholder_say":
          MessageLookupByLibrary.simpleMessage("Sọ ohun tí ìwọ nìkan lè sọ…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("Àmì rẹ nìyí: fi ránṣẹ́"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Tẹ̀ ẹ́, sọ̀rọ̀, tàbí ronú sókè"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Jẹ́rìí ọ̀rọ̀ aṣínà"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Kàn sí ìrànlọ́wọ́"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ kò tíì ní èdè, nítorí náà èyí kò tíì ṣà ìfúnni rẹ. A ó pa àwọn àṣàyàn rẹ mọ́ títí di ìgbà náà."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Tẹ̀síwájú"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Tẹ̀síwájú pẹ̀lú ímeèlì"),
      "copy": MessageLookupByLibrary.simpleMessage("Dà kọ"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Da ìròyìn kọ dípò"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Kò ṣeé ṣí ìwọlé Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Jíjáde kùnà: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé ya àwòrán."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "A máa ń fi hàn lórí profaili rẹ àti lábẹ́ àwọn ìfiránṣẹ́ rẹ."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Kò sí orílẹ̀-èdè tí ó bá “{query}” mu."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Má ṣe fi orílẹ̀-èdè hàn"),
      "country_search":
          MessageLookupByLibrary.simpleMessage("Wá àwọn orílẹ̀-èdè"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "A máa ń fi hàn lórí profaili rẹ àti lábẹ́ àwọn ìfiránṣẹ́ rẹ. Nígbà tí o bá rí àwọn ìfiránṣẹ́ ẹnìkan, a máa ka orílẹ̀-èdè rẹ nínú Àgbéyẹ̀wò rẹ̀, ní àwùjọ ènìyàn márùn-ún tàbí jù bẹ́ẹ̀ lọ nìkan, a kì í sì í dárúkọ rẹ."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Láti inú ètò fóònù rẹ"),
      "create": MessageLookupByLibrary.simpleMessage("Ṣẹ̀dá"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Ṣẹ̀dá àkáǹtì"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Ṣẹ̀dá àkáǹtì rẹ"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Ṣẹ̀dá ìfihàn rẹ"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("Lẹ́ńsì AR"),
      "create_go_live":
          MessageLookupByLibrary.simpleMessage("Lọ sí ìgbóhùnsáfẹ́fẹ́ tààrà"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́ ọ̀rọ̀"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́ ohùn"),
      "delete": MessageLookupByLibrary.simpleMessage("Pa rẹ́"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Pa ọ̀rọ̀ ìwòye yìí rẹ́?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Pa ìfiránṣẹ́ yìí rẹ́?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Ṣàpèjúwe àsomọ́ yìí"),
      "description": MessageLookupByLibrary.simpleMessage("Àpèjúwe"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("A ti da DID kọ sí pátákó"),
      "done": MessageLookupByLibrary.simpleMessage("Ó ti parí"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Ti olóòtú lẹ́yìn tí o bá kọ nǹkan kan, a ó sì fún ọ ní àkọsílẹ̀ àkọ́kọ́."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("ọjọ́ {days} sẹ́yìn"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("wákàtí {hours} sẹ́yìn"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Ní báyìí"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("ìṣẹ́jú {minutes} sẹ́yìn"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("A kò tíì kọ nǹkan kan"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Ìdìbò, kò sí ìbéèrè síbẹ̀"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Àyọkà, kò sí ọ̀rọ̀ síbẹ̀"),
      "drafts": MessageLookupByLibrary.simpleMessage("Àwọn àkọsílẹ̀ àkọ́kọ́"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Ṣàtúnṣe ìfihàn"),
      "email": MessageLookupByLibrary.simpleMessage("Ímeèlì"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Ìfitónilétí ímeèlì"),
      "explore": MessageLookupByLibrary.simpleMessage("Ṣàwárí"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Ìtọpinpin ojú kò sí lórí ẹ̀rọ yìí."),
      "feedTagDetail": (Object a0) =>
          "Kò sí nǹkan tí a fi ránṣẹ́ pẹ̀lú #${a0} síbẹ̀.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Tẹ̀lé {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Àwọn olùtẹ̀lé"),
      "following": MessageLookupByLibrary.simpleMessage("Àwọn tí o ń tẹ̀lé"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Ṣé o gbàgbé ọ̀rọ̀ aṣínà?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Gbígba ìrànlọ́wọ́"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Tẹ̀síwájú pẹ̀lú Google"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("Wọlé pẹ̀lú Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google máa ń dá ìwọlé tó parí padà sí Kyron nípasẹ̀ ìjápọ̀ tí Android àti iOS nìkan ń dáhùn, nítorí náà lórí ${a0} aṣàwákiri kò ní ibi tí yóò dá a padà sí.\\n\\nTí o bá ti ní àkáǹtì Kyron nípasẹ̀ Google, yan Tẹ̀síwájú pẹ̀lú ímeèlì pẹ̀lú àdírẹ́sì kan náà, kí o sì tẹ Ṣé o gbàgbé ọ̀rọ̀ aṣínà: o máa gba ìjápọ̀ láti ṣètò ọ̀rọ̀ aṣínà.",
      "googleSignInNeedsPhoneApp":
          MessageLookupByLibrary.simpleMessage("Ìwọlé Google nílò áàpù fóònù"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Forúkọsílẹ̀ pẹ̀lú Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìtọ́sọ́nà àti ìdáhùn sí àwọn ìbéèrè tí a sábà ń béèrè"),
      "handle": MessageLookupByLibrary.simpleMessage("orúkọ olùmúlò"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Ìrànlọ́wọ́ àti Àtìlẹ́yìn"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Ibùdó Ìrànlọ́wọ́"),
      "home": MessageLookupByLibrary.simpleMessage("Ilé"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("Ní ìlà kan"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Àkáǹtì rẹ"),
      "ins_act_community": MessageLookupByLibrary.simpleMessage("Ṣí àwùjọ náà"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Kọ ìfiránṣẹ́"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Wo ìfiránṣẹ́ náà"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Ṣàtúnṣe ìwé àkọsílẹ̀ rẹ"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("Ìgbà tí wọ́n wà níbẹ̀"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Ní àgbègbè àkókò rẹ."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Ọjọ́ orí"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Láti inú ènìyàn {known} tí a dé ọ̀dọ̀ wọn tí wọ́n fún wa ní ọjọ́ ìbí wọn."),
      "ins_chart": MessageLookupByLibrary.simpleMessage(
          "Àwọn ènìyàn tí a dé ọ̀dọ̀ wọn lójoojúmọ́"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Àwọn àwùjọ tí wọ́n wà"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Àwọn orílẹ̀-èdè"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Láti inú ènìyàn {known} tí a dé ọ̀dọ̀ wọn tí wọ́n ní orílẹ̀-èdè lórí profaili wọn."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Ọjọ́ {days} tó kọjá"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("A kò lè gbé ìjìnlẹ̀ òye wọlé"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Àwọn olùtẹ̀lé"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Kò tíì sí ẹgbẹ́ tó tóbi tó láti fi hàn."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Bí o ṣe lè dàgbà"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Àwọn kókó tí wọ́n ń tẹ̀lé"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Ìfẹ́ràn"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Tuntun"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Àwọn olùtẹ̀lé tuntun"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Kò sí ìkankan nínú àwọn ìfiránṣẹ́ rẹ tó dé ọ̀dọ̀ ẹnikẹ́ni ní àsìkò yìí."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Wọn kò tẹ̀lé ọ"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Àwọn orílẹ̀-èdè náà ni èyí tí àwọn ènìyàn yàn lórí profaili wọn. Kyron kì í gba ìlú tàbí akọ-abo ẹnikẹ́ni, nítorí náà kò sí nǹkan láti fi hàn fún wọn."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Ìṣílẹ̀"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "dé ọ̀dọ̀ {reach} · ìfẹ́ràn {likes} · èsì {replies}"),
      "ins_reach":
          MessageLookupByLibrary.simpleMessage("Àwọn ènìyàn tí a dé ọ̀dọ̀ wọn"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "A ka ènìyàn kọ̀ọ̀kan lẹ́ẹ̀kan: a fi ọ̀kan nínú àwọn ìfiránṣẹ́ rẹ hàn án tàbí ó ṣí i fún ìgbà àkọ́kọ́. Àwọn olùtẹ̀lé tuntun ṣì ń tẹ̀lé ọ; a kì í ka àwọn tó dẹ́kun títẹ̀lé."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Àwọn èsì"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Àtúnfiránṣẹ́"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Ìfipamọ́"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Ẹni tí àwọn olùwò rẹ jẹ́ yóò hàn nígbà tí ènìyàn {floor} bá ti rí àwọn ìfiránṣẹ́ rẹ ní àsìkò yìí. Bí wọ́n bá kéré sí bẹ́ẹ̀, ó lè tọ́ka sí ẹnìkan."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Àwọn ènìyàn kò tíì tó"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% nínú wọn ti ń tẹ̀lé ọ tẹ́lẹ̀: àwọn ìfiránṣẹ́ rẹ ń dé ọ̀dọ̀ àwọn tó mọ̀ ọ́ jù lọ."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% nínú wọn kò tíì tẹ̀lé ọ: àwọn ènìyàn ń rí àwọn ìfiránṣẹ́ rẹ."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "O dé ọ̀dọ̀ ènìyàn {reach}, {pct}% kéré sí àsìkò tó kọjá."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "O dé ọ̀dọ̀ ènìyàn {reach} ní ọjọ́ {days} tó kọjá."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "O dé ọ̀dọ̀ ènìyàn {reach}, bí i ti àsìkò tó kọjá."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Kò sí ẹni tuntun tó rí àwọn ìfiránṣẹ́ rẹ ní ọjọ́ {days} tó kọjá."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "O dé ọ̀dọ̀ ènìyàn {reach}, {pct}% ju àsìkò tó kọjá lọ."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "O dé ọ̀dọ̀ ènìyàn {reach}, ìlọ́po {times}× ti àsìkò tó kọjá."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Púpọ̀ nínú wọn ń tẹ̀lé {name} ju kókó mìíràn lọ."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Àwọn olùwò"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Àkópọ̀"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Àwọn tó rí ọ̀kan nínú àwọn ìfiránṣẹ́ rẹ máa ń wo ìwé àkọsílẹ̀ rẹ kí wọ́n tó tẹ̀lé ọ. Ojú tàbí àmì-ìdámọ̀ fi hàn pé ẹnìkan wà níbẹ̀."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Ṣàfikún àwòrán ìwé àkọsílẹ̀"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Sọ ní ìlà kan ohun tí o máa ń fi ránṣẹ́ nípa rẹ̀, kí àjèjì lè mọ ohun tí títẹ̀lé ọ yóò fún un."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Kọ nípa ara rẹ"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} nínú àwọn ìfiránṣẹ́ rẹ {total} kò ní kókó. Kókó ń fi ìfiránṣẹ́ sínú ìfúnni kókó náà àti síwájú àwọn tó ń tẹ̀lé e."),
      "ins_tip_add_topics_t": MessageLookupByLibrary.simpleMessage(
          "Ṣàfikún kókó sí àwọn ìfiránṣẹ́ rẹ"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "Ènìyàn {received} dáhùn sí àwọn ìfiránṣẹ́ rẹ, o sì dáhùn {answered}. Wọ́n bìkítà tó láti kọ: ìdáhùn kan ń sọ olùkàwé di olùbẹ̀wò déédé."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Dáhùn àwọn èsì rẹ"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Àwọn olùwò rẹ ń ṣiṣẹ́ jù lọ ní {when}. Ìfiránṣẹ́ tí a fi sí díẹ̀ ṣáájú àkókò náà yóò rí àwọn tí yóò gbà á."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́ nígbà tí wọ́n wà"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "Ènìyàn {reached} tí kò tẹ̀lé ọ rí àwọn ìfiránṣẹ́ rẹ, {gained} sì tẹ̀lé ọ. Jẹ́ kí àpèjúwe rẹ àti àwọn ìfiránṣẹ́ tuntun rẹ sọ ohun tí wọ́n lè retí lọ́dọ̀ rẹ."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("Sọ àwọn olùkàwé di olùtẹ̀lé"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Ìfiránṣẹ́ kan dé ọ̀dọ̀ ènìyàn ìlọ́po {times}× ju bí àwọn mìíràn rẹ ṣe máa ń dé. Wo ohun tó ṣe yàtọ̀, kí o sì ṣe é sí i."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Ṣe ohun tó ṣiṣẹ́ sí i"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Ọ̀pọ̀ nínú àwọn tó ń rí àwọn ìfiránṣẹ́ rẹ wà ní {name}. Fífi ránṣẹ́ síbẹ̀ ń gbé ọ síwájú àwọn yòókù."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́ sí {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "O fi ránṣẹ́ ní ìgbà {posts} láàárín ọjọ́ {days}. Ìfiránṣẹ́ kọ̀ọ̀kan jẹ́ àǹfààní mìíràn láti rí ọ, ìlù tó dúró ṣinṣin sì ń mú ọ wà nínú ìfúnni àwọn olùtẹ̀lé rẹ."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Máa fi ránṣẹ́ léraléra"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "O kò fi nǹkan ránṣẹ́ ní ọjọ́ {days} tó kọjá. Kò sí ohun tó ń dé ọ̀dọ̀ ẹnikẹ́ni láìsí ìfiránṣẹ́."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Fi nǹkan ránṣẹ́"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Ìjìnlẹ̀ òye"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ tó ga jù"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Ní ìfiwéra pẹ̀lú ọjọ́ {days} tó ṣáájú"),
      "interest_add": MessageLookupByLibrary.simpleMessage(
          "Fi ohun tí o nífẹ̀ẹ́ sí kún un"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Fà á láti tún ètò ṣe"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Táàbù márùn-ún péré ló lè wọ inú ọ̀pá. Yọ ọ̀kan kúrò láti fi òmíràn kún un."),
      "interest_following":
          MessageLookupByLibrary.simpleMessage("Àwọn tí o ń tẹ̀lé"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Fún ọ"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn háṣítáàgì máa hàn níbí nígbà tí àwọn ènìyàn bá bẹ̀rẹ̀ sí lò wọ́n."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Ń gbajúmọ̀ báyìí"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Àwọn fídíò"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Àwọn táàbù rẹ"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Yóò pòórá fún ẹ̀yin méjèèjì."),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
          "A ó yọ ọ́ kúrò nínú okùn ọ̀rọ̀."),
      "join": MessageLookupByLibrary.simpleMessage("Darapọ̀"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Máa ṣàtúnṣe lọ"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Àwọn ojú-ìbòjú Kyron wà ní èdè rẹ. Tí ọ̀rọ̀ kan kò bá dún dáadáa, sọ fún wa nípasẹ̀ Fi èsì ránṣẹ́."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Àwọn èdè"),
      "leave": MessageLookupByLibrary.simpleMessage("Kúrò"),
      "leaveCommunity": (Object a0) => "Kúrò nínú ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Jẹ́ kí ó padà wọlé"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("Ojú-ìwé 1 ṣí sílẹ̀"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Fi fídíò kúkúrú kún un"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Fi GIF kún un"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Fi háṣítáàgì kún un"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Fi àwòrán kún un"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Fi ìdìbò kún un"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Fi fídíò kún un"),
      "literaladdAnInterest": MessageLookupByLibrary.simpleMessage(
          "Fi ohun tí o nífẹ̀ẹ́ sí kún un"),
      "literaladdLabelAsATab": (Object a0) => "Fi ${a0} kún un gẹ́gẹ́ bí táàbù",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("Èdè áàpù"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("Ẹ̀dà áàpù"),
      "literalblockAuthor": (Object a0) => "Dínà ${a0}",
      "literalblockAuthor2": (Object a0) => "Dínà ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Dínà àkáǹtì yìí?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Pa ìdáhùn tì"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("Tún ṣàyẹ̀wò"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Yan láti inú àwòrán"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Pa káṣì rẹ́"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Ti gbogbo ojú-ìwé"),
      "literalcloseTabLabel": (Object a0) => "Ti ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Ti aṣàwákiri"),
      "literalcloseWidgetCommunityName": (Object a0) => "Ti ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Kàn sí àtìlẹ́yìn"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Àwọn èdè àkóónú"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Da ìjápọ̀ kọ"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Da ìjápọ̀ ìfiránṣẹ́ kọ"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Da ọ̀rọ̀ ìfiránṣẹ́ kọ"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Da ọ̀rọ̀ kọ"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé àwọn àwùjọ wá"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé GIF wá"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Kò ṣeé gbé àwọn ìfitónilétí wá"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé àwọn ọmọ ẹgbẹ́ wá"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Kò ṣeé gbé àwọn ìfiránṣẹ́ yìí wá"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé ìjíròrò yìí wá"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé àkójọ yìí wá"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé ìfiránṣẹ́ yìí wá"),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé ìdáhùn yìí wá"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Kò ṣeé gbé àwọn àmì tó gbajúmọ̀ wá"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé àwọn àwùjọ rẹ wá"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Kò ṣeé gbé àwọn ìfiránṣẹ́ rẹ wá"),
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé ṣí àwùjọ yìí"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé fi ìdáhùn ránṣẹ́."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Ìwádìí kò ṣiṣẹ́"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Jíjáde kùnà: ${a0}",
      "literalcountPagesOpen": (Object a0) => "Ojú-ìwé ${a0} ṣí sílẹ̀",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Àwòrán ìbòrí"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("Ìpamọ́ dátà"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Pa ìfiránṣẹ́ rẹ́"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Wá àwọn ènìyàn"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Má ṣe dáhùn"),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage(
          "A ti fi àkọsílẹ̀ àkọ́kọ́ pamọ́"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage("A kò lè fi èsì ránṣẹ́ báyìí"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Ìwọ̀n ọ̀rọ̀"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("A kò tíì ṣètò GIF"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Fi fún áàpù mìíràn"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Fi ọ̀rọ̀ aṣínà pamọ́"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Fi ìfiránṣẹ́ yìí pamọ́"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Ó fi í pamọ́ ó sì ní kí a dín irú rẹ̀ kù"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Bí a ṣe ń hùwà"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("Máa kọ ọ́ lọ"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron kò dáhùn"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "Ọjọ́ \\${a0}",
      "literalleaveCommunityName": (Object a0) => "Kúrò nínú ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, lẹ́ńsì ojú",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ tí o fẹ́ràn"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("A ti da ìjápọ̀ kọ"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Sọ di alábòójútó"),
      "literalmuteAuthor": (Object a0) => "Pa ẹnu ${a0} mọ́",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Pa ẹnu okùn ọ̀rọ̀ yìí mọ́"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Pa ẹnu ọ̀rọ̀ tàbí àmì mọ́"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Àwọn àkáǹtì tí a pa ẹnu wọn mọ́ àti tí a dínà"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "A ti pa ẹnu rẹ̀ mọ́. O kò ní gba ìfitónilétí."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Kò sí áàpù lórí ẹ̀rọ yìí tó ń ṣí ìjápọ̀ ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Kò sí aṣàwákiri lórí ẹ̀rọ yìí tó gba ìjápọ̀ náà."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("Kò sí DID síbẹ̀"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("Kò sí àkọsílẹ̀ àkọ́kọ́"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
          "Kò sí ohun tí o nífẹ̀ẹ́ sí síbẹ̀"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Kò sí ìfẹ́ràn síbẹ̀"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Kò sí ìfiránṣẹ́ síbẹ̀"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Kò sí olùtẹ̀lé tuntun"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Kò sí ìfiránṣẹ́ síbẹ̀"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Kò sí ìdáhùn síbẹ̀"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Kò sí àtúnfiránṣẹ́ síbẹ̀"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Kò sí àmì tó gbajúmọ̀ tó bá a mu"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("A kò rí ẹnikẹ́ni"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("A kò yọ ẹnikẹ́ni kúrò"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Kò sí ẹnikẹ́ni níbí síbẹ̀"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Kò wù mí"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("A kò rí nǹkan kan"),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
          "Kò sí nǹkan tó ń gbajúmọ̀ síbẹ̀"),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
          "Kò sí nǹkan nínú àkọsílẹ̀ síbẹ̀"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Kò sí èyí tó bá a mu"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Kò sí ẹni tí a pa ẹnu rẹ̀ mọ́"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Kò sí nǹkan láti wò síbẹ̀"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Kò sí èyí tí a kò kà"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Olóhun nìkan ló lè yí èyí padà"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Ṣí ìdáhùn"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Ṣí ímeèlì láti Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Ọ̀rọ̀ aṣínà àti ìwọlé"),
      "literalpostInCommunityName": (Object a0) => "Fi ránṣẹ́ sí ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Fi ránṣẹ́ sí ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Fi ránṣẹ́ pẹ̀lú ọ̀rọ̀ tìrẹ lókè"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Èdè àkọ́kọ́"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Ìfitónilétí títì"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Ó ń ṣàyẹ̀wò…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Gba ìfiránṣẹ́ ohùn sílẹ̀"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Tún gba sílẹ̀"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Yọ kúrò ní alábòójútó"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Yọ kúrò nínú àwùjọ"),
      "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage(
          "Yọ kúrò nínú àwọn tí a fi pamọ́"),
      "literalremoveLabel": (Object a0) => "Yọ ${a0} kúrò",
      "literalremoveLanguageEnglishname": (Object a0) => "Yọ ${a0} kúrò",
      "literalremoveMemberDisplayname": (Object a0) => "Yọ ${a0} kúrò?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Yọ ìdìbò kúrò"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Yọ ìdáhùn yìí kúrò"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Pa ìjíròrò yìí rẹ́"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Yọ ìdìbò yìí kúrò"),
      "literalreportAuthor": (Object a0) => "Fi ẹ̀sùn kan ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Fi ẹ̀sùn kan ìfiránṣẹ́"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Tún fi kóòdù ránṣẹ́"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ tí a fi pamọ́"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Sọ nǹkan kan"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Sọ nǹkan kan nínú ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Ìwádìí kùnà"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Tún fi ránṣẹ́"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "Tún fi ránṣẹ́ ní ìṣẹ́jú-àáyá ${a0}",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Fún wa ní èsì"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Fi ìjápọ̀ ránṣẹ́"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "A ti fi ránṣẹ́. Ìyẹn ni ìròyìn #${a0}.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "Ṣètò ọ̀rọ̀ aṣínà kí o tẹ̀síwájú"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("Pín àkọsílẹ̀ pẹ̀lú àtìlẹ́yìn"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Pín àwùjọ yìí"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Pín ojú-ìwé yìí"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Pín ìfihàn yìí"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Pín…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Pín pẹ̀lú àyọkà"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Fi irú èyí hàn sí i"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Fi ọ̀rọ̀ aṣínà hàn"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Fi àbájáde hàn"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Bẹ̀rẹ̀ àwùjọ kan"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Bẹ̀rẹ̀ gbígbasílẹ̀"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Dẹ́kun gbígbé wá"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Dẹ́kun rírí ìfiránṣẹ́ yìí àti àwọn ìdáhùn rẹ̀"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Ìlà ìtàn, nǹkan ${a0}",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Yí kámẹ́rà padà"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Fi àmì sí ẹnìkan"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("Ya àwòrán"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Tẹ àsíá tàbí àwòrán láti yí i padà"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Tẹ ìjápọ̀ tó wà nínú rẹ̀"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Tẹ̀ ẹ́ láti fi àwòrán àti ìbòrí kún un"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Kò ṣiṣẹ́. Gbìyànjú lẹ́ẹ̀kan sí i."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé GIF yẹn wá."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé ṣí ìjápọ̀ yìí níbí."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Kámẹ́rà ti tì"),
      "literalthisCommunity": MessageLookupByLibrary.simpleMessage("Àwùjọ yìí"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Ìdáhùn yìí kò sí mọ́"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Túmọ̀ ìfiránṣẹ́"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("Pa ohùn"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("Tan ohùn"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Lo ọ̀kan nínú tiwa"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "A ti tún fi kóòdù ìjẹ́rìísí ránṣẹ́."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Ìjẹ́rìísí kùnà: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Jẹ́rìí ímeèlì"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Àwọn olùwò, ìfẹ́ràn, ìpamọ́ àti ọ̀rọ̀ ìwòye"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Ohun tí Kyron ń tọ́jú"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Ohun tí áàpù yìí ń ṣe"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Ohun tí o ṣe, ohun tí o retí, ohun tó ṣẹlẹ̀ "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Ohun tí o fi ránṣẹ́ jẹ́ tìrẹ"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Bóyá a lè dé Kyron báyìí"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Ta ló lè dáhùn"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Ta ni o fẹ́ fi àmì sí?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "O ti ń tẹ̀lé gbogbo àwọn àmì tó gbajúmọ̀"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("O ti rí gbogbo rẹ̀"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("O kò sí nínú àwùjọ kankan"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("O ti jáde."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "O ti kúrò nínú ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("O kò tíì fi nǹkan kan ránṣẹ́"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Gbé púpọ̀ sí i wá"),
      "logCleared":
          MessageLookupByLibrary.simpleMessage("A ti pa àkọsílẹ̀ rẹ́"),
      "logCopied": MessageLookupByLibrary.simpleMessage("A ti da àkọsílẹ̀ kọ"),
      "logIn": MessageLookupByLibrary.simpleMessage("Wọlé"),
      "logOut": MessageLookupByLibrary.simpleMessage("Jáde"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Jáde?"),
      "login": MessageLookupByLibrary.simpleMessage("Ìwọlé"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Ìwọlé kùnà. Ṣàyẹ̀wò àwọn àlàyé rẹ."),
      "manage": MessageLookupByLibrary.simpleMessage("Ṣàkóso"),
      "menu": MessageLookupByLibrary.simpleMessage("Àkójọ"),
      "message": MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́"),
      "messages": MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́"),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("O ti ka gbogbo ìjíròrò."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Ṣí ìfihàn ẹnìkan kí o tẹ Ìfiránṣẹ́ láti bẹ̀rẹ̀ ìjíròrò."),
      "mute": MessageLookupByLibrary.simpleMessage("Pa ẹnu mọ́"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage(
          "Àwọn tí a pa ẹnu wọn mọ́ àti tí a dínà"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
          "Àwọn ọ̀rọ̀ àti àmì tí a pa ẹnu wọn mọ́"),
      "name": MessageLookupByLibrary.simpleMessage("Orúkọ"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Ojú-ìbòjú <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Àdírẹ́sì ímeèlì tuntun"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Ọ̀rọ̀ aṣínà tuntun"),
      "newPost": MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́ tuntun"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Kì í ṣe báyìí"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "A kò fi ránṣẹ́. Tẹ̀ ẹ́ láti gbìyànjú lẹ́ẹ̀kan sí i"),
      "nothingMatchesQuery": (Object a0) =>
          "Kò sí nǹkan lórí Kyron tó bá \"${a0}\" mu",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Kò sí nǹkan láti dà kọ"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Ìfẹ́ràn, ìdáhùn àti olùtẹ̀lé tuntun ń wá síbí."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ènìyàn tó ń tẹ̀lé ọ máa hàn níbí."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Nígbà tí ẹnìkan bá fẹ́ràn ìfiránṣẹ́ rẹ, yóò hàn níbí."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìdáhùn sí ìfiránṣẹ́ rẹ ń wá síbí."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Nígbà tí ẹnìkan bá tún ọ fi ránṣẹ́, yóò hàn níbí."),
      "notifications": MessageLookupByLibrary.simpleMessage("Àwọn ìfitónilétí"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Ṣí nínú aṣàwákiri"),
      "or": MessageLookupByLibrary.simpleMessage("tàbí"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("A kò rí ojú-ìwé náà"),
      "password": MessageLookupByLibrary.simpleMessage("Ọ̀rọ̀ aṣínà"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Ọ̀rọ̀ aṣínà kúrú jù"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Yan àwọn ohun tí o nífẹ̀ẹ́ sí"),
      "post": MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("Ìṣirò ìfiránṣẹ́"),
      "postInCommunity": (Object a0) => "Fi ránṣẹ́ sí ${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́, sọ ọ́, fi hàn."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("A ti da ọ̀rọ̀ ìfiránṣẹ́ kọ"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("Ìlànà Àṣírí"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("A ti ṣe àfikún ìfihàn"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Ìtàn ara ẹni"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Orílẹ̀-èdè"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Orúkọ ìfihàn"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Ibùdó"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Tẹ̀ ẹ́ láti yí i padà"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Wẹ́ẹ̀bù"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Ìfitónilétí títì"),
      "quote": MessageLookupByLibrary.simpleMessage("Fàyọ ọ̀rọ̀"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Fàyọ ìfiránṣẹ́"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Kàn sí ènìyàn kan"),
      "remove": MessageLookupByLibrary.simpleMessage("Yọ kúrò"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Pa ìjíròrò yìí rẹ́?"),
      "removeMember": (Object a0) => "Yọ ${a0} kúrò?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Pa ìfiránṣẹ́ yìí rẹ́?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("Ìdáhùn, ìtẹ̀lé àti ìmẹ́nubà"),
      "repliesPolicy": (Object a0) => "Ìdáhùn: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Dáhùn"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Ẹnikẹ́ni lè darapọ̀"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Ẹnikẹ́ni ṣì lè rí, tún fi ránṣẹ́ àti fàyọ ìfiránṣẹ́ yìí."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Ẹnikẹ́ni lórí Kyron lè dáhùn ìfiránṣẹ́ yìí."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Àwọn tó ń tẹ̀lé ọ"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn tó ń tẹ̀lé ọ nìkan ló lè dáhùn ìfiránṣẹ́ yìí."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Àwọn tí o mẹ́nu bà"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn tí o @mẹ́nu bà nínú ìfiránṣẹ́ yìí nìkan ló lè dáhùn."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Kò sí ẹni tó lè dáhùn"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "A ti pa ìdáhùn. Ìwọ ṣì lè dáhùn."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Ta ló lè dáhùn?"),
      "report": MessageLookupByLibrary.simpleMessage("Jábọ̀"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "A ti da ìròyìn kọ. Lẹ̀ ẹ́ mọ́ ímeèlì sí àtìlẹ́yìn."),
      "reportSent":
          MessageLookupByLibrary.simpleMessage("A ti fi ìjábọ̀ ránṣẹ́"),
      "repost": MessageLookupByLibrary.simpleMessage("Tún fi ránṣẹ́"),
      "reset": MessageLookupByLibrary.simpleMessage("Tún ṣètò"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Tún ọ̀rọ̀ aṣínà rẹ ṣètò"),
      "retry": MessageLookupByLibrary.simpleMessage("Gbìyànjú lẹ́ẹ̀kan sí i"),
      "save": MessageLookupByLibrary.simpleMessage("Fi pamọ́"),
      "saveDraft":
          MessageLookupByLibrary.simpleMessage("Fi àkọsílẹ̀ àkọ́kọ́ pamọ́"),
      "saySomething": (Object a0) => "Sọ nǹkan kan nínú ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Wá"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Wá pẹ̀lú orúkọ tàbí orúkọ olùmúlò"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Wá àwọn àwùjọ"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Wá GIF"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Wá àwọn èdè"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Wá àwọn àmì tó gbajúmọ̀"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Ìkìlọ̀ ààbò àti àyípadà àkáǹtì"),
      "selectAppLanguage":
          MessageLookupByLibrary.simpleMessage("Yan èdè ojú áàpù."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Yan àwọn èdè tó máa hàn nínú ìfúnni rẹ. Tí o kò bá yan ọ̀kankan, gbogbo èdè ni a ó fi hàn."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Yan èdè àkọ́kọ́ rẹ fún ìtúmọ̀ nínú ìfúnni."),
      "send": MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Fi ìjẹ́rìísí ránṣẹ́"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Fi ìròyìn àṣìṣe ránṣẹ́"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Fi èsì ránṣẹ́"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Fi ìjábọ̀ ránṣẹ́"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́ sí àtìlẹ́yìn"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Ipò iṣẹ́"),
      "settings": MessageLookupByLibrary.simpleMessage("Ètò"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Pín àkọsílẹ̀ áàpù pẹ̀lú àtìlẹ́yìn"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Wọlé sí Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("O wọlé gẹ́gẹ́ bí"),
      "signupFailed": (Object a0) => "Ìforúkọsílẹ̀ kùnà: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Dúró"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron ṣẹ̀ṣẹ̀ ń bẹ̀rẹ̀, ọ̀nà tó yára jù láti dé ọ̀dọ̀ ẹni tó lè tún un ṣe ni láti ṣí tíkẹ́ẹ̀tì. Sọ fún wa ohun tí o ń ṣe àti ohun tó ṣẹlẹ̀."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Áàpù kò tíì ní àpótí àtìlẹ́yìn, nítorí náà ojú-ìbòjú yìí ń tọ́ ọ sí ibi tí a ń bójútó gan-an dípò fọ́ọ̀mù tí kò lọ síbì kankan."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Àkọsílẹ̀ áàpù"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Sọ fún wa ohun tó kù tàbí tó bàjẹ́"),
      "terms": MessageLookupByLibrary.simpleMessage("Àwọn Òfin Iṣẹ́"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Ọ̀rọ̀, ohùn àti fídíò, àwọn ènìyàn tó ń ṣe wọ́n, àti àwọn yàrá tí wọ́n ti ń bára sọ̀rọ̀."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "Kò sí bọ́tìnnì Fi ránṣẹ́ nínú olóòtú"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Òkùnkùn"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Òkùnkùn nígbà gbogbo"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Bàìbàì"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Òkùnkùn rírọ̀, eérú aláwọ̀ búlúù dípò dúdú"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Ìmọ́lẹ̀"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Ìmọ́lẹ̀ nígbà gbogbo"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Ẹ̀rọ"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Tẹ̀lé ètò ìmọ́lẹ̀ tàbí òkùnkùn fóònù rẹ"),
      "translate": MessageLookupByLibrary.simpleMessage("Túmọ̀"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Ìtúmọ̀ kò tíì tàn. Kò sí nǹkan tí a ń túmọ̀ nínú ìfúnni rẹ síbẹ̀; a ó rántí èyí títí di ìgbà náà."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Èyí ń yí àwọn ọ̀rọ̀ Kyron fúnra rẹ̀ padà, àwọn apá ojú tí Flutter fúnra rẹ̀ ń yà, ọjọ́ àti nọ́ńbà, àti ìtọ́sọ́nà ìṣètò áàpù fún àwọn èdè tí a ń kọ láti ọ̀tún sí òsì."),
      "tryAgain":
          MessageLookupByLibrary.simpleMessage("Gbìyànjú lẹ́ẹ̀kan sí i"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Ìlànà Àṣírí"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Àwọn Òfin Iṣẹ́"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Àkáǹtì"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Lẹ́yìn"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("Áàpù àti Ẹ̀rọ"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Mo ń fa ọ̀rọ̀ jìbìtì náà yọ láti kìlọ̀ fún àwọn ènìyàn."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Sọ ìdí tí o fi rò pé ìpinnu náà kò tọ́: ohun tí ìfiránṣẹ́ náà túmọ̀ sí, ohun tí ẹgbẹ́ lè ti fojú fò, tàbí ìdí tí òfin náà kò fi bá a mu. Ẹlòmíràn ló máa kà á, kì í ṣe ẹni tó ṣe ìpinnu."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Ẹ̀bẹ̀ rẹ"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Kọ ó kéré tán lẹ́tà \$count. O lè bẹ̀bẹ̀ lórí ìpinnu kọ̀ọ̀kan lẹ́ẹ̀kan ṣoṣo."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Fi ẹ̀bẹ̀ ránṣẹ́"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "A ti fi ẹ̀bẹ̀ ránṣẹ́. Wàá gba ìfitónilétí nígbà tí a bá ṣe ìpinnu."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Ẹ̀bẹ̀ lórí ẹjọ́ \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Ìrísí"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Ìmọ́lẹ̀, òkùnkùn tàbí tẹ̀lé fóònù rẹ"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Ṣáájú"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Ẹ kò ní rí ara yín lórí Kyron, a ó sì yọ ìtẹ̀lé láàrin yín kúrò. A kò ní sọ fún un."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Ní nínú"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Kí ni ó wà fún (àṣàyàn)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Àwọn alábòójútó nìkan ló lè kọ̀wé"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Fún ìkéde. Gbogbo ènìyàn nínú àwùjọ ṣì lè kà kí wọ́n sì fèsì."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Fi fọ́tò tàbí ìdìbò kún un"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Àwọn fọ́tò àti fídíò"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Pa ìjíròrò dé"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Kò sí ẹni tí yóò lè kà tàbí kọ̀wé nínú rẹ̀ mọ́. A kò lè yí èyí padà."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Ṣé kí a pa ìjíròrò yìí dé?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("A ti dà á kọ"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "A yọ ìfiránṣẹ́ náà kúrò fún gbogbo ènìyàn. Kyron pa ẹ̀dà kan mọ́ fún àyẹ̀wò."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "A yọ ìfiránṣẹ́ náà kúrò fún gbogbo ènìyàn nínú ìjíròrò."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Ṣàtúnṣe ìjíròrò"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Ṣàtúnṣe"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("a ti ṣàtúnṣe"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("O ń ṣàtúnṣe ìfiránṣẹ́ rẹ"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("A kò lè ṣí ìjíròrò yìí."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Àwọn ìjíròrò"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Darapọ̀ mọ́ ìjíròrò"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Darapọ̀ mọ́ àwùjọ láti rí àwọn ìjíròrò rẹ̀ kí o sì kópa."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count ti darapọ̀"),
      "ui_cchat_leave":
          MessageLookupByLibrary.simpleMessage("Kúrò nínú ìjíròrò"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "O ṣì lè kà á níwọ̀n ìgbà tí o bá wà nínú àwùjọ."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Olùní àti àwọn alábòójútó nìkan ló lè kọ̀wé níbí."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Pa ohùn rẹ́"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Kò ní sí ìfitónilétí láti ọ̀dọ̀ rẹ̀, a kò sì ní kà á mọ́ Àwọn ìfiránṣẹ́."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Orúkọ ìjíròrò"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Ìjíròrò tuntun"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Kò sí ìjíròrò síbẹ̀."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Kò sí ìjíròrò síbẹ̀. Ṣí ọ̀kan fún àwùjọ."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìjíròrò àwùjọ kò ní ìfipamọ́ láti òpin dé òpin. Àwọn alábòójútó àwùjọ àti Kyron lè kà wọ́n."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Kàn án mọ́ òkè"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Fi ìdáhùn kún un"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Pa ìdìbò dé"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Ti pa dé"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Gbogbo ènìyàn ń rí iye àwọn tó yan ìdáhùn kọ̀ọ̀kan, ṣùgbọ́n kì í ṣe ẹni tó yàn án."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Jẹ́ kí wọ́n yan ọ̀pọ̀"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Ìdìbò tuntun"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Yan ọ̀kan"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Ìdáhùn \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Ìdìbò: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Ìbéèrè"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Ìdáhùn kọ̀ọ̀kan lè wà nínú ìdìbò lẹ́ẹ̀kan ṣoṣo."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Yan ọ̀kan tàbí jù bẹ́ẹ̀ lọ"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count ti dáhùn"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Wá nínú ìjíròrò yìí"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Wá nínú ìjíròrò yìí"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("A kò rí nǹkankan."),
      "ui_cchat_shut":
          MessageLookupByLibrary.simpleMessage("O kò lè rí ìjíròrò yìí mọ́."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Ipò díẹ̀díẹ̀"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Bí ó ti pẹ́ tó tí a ń dúró láàárín àwọn ìfiránṣẹ́. Kò kan àwọn alábòójútó."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("Wákàtí 1"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Ìṣẹ́jú \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Ipò díẹ̀díẹ̀: ìfiránṣẹ́ kan ní gbogbo ìṣẹ́jú-àáyá \$seconds"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Pípa"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Ìṣẹ́jú-àáyá \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "O lè kà kí o sì fèsì gẹ́gẹ́ bí olùwòran. Darapọ̀ láti kọ̀wé."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Ìfiránṣẹ́ yẹn ti pẹ́ jù láti fi hàn."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Nǹkan tí o yàn tóbi jù láti fi ránṣẹ́, a sì fi í sílẹ̀."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("Ṣí ohùn"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Yọ kúrò ní òkè"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Ṣe àkọsílẹ̀ ìfiránṣẹ́ ohùn"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Ìwọ"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Àwọn àwùjọ"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Fún kí ni? (àṣàyàn)"),
      "ui_community_posts":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Àkóónú àti Ìfihàn"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé ìfúnni rẹ wá"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Kò ṣeé gbé àwọn ìfiránṣẹ́ tí o fẹ́ràn wá"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("Kò ṣeé gbé ìfihàn rẹ wá"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Kò ṣeé gbé àwọn ìfiránṣẹ́ tí o fi pamọ́ wá"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("ID tí kò ní àárín"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Yíyanjú ìṣòro"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Àwọn ẹgbẹ́"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Kò sí ẹgbẹ́"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ẹgbẹ́ tí o wà nínú wọn, àti àwọn ìjíròrò àwùjọ tí o darapọ̀ mọ́, ni a fihàn níbí."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "O lè pin ìjíròrò tó tó \$count. Kọ́kọ́ yọ pin kan kúrò."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("A ti pin"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Tí a fẹ́ràn"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Tí a fipamọ́"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Kò sí nǹkan níbí síbẹ̀"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Tẹ̀lé àwọn àkáǹtì díẹ̀, àwọn ìfiránṣẹ́ wọn yóò sì hàn níbí."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "Kò sí nǹkan láti ọ̀dọ̀ àwọn tí o ń tẹ̀lé"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ máa hàn níbí bí àwọn ènìyàn ṣe ń kọ wọ́n."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Ń dín kù"),
      "ui_feed_signal_less": MessageLookupByLibrary.simpleMessage("Kò wù mí"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Fi bíi èyí sí i hàn"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("A ti yọ ọ́ kúrò"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Àwọn àmì ìfúnni rẹ"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Tẹ Fi àwọn ìfiránṣẹ́ bíi èyí sí i hàn tàbí Èyí kò wù mí lórí ìfiránṣẹ́ kan, yóò sì hàn níbí."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Kò sí nǹkan kan níbí síbẹ̀"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Ohun tí Fi sí i hàn àti Kò wù mí ń sọ fún àwọn ìfúnni rẹ"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Ìwọ̀nyí ń ṣe àgbékalẹ̀ Ilé àti Ṣàwárí, ní pàtàkì nípa ohun tí ìfiránṣẹ́ kọ̀ọ̀kan dá lé. Ọ̀kọ̀ọ̀kan ń dín kù ní ìdajì lóṣooṣù, kò sì ní kà mọ́ lẹ́yìn oṣù mẹ́fà. Yọ ọ̀kan kúrò láti dá a dúró báyìí."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ tó ní fídíò kúkúrú máa hàn níbí."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Kò sí fídíò síbẹ̀"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Èsì"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Wá àwọn ènìyàn lórí Kyron"),
      "ui_from_account":
          MessageLookupByLibrary.simpleMessage("Láti àkáǹtì kan"),
      "ui_group_add":
          MessageLookupByLibrary.simpleMessage("Fi àwọn ènìyàn kún un"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Fi kún un"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Fi orúkọ ẹgbẹ́ kún un"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Kọ̀ ọ́"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ inú ẹgbẹ́ yìí ni a fi kóòdù pa mọ́ láti ìbẹ̀rẹ̀ dé òpin, bí ìjíròrò mìíràn."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor fi \$users kún un"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor sọ \$users di alákòóso"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor ṣẹ̀dá ẹgbẹ́ náà"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor ṣètò pé kí àwọn tuntun darapọ̀ bí ọmọ ẹgbẹ́"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor ṣètò pé kí àwọn tuntun darapọ̀ bí olùwòran"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor kúrò"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor sọ \$users di ọmọ ẹgbẹ́"),
      "ui_group_event_owner":
          MessageLookupByLibrary.simpleMessage("\$actor sọ \$users di oníǹkan"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor yọ \$users kúrò"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor yí orúkọ ẹgbẹ́ padà sí \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor sọ \$users di olùwòran"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Ẹgbẹ́ kan lè ní ènìyàn \$count jù lọ."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "A ti gbé ọwọ́ sókè. A ti sọ fún àwọn alákòóso."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count ń béèrè láti kọ̀wé"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Ń béèrè láti kọ̀wé"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Àwọn tí a bá fi kún un lẹ́yìn yóò darapọ̀ bí olùwòran"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Kúrò nínú ẹgbẹ́"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Yóò kúrò nínú àkójọ rẹ, o kò sì ní rí ohun tí a bá sọ lẹ́yìn náà. Ẹnìkan yóò ní láti tún fi ọ́ kún un."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Ṣé o fẹ́ kúrò nínú ẹgbẹ́ yìí?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Jẹ́ kí wọ́n kọ̀wé"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Sọ ọwọ́ kalẹ̀"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Sọ di alákòóso"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Sọ di oníǹkan"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Sọ di olùwòran"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Ọmọ ẹgbẹ́ \$count"),
      "ui_group_members":
          MessageLookupByLibrary.simpleMessage("Àwọn ọmọ ẹgbẹ́"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Orúkọ ẹgbẹ́"),
      "ui_group_name_first": MessageLookupByLibrary.simpleMessage(
          "Kọ́kọ́ fún ẹgbẹ́ náà ní orúkọ."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Ṣẹ̀dá ìjíròrò ẹgbẹ́"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Oníǹkan kan ṣoṣo ló wà. Ìwọ yóò wà bí alákòóso."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Sọ \$name di oníǹkan?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Gbé ọwọ́ sókè"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Yọ kúrò nínú ẹgbẹ́"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Yọ kúrò ní alákòóso"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("O kò sí nínú ẹgbẹ́ yìí mọ́."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Yí orúkọ padà"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Alákòóso"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Ọmọ ẹgbẹ́"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Olùwòran"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Gẹ́gẹ́ bí olùwòran, o lè kà kí o sì fèsì níbí."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn olùwòran lè kà, fèsì, kí wọ́n sì gbé ọwọ́ sókè láti béèrè láti kọ̀wé."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Àwọn àbá"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Wo profaili"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("ìwọ"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Olùwòran ni ọ́"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Ìrànlọ́wọ́"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "A ti kọ ọ́ sílẹ̀. Èyí ń ràn wá lọ́wọ́ láti yan ohun tí a ó fi hàn ọ́."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Darapọ̀"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Darapọ̀"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Èdè"),
      "ui_language_detail": MessageLookupByLibrary.simpleMessage("Yan èdè rẹ"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Òfin"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Fẹ́ràn"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ tí o fẹ́ràn"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ tí o fẹ́ràn máa hàn níbí, tuntun jù lọ ní àkọ́kọ́."),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("A ti da ìjápọ̀ kọ"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "O kò ní rí àwọn ìfiránṣẹ́ rẹ̀ mọ́. A kò ní sọ fún un."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Kò sí ìfẹ́ràn síbẹ̀"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Kò sí ìfiránṣẹ́ tó bá àwọn àsẹ́ yẹn mu."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Kò sí èyí tí a fi pamọ́ síbẹ̀"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("A ti ṣe àtúnṣe àkọọ́lẹ̀ rẹ"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "A ti gba ẹ̀bẹ̀ rẹ lórí ẹjọ́ \$number"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "A tún wo ẹ̀bẹ̀ rẹ lórí ẹjọ́ \$number, ìpinnu náà sì dúró"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "A ti fòfin de àkọọ́lẹ̀ rẹ títí láé"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Ẹjọ́ \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("tẹ̀lé ọ"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("fẹ́ràn ìfiránṣẹ́ rẹ"),
      "ui_notif_mentioned": MessageLookupByLibrary.simpleMessage("dá ọ lórúkọ"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Kò sí ìdárúkọ síbẹ̀"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Nígbà tí ẹnìkan bá kọ @orúkọ rẹ nínú ìfiránṣẹ́ tàbí èsì, yóò hàn níbí."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Àtijọ́"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "A ti yọ ìfiranṣẹ́ rẹ kúrò nínú ìjíròrò àwùjọ"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "A ti yọ ohun kan tí o firánṣẹ́ kúrò"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("A ti yọ ìfiránṣẹ́ rẹ kúrò"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("A ti yọ èsì rẹ kúrò"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("fèsì sí ìfiránṣẹ́ rẹ"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "A ti gbé ìgbésẹ̀ lórí ohun kan tí o jábọ̀. O ṣé fún sísọ fún wa."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "A wo ohun kan tí o jábọ̀, a kò sì rí i pé ó rú òfin wa."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("A jábọ̀ nítorí: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("tún ìfiránṣẹ́ rẹ fi ránṣẹ́"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "A ti yí ìpinnu ẹjọ́ \$number padà"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("A ti dá àkọọ́lẹ̀ rẹ dúró"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "A ti dá àkọọ́lẹ̀ rẹ dúró títí di \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Gbogbo"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Àwọn ìtẹ̀lé"),
      "ui_notif_tab_likes":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfẹ́ràn"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Àwọn ìdárúkọ"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Àwọn èsì"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("Ọ̀sẹ̀ yìí"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Òní"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Àkọọ́lẹ̀ rẹ ní ìkìlọ̀"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Àná"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Ó parí"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Fò ó"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("A ti ṣí èyí tẹ́lẹ̀."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Ó ti parí"),
      "ui_once_failed": MessageLookupByLibrary.simpleMessage("A kò lè ṣí èyí."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Ó ń ṣí lẹ́ẹ̀kan, lẹ́yìn náà a ó pa á rẹ́ lórí Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Wò ó lẹ́ẹ̀kan"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("A ti ṣí i"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("\$count nínú \$total ti ṣí i"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Àwọn tí o fi ránṣẹ́ sí nìkan ló lè ṣí i, lẹ́ẹ̀kan."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́ fún wíwò lẹ́ẹ̀kan"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Tẹ̀ láti wò ó"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Dánudúró"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Ṣe é"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "A ó yọ ọ́ kúrò nínú ìfihàn rẹ àti ìfúnni gbogbo ènìyàn. Àwọn ìdáhùn rẹ̀ máa lọ pẹ̀lú rẹ̀."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("A ti pa ìfiránṣẹ́ rẹ́"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("A ti fi ìfiránṣẹ́ pamọ́"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("A ti da ọ̀rọ̀ ìfiránṣẹ́ kọ"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("A fi ránṣẹ́ láàrin"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "A ti fi í pamọ́. A ó dín irú rẹ̀ kù."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Àwọn àṣàyàn"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Àṣírí"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Ṣé o fẹ́ ṣàfikún nǹkan kan? (àṣàyàn)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Ìwọ yóò gba ìfitónilétí nígbà tí ẹgbẹ́ bá pinnu, o sì lè tẹ̀lé e nínú Àwọn ìjábọ̀ rẹ."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Tí o kò bá fẹ́ rí ẹni yìí mọ́ pẹ̀lú, o lè pa á lẹ́nu mọ́ tàbí dí i lọ́nà láti inú àkójọ kan náà."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Jíjábọ̀ ohun kan náà lẹ́ẹ̀mejì kò fi kún ìwúwo rẹ̀: a máa ń tọ́jú ìjábọ̀ kan fún ènìyàn kọ̀ọ̀kan."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "A kì í pín ìjábọ̀ rẹ pẹ̀lú ẹni náà. A máa ń tọ́jú ẹ̀dà ohun tí o jábọ̀, kí a lè ṣàyẹ̀wò rẹ̀ bí wọ́n tilẹ̀ pa á rẹ́."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "A ti gba ìjábọ̀ rẹ, ó sì ń dúró de àyẹ̀wò. A kì í sọ fún ẹni náà ẹni tó jábọ̀."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Wo àwọn ìjábọ̀ rẹ"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Sọ ohun tí kò tọ́ fún wa"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("O ṣeun tí o sọ fún wa"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Kí ló ṣe \$name?"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("Kí ló ṣe ìfiránṣẹ́ yìí?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("Kí ló ṣe àtẹ̀jáde yìí?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("Kí ló ṣe èsì yìí?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Ìfiranṣẹ́ ìjíròrò àwùjọ"),
      "ui_reports_a_post":
          MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́ kan"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Èsì kan"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("A ti gbé ìgbésẹ̀"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("Àkọọ́lẹ̀ kan"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("A pinnu ní \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Kò sí òfin tí a rú"),
      "ui_reports_failed":
          MessageLookupByLibrary.simpleMessage("A kò lè ṣí àwọn ìjábọ̀ rẹ"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Ohun tí o jábọ̀ láàrin ọjọ́ 90 sẹ́yìn, àti àbájáde rẹ̀. O máa ń gba ìfitónilétí nígbà tí ẹgbẹ́ bá pinnu. A kì í sọ fún ẹni tí o jábọ̀ ẹni tí ó jábọ̀ wọn."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Kò sí ìjábọ̀"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Nígbà tí o bá jábọ̀ ìfiránṣẹ́, èsì, ìfiranṣẹ́ tàbí àkọọ́lẹ̀, a máa fihàn níbí pẹ̀lú àbájáde rẹ̀."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("Ó wà lábẹ́ àyẹ̀wò"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("A jábọ̀ ní \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Ohun tí o jábọ̀, àti àbájáde rẹ̀"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Àwọn ìjábọ̀ rẹ"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Ààbò ọmọdé"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Ohunkóhun tó fi ọmọdé sínú ewu tàbí tó ń lò ó ní ọ̀nà ìbálòpọ̀."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Ìfìyàjẹ tí a dojú kọ ẹnì kan, ìhalẹ̀, tàbí ìbánisọ̀rọ̀ tí a kò fẹ́."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Ìkọlù sí àwọn ènìyàn nítorí irú ẹni tí wọ́n jẹ́."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Títa tàbí pípolówó ohun tí kò bófin mu."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Ṣíṣe bí ẹni pé o jẹ́ ẹlòmíràn."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Ó ń lo iṣẹ́ rẹ tàbí àmì-ìdámọ̀ rẹ láìgba àṣẹ."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Àwọn ọ̀rọ̀ tó ń ṣini lọ́nà nípa ìlera, ìdìbò, tàbí ìṣẹ̀lẹ̀."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Gbígbani níyànjú láti ṣe ara ẹni léṣe tàbí fífi hàn."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Àkóónú ìbálòpọ̀ tí a fi hàn láìkìlọ̀."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Kò sí èyíkéyìí lókè. Sọ ohun tí kò tọ́ fún wa."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Ìpolówó tó ń tún ara rẹ̀ ṣe, tó ń ṣini lọ́nà, tàbí tí a kò fẹ́."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Ìhalẹ̀ ìwà ipá, gbígbé e ga, tàbí rírú u sókè."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Ìyọlẹ́nu tàbí ìfipá-ṣèkà"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Ọ̀rọ̀ ìkórìíra"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Ọjà tàbí iṣẹ́ tí kò bófin mu"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Ṣíṣe bí ẹlòmíràn"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Ohun-ìní ọgbọ́n"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Ìròyìn èké"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Ìpara-ẹni tàbí ṣíṣe ara-ẹni léṣe"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Àkóónú àgbàlagbà"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Nǹkan mìíràn"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Àwúrúju"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Ìwà ipá tàbí ìhàlẹ̀"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ tí a fi pamọ́"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Tẹ àmì àpamọ́ ìfiránṣẹ́ kan láti tọ́jú rẹ̀ síbí. Ìwọ nìkan ló ń rí àwọn tí o fi pamọ́."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Wá pẹ̀lú orúkọ olùmúlò tàbí orúkọ ìfihàn."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Pa rẹ́"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Wá gbogbo ohun tí a fi ránṣẹ́"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Àwọn àsẹ́"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("Wá àwọn ènìyàn"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Wá àwọn ìfiránṣẹ́"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Ètò"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Áàpù àti Ẹ̀rọ"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Àkóónú àti Ìfihàn"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Ìpamọ́ dátà"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Sọ èrò rẹ"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Wo àwọn àpilẹ̀kọ ìrànlọ́wọ́"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Yan èdè rẹ"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Àwọn tí o ti pa ẹnu wọn mọ́ tàbí tí o ti dínà"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Àwọn àṣàyàn ìfitónilétí"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("Ìfihàn rẹ àti àlàyé ìkànsí"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "O máa ní láti wọlé lẹ́ẹ̀kan sí i kí o tó padà sí àkáǹtì rẹ."),
      "ui_settings_security": MessageLookupByLibrary.simpleMessage("Ètò ààbò"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Jẹ́rìí ọ̀rọ̀ aṣínà"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("Ní ìlà kan"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Àdírẹ́sì ímeèlì tuntun"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Ọ̀rọ̀ aṣínà tuntun"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Ohun tó ṣẹlẹ̀"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "Gba ìrànlọ́wọ́ láti ọ̀dọ̀ ẹgbẹ́ wa"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Pín"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Fa ọ̀rọ̀ yọ"),
      "ui_share_send_message": MessageLookupByLibrary.simpleMessage(
          "Fi ránṣẹ́ nínú ìfiránṣẹ́ àdáni"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Sí àwọn ènìyàn lórí Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Pín ìfiránṣẹ́ yìí"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Ohun tó jẹ mọ́"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "A ti fòfin de àkọọ́lẹ̀ rẹ títí láé"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Ìdáhùn náà, ní \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Ẹ̀bẹ̀"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Bẹ̀bẹ̀ lórí ìpinnu yìí"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "A kò lè bẹ̀bẹ̀ lórí ìpinnu yìí mọ́. Tí nǹkan kan kò bá tọ́, kàn sí ìrànlọ́wọ́."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("A ń ṣàyẹ̀wò ẹ̀bẹ̀ náà"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("A gba ẹ̀bẹ̀ náà"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Ẹlòmíràn nínú ẹgbẹ́ ń tún un wò. Wàá gba ìfitónilétí nígbà tí a bá ṣe ìpinnu."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Tí o bá rò pé àṣìṣe ni, o lè béèrè pé kí a tún un wò títí di \$date. Ẹlòmíràn nínú ẹgbẹ́ ló máa pinnu."),
      "ui_standing_appeal_upheld":
          MessageLookupByLibrary.simpleMessage("Lẹ́yìn ẹ̀bẹ̀: ìpinnu náà dúró"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Ẹjọ́ \$number. Òfin: \$rule. Ẹgbẹ́ kọ pé:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Pípa àkọọ́lẹ̀ rẹ rẹ́ kò mú ìfòfinde kúrò: àkọọ́lẹ̀ tuntun pẹ̀lú àdírẹ́sì ímeèlì kan náà yóò bẹ̀rẹ̀ ní ìfòfinde pẹ̀lú."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("A ti fòfin dè é"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Ojú-ìwé yìí, ẹ̀bẹ̀, ìrànlọ́wọ́ àti pípa àkọọ́lẹ̀ rẹ́ nìkan ló ṣì ń ṣiṣẹ́."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("A lè bẹ̀bẹ̀"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Ẹjọ́ \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("A pinnu ní \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Àwọn ìpinnu nípa àkọọ́lẹ̀ rẹ"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Pa àkọọ́lẹ̀ rẹ rẹ́"),
      "ui_standing_details": MessageLookupByLibrary.simpleMessage("Wo àlàyé"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Wo àlàyé kí o sì bẹ̀bẹ̀"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Ó parí ní \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Àkọọ́lẹ̀ rẹ wà ní ipò rere"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Kò sí ohun tó ń dí i lọ́wọ́."),
      "ui_standing_load_failed":
          MessageLookupByLibrary.simpleMessage("A kò lè ṣí ipò àkọọ́lẹ̀"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("A ti yọ ìfiránṣẹ́ kúrò"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "A kò tíì ṣe ìpinnu kankan nípa àkọọ́lẹ̀ rẹ. Tí ẹgbẹ́ bá yọ nǹkan rẹ kúrò tàbí tí wọ́n bá dí àkọọ́lẹ̀ rẹ lọ́wọ́, yóò hàn níbí pẹ̀lú ìdí rẹ̀, o sì lè bẹ̀bẹ̀."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Kò sí ohun láti bẹ̀bẹ̀ lé: a ti fagi lé ìpinnu náà."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("A ti yọ àtẹ̀jáde kúrò"),
      "ui_standing_pull_to_check":
          MessageLookupByLibrary.simpleMessage("Fà á sílẹ̀ láti tún ṣàyẹ̀wò."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Ka àwọn òfin Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("A ti yọ èsì kúrò"),
      "ui_standing_reversed":
          MessageLookupByLibrary.simpleMessage("A ti fagi lé e"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "A fagi lé e ní \$date. Gbogbo ohun tí a yọ ti padà, kò sì sí ìdíwọ́ kankan tó ń ṣiṣẹ́ mọ́."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("Òfin: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Jáde"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("A ti dá a dúró"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "O lè kà, ṣùgbọ́n o kò lè fi nǹkan ránṣẹ́, fèsì, tẹ̀lé, tàbí fi ìfiránṣẹ́ ránṣẹ́. Jíjábọ̀, dídínà àti pípa lẹ́nu mọ́ ṣì ń ṣiṣẹ́."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "A ti dá àkọọ́lẹ̀ rẹ dúró: o lè kà, ṣùgbọ́n o kò lè fi nǹkan ránṣẹ́."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("A dá a dúró títí di \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "A ti dá àkọọ́lẹ̀ rẹ dúró títí di \$date: o lè kà, ṣùgbọ́n o kò lè fi nǹkan ránṣẹ́."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Ohun tí ẹgbẹ́ kọ"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("Ipò àkọọ́lẹ̀"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Ìkìlọ̀"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Kí nìdí?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("O kọ, ní \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́ rẹ"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Àtẹ̀jáde rẹ"),
      "ui_standing_your_reply": MessageLookupByLibrary.simpleMessage("Èsì rẹ"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Àwọn Òfin Iṣẹ́"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ìfiránṣẹ́ yìí"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("A ti pa ẹnu okùn ọ̀rọ̀ mọ́"),
      "ui_try_again":
          MessageLookupByLibrary.simpleMessage("Gbìyànjú lẹ́ẹ̀kan sí i"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("Pa ohùn"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Tan ohùn"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Ó kéré tán lẹ́tà méjì."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Padà"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Àwọn ọ̀rọ̀, tàbí àsẹ́: àkáǹtì kan, àkókò ọjọ́, tàbí ohun tí ìfiránṣẹ́ kan ní."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Fagilé àtúnfiránṣẹ́"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Ṣe àfikún ọ̀rọ̀ aṣínà"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Lo àdírẹ́sì mìíràn"),
      "username": MessageLookupByLibrary.simpleMessage("Orúkọ olùmúlò"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Orúkọ olùmúlò gbọ́dọ̀ jẹ́ lẹ́tà kékeré (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Fídíò"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("So mọ́"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Ó ti ṣetán láti so mọ́"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Gba ìfiránṣẹ́ ohùn sílẹ̀"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Ó ń fi pamọ́…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Dúró"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Ohun tó ṣẹlẹ̀"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Kí ló ṣẹlẹ̀, kí ni ó yẹ ká wò?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Kí ló wà nínú àwòrán yìí?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Fún kí ni? (àṣàyàn)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Ohun tí o ṣe, ohun tí o retí, ohun tó ṣẹlẹ̀"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Ohun tí o ń ṣe nígbà tó ṣẹlẹ̀."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("O fèsì"),
      "dmReplied": (Object a0) => "$a0 fèsì",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Fi kún ìfiránṣẹ́"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́ tuntun"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "A kò tíì sọ nǹkan kan. Fífi ọwọ́ júwe jẹ́ ìbẹ̀rẹ̀ tó dára."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Fi ọwọ́ júwe"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ tuntun"),
      "dmTyping": (Object a0) => "$a0 ń tẹ̀wé",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Yọ ìhùwàsí rẹ kúrò"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Ẹnìkan"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("Àsomọ́"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "A kò lè ka ìfiránṣẹ́ yìí lórí ẹ̀rọ yìí."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Ń dúró de ìfiránṣẹ́ yìí. Èyí lè gba ìgbà díẹ̀."),
      "ui_dm_preview_sealed": MessageLookupByLibrary.simpleMessage(
          "Ìfiránṣẹ́ tí a ti fi kóòdù pa mọ́"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "A ti fi kóòdù pa àwọn ìfiránṣẹ́ mọ́ láti òpin dé òpin"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "A kò fi kóòdù pa á mọ́ láti òpin dé òpin"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Ti fi ránṣẹ́"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Ti rí i"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Ń fi ránṣẹ́…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Ya fọ́tò"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Àwọn àṣàyàn míì"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("Fi pamọ́ sí ẹ̀rọ"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Pín"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Ń fi pamọ́…"),
      "ui_media_saved": MessageLookupByLibrary.simpleMessage(
          "A ti fi pamọ́ sí àwọn fọ́tò rẹ"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "A kò lè fi pamọ́. Gbìyànjú lẹ́ẹ̀kan sí i."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Gba Kyron láàyè láti fi kún àwọn fọ́tò rẹ kí o lè fi èyí pamọ́."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Gbogbo ètò ń ṣiṣẹ́"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Àkókò iṣẹ́"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Ọjọ́ 60 tó kọjá"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Ọjọ́ 60 sẹ́yìn"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Òní"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database":
          MessageLookupByLibrary.simpleMessage("Ibi ìpamọ́ dátà"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Ìwọlé"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Àwọn ìṣẹ̀lẹ̀ àìpẹ́"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Kò sí ìṣẹ̀lẹ̀ kankan ní ọjọ́ 60 tó kọjá."),
      "ui_status_ongoing":
          MessageLookupByLibrary.simpleMessage("Ó ń lọ lọ́wọ́"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Kò sí dátà"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Àlàyé"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron máa ń ṣàyẹ̀wò ara rẹ̀ ní gbogbo ìṣẹ́jú 5 nígbà tó bá ń ṣiṣẹ́. Ọjọ́ eérú kò ní àyẹ̀wò kankan."),
      "ui_status_unavailable":
          MessageLookupByLibrary.simpleMessage("Ìtàn àkókò iṣẹ́ kò tíì sí."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Àwọn ètò kan ní ìṣòro"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Ṣe àkọsílẹ̀ ìfiránṣẹ́ ohùn"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Ó ti ṣetán láti fi ránṣẹ́"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́ yẹn kò sí níbí mọ́."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Lọ sí ìfiránṣẹ́ náà"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Ìfiránṣẹ́ ohùn"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Òǹkọ̀wé fẹ́ràn rẹ̀"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Fi fọ́tò tàbí fídíò kún un"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Mídíà"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ ohùn"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Ìwíregbè"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("Àwòrán ẹ̀yìn"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Pa ohùn ìwífún mọ́"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Dẹ́kun gbígba ìwífún nípa ìjíròrò yìí"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Wọn kò lè fi ìfiránṣẹ́ ránṣẹ́ sí ọ mọ́"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Kò sí"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Fọ́tò"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("A ti ṣí ohùn padà."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "A kò lè yọ ọ́ kúrò. Gbìyànjú lẹ́ẹ̀kan sí i."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profaili"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Ṣí ohùn padà"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Àwọn fọ́tò àti fídíò tí o pín ń hàn níbí."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Wo gbogbo rẹ̀"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Fọ́tò àti fídíò"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Báyìí ni ìwíregbè rẹ yóò ṣe rí."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Ó dára."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Ìkùukùu"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Ìrọ̀lẹ́"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Ewé"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Iyanrìn"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Àmì kékeré"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Lò ó"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Lọ́wọ́lọ́wọ́"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́ láìsí àwòtẹ́lẹ̀"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Wá"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Gbé jáde"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Kọ ìfiránṣẹ́…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Ti fi ránṣẹ́"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "Ti fi ránṣẹ́, ṣùgbọ́n kì í ṣe sí gbogbo ènìyàn."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Kò ṣeé fi ránṣẹ́. Gbìyànjú lẹ́ẹ̀kan sí i."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Olùtẹ̀lé"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Àlẹ̀mọ́"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Gbogbo"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Àìkà"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Àìdáhùn"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Ìpamọ́"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Kò sí ohun tí a pa mọ́"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìjíròrò tí o yọ kúrò nínú àkójọ rẹ ń dúró síbí, bí o bá fẹ́ dá wọn padà."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Ó lọ sí Ìpamọ́. Ẹnì kejì ń tọ́jú tirẹ̀, yóò sì padà bí ọ̀kan nínú yín bá tún kọ̀wé."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Dá padà"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Ó ti padà sínú àkójọ rẹ."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Kò sí ìjíròrò tó bá a mu."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Kò sí ohun tó ń dúró dè ọ́"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Gbogbo ìjíròrò ló parí pẹ̀lú ọ̀rọ̀ rẹ."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Fọ́tò"),
      "ui_dm_preview_photos":
          MessageLookupByLibrary.simpleMessage("Àwọn fọ́tò"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Fídíò"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Kò tíì sí ìfiránṣẹ́"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Ìwọ:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Àná"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Ètò ìfiránṣẹ́"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("Àṣírí"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Ìwé-ẹ̀rí kíkà"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Nígbà tí èyí bá wà ní pípa, àwọn ènìyàn kò ní rí ìgbà tí o ka ìfiránṣẹ́ wọn, ìwọ náà kò ní rí ìgbà tí wọ́n ka tìrẹ."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Fihàn nígbà tí o bá ń tẹ̀wé"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Ẹni tí o ń kọ̀wé sí ń rí pé o ń kọ̀wé."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Àwòtẹ́lẹ̀ ìjápọ̀"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Fóònù rẹ ń ṣí ìjápọ̀ tí o fi ránṣẹ́ láti ṣe àwòtẹ́lẹ̀ rẹ̀, nítorí náà ojú-òpó náà ń rí ìbéèrè fóònù rẹ. Olupin Kyron kò rí ìjápọ̀ náà rí."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Ìwífún fún ìfiránṣẹ́"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ jẹ́ pípa láṣìírí láti òpin dé òpin. Kyron kò lè kà wọ́n, kò sì sí ohunkóhun níbí tó yí ìyẹn padà."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Sí:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Àìpẹ́"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Àwọn ènìyàn"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Kò sí ẹni tó ń jẹ́ orúkọ yẹn."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Fi ìwífún ìdánwò ránṣẹ́"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "A kò tíì ṣètò olupin Kyron láti fi ìwífún ránṣẹ́, nítorí náà kò sí èyí tó lè dé. Ìṣòro náà wà lọ́dọ̀ wa, kì í ṣe fóònù rẹ."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "A kò forúkọ fóònù yìí sílẹ̀ fún ìwífún. Ṣàyẹ̀wò pé a gba ìwífún Kyron láàyè nínú ètò fóònù rẹ, lẹ́yìn náà gbìyànjú lẹ́ẹ̀kan sí i."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "A kò lè fi ìwífún náà dé fóònù yìí. Gbìyànjú lẹ́ẹ̀kan sí i lẹ́yìn ìṣẹ́jú kan."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "A ti fi ránṣẹ́. Ó yẹ kó dé láàárín ìṣẹ́jú-àáyá díẹ̀."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Ìwífún ń ṣiṣẹ́."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Kò tíì sí àwọn ìfiránṣẹ́"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("Àwùjọ tuntun"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Orúkọ"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Láti orúkọ ni a ti ń ṣe àdírẹ́sì rẹ̀."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Àwọn ènìyàn yóò rí i ní"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Ìwọ ni yóò ni ín. A lè fi àwòrán, àsíá àti àwọn alábòójútó kún un láti ojú-ìwé rẹ̀ nígbà tí ó bá wà."),
      "ui_community_settings_home": MessageLookupByLibrary.simpleMessage("Ilé"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ àwùjọ ní Ilé"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ láti àwọn àwùjọ rẹ tún ń hàn ní Ilé. Tí a bá pa á, wọ́n á dúró síbí ní Àwọn Àwùjọ, níbi tí ọ̀kọ̀ọ̀kan ti ń fi ohun tuntun hàn."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Àkójọ rẹ"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Iye àwọn ìfiránṣẹ́ tuntun"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Fi hàn iye ìfiránṣẹ́ tó jẹ́ tuntun nínú àwùjọ kọ̀ọ̀kan láti ìgbà tí o ṣí i kẹ́yìn."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Àwọn àwùjọ tí o ń darí"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn àwùjọ tí o dá sílẹ̀ tàbí tí o ń bójútó wà níbí."),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("Olùní"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Alábòójútó"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́ tuntun"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Tí o ń darí"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Ètò àwùjọ"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Ṣàwárí"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Kò sí àwùjọ tó bá a mu."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Kò sí nǹkan tuntun"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Gbogbo àwùjọ wà bí o ṣe fi wọ́n sílẹ̀."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("O kò tíì ń darí ọ̀kankan"),
      "ui_community_discover_none": MessageLookupByLibrary.simpleMessage(
          "Kò sí ohun tó kù láti dara pọ̀ mọ́"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "O wà nínú gbogbo àwùjọ lórí Kyron. Dá òmíràn sílẹ̀."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Gbìyànjú ọ̀rọ̀ mìíràn, tàbí dá àwùjọ sílẹ̀ pẹ̀lú orúkọ yẹn."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Kọ ìfiránṣẹ́"),
      "ui_community_members":
          MessageLookupByLibrary.simpleMessage("Àwọn ọmọ ẹgbẹ́:"),
      "ui_toast_posted":
          MessageLookupByLibrary.simpleMessage("A ti gbé e jáde"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Wò ó"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Ṣí i"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Lórí ayélujára"),
      "ui_dm_show_online": MessageLookupByLibrary.simpleMessage(
          "Fihàn nígbà tí o bá wà lórí ayélujára"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn tí o ń fi ìfiránṣẹ́ ránṣẹ́ sí ń rí àmì aláwọ̀ ewé nígbà tí Kyron bá ṣí sílẹ̀ lọ́dọ̀ rẹ. Nígbà tí èyí bá wà ní pípa, ìwọ náà kò ní rí tiwọn."),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "Wá àwọn ènìyàn àti àwọn ìfìwéránṣẹ́"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Àwọn àwùjọ tí o lè darapọ̀ mọ́"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Kò sí nǹkan láti wò síbẹ̀"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn fọ́tò àti fídíò tí àwọn ènìyàn fí síta yóò hàn níbí."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Tẹ̀lé"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Pa àkáǹtì rẹ́"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Èyí yóò pa àkáǹtì Kyron rẹ rẹ́ pátápátá. A kò lè dá a padà."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Profaili rẹ, àwọn ìfìwéránṣẹ́, ìdáhùn, àwọn ohun tí o fẹ́ràn àti àtúnpín rẹ"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ rẹ, pẹ̀lú èyí tí o fi ránṣẹ́ sí àwọn ẹlòmíràn, àti àwọn fọ́tò àti àkọsílẹ̀ ohùn inú wọn"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Àwọn olùtẹ̀lé rẹ, àwọn ènìyàn tí o ń tẹ̀lé, àti àwọn ètò rẹ"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Àwọn àwùjọ tí o dá sílẹ̀ yóò bọ́ sọ́wọ́ alábòójútó tàbí ọmọ ẹgbẹ́ tó pẹ́ jù níbẹ̀. Àwùjọ tí kò sí ẹlòmíràn nínú rẹ̀ yóò di títì."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Pa àkáǹtì rẹ rẹ́?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "O kò ní lè rí ohunkóhun nínú rẹ̀ gbà padà."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("A ti pa àkáǹtì rẹ rẹ́."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Àkáǹtì tí a ti pa rẹ́"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "A ti pa àkáǹtì yìí rẹ́, nítorí náà a kò lè fi ìfiránṣẹ́ ránṣẹ́ síbí mọ́."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Ṣé o forúkọsílẹ̀ pẹ̀lú Google? Lo «Sign in with Google» dípò rẹ̀."),
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("A kò lè gbé lẹ́ńsì yẹn wá."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("A kò lè ká fídíò náà sílẹ̀."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "A kò lè fi lẹ́ńsì kún fídíò yìí, nítorí náà a ó fi í síta bí a ti yà á."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Ìfiránṣẹ́ rẹ ti ní àwọn àfikún tó pọ̀ jù tí ó lè gbà."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("À ń fi lẹ́ńsì rẹ kún un…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Fìlàṣì"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Ká fídíò sílẹ̀"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Fọ́tò"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Fídíò"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "A ti fagi lé wíwọlé pẹ̀lú Google."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("Ẹ̀BÙN"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Kò tíì sí ẹni tó fi ẹ̀bùn ránṣẹ́ sí ìfiránṣẹ́ yìí."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Ẹ̀bùn"),
      "analytics_gifts_label":
          MessageLookupByLibrary.simpleMessage("Àwọn ẹ̀bùn"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Ẹyọ owó"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Olùfiránṣẹ́"),
      "analytics_senders":
          MessageLookupByLibrary.simpleMessage("Àwọn olùfiránṣẹ́"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Ẹyọ owó ìdánwò: a kò lè gbà wọ́n jáde síbẹ̀."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Tí a fi pamọ́"),
      "ui_saved_tab_posts":
          MessageLookupByLibrary.simpleMessage("Àwọn ìfiránṣẹ́"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Àwọn àsọyé"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Wo àwọn ìdáhùn sí i"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Ti ṣàtúnṣe"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Sí i"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Tí ò ń tẹ̀lé"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Àwọn tó gbajúmọ̀"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Tuntun"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Tò àwọn àsọyé: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "fi ẹ̀bùn ránṣẹ́ sí ìfiránṣẹ́ rẹ"),
      "ui_notif_gift_comment":
          MessageLookupByLibrary.simpleMessage("fi \$gift ránṣẹ́ sí àsọyé rẹ"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "fi \$gift ránṣẹ́ sí ìfiránṣẹ́ rẹ"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Fi ẹ̀bùn ránṣẹ́"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Ṣàtúnṣe ìfiránṣẹ́"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "O lè ṣàtúnṣe rẹ̀ fún ìṣẹ́jú \$n sí i"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Fi pamọ́"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Kò tíì sí ohun tí a fi síta lábẹ́ #\$tab."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Yan ẹ̀bùn kan"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Ẹyọ owó kò tó"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Ẹyọ owó ìdánwò: a kò lè rà wọ́n, wọn kò sì ní iye owó."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Yóò kún padà ní \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("Ẹyọ owó 1"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("Ẹyọ owó \$count"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("O ní \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Fi \$gift ránṣẹ́"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("A ti fi \$gift ránṣẹ́"),
      "ui_retry":
          MessageLookupByLibrary.simpleMessage("Gbìyànjú lẹ́ẹ̀kan sí i"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "Fún ìṣẹ́jú 15 lẹ́yìn tí o fi síta"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Ti ṣàtúnṣe"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "A kò lè gbé àwọn àsọyé tí o fi pamọ́ wá"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Kò sí àsọyé tí a fi pamọ́"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Tẹ àmì ìpamọ́ lábẹ́ àsọyé kan láti pa á mọ́ síbí. Ìwọ nìkan ló ń rí ohun tí o fi pamọ́."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Ń dá \$name lóhùn"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Ṣàdàkọ"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Wá"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Yan gbogbo rẹ̀"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("Ẹ̀bùn \$count"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("Ẹ̀bùn 1"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "A kò lè gbé àwọn ìfiránṣẹ́ míì wá."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Àwọn ìránnilétí"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Ohun tuntun lẹ́yìn tí o ti lọ fún ìgbà díẹ̀, àti nígbà tí ẹyọ owó rẹ bá padà. Kò ju ẹyọ kan lọ lójoojúmọ́."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Àwọn ẹ̀bùn"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("láti ọ̀dọ̀ ènìyàn 1"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("láti ọ̀dọ̀ ènìyàn \$count"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("Olùfúnni tó ga jù"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "A kò lè gbé àwọn tó fi ẹ̀bùn ránṣẹ́ wá."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Kí ló ṣẹ̀ṣẹ̀ dé"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Ó yé mi"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "A dúpẹ́. A ń ka gbogbo ìdáhùn."),
      "ui_check_in_title": MessageLookupByLibrary.simpleMessage(
          "Báwo ni Kyron ṣe rí títí di ìsinsìnyí?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Ọjọ́ \$day ìdánwò rẹ. Títẹ̀ ẹ̀ẹ̀kan tó."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Ṣé ohun kan wà tí a gbọ́dọ̀ tún ṣe tàbí fi kún un? (àṣàyàn)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Fi ránṣẹ́"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Kì í ṣe báyìí"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Tẹ padà lẹ́ẹ̀kan sí i láti kúrò ní Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Jẹ́rìí pé ìwọ ni"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Tẹ ọ̀rọ̀ aṣínà rẹ láti pa àkọọ́lẹ̀ rẹ rẹ́."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Wọlé lẹ́ẹ̀kan sí i pẹ̀lú Google láti pa àkọọ́lẹ̀ rẹ rẹ́."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Ìyẹn kò ṣiṣẹ́. Ṣàyẹ̀wò rẹ̀ kí o sì tún gbìyànjú."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Ojú-ìwé yìí fẹ́ ṣí ìṣàfilọ́lẹ̀ mìíràn"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Ó ń béèrè láti ṣí ìjápọ̀ {scheme} kan."),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("Ìkọ́"),
      "ui_about_cache_size": MessageLookupByLibrary.simpleMessage(
          "Àwòrán àti fáìlì {size} nínú ibi ìpamọ́ ìgbà díẹ̀"),
      "ui_about_freed":
          MessageLookupByLibrary.simpleMessage("A ti tú {size} sílẹ̀"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("Ó ń wọ̀n…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("Kò sí nǹkan láti pa rẹ́"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("Ibi ìpamọ́"),
      "ui_about_version":
          MessageLookupByLibrary.simpleMessage("Ẹ̀yà {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("Àwọn tí a dí"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("Ò ń fi ránṣẹ́ ní orúkọ ara rẹ"),
      "ui_composer_uploads_failed": MessageLookupByLibrary.simpleMessage(
          "Àwọn àsomọ́ wọ̀nyí kò gbéjáde. Tẹ ọ̀kan láti tún gbìyànjú, tàbí yọ ọ́ kúrò."),
      "ui_email_change_failed": MessageLookupByLibrary.simpleMessage(
          "A kò lè yí ímeèlì rẹ padà. Jọ̀wọ́ tún gbìyànjú."),
      "ui_email_changes_after_link": MessageLookupByLibrary.simpleMessage(
          "Àdírẹ́sì rẹ yóò yí padà nígbà tí o bá ṣí ìjápọ̀ tí a fi ránṣẹ́."),
      "ui_email_check_link": MessageLookupByLibrary.simpleMessage(
          "Wo {email} fún ìjápọ̀ ìfìdímúlẹ̀."),
      "ui_email_enter":
          MessageLookupByLibrary.simpleMessage("Tẹ àdírẹ́sì ímeèlì."),
      "ui_email_invalid":
          MessageLookupByLibrary.simpleMessage("Ìyẹn kò jọ àdírẹ́sì ímeèlì."),
      "ui_email_same": MessageLookupByLibrary.simpleMessage(
          "Ìyẹn ti jẹ́ àdírẹ́sì ímeèlì rẹ tẹ́lẹ̀."),
      "ui_feedback_bug_hint": MessageLookupByLibrary.simpleMessage(
          "Ohun tí o ṣe, ohun tí o retí, àti ohun tí ó ṣẹlẹ̀ dípò rẹ̀."),
      "ui_feedback_idea_example": MessageLookupByLibrary.simpleMessage(
          "Jẹ́ kí n lẹ ìfiránṣẹ́ mọ́ àkọọ́lẹ̀ mi"),
      "ui_feedback_idea_hint": MessageLookupByLibrary.simpleMessage(
          "Ohun tí o fẹ́, àti ohun tí yóò jẹ́ kí o lè ṣe."),
      "ui_feedback_idea_label":
          MessageLookupByLibrary.simpleMessage("Ohun tí yóò ṣe ìrànlọ́wọ́"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("Ìṣòro kan"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("Èrò kan"),
      "ui_feedback_kind_question":
          MessageLookupByLibrary.simpleMessage("Ìbéèrè kan"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "Ẹgbẹ́ Kyron nìkan ló ń ka èyí. A ń fi ránṣẹ́ pẹ̀lú àkọọ́lẹ̀ rẹ kí a lè fèsì nípasẹ̀ ímeèlì, àti pẹ̀lú ẹ̀yà ìṣàfilọ́lẹ̀ tí o ń lò. Pípa àkọọ́lẹ̀ rẹ rẹ́ yóò pa èyí rẹ́ náà."),
      "ui_feedback_question_example": MessageLookupByLibrary.simpleMessage(
          "Báwo ni mo ṣe lè pa ọ̀rọ̀ kan lẹ́nu mọ́?"),
      "ui_feedback_question_hint": MessageLookupByLibrary.simpleMessage(
          "Ohun tí o ń gbìyànjú láti ṣe, àti ibi tí o há sí."),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("Ìbéèrè rẹ"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "A kò lè dé Kyron. Ṣàyẹ̀wò ìsopọ̀ rẹ kí o sì tún gbìyànjú. A kò tíì kọ nǹkan kan, nítorí náà kò sí ohun tó sọnù."),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("Pa rẹ́"),
      "ui_log_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìbéèrè tí kò yọrí àti àwọn ìṣẹ̀lẹ̀ pàtàkì míì máa ń hàn níbí."),
      "ui_muted_tab":
          MessageLookupByLibrary.simpleMessage("Àwọn tí a pa lẹ́nu mọ́"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "Ṣàfikún ọ̀rọ̀ tàbí àmì lókè. Àwọn ìfiránṣẹ́ tí ó ní i kò ní hàn nínú àkójọ rẹ."),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ tí ó ní èyíkéyìí nínú ìwọ̀nyí kò ní hàn nínú àkójọ rẹ. Lẹ́tà ńlá tàbí kékeré kò jẹ́ nǹkan, ọ̀rọ̀ sì ń bá ara mu nínú àwọn ọ̀rọ̀ tó gùn jù, nítorí náà “spoiler” ń mú “spoilers” pẹ̀lú."),
      "ui_nobody_blocked":
          MessageLookupByLibrary.simpleMessage("Kò sí ẹni tí a dí"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "Dídí ń fi yín pamọ́ fún ara yín, ní ẹ̀gbẹ́ méjèèjì. Dí ẹnìkan láti inú àkójọ àṣàyàn lórí àkọọ́lẹ̀ rẹ̀."),
      "ui_nobody_muted":
          MessageLookupByLibrary.simpleMessage("Kò sí ẹni tí a pa lẹ́nu mọ́"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "Pípa àkọọ́lẹ̀ lẹ́nu mọ́ ń fi àwọn ìfiránṣẹ́ rẹ̀ pamọ́ láì sọ fún un. Pa ẹnìkan lẹ́nu mọ́ láti inú àkójọ àṣàyàn àkọọ́lẹ̀ tàbí ìfiránṣẹ́ rẹ̀."),
      "ui_password": MessageLookupByLibrary.simpleMessage("Ọ̀rọ̀ aṣínà"),
      "ui_password_mismatch":
          MessageLookupByLibrary.simpleMessage("Wọn kò bá ara mu."),
      "ui_password_other_devices": MessageLookupByLibrary.simpleMessage(
          "Ìwọ yóò wà nínú àkọọ́lẹ̀ lórí ẹ̀rọ yìí. A ó jáde kúrò lórí àwọn ẹ̀rọ míì."),
      "ui_password_too_short":
          MessageLookupByLibrary.simpleMessage("Lo ó kéré tán lẹ́tà 8."),
      "ui_password_update_failed": MessageLookupByLibrary.simpleMessage(
          "A kò lè ṣe àtúnṣe ọ̀rọ̀ aṣínà rẹ. Jọ̀wọ́ tún gbìyànjú."),
      "ui_password_updated":
          MessageLookupByLibrary.simpleMessage("A ti ṣe àtúnṣe ọ̀rọ̀ aṣínà."),
      "ui_profile_did_copied":
          MessageLookupByLibrary.simpleMessage("A ti ṣe ẹ̀dà DID"),
      "ui_profile_empty_likes": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìfiránṣẹ́ tí o fẹ́ràn ni a ń tọ́jú síbí, fún ìwọ nìkan."),
      "ui_profile_empty_media_mine": MessageLookupByLibrary.simpleMessage(
          "O kò tíì fi fọ́tò tàbí fídíò kankan ránṣẹ́."),
      "ui_profile_empty_media_other": MessageLookupByLibrary.simpleMessage(
          "{name} kò tíì fi fọ́tò tàbí fídíò kankan ránṣẹ́."),
      "ui_profile_empty_posts_mine": MessageLookupByLibrary.simpleMessage(
          "Gbogbo ohun tí o bá fi ránṣẹ́ yóò hàn níbí."),
      "ui_profile_empty_posts_other": MessageLookupByLibrary.simpleMessage(
          "{name} kò tíì fi nǹkan kankan ránṣẹ́."),
      "ui_profile_load_failed_mine":
          MessageLookupByLibrary.simpleMessage("A kò lè gbé àkọọ́lẹ̀ rẹ jáde"),
      "ui_profile_load_failed_other":
          MessageLookupByLibrary.simpleMessage("A kò lè gbé @{handle} jáde"),
      "ui_pw_rule_length":
          MessageLookupByLibrary.simpleMessage("Ó kéré tán lẹ́tà 8"),
      "ui_pw_rule_lower":
          MessageLookupByLibrary.simpleMessage("Lẹ́tà kékeré (a–z)"),
      "ui_pw_rule_number":
          MessageLookupByLibrary.simpleMessage("Ó kéré tán nọ́mbà kan"),
      "ui_pw_rule_symbol": MessageLookupByLibrary.simpleMessage("Àmì (!@#…)"),
      "ui_pw_rule_upper":
          MessageLookupByLibrary.simpleMessage("Lẹ́tà ńlá (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "Àkọsílẹ̀ {count} àìpẹ́ yìí. Ṣàyẹ̀wò wọn ní Nípa › Àkọsílẹ̀ ètò kí o tó fi ránṣẹ́."),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "Ẹgbẹ́ Kyron nìkan ló ń ka èyí. A ń fi ránṣẹ́ pẹ̀lú àkọọ́lẹ̀ rẹ kí a lè tẹ̀lé e. Ka àkọsílẹ̀ náà ní Nípa › Àkọsílẹ̀ ètò kọ́kọ́ bí o bá fẹ́ rí gangan ohun tí ó ń bá a lọ."),
      "ui_report_sent":
          MessageLookupByLibrary.simpleMessage("A ti fi ránṣẹ́, o ṣé."),
      "ui_report_sent_number": MessageLookupByLibrary.simpleMessage(
          "A ti fi ránṣẹ́, o ṣé. Ìròyìn #{number} ni."),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("Kí ló ṣẹlẹ̀ tí kò tọ́?"),
      "ui_settings_about_help": MessageLookupByLibrary.simpleMessage(
          "Ẹ̀yà, ìlànà, ipò àti àkọsílẹ̀ ètò"),
      "ui_settings_autoplay_help": MessageLookupByLibrary.simpleMessage(
          "Dá fídíò dúró láti máa ṣeré fúnra wọn nígbà tí o bá ń yí"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage(
          "Ìdánimọ̀ rẹ tí kò dá lórí ibì kan"),
      "ui_settings_moderation": MessageLookupByLibrary.simpleMessage("Ìṣàkóso"),
      "ui_settings_moderation_help": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìròyìn àti ẹ̀bẹ̀ tí ń dúró de àyẹ̀wò"),
      "ui_settings_muted_words_help": MessageLookupByLibrary.simpleMessage(
          "Pa àwọn ìfiránṣẹ́ tí ó ní ìwọ̀nyí mọ́ kúrò nínú àkójọ rẹ"),
      "ui_settings_not_signed_in":
          MessageLookupByLibrary.simpleMessage("O kò wọlé"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("Àwọn ààyò ìfitónilétí"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("Àṣírí àti Ààbò"),
      "ui_settings_standing_help": MessageLookupByLibrary.simpleMessage(
          "Àwọn ìpinnu nípa àkọọ́lẹ̀ rẹ, àti ẹ̀bẹ̀"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("Ṣàtúnṣe ìwọ̀n ọ̀rọ̀"),
      "ui_settings_your_account":
          MessageLookupByLibrary.simpleMessage("Àkọọ́lẹ̀ rẹ"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "A ṣì ń kọ́ gbígbàsílẹ̀ àti títẹ̀jáde lẹ́ńsì AR. Kò sí ohun tí o bá yà tí a ó fipamọ́ síbẹ̀, nítorí náà kámẹ́rà wà ní títì."),
      "ui_soon_lens_heading":
          MessageLookupByLibrary.simpleMessage("Lẹ́ńsì kò tíì ṣetán"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("Lẹ́ńsì AR"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "Láti lọ láàyè nílò olùpín ìkànnì media tí Kyron kò tíì ń ṣiṣẹ́. Bí o bá bẹ̀rẹ̀ ìgbéjáde báyìí, ìwọ yóò wà nínú yàrá tí ẹnikẹ́ni kò lè wọ̀. Gbígbàsílẹ̀ ìfiránṣẹ́ ohùn ń ṣiṣẹ́ lónìí."),
      "ui_soon_live_heading":
          MessageLookupByLibrary.simpleMessage("Lílọ láàyè kò tíì ṣetán"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("Lọ láàyè"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Ìdìbò nílò ibi láti tọ́jú àwọn àṣàyàn àti láti ka ìbò. Ìyẹn kò tíì sí, nítorí náà ìdìbò tí a fi ránṣẹ́ lónìí yóò pàdánù gbogbo ìdáhùn."),
      "ui_soon_poll_heading":
          MessageLookupByLibrary.simpleMessage("Ìdìbò kò tíì ṣetán"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("Ìdìbò"),
      "ui_soon_write_instead":
          MessageLookupByLibrary.simpleMessage("Kọ ìfiránṣẹ́ ọ̀rọ̀ dípò rẹ̀"),
      "ui_status_check_again":
          MessageLookupByLibrary.simpleMessage("Tún ṣàyẹ̀wò"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("Àlàyé"),
      "ui_status_mirror":
          MessageLookupByLibrary.simpleMessage("Àwọn tábìlì dígí"),
      "ui_status_not_right": MessageLookupByLibrary.simpleMessage(
          "Kyron dáhùn, ṣùgbọ́n nǹkan kan kò tọ́."),
      "ui_status_round_trip":
          MessageLookupByLibrary.simpleMessage("Ìrìn àjò lọ àti bọ̀"),
      "ui_support_ask": MessageLookupByLibrary.simpleMessage("Béèrè ìbéèrè"),
      "ui_support_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Nípa àkọọ́lẹ̀ rẹ, tàbí bí nǹkan ṣe ń ṣiṣẹ́"),
      "ui_support_by_email":
          MessageLookupByLibrary.simpleMessage("Nípasẹ̀ ímeèlì"),
      "ui_support_crash_detail": MessageLookupByLibrary.simpleMessage(
          "Bí Kyron bá kọlu: ó ń fi àkọsílẹ̀ ìṣàfilọ́lẹ̀ ránṣẹ́ pẹ̀lú"),
      "ui_support_in_app":
          MessageLookupByLibrary.simpleMessage("Nínú ìṣàfilọ́lẹ̀"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "Kọ̀wé sí ẹgbẹ́ Kyron láti ibí. Ó ń dé ọ̀dọ̀ wa ní ìkọ̀kọ̀, pẹ̀lú àkọọ́lẹ̀ rẹ, a sì ń fèsì sí àdírẹ́sì ímeèlì tí ó wà lórí rẹ̀."),
      "ui_support_no_mail": MessageLookupByLibrary.simpleMessage(
          "Kò sí ìṣàfilọ́lẹ̀ ímeèlì tí ó ṣí. A ti ṣe ẹ̀dà {address}."),
      "ui_support_privacy":
          MessageLookupByLibrary.simpleMessage("Àṣírí àti dátà rẹ"),
      "ui_support_report": MessageLookupByLibrary.simpleMessage("Jábọ̀ ìṣòro"),
      "ui_support_report_detail": MessageLookupByLibrary.simpleMessage(
          "Nǹkan kan ti bàjẹ́ tàbí kò ṣe ohun tí ó yẹ"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "Láti jábọ̀ ìfiránṣẹ́ tàbí àkọọ́lẹ̀, lo àkójọ àṣàyàn rẹ̀: ìyẹn ń sọ fún wa gangan èyí tí o ní lọ́kàn."),
      "ui_support_safety":
          MessageLookupByLibrary.simpleMessage("Ààbò àti ìlòkulò"),
      "ui_support_status_detail": MessageLookupByLibrary.simpleMessage(
          "Bóyá Kyron ti dúró fún gbogbo ènìyàn, tàbí fún ìwọ nìkan"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("Ńlá"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("Tóbi jù"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("Àárín"),
      "ui_text_size_preview": MessageLookupByLibrary.simpleMessage(
          "Kyron jẹ́ ibi láti sọ ohun tí ó yẹ kí a kà."),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("Kékeré"),
      "ui_theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Òkùnkùn nígbà gbogbo"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("Bàìbàì"),
      "ui_theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Òkùnkùn rírọ̀, búlúù-eérú dípò dúdú"),
      "ui_theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Ìmọ́lẹ̀ nígbà gbogbo"),
      "ui_theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Tẹ̀lé ètò ìmọ́lẹ̀ tàbí òkùnkùn fóònù"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("Mú ìdènà kúrò"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("Mú ìpalọ́lọ́ kúrò"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("Ta ni ọ́"),
      "ui_verify_about_help": MessageLookupByLibrary.simpleMessage(
          "Ní ọ̀rọ̀ ara rẹ, ohun tí olùyẹ̀wò yẹ kí ó mọ̀."),
      "ui_verify_about_hint": MessageLookupByLibrary.simpleMessage(
          "Mo ń kọ nípa ẹyẹ níbí àti lórí ojúlé mi."),
      "ui_verify_add_link":
          MessageLookupByLibrary.simpleMessage("Ṣàfikún ìjápọ̀ míì"),
      "ui_verify_again":
          MessageLookupByLibrary.simpleMessage("O lè tún béèrè láti {date}."),
      "ui_verify_ask": MessageLookupByLibrary.simpleMessage("Béèrè ìjẹ́rìísí"),
      "ui_verify_before": MessageLookupByLibrary.simpleMessage("Kí o tó béèrè"),
      "ui_verify_cat_creator":
          MessageLookupByLibrary.simpleMessage("Olùdásílẹ̀"),
      "ui_verify_cat_journalist":
          MessageLookupByLibrary.simpleMessage("Oníròyìn"),
      "ui_verify_cat_org":
          MessageLookupByLibrary.simpleMessage("Àjọ tàbí àmì-ìdámọ̀"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("Nǹkan míì"),
      "ui_verify_cat_public":
          MessageLookupByLibrary.simpleMessage("Ènìyàn gbajúmọ̀"),
      "ui_verify_denied":
          MessageLookupByLibrary.simpleMessage("A kò fọwọ́ sí ìbéèrè {number}"),
      "ui_verify_done":
          MessageLookupByLibrary.simpleMessage("A ti jẹ́rìísí rẹ"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("Ṣàtúnṣe àkọọ́lẹ̀ rẹ"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("Tẹ kóòdù oní-nọ́mbà 6"),
      "ui_verify_email_resend_in": MessageLookupByLibrary.simpleMessage(
          "Tún kóòdù fi ránṣẹ́ ní ìṣẹ́jú-àáyá {seconds}"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("A fi ránṣẹ́ sí {email}"),
      "ui_verify_email_verify":
          MessageLookupByLibrary.simpleMessage("Jẹ́rìísí"),
      "ui_verify_hero":
          MessageLookupByLibrary.simpleMessage("Gba ìjẹ́rìísí lórí Kyron"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("Gba"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("ìjẹ́rìísí"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("lórí Kyron."),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "Báájì náà fi hàn pé ẹnìkan nínú ẹgbẹ́ Kyron ti ṣàyẹ̀wò pé àkọọ́lẹ̀ yìí ni ẹni tí ó sọ pé òun jẹ́. Kò fúnni ní ìdé tó pọ̀ sí i, kò sì sí fún títà."),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "Báájì náà ń dúró níwọ̀n ìgbà tí orúkọ rẹ bá dúró. Yí orúkọ rẹ padà, a ó yọ ọ́ kúrò títí ẹnìkan yóò fi ṣàyẹ̀wò tuntun."),
      "ui_verify_link_first":
          MessageLookupByLibrary.simpleMessage("Ibi tí a ti lè ṣàyẹ̀wò"),
      "ui_verify_link_more": MessageLookupByLibrary.simpleMessage("Ìjápọ̀ míì"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "Ojúlé tàbí àkọọ́lẹ̀ míì tí ó sọ pé àkọọ́lẹ̀ Kyron yìí jẹ́ tìrẹ: fi orúkọ Kyron rẹ, tàbí ìjápọ̀ sí àkọọ́lẹ̀ rẹ, síbẹ̀. Kyron kò béèrè fún ìwé ìdánimọ̀ rí."),
      "ui_verify_load_failed":
          MessageLookupByLibrary.simpleMessage("A kò lè gbé ipò rẹ jáde"),
      "ui_verify_need_ticks": MessageLookupByLibrary.simpleMessage(
          "Gbogbo ohun tí ó wà lókè gbọ́dọ̀ ní àmì kí o tó lè béèrè."),
      "ui_verify_req_age": MessageLookupByLibrary.simpleMessage(
          "Àkọọ́lẹ̀ tí ó ti tó ọjọ́ {days} ó kéré tán"),
      "ui_verify_req_bio":
          MessageLookupByLibrary.simpleMessage("Àpèjúwe tí ó sọ ẹni tí o jẹ́"),
      "ui_verify_req_name":
          MessageLookupByLibrary.simpleMessage("Orúkọ rẹ lórí àkọọ́lẹ̀"),
      "ui_verify_req_photo":
          MessageLookupByLibrary.simpleMessage("Fọ́tò àkọọ́lẹ̀"),
      "ui_verify_req_standing": MessageLookupByLibrary.simpleMessage(
          "Kò sí nǹkan lórí àkọsílẹ̀ rẹ ní ọjọ́ {days} sẹ́yìn"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage(
          "A ti fi ránṣẹ́. Ènìyàn kan yóò wò ó."),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("Láti {date}."),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("Béèrè"),
      "ui_verify_step_ask_detail": MessageLookupByLibrary.simpleMessage(
          "Ta ni ọ́, àti ìjápọ̀\ntí ó fi hàn"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("Báájì náà"),
      "ui_verify_step_badge_detail": MessageLookupByLibrary.simpleMessage(
          "Lẹ́gbẹ̀ẹ́ orúkọ rẹ,\nníbikíbi tí ó bá hàn"),
      "ui_verify_step_check":
          MessageLookupByLibrary.simpleMessage("Ènìyàn kan\nń ṣàyẹ̀wò"),
      "ui_verify_step_check_detail": MessageLookupByLibrary.simpleMessage(
          "Ẹnìkan nínú ẹgbẹ́\nń ṣí ìjápọ̀ rẹ"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("Ìjẹ́rìísí"),
      "ui_verify_waiting": MessageLookupByLibrary.simpleMessage(
          "Ìbéèrè {number} wà lọ́wọ́ ènìyàn kan"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "A fi ránṣẹ́ ní {date}, gẹ́gẹ́ bí {category}. Ìwọ yóò gba ìfitónilétí nígbà tí a bá pinnu."),
      "ui_verify_withdraw":
          MessageLookupByLibrary.simpleMessage("Fa ìbéèrè sẹ́yìn"),
      "ui_verify_withdrawn":
          MessageLookupByLibrary.simpleMessage("A ti fa ìbéèrè sẹ́yìn."),
      "ui_voice_finish_failed": MessageLookupByLibrary.simpleMessage(
          "A kò lè parí gbígbàsílẹ̀: {error}"),
      "ui_voice_limit":
          MessageLookupByLibrary.simpleMessage("Títí di ìṣẹ́jú mẹ́wàá."),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("Ó ń gbọ́…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron nílò àṣẹ láti lo gbohùngbohùn láti gbàsílẹ̀. O lè fún un nínú ètò ẹ̀rọ rẹ."),
      "ui_voice_start_failed": MessageLookupByLibrary.simpleMessage(
          "A kò lè bẹ̀rẹ̀ gbígbàsílẹ̀: {error}"),
    };

final messageLookup = MessageLookup();
