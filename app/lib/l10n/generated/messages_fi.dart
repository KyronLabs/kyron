import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fi';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Sana, lause tai #tunniste"),
      "about": MessageLookupByLibrary.simpleMessage("Tietoja"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Lisää vastaus"),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage("Lisää kieliä…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Hyväksy ja jatka"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Onko sinulla jo Kyron-tili?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Kommentit"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage("Eri ihmiset, ei avauskertoja"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Sitoutuminen"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Tykkäykset"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Ei vielä katsojia"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Kukaan ei ole vielä avannut tätä julkaisua."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Julkaistu"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Tallennukset"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Katsojat"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("KATSOJIA PÄIVÄSSÄ"),
      "and": MessageLookupByLibrary.simpleMessage("ja"),
      "answerNumber": (Object a0) => "Vastaus ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR-linssi"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Liitä järjestelmäloki"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Edestakainen viive"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("TUNNUKSEN VAHVISTUS"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Yritä uudelleen"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Yritä uudelleen"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Lähetyksen aloittaminen nyt veisi sinut huoneeseen, johon kukaan ei voisi"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Perusta yhteisö"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage(
              "Mihin se on tarkoitettu? (valinnainen)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("takaisin sisään."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage(
              "takaisin sisään tästä luettelosta."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Sen sulkeminen"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("liity ensin"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("tulossa pian"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Julkaiset omana itsenäsi"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("julkaise tässä yhteisössä"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Juuri nyt"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Yritä uudelleen"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Aihe 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Sinulle"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("on jotain."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("matkalla sinne nyt."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", ei"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("liikunko"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Ääni pois"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Ääni päälle"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Sinulle"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Välilehtesi"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Yritä uudelleen"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Symboli (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("KATSOJIA PÄIVÄSSÄ"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("ei voitu ladata"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("tämä julkaisu"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("Lisättävää? (valinnainen)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("tämä julkaisu"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Tililtä"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Kirjaudu ulos"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Tilisi"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Vahvista salasana"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("ei nyt"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Ladataan…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Julkaistaan…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 t sitten"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Kopioi tarinan linkki"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Tarinasi"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Tilisi, julkaisusi ja se, mitä napautat, jotta"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Lisää aihe"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("itsestään."),
      "authorBlocked": (Object a0) => "${a0} estetty",
      "authorPostsHidden": (Object a0) => "Et näe julkaisuja käyttäjältä ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Estä"),
      "blockAuthor": (Object a0) => "Estetäänkö ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Koontiversion tiedot kopioitu"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Jatkamalla hyväksyt"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Jatkamalla hyväksyt käyttöehtomme ja tietosuojakäytäntömme"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Rekisteröitymällä hyväksyt"),
      "cancel": MessageLookupByLibrary.simpleMessage("Peruuta"),
      "change": MessageLookupByLibrary.simpleMessage("Vaihda"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Vaihda sähköposti"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Vahvista tilisi sähköpostistasi."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Tarkista, onko Kyron tavoitettavissa"),
      "clear": MessageLookupByLibrary.simpleMessage("Tyhjennä"),
      "close": MessageLookupByLibrary.simpleMessage("Sulje"),
      "closeCommunity": (Object a0) => "Suljetaanko ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Sulje se"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Sulje tämä yhteisö"),
      "communities": MessageLookupByLibrary.simpleMessage("Yhteisöt"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Löydä sellainen Löydöistä tai perusta oma."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Heitä kuuma mielipide (tai haalea)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Mitä päässäsi pyörii?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Sano jotain, mitä vain sinä voit sanoa…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("Tämä on merkkisi: lähetä se"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Kirjoita, puhu tai ajattele ääneen"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Vahvista salasana"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Ota yhteyttä tukeen"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Julkaisuilla ei vielä ole kieltä, joten tämä ei vielä suodata syötettäsi. Valintasi säilytetään siihen asti."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Jatka"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Jatka sähköpostilla"),
      "copy": MessageLookupByLibrary.simpleMessage("Kopioi"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Kopioi raportti sen sijaan"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google-kirjautumista ei voitu avata. ${a0}",
      "couldNotSignOut": (Object a0) => "Uloskirjautuminen epäonnistui: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("Kuvaa ei voitu ottaa."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Näkyy profiilissasi ja julkaisujesi alla."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Mikään maa ei vastaa hakua ”{query}”."),
      "country_none": MessageLookupByLibrary.simpleMessage("Älä näytä maata"),
      "country_search": MessageLookupByLibrary.simpleMessage("Hae maita"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Näkyy profiilissasi ja julkaisujesi alla. Kun näet jonkun julkaisuja, maasi lasketaan mukaan hänen Tilastoihinsa, vain vähintään viiden hengen ryhminä eikä koskaan nimellä."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Puhelimesi asetuksista"),
      "create": MessageLookupByLibrary.simpleMessage("Luo"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Luo tili"),
      "createYourAccount": MessageLookupByLibrary.simpleMessage("Luo tilisi"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Luo profiilisi"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR-linssi"),
      "create_go_live":
          MessageLookupByLibrary.simpleMessage("Aloita suora lähetys"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Tekstijulkaisu"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("Äänijulkaisu"),
      "delete": MessageLookupByLibrary.simpleMessage("Poista"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Poistetaanko tämä kommentti?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Poistetaanko tämä julkaisu?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Kuvaile tätä liitettä"),
      "description": MessageLookupByLibrary.simpleMessage("Kuvaus"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID kopioitu leikepöydälle"),
      "done": MessageLookupByLibrary.simpleMessage("Valmis"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Sulje editori, kun olet kirjoittanut jotain, niin sinulle tarjotaan luonnosta."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} päivää sitten"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} tuntia sitten"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Juuri nyt"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} minuuttia sitten"),
      "draft_nothing_empty": MessageLookupByLibrary.simpleMessage(
          "Mitään ei ole vielä kirjoitettu"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Kysely, vielä ilman kysymystä"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Lainaus, vielä ilman tekstiä"),
      "drafts": MessageLookupByLibrary.simpleMessage("Luonnokset"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Muokkaa profiilia"),
      "email": MessageLookupByLibrary.simpleMessage("Sähköposti"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Sähköposti-ilmoitukset"),
      "explore": MessageLookupByLibrary.simpleMessage("Tutki"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Kasvojen seuranta ei ole käytettävissä tässä laitteessa."),
      "feedTagDetail": (Object a0) =>
          "Tunnisteella #${a0} ei ole vielä julkaistu mitään.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Seuraa: {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Seuraajat"),
      "following": MessageLookupByLibrary.simpleMessage("Seuratut"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Unohditko salasanan?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Avun saaminen"),
      "googleContinue": MessageLookupByLibrary.simpleMessage("Jatka Googlella"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Kirjaudu Googlella"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google palauttaa valmiin kirjautumisen Kyroniin linkillä, johon vastaavat vain Android ja iOS, joten alustalla ${a0} selaimella ei olisi minne palauttaa sitä.\\n\\nJos sinulla on jo Kyron-tili Googlen kautta, valitse Jatka sähköpostilla samalla osoitteella ja napauta Unohditko salasanan: saat linkin salasanan asettamiseen.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Google-kirjautuminen vaatii puhelinsovelluksen"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Rekisteröidy Googlella"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Oppaita ja vastauksia yleisiin kysymyksiin"),
      "handle": MessageLookupByLibrary.simpleMessage("käyttäjänimi"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("Ohje ja tuki"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Ohjekeskus"),
      "home": MessageLookupByLibrary.simpleMessage("Koti"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("Yhdellä rivillä"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Tilisi"),
      "ins_act_community": MessageLookupByLibrary.simpleMessage("Avaa yhteisö"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Kirjoita julkaisu"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Katso julkaisu"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Muokkaa profiiliasi"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("Milloin he ovat paikalla"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Omalla aikavyöhykkeelläsi."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Iät"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Niistä {known} tavoitetusta, jotka ovat antaneet syntymäpäivän."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Tavoitetut ihmiset päivittäin"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Yhteisöt, joissa he ovat"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Maat"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Niistä {known} tavoitetusta, joilla on profiilissaan maa."),
      "ins_days":
          MessageLookupByLibrary.simpleMessage("Viimeiset {days} päivää"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("Tilastoja ei voitu ladata"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Seuraajat"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Mikään ryhmä ei ole vielä tarpeeksi suuri näytettäväksi."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Miten kasvaa"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Aiheet, joita he seuraavat"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Tykkäykset"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Uusi"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Uudet seuraajat"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Mikään julkaisusi ei tavoittanut ketään tällä jaksolla."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Eivät seuraa sinua"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Maat ovat niitä, jotka ihmiset ovat valinneet profiiliinsa. Kyron ei kerää kenenkään kaupunkia tai sukupuolta, joten niistä ei ole mitään näytettävää."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Avaukset"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} tavoitettu · {likes} tykkäystä · {replies} vastausta"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Tavoitetut ihmiset"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Jokainen ihminen lasketaan kerran: hänelle näytettiin tai hän avasi jonkin julkaisusi ensimmäistä kertaa. Uudet seuraajat seuraavat sinua yhä; seuraamisen lopetuksia ei lasketa."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Vastaukset"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Jaot"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Tallennukset"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Kuka yleisösi on, näytetään, kun {floor} ihmistä on nähnyt julkaisusi tällä jaksolla. Vähemmällä se voisi osoittaa jonkun."),
      "ins_small_title": MessageLookupByLibrary.simpleMessage(
          "Ihmisiä ei ole vielä tarpeeksi"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct} % heistä seuraa sinua jo: julkaisusi tavoittavat enimmäkseen sinut tuntevia."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct} % heistä ei vielä seuraa sinua: julkaisusi löydetään."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Tavoitit {reach} ihmistä, {pct} % vähemmän kuin edellisellä jaksolla."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Tavoitit {reach} ihmistä viimeisten {days} päivän aikana."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Tavoitit {reach} ihmistä, suunnilleen saman verran kuin edellisellä jaksolla."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Kukaan uusi ei nähnyt julkaisujasi viimeisten {days} päivän aikana."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Tavoitit {reach} ihmistä, {pct} % enemmän kuin edellisellä jaksolla."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Tavoitit {reach} ihmistä, {times}× edellisen jakson verran."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Useampi heistä seuraa aihetta {name} kuin mitään muuta aihetta."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Yleisö"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Yleiskatsaus"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Julkaisusi löytäneet katsovat profiiliasi ennen seuraamista. Kasvot tai logo kertovat, että siellä on joku."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Lisää profiilikuva"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Kerro yhdellä rivillä, mistä julkaiset, jotta vieras tietää, mitä seuraaminen hänelle antaa."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Kirjoita esittely"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without}/{total} julkaisustasi oli ilman aihetta. Aihe vie julkaisun aiheen syötteeseen ja sen seuraajien eteen."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Lisää julkaisuihin aiheita"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} ihmistä vastasi julkaisuihisi ja sinä vastasit {answered}. He välittivät tarpeeksi kirjoittaakseen: vastaus tekee lukijasta vakiokävijän."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Vastaa vastauksiin"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Yleisösi on aktiivisimmillaan {when}. Juuri ennen sitä tehty julkaisu saa vastaanottajia."),
      "ins_tip_best_time_t": MessageLookupByLibrary.simpleMessage(
          "Julkaise, kun he ovat paikalla"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} sinua seuraamatonta näki julkaisusi, ja {gained} alkoi seurata. Anna esittelysi ja uusimpien julkaisujesi kertoa, mitä sinulta voi odottaa."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("Tee lukijoista seuraajia"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Yksi julkaisu tavoitti {times}× enemmän ihmisiä kuin muut julkaisusi yleensä. Katso, mitä se teki toisin, ja tee sitä enemmän."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Tee enemmän sitä, mikä toimi"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Moni julkaisujesi näkijä on yhteisössä {name}. Siellä julkaiseminen vie sinut muidenkin eteen."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Julkaise yhteisössä {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Julkaisit {posts} kertaa {days} päivässä. Jokainen julkaisu on uusi mahdollisuus tulla löydetyksi, ja tasainen rytmi pitää sinut seuraajiesi syötteissä."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Julkaise useammin"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Et ole julkaissut viimeisten {days} päivän aikana. Ilman julkaisua mikään ei tavoita ketään."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Julkaise jotain"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Tilastot"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("Parhaat julkaisut"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Verrattuna edellisiin {days} päivään"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Lisää kiinnostuksen kohde"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Järjestä vetämällä"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Palkkiin mahtuu enintään viisi välilehteä. Poista yksi lisätäksesi toisen."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Seuratut"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Sinulle"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Aihetunnisteet ilmestyvät tänne, kun ihmiset alkavat käyttää niitä."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Suosittua nyt"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Videot"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Välilehtesi"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Se katoaa teiltä molemmilta."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Se poistetaan ketjusta."),
      "join": MessageLookupByLibrary.simpleMessage("Liity"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Jatka muokkaamista"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyronin näkymät ovat sinun kielelläsi. Jos jokin sana kuulostaa väärältä, kerro siitä kohdassa Lähetä palautetta."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Kielet"),
      "leave": MessageLookupByLibrary.simpleMessage("Poistu"),
      "leaveCommunity": (Object a0) => "Poistutaanko ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Päästä takaisin"),
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("1 sivu auki"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Lisää leike"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Lisää GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Lisää aihetunniste"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Lisää kuva"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Lisää kysely"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Lisää video"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Lisää kiinnostuksen kohde"),
      "literaladdLabelAsATab": (Object a0) => "Lisää ${a0} välilehdeksi",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Sovelluksen kieli"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Sovelluksen versio"),
      "literalblockAuthor": (Object a0) => "Estä ${a0}",
      "literalblockAuthor2": (Object a0) => "Estetäänkö ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Estetäänkö tämä tili?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Peru vastaus"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Tarkista uudelleen"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Valitse galleriasta"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Tyhjennä välimuisti"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Sulje kaikki sivut"),
      "literalcloseTabLabel": (Object a0) => "Sulje ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Sulje selain"),
      "literalcloseWidgetCommunityName": (Object a0) => "Suljetaanko ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Ota yhteyttä tukeen"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Sisällön kielet"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Kopioi linkki"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Kopioi julkaisun linkki"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Kopioi julkaisun teksti"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Kopioi teksti"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("Yhteisöjä ei voitu ladata"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF-kuvia ei voitu ladata"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("Ilmoituksia ei voitu ladata"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("Jäseniä ei voitu ladata"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Näitä julkaisuja ei voitu ladata"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Tätä keskustelua ei voitu ladata"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Tätä luetteloa ei voitu ladata"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Tätä julkaisua ei voitu ladata"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Tätä vastausta ei voitu ladata"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Suosittuja tunnisteita ei voitu ladata"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage("Yhteisöjäsi ei voitu ladata"),
      "literalcouldNotLoadYourMessages":
          MessageLookupByLibrary.simpleMessage("Viestejäsi ei voitu ladata"),
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("Tätä yhteisöä ei voitu avata"),
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("Vastausta ei voitu julkaista."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Haku ei onnistunut"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Uloskirjautuminen epäonnistui: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} sivua auki",
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Kansikuva"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("Datansäästö"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Poista julkaisu"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Löydä ihmisiä"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Älä vastaa"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Luonnos tallennettu"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Palautetta ei voi lähettää juuri nyt"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Tekstin koko"),
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
          "GIF-kuvia ei ole otettu käyttöön"),
      "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage(
          "Anna se toiselle sovellukselle"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Piilota salasana"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Piilota tämä julkaisu"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Piilottaa sen ja pyytää meitä näyttämään vähemmän tällaisia"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Miten käyttäytyä"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Jatka kirjoittamista"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron ei vastannut"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "\\${a0}-päivä",
      "literalleaveCommunityName": (Object a0) => "Poistutaanko ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, kasvolinssi",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Tykätyt julkaisut"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Linkki kopioitu"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Tee valvojaksi"),
      "literalmuteAuthor": (Object a0) => "Mykistä ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Mykistä tämä ketju"),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
          "Mykistä sanoja tai tunnisteita"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("Mykistetyt ja estetyt tilit"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Mykistetty. Et saa ilmoituksia."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Mikään tämän laitteen sovellus ei avaa ${a0}-linkkejä.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Mikään tämän laitteen selain ei ottanut linkkiä vastaan."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("Ei vielä DID:tä"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Ei luonnoksia"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
          "Ei vielä kiinnostuksen kohteita"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Ei vielä tykkäyksiä"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Ei vielä viestejä"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Ei uusia seuraajia"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Ei vielä julkaisuja"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Ei vielä vastauksia"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Ei vielä uudelleenjulkaisuja"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Mikään suosittu tunniste ei vastaa"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Ketään ei löytynyt"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Ketään ei ole poistettu"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Täällä ei ole vielä ketään"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Ei kiinnosta"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Mitään ei löytynyt"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Mikään ei ole vielä suosittua"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Lokissa ei ole vielä mitään"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Ei osumia"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Ei mykistyksiä"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Ei vielä mitään katsottavaa"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Ei lukemattomia"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Vain omistaja voi muuttaa tätä"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Avaa vastaus"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Avaa Kyronin sähköposti"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Salasana ja kirjautuminen"),
      "literalpostInCommunityName": (Object a0) => "Julkaise yhteisöön ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) =>
          "Julkaise yhteisöön ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Julkaise se omin sanoin yläpuolella"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Ensisijainen kieli"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-ilmoitukset"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Luetaan…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Äänitä äänijulkaisu"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Tallenna uudelleen"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Poista valvojista"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Poista yhteisöstä"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Poista tallennetuista"),
      "literalremoveLabel": (Object a0) => "Poista ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Poista ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Poistetaanko ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Poista kysely"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Poista tämä vastaus"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Poista tämä keskustelu"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Poista tämä kysely"),
      "literalreportAuthor": (Object a0) => "Ilmoita käyttäjästä ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Ilmoita julkaisusta"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Lähetä koodi uudelleen"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Tallennetut julkaisut"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Sano jotain"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Sano jotain yhteisölle ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Haku epäonnistui"),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("Lähetä uudelleen"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "Lähetä uudelleen ${a0} s kuluttua",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Lähetä palautetta"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Lähetä linkki"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Lähetetty. Se on raportti nro ${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Aseta salasana ja jatka"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("Jaa loki tuelle"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Jaa tämä yhteisö"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Jaa tämä sivu"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Jaa tämä profiili"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Jaa…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Jaa lainauksen kanssa"),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
          "Näytä lisää tällaisia julkaisuja"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Näytä salasana"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Näytä tulokset"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Perusta yhteisö"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Aloita tallennus"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Lopeta lataus"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Lakkaa näkemästä tätä julkaisua ja sen vastauksia"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Tarinapalkki, ${a0} kohdetta",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Vaihda kameraa"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Merkitse joku"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("Ota kuva"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Vaihda napauttamalla banneria tai kuvaa"),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
          "Napauta sen sisällä olevaa linkkiä"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Lisää kuva ja kansi napauttamalla"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Se ei mennyt läpi. Yritä uudelleen."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("GIF-kuvaa ei voitu ladata."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Tätä linkkiä ei voi avata täällä."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Kamera on suljettu"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Tämä yhteisö"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Tämä vastaus on poistunut"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Käännä julkaisu"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("Ääni pois"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("Ääni päälle"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Käytä jotain meidän"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Vahvistuskoodi lähetetty uudelleen."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Vahvistus epäonnistui: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Vahvista sähköposti"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Katsojat, tykkäykset, tallennukset ja kommentit"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Mitä Kyron säilyttää"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Mitä tämä sovellus on tehnyt"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Mitä teit, mitä odotit, mitä tapahtui "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Julkaisemasi on sinun"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Onko Kyron tavoitettavissa juuri nyt"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Kuka voi vastata"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Kenet haluat merkitä?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Seuraat jo kaikkia suosittuja tunnisteita"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Olet ajan tasalla"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("Et ole missään yhteisössä"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Olet kirjautunut ulos."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) =>
          "Poistuit yhteisöstä ${a0}",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "Et ole vielä julkaissut mitään"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Lataa lisää"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Loki tyhjennetty"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Loki kopioitu"),
      "logIn": MessageLookupByLibrary.simpleMessage("Kirjaudu sisään"),
      "logOut": MessageLookupByLibrary.simpleMessage("Kirjaudu ulos"),
      "logOutQuestion":
          MessageLookupByLibrary.simpleMessage("Kirjaudutaanko ulos?"),
      "login": MessageLookupByLibrary.simpleMessage("Kirjautuminen"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Kirjautuminen epäonnistui. Tarkista tunnuksesi."),
      "manage": MessageLookupByLibrary.simpleMessage("Hallinnoi"),
      "menu": MessageLookupByLibrary.simpleMessage("Valikko"),
      "message": MessageLookupByLibrary.simpleMessage("Viesti"),
      "messages": MessageLookupByLibrary.simpleMessage("Viestit"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "Kaikki keskustelut ovat ajan tasalla."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Avaa jonkun profiili ja aloita keskustelu napauttamalla Viesti."),
      "mute": MessageLookupByLibrary.simpleMessage("Mykistä"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Mykistetyt ja estetyt"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
          "Mykistetyt sanat ja tunnisteet"),
      "name": MessageLookupByLibrary.simpleMessage("Nimi"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name>-näkymä"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Uusi sähköpostiosoite"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Uusi salasana"),
      "newPost": MessageLookupByLibrary.simpleMessage("Uusi julkaisu"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Ei nyt"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Ei lähetetty. Yritä uudelleen napauttamalla"),
      "nothingMatchesQuery": (Object a0) =>
          "Mikään Kyronissa ei vastaa hakua \"${a0}\"",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Ei mitään kopioitavaa"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Tykkäykset, vastaukset ja uudet seuraajat tulevat tänne."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Sinua seuraavat ihmiset näkyvät täällä."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Kun joku tykkää julkaisustasi, se näkyy täällä."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Vastaukset julkaisuihisi tulevat tänne."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Kun joku julkaisee sinut uudelleen, se näkyy täällä."),
      "notifications": MessageLookupByLibrary.simpleMessage("Ilmoitukset"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("Avaa selaimessa"),
      "or": MessageLookupByLibrary.simpleMessage("tai"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("Sivua ei löytynyt"),
      "password": MessageLookupByLibrary.simpleMessage("Salasana"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Salasana on liian lyhyt"),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
          "Valitse kiinnostuksen kohteesi"),
      "post": MessageLookupByLibrary.simpleMessage("Julkaise"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Julkaisun tilastot"),
      "postInCommunity": (Object a0) => "Julkaise yhteisöön ${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Julkaise, sano, näytä."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Julkaisun teksti kopioitu"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Tietosuojakäytäntö"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profiili päivitetty"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Esittely"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Maa"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Näyttönimi"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Sijainti"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Vaihda napauttamalla"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Verkkosivusto"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Push-ilmoitukset"),
      "quote": MessageLookupByLibrary.simpleMessage("Lainaa"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Lainaa julkaisua"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Tavoita ihminen"),
      "remove": MessageLookupByLibrary.simpleMessage("Poista"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Poistetaanko tämä keskustelu?"),
      "removeMember": (Object a0) => "Poistetaanko ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Poistetaanko tämä viesti?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Vastaukset, seuraamiset ja maininnat"),
      "repliesPolicy": (Object a0) => "Vastaukset: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Vastaa"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Kuka tahansa voi osallistua"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Kuka tahansa voi edelleen nähdä, julkaista uudelleen ja lainata tätä julkaisua."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kuka tahansa Kyronissa voi vastata tähän julkaisuun."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Sinua seuraavat"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Vain sinua seuraavat voivat vastata tähän julkaisuun."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Mainitsemasi ihmiset"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Vain tässä julkaisussa @mainitsemasi ihmiset voivat vastata."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Kukaan ei voi vastata"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Vastaukset on poistettu käytöstä. Voit silti vastata itse."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Kuka voi vastata?"),
      "report": MessageLookupByLibrary.simpleMessage("Raportoi"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Raportti kopioitu. Liitä se sähköpostiin tuelle."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Raportti lähetetty"),
      "repost": MessageLookupByLibrary.simpleMessage("Julkaise uudelleen"),
      "reset": MessageLookupByLibrary.simpleMessage("Nollaa"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Nollaa salasanasi"),
      "retry": MessageLookupByLibrary.simpleMessage("Yritä uudelleen"),
      "save": MessageLookupByLibrary.simpleMessage("Tallenna"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Tallenna luonnos"),
      "saySomething": (Object a0) => "Sano jotain yhteisölle ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Hae"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Hae nimellä tai käyttäjänimellä"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Hae yhteisöjä"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Hae GIF-kuvia"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Hae kieliä"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Hae suosittuja tunnisteita"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Tietoturvailmoitukset ja tilin muutokset"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Valitse sovelluksen käyttöliittymän kieli."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Valitse, mitä kieliä syötteisiisi tulee. Jos et valitse yhtään, kaikki kielet näytetään."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Valitse ensisijainen kieli syötteesi käännöksille."),
      "send": MessageLookupByLibrary.simpleMessage("Lähetä"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Lähetä vahvistus"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Lähetä virheraportti"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Lähetä palautetta"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Lähetä raportti"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("Lähetä tuelle"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Palvelun tila"),
      "settings": MessageLookupByLibrary.simpleMessage("Asetukset"),
      "shareAppLog":
          MessageLookupByLibrary.simpleMessage("Jaa sovelluksen loki tuelle"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Kirjaudu Kyroniin"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Kirjautuneena"),
      "signupFailed": (Object a0) => "Rekisteröinti epäonnistui: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Jää"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron on alussa, ja nopein tapa tavoittaa joku, joka voi oikeasti korjata ongelman, on avata tiketti. Kerro, mitä olit tekemässä ja mitä tapahtui."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Sovelluksessa ei ole vielä tuen postilaatikkoa, joten tämä näkymä ohjaa paikkaan, jota oikeasti seurataan, eikä lomakkeeseen, joka ei vie mihinkään."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Järjestelmäloki"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Kerro, mitä puuttuu tai mikä on rikki"),
      "terms": MessageLookupByLibrary.simpleMessage("Käyttöehdot"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Tekstiä, ääntä ja videota, niiden tekijät ja huoneet, joissa he juttelevat."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "Editorissa ei ole Julkaise-painiketta"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Tumma"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Aina tumma"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Himmeä"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Pehmeämpi tumma, sinertävän harmaa mustan sijaan"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Vaalea"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("Aina vaalea"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Järjestelmä"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Noudata puhelimen vaaleaa tai tummaa asetusta"),
      "translate": MessageLookupByLibrary.simpleMessage("Käännä"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Kääntäminen ei ole vielä käytössä. Syötteessäsi ei käännetä vielä mitään; tämä muistetaan siihen asti."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Tämä vaihtaa Kyronin omat sanat, Flutterin itse piirtämät käyttöliittymän osat, päivämäärät ja luvut sekä sovelluksen asettelun suunnan oikealta vasemmalle kirjoitettaville kielille."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Yritä uudelleen"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Tietosuojakäytäntö"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Käyttöehdot"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Tili"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Jälkeen"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Sovellus ja laite"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Lainasin huijausta varoittaakseni muita."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Kerro, miksi päätös on mielestäsi väärä: mitä julkaisu tarkoitti, mitä tiimiltä on voinut jäädä huomaamatta tai miksi sääntö ei sovi. Sen lukee joku muu kuin päätöksen tehnyt."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Valituksesi"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Kirjoita vähintään \$count merkkiä. Voit valittaa jokaisesta päätöksestä kerran."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Lähetä valitus"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Valitus lähetetty. Saat ilmoituksen, kun asia on ratkaistu."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Valitus tapauksesta \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Ulkoasu"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Vaalea, tumma tai puhelimen asetuksen mukaan"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Ennen"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Kumpikaan teistä ei näe toista Kyronissa, ja seuraamiset välillänne poistetaan. Hänelle ei kerrota."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Sisältää"),
      "ui_cchat_about": MessageLookupByLibrary.simpleMessage(
          "Mitä varten se on (valinnainen)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Vain moderaattorit voivat kirjoittaa"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Tiedotteille. Kaikki yhteisössä voivat edelleen lukea ja reagoida."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Lisää kuva tai kysely"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Kuvat ja videot"),
      "ui_cchat_close":
          MessageLookupByLibrary.simpleMessage("Sulje keskustelu"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Kukaan ei voi enää lukea tai kirjoittaa siihen. Tätä ei voi perua."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Suljetaanko tämä keskustelu?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Kopioitu"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Viesti poistetaan kaikilta. Kyron säilyttää kopion tarkistusta varten."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Viesti poistetaan kaikilta keskustelussa."),
      "ui_cchat_edit":
          MessageLookupByLibrary.simpleMessage("Muokkaa keskustelua"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Muokkaa"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("muokattu"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Muokkaat viestiäsi"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Keskustelua ei voitu avata."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Keskustelut"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Liity keskusteluun"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Liity yhteisöön nähdäksesi sen keskustelut ja osallistuaksesi."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count liittynyt"),
      "ui_cchat_leave":
          MessageLookupByLibrary.simpleMessage("Poistu keskustelusta"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Voit yhä lukea sitä niin kauan kuin olet yhteisössä."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Vain omistaja ja moderaattorit voivat kirjoittaa tänne."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Mykistä"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Ei ilmoituksia siitä, eikä sitä lasketa Viesteihin."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Keskustelun nimi"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Uusi keskustelu"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Ei vielä keskusteluja."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Ei vielä keskusteluja. Avaa yksi yhteisölle."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Yhteisökeskustelut eivät ole päästä päähän salattuja. Yhteisön moderaattorit ja Kyron voivat lukea niitä."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Kiinnitä ylös"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Lisää vastaus"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Sulje kysely"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Suljettu"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Kaikki näkevät, kuinka moni valitsi kunkin vastauksen, mutta eivät koskaan keitä."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Salli useampi valinta"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Uusi kysely"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Valitse yksi"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Vastaus \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Kysely: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Kysymys"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Kukin vastaus voi olla kyselyssä vain kerran."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Valitse yksi tai useampi"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count vastasi"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Hae tästä keskustelusta"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Hae tästä keskustelusta"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Mitään ei löytynyt."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Et voi enää nähdä tätä keskustelua."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Hidas tila"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Kuinka kauan viestien välillä odotetaan. Ei koske moderaattoreita."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 tunti"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minuuttia"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Hidas tila: yksi viesti \$seconds sekunnin välein"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Pois"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n sekuntia"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Voit lukea ja reagoida katsojana. Liity kirjoittaaksesi."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Viesti on liian kaukana näytettäväksi."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Jokin valitsemasi on liian suuri lähetettäväksi, ja se jätettiin pois."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Poista mykistys"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Irrota"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Nauhoita ääniviesti"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Sinä"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Yhteisöt"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage(
              "Mihin se on tarkoitettu? (valinnainen)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Julkaisut:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Sisältö ja näyttö"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("Syötettäsi ei voitu ladata"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Tykkäämiäsi julkaisuja ei voitu ladata"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("Profiiliasi ei voitu ladata"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Tallennettuja julkaisujasi ei voitu ladata"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Hajautettu tunniste"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Vianmääritys"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Ryhmät"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Ei ryhmiä"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Tässä näkyvät ryhmät, joissa olet mukana, ja yhteisökeskustelut, joihin liityt."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Voit kiinnittää enintään \$count keskustelua. Irrota ensin yksi."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Kiinnitetty"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Tykätyt"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Tallennetut"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Täällä ei ole vielä mitään"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Seuraa muutamaa tiliä, niin niiden julkaisut näkyvät täällä."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Ei mitään seuraamiltasi"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Julkaisut näkyvät täällä sitä mukaa kuin ihmiset kirjoittavat niitä."),
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("Heikkenee"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Ei kiinnosta"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Näytä lisää tällaisia"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Poistettu"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Syötteesi signaalit"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Napauta julkaisussa Näytä lisää tällaisia julkaisuja tai Ei kiinnosta, niin se näkyy täällä."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Täällä ei ole vielä mitään"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Mitä Näytä lisää ja Ei kiinnosta kertovat syötteillesi"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Ne muokkaavat Kotia ja Tutkia, enimmäkseen sen mukaan, mistä julkaisu kertoi. Jokainen heikkenee puoleen joka kuukausi eikä lasketa enää kuuden jälkeen. Poista jokin, niin se loppuu heti."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Leikkeen sisältävät julkaisut näkyvät täällä."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Ei vielä videoita"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Palaute"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Löydä ihmisiä Kyronista"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Tililtä"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Lisää henkilöitä"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Lisää"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Lisää ryhmän nimi"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Hylkää"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Tämän ryhmän viestit ovat päästä päähän salattuja, kuten kaikki muutkin keskustelut."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor lisäsi: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor teki ylläpitäjäksi: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor loi ryhmän"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor asetti uudet henkilöt liittymään jäseninä"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor asetti uudet henkilöt liittymään katsojina"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor poistui"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor teki jäseneksi: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor teki omistajaksi: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor poisti: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor nimesi ryhmän uudelleen: \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor teki katsojaksi: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Ryhmässä voi olla enintään \$count henkilöä."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Käsi nostettu. Ylläpitäjille on kerrottu."),
      "ui_group_hands": MessageLookupByLibrary.simpleMessage(
          "\$count pyytää kirjoitusoikeutta"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Pyytävät kirjoitusoikeutta"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Myöhemmin lisätyt liittyvät katsojina"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Poistu ryhmästä"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Se poistuu listaltasi, etkä näe, mitä sen jälkeen sanotaan. Jonkun pitäisi lisätä sinut uudelleen."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Poistutaanko ryhmästä?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Anna kirjoittaa"),
      "ui_group_lower_hand": MessageLookupByLibrary.simpleMessage("Laske käsi"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Tee ylläpitäjäksi"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Tee omistajaksi"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Tee katsojaksi"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count jäsentä"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Jäsenet"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Ryhmän nimi"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Nimeä ryhmä ensin."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Luo ryhmäkeskustelu"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Omistajia on yksi. Jatkat ylläpitäjänä."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Tehdäänkö \$name omistajaksi?"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("Nosta käsi"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Poista ryhmästä"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Poista ylläpitäjyys"),
      "ui_group_removed":
          MessageLookupByLibrary.simpleMessage("Et ole enää tässä ryhmässä."),
      "ui_group_rename":
          MessageLookupByLibrary.simpleMessage("Nimeä uudelleen"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Ylläpitäjä"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Jäsen"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Katsoja"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Katsojana voit lukea ja reagoida täällä."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Katsojat voivat lukea, reagoida ja nostaa käden pyytääkseen kirjoitusoikeutta."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Ehdotetut"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Näytä profiili"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("sinä"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Olet katsoja"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Ohje"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Kirjattu. Tämä auttaa valitsemaan, mitä sinulle näytetään."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Liity"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Liittynyt"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Kieli"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Valitse kieli"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Juridiset tiedot"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Tykkää"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Tykätyt julkaisut"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Tykkäämäsi julkaisut näkyvät täällä uusimmat ensin."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Linkki kopioitu"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Et enää näe hänen julkaisujaan. Hänelle ei kerrota."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Ei vielä tykkäyksiä"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Mikään julkaisu ei vastaa suodattimia."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Ei vielä tallennettuja"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Tiliäsi on päivitetty"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Valituksesi tapauksesta \$number hyväksyttiin"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Kävimme valituksesi tapauksesta \$number uudelleen läpi, ja päätös pysyy voimassa"),
      "ui_notif_banned":
          MessageLookupByLibrary.simpleMessage("Tilisi on suljettu pysyvästi"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Tapaus \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("alkoi seurata sinua"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("tykkäsi julkaisustasi"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("mainitsi sinut"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Ei vielä mainintoja"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Kun joku kirjoittaa @käyttäjänimesi julkaisuun tai vastaukseen, se näkyy täällä."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Vanhemmat"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Viestisi yhteisökeskustelussa poistettiin"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Jotain julkaisemaasi poistettiin"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Julkaisusi poistettiin"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Vastauksesi poistettiin"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("vastasi julkaisuusi"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Ryhdyimme toimiin raportoimasi asian vuoksi. Kiitos, että kerroit."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Tarkistimme raportoimasi asian, emmekä todenneet sen rikkovan sääntöjämme."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Raportoitu syystä: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("jakoi julkaisusi"),
      "ui_notif_reversed":
          MessageLookupByLibrary.simpleMessage("Peruimme tapauksen \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Tilisi on jäädytetty"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Tilisi on jäädytetty \$date asti"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Kaikki"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Seuraajat"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Tykkäykset"),
      "ui_notif_tab_mentions":
          MessageLookupByLibrary.simpleMessage("Maininnat"),
      "ui_notif_tab_replies":
          MessageLookupByLibrary.simpleMessage("Vastaukset"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Tällä viikolla"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Tänään"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Tilillesi on annettu varoitus"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Eilen"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Valmis"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Ohita"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Tämä on jo avattu."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Vanhentunut"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Tätä ei voitu avata."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Avautuu kerran ja poistetaan sitten Kyronista."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Katso kerran"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Avattu"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Avannut \$count / \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Vain ne, joille lähetit tämän, voivat avata sen, kerran."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Lähetä kerran katsottavaksi"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Napauta nähdäksesi"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Tauko"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Toista"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Se poistetaan profiilistasi ja kaikkien syötteistä. Sen vastaukset lähtevät sen mukana."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Julkaisu poistettu"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Julkaisu piilotettu"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Julkaisun teksti kopioitu"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Julkaistu välillä"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Piilotettu. Näytämme vähemmän tällaisia."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Asetukset"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Tietosuoja"),
      "ui_report_add":
          MessageLookupByLibrary.simpleMessage("Lisättävää? (valinnainen)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Saat ilmoituksen, kun tiimi on päättänyt, ja voit seurata asiaa kohdassa Raportoimasi."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Jos et myöskään halua nähdä häntä enää, voit mykistää tai estää hänet samasta valikosta."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Saman asian raportoiminen kahdesti ei lisää sen painoarvoa: säilytämme yhden raportin henkilöä kohden."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Raporttiasi ei jaeta hänen kanssaan. Säilytämme kopion raportoimastasi, jotta se voidaan tarkistaa, vaikka se poistettaisiin."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Raporttisi on vastaanotettu ja odottaa tarkistusta. Emme kerro hänelle, kuka raportoi."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Näytä raportoimasi"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Kerro, mikä on vialla"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Kiitos, että kerroit"),
      "ui_report_what_account": MessageLookupByLibrary.simpleMessage(
          "Mitä vikaa on käyttäjässä \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Mitä vikaa tässä viestissä on?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Mitä vikaa tässä julkaisussa on?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Mitä vikaa tässä vastauksessa on?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("Viesti yhteisökeskustelussa"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Julkaisu"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Vastaus"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Toimiin ryhdytty"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Tili"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Päätetty \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Sääntöjä ei rikottu"),
      "ui_reports_failed":
          MessageLookupByLibrary.simpleMessage("Raportoimiasi ei voitu ladata"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Mitä olet raportoinut viimeisten 90 päivän aikana ja mitä siitä seurasi. Saat ilmoituksen, kun tiimi päättää. Kukaan, jonka raportoit, ei saa tietää, kuka raportoi."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Ei raportoituja"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Kun raportoit julkaisun, vastauksen, viestin tai tilin, se näkyy tässä yhdessä sen kanssa, mitä siitä seurasi."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("Käsittelyssä"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Raportoitu \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Mitä olet raportoinut ja mitä siitä seurasi"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Raportoimasi"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Lasten turvallisuus"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Kaikki, mikä vaarantaa tai seksualisoi alaikäisen."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Kohdistettu häirintä, uhkaukset tai ei-toivottu yhteydenpito."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Ihmisiin kohdistuvat hyökkäykset sen vuoksi, keitä he ovat."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Jonkin laittoman myyminen tai mainostaminen."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Toiseksi henkilöksi tekeytyminen."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Käyttää teostasi tai tavaramerkkiäsi ilman lupaa."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Harhaanjohtavat väitteet terveydestä, vaaleista tai tapahtumista."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Itsensä vahingoittamiseen kannustaminen tai sen näyttäminen."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Seksuaalinen sisältö ilman varoitusta."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Ei mikään yllä olevista. Kerro, mikä on vialla."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Toistuva, harhaanjohtava tai ei-toivottu mainostaminen."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Väkivallalla uhkaaminen, sen ihannointi tai siihen yllyttäminen."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Häirintä tai kiusaaminen"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Vihapuhe"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Laittomat tuotteet tai palvelut"),
      "ui_rule_impersonation": MessageLookupByLibrary.simpleMessage(
          "Toisena henkilönä esiintyminen"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Immateriaalioikeudet"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Väärä tieto"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Itsemurha tai itsensä vahingoittaminen"),
      "ui_rule_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Aikuisille tarkoitettu sisältö"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Jokin muu"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Roskaposti"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Väkivalta tai uhkaukset"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Tallennetut julkaisut"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Säilytä julkaisu täällä napauttamalla sen arkistokuvaketta. Vain sinä näet tallentamasi."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Hae käyttäjänimellä tai näyttönimellä."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Tyhjennä"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("Hae kaikesta julkaistusta"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Suodattimet"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Hae ihmisiä"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("Hae julkaisuja"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Asetukset"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Sovellus ja laite"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Sisältö ja näyttö"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Datansäästö"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Kerro mielipiteesi"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Selaa ohjeartikkeleita"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Valitse kieli"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Ketkä olet mykistänyt tai estänyt"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Ilmoitusasetukset"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("Profiilisi ja yhteystietosi"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Sinun täytyy kirjautua uudelleen päästäksesi tilillesi."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Tietoturva-asetukset"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Vahvista salasana"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("Yhdellä rivillä"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Uusi sähköpostiosoite"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Uusi salasana"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Mitä tapahtui"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Saa apua tiimiltämme"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Jaa"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Lainaa"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Lähetä viestissä"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Ihmisille Kyronissa"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Jaa tämä julkaisu"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Mitä asia koski"),
      "ui_standing_account_banned":
          MessageLookupByLibrary.simpleMessage("Tilisi on suljettu pysyvästi"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Vastaus, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Valitus"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Valita tästä päätöksestä"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Tästä päätöksestä ei voi enää valittaa. Jos jokin on vialla, ota yhteyttä tukeen."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Valitus käsittelyssä"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Valitus hyväksytty"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Joku muu tiimistä käy asian uudelleen läpi. Saat ilmoituksen, kun asia on ratkaistu."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Jos pidät tätä virheenä, voit pyytää uutta käsittelyä \$date asti. Päätöksen tekee joku muu tiimistä."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Valitettu: päätös pysyy voimassa"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Tapaus \$number. Sääntö: \$rule. Tiimi kirjoitti:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Tilin poistaminen ei kumoa sulkemista: uusi tili samalla sähköpostiosoitteella on myös suljettu."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Suljettu pysyvästi"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Vain tämä sivu, valitukset, tuki ja tilin poistaminen toimivat enää."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Valituskelpoinen"),
      "ui_standing_case":
          MessageLookupByLibrary.simpleMessage("Tapaus \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Päätetty \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Tiliäsi koskevat päätökset"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Poista tilisi"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Näytä tiedot"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Näytä tiedot ja valita"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Päättyy \$date"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "Tililläsi ei ole huomautettavaa"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Mikään ei rajoita sitä."),
      "ui_standing_load_failed":
          MessageLookupByLibrary.simpleMessage("Tilin tilaa ei voitu ladata"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Viesti poistettu"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Tilistäsi ei ole tehty päätöksiä. Jos tiimi joskus poistaa jotain sinun tekemääsi tai rajoittaa tiliäsi, se näkyy täällä perusteluineen, ja voit valittaa siitä."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Ei valitettavaa: päätös on kumottu."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Julkaisu poistettu"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Tarkista uudelleen vetämällä alas."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Lue Kyronin säännöt"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Vastaus poistettu"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Kumottu"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Kumottu \$date. Kaikki poistettu on palautettu, eikä mikään rajoitus ole enää voimassa."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Sääntö: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("Kirjaudu ulos"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Jäädytetty"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Voit lukea, mutta et julkaista, vastata, seurata tai lähettää viestejä. Raportointi, estäminen ja mykistäminen toimivat edelleen."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Tilisi on jäädytetty: voit lukea, mutta et julkaista."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Jäädytetty \$date asti"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Tilisi on jäädytetty \$date asti: voit lukea, mutta et julkaista."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Mitä tiimi sanoi"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("Tilin tila"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Varoitus"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Miksi?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Kirjoitit \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Viestisi"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Julkaisusi"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Vastauksesi"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Käyttöehdot"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("tämä julkaisu"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Ketju mykistetty"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Yritä uudelleen"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("Ääni pois"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Ääni päälle"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Vähintään kaksi merkkiä."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Kumoa"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Sanoja tai suodatin: tili, aikaväli tai mitä julkaisu sisältää."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Kumoa uudelleenjulkaisu"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Päivitä salasana"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Käytä toista osoitetta"),
      "username": MessageLookupByLibrary.simpleMessage("Käyttäjänimi"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Käyttäjänimen on oltava pienillä kirjaimilla (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Liitä"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Valmis liitettäväksi"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Äänitä äänijulkaisu"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Tallennetaan…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Lopeta"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Mitä tapahtui"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Mitä tapahtui, ja mitä meidän pitäisi tarkistaa?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Mitä tässä kuvassa on?"),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage(
          "Mihin se on tarkoitettu? (valinnainen)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Mitä teit, mitä odotit, mitä tapahtui"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Mitä olit tekemässä, kun se tapahtui."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Vastasit"),
      "dmReplied": (Object a0) => "$a0 vastasi",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Lisää viestiin"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Uusi viesti"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Mitään ei ole vielä sanottu. Vilkutus on hyvä alku."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Vilkuta"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Uudet viestit"),
      "dmTyping": (Object a0) => "$a0 kirjoittaa",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Poista reaktiosi"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Joku"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Viesti"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("Liite"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Tätä viestiä ei voi lukea tällä laitteella."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Odotetaan tätä viestiä. Tämä voi kestää hetken."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Salattu viesti"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Viestit ovat päästä päähän salattuja"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Ei päästä päähän salattu"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Lähetetty"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Nähty"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Lähetetään…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Ota kuva"),
      "ui_media_more":
          MessageLookupByLibrary.simpleMessage("Lisää vaihtoehtoja"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Tallenna laitteelle"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Jaa"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Tallennetaan…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Tallennettu kuviisi"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Tallennus epäonnistui. Yritä uudelleen."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Anna Kyronin lisätä kuviisi, jotta voit tallentaa tämän."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Kaikki järjestelmät toimivat"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Käytettävyys"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Viimeiset 60 päivää"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 päivää sitten"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Tänään"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Tietokanta"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Kirjautuminen"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Viimeaikaiset häiriöt"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Ei häiriöitä viimeisten 60 päivän aikana."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Käynnissä"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Ei tietoja"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Tiedot"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron tarkistaa itsensä 5 minuutin välein ollessaan käynnissä. Harmaana päivänä tarkistuksia ei tehty."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Käytettävyyshistoria ei ole vielä saatavilla."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Joissakin järjestelmissä on ongelmia"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Nauhoita ääniviesti"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Valmis lähetettäväksi"),
      "ui_dm_quote_gone": MessageLookupByLibrary.simpleMessage(
          "Sitä viestiä ei ole enää täällä."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Siirry viestiin"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("Ääniviesti"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Kirjoittaja tykkää"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Lisää kuva tai leike"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Media"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Ääniviestit"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Keskustelu"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("Taustakuva"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Mykistä ilmoitukset"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Lopeta tätä keskustelua koskevat ilmoitukset"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "He eivät voi enää lähettää sinulle viestejä"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Ei mitään"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Kuva"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Mykistys poistettu."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Poistaminen epäonnistui. Yritä uudelleen."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profiili"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Poista mykistys"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Jakamasi kuvat ja leikkeet näkyvät täällä."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Näytä kaikki"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Kuvat ja leikkeet"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("Tältä keskustelusi näyttää."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Näyttää hyvältä."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Usva"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Hämärä"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Salvia"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Hiekka"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Pisteet"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Käytä"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Nykyinen"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Lähetä ilman esikatselua"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Hae"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Julkaise"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Kirjoita viesti…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Lähetä"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Lähetetty"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Lähetetty, mutta ei kaikille."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Lähettäminen ei onnistunut. Yritä uudelleen."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Seuraaja"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Suodatin"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Kaikki"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Lukemattomat"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Vastaamattomat"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Piilotetut"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Ei mitään piilotettuna"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Listaltasi poistamasi keskustelut odottavat täällä siltä varalta, että haluat ne takaisin."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Se siirtyy piilotettuihin. Toinen pitää omansa, ja se palaa, jos jompikumpi kirjoittaa uudelleen."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Palauta"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Takaisin listallasi."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Ei vastaavia keskusteluja."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Mikään ei odota sinua"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Jokainen keskustelu päättyy sinun sanaasi."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Kuva"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Kuvat"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Ei vielä viestejä"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Sinä:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Eilen"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Viestit"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Viestiasetukset"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Yksityisyys"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Lukukuittaukset"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Kun tämä on pois päältä, muut eivät näe, milloin olet lukenut heidän viestinsä, etkä sinä näe, milloin he ovat lukeneet sinun viestisi."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Näytä, kun kirjoitat"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Henkilö, jolle kirjoitat, näkee, että kirjoitat."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Linkkien esikatselut"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Puhelimesi avaa lähettämäsi linkin esikatselun tekemiseksi, joten sivusto näkee puhelimesi pyynnön. Kyronin palvelin ei koskaan näe linkkiä."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Viestien ilmoitukset"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Viestit on salattu päästä päähän. Kyron ei voi lukea niitä, eikä mikään tässä muuta sitä."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Vastaanottaja:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Viimeisimmät"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Ihmiset"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Kukaan ei ole tuolla nimellä."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Lähetä testi-ilmoitus"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyronin palvelinta ei ole vielä määritetty lähettämään ilmoituksia, joten yksikään ei voi tulla perille. Vika on meidän päässämme, ei puhelimessasi."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Tätä puhelinta ei ole rekisteröity ilmoituksille. Tarkista, että Kyronin ilmoitukset on sallittu puhelimen asetuksissa, ja yritä uudelleen."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Ilmoitusta ei voitu toimittaa tähän puhelimeen. Yritä minuutin päästä uudelleen."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Lähetetty. Sen pitäisi saapua muutamassa sekunnissa."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Ilmoitukset toimivat."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Ei vielä julkaisuja"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("Uusi yhteisö"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Nimi"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Osoite muodostetaan nimestä."),
      "ui_community_address": MessageLookupByLibrary.simpleMessage(
          "Ihmiset löytävät sen osoitteesta"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Sinusta tulee sen omistaja. Kuvan, bannerin ja moderaattorit voi lisätä sen sivulta, kun se on luotu."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Koti"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Yhteisöjen julkaisut Kodissa"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Yhteisöjesi julkaisut näkyvät myös Kodissa. Pois päältä ne pysyvät täällä Yhteisöissä, joissa jokainen näyttää, mitä on uutta."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Sinun listasi"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Uusien julkaisujen määrä"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Näytä, montako julkaisua kussakin yhteisössä on uusia sen jälkeen, kun viimeksi avasit sen."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Yhteisöt, joita johdat"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Tässä ovat yhteisöt, jotka perustat tai joita moderoit."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Omistaja"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderaattori"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Uudet julkaisut"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Sinun johtamasi"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Yhteisöasetukset"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Löydä"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Mikään yhteisö ei vastaa."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Ei mitään uutta"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Jokainen yhteisö on niin kuin sen jätit."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Et johda vielä yhtään"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Ei enää mitään, mihin liittyä"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Olet Kyronin jokaisessa yhteisössä. Perusta uusi."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Kokeile toista sanaa tai perusta yhteisö sillä nimellä."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Kirjoita julkaisu"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Jäsenet:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Julkaistu"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Näytä"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Avaa"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Verkossa"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Näytä, kun olet verkossa"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Ihmiset, joille viestit, näkevät vihreän pisteen, kun Kyron on sinulla auki. Kun tämä on pois päältä, et näe heidänkään pistettään."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Hae ihmisiä ja julkaisuja"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Yhteisöjä, joihin liittyä"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Ei vielä mitään katsottavaa"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Ihmisten julkaisemat kuvat ja leikkeet näkyvät täällä."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Seuraa"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("Poista tili"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Tämä poistaa Kyron-tilisi pysyvästi. Toimintoa ei voi kumota."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Profiilisi, julkaisusi, vastauksesi, tykkäyksesi ja uudelleenjulkaisusi"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Viestisi, myös muille lähettämäsi, sekä niiden kuvat ja ääniviestit"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Seuraajasi, seuraamasi ihmiset ja asetuksesi"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Perustamasi yhteisöt siirtyvät pisimpään mukana olleelle valvojalle tai jäsenelle. Yhteisö, jossa ei ole ketään muuta, suljetaan."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Poistetaanko tilisi?"),
      "ui_delete_account_confirm_detail":
          MessageLookupByLibrary.simpleMessage("Et saa mitään siitä takaisin."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Tilisi on poistettu."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Poistettu tili"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Tämä tili on poistettu, joten tänne ei voi enää lähettää viestejä."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Rekisteröidyitkö Googlella? Käytä sen sijaan painiketta ”Sign in with Google”."),
      "ar_lens_not_loaded":
          MessageLookupByLibrary.simpleMessage("Linssiä ei voitu ladata."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Videota ei voitu tallentaa."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Linssiä ei voitu lisätä tähän videoon, joten se julkaistaan sellaisena kuin se kuvattiin."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Julkaisussasi on jo niin monta liitettä kuin siihen mahtuu."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Lisätään linssiä…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Salama"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Kuvaa video"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Kuva"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Video"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Google-kirjautuminen peruttiin."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("LAHJAT"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Kukaan ei ole vielä lähettänyt tälle julkaisulle lahjaa."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Lahja"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Lahjat"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Kolikot"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Lähettäjä"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Lähettäjät"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Testikolikot: niitä ei voi vielä nostaa."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Tallennetut"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Julkaisut"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Kommentit"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Näytä lisää vastauksia"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Muokattu"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Lisää"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Seuratut"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Suosituimmat"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Uusimmat"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Lajittele kommentit: \$order"),
      "ui_notif_gift":
          MessageLookupByLibrary.simpleMessage("lähetti lahjan julkaisullesi"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "lähetti \$gift-lahjan kommentillesi"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "lähetti \$gift-lahjan julkaisullesi"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Lähetä lahja"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Muokkaa julkaisua"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Voit muokata sitä vielä \$n min"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Tallenna"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Tunnisteella #\$tab ei ole vielä julkaistu mitään."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Valitse lahja"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Ei tarpeeksi kolikoita"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Testikolikot: niitä ei voi ostaa, eikä niillä ole rahallista arvoa."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Täydentyy \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 kolikko"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count kolikkoa"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("Sinulla on \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Lähetä \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift lähetetty"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Yritä uudelleen"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "15 minuutin ajan julkaisun jälkeen"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Muokattu"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Tallennettuja kommenttejasi ei voitu ladata"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Ei tallennettuja kommentteja"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Napauta kommentin alla olevaa arkistokuvaketta säilyttääksesi sen täällä. Vain sinä näet, mitä tallennat."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Vastaus käyttäjälle \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Kopioi"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Hae"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Valitse kaikki"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count lahjaa"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 lahja"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Lisää julkaisuja ei voitu ladata."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Muistutukset"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Mitä uutta on, kun olet ollut poissa, ja kun kolikkosi palaavat. Korkeintaan yksi päivässä."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Lahjat"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("1 henkilöltä"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("\$count henkilöltä"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("Suurin lahjoittaja"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Lahjojen lähettäjiä ei voitu ladata."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Uutta"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Selvä"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Kiitos. Luemme jokaisen vastauksen."),
      "ui_check_in_title": MessageLookupByLibrary.simpleMessage(
          "Mitä pidät Kyronista tähän mennessä?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Testisi päivä \$day. Yksi napautus riittää."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Pitäisikö meidän korjata tai lisätä jotain? (valinnainen)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Lähetä"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Ei nyt"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Poistu Kyronista painamalla Takaisin uudelleen"),
    };

final messageLookup = MessageLookup();
