import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'tl';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Salita, parirala, o #tag"),
      "about": MessageLookupByLibrary.simpleMessage("Tungkol"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Magdagdag ng sagot"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng wika…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Sumang-ayon at magpatuloy"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("May Kyron account ka na?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Mga komento"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Iba-ibang tao, hindi bilang ng pagbukas"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Pakikilahok"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Mga like"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Wala pang manonood"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Wala pang nagbukas ng post na ito."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Nai-post"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Mga save"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Mga manonood"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("MGA MANONOOD BAWAT ARAW"),
      "and": MessageLookupByLibrary.simpleMessage("at"),
      "answerNumber": (Object a0) => "Sagot ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR lens"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Ilakip ang log ng app"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Balikang oras"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("PAG-VERIFY NG TOKEN"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Subukan ulit"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Subukan ulit"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Kapag nagsimula ka ng broadcast ngayon, mapupunta ka sa kuwartong walang makakapasok"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Magsimula ng komunidad"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Para saan ito? (opsyonal)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("ulit."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("ulit mula sa listahang ito."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Kapag isinara ito,"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("sumali muna"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("malapit na"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Nagpo-post bilang ikaw"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("mag-post sa komunidad na ito"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Ngayon lang"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Subukan ulit"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Paksa 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Para sa Iyo"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("may laman."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("papunta na roon ngayon."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", hindi"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("gumagalaw ba ako"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("I-off ang tunog"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("I-on ang tunog"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Para sa Iyo"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Mga tab mo"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Subukan ulit"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Simbolo (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("MGA MANONOOD BAWAT ARAW"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("hindi ma-load"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ang post na ito"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "May gusto kang idagdag? (opsyonal)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ang post na ito"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Mula sa isang account"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Mag-log out"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Ang account mo"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Kumpirmahin ang password"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("hindi ngayon"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Naglo-load…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Nagpo-post…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 oras ang nakalipas"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Kopyahin ang link ng story"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Ang Story Mo"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Ang account mo, ang mga post mo, at ang mga tina-tap mo para"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng paksa"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("sarili nito."),
      "authorBlocked": (Object a0) => "Na-block si ${a0}",
      "authorPostsHidden": (Object a0) =>
          "Hindi mo makikita ang mga post ni ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("I-block"),
      "blockAuthor": (Object a0) => "I-block si ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Nakopya ang detalye ng build"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Sa pagpapatuloy, sumasang-ayon ka sa"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Sa pagpapatuloy, sumasang-ayon ka sa aming Mga Tuntunin ng Serbisyo at Patakaran sa Privacy"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Sa pag-sign up, sumasang-ayon ka sa"),
      "cancel": MessageLookupByLibrary.simpleMessage("Kanselahin"),
      "change": MessageLookupByLibrary.simpleMessage("Palitan"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Palitan ang email"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "I-verify ang account mo mula sa email mo."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Tingnan kung naaabot ang Kyron"),
      "clear": MessageLookupByLibrary.simpleMessage("I-clear"),
      "close": MessageLookupByLibrary.simpleMessage("Isara"),
      "closeCommunity": (Object a0) => "Isara ang ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Isara ito"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Isara ang komunidad na ito"),
      "communities": MessageLookupByLibrary.simpleMessage("Mga komunidad"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Maghanap ng isa sa Tuklasin, o magsimula ng sarili mo."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Maghagis ng mainit na opinyon (o maligamgam)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Ano ang nasa isip mo?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Sabihin ang bagay na ikaw lang ang makapagsasabi…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "Ito na ang senyales mo: i-post mo"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Mag-type, magsalita, o mag-isip nang malakas"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Kumpirmahin ang password"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Makipag-ugnayan sa support"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Wala pang wika ang mga post, kaya hindi pa nito sinasala ang feed mo. Itatago ang mga pinili mo hanggang doon."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Magpatuloy"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Magpatuloy gamit ang email"),
      "copy": MessageLookupByLibrary.simpleMessage("Kopyahin"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Kopyahin na lang ang ulat"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Hindi mabuksan ang pag-sign in gamit ang Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Hindi nakapag-log out: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Hindi makakuha ng larawan."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Ipinapakita sa profile mo at sa ilalim ng mga post mo."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Walang bansang tumutugma sa “{query}”."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Huwag magpakita ng bansa"),
      "country_search":
          MessageLookupByLibrary.simpleMessage("Maghanap ng bansa"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Ipinapakita sa profile mo at sa ilalim ng mga post mo. Kapag nakita mo ang mga post ng isang tao, binibilang ang bansa mo sa kanyang Insights, sa mga grupo lang na lima o higit pa at hindi kailanman sa pangalan."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Mula sa settings ng phone mo"),
      "create": MessageLookupByLibrary.simpleMessage("Gumawa"),
      "createAccount":
          MessageLookupByLibrary.simpleMessage("Gumawa ng account"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Gumawa ng account mo"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Gumawa ng profile mo"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR lens"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Mag-live"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("Text post"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("Voice post"),
      "delete": MessageLookupByLibrary.simpleMessage("Burahin"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Burahin ang komentong ito?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Burahin ang post na ito?"),
      "describeAttachment": MessageLookupByLibrary.simpleMessage(
          "Ilarawan ang attachment na ito"),
      "description": MessageLookupByLibrary.simpleMessage("Paglalarawan"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("Nakopya ang DID sa clipboard"),
      "done": MessageLookupByLibrary.simpleMessage("Tapos na"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Isara ang editor pagkatapos magsulat ng kahit ano at aalukin ka ng draft."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} araw ang nakalipas"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} oras ang nakalipas"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Ngayon lang"),
      "draft_minutes_ago": MessageLookupByLibrary.simpleMessage(
          "{minutes} minuto ang nakalipas"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Wala pang naisusulat"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Poll, wala pang tanong"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Quote, wala pang teksto"),
      "drafts": MessageLookupByLibrary.simpleMessage("Mga draft"),
      "editProfile": MessageLookupByLibrary.simpleMessage("I-edit ang profile"),
      "email": MessageLookupByLibrary.simpleMessage("Email"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Mga notification sa email"),
      "explore": MessageLookupByLibrary.simpleMessage("Tuklasin"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Hindi available ang face tracking sa device na ito."),
      "feedTagDetail": (Object a0) => "Wala pang nai-post na may #${a0}.",
      "follow_author":
          MessageLookupByLibrary.simpleMessage("I-follow si {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Mga tagasunod"),
      "following": MessageLookupByLibrary.simpleMessage("Sinusundan"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Nakalimutan ang password?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Paghingi ng tulong"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Magpatuloy gamit ang Google"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Mag-sign in gamit ang Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Ibinabalik ng Google sa Kyron ang natapos na pag-sign in sa pamamagitan ng link na Android at iOS lang ang sumasagot, kaya sa ${a0} walang mapagbabalikan ang browser.\\n\\nKung may Kyron account ka na sa Google, piliin ang Magpatuloy gamit ang email gamit ang parehong address, at i-tap ang Nakalimutan ang password: makakatanggap ka ng link para magtakda ng password.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Kailangan ng phone app para sa pag-sign in gamit ang Google"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Mag-sign up gamit ang Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Mga gabay at sagot sa mga karaniwang tanong"),
      "handle": MessageLookupByLibrary.simpleMessage("handle"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Tulong at Suporta"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Help Center"),
      "home": MessageLookupByLibrary.simpleMessage("Home"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("Sa isang linya"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Ang account mo"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Buksan ang komunidad"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Sumulat ng post"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Tingnan ang post"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("I-edit ang profile mo"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("Kailan sila nandiyan"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Sa time zone mo."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Mga edad"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Mula sa {known} taong naabot na nagbigay ng kaarawan."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Mga taong naabot bawat araw"),
      "ins_communities": MessageLookupByLibrary.simpleMessage(
          "Mga komunidad na kinabibilangan nila"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Mga bansa"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Mula sa {known} taong naabot na may bansa sa kanilang profile."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Huling {days} araw"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("Hindi ma-load ang mga insight"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Mga follower"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Wala pang grupong sapat ang laki para ipakita."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Paano lumago"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Mga paksang sinusundan nila"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Mga like"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Bago"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Mga bagong follower"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Wala sa mga post mo ang nakaabot sa sinuman sa panahong ito."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Hindi ka sinusundan"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Ang mga bansa ay ang mga pinili ng mga tao sa kanilang profile. Hindi kinokolekta ng Kyron ang lungsod o kasarian ng sinuman, kaya walang maipapakita para sa mga iyon."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Mga pagbukas"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} naabot · {likes} like · {replies} sagot"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Mga taong naabot"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Isang beses lang binibilang ang bawat tao: unang beses na naipakita o nabuksan niya ang isa sa mga post mo. Sinusundan ka pa rin ng mga bagong follower; hindi binibilang ang mga nag-unfollow."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Mga sagot"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Mga repost"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Mga save"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Ipapakita kung sino ang audience mo kapag {floor} tao na ang nakakita ng mga post mo sa panahong ito. Kapag mas kaunti, puwede itong tumuro sa isang tao."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Kulang pa ang mga tao"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% sa kanila ang sumusunod na sa iyo: ang mga post mo ay kadalasang umaabot sa mga kakilala mo."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% sa kanila ang hindi ka pa sinusundan: natutuklasan ang mga post mo."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Nakaabot ka sa {reach} tao, {pct}% mas kaunti sa nakaraang panahon."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Nakaabot ka sa {reach} tao sa huling {days} araw."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Nakaabot ka sa {reach} tao, halos kapareho ng nakaraang panahon."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Walang bagong nakakita ng mga post mo sa huling {days} araw."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Nakaabot ka sa {reach} tao, {pct}% higit sa nakaraang panahon."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Nakaabot ka sa {reach} tao, {times}× ng nakaraang panahon."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Mas marami sa kanila ang sumusunod sa {name} kaysa sa ibang paksa."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Audience"),
      "ins_tab_overview":
          MessageLookupByLibrary.simpleMessage("Pangkalahatang-ideya"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Tinitingnan ng mga nakakita ng post mo ang profile mo bago sila mag-follow. Ang mukha o logo ay nagsasabing may tao roon."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng profile picture"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Sabihin sa isang linya kung tungkol saan ang mga post mo, para malaman ng estranghero kung ano ang makukuha niya sa pag-follow sa iyo."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Sumulat ng bio"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} sa {total} post mo ang walang paksa. Inilalagay ng paksa ang post sa feed ng paksang iyon at sa harap ng mga sumusunod dito."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Lagyan ng paksa ang mga post"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} tao ang sumagot sa mga post mo at sinagot mo ang {answered}. Sapat ang malasakit nila para magsulat: ginagawang suki ng isang sagot ang mambabasa."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Sagutin ang mga sagot"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Pinakaaktibo ang audience mo sa {when}. May sasalubong sa post na inilagay bago iyon."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Mag-post kapag nandiyan sila"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} taong hindi sumusunod sa iyo ang nakakita ng mga post mo, at {gained} ang nag-follow. Hayaang sabihin ng bio at mga pinakabagong post mo kung ano ang aasahan nila sa iyo."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Gawing follower ang mga mambabasa"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Isang post ang nakaabot sa {times}× ng karaniwang naaabot ng iba mong post. Tingnan kung ano ang ginawa nitong iba, at gawin pa iyon."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Gawin pa ang gumana"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Marami sa mga nakakakita ng post mo ay nasa {name}. Ang pag-post doon ay maglalagay sa iyo sa harap ng iba pa."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Mag-post sa {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Nag-post ka ng {posts} beses sa loob ng {days} araw. Bawat post ay isa pang pagkakataong matagpuan, at pinananatili ka ng tuloy-tuloy na ritmo sa feed ng mga follower mo."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Mag-post nang mas madalas"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Hindi ka nag-post sa huling {days} araw. Walang umaabot sa kahit sino kung walang post."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Mag-post ng kahit ano"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Mga insight"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("Mga nangungunang post"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Kumpara sa naunang {days} araw"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng interes"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("I-drag para ayusin"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Hanggang limang tab lang ang kasya sa bar. Mag-alis ng isa para magdagdag ng iba."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Sinusundan"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Para sa Iyo"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Lalabas dito ang mga hashtag kapag nagsimula nang gamitin ng mga tao."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Trending ngayon"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Mga video"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Mga tab mo"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
          "Mawawala ito para sa inyong dalawa."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Aalisin ito sa thread."),
      "join": MessageLookupByLibrary.simpleMessage("Sumali"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Ituloy ang pag-edit"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Nasa wika mo na ang mga screen ng Kyron. Kung may salitang mali ang dating, sabihin sa amin sa Magpadala ng feedback."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Mga wika"),
      "leave": MessageLookupByLibrary.simpleMessage("Umalis"),
      "leaveCommunity": (Object a0) => "Umalis sa ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Papasukin ulit"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 pahinang bukas"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng clip"),
      "literaladdAGif":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng hashtag"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng larawan"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng poll"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng video"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng interes"),
      "literaladdLabelAsATab": (Object a0) => "Idagdag ang ${a0} bilang tab",
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("Wika ng app"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Bersyon ng app"),
      "literalblockAuthor": (Object a0) => "I-block si ${a0}",
      "literalblockAuthor2": (Object a0) => "I-block si ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("I-block ang account na ito?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Itapon ang sagot"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("Suriin ulit"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Pumili mula sa gallery"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("I-clear ang cache"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Isara ang lahat ng pahina"),
      "literalcloseTabLabel": (Object a0) => "Isara ang ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Isara ang browser"),
      "literalcloseWidgetCommunityName": (Object a0) => "Isara ang ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Makipag-ugnayan sa suporta"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Mga wika ng nilalaman"),
      "literalcopyLink":
          MessageLookupByLibrary.simpleMessage("Kopyahin ang link"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Kopyahin ang link ng post"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Kopyahin ang teksto ng post"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("Kopyahin ang teksto"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga komunidad"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Hindi ma-load ang mga GIF"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga notification"),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga miyembro"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga post na ito"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("Hindi ma-load ang usapang ito"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang listahang ito"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("Hindi ma-load ang post na ito"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang sagot na ito"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga sikat na tag"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Hindi ma-load ang mga komunidad mo"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga mensahe mo"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Hindi mabuksan ang komunidad na ito"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("Hindi maipost ang sagot."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Hindi gumana ang paghahanap"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Hindi nakapag-log out: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} pahinang bukas",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Cover photo"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Pagtitipid ng data"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Burahin ang post"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Maghanap ng tao"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("Huwag sumagot"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Na-save ang draft"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Hindi maipadala ang feedback ngayon"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Laki ng teksto"),
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
          "Hindi pa naka-set up ang mga GIF"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Ipasa sa ibang app"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Itago ang password"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Itago ang post na ito"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Itinatago ito at hinihiling sa amin na magpakita ng mas kaunting ganito"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Paano kumilos"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Ituloy ang pagsusulat"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Hindi sumagot ang Kyron"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "Petsa ng \\${a0}",
      "literalleaveCommunityName": (Object a0) => "Umalis sa ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, face lens",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Mga ni-like na post"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Nakopya ang link"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Gawing moderator"),
      "literalmuteAuthor": (Object a0) => "I-mute si ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("I-mute ang thread na ito"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("I-mute ang mga salita o tag"),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
          "Mga naka-mute at naka-block na account"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Naka-mute. Hindi ka makakatanggap ng notification."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Walang app sa device na ito ang nagbubukas ng mga link na ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Walang browser sa device na ito ang tumanggap ng link."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Wala pang DID"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Walang draft"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Wala pang interes"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Wala pang like"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Wala pang mensahe"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Walang bagong tagasunod"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Wala pang post"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Wala pang sagot"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Wala pang repost"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Walang tumutugmang sikat na tag"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Walang nahanap na tao"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Walang inalis"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Wala pang tao rito"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Hindi interesado"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Walang nahanap"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Wala pang trending"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Wala pang laman ang log"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Walang tugma"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Walang naka-mute"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Wala pang mapapanood"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Walang hindi pa nababasa"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Ang may-ari lang ang makakapagbago nito"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Buksan ang sagot"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
          "Buksan ang email mula sa Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Password at pag-log in"),
      "literalpostInCommunityName": (Object a0) => "I-post sa ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "I-post sa ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "I-post ito na may sarili mong salita sa itaas"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Pangunahing wika"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Mga push notification"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Sinusuri…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Mag-record ng voice post"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Mag-record ulit"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Alisin bilang moderator"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Alisin sa komunidad"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Alisin sa mga naka-save"),
      "literalremoveLabel": (Object a0) => "Alisin ang ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Alisin ang ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Alisin si ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Alisin ang poll"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Alisin ang sagot na ito"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Burahin ang usapang ito"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Alisin ang poll na ito"),
      "literalreportAuthor": (Object a0) => "I-report si ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("I-report ang post"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Ipadala ulit ang code"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Mga naka-save na post"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Magsabi ng kahit ano"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Magsabi ng kahit ano sa ${a0}",
      "literalsearchFailed": MessageLookupByLibrary.simpleMessage(
          "Hindi nagtagumpay ang paghahanap"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Ipadala ulit"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "Ipadala ulit sa loob ng ${a0}s",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Magbigay ng feedback"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Ipadala ang link"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Naipadala. Iyan ang ulat #${a0}.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "Magtakda ng password at magpatuloy"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("Ibahagi ang log sa suporta"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Ibahagi ang komunidad na ito"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Ibahagi ang pahinang ito"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Ibahagi ang profile na ito"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Ibahagi…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Ibahagi nang may quote"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Magpakita pa ng ganito"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Ipakita ang password"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Ipakita ang mga resulta"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Magsimula ng komunidad"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Simulan ang pag-record"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Ihinto ang pag-load"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Huwag nang makita ang post na ito at ang mga sagot dito"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Hanay ng mga story, ${a0} item",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Palitan ang camera"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Mag-tag ng tao"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Kumuha ng larawan"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "I-tap ang banner o larawan para palitan"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("I-tap ang link sa loob nito"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "I-tap para magdagdag ng larawan at cover"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Hindi iyon gumana. Subukan ulit."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Hindi ma-load ang GIF na iyon."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Hindi mabubuksan dito ang link na ito."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Nakasara ang camera"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Ang komunidad na ito"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Wala na ang sagot na ito"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Isalin ang post"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("I-off ang tunog"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("I-on ang tunog"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Gamitin ang isa sa amin"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Naipadala ulit ang verification code."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Hindi na-verify: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("I-verify ang email"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Mga manonood, like, save, at komento"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Ano ang iniingatan ng Kyron"),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
          "Ano ang ginagawa ng app na ito"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Ano ang ginawa mo, ano ang inaasahan mo, ano ang nangyari "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Sa iyo ang ipino-post mo"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Kung naaabot ang Kyron ngayon"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Sino ang puwedeng sumagot"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Sino ang gusto mong i-tag?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Sinusundan mo na ang lahat ng sikat na tag"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Nakita mo na lahat"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("Wala ka sa anumang komunidad"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Naka-log out ka na."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Umalis ka sa ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Wala ka pang naipo-post"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Mag-load pa"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Na-clear ang log"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Nakopya ang log"),
      "logIn": MessageLookupByLibrary.simpleMessage("Mag-log in"),
      "logOut": MessageLookupByLibrary.simpleMessage("Mag-log out"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Mag-log out?"),
      "login": MessageLookupByLibrary.simpleMessage("Pag-log in"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Hindi nakapag-log in. Suriin ang credentials mo."),
      "manage": MessageLookupByLibrary.simpleMessage("Pamahalaan"),
      "menu": MessageLookupByLibrary.simpleMessage("Menu"),
      "message": MessageLookupByLibrary.simpleMessage("Mensahe"),
      "messages": MessageLookupByLibrary.simpleMessage("Mga mensahe"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "Nabasa mo na ang lahat ng usapan."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Buksan ang profile ng isang tao at i-tap ang Mensahe para magsimula ng usapan."),
      "mute": MessageLookupByLibrary.simpleMessage("I-mute"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Naka-mute at naka-block"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
          "Mga naka-mute na salita at tag"),
      "name": MessageLookupByLibrary.simpleMessage("Pangalan"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Screen ng <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Bagong email address"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Bagong password"),
      "newPost": MessageLookupByLibrary.simpleMessage("Bagong post"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Hindi ngayon"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Hindi naipadala. I-tap para subukan ulit"),
      "nothingMatchesQuery": (Object a0) =>
          "Walang tumutugma sa \"${a0}\" sa Kyron",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("Walang makokopya"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Dito napupunta ang mga like, sagot, at bagong tagasunod."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Lalabas dito ang mga taong sumusunod sa iyo."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Kapag may nag-like sa post mo, lalabas ito rito."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Dito napupunta ang mga sagot sa mga post mo."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Kapag may nag-repost sa iyo, lalabas ito rito."),
      "notifications": MessageLookupByLibrary.simpleMessage("Mga notification"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Buksan sa browser"),
      "or": MessageLookupByLibrary.simpleMessage("o"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Hindi nahanap ang pahina"),
      "password": MessageLookupByLibrary.simpleMessage("Password"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Masyadong maikli ang password"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Piliin ang mga interes mo"),
      "post": MessageLookupByLibrary.simpleMessage("I-post"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("Stats ng post"),
      "postInCommunity": (Object a0) => "I-post sa ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
          "Mag-post, magsalita, magpakita."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Nakopya ang teksto ng post"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Patakaran sa Privacy"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Na-update ang profile"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Bansa"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Display name"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Lokasyon"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("I-tap para palitan"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Website"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Mga push notification"),
      "quote": MessageLookupByLibrary.simpleMessage("I-quote"),
      "quotePost": MessageLookupByLibrary.simpleMessage("I-quote ang post"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Makipag-ugnayan sa tao"),
      "remove": MessageLookupByLibrary.simpleMessage("Alisin"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Burahin ang usapang ito?"),
      "removeMember": (Object a0) => "Alisin si ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Burahin ang mensaheng ito?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Mga sagot, follow, at pagbanggit"),
      "repliesPolicy": (Object a0) => "Mga sagot: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Sumagot"),
      "reply_anyone": MessageLookupByLibrary.simpleMessage(
          "Puwedeng sumali ang kahit sino"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Puwede pa ring makita, i-repost, at i-quote ng kahit sino ang post na ito."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Puwedeng sumagot sa post na ito ang kahit sino sa Kyron."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Mga taong sumusunod sa iyo"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Ang mga sumusunod lang sa iyo ang puwedeng sumagot sa post na ito."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Mga taong binanggit mo"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Ang mga taong @binanggit mo lang sa post na ito ang puwedeng sumagot."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Walang puwedeng sumagot"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Naka-off ang mga sagot. Puwede ka pa ring sumagot."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Sino ang puwedeng sumagot?"),
      "report": MessageLookupByLibrary.simpleMessage("I-report"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Nakopya ang ulat. I-paste ito sa email para sa suporta."),
      "reportSent":
          MessageLookupByLibrary.simpleMessage("Naipadala ang report"),
      "repost": MessageLookupByLibrary.simpleMessage("I-repost"),
      "reset": MessageLookupByLibrary.simpleMessage("I-reset"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("I-reset ang password mo"),
      "retry": MessageLookupByLibrary.simpleMessage("Subukan ulit"),
      "save": MessageLookupByLibrary.simpleMessage("I-save"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("I-save ang draft"),
      "saySomething": (Object a0) => "Magsabi ng kahit ano sa ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Maghanap"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Maghanap ayon sa pangalan o handle"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Maghanap ng komunidad"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Maghanap ng GIF"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("Maghanap ng wika"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Maghanap ng sikat na tag"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Mga alerto sa seguridad at pagbabago sa account"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Piliin ang wika ng interface ng app."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Piliin kung aling mga wika ang lalabas sa mga feed mo. Kung wala kang pipiliin, ipapakita ang lahat ng wika."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Piliin ang pangunahing wika mo para sa mga pagsasalin sa feed."),
      "send": MessageLookupByLibrary.simpleMessage("Ipadala"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Ipadala ang verification"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Magpadala ng bug report"),
      "sendFeedback":
          MessageLookupByLibrary.simpleMessage("Magpadala ng feedback"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Ipadala ang report"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Ipadala sa suporta"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("Status ng serbisyo"),
      "settings": MessageLookupByLibrary.simpleMessage("Mga setting"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Ibahagi ang log ng app sa suporta"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Mag-sign in sa Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Naka-sign in bilang"),
      "signupFailed": (Object a0) => "Hindi nakapag-sign up: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Manatili"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Bago pa lang ang Kyron, at ang pinakamabilis na paraan para maabot ang taong talagang makakaayos nito ay magbukas ng ticket. Sabihin sa amin kung ano ang ginagawa mo at ano ang nangyari."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Wala pang support inbox ang app, kaya itinuturo ka ng screen na ito sa lugar na talagang binabantayan sa halip na sa form na walang patutunguhan."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Log ng app"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Sabihin sa amin kung ano ang kulang o sira"),
      "terms": MessageLookupByLibrary.simpleMessage("Mga Tuntunin ng Serbisyo"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Teksto, boses, at video, ang mga taong gumagawa nito, at ang mga kuwartong pinag-uusapan nila."),
      "theComposerNoPostButton":
          MessageLookupByLibrary.simpleMessage("Walang Post button sa editor"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Madilim"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Laging madilim"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Malamlam"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Mas malambot na dilim, asul-abuhin sa halip na itim"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Maliwanag"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Laging maliwanag"),
      "theme_system": MessageLookupByLibrary.simpleMessage("System"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Sundin ang maliwanag o madilim na setting ng phone mo"),
      "translate": MessageLookupByLibrary.simpleMessage("Isalin"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Hindi pa naka-on ang pagsasalin. Wala pang isinasalin sa feed mo; tatandaan ito hanggang doon."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Binabago nito ang sariling mga salita ng Kyron, ang mga bahagi ng interface na si Flutter mismo ang gumuguhit, ang mga petsa at numero, at ang direksyon ng layout ng app para sa mga wikang isinusulat mula kanan pakaliwa."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Subukan ulit"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Patakaran sa Privacy"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Mga Tuntunin ng Serbisyo"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Account"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Pagkatapos"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("App at Device"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Kinopya ko ang scam para bigyan ng babala ang mga tao."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Sabihin kung bakit sa tingin mo mali ang desisyon: ano ang ibig sabihin ng post, ano ang maaaring hindi napansin ng team, o bakit hindi angkop ang patakaran. Iba ang magbabasa nito, hindi ang nagpasya."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Ang apela mo"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Sumulat ng hindi bababa sa \$count na character. Isang beses ka lang puwedeng mag-apela sa bawat desisyon."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Ipadala ang apela"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Naipadala ang apela. Makakatanggap ka ng notification kapag napagpasyahan na."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Apela sa kaso \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Hitsura"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Maliwanag, madilim, o sundin ang phone mo"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Bago"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Hindi na kayo magkikita sa Kyron, at aalisin ang mga follow sa pagitan ninyo. Hindi siya sasabihan."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Naglalaman"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Para saan ito (opsyonal)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Mga moderator lang ang makakasulat"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Para sa mga anunsyo. Lahat sa komunidad ay makakabasa at makakapag-react pa rin."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng larawan o poll"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Mga larawan at video"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Isara ang chat"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Wala nang makakabasa o makakasulat dito. Hindi na ito maibabalik."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Isara ang chat na ito?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Nakopya"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Aalisin ang mensahe para sa lahat. May itatagong kopya ang Kyron para sa pagsusuri."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Aalisin ang mensahe para sa lahat sa chat."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("I-edit ang chat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("I-edit"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("na-edit"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Ine-edit mo ang iyong mensahe"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Hindi mabuksan ang chat na ito."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Mga chat"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("Sumali sa chat"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Sumali sa komunidad para makita at makilahok sa mga chat nito."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count ang sumali"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Umalis sa chat"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Mababasa mo pa rin ito habang nasa komunidad ka."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Ang may-ari at mga moderator lang ang makakasulat dito."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("I-mute"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Walang notification mula rito, at hindi ito kasama sa bilang ng Messages."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Pangalan ng chat"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Bagong chat"),
      "ui_cchat_none": MessageLookupByLibrary.simpleMessage("Wala pang chat."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Wala pang chat. Magbukas ng isa para sa komunidad."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Hindi end-to-end encrypted ang mga chat ng komunidad. Mababasa ito ng mga moderator ng komunidad at ng Kyron."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("I-pin sa itaas"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng sagot"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Isara ang poll"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Sarado na"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Nakikita ng lahat kung ilan ang pumili sa bawat sagot, pero hindi kailanman kung sino."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Payagang pumili ng ilan"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Bagong poll"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Pumili ng isa"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("Sagot \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Poll: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Tanong"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Isang beses lang puwedeng lumabas ang bawat sagot sa poll."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Pumili ng isa o higit pa"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count ang sumagot"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Maghanap sa chat na ito"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Maghanap sa chat na ito"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Walang nahanap."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Hindi mo na makikita ang chat na ito."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Slow mode"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Gaano katagal maghihintay sa pagitan ng mga mensahe. Hindi para sa mga moderator."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 oras"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minuto"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Slow mode: isang mensahe bawat \$seconds segundo"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Naka-off"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n segundo"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Makakabasa at makakapag-react ka bilang manonood. Sumali para makasulat."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Masyado nang luma ang mensaheng iyon para maipakita."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "May napili kang masyadong malaki para maipadala kaya hindi isinama."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("I-unmute"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("I-unpin"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Mag-record ng voice note"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Ikaw"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Mga komunidad"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Para saan ito? (opsyonal)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Mga post:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Nilalaman at Display"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("Hindi ma-load ang feed mo"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga ni-like mong post"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("Hindi ma-load ang profile mo"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga naka-save mong post"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Desentralisadong ID"),
      "ui_diagnostics":
          MessageLookupByLibrary.simpleMessage("Pag-troubleshoot"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Mga grupo"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Walang grupo"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Dito nakalista ang mga grupong kinabibilangan mo at ang mga community chat na sinasalihan mo."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Hanggang \$count chat lang ang puwede mong i-pin. Mag-unpin muna ng isa."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Naka-pin"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Nagustuhan"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Naka-save"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Wala pang laman dito"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Sundan ang ilang account at lalabas dito ang mga post nila."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "Wala mula sa mga sinusundan mo"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Lalabas dito ang mga post habang isinusulat ng mga tao."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Humihina"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Hindi interesado"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Magpakita pa ng ganito"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("Inalis"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Mga signal ng feed mo"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "I-tap ang Magpakita pa ng mga post na ganito o Hindi interesado rito sa isang post, at lalabas ito rito."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Wala pa rito"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Ang sinasabi ng Ipakita pa at Hindi interesado sa mga feed mo"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Hinuhubog nito ang Home at Explore, kadalasan ayon sa paksa ng bawat post. Humihina nang kalahati ang bawat isa buwan-buwan at hindi na binibilang pagkalipas ng anim. Alisin ang isa para itigil ito ngayon."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Lalabas dito ang mga post na may clip."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Wala pang video"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Maghanap ng tao sa Kyron"),
      "ui_from_account":
          MessageLookupByLibrary.simpleMessage("Mula sa isang account"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Magdagdag ng tao"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Idagdag"),
      "ui_group_add_name": MessageLookupByLibrary.simpleMessage(
          "Magdagdag ng pangalan ng grupo"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Tanggihan"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Ang mga mensahe sa grupong ito ay end-to-end encrypted, tulad ng ibang usapan."),
      "ui_group_event_added": MessageLookupByLibrary.simpleMessage(
          "Idinagdag ni \$actor si \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "Ginawang admin ni \$actor si \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("Ginawa ni \$actor ang grupo"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "Itinakda ni \$actor na sumali ang mga bago bilang miyembro"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "Itinakda ni \$actor na sumali ang mga bago bilang manonood"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("Umalis si \$actor"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "Ginawang miyembro ni \$actor si \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "Ginawang may-ari ni \$actor si \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("Inalis ni \$actor si \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "Pinalitan ni \$actor ang pangalan ng grupo ng \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "Ginawang manonood ni \$actor si \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Hanggang \$count tao lang ang puwede sa isang grupo."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Nakataas ang kamay. Nasabihan na ang mga admin."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count ang gustong magsulat"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Gustong magsulat"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Ang mga idadagdag mamaya ay sasali bilang manonood"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Umalis sa grupo"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Mawawala ito sa listahan mo at hindi mo makikita ang sasabihin pagkatapos. May kailangang magdagdag ulit sa iyo."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Umalis sa grupong ito?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Payagang magsulat"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Ibaba ang kamay"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Gawing admin"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Gawing may-ari"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Gawing manonood"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count miyembro"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Mga miyembro"),
      "ui_group_name":
          MessageLookupByLibrary.simpleMessage("Pangalan ng grupo"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Pangalanan muna ang grupo."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Gumawa ng group chat"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Iisa ang may-ari. Mananatili kang admin."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Gawing may-ari si \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Itaas ang kamay"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Alisin sa grupo"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Alisin bilang admin"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Wala ka na sa grupong ito."),
      "ui_group_rename":
          MessageLookupByLibrary.simpleMessage("Palitan ang pangalan"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Admin"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Miyembro"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Manonood"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Bilang manonood, puwede kang magbasa at mag-react dito."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Ang mga manonood ay puwedeng magbasa, mag-react at magtaas ng kamay para humiling na magsulat."),
      "ui_group_suggested":
          MessageLookupByLibrary.simpleMessage("Iminumungkahi"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Tingnan ang profile"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("ikaw"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Manonood ka"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Tulong"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Naitala. Nakakatulong ito sa pagpili ng ipapakita sa iyo."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Sumali"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Sumali"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Wika"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Piliin ang iyong wika"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Legal"),
      "ui_like": MessageLookupByLibrary.simpleMessage("I-like"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Mga ni-like na post"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Lalabas dito ang mga post na ni-like mo, pinakabago muna."),
      "ui_link_copied":
          MessageLookupByLibrary.simpleMessage("Nakopya ang link"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Hindi mo na makikita ang mga post niya. Hindi siya sasabihan."),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage("Wala pang like"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Walang post na tumutugma sa mga filter na iyon."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Wala pang naka-save"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Na-update ang iyong account"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Tinanggap ang apela mo sa kaso \$number"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Muli naming tiningnan ang apela mo sa kaso \$number, at nananatili ang desisyon"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Permanenteng na-ban ang iyong account"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Kaso \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("ay nag-follow sa iyo"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("ay nag-like sa post mo"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("ay nag-mention sa iyo"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Wala pang mention"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Kapag isinulat ng isang tao ang iyong @handle sa isang post o reply, lalabas ito rito."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Mas luma"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Inalis ang mensahe mo sa isang community chat"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "May inalis na isang bagay na pinost mo"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Inalis ang post mo"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Inalis ang reply mo"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("ay nag-reply sa post mo"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Kumilos kami sa isang bagay na ini-report mo. Salamat sa pagsabi sa amin."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Tiningnan namin ang isang bagay na ini-report mo at hindi namin nakitang lumabag ito sa aming mga patakaran."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Ini-report dahil sa: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("ay nag-repost ng post mo"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Binawi namin ang desisyon sa kaso \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Suspendido ang iyong account"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Suspendido ang iyong account hanggang \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Lahat"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Mga follow"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Mga like"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Mga mention"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Mga reply"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Ngayong linggo"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Ngayong araw"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("May babala ang iyong account"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Kahapon"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Tapos na"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Laktawan"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Nabuksan na ito."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Nag-expire"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Hindi ito mabuksan."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Isang beses lang mabubuksan, saka buburahin sa Kyron."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Isang beses tingnan"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Nabuksan"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "Binuksan ng \$count sa \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Ang mga pinadalhan mo lang ang makakabukas nito, isang beses."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Ipadala para isang beses makita"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("I-tap para makita"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("I-pause"),
      "ui_play": MessageLookupByLibrary.simpleMessage("I-play"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Aalisin ito sa profile mo at sa feed ng lahat. Kasama nitong mawawala ang mga sagot dito."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Nabura ang post"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Nakatago ang post"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Nakopya ang teksto ng post"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Nai-post sa pagitan ng"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Nakatago. Magpapakita kami ng mas kaunting ganito."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Mga kagustuhan"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "May gusto ka pang idagdag? (opsyonal)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Makakatanggap ka ng notification kapag nagpasya ang team, at masusubaybayan mo ito sa Mga report mo."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Kung ayaw mo na ring makita ang taong ito, puwede mo siyang i-mute o i-block mula sa parehong menu."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Hindi nadaragdagan ang bigat kapag dalawang beses mong ini-report ang parehong bagay: isang report lang bawat tao ang itinatago namin."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Hindi ibinabahagi ang report mo sa taong iyon. Nagtatago kami ng kopya ng ini-report mo para masuri pa rin ito kahit mabura."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Natanggap na ang report mo at naghihintay itong masuri. Hindi namin sinasabi sa taong iyon kung sino ang nag-report."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Tingnan ang mga report mo"),
      "ui_report_tell_us": MessageLookupByLibrary.simpleMessage(
          "Sabihin sa amin kung ano ang mali"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Salamat sa pagsabi sa amin"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Ano ang mali kay \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Ano ang mali sa mensaheng ito?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("Ano ang mali sa post na ito?"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("Ano ang mali sa reply na ito?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Isang mensahe sa community chat"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Isang post"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Isang reply"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("May aksyong ginawa"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("Isang account"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Napagpasyahan \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Walang nilabag na patakaran"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga report mo"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Ang mga ini-report mo sa nakalipas na 90 araw, at kung ano ang kinahinatnan. Makakatanggap ka ng notification kapag nagpasya ang team. Hindi kailanman sinasabi sa ini-report mo kung sino ang nag-report."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Walang ini-report"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kapag nag-report ka ng post, reply, mensahe o account, nakalista ito rito kasama ang kinahinatnan."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("Sinusuri"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Ini-report \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Ang mga ini-report mo, at ang kinahinatnan"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Mga report mo"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Kaligtasan ng bata"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Anumang naglalagay sa panganib o nagseseksuwalisa sa isang menor de edad."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Tinutukang pang-aabuso, pagbabanta, o hindi gustong pakikipag-ugnayan."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Pag-atake sa mga tao dahil sa kung sino sila."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Pagbebenta o pag-promote ng ilegal na bagay."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Pagpapanggap bilang ibang tao."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Ginagamit ang gawa o trademark mo nang walang pahintulot."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Mapanlinlang na pahayag tungkol sa kalusugan, eleksyon, o mga pangyayari."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Paghikayat o pagpapakita ng pananakit sa sarili."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Sekswal na content na ipinapakita nang walang babala."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Wala sa mga nabanggit. Sabihin sa amin kung ano ang mali."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Paulit-ulit, mapanlinlang, o hindi gustong pag-promote."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Pagbabanta, pagluluwalhati, o pag-uudyok ng karahasan."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Panliligalig o pambu-bully"),
      "ui_rule_hate":
          MessageLookupByLibrary.simpleMessage("Mapoot na pananalita"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Ilegal na produkto o serbisyo"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Pagpapanggap"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Intelektwal na ari-arian"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Maling impormasyon"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Pagpapakamatay o pananakit sa sarili"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Pang-adultong nilalaman"),
      "ui_rule_something_else": MessageLookupByLibrary.simpleMessage("Iba pa"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spam"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Karahasan o pagbabanta"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Mga naka-save na post"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "I-tap ang archive icon ng post para itago ito rito. Ikaw lang ang nakakakita ng mga naka-save mo."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Maghanap ayon sa handle o display name."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("I-clear"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Hanapin ang lahat ng nai-post"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Mga filter"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("Maghanap ng tao"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Maghanap ng post"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Mga setting"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("App at Device"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Nilalaman at Display"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Pagtitipid ng data"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Ibahagi ang iniisip mo"),
      "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage(
          "Mag-browse ng mga artikulo ng tulong"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Piliin ang wika mo"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Sino ang na-mute o na-block mo"),
      "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
          "Mga kagustuhan sa notification"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Ang profile at contact details mo"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Kailangan mong mag-sign in ulit para makabalik sa account mo."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Mga setting sa seguridad"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Kumpirmahin ang password"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("Sa isang linya"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Bagong email address"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Bagong password"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Ano ang nangyari"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "Humingi ng tulong sa aming team"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Ibahagi"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("I-quote"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Ipadala sa mensahe"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Sa mga tao sa Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Ibahagi ang post na ito"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Tungkol saan ito"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Permanenteng na-ban ang account mo"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Ang sagot, noong \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Apela"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Mag-apela sa desisyong ito"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Hindi na puwedeng iapela ang desisyong ito. Kung may mali, makipag-ugnayan sa support."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Sinusuri ang apela"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Tinanggap ang apela"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "May ibang tao sa team na muling sumusuri nito. Makakatanggap ka ng notification kapag napagpasyahan na."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Kung sa tingin mo ay pagkakamali ito, puwede kang humiling ng muling pagsusuri hanggang \$date. Ibang tao sa team ang magpapasya."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Inapela: nananatili ang desisyon"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Kaso \$number. Patakaran: \$rule. Isinulat ng team:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Hindi naaalis ang ban kapag binura mo ang account mo: naka-ban din agad ang bagong account na may parehong email address."),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("Na-ban"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Itong page, mga apela, support, at pagbura ng account mo na lang ang gumagana."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Puwedeng iapela"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Kaso \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Napagpasyahan noong \$date"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "Mga desisyon tungkol sa account mo"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Burahin ang account mo"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Tingnan ang detalye"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "Tingnan ang detalye at mag-apela"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Matatapos sa \$date"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "Maayos ang katayuan ng account mo"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Walang naglilimita rito."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang status ng account"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Inalis ang mensahe"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Walang napagpasyahan tungkol sa account mo. Kung may alisin man ang team na sa iyo o limitahan ang account mo, makikita ito rito kasama ang dahilan, at puwede kang mag-apela."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Walang dapat iapela: binawi ang desisyon."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Inalis ang post"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Hilahin pababa para tingnan ulit."),
      "ui_standing_read_rules": MessageLookupByLibrary.simpleMessage(
          "Basahin ang mga patakaran ng Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Inalis ang reply"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Binawi"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Binawi noong \$date. Naibalik ang lahat ng inalis, at wala nang limitasyong umiiral."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Patakaran: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("Mag-sign out"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Suspendido"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Puwede kang magbasa, pero hindi puwedeng mag-post, mag-reply, mag-follow, o magpadala ng mensahe. Gumagana pa rin ang pag-report, pag-block, at pag-mute."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Suspendido ang account mo: puwede kang magbasa, pero hindi mag-post."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Suspendido hanggang \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Suspendido ang account mo hanggang \$date: puwede kang magbasa, pero hindi mag-post."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Ang isinulat ng team"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Status ng account"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Babala"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Bakit?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Isinulat mo, noong \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Ang mensahe mo"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Ang post mo"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Ang reply mo"),
      "ui_terms":
          MessageLookupByLibrary.simpleMessage("Mga Tuntunin ng Serbisyo"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ang post na ito"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Naka-mute ang thread"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Subukan ulit"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("I-off ang tunog"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("I-on ang tunog"),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
          "Hindi bababa sa dalawang character."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("I-undo"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Mga salita, o filter: account, saklaw ng petsa, o laman ng post."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("I-undo ang repost"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("I-update ang password"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Gumamit ng ibang address"),
      "username": MessageLookupByLibrary.simpleMessage("Username"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Dapat maliliit na titik ang username (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Ilakip"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Handa nang ilakip"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Mag-record ng voice post"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Sine-save…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Ihinto"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Ano ang nangyari"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Ano ang nangyari, at ano ang dapat naming tingnan?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Ano ang nasa larawang ito?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Para saan ito? (opsyonal)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Ano ang ginawa mo, ano ang inaasahan mo, ano ang nangyari"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Ano ang ginagawa mo nang mangyari ito."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Sumagot ka"),
      "dmReplied": (Object a0) => "Sumagot si $a0",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Idagdag sa mensahe"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Bagong mensahe"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Wala pang nasasabi. Magandang simula ang pagkaway."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Kumaway"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Mga bagong mensahe"),
      "dmTyping": (Object a0) => "Nagta-type si $a0",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Alisin ang iyong reaksyon"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Isang tao"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Mensahe"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("Kalakip"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Hindi mababasa ang mensaheng ito sa device na ito."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Hinihintay ang mensaheng ito. Maaaring matagalan ito."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Naka-encrypt na mensahe"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Naka-end-to-end encrypt ang mga mensahe"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Hindi naka-end-to-end encrypt"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Naipadala"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Nakita"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Ipinapadala…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Kumuha ng litrato"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Iba pang opsyon"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("I-save sa device"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Ibahagi"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Sine-save…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Na-save sa iyong mga larawan"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Hindi ito ma-save. Subukang muli."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Payagan ang Kyron na magdagdag sa iyong mga larawan para ma-save ito."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Gumagana ang lahat ng sistema"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Accessibility"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Huling 60 araw"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 araw na ang nakalipas"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Ngayon"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Database"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Pag-sign in"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Mga kamakailang insidente"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Walang insidente sa huling 60 araw."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Nagpapatuloy"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Walang data"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Mga detalye"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Sinusuri ng Kyron ang sarili nito bawat 5 minuto habang tumatakbo. Walang pagsusuri ang araw na kulay abo."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Hindi pa available ang kasaysayan ng uptime."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "May problema ang ilang sistema"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Mag-record ng voice note"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Handa nang ipadala"),
      "ui_dm_quote_gone": MessageLookupByLibrary.simpleMessage(
          "Wala na rito ang mensaheng iyon."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Pumunta sa mensahe"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("Voice note"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Nagustuhan ng may-akda"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Magdagdag ng larawan o clip"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Media"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Mga voice note"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Wallpaper"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("I-mute ang mga notification"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Huwag nang makatanggap ng notification tungkol sa usapang ito"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Hindi ka na nila mapapadalhan ng mensahe"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Wala"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Larawan"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("Na-unmute na."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Hindi ito maalis. Subukang muli."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profile"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("I-unmute"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Lalabas dito ang mga larawan at clip na ibinabahagi mo."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Tingnan lahat"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Mga larawan at clip"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Ganito ang magiging hitsura ng chat mo."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Maganda."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Ulap"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Takipsilim"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Sage"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Buhangin"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Tuldok"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Ilapat"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Kasalukuyan"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Ipadala nang walang preview"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Maghanap"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("I-post"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Sumulat ng mensahe…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Ipadala"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Naipadala"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "Naipadala, pero hindi sa lahat."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Hindi ito maipadala. Subukang muli."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Tagasunod"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Salain"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Lahat"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Hindi pa nababasa"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Hindi pa nasasagot"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Nakatago"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Walang nakatago"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ang mga usapang inalis mo sa listahan ay naghihintay dito, kung sakaling gusto mo silang ibalik."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Lilipat ito sa Nakatago. Mananatili sa kabila ang kanila, at babalik ito kapag may sumulat ulit sa inyo."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Ibalik"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Nasa listahan mo na ulit."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Walang tumutugmang usapan."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Walang naghihintay sa iyo"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Bawat usapan ay nagtatapos sa salita mo."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Larawan"),
      "ui_dm_preview_photos":
          MessageLookupByLibrary.simpleMessage("Mga larawan"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Wala pang mensahe"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Ikaw:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Kahapon"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Mga mensahe"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Mga setting ng mensahe"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Mga read receipt"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Kapag naka-off ito, hindi makikita ng iba kung kailan mo nabasa ang mga mensahe nila, at hindi mo rin makikita kung kailan nila nabasa ang sa iyo."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Ipakita kapag nagta-type ka"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Nakikita ng sinusulatan mo na nagsusulat ka."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Mga preview ng link"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Binubuksan ng iyong telepono ang link na ipinapadala mo para gawin ang preview nito, kaya nakikita ng site ang hiling ng iyong telepono. Hindi kailanman nakikita ng server ng Kyron ang link."),
      "ui_dm_settings_notifications": MessageLookupByLibrary.simpleMessage(
          "Mga notification para sa mensahe"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Naka-end-to-end encrypt ang mga mensahe. Hindi ito mababasa ng Kyron, at walang anumang dito na magbabago niyon."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Para kay:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Kamakailan"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Mga tao"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Walang may ganoong pangalan."),
      "ui_push_test": MessageLookupByLibrary.simpleMessage(
          "Magpadala ng test na notification"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Hindi pa naka-set up ang server ng Kyron para magpadala ng mga notification, kaya walang makakarating. Nasa amin ang problema, hindi sa iyong telepono."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Hindi naka-rehistro ang teleponong ito para sa mga notification. Tingnan kung pinapayagan ang mga notification ng Kyron sa mga setting ng iyong telepono, saka subukan ulit."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Hindi maihatid ang notification sa teleponong ito. Subukan ulit pagkalipas ng isang minuto."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Naipadala na. Dapat itong dumating sa loob ng ilang segundo."),
      "ui_push_working": MessageLookupByLibrary.simpleMessage(
          "Gumagana ang mga notification."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Wala pang post"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Bagong komunidad"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Pangalan"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Ang address nito ay mula sa pangalan."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Makikita ito ng mga tao sa"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Ikaw ang may-ari nito. Puwedeng magdagdag ng larawan, banner at mga moderator mula sa page nito kapag nagawa na."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Home"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Mga post ng komunidad sa Home"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Lumalabas din sa Home ang mga post mula sa mga komunidad mo. Kapag naka-off, mananatili sila rito sa Mga Komunidad, kung saan ipinapakita ng bawat isa kung ano ang bago."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Ang listahan mo"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Bilang ng bagong post"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Ipakita kung ilang post ang bago sa bawat komunidad mula nang huli mo itong buksan."),
      "ui_community_settings_running": MessageLookupByLibrary.simpleMessage(
          "Mga komunidad na pinapatakbo mo"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Nakalista rito ang mga komunidad na sinimulan o mino-moderate mo."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("May-ari"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderator"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Mga bagong post"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Pinapatakbo mo"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Mga setting ng komunidad"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Tuklasin"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Walang tumutugmang komunidad."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Walang bago"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ang bawat komunidad ay gaya ng iniwan mo."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Wala ka pang pinapatakbo"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Wala nang masasalihan"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kasali ka na sa bawat komunidad sa Kyron. Magsimula ng isa pa."),
      "ui_community_discover_search_detail": MessageLookupByLibrary.simpleMessage(
          "Sumubok ng ibang salita, o magsimula ng komunidad na may ganoong pangalan."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Sumulat ng post"),
      "ui_community_members":
          MessageLookupByLibrary.simpleMessage("Mga miyembro:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Na-post na"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Tingnan"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Buksan"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Online"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Ipakita kapag online ka"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Nakikita ng mga kausap mo ang berdeng tuldok habang bukas ang Kyron mo. Kapag naka-off ito, hindi mo rin makikita ang sa kanila."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Maghanap ng mga tao at post"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Mga komunidad na puwedeng salihan"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Wala pang makikita"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Dito lalabas ang mga larawan at clip na ipino-post ng mga tao."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("I-follow"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("I-delete ang account"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Permanente nitong ide-delete ang iyong Kyron account. Hindi na ito maibabalik."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Ang iyong profile, mga post, sagot, like at repost"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Ang iyong mga mensahe, kasama ang mga ipinadala mo sa iba, at ang mga larawan at voice note sa mga ito"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Ang iyong mga follower, ang mga taong fina-follow mo, at ang iyong mga setting"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Ang mga komunidad na sinimulan mo ay mapupunta sa pinakamatagal na moderator o miyembro. Isasara ang komunidad na wala nang ibang tao."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("I-delete ang iyong account?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Hindi mo na mababawi ang alinman dito."),
      "ui_delete_account_done": MessageLookupByLibrary.simpleMessage(
          "Na-delete na ang iyong account."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Na-delete na account"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Na-delete na ang account na ito, kaya hindi na makakapagpadala ng mensahe rito."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Nag-sign up gamit ang Google? Gamitin na lang ang “Sign in with Google”."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang lens na iyon."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Hindi ma-record ang video."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Hindi maidagdag ang lens sa video na ito, kaya ipo-post ito kung paano kinunan."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Nasa pinakamaraming attachment na ang post mo."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Idinadagdag ang lens mo…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Flash"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("Mag-record ng video"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Larawan"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Video"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Kinansela ang pag-sign in sa Google."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("MGA REGALO"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Wala pang nagpadala ng regalo sa post na ito."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Regalo"),
      "analytics_gifts_label":
          MessageLookupByLibrary.simpleMessage("Mga regalo"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Mga coin"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Nagpadala"),
      "analytics_senders":
          MessageLookupByLibrary.simpleMessage("Mga nagpadala"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Mga test coin: hindi pa maaaring i-withdraw."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Naka-save"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Mga post"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Mga komento"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Tingnan ang iba pang sagot"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Na-edit"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Iba pa"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Sinusundan"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Nangunguna"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Pinakabago"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage(
          "Ayusin ang mga komento: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "nagpadala ng regalo sa post mo"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "nagpadala ng \$gift sa komento mo"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "nagpadala ng \$gift sa post mo"),
      "ui_gift_title":
          MessageLookupByLibrary.simpleMessage("Magpadala ng regalo"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("I-edit ang post"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Maaari mo itong i-edit nang \$n min pa"),
      "ui_save": MessageLookupByLibrary.simpleMessage("I-save"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Wala pang nai-post sa ilalim ng #\$tab."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Pumili ng regalo"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Kulang ang coin"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Mga test coin: hindi mabibili at walang halagang pera."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Mapupunan sa \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 barya"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count coin"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("Mayroon kang \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Ipadala ang \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("Naipadala ang \$gift"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Subukang muli"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "Sa loob ng 15 minuto pagkatapos mag-post"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Na-edit"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang mga na-save mong komento"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Walang naka-save na komento"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "I-tap ang archive icon sa ilalim ng komento para itago ito rito. Ikaw lang ang nakakakita ng sine-save mo."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Sumasagot kay \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Kopyahin"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Hanapin"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Piliin lahat"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count regalo"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 regalo"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load ang iba pang post."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Mga paalala"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Ano ang bago pagkatapos mong mawala, at kapag bumalik ang mga coin mo. Hindi hihigit sa isa bawat araw."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Mga regalo"),
      "ui_gifts_from_one":
          MessageLookupByLibrary.simpleMessage("mula sa 1 tao"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("mula sa \$count tao"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("Nangungunang nagregalo"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Hindi ma-load kung sino ang nagpadala ng regalo."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Ano ang bago"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Sige"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Salamat. Binabasa namin ang bawat sagot."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Kumusta ang Kyron sa ngayon?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Araw \$day ng iyong test. Sapat na ang isang tap."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "May dapat ba kaming ayusin o idagdag? (opsyonal)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Ipadala"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Hindi ngayon"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Pindutin muli ang back para umalis sa Kyron"),
    };

final messageLookup = MessageLookup();
