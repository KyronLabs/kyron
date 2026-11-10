import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'it';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
          "Una parola, una frase o un #tag"),
      "about": MessageLookupByLibrary.simpleMessage("Informazioni"),
      "addAnAnswer":
          MessageLookupByLibrary.simpleMessage("Aggiungi una risposta"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Aggiungi altre lingue…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Accetta e continua"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Sei già su Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Commenti"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Persone distinte, non aperture"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Coinvolgimento"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Mi piace"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Ancora nessuno spettatore"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Nessuno ha ancora aperto questo post."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Pubblicato"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Salvataggi"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Spettatori"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("SPETTATORI AL GIORNO"),
      "and": MessageLookupByLibrary.simpleMessage("e"),
      "answerNumber": (Object a0) => "Risposta ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("Lente AR"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Allega il log di sistema"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Andata e ritorno"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("VERIFICA DEL TOKEN"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Riprova"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Riprova"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Avviare una diretta ora ti metterebbe in una stanza in cui nessuno potrebbe"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Crea una community"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("A cosa serve? (facoltativo)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("rientrare."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("rientrare da questo elenco."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Chiuderla"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("prima unisciti"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("in arrivo"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Pubblichi come te"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("pubblica in questa community"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Proprio ora"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Riprova"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Argomento 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Per te"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("ha qualcosa."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage(
              "la sua strada verso di essa ora."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", non"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("mi sto muovendo"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Disattiva l'audio"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Attiva l'audio"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Per te"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Le tue schede"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Riprova"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Simbolo (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("SPETTATORI AL GIORNO"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("impossibile caricare"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("questo post"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Qualcosa da aggiungere? (facoltativo)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("questo post"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Da un account"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Esci"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Il tuo account"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Conferma password"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("non ora"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Caricamento…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Pubblicazione…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 h fa"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Copia il link della storia"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("La tua storia"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Il tuo account, i tuoi post e ciò che tocchi, così"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Aggiungi un argomento"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("da sé."),
      "authorBlocked": (Object a0) => "${a0} bloccato",
      "authorPostsHidden": (Object a0) => "Non vedrai i post di ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Blocca"),
      "blockAuthor": (Object a0) => "Bloccare ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Dettagli della build copiati"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("Continuando accetti i nostri"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Continuando accetti i nostri Termini e l'Informativa sulla privacy"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Registrandoti accetti i nostri"),
      "cancel": MessageLookupByLibrary.simpleMessage("Annulla"),
      "change": MessageLookupByLibrary.simpleMessage("Cambia"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Cambia email"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Controlla la tua email per confermare l'account."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Controlla se Kyron è raggiungibile"),
      "clear": MessageLookupByLibrary.simpleMessage("Cancella"),
      "close": MessageLookupByLibrary.simpleMessage("Chiudi"),
      "closeCommunity": (Object a0) => "Chiudere ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Chiudila"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Chiudi questa community"),
      "communities": MessageLookupByLibrary.simpleMessage("Community"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Trovane una in Scopri o creane una tua."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Lancia un'opinione forte (o tiepida)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Cosa ti frulla per la testa?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Di' qualcosa che solo tu puoi dire…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "Questo è il tuo segnale: invialo"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Scrivi, parla o pensa ad alta voce"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Conferma password"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Contatta l'assistenza"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "I post non indicano ancora una lingua, quindi oggi questo non filtra il tuo feed. La tua scelta viene conservata per quando lo faranno."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Continua"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Continua con l'email"),
      "copy": MessageLookupByLibrary.simpleMessage("Copia"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Copia invece il report"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Impossibile aprire l'accesso con Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Impossibile uscire: ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
          "Impossibile scattare quella foto."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Mostrato sul tuo profilo e sotto i tuoi post."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Nessun paese corrisponde a “{query}”."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Non mostrare nessun paese"),
      "country_search": MessageLookupByLibrary.simpleMessage("Cerca paesi"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Mostrato sul tuo profilo e sotto i tuoi post. Quando vedi i post di qualcuno, il tuo paese viene contato nelle sue Statistiche, solo in gruppi di cinque o più e mai per nome."),
      "country_suggested": MessageLookupByLibrary.simpleMessage(
          "Dalle impostazioni del telefono"),
      "create": MessageLookupByLibrary.simpleMessage("Crea"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Crea account"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Crea il tuo account"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Crea il tuo profilo"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("Lente AR"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("Vai in diretta"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("Post di testo"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("Post vocale"),
      "delete": MessageLookupByLibrary.simpleMessage("Elimina"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Eliminare questo commento?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Eliminare questo post?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Descrivi questo allegato"),
      "description": MessageLookupByLibrary.simpleMessage("Descrizione"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID copiato negli appunti"),
      "done": MessageLookupByLibrary.simpleMessage("Fatto"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Chiudi l'editor con qualcosa di scritto e ti verrà proposta una bozza."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("{days} giorni fa"),
      "draft_hours_ago": MessageLookupByLibrary.simpleMessage("{hours} ore fa"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Proprio ora"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} minuti fa"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Ancora niente di scritto"),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
          "Un sondaggio, ancora senza domanda"),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage(
          "Una citazione, ancora senza testo"),
      "drafts": MessageLookupByLibrary.simpleMessage("Bozze"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Modifica profilo"),
      "email": MessageLookupByLibrary.simpleMessage("Email"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Notifiche via email"),
      "explore": MessageLookupByLibrary.simpleMessage("Esplora"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Il rilevamento del volto non è disponibile su questo dispositivo."),
      "feedTagDetail": (Object a0) => "Ancora nulla pubblicato in #${a0}.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Segui {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Follower"),
      "following": MessageLookupByLibrary.simpleMessage("Seguiti"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Password dimenticata?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Ottenere aiuto"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Continua con Google"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("Accedi con Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google riconsegna l'accesso completato a Kyron tramite un link a cui rispondono solo Android e iOS, quindi su ${a0} il browser non saprebbe dove riportarlo.\\n\\nSe hai già un account Kyron tramite Google, usa Continua con l'email con lo stesso indirizzo e tocca Password dimenticata: ti invieremo un link per impostarne una.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "L'accesso con Google richiede l'app per telefono"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Registrati con Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Guide e risposte alle domande frequenti"),
      "handle": MessageLookupByLibrary.simpleMessage("nome utente"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Aiuto e supporto"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Centro assistenza"),
      "home": MessageLookupByLibrary.simpleMessage("Home"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("In una riga"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Il tuo account"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Apri la community"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Scrivi un post"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("Vedi il post"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Modifica il profilo"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Quando ci sono"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Nel tuo fuso orario."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Età"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Tra le {known} persone raggiunte che hanno indicato un compleanno."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Persone raggiunte ogni giorno"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Community di cui fanno parte"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Paesi"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Dalle {known} persone raggiunte che hanno un paese nel profilo."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Ultimi {days} giorni"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare le statistiche"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Follower"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Nessun gruppo è ancora abbastanza grande da mostrare."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Come crescere"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Argomenti che seguono"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Mi piace"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Nuovo"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Nuovi follower"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Nessuno dei tuoi post ha raggiunto qualcuno in questo periodo."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Non ti seguono"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "I paesi sono quelli che le persone hanno scelto sul proprio profilo. Kyron non raccoglie la città o il genere di nessuno, quindi non c'è nulla da mostrare per questi."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Aperture"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} raggiunte · {likes} mi piace · {replies} risposte"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Persone raggiunte"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Ogni persona conta una volta sola: le è stato mostrato o ha aperto per la prima volta uno dei tuoi post. I nuovi follower ti seguono ancora; chi smette di seguirti non viene contato."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Risposte"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Ripubblicazioni"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Salvataggi"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Chi è il tuo pubblico si vede quando {floor} persone hanno visto i tuoi post in questo periodo. Con meno, potrebbe indicare qualcuno."),
      "ins_small_title": MessageLookupByLibrary.simpleMessage(
          "Non ci sono ancora abbastanza persone"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "Il {pct}% ti segue già: i tuoi post raggiungono soprattutto chi ti conosce."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "Il {pct}% non ti segue ancora: i tuoi post vengono scoperti."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Hai raggiunto {reach} persone, il {pct}% in meno del periodo precedente."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Hai raggiunto {reach} persone negli ultimi {days} giorni."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Hai raggiunto {reach} persone, più o meno come nel periodo precedente."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Nessuno di nuovo ha visto i tuoi post negli ultimi {days} giorni."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Hai raggiunto {reach} persone, il {pct}% in più del periodo precedente."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Hai raggiunto {reach} persone, {times}× rispetto al periodo precedente."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "In più seguono {name} che qualsiasi altro argomento."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Pubblico"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Panoramica"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Chi trova uno dei tuoi post guarda il tuo profilo prima di seguirti. Un volto o un logo gli dice che c'è qualcuno."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Aggiungi una foto profilo"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Di' in una riga di cosa scrivi, così uno sconosciuto sa cosa gli dà seguirti."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Scrivi una bio"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} dei tuoi {total} post non avevano un argomento. Un argomento mette il post nel feed di quell'argomento e davanti a chi lo segue."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Aggiungi argomenti ai post"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} persone hanno risposto ai tuoi post e tu ne hai risposte {answered}. Ci tenevano abbastanza da scrivere: una risposta trasforma un lettore in un habitué."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Rispondi alle risposte"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Il tuo pubblico è più attivo il {when}. Un post pubblicato poco prima trova qualcuno ad accoglierlo."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Pubblica quando ci sono"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} persone che non ti seguono hanno visto i tuoi post, e {gained} ti hanno seguito. Fai dire alla bio e ai post più recenti cosa possono aspettarsi da te."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Trasforma i lettori in follower"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Un post ha raggiunto {times}× le persone che raggiungono di solito gli altri. Guarda cosa ha fatto di diverso e fallo di più."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "Fai di più di ciò che ha funzionato"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Molte delle persone che vedono i tuoi post sono in {name}. Pubblicare lì ti mette davanti al resto."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Pubblica in {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Hai pubblicato {posts} volte in {days} giorni. Ogni post è un'altra occasione per farti trovare, e un ritmo costante ti tiene nei feed dei tuoi follower."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Pubblica più spesso"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Non hai pubblicato negli ultimi {days} giorni. Senza un post non arriva niente a nessuno."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Pubblica qualcosa"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Statistiche"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Post migliori"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Rispetto ai {days} giorni precedenti"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Aggiungi un interesse"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("Trascina per riordinare"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "La barra contiene al massimo cinque schede. Rimuovine una per aggiungerne un'altra."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Seguiti"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Per te"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Gli hashtag compaiono qui man mano che le persone iniziano a usarli."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Di tendenza ora"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Video"),
      "interest_your_tabs":
          MessageLookupByLibrary.simpleMessage("Le tue schede"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Sparisce per entrambi."),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
          "Verrà rimosso dalla discussione."),
      "join": MessageLookupByLibrary.simpleMessage("Unisciti"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Continua a modificare"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Le schermate di Kyron sono nella tua lingua. Se una parola suona male, diccelo con Invia feedback."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Lingue"),
      "leave": MessageLookupByLibrary.simpleMessage("Esci"),
      "leaveCommunity": (Object a0) => "Lasciare ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Riammetti"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 pagina aperta"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Aggiungi una clip"),
      "literaladdAGif":
          MessageLookupByLibrary.simpleMessage("Aggiungi una GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Aggiungi un hashtag"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Aggiungi una foto"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Aggiungi un sondaggio"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Aggiungi un video"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Aggiungi un interesse"),
      "literaladdLabelAsATab": (Object a0) => "Aggiungi ${a0} come scheda",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Lingua dell'app"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Versione dell'app"),
      "literalblockAuthor": (Object a0) => "Blocca ${a0}",
      "literalblockAuthor2": (Object a0) => "Bloccare ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Bloccare questo account?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Annulla risposta"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Controlla di nuovo"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Scegli dalla galleria"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Svuota la cache"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Chiudi tutte le pagine"),
      "literalcloseTabLabel": (Object a0) => "Chiudi ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Chiudi il browser"),
      "literalcloseWidgetCommunityName": (Object a0) => "Chiudere ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Contatta l'assistenza"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Lingue dei contenuti"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Copia link"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Copia il link al post"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Copia il testo del post"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Copia testo"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare le community"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Impossibile caricare le GIF"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare le notifiche"),
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("Impossibile caricare i membri"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare questi post"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Impossibile caricare questa conversazione"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare questo elenco"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare questo post"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare questa risposta"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare i tag di tendenza"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Impossibile caricare le tue community"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare i tuoi messaggi"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Impossibile aprire questa community"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Impossibile pubblicare quella risposta."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Impossibile cercare"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Impossibile uscire: ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} pagine aperte",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Foto di copertina"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Risparmio dati"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("Elimina post"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Scopri persone"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("Non rispondere"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Bozza salvata"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Al momento non è possibile inviare feedback"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Dimensione del testo"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("Le GIF non sono configurate"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Passalo a un'altra app"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Nascondi password"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Nascondi questo post"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Lo nasconde e ci dice di mostrarne meno di questo tipo"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Come comportarsi"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Continua a scrivere"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron non ha risposto"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "Data \\${a0}",
      "literalleaveCommunityName": (Object a0) => "Lasciare ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, lente per il viso",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Post che ti piacciono"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("Link copiato"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Nomina moderatore"),
      "literalmuteAuthor": (Object a0) => "Silenzia ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Silenzia questa discussione"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Silenzia parole o tag"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("Account silenziati e bloccati"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Silenziato. Non riceverai notifiche."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Nessuna app su questo dispositivo apre i link ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Nessun browser su questo dispositivo ha aperto quel link."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("Ancora nessun DID"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("Nessuna bozza"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Ancora nessun interesse"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Ancora nessun Mi piace"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Ancora nessun messaggio"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Nessun nuovo follower"),
      "literalnoPostsYet":
          MessageLookupByLibrary.simpleMessage("Ancora nessun post"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Ancora nessuna risposta"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Ancora nessun repost"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Nessun tag di tendenza corrisponde"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Nessuno trovato"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Nessuno è stato rimosso"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Ancora nessuno qui"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Non mi interessa"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Nessun risultato"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("Ancora niente di tendenza"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Ancora nulla nel log"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Nessun risultato"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Niente di silenziato"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Ancora niente da vedere"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Niente da leggere"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Solo il proprietario può modificarlo"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Apri risposta"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Apri l'email di Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Password e accesso"),
      "literalpostInCommunityName": (Object a0) => "Pubblica in ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Pubblica in ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Pubblicalo con le tue parole sopra"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Lingua principale"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Notifiche push"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Lettura…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Registra un post vocale"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Registra di nuovo"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Rimuovi da moderatore"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Rimuovi dalla community"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Rimuovi dai salvati"),
      "literalremoveLabel": (Object a0) => "Rimuovi ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Rimuovi ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Rimuovere ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Rimuovi il sondaggio"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Rimuovi questa risposta"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Rimuovi questa conversazione"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Rimuovi questo sondaggio"),
      "literalreportAuthor": (Object a0) => "Segnala ${a0}",
      "literalreportPost": MessageLookupByLibrary.simpleMessage("Segnala post"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Invia di nuovo il codice"),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage("Post salvati"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Scrivi qualcosa"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Scrivi qualcosa a ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Ricerca non riuscita"),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("Invia di nuovo"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "Invia di nuovo tra ${a0} s",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Invia feedback"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Invia il link"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Inviato. È il report n. ${a0}.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "Imposta una password e continua"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Condividi il log con l'assistenza"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Condividi questa community"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Condividi questa pagina"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Condividi questo profilo"),
      "literalshareVia":
          MessageLookupByLibrary.simpleMessage("Condividi tramite…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Condividi con una citazione"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Mostra più post come questo"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Mostra password"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Mostra risultati"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Crea una community"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Avvia registrazione"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Interrompi caricamento"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Non vedere più questo post e le sue risposte"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Barra delle storie, ${a0} elementi",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Cambia fotocamera"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Tagga qualcuno"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Scatta una foto"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Tocca il banner o l'immagine per cambiarli"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Tocca il link al suo interno"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Tocca per aggiungere una foto e una copertina"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Non è andata a buon fine. Riprova."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Impossibile scaricare quella GIF."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Quel link non può essere aperto qui."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("La fotocamera è chiusa"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Questa community"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Questa risposta non c'è più"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Traduci post"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Disattiva l'audio"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Attiva l'audio"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Usa una delle nostre"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Codice di verifica inviato di nuovo."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Verifica non riuscita: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Verifica email"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Spettatori, Mi piace, salvataggi e commenti"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Cosa conserva Kyron"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Cosa ha fatto questa app"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Cosa hai fatto, cosa ti aspettavi, cosa è successo "),
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("Ciò che pubblichi è tuo"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Se Kyron è raggiungibile in questo momento"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Chi può rispondere"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Chi vuoi taggare?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Segui già tutti i tag di tendenza"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Sei in pari"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Non fai parte di nessuna community"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Sei uscito."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Hai lasciato ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Non hai ancora pubblicato"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Carica altro"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Log cancellato"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Log copiato"),
      "logIn": MessageLookupByLibrary.simpleMessage("Accedi"),
      "logOut": MessageLookupByLibrary.simpleMessage("Esci"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Uscire?"),
      "login": MessageLookupByLibrary.simpleMessage("Accesso"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Accesso non riuscito. Controlla le credenziali."),
      "manage": MessageLookupByLibrary.simpleMessage("Gestisci"),
      "menu": MessageLookupByLibrary.simpleMessage("Menu"),
      "message": MessageLookupByLibrary.simpleMessage("Messaggio"),
      "messages": MessageLookupByLibrary.simpleMessage("Messaggi"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "Tutte le conversazioni sono in pari."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Apri il profilo di qualcuno e tocca Messaggio per iniziare una conversazione."),
      "mute": MessageLookupByLibrary.simpleMessage("Silenzia"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Silenziati e bloccati"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Parole e tag silenziati"),
      "name": MessageLookupByLibrary.simpleMessage("Nome"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Schermata <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Nuovo indirizzo email"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Nuova password"),
      "newPost": MessageLookupByLibrary.simpleMessage("Nuovo post"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Non ora"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Non inviato. Tocca per riprovare"),
      "nothingMatchesQuery": (Object a0) =>
          "Niente su Kyron corrisponde a \"${a0}\"",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Niente da copiare"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Mi piace, risposte e nuovi follower arrivano qui."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Le persone che ti seguono compaiono qui."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Quando qualcuno mette Mi piace a un tuo post, compare qui."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Le risposte ai tuoi post arrivano qui."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Quando qualcuno ti ripubblica, compare qui."),
      "notifications": MessageLookupByLibrary.simpleMessage("Notifiche"),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("Apri nel browser"),
      "or": MessageLookupByLibrary.simpleMessage("oppure"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Pagina non trovata"),
      "password": MessageLookupByLibrary.simpleMessage("Password"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Password troppo corta"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Scegli i tuoi interessi"),
      "post": MessageLookupByLibrary.simpleMessage("Pubblica"),
      "postAnalytics":
          MessageLookupByLibrary.simpleMessage("Statistiche del post"),
      "postInCommunity": (Object a0) => "Pubblica in ${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Pubblicalo, dillo, mostralo."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Testo del post copiato"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Informativa sulla privacy"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profilo aggiornato"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Paese"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Nome visualizzato"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Posizione"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Tocca per cambiare"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Sito web"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Notifiche push"),
      "quote": MessageLookupByLibrary.simpleMessage("Cita"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Cita post"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Parla con una persona"),
      "remove": MessageLookupByLibrary.simpleMessage("Rimuovi"),
      "removeConversation": MessageLookupByLibrary.simpleMessage(
          "Rimuovere questa conversazione?"),
      "removeMember": (Object a0) => "Rimuovere ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Rimuovere questo messaggio?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("Risposte, follower e menzioni"),
      "repliesPolicy": (Object a0) => "Risposte: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Rispondi"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Chiunque può interagire"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Chiunque può ancora vedere, ripubblicare e citare questo post."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Chiunque su Kyron può rispondere a questo post."),
      "reply_followers": MessageLookupByLibrary.simpleMessage("Chi ti segue"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Solo chi ti segue può rispondere a questo post."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Le persone che menzioni"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Solo le persone che @menzioni in questo post possono rispondere."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Nessuno può rispondere"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Le risposte sono disattivate. Tu puoi comunque rispondere."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Chi può rispondere?"),
      "report": MessageLookupByLibrary.simpleMessage("Segnala"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Report copiato. Incollalo in un'email all'assistenza."),
      "reportSent":
          MessageLookupByLibrary.simpleMessage("Segnalazione inviata"),
      "repost": MessageLookupByLibrary.simpleMessage("Repost"),
      "reset": MessageLookupByLibrary.simpleMessage("Reimposta"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Reimposta la password"),
      "retry": MessageLookupByLibrary.simpleMessage("Riprova"),
      "save": MessageLookupByLibrary.simpleMessage("Salva"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Salva bozza"),
      "saySomething": (Object a0) => "Scrivi qualcosa a ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Cerca"),
      "searchByNameOrHandle":
          MessageLookupByLibrary.simpleMessage("Cerca per nome o nome utente"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Cerca community"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Cerca GIF"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Cerca lingue"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Cerca tag di tendenza"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Avvisi di sicurezza e modifiche all'account"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Scegli la lingua dell'interfaccia dell'app."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Scegli quali lingue includere nei tuoi feed. Se non ne scegli nessuna, verranno mostrate tutte."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Scegli la lingua preferita per le traduzioni nel tuo feed."),
      "send": MessageLookupByLibrary.simpleMessage("Invia"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Invia conferma"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Invia report di errore"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Invia feedback"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Invia segnalazione"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Invia all'assistenza"),
      "serviceStatus":
          MessageLookupByLibrary.simpleMessage("Stato del servizio"),
      "settings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Condividi il log dell'app con l'assistenza"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Accedi a Kyron"),
      "signedInAs":
          MessageLookupByLibrary.simpleMessage("Accesso effettuato come"),
      "signupFailed": (Object a0) => "Registrazione non riuscita: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Resta"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron è agli inizi e il modo più rapido per raggiungere chi può risolvere un problema è aprire una segnalazione. Indica cosa stavi facendo e cosa è successo invece."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Non c'è ancora una casella di assistenza nell'app, quindi questa schermata rimanda al posto davvero seguito invece che a un modulo che non porta da nessuna parte."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Log di sistema"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Dicci cosa manca o non funziona"),
      "terms": MessageLookupByLibrary.simpleMessage("Termini"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Testo, voce e video, le persone che li creano e le stanze in cui parlano."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "L'editor non ha il pulsante Pubblica"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Scuro"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Sempre scuro"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Attenuato"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Uno scuro più morbido, grigio-blu invece che nero"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Chiaro"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Sempre chiaro"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Sistema"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Segui l'impostazione chiara o scura del telefono"),
      "translate": MessageLookupByLibrary.simpleMessage("Traduci"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "La traduzione non è ancora disponibile. Oggi nel tuo feed non viene tradotto nulla; la scelta viene ricordata per quando lo sarà."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Cambia le parole di Kyron, le parti dell'interfaccia che Flutter disegna da sé, date e numeri e la direzione in cui l'app si dispone per le lingue da destra a sinistra."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Riprova"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Informativa sulla privacy"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Termini di servizio"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Account"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Dopo"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("App e dispositivo"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Stavo citando la truffa per mettere in guardia le persone."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Spiega perché pensi che la decisione sia sbagliata: cosa intendeva il post, cosa potrebbe essere sfuggito al team o perché la regola non è adatta. Lo legge una persona diversa da chi ha deciso."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Il tuo ricorso"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Scrivi almeno \$count caratteri. Puoi fare ricorso contro ogni decisione una sola volta."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Invia ricorso"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Ricorso inviato. Riceverai una notifica quando verrà presa una decisione."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Ricorso sul caso \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Aspetto"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Chiaro, scuro o come è impostato il telefono"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Prima"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Nessuno di voi due vedrà l'altro su Kyron e ogni follow tra voi viene rimosso. Non viene avvisato."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Con"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("A cosa serve (facoltativo)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Solo i moderatori possono scrivere"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Per gli annunci. Tutti nella community possono comunque leggere e reagire."),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "Aggiungi una foto o un sondaggio"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Foto e video"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Chiudi chat"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Nessuno potrà più leggerla né scriverci. L’azione non si può annullare."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Chiudere questa chat?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Copiato"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Il messaggio viene rimosso per tutti. Kyron ne conserva una copia per la revisione."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Il messaggio viene rimosso per tutti nella chat."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Modifica chat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Modifica"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("modificato"),
      "ui_cchat_editing": MessageLookupByLibrary.simpleMessage(
          "Stai modificando il tuo messaggio"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile aprire questa chat."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Unisciti alla chat"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Unisciti alla community per vedere le sue chat e partecipare."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count iscritti"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Esci dalla chat"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Potrai comunque leggerla finché sei nella community."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Solo il proprietario e i moderatori possono scrivere qui."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Silenzia"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Nessuna notifica da questa chat, e non viene contata nei Messaggi."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Nome della chat"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Nuova chat"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Ancora nessuna chat."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Ancora nessuna chat. Aprine una per la community."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Le chat della community non sono crittografate end-to-end. I moderatori della community e Kyron possono leggerle."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Fissa in alto"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Aggiungi una risposta"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Chiudi sondaggio"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Chiuso"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Tutti vedono quante persone hanno scelto ogni risposta, mai chi."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Consenti più scelte"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Nuovo sondaggio"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Scegline una"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Risposta \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Sondaggio: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Domanda"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Ogni risposta può comparire una sola volta in un sondaggio."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Scegline una o più"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count hanno risposto"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Cerca in questa chat"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Cerca in questa chat"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Nessun risultato."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Non puoi più vedere questa chat."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Modalità lenta"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Quanto si aspetta tra un messaggio e l’altro. Non vale per i moderatori."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 ora"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minuti"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Modalità lenta: un messaggio ogni \$seconds secondi"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Disattivata"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n secondi"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Puoi leggere e reagire come spettatore. Unisciti per scrivere."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Quel messaggio è troppo indietro per essere mostrato."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Qualcosa che hai scelto è troppo grande da inviare ed è stato escluso."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Riattiva notifiche"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Non fissare più"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Registra un messaggio vocale"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Tu"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Community"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("A cosa serve? (facoltativo)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Post:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Contenuti e visualizzazione"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare il tuo feed"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare i post che ti piacciono"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare il tuo profilo"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare i post salvati"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("ID decentralizzato"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnostica"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Gruppi"),
      "ui_dm_groups_none":
          MessageLookupByLibrary.simpleMessage("Nessun gruppo"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Qui trovi i gruppi di cui fai parte e le chat delle community a cui ti unisci."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Puoi fissare fino a \$count chat. Prima toglierne una."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Fissata"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Mi piace"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Salvati"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Ancora niente qui"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Segui qualche account e i suoi post compariranno qui."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "Niente dalle persone che segui"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "I post compariranno qui man mano che le persone li scrivono."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("In calo"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Non mi interessa"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Mostra di più come questo"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("Rimosso"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("I segnali del tuo feed"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Tocca Mostra più post come questo o Non mi interessa su un post e comparirà qui."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Ancora niente qui"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Cosa dicono ai tuoi feed Mostra di più e Non mi interessa"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Danno forma a Home ed Esplora, soprattutto in base all'argomento di ogni post. Ognuno si dimezza ogni mese e smette di contare dopo sei. Rimuovine uno per fermarlo subito."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "I post con una clip compariranno qui."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Ancora nessun video"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Trova persone su Kyron"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Da un account"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Aggiungi persone"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Aggiungi"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Aggiungi nome del gruppo"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Ignora"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "I messaggi in questo gruppo sono crittografati end-to-end, come in ogni altra conversazione."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor ha aggiunto \$users"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor ha reso \$users admin"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor ha creato il gruppo"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor fa entrare le nuove persone come membri"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor fa entrare le nuove persone come spettatori"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor è uscito"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor ha reso \$users membro"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor ha reso \$users proprietario"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor ha rimosso \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor ha rinominato il gruppo in \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor ha reso \$users spettatore"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Un gruppo può avere al massimo \$count persone."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Mano alzata. Gli admin sono stati avvisati."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count chiedono di scrivere"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Chiedono di scrivere"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Chi viene aggiunto dopo entra come spettatore"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Esci dal gruppo"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Sparisce dalla tua lista e non vedrai cosa verrà detto dopo. Qualcuno dovrebbe aggiungerti di nuovo."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Uscire da questo gruppo?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Lascia scrivere"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Abbassa la mano"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Rendi admin"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Rendi proprietario"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Rendi spettatore"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count membri"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Membri"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Nome del gruppo"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Prima dai un nome al gruppo."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Crea chat di gruppo"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "C’è un solo proprietario. Resterai admin."),
      "ui_group_owner_title": MessageLookupByLibrary.simpleMessage(
          "Rendere \$name il proprietario?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Alza la mano"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Rimuovi dal gruppo"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Rimuovi da admin"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Non fai più parte di questo gruppo."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Rinomina"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Amministratore"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Membro"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Spettatore"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Come spettatore, qui puoi leggere e reagire."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Gli spettatori possono leggere, reagire e alzare la mano per chiedere di scrivere."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Suggeriti"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Vedi profilo"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("tu"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Sei uno spettatore"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Aiuto"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Preso nota. Aiuta a decidere cosa ti viene mostrato."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Unisciti"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Iscritto"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Lingua"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Scegli la tua lingua"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Note legali"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Mi piace"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Post che ti piacciono"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "I post che ti piacciono compaiono qui, dai più recenti."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Link copiato"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Non vedrai più i suoi post. Non viene avvisato."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Ancora nessun Mi piace"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Nessun post corrisponde a quei filtri."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Ancora niente di salvato"),
      "ui_notif_account_update": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è stato aggiornato"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Il tuo ricorso sul caso \$number è stato accolto"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Abbiamo riesaminato il tuo ricorso sul caso \$number e la decisione resta valida"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è stato bannato"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Caso \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("ha iniziato a seguirti"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("ha messo mi piace al tuo post"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("ti ha menzionato"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Ancora nessuna menzione"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Quando qualcuno scrive il tuo @nome utente in un post o in una risposta, comparirà qui."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Meno recenti"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Il tuo messaggio in una chat della community è stato rimosso"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Qualcosa che hai pubblicato è stato rimosso"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Il tuo post è stato rimosso"),
      "ui_notif_removed_reply": MessageLookupByLibrary.simpleMessage(
          "La tua risposta è stata rimossa"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("ha risposto al tuo post"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Abbiamo preso provvedimenti su qualcosa che hai segnalato. Grazie per avercelo detto."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Abbiamo esaminato qualcosa che hai segnalato e non abbiamo riscontrato violazioni delle nostre regole."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Segnalato per: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("ha ripubblicato il tuo post"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Abbiamo annullato il caso \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Il tuo account è sospeso"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è sospeso fino al \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Tutte"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Mi piace"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("Menzioni"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Risposte"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Questa settimana"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Oggi"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Il tuo account ha ricevuto un avvertimento"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Ieri"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Fine"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Salta"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("È già stato aperto."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Scaduto"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Impossibile aprirlo."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Si apre una volta, poi viene eliminato da Kyron."),
      "ui_once_label":
          MessageLookupByLibrary.simpleMessage("Visualizza una volta"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Aperto"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Aperto da \$count su \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Solo le persone a cui l’hai inviato possono aprirlo, una volta."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Invia con visualizzazione singola"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Tocca per vedere"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pausa"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Riproduci"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Viene rimosso dal tuo profilo e dal feed di tutti. Le risposte se ne vanno con lui."),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("Post eliminato"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("Post nascosto"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Testo del post copiato"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Pubblicato tra"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Nascosto. Ti mostreremo meno contenuti simili."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Preferenze"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Qualcosa da aggiungere? (facoltativo)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Riceverai una notifica quando il team avrà deciso e puoi seguire la segnalazione in Le tue segnalazioni."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Se vuoi anche smettere di vedere questa persona, silenziala o bloccala dallo stesso menu."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Segnalare due volte la stessa cosa non le dà più peso: teniamo una segnalazione per persona."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "La tua segnalazione non viene condivisa con l'altra persona. Conserviamo una copia di ciò che hai segnalato, così può essere esaminato anche se viene eliminato."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "La tua segnalazione è stata ricevuta ed è in coda per la revisione. Non diciamo all'altra persona chi l'ha segnalata."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Vedi le tue segnalazioni"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Dicci cosa non va"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Grazie per avercelo detto"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Cosa non va con \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Cosa non va in questo messaggio?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("Cosa non va in questo post?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Cosa non va in questa risposta?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Un messaggio in una chat della community"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Un post"),
      "ui_reports_a_reply":
          MessageLookupByLibrary.simpleMessage("Una risposta"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Provvedimento preso"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("Un account"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Deciso il \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Nessuna regola violata"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare le tue segnalazioni"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Quello che hai segnalato negli ultimi 90 giorni e com'è andata. Ricevi una notifica quando il team decide. Chi segnali non sa mai chi l'ha segnalato."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Nessuna segnalazione"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Quando segnali un post, una risposta, un messaggio o un account, compare qui con com'è andata."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("In revisione"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Segnalato il \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Cosa hai segnalato e com'è andata"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Le tue segnalazioni"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Sicurezza dei minori"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Qualsiasi cosa che metta in pericolo o sessualizzi un minore."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Abusi mirati, minacce o contatti indesiderati."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Attacchi alle persone per ciò che sono."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Vendita o promozione di qualcosa di illegale."),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("Fingersi qualcun altro."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Usa la tua opera o il tuo marchio senza permesso."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Affermazioni fuorvianti su salute, elezioni o eventi."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Incoraggiare o mostrare l'autolesionismo."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Contenuti sessuali mostrati senza avviso."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Nessuna delle precedenti. Dicci cosa non va."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Promozione ripetitiva, ingannevole o indesiderata."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Minacciare, esaltare o incitare a fare del male."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Molestie o bullismo"),
      "ui_rule_hate":
          MessageLookupByLibrary.simpleMessage("Incitamento all'odio"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Beni o servizi illegali"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Sostituzione di persona"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Proprietà intellettuale"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Informazioni false"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Suicidio o autolesionismo"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Contenuti per adulti"),
      "ui_rule_something_else": MessageLookupByLibrary.simpleMessage("Altro"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spam"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Violenza o minacce"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("Post salvati"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Tocca l'icona dell'archivio su un post per tenerlo qui. Solo tu vedi ciò che salvi."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Cerca per nome utente o nome visualizzato."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Cancella"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "Cerca in tutto ciò che è stato pubblicato"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filtri"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Cerca persone"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("Cerca post"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("App e dispositivo"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Contenuti e visualizzazione"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Risparmio dati"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Dicci cosa ne pensi"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Sfoglia gli articoli di aiuto"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Scegli la tua lingua"),
      "ui_settings_muted_blocked":
          MessageLookupByLibrary.simpleMessage("Chi hai silenziato o bloccato"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Preferenze di notifica"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Il tuo profilo e i tuoi dati di contatto"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Dovrai accedere di nuovo per tornare al tuo account."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Impostazioni di sicurezza"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Conferma password"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("In una riga"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Nuovo indirizzo email"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Nuova password"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Cosa è successo"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("Ricevi aiuto dal nostro team"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Condividi"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Cita"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Invia in un messaggio"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("A persone su Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Condividi questo post"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Di cosa si trattava"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è stato bannato"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("La risposta, il \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Ricorso"),
      "ui_standing_appeal_button": MessageLookupByLibrary.simpleMessage(
          "Fai ricorso contro questa decisione"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Non è più possibile fare ricorso contro questa decisione. Se qualcosa non va, contatta l'assistenza."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Ricorso in esame"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Ricorso accolto"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Un'altra persona del team la sta riesaminando. Riceverai una notifica quando verrà presa una decisione."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Se pensi che sia un errore, puoi chiedere un riesame fino al \$date. Decide un'altra persona del team."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Ricorso esaminato: la decisione resta valida"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Caso \$number. Regola: \$rule. Il team ha scritto:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Eliminare il tuo account non revoca un ban: anche un nuovo account con lo stesso indirizzo email parte bannato."),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("Bannato"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Funzionano ancora solo questa pagina, i ricorsi, l'assistenza e l'eliminazione dell'account."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Puoi fare ricorso"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Caso \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Deciso il \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Decisioni sul tuo account"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Elimina il tuo account"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Vedi dettagli"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("Vedi dettagli e fai ricorso"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Termina il \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Il tuo account è in regola"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Nessuna limitazione attiva."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare lo stato dell'account"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Messaggio rimosso"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Non è stato deciso nulla sul tuo account. Se il team dovesse rimuovere qualcosa di tuo o limitare il tuo account, lo troverai qui con il motivo e potrai fare ricorso."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Niente da contestare: la decisione è stata annullata."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Post rimosso"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Trascina verso il basso per ricontrollare."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Leggi le regole di Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Risposta rimossa"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Annullata"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Annullata il \$date. Tutto ciò che era stato rimosso è tornato e nessuna limitazione è più in vigore."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Regola: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Esci"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("Sospeso"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Puoi leggere, ma non pubblicare, rispondere, seguire o inviare messaggi. Segnalare, bloccare e silenziare funzionano ancora."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è sospeso: puoi leggere, ma non pubblicare."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Sospeso fino al \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è sospeso fino al \$date: puoi leggere, ma non pubblicare."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Cosa ha detto il team"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Stato dell'account"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Avvertimento"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Perché?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Hai scritto, il \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Il tuo messaggio"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Il tuo post"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("La tua risposta"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Termini"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("questo post"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Discussione silenziata"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Riprova"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Disattiva l'audio"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("Attiva l'audio"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Due caratteri o più."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Annulla"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Parole, o un filtro: un account, un intervallo di date o cosa contiene un post."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Annulla repost"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Aggiorna password"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Usa un altro indirizzo"),
      "username": MessageLookupByLibrary.simpleMessage("Nome utente"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Il nome utente deve essere in minuscolo (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Allega"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Pronto da allegare"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Registra un post vocale"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Registrazione…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Ferma"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Cosa è successo"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Cosa è successo e cosa dovremmo controllare?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Cosa c'è in questa immagine?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("A cosa serve? (facoltativo)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Cosa hai fatto, cosa ti aspettavi, cosa è successo"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Cosa stavi facendo quando è successo."),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("Hai risposto"),
      "dmReplied": (Object a0) => "$a0 ha risposto",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Aggiungi al messaggio"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Nuovo messaggio"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Non è stato ancora detto nulla. Un saluto è un buon inizio."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Saluta"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Nuovi messaggi"),
      "dmTyping": (Object a0) => "$a0 sta scrivendo",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Rimuovi la tua reazione"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Qualcuno"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Messaggio"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Allegato"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Questo messaggio non può essere letto su questo dispositivo."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "In attesa di questo messaggio. Potrebbe volerci un po’."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Messaggio crittografato"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "I messaggi sono crittografati end-to-end"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Non crittografato end-to-end"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Inviato"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Visualizzato"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Invio in corso…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Scatta una foto"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Altre opzioni"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Salva sul dispositivo"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Condividi"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Salvataggio…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Salvato nelle tue foto"),
      "ui_media_save_failed":
          MessageLookupByLibrary.simpleMessage("Impossibile salvare. Riprova."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Consenti a Kyron di aggiungere alle tue foto per salvarlo."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Tutti i sistemi operativi"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Disponibilità"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Ultimi 60 giorni"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 giorni fa"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Oggi"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Database"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Accesso"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Incidenti recenti"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Nessun incidente negli ultimi 60 giorni."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("In corso"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Nessun dato"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Dettagli"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron si controlla ogni 5 minuti mentre è in funzione. Un giorno grigio non ha avuto controlli."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "La cronologia della disponibilità non è ancora disponibile."),
      "ui_status_degraded":
          MessageLookupByLibrary.simpleMessage("Alcuni sistemi hanno problemi"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Registra un messaggio vocale"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Pronto da inviare"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Quel messaggio non c'è più."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Vai al messaggio"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Messaggio vocale"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Piace all'autore"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Aggiungi una foto o un clip"),
      "ui_dm_info_media":
          MessageLookupByLibrary.simpleMessage("Contenuti multimediali"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Messaggi vocali"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Sfondo"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Silenzia le notifiche"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Non ricevere più notifiche su questa conversazione"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("Non possono più scriverti"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Nessuno"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Notifiche riattivate."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile rimuoverla. Riprova."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profilo"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Riattiva"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Le foto e i clip che condividi compaiono qui."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Mostra tutto"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("Foto e clip"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Ecco come apparirà la tua chat."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Sta bene."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Foschia"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Crepuscolo"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Salvia"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Sabbia"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Puntini"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Applica"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Attuale"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Invia senza anteprima"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Cerca"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Pubblica"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Scrivi un messaggio…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Invia"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Inviato"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Inviato, ma non a tutti."),
      "ui_share_failed":
          MessageLookupByLibrary.simpleMessage("Impossibile inviare. Riprova."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtro"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Tutte"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Da leggere"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Senza risposta"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Nascoste"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Niente di nascosto"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Le conversazioni che togli dall'elenco aspettano qui, nel caso tu le voglia riavere."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Passa tra le Nascoste. L'altra persona tiene la sua, e torna se uno di voi due scrive di nuovo."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Ripristina"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Di nuovo nel tuo elenco."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "Nessuna conversazione corrisponde."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Niente ti aspetta"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ogni conversazione finisce con la tua parola."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Foto"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Ancora nessun messaggio"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Tu:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Ieri"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Messaggi"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Impostazioni dei messaggi"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Conferme di lettura"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Se disattivate, gli altri non vedranno quando hai letto i loro messaggi, e tu non vedrai quando loro hanno letto i tuoi."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Mostra quando scrivi"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "La persona a cui scrivi vede che stai scrivendo."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Anteprime dei link"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Il tuo telefono apre il link che invii per crearne l'anteprima, quindi il sito vede la richiesta del tuo telefono. Il server di Kyron non vede mai il link."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Notifiche dei messaggi"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "I messaggi sono crittografati end-to-end. Kyron non può leggerli, e niente qui lo cambia."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("A:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Recenti"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Persone"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Nessuno con questo nome."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Invia una notifica di prova"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Il server di Kyron non è ancora configurato per inviare notifiche, quindi non ne può arrivare nessuna. Il problema è nostro, non del tuo telefono."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Questo telefono non è registrato per le notifiche. Controlla che le notifiche di Kyron siano consentite nelle impostazioni del telefono, poi riprova."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Impossibile recapitare la notifica a questo telefono. Riprova tra un minuto."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Inviata. Dovrebbe arrivare in pochi secondi."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Le notifiche funzionano."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Ancora nessun post"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Nuova community"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Nome"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Il suo indirizzo nasce dal nome."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("La troveranno all'indirizzo"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Ne sarai il proprietario. Un'immagine, un banner e i moderatori si aggiungono dalla sua pagina, una volta creata."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Home"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Post delle community nella Home"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "I post delle tue community compaiono anche nella Home. Se disattivato, restano qui in Community, dove ognuna mostra cosa c'è di nuovo."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("La tua lista"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Conteggio dei nuovi post"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Mostra quanti post sono nuovi in ogni community dall'ultima volta che l'hai aperta."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Community che gestisci"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Qui trovi le community che crei o moderi."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Proprietario"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderatore"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Nuovi post"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Gestite da te"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Impostazioni community"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Scopri"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "Nessuna community corrisponde."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Niente di nuovo"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Ogni community è come l'hai lasciata."),
      "ui_community_running_none": MessageLookupByLibrary.simpleMessage(
          "Non ne gestisci ancora nessuna"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Non resta nulla a cui unirsi"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Sei in ogni community di Kyron. Creane un'altra."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Prova un'altra parola, o crea una community con quel nome."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Scrivi un post"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Membri:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Pubblicato"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Vedi"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Apri"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Online"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Mostra quando sei online"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Le persone a cui scrivi vedono un punto verde mentre hai Kyron aperto. Se lo disattivi, nemmeno tu vedrai il loro."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Cerca persone e post"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Community a cui unirti"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Ancora niente da vedere"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Le foto e le clip pubblicate dalle persone appariranno qui."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Segui"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Elimina account"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "In questo modo il tuo account Kyron viene eliminato per sempre. L'operazione non può essere annullata."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Il tuo profilo, i post, le risposte, i Mi piace e le ricondivisioni"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "I tuoi messaggi, compresi quelli che hai inviato ad altri, con le foto e i messaggi vocali che contengono"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "I tuoi follower, le persone che segui e le tue impostazioni"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Le community che hai creato passano al moderatore o al membro presente da più tempo. Una community senza nessun altro viene chiusa."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Eliminare il tuo account?"),
      "ui_delete_account_confirm_detail":
          MessageLookupByLibrary.simpleMessage("Non potrai recuperarne nulla."),
      "ui_delete_account_done": MessageLookupByLibrary.simpleMessage(
          "Il tuo account è stato eliminato."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Account eliminato"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Questo account è stato eliminato, quindi non è più possibile inviare messaggi qui."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Ti sei registrato con Google? Usa invece «Sign in with Google»."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare quella lente."),
      "ar_could_not_record": MessageLookupByLibrary.simpleMessage(
          "Impossibile registrare il video."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Non è stato possibile aggiungere la lente a questo video, quindi viene pubblicato così come è stato girato."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Il tuo post ha già il numero massimo di allegati."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Aggiunta della lente…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Flash"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("Registra un video"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Foto"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Video"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "L'accesso con Google è stato annullato."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("REGALI"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Nessuno ha ancora inviato un regalo a questo post."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Regalo"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Regali"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Monete"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Mittente"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Mittenti"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Monete di prova: non possono ancora essere prelevate."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Salvati"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Post"),
      "ui_saved_tab_comments": MessageLookupByLibrary.simpleMessage("Commenti"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Mostra altre risposte"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Modificato"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Altro"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Seguiti"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Più rilevanti"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Recenti"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Ordina commenti: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "ha inviato un regalo al tuo post"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "ha inviato un \$gift al tuo commento"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "ha inviato un \$gift al tuo post"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Invia un regalo"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Modifica post"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Puoi modificarlo ancora per \$n min"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Salva"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Non è ancora stato pubblicato nulla in #\$tab."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Scegli un regalo"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Monete insufficienti"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Monete di prova: non si possono acquistare e non hanno valore in denaro."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Si ricarica il \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 moneta"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count monete"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("Hai \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Invia \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift inviato"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Riprova"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "Per 15 minuti dopo la pubblicazione"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Modificato"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare i commenti salvati"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Nessun commento salvato"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Tocca l'icona dell'archivio sotto un commento per conservarlo qui. Solo tu vedi ciò che salvi."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("In risposta a \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Copia"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Cerca"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Seleziona tutto"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count regali"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 regalo"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare altri post."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Promemoria"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Le novità dopo un periodo di assenza e quando tornano le tue monete. Mai più di uno al giorno."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Regali"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("da 1 persona"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("da \$count persone"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("Miglior donatore"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare chi ha inviato regali."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Novità"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Ho capito"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Grazie. Leggiamo ogni risposta."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Come ti sembra Kyron finora?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Giorno \$day del tuo test. Basta un tocco."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Qualcosa da sistemare o aggiungere? (facoltativo)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Invia"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Non ora"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Premi di nuovo Indietro per uscire da Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("Conferma che sei tu"),
      "ui_confirm_its_you_password": MessageLookupByLibrary.simpleMessage(
          "Inserisci la password per eliminare l'account."),
      "ui_confirm_its_you_google": MessageLookupByLibrary.simpleMessage(
          "Accedi di nuovo con Google per eliminare l'account."),
      "ui_confirm_its_you_failed": MessageLookupByLibrary.simpleMessage(
          "Non ha funzionato. Controlla e riprova."),
      "ui_browser_leave_title": MessageLookupByLibrary.simpleMessage(
          "Questa pagina vuole aprire un'altra app"),
      "ui_browser_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Chiede di aprire un link {scheme}."),
    };

final messageLookup = MessageLookup();
