import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Un mot, une phrase ou un #tag"),
      "about": MessageLookupByLibrary.simpleMessage("À propos"),
      "addAnAnswer":
          MessageLookupByLibrary.simpleMessage("Ajouter une réponse"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Ajouter des langues…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Accepter et continuer"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Déjà sur Kyron ?"),
      "analytics_comments":
          MessageLookupByLibrary.simpleMessage("Commentaires"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
              "Personnes distinctes, pas ouvertures"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Engagement"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("J'aime"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Aucun lecteur pour l'instant"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Personne n'a encore ouvert cette publication."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Publiée"),
      "analytics_saves":
          MessageLookupByLibrary.simpleMessage("Enregistrements"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Lecteurs"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("LECTEURS PAR JOUR"),
      "and": MessageLookupByLibrary.simpleMessage("et"),
      "answerNumber": (Object a0) => "Réponse ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("Filtre RA"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Joindre le journal système"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Aller-retour"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("VÉRIFICATION DU JETON"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Réessayer"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Réessayer"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Lancer une diffusion maintenant vous placerait dans une salle que personne ne pourrait"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Créer une communauté"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage(
              "À quoi sert-elle ? (facultatif)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("revenir."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("revenir depuis cette liste."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("La fermer"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("rejoignez d'abord"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("bientôt"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Publié en votre nom"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("publier dans cette communauté"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("À l'instant"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Réessayer"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Sujet 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Pour vous"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("a quelque chose."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("son chemin vers elle."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", pas"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("est-ce que je bouge"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Couper le son"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Activer le son"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Pour vous"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Vos onglets"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Réessayer"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Symbole (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("LECTEURS PAR JOUR"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("impossible de charger"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("cette publication"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage(
              "Quelque chose à ajouter ? (facultatif)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("cette publication"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("D'un compte"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Se déconnecter"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Votre compte"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Confirmer le mot de passe"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("pas maintenant"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Chargement…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Publication…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("il y a 3 h"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Copier le lien de la story"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Votre story"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Votre compte, vos publications et ce que vous touchez, afin"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Ajouter un sujet"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("par elle-même."),
      "authorBlocked": (Object a0) => "${a0} bloqué",
      "authorPostsHidden": (Object a0) =>
          "Vous ne verrez plus les publications de ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Bloquer"),
      "blockAuthor": (Object a0) => "Bloquer ${a0} ?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Détails de la version copiés"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "En continuant, vous acceptez nos"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "En continuant, vous acceptez nos Conditions et notre Politique de confidentialité"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "En vous inscrivant, vous acceptez nos"),
      "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
      "change": MessageLookupByLibrary.simpleMessage("Modifier"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Changer d'e-mail"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Consultez vos e-mails pour confirmer votre compte."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Vérifier si Kyron est joignable"),
      "clear": MessageLookupByLibrary.simpleMessage("Effacer"),
      "close": MessageLookupByLibrary.simpleMessage("Fermer"),
      "closeCommunity": (Object a0) => "Fermer ${a0} ?",
      "closeIt": MessageLookupByLibrary.simpleMessage("La fermer"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Fermer cette communauté"),
      "communities": MessageLookupByLibrary.simpleMessage("Communautés"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Trouvez-en une dans Découvrir, ou créez la vôtre."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Lâchez un avis tranché (ou tiède)"),
      "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
          "Qu'est-ce qui vous trotte dans la tête ?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Dites ce que vous seul pouvez dire…"),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
          "C'est votre signal : envoyez-le"),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
          "Écrivez, parlez ou pensez à voix haute"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Confirmer le mot de passe"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Contacter l'assistance"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Les publications n'indiquent pas encore leur langue, ce réglage ne filtre donc pas encore votre fil. Votre choix est conservé pour plus tard."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Continuer"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Continuer avec un e-mail"),
      "copy": MessageLookupByLibrary.simpleMessage("Copier"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Copier le rapport à la place"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Impossible d'ouvrir la connexion Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Déconnexion impossible : ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
          "Impossible de prendre cette photo."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Affiché sur ton profil et sous tes publications."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Aucun pays ne correspond à « {query} »."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("N'afficher aucun pays"),
      "country_search":
          MessageLookupByLibrary.simpleMessage("Rechercher un pays"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Affiché sur ton profil et sous tes publications. Quand tu vois les publications de quelqu'un, ton pays est compté dans ses Statistiques, uniquement par groupes de cinq ou plus et jamais par ton nom."),
      "country_suggested": MessageLookupByLibrary.simpleMessage(
          "D'après les réglages de ton téléphone"),
      "create": MessageLookupByLibrary.simpleMessage("Créer"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Créer un compte"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Créez votre compte"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Créez votre profil"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("Filtre RA"),
      "create_go_live":
          MessageLookupByLibrary.simpleMessage("Passer en direct"),
      "create_text_post":
          MessageLookupByLibrary.simpleMessage("Publication texte"),
      "create_voice_post":
          MessageLookupByLibrary.simpleMessage("Publication vocale"),
      "delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Supprimer ce commentaire ?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Supprimer cette publication ?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Décrivez cette pièce jointe"),
      "description": MessageLookupByLibrary.simpleMessage("Description"),
      "didCopied": MessageLookupByLibrary.simpleMessage(
          "DID copié dans le presse-papiers"),
      "done": MessageLookupByLibrary.simpleMessage("Terminé"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Fermez l'éditeur avec du texte écrit et un brouillon vous sera proposé."),
      "draft_days_ago":
          MessageLookupByLibrary.simpleMessage("il y a {days} jours"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("il y a {hours} heures"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("À l'instant"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("il y a {minutes} minutes"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Rien d'écrit pour l'instant"),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage(
          "Un sondage, sans question pour l'instant"),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage(
          "Une citation, sans texte pour l'instant"),
      "drafts": MessageLookupByLibrary.simpleMessage("Brouillons"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Modifier le profil"),
      "email": MessageLookupByLibrary.simpleMessage("E-mail"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Notifications par e-mail"),
      "explore": MessageLookupByLibrary.simpleMessage("Explorer"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Le suivi du visage n'est pas disponible sur cet appareil."),
      "feedTagDetail": (Object a0) => "Rien n'a encore été publié sous #${a0}.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Suivre {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Abonnés"),
      "following": MessageLookupByLibrary.simpleMessage("Abonnements"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Mot de passe oublié ?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Obtenir de l'aide"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Continuer avec Google"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Se connecter avec Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google renvoie la connexion terminée à Kyron par un lien auquel seuls Android et iOS répondent : sur ${a0}, le navigateur n'aurait nulle part où la renvoyer.\\n\\nSi vous avez déjà un compte Kyron via Google, utilisez Continuer avec un e-mail avec la même adresse et touchez Mot de passe oublié : vous recevrez un lien pour en définir un.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "La connexion Google nécessite l'application mobile"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("S'inscrire avec Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Guides et réponses aux questions fréquentes"),
      "handle": MessageLookupByLibrary.simpleMessage("pseudo"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Aide et assistance"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Centre d'aide"),
      "home": MessageLookupByLibrary.simpleMessage("Accueil"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("En une ligne"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Votre compte"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Ouvrir la communauté"),
      "ins_act_post":
          MessageLookupByLibrary.simpleMessage("Écrire une publication"),
      "ins_act_post_open":
          MessageLookupByLibrary.simpleMessage("Voir la publication"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Modifier votre profil"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Quand ils sont là"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("Dans votre fuseau horaire."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Âges"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Parmi les {known} personnes touchées qui ont indiqué un anniversaire."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("Personnes touchées par jour"),
      "ins_communities": MessageLookupByLibrary.simpleMessage(
          "Communautés dont ils font partie"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Pays"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Parmi les {known} personnes atteintes qui ont un pays sur leur profil."),
      "ins_days": MessageLookupByLibrary.simpleMessage("{days} derniers jours"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger les statistiques"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Abonnés"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Aucun groupe n'est encore assez grand pour être affiché."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Comment grandir"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Sujets qu'ils suivent"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("J'aime"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Nouveau"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Nouveaux abonnés"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Aucune de vos publications n'a touché personne sur cette période."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Ne vous suivent pas"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Les pays sont ceux que les gens ont choisis sur leur profil. Kyron ne collecte la ville ou le genre de personne, il n'y a donc rien à afficher pour ces données."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Ouvertures"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} touchées · {likes} j'aime · {replies} réponses"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("Personnes touchées"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Chaque personne compte une seule fois : on lui a montré ou elle a ouvert l'une de vos publications pour la première fois. Les nouveaux abonnés vous suivent toujours ; les désabonnements ne sont pas comptés."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Réponses"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Republications"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Enregistrements"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Qui est votre audience s'affiche quand {floor} personnes ont vu vos publications sur cette période. En dessous, cela pourrait désigner quelqu'un."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Pas encore assez de monde"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct} % d'entre elles vous suivent déjà : vos publications touchent surtout des gens qui vous connaissent."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct} % d'entre elles ne vous suivent pas encore : vos publications sont découvertes."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Vous avez touché {reach} personnes, {pct} % de moins que la période précédente."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "Vous avez touché {reach} personnes ces {days} derniers jours."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Vous avez touché {reach} personnes, à peu près autant que la période précédente."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Personne de nouveau n'a vu vos publications ces {days} derniers jours."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Vous avez touché {reach} personnes, {pct} % de plus que la période précédente."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Vous avez touché {reach} personnes, {times}× plus que la période précédente."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Elles sont plus nombreuses à suivre {name} que tout autre sujet."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Audience"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Aperçu"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Ceux qui trouvent l'une de vos publications regardent votre profil avant de s'abonner. Un visage ou un logo leur dit que quelqu'un est là."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Ajoutez une photo de profil"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Dites en une ligne de quoi vous parlez, pour qu'un inconnu sache ce que vous suivre lui apportera."),
      "ins_tip_add_bio_t":
          MessageLookupByLibrary.simpleMessage("Écrivez une bio"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} de vos {total} publications n'avaient pas de sujet. Un sujet place la publication dans le fil de ce sujet et devant ceux qui le suivent."),
      "ins_tip_add_topics_t": MessageLookupByLibrary.simpleMessage(
          "Ajoutez des sujets à vos publications"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} personnes ont répondu à vos publications et vous en avez répondu {answered}. Elles se sont déjà donné la peine d'écrire : une réponse fait d'un lecteur un habitué."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Répondez à vos réponses"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Votre audience est la plus active le {when}. Une publication juste avant trouve du monde pour l'accueillir."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Publiez quand ils sont là"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} personnes qui ne vous suivent pas ont vu vos publications, et {gained} se sont abonnées. Que votre bio et vos dernières publications disent à quoi s'attendre avec vous."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Transformez les lecteurs en abonnés"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Une publication a touché {times}× plus de monde que vos autres d'habitude. Regardez ce qu'elle a fait différemment, et faites-en plus."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "Faites plus de ce qui a marché"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Beaucoup de ceux qui voient vos publications sont dans {name}. Y publier vous met devant le reste de ses membres."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Publiez dans {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Vous avez publié {posts} fois en {days} jours. Chaque publication est une chance de plus d'être trouvé, et un rythme régulier vous garde dans le fil de vos abonnés."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Publiez plus souvent"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "Vous n'avez rien publié ces {days} derniers jours. Rien n'atteint personne sans publication."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Publiez quelque chose"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Statistiques"),
      "ins_top_posts":
          MessageLookupByLibrary.simpleMessage("Meilleures publications"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Par rapport aux {days} jours précédents"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Ajouter un centre d'intérêt"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
          "Faites glisser pour réorganiser"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Le bandeau contient cinq onglets au maximum. Retirez-en un pour en ajouter un autre."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Abonnements"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Pour vous"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Les hashtags apparaissent ici dès qu'on commence à les utiliser."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Tendances du moment"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Vidéos"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Vos onglets"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Il disparaît pour vous deux."),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
          "Il sera retiré de la discussion."),
      "join": MessageLookupByLibrary.simpleMessage("Rejoindre"),
      "keepEditing":
          MessageLookupByLibrary.simpleMessage("Continuer à modifier"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Les écrans de Kyron sont dans votre langue. Si un mot sonne faux, dites-le-nous via Envoyer un avis."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Langues"),
      "leave": MessageLookupByLibrary.simpleMessage("Quitter"),
      "leaveCommunity": (Object a0) => "Quitter ${a0} ?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Réadmettre"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 page ouverte"),
      "literaladdAClip":
          MessageLookupByLibrary.simpleMessage("Ajouter un clip"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Ajouter un GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Ajouter un hashtag"),
      "literaladdAPhoto":
          MessageLookupByLibrary.simpleMessage("Ajouter une photo"),
      "literaladdAPoll":
          MessageLookupByLibrary.simpleMessage("Ajouter un sondage"),
      "literaladdAVideo":
          MessageLookupByLibrary.simpleMessage("Ajouter une vidéo"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Ajouter un centre d'intérêt"),
      "literaladdLabelAsATab": (Object a0) => "Ajouter ${a0} comme onglet",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Langue de l'app"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Version de l'app"),
      "literalblockAuthor": (Object a0) => "Bloquer ${a0}",
      "literalblockAuthor2": (Object a0) => "Bloquer ${a0} ?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Bloquer ce compte ?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Annuler la réponse"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Vérifier à nouveau"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Choisir dans la galerie"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Vider le cache"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Fermer toutes les pages"),
      "literalcloseTabLabel": (Object a0) => "Fermer ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Fermer le navigateur"),
      "literalcloseWidgetCommunityName": (Object a0) => "Fermer ${a0} ?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Contacter l'assistance"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Langues du contenu"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Copier le lien"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
          "Copier le lien de la publication"),
      "literalcopyPostText": MessageLookupByLibrary.simpleMessage(
          "Copier le texte de la publication"),
      "literalcopyText":
          MessageLookupByLibrary.simpleMessage("Copier le texte"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger les communautés"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Impossible de charger les GIF"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger les notifications"),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger les membres"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger ces publications"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Impossible de charger cette conversation"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger cette liste"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger cette publication"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger cette réponse"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger les tags tendance"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Impossible de charger vos communautés"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger vos messages"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Impossible d'ouvrir cette communauté"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Impossible de publier cette réponse."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Recherche impossible"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Déconnexion impossible : ${a0}",
      "literalcountPagesOpen": (Object a0) => "${a0} pages ouvertes",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Photo de couverture"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Économiseur de données"),
      "literaldeletePost":
          MessageLookupByLibrary.simpleMessage("Supprimer la publication"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Découvrir des personnes"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("Ne pas répondre"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Brouillon enregistré"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Impossible d'envoyer un avis pour le moment"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Taille du texte"),
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
          "Les GIF ne sont pas configurés"),
      "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage(
          "La transmettre à une autre app"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Masquer le mot de passe"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Masquer cette publication"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "La masque et nous indique d'en montrer moins de ce genre"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Comment se comporter"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping":
          MessageLookupByLibrary.simpleMessage("Continuez à écrire"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron n'a pas répondu"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "Date \\${a0}",
      "literalleaveCommunityName": (Object a0) => "Quitter ${a0} ?",
      "literallensNameFaceLens": (Object a0) => "${a0}, filtre visage",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Publications aimées"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("Lien copié"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Nommer modérateur"),
      "literalmuteAuthor": (Object a0) => "Masquer ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Masquer cette discussion"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Masquer des mots ou des tags"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("Comptes masqués et bloqués"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Masqué. Vous ne serez pas notifié."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Aucune app de cet appareil n'ouvre les liens ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Aucun navigateur de cet appareil n'a pris ce lien."),
      "literalnoDidYet":
          MessageLookupByLibrary.simpleMessage("Pas encore de DID"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("Aucun brouillon"),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
          "Aucun centre d'intérêt pour l'instant"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Aucun J'aime pour l'instant"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Aucun message pour l'instant"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Aucun nouvel abonné"),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage(
          "Aucune publication pour l'instant"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Aucune réponse pour l'instant"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Aucun partage pour l'instant"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Aucun tag tendance ne correspond"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Personne trouvé"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Personne n'a été retiré"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Personne ici pour l'instant"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Pas intéressé"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Rien trouvé"),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
          "Rien n'est tendance pour l'instant"),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
          "Rien dans le journal pour l'instant"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Aucun résultat"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Rien de masqué"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("Rien à voir pour l'instant"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Rien de non lu"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Seul le propriétaire peut modifier ceci"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Ouvrir la réponse"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Ouvrez l'e-mail de Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Mot de passe et connexion"),
      "literalpostInCommunityName": (Object a0) => "Publier dans ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Publier dans ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "La publier avec vos propres mots au-dessus"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Langue principale"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Notifications push"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Lecture…"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage(
          "Enregistrer une publication vocale"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Enregistrer à nouveau"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Retirer des modérateurs"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Retirer de la communauté"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Retirer des enregistrements"),
      "literalremoveLabel": (Object a0) => "Retirer ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Retirer ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Retirer ${a0} ?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Retirer le sondage"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Retirer cette réponse"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Supprimer cette conversation"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Retirer ce sondage"),
      "literalreportAuthor": (Object a0) => "Signaler ${a0}",
      "literalreportPost":
          MessageLookupByLibrary.simpleMessage("Signaler la publication"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Renvoyer le code"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Publications enregistrées"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Dites quelque chose"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Dites quelque chose à ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("La recherche a échoué"),
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Renvoyer"),
      "literalsendAgainInCooldownS": (Object a0) => "Renvoyer dans ${a0} s",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Envoyer un avis"),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Envoyer le lien"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Envoyé. C'est le rapport n° ${a0}.",
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
          "Définissez un mot de passe et continuez"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Partager le journal avec l'assistance"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Partager cette communauté"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Partager cette page"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Partager ce profil"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Partager via…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Partager avec une citation"),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
          "Afficher plus de publications comme celle-ci"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Afficher le mot de passe"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Afficher les résultats"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Créer une communauté"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Démarrer l'enregistrement"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Arrêter le chargement"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Ne plus voir cette publication ni ses réponses"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Bandeau de stories, ${a0} éléments",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Changer de caméra"),
      "literaltagSomeone":
          MessageLookupByLibrary.simpleMessage("Identifier quelqu'un"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Prendre une photo"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Touchez la bannière ou l'image pour la changer"),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
          "Touchez le lien qu'il contient"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Touchez pour ajouter une photo et une couverture"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Ça n'a pas fonctionné. Réessayez."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Ce GIF n'a pas pu être téléchargé."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Ce lien ne peut pas être ouvert ici."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("La caméra est fermée"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Cette communauté"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Cette réponse n'existe plus"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Traduire la publication"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Couper le son"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Activer le son"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Utiliser l'une des nôtres"),
      "literalverificationCodeResent":
          MessageLookupByLibrary.simpleMessage("Code de vérification renvoyé."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Échec de la vérification : ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Vérifier l'e-mail"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Lecteurs, J'aime, enregistrements et commentaires"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Ce que Kyron conserve"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Ce que cette app a fait"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Ce que vous avez fait, ce que vous attendiez, ce qui s'est passé "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
          "Ce que vous publiez vous appartient"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
              "Si Kyron est joignable en ce moment"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Qui peut répondre"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Qui voulez-vous identifier ?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Vous suivez déjà tous les tags tendance"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Vous êtes à jour"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Vous n'êtes dans aucune communauté"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Vous êtes déconnecté."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) =>
          "Vous avez quitté ${a0}",
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
          "Vous n'avez encore rien publié"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Charger plus"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Journal effacé"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Journal copié"),
      "logIn": MessageLookupByLibrary.simpleMessage("Se connecter"),
      "logOut": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
      "logOutQuestion":
          MessageLookupByLibrary.simpleMessage("Se déconnecter ?"),
      "login": MessageLookupByLibrary.simpleMessage("Connexion"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Échec de la connexion. Vérifiez vos identifiants."),
      "manage": MessageLookupByLibrary.simpleMessage("Gérer"),
      "menu": MessageLookupByLibrary.simpleMessage("Menu"),
      "message": MessageLookupByLibrary.simpleMessage("Message"),
      "messages": MessageLookupByLibrary.simpleMessage("Messages"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "Toutes les conversations sont à jour."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Ouvrez le profil de quelqu'un et touchez Message pour commencer une conversation."),
      "mute": MessageLookupByLibrary.simpleMessage("Masquer"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Masqués et bloqués"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Mots et tags masqués"),
      "name": MessageLookupByLibrary.simpleMessage("Nom"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Écran <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Nouvelle adresse e-mail"),
      "newPassword":
          MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
      "newPost": MessageLookupByLibrary.simpleMessage("Nouvelle publication"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Pas maintenant"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Non envoyé. Touchez pour réessayer"),
      "nothingMatchesQuery": (Object a0) =>
          "Rien sur Kyron ne correspond à « ${a0} »",
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("Rien à copier"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Les J'aime, réponses et nouveaux abonnés arrivent ici."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Les personnes qui vous suivent apparaissent ici."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Quand quelqu'un aime l'une de vos publications, cela apparaît ici."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Les réponses à vos publications arrivent ici."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Quand quelqu'un vous partage, cela apparaît ici."),
      "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Ouvrir dans le navigateur"),
      "or": MessageLookupByLibrary.simpleMessage("ou"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("Page introuvable"),
      "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Mot de passe trop court"),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
          "Choisissez vos centres d'intérêt"),
      "post": MessageLookupByLibrary.simpleMessage("Publier"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage(
          "Statistiques de la publication"),
      "postInCommunity": (Object a0) => "Publier dans ${a0}",
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
          "Publiez-le, dites-le, montrez-le."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Texte de la publication copié"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Politique de confidentialité"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profil mis à jour"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Pays"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Nom affiché"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Lieu"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Touchez pour changer"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Site web"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Notifications push"),
      "quote": MessageLookupByLibrary.simpleMessage("Citer"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Citer la publication"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Joindre une personne"),
      "remove": MessageLookupByLibrary.simpleMessage("Retirer"),
      "removeConversation": MessageLookupByLibrary.simpleMessage(
          "Supprimer cette conversation ?"),
      "removeMember": (Object a0) => "Retirer ${a0} ?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Supprimer ce message ?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Réponses, abonnements et mentions"),
      "repliesPolicy": (Object a0) => "Réponses : ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Répondre"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Tout le monde peut interagir"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Tout le monde peut toujours voir, partager et citer cette publication."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Tout le monde sur Kyron peut répondre à cette publication."),
      "reply_followers": MessageLookupByLibrary.simpleMessage(
          "Les personnes qui vous suivent"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Seules les personnes qui vous suivent peuvent répondre."),
      "reply_mentioned": MessageLookupByLibrary.simpleMessage(
          "Les personnes que vous mentionnez"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Seules les personnes que vous @mentionnez dans cette publication peuvent répondre."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Personne ne peut répondre"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Les réponses sont désactivées. Vous pouvez toujours répondre."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Qui peut répondre ?"),
      "report": MessageLookupByLibrary.simpleMessage("Signaler"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Rapport copié. Collez-le dans un e-mail à l'assistance."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Signalement envoyé"),
      "repost": MessageLookupByLibrary.simpleMessage("Partager"),
      "reset": MessageLookupByLibrary.simpleMessage("Réinitialiser"),
      "resetPassword": MessageLookupByLibrary.simpleMessage(
          "Réinitialisez votre mot de passe"),
      "retry": MessageLookupByLibrary.simpleMessage("Réessayer"),
      "save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
      "saveDraft":
          MessageLookupByLibrary.simpleMessage("Enregistrer le brouillon"),
      "saySomething": (Object a0) => "Dites quelque chose à ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Rechercher"),
      "searchByNameOrHandle":
          MessageLookupByLibrary.simpleMessage("Rechercher par nom ou pseudo"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Rechercher des communautés"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Rechercher des GIF"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("Rechercher des langues"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Rechercher des tags tendance"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Alertes de sécurité et modifications du compte"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Choisissez la langue de l'interface de l'app."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Choisissez les langues à inclure dans vos fils. Si aucune n'est choisie, toutes les langues sont affichées."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Choisissez votre langue préférée pour les traductions de votre fil."),
      "send": MessageLookupByLibrary.simpleMessage("Envoyer"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Envoyer la confirmation"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Envoyer un rapport d'erreur"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Envoyer un avis"),
      "sendReport":
          MessageLookupByLibrary.simpleMessage("Envoyer le signalement"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Envoyer à l'assistance"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("État du service"),
      "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Partager le journal de l'app avec l'assistance"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Se connecter à Kyron"),
      "signedInAs":
          MessageLookupByLibrary.simpleMessage("Connecté en tant que"),
      "signupFailed": (Object a0) => "Échec de l'inscription : ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Rester"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron débute, et le moyen le plus rapide de joindre quelqu'un qui peut corriger un problème est d'ouvrir un ticket. Indiquez ce que vous faisiez et ce qui s'est passé."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "Il n'y a pas encore de messagerie d'assistance dans l'app : cet écran renvoie donc vers l'endroit réellement suivi plutôt que vers un formulaire qui ne mène nulle part."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Journal système"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Dites-nous ce qui manque ou ne fonctionne pas"),
      "terms": MessageLookupByLibrary.simpleMessage("Conditions"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Texte, voix et vidéo, les personnes qui les créent et les salons où elles discutent."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "L'éditeur n'a pas de bouton Publier"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Sombre"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Toujours sombre"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Tamisé"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Un sombre plus doux, gris-bleu plutôt que noir"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Clair"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Toujours clair"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Système"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Suivre le réglage clair ou sombre du téléphone"),
      "translate": MessageLookupByLibrary.simpleMessage("Traduire"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "La traduction n'est pas encore disponible. Rien n'est traduit dans votre fil pour l'instant ; ce choix est conservé pour plus tard."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Cela change les mots de Kyron, les parties de l'interface que Flutter dessine lui-même, les dates et les nombres, ainsi que le sens de mise en page pour les langues écrites de droite à gauche."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Réessayer"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Politique de confidentialité"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Conditions d'utilisation"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Compte"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Après"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("App et appareil"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Je citais l'arnaque pour mettre les gens en garde."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Expliquez pourquoi la décision vous semble erronée : ce que la publication voulait dire, ce que l'équipe a pu manquer, ou pourquoi la règle ne s'applique pas. Une autre personne que celle qui a décidé le lira."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Votre appel"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Écrivez au moins \$count caractères. Vous pouvez faire appel de chaque décision une seule fois."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Envoyer l'appel"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Appel envoyé. Vous recevrez une notification lorsqu'une décision sera prise."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Appel du cas \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Apparence"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Clair, sombre ou selon le réglage du téléphone"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Avant"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Aucun de vous ne verra l'autre sur Kyron, et tout abonnement entre vous est retiré. Cette personne n'est pas prévenue."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Contenant"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("À quoi il sert (facultatif)"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage(
          "Seuls les modérateurs peuvent écrire"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Pour les annonces. Tout le monde dans la communauté peut toujours lire et réagir."),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage(
          "Ajouter une photo ou un sondage"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Photos et vidéos"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Fermer le chat"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Plus personne ne pourra y lire ni y écrire. Cette action est irréversible."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Fermer ce chat ?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Copié"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Le message est retiré pour tout le monde. Kyron en garde une copie pour examen."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Le message est retiré pour tout le monde dans le chat."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Modifier le chat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Modifier"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("modifié"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Modification de votre message"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Impossible d’ouvrir ce chat."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Discussions"),
      "ui_cchat_join":
          MessageLookupByLibrary.simpleMessage("Rejoindre le chat"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Rejoignez la communauté pour voir ses chats et y participer."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("\$count membres"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Quitter le chat"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Vous pourrez toujours le lire tant que vous êtes dans la communauté."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Seuls le propriétaire et les modérateurs peuvent écrire ici."),
      "ui_cchat_mute":
          MessageLookupByLibrary.simpleMessage("Mettre en sourdine"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Aucune notification de ce chat, et il n’est plus compté dans Messages."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Nom du chat"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Nouveau chat"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Aucun chat pour l’instant."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Aucun chat pour l’instant. Ouvrez-en un pour la communauté."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Les chats de communauté ne sont pas chiffrés de bout en bout. Les modérateurs de la communauté et Kyron peuvent les lire."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Épingler en haut"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Ajouter une réponse"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Clore le sondage"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Clos"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Tout le monde voit combien de personnes ont choisi chaque réponse, jamais qui."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Autoriser plusieurs choix"),
      "ui_cchat_poll_new":
          MessageLookupByLibrary.simpleMessage("Nouveau sondage"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Choisissez-en une"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Réponse \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Sondage : \$question"),
      "ui_cchat_poll_question":
          MessageLookupByLibrary.simpleMessage("Question"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Chaque réponse ne peut figurer qu’une fois dans un sondage."),
      "ui_cchat_poll_several": MessageLookupByLibrary.simpleMessage(
          "Choisissez-en une ou plusieurs"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count ont répondu"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Rechercher dans ce chat"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Rechercher dans ce chat"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Aucun résultat."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Vous ne pouvez plus voir ce chat."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Mode lent"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Le temps d’attente entre deux messages. Ne s’applique pas aux modérateurs."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 heure"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minutes"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Mode lent : un message toutes les \$seconds secondes"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Désactivé"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n secondes"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Vous pouvez lire et réagir en tant que spectateur. Rejoignez le chat pour écrire."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Ce message est trop ancien pour être affiché."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Un élément que vous avez choisi est trop volumineux pour être envoyé et a été retiré."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Réactiver le son"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Désépingler"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Enregistrer un message vocal"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Vous"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communautés"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage(
              "À quoi sert-elle ? (facultatif)"),
      "ui_community_posts":
          MessageLookupByLibrary.simpleMessage("Publications :"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Contenu et affichage"),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger votre fil"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger vos publications aimées"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger votre profil"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger vos publications enregistrées"),
      "ui_decentralized_id":
          MessageLookupByLibrary.simpleMessage("Identifiant décentralisé"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnostic"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Groupes"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Aucun groupe"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Les groupes dont vous faites partie et les chats de communauté que vous rejoignez s’affichent ici."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Vous pouvez épingler jusqu'à \$count discussions. Désépinglez-en une d'abord."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Épinglée"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("J'aime"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Enregistrés"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Rien ici pour l'instant"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Suivez quelques comptes et leurs publications apparaîtront ici."),
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
          "Rien des personnes que vous suivez"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Les publications apparaîtront ici à mesure que les gens les écrivent."),
      "ui_feed_signal_fading":
          MessageLookupByLibrary.simpleMessage("S'estompe"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Pas intéressé"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Afficher plus de ce genre"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("Retiré"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Vos signaux de fil"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Touchez Afficher plus de publications comme celle-ci ou Pas intéressé par ceci sur une publication, et elle apparaîtra ici."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Rien pour l'instant"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Ce que Afficher plus et Pas intéressé disent à vos fils"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Ils façonnent Accueil et Explorer, surtout selon le sujet de chaque publication. Chacun s'affaiblit de moitié chaque mois et ne compte plus au bout de six. Retirez-en un pour l'arrêter tout de suite."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Les publications avec un clip apparaîtront ici."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Aucune vidéo pour l'instant"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Avis"),
      "ui_find_people_on_kyron": MessageLookupByLibrary.simpleMessage(
          "Trouver des personnes sur Kyron"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("D'un compte"),
      "ui_group_add":
          MessageLookupByLibrary.simpleMessage("Ajouter des personnes"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Ajouter"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Ajouter un nom de groupe"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Ignorer"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Les messages de ce groupe sont chiffrés de bout en bout, comme toute autre conversation."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor a ajouté \$users"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor a nommé \$users admin"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor a créé le groupe"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor fait rejoindre les nouveaux en tant que membres"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor fait rejoindre les nouveaux en tant que spectateurs"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor est parti"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor a fait de \$users un membre"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor a fait de \$users le propriétaire"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor a retiré \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor a renommé le groupe \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor a fait de \$users un spectateur"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Un groupe peut compter au plus \$count personnes."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Main levée. Les admins ont été prévenus."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count demandent à écrire"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Demandent à écrire"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Les personnes ajoutées plus tard rejoignent en spectateurs"),
      "ui_group_leave":
          MessageLookupByLibrary.simpleMessage("Quitter le groupe"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Il disparaît de votre liste et vous ne verrez pas ce qui sera dit ensuite. Quelqu’un devra vous ajouter à nouveau."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Quitter ce groupe ?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Autoriser à écrire"),
      "ui_group_lower_hand":
          MessageLookupByLibrary.simpleMessage("Baisser la main"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Nommer admin"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Nommer propriétaire"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Passer en spectateur"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count membres"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Membres"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Nom du groupe"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Nommez d’abord le groupe."),
      "ui_group_new": MessageLookupByLibrary.simpleMessage(
          "Créer une discussion de groupe"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Il n’y a qu’un propriétaire. Vous resterez admin."),
      "ui_group_owner_title": MessageLookupByLibrary.simpleMessage(
          "Faire de \$name le propriétaire ?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Lever la main"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Retirer du groupe"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Retirer des admins"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Vous ne faites plus partie de ce groupe."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Renommer"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Admin"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Membre"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Spectateur"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "En tant que spectateur, vous pouvez lire et réagir ici."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Les spectateurs peuvent lire, réagir et lever la main pour demander à écrire."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Suggestions"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Voir le profil"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("vous"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Vous êtes spectateur"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Aide"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Noté. Cela aide à choisir ce qui vous est montré."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Rejoindre"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Membre"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Langue"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Choisissez votre langue"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Mentions légales"),
      "ui_like": MessageLookupByLibrary.simpleMessage("J'aime"),
      "ui_liked_posts":
          MessageLookupByLibrary.simpleMessage("Publications aimées"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Les publications que vous aimez apparaissent ici, les plus récentes d'abord."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Lien copié"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Vous ne verrez plus ses publications. Cette personne n'est pas prévenue."),
      "ui_no_likes_yet":
          MessageLookupByLibrary.simpleMessage("Aucun J'aime pour l'instant"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Aucune publication ne correspond à ces filtres."),
      "ui_nothing_saved_yet": MessageLookupByLibrary.simpleMessage(
          "Rien d'enregistré pour l'instant"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Votre compte a été mis à jour"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Votre appel sur le cas \$number a été accepté"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Nous avons réexaminé votre appel sur le cas \$number, et la décision est maintenue"),
      "ui_notif_banned":
          MessageLookupByLibrary.simpleMessage("Votre compte a été banni"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Cas \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("vous suit désormais"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("a aimé votre publication"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("vous a mentionné"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Aucune mention pour l'instant"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Quand quelqu'un écrit votre @pseudo dans une publication ou une réponse, cela apparaît ici."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Plus ancien"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Votre message dans un chat de communauté a été supprimé"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Un contenu que vous avez publié a été supprimé"),
      "ui_notif_removed_post": MessageLookupByLibrary.simpleMessage(
          "Votre publication a été supprimée"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Votre réponse a été supprimée"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("a répondu à votre publication"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Nous avons pris des mesures concernant un contenu que vous avez signalé. Merci de nous l’avoir signalé."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Nous avons examiné un contenu que vous avez signalé et n’avons pas constaté qu’il enfreignait nos règles."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Signalé pour : \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("a republié votre publication"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Nous avons annulé le cas \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Votre compte est suspendu"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Votre compte est suspendu jusqu’au \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Tout"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Abonnés"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("J’aime"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("Mentions"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Réponses"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("Cette semaine"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Aujourd’hui"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Votre compte a reçu un avertissement"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Hier"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Terminer"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Passer"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("Ceci a déjà été ouvert."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Expiré"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Impossible d’ouvrir ceci."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "S’ouvre une fois, puis est supprimé de Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Vue unique"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Ouvert"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "Ouvert par \$count sur \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Seules les personnes à qui vous l’avez envoyé peuvent l’ouvrir, une fois."),
      "ui_once_send":
          MessageLookupByLibrary.simpleMessage("Envoyer en vue unique"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Touchez pour voir"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pause"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Lire"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Elle est retirée de votre profil et du fil de tout le monde. Ses réponses partent avec elle."),
      "ui_post_deleted":
          MessageLookupByLibrary.simpleMessage("Publication supprimée"),
      "ui_post_hidden":
          MessageLookupByLibrary.simpleMessage("Publication masquée"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Texte de la publication copié"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Publiée entre"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Masquée. Nous vous en montrerons moins de ce genre."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Préférences"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Confidentialité"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Quelque chose à ajouter ? (facultatif)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Vous recevrez une notification quand l’équipe aura décidé, et vous pouvez suivre votre signalement dans Vos signalements."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Si vous ne voulez plus voir cette personne non plus, vous pouvez la masquer ou la bloquer depuis le même menu."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Signaler deux fois la même chose ne lui donne pas plus de poids : nous gardons un signalement par personne."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Votre signalement n'est pas partagé avec la personne concernée. Nous gardons une copie de ce que vous avez signalé, pour qu'il puisse être examiné même s'il est supprimé."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Votre signalement a été reçu et attend d'être examiné. Nous ne disons pas à la personne concernée qui l'a signalée."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Voir vos signalements"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Dites-nous ce qui ne va pas"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Merci de nous l'avoir signalé"),
      "ui_report_what_account": MessageLookupByLibrary.simpleMessage(
          "Quel est le problème avec \$name ?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Quel est le problème avec ce message ?"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage(
          "Quel est le problème avec cette publication ?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Quel est le problème avec cette réponse ?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Un message dans un chat de communauté"),
      "ui_reports_a_post":
          MessageLookupByLibrary.simpleMessage("Une publication"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Une réponse"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Mesures prises"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("Un compte"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Décidé le \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Aucune règle enfreinte"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger vos signalements"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Ce que vous avez signalé ces 90 derniers jours, et ce qu’il en est advenu. Vous recevez une notification quand l’équipe décide. Les personnes que vous signalez ne savent jamais qui les a signalées."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Aucun signalement"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Quand vous signalez une publication, une réponse, un message ou un compte, il s’affiche ici avec ce qu’il en est advenu."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("En cours d’examen"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Signalé le \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Ce que vous avez signalé, et ce qu’il en est advenu"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Vos signalements"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Sécurité des enfants"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Tout ce qui met en danger ou sexualise un mineur."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Abus ciblés, menaces ou contacts non désirés."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Attaques contre des personnes pour ce qu'elles sont."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Vente ou promotion de quelque chose d'illégal."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Se faire passer pour quelqu'un d'autre."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Utilise votre œuvre ou votre marque sans autorisation."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Affirmations trompeuses sur la santé, les élections ou des événements."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Encourager ou montrer l'automutilation."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Contenu sexuel affiché sans avertissement."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Rien de tout cela. Dites-nous ce qui ne va pas."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Promotion répétitive, trompeuse ou non sollicitée."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Menacer, glorifier ou inciter à la violence."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Harcèlement ou intimidation"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Discours haineux"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Biens ou services illégaux"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Usurpation d’identité"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Propriété intellectuelle"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Fausses informations"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Suicide ou automutilation"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Contenu pour adultes"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Autre chose"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spam"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Violence ou menaces"),
      "ui_saved_posts":
          MessageLookupByLibrary.simpleMessage("Publications enregistrées"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Touchez l'icône d'archive d'une publication pour la garder ici. Vous seul voyez ce que vous enregistrez."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Rechercher par pseudo ou nom affiché."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Effacer"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "Rechercher dans tout ce qui est publié"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filtres"),
      "ui_search_people":
          MessageLookupByLibrary.simpleMessage("Rechercher des personnes"),
      "ui_search_posts":
          MessageLookupByLibrary.simpleMessage("Rechercher des publications"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("App et appareil"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Contenu et affichage"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Économiseur de données"),
      "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
          "Dites-nous ce que vous en pensez"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Parcourir les articles d'aide"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Choisissez votre langue"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Les personnes que vous avez masquées ou bloquées"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Préférences de notification"),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
          "Votre profil et vos coordonnées"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Vous devrez vous reconnecter pour retrouver votre compte."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Paramètres de sécurité"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Confirmer le mot de passe"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("En une ligne"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Nouvelle adresse e-mail"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Ce qui s'est passé"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "Obtenir l'aide de notre équipe"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Partager"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Citer"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Envoyer dans un message"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("À des personnes sur Kyron"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Partager cette publication"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Ce dont il s'agissait"),
      "ui_standing_account_banned":
          MessageLookupByLibrary.simpleMessage("Votre compte est banni"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("La réponse, le \$date :"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Appel"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Faire appel de cette décision"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Il n'est plus possible de faire appel de cette décision. Si quelque chose ne va pas, contactez l'assistance."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Appel en cours d'examen"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Appel accepté"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Une autre personne de l'équipe réexamine la décision. Vous recevrez une notification lorsqu'une décision sera prise."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Si vous pensez qu'il s'agit d'une erreur, vous pouvez demander un réexamen jusqu'au \$date. Une autre personne de l'équipe décide."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Appel examiné : la décision est maintenue"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Cas \$number. Règle : \$rule. L'équipe a écrit :"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Supprimer votre compte ne lève pas un bannissement : un nouveau compte avec la même adresse e-mail est banni lui aussi."),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("Banni"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Seuls cette page, les appels, l'assistance et la suppression de votre compte fonctionnent encore."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Appel possible"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Cas \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Décidé le \$date"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "Décisions concernant votre compte"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Supprimer votre compte"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Voir les détails"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "Voir les détails et faire appel"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Prend fin le \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Votre compte est en règle"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Rien ne le restreint."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger l'état du compte"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Message supprimé"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Aucune décision n'a été prise concernant votre compte. Si l'équipe supprime un jour quelque chose de vous ou restreint votre compte, cela apparaîtra ici avec la raison, et vous pourrez faire appel."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Rien à contester : la décision a été annulée."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Publication supprimée"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Tirez vers le bas pour vérifier à nouveau."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Lire les règles de Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Réponse supprimée"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Annulée"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Annulée le \$date. Tout ce qui avait été supprimé est rétabli, et plus aucune restriction ne s'applique."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Règle : \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("Se déconnecter"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("Suspendu"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Vous pouvez lire, mais pas publier, répondre, suivre ni envoyer de messages. Signaler, bloquer et masquer fonctionnent toujours."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Votre compte est suspendu : vous pouvez lire, mais pas publier."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Suspendu jusqu'au \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Votre compte est suspendu jusqu'au \$date : vous pouvez lire, mais pas publier."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Ce que l'équipe a dit"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("État du compte"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Avertissement"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Pourquoi ?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Vous avez écrit, le \$date :"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Votre message"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Votre publication"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Votre réponse"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Conditions"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("cette publication"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Discussion masquée"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Réessayer"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Couper le son"),
      "ui_turn_sound_on":
          MessageLookupByLibrary.simpleMessage("Activer le son"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Deux caractères ou plus."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Annuler"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Des mots, ou un filtre : un compte, une période ou ce que contient une publication."),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Annuler le partage"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Mettre à jour le mot de passe"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Utiliser une autre adresse"),
      "username": MessageLookupByLibrary.simpleMessage("Nom d'utilisateur"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Le nom d'utilisateur doit être en minuscules (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Vidéo"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Joindre"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Prêt à joindre"),
      "voice_record_post": MessageLookupByLibrary.simpleMessage(
          "Enregistrer une publication vocale"),
      "voice_recording":
          MessageLookupByLibrary.simpleMessage("Enregistrement…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Arrêter"),
      "whatHappened":
          MessageLookupByLibrary.simpleMessage("Ce qui s'est passé"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Que s'est-il passé, et que devons-nous examiner ?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Qu'y a-t-il sur cette image ?"),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage(
          "À quoi sert-elle ? (facultatif)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Ce que vous avez fait, ce que vous attendiez, ce qui s'est passé"),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
          "Ce que vous faisiez quand c'est arrivé."),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("Vous avez répondu"),
      "dmReplied": (Object a0) => "$a0 a répondu",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Ajouter au message"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Nouveau message"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Rien n'a encore été dit. Un petit coucou est un bon début."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Saluer"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Nouveaux messages"),
      "dmTyping": (Object a0) => "$a0 est en train d'écrire",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Retirer votre réaction"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Quelqu'un"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Message"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Pièce jointe"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Ce message ne peut pas être lu sur cet appareil."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "En attente de ce message. Cela peut prendre un certain temps."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Message chiffré"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Les messages sont chiffrés de bout en bout"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Non chiffré de bout en bout"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Envoyé"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Vu"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Envoi…"),
      "ui_dm_take_photo":
          MessageLookupByLibrary.simpleMessage("Prendre une photo"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Plus d'options"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Enregistrer sur l'appareil"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Partager"),
      "ui_media_saving":
          MessageLookupByLibrary.simpleMessage("Enregistrement…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Enregistré dans vos photos"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de l'enregistrer. Réessayez."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Autorisez Kyron à ajouter à vos photos pour enregistrer ceci."),
      "ui_status_all_ok": MessageLookupByLibrary.simpleMessage(
          "Tous les systèmes sont opérationnels"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Disponibilité"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("60 derniers jours"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("Il y a 60 jours"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Aujourd'hui"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database":
          MessageLookupByLibrary.simpleMessage("Base de données"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Connexion"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Incidents récents"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Aucun incident au cours des 60 derniers jours."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("En cours"),
      "ui_status_no_data":
          MessageLookupByLibrary.simpleMessage("Aucune donnée"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Détails"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron se vérifie toutes les 5 minutes tant qu'il fonctionne. Un jour gris n'a eu aucune vérification."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "L'historique de disponibilité n'est pas encore disponible."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Certains systèmes rencontrent des problèmes"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Enregistrer un message vocal"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Prêt à envoyer"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Ce message n'est plus là."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Aller au message"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Message vocal"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Aimé par l'auteur"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Ajouter une photo ou un clip"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Médias"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Messages vocaux"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Discussion"),
      "ui_dm_info_wallpaper":
          MessageLookupByLibrary.simpleMessage("Fond d'écran"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Désactiver les notifications"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Ne plus être notifié de cette conversation"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "Cette personne ne peut plus vous écrire"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Aucun"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Photo"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("Son réactivé."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de la supprimer. Réessayez."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profil"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Réactiver"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Les photos et clips que vous partagez apparaissent ici."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("Tout voir"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Photos et clips"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Voici à quoi ressemblera votre discussion."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("C'est parfait."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Brume"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Crépuscule"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Sauge"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Sable"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Points"),
      "ui_dm_wallpaper_apply":
          MessageLookupByLibrary.simpleMessage("Appliquer"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("Actuel"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Envoyer sans l’aperçu"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Rechercher"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Publier"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Écrire un message…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Envoyer"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Envoyé"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "Envoyé, mais pas à tout le monde."),
      "ui_share_failed":
          MessageLookupByLibrary.simpleMessage("L’envoi a échoué. Réessayez."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Abonné"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtre"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Toutes"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Non lues"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Sans réponse"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Masquées"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Rien de masqué"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Les conversations que vous retirez de votre liste attendent ici, au cas où vous voudriez les récupérer."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Elle passe dans Masquées. L’autre personne garde la sienne, et elle revient si l’un de vous écrit à nouveau."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Remettre"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("De retour dans votre liste."),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage(
          "Aucune conversation ne correspond."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Rien ne vous attend"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Chaque conversation se termine sur votre mot."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Photo"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Photos"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Vidéo"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Pas encore de messages"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Vous :"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Hier"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Messages"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Paramètres des messages"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Confidentialité"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Confirmations de lecture"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Désactivées, les autres ne verront pas quand vous avez lu leurs messages, et vous ne verrez pas quand ils ont lu les vôtres."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Indiquer quand vous écrivez"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "La personne à qui vous écrivez voit que vous êtes en train d’écrire."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Aperçus des liens"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Votre téléphone ouvre le lien que vous envoyez pour en faire l’aperçu : le site voit donc la demande de votre téléphone. Le serveur de Kyron ne voit jamais le lien."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Notifications des messages"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Les messages sont chiffrés de bout en bout. Kyron ne peut pas les lire, et rien ici n’y change rien."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("À :"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Récents"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Personnes"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Personne de ce nom."),
      "ui_push_test": MessageLookupByLibrary.simpleMessage(
          "Envoyer une notification de test"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Le serveur de Kyron n’est pas encore configuré pour envoyer des notifications, donc aucune ne peut arriver. Le problème vient de nous, pas de votre téléphone."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Ce téléphone n’est pas enregistré pour les notifications. Vérifiez que les notifications de Kyron sont autorisées dans les réglages du téléphone, puis réessayez."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "La notification n’a pas pu être remise à ce téléphone. Réessayez dans une minute."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Envoyée. Elle devrait arriver dans quelques secondes."),
      "ui_push_working": MessageLookupByLibrary.simpleMessage(
          "Les notifications fonctionnent."),
      "ui_community_no_posts": MessageLookupByLibrary.simpleMessage(
          "Aucune publication pour l'instant"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Nouvelle communauté"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Nom"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Son adresse est tirée du nom."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("On la trouvera à l'adresse"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Vous en serez propriétaire. Une image, une bannière et des modérateurs peuvent être ajoutés depuis sa page une fois créée."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Accueil"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage(
          "Publications des communautés dans l'Accueil"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Les publications de vos communautés apparaissent aussi dans l'Accueil. Désactivé, elles restent ici dans Communautés, où chacune montre ce qui est nouveau."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Votre liste"),
      "ui_community_counts": MessageLookupByLibrary.simpleMessage(
          "Nombre de nouvelles publications"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Afficher combien de publications sont nouvelles dans chaque communauté depuis votre dernière visite."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Communautés que vous gérez"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Les communautés que vous créez ou modérez sont listées ici."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Propriétaire"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Modérateur"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Nouvelles publications"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Celles que vous gérez"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Paramètres des communautés"),
      "ui_community_discover":
          MessageLookupByLibrary.simpleMessage("Découvrir"),
      "ui_community_search_none": MessageLookupByLibrary.simpleMessage(
          "Aucune communauté ne correspond."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Rien de nouveau"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Chaque communauté est telle que vous l'avez laissée."),
      "ui_community_running_none": MessageLookupByLibrary.simpleMessage(
          "Vous n'en gérez aucune pour l'instant"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Plus rien à rejoindre"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Vous êtes dans toutes les communautés de Kyron. Créez-en une autre."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Essayez un autre mot, ou créez une communauté de ce nom."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Écrire une publication"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Membres :"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Publié"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Voir"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Ouvrir"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("En ligne"),
      "ui_dm_show_online": MessageLookupByLibrary.simpleMessage(
          "Indiquer quand vous êtes en ligne"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Les personnes à qui vous écrivez voient un point vert tant que Kyron est ouvert. Désactivé, vous ne verrez pas non plus le leur."),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage(
          "Rechercher des personnes et des publications"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Communautés à rejoindre"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Rien à voir pour l'instant"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Les photos et clips que les gens publient apparaîtront ici."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Suivre"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Supprimer le compte"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Cette action supprime définitivement votre compte Kyron. Elle est irréversible."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Votre profil, vos publications, réponses, mentions J'aime et republications"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Vos messages, y compris ceux que vous avez envoyés à d'autres personnes, ainsi que les photos et messages vocaux qu'ils contiennent"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Vos abonnés, les personnes que vous suivez et vos paramètres"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Les communautés que vous avez créées passent au modérateur ou au membre le plus ancien. Une communauté sans autre membre est fermée."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Supprimer votre compte ?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Vous ne pourrez rien en récupérer."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Votre compte a été supprimé."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Compte supprimé"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "Ce compte a été supprimé : il n'est plus possible d'envoyer des messages ici."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Inscrit avec Google ? Utilisez plutôt « Sign in with Google »."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Ce filtre n'a pas pu être chargé."),
      "ar_could_not_record": MessageLookupByLibrary.simpleMessage(
          "La vidéo n'a pas pu être enregistrée."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Le filtre n'a pas pu être ajouté à cette vidéo : elle est publiée telle qu'elle a été filmée."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Votre publication contient déjà autant de pièces jointes que possible."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Ajout de votre filtre…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Flash"),
      "ar_record_video":
          MessageLookupByLibrary.simpleMessage("Enregistrer une vidéo"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Photo"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Vidéo"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "La connexion avec Google a été annulée."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("CADEAUX"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Personne n'a encore envoyé de cadeau à cette publication."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Cadeau"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Cadeaux"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Pièces"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Expéditeur"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Expéditeurs"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Pièces de test : elles ne peuvent pas encore être retirées."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Enregistrés"),
      "ui_saved_tab_posts":
          MessageLookupByLibrary.simpleMessage("Publications"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Commentaires"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Voir plus de réponses"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Modifié"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Plus"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Abonnements"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Top"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Récents"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage(
          "Trier les commentaires : \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "a envoyé un cadeau à votre publication"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "a envoyé un \$gift à votre commentaire"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "a envoyé un \$gift à votre publication"),
      "ui_gift_title":
          MessageLookupByLibrary.simpleMessage("Envoyer un cadeau"),
      "ui_edit_post":
          MessageLookupByLibrary.simpleMessage("Modifier la publication"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Vous pouvez la modifier encore \$n min"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Rien n'a encore été publié sous #\$tab."),
      "ui_gift_pick":
          MessageLookupByLibrary.simpleMessage("Choisissez un cadeau"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Pas assez de pièces"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Pièces de test : elles ne peuvent pas être achetées et n'ont aucune valeur monétaire."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Recharge le \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 pièce"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count pièces"),
      "ui_gift_balance":
          MessageLookupByLibrary.simpleMessage("Vous avez \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Envoyer \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("\$gift envoyé"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Réessayer"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage(
          "Pendant 15 minutes après la publication"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Modifiée"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger vos commentaires enregistrés"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Aucun commentaire enregistré"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Touchez l'icône d'archive sous un commentaire pour le garder ici. Vous seul voyez ce que vous enregistrez."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("En réponse à \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Copier"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Rechercher"),
      "ui_select_all":
          MessageLookupByLibrary.simpleMessage("Tout sélectionner"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count cadeaux"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 cadeau"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger plus de publications."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Rappels"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Ce qui est nouveau après une absence, et quand vos pièces sont de retour. Jamais plus d'un par jour."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Cadeaux"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("d'1 personne"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("de \$count personnes"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("Meilleur donateur"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger qui a envoyé des cadeaux."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Nouveautés"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Compris"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Merci. Nous lisons chaque réponse."),
      "ui_check_in_title": MessageLookupByLibrary.simpleMessage(
          "Que pensez-vous de Kyron jusqu'ici ?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Jour \$day de votre test. Un seul geste suffit."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Quelque chose à corriger ou à ajouter ? (facultatif)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Envoyer"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Plus tard"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Appuyez de nouveau sur Retour pour quitter Kyron"),
    };

final messageLookup = MessageLookup();
