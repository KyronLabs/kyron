import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pl';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("Słowo, fraza lub #tag"),
      "about": MessageLookupByLibrary.simpleMessage("Informacje"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Dodaj odpowiedź"),
      "addMoreLanguages":
          MessageLookupByLibrary.simpleMessage("Dodaj więcej języków…"),
      "agreeAndContinue":
          MessageLookupByLibrary.simpleMessage("Zgadzam się i kontynuuję"),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Masz już konto w Kyron?"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Komentarze"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage("Unikalne osoby, nie otwarcia"),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Zaangażowanie"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Polubienia"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("Brak widzów"),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
          "Nikt jeszcze nie otworzył tego posta."),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Opublikowano"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Zapisy"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Widzowie"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("WIDZOWIE DZIENNIE"),
      "and": MessageLookupByLibrary.simpleMessage("i"),
      "answerNumber": (Object a0) => "Odpowiedź ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("Filtr AR"),
      "attachSystemLog":
          MessageLookupByLibrary.simpleMessage("Dołącz dziennik systemowy"),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Czas odpowiedzi"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("WERYFIKACJA TOKENU"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Spróbuj ponownie"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Spróbuj ponownie"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "Rozpoczęcie transmisji teraz umieściłoby cię w pokoju, do którego nikt nie mógłby"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Załóż społeczność"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("Do czego służy? (opcjonalnie)"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("wrócić."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("wrócić z tej listy."),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Zamknięcie jej"),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("najpierw dołącz"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("wkrótce"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Publikujesz jako ty"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("publikuj w tej społeczności"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("Przed chwilą"),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("Spróbuj ponownie"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("Temat 1"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("Dla ciebie"),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("coś ma."),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("właśnie do niej zmierza."),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", a nie"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("czy się ruszam"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Wyłącz dźwięk"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Włącz dźwięk"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("Dla ciebie"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Twoje karty"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Spróbuj ponownie"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Symbol (!@#…)"),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("WIDZOWIE DZIENNIE"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("nie udało się wczytać"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("ten post"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("Coś do dodania? (opcjonalnie)"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("ten post"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("Z konta"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Wyloguj się"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Twoje konto"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Potwierdź hasło"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("nie teraz"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("Wczytywanie…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("Publikowanie…"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3 godz. temu"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Kopiuj link do relacji"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Twoja relacja"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
              "Twoje konto, twoje posty i to, co stukasz, aby"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Dodaj temat"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("samodzielnie."),
      "authorBlocked": (Object a0) => "Zablokowano ${a0}",
      "authorPostsHidden": (Object a0) => "Nie zobaczysz postów od ${a0}",
      "block": MessageLookupByLibrary.simpleMessage("Zablokuj"),
      "blockAuthor": (Object a0) => "Zablokować ${a0}?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("Skopiowano szczegóły wersji"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Kontynuując, akceptujesz nasze"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
          "Kontynuując, akceptujesz nasze Warunki i Politykę prywatności"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
          "Rejestrując się, akceptujesz nasze"),
      "cancel": MessageLookupByLibrary.simpleMessage("Anuluj"),
      "change": MessageLookupByLibrary.simpleMessage("Zmień"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Zmień e-mail"),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
          "Sprawdź pocztę, aby potwierdzić konto."),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
          "Sprawdź, czy Kyron jest dostępny"),
      "clear": MessageLookupByLibrary.simpleMessage("Wyczyść"),
      "close": MessageLookupByLibrary.simpleMessage("Zamknij"),
      "closeCommunity": (Object a0) => "Zamknąć ${a0}?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Zamknij"),
      "closeThisCommunity":
          MessageLookupByLibrary.simpleMessage("Zamknij tę społeczność"),
      "communities": MessageLookupByLibrary.simpleMessage("Społeczności"),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Znajdź jakąś w Odkrywaj albo załóż własną."),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
          "Rzuć ostrą opinię (albo letnią)"),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("Co chodzi ci po głowie?"),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
          "Powiedz coś, co tylko ty możesz powiedzieć…"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("To twój sygnał: wyślij go"),
      "composer_placeholder_think":
          MessageLookupByLibrary.simpleMessage("Pisz, mów albo myśl na głos"),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Potwierdź hasło"),
      "contactSupport":
          MessageLookupByLibrary.simpleMessage("Skontaktuj się z pomocą"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "Posty nie mają jeszcze przypisanego języka, więc to jeszcze nie filtruje twojego kanału. Twój wybór zostanie zachowany na później."),
      "continueAction": MessageLookupByLibrary.simpleMessage("Kontynuuj"),
      "continueWithEmail":
          MessageLookupByLibrary.simpleMessage("Kontynuuj z e-mailem"),
      "copy": MessageLookupByLibrary.simpleMessage("Kopiuj"),
      "copyReportInstead":
          MessageLookupByLibrary.simpleMessage("Skopiuj raport"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Nie udało się otworzyć logowania Google. ${a0}",
      "couldNotSignOut": (Object a0) => "Nie udało się wylogować: ${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
          "Nie udało się zrobić tego zdjęcia."),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Widoczny na twoim profilu i pod twoimi postami."),
      "country_no_match": MessageLookupByLibrary.simpleMessage(
          "Żaden kraj nie pasuje do „{query}”."),
      "country_none": MessageLookupByLibrary.simpleMessage("Nie pokazuj kraju"),
      "country_search": MessageLookupByLibrary.simpleMessage("Szukaj krajów"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Widoczny na twoim profilu i pod twoimi postami. Gdy widzisz czyjeś posty, twój kraj jest liczony w jego Statystykach, tylko w grupach co najmniej pięciu osób i nigdy z nazwiska."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("Z ustawień twojego telefonu"),
      "create": MessageLookupByLibrary.simpleMessage("Utwórz"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Utwórz konto"),
      "createYourAccount":
          MessageLookupByLibrary.simpleMessage("Utwórz swoje konto"),
      "createYourProfile":
          MessageLookupByLibrary.simpleMessage("Utwórz swój profil"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("Filtr AR"),
      "create_go_live":
          MessageLookupByLibrary.simpleMessage("Rozpocznij transmisję"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("Post tekstowy"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("Post głosowy"),
      "delete": MessageLookupByLibrary.simpleMessage("Usuń"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("Usunąć ten komentarz?"),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Usunąć ten post?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("Opisz ten załącznik"),
      "description": MessageLookupByLibrary.simpleMessage("Opis"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("Skopiowano DID do schowka"),
      "done": MessageLookupByLibrary.simpleMessage("Gotowe"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "Zamknij edytor z napisanym tekstem, a zaproponujemy wersję roboczą."),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} dni temu"),
      "draft_hours_ago":
          MessageLookupByLibrary.simpleMessage("{hours} godz. temu"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("Przed chwilą"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} min temu"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("Jeszcze nic nie napisano"),
      "draft_poll_empty":
          MessageLookupByLibrary.simpleMessage("Ankieta, jeszcze bez pytania"),
      "draft_quote_empty":
          MessageLookupByLibrary.simpleMessage("Cytat, jeszcze bez tekstu"),
      "drafts": MessageLookupByLibrary.simpleMessage("Wersje robocze"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Edytuj profil"),
      "email": MessageLookupByLibrary.simpleMessage("E-mail"),
      "emailNotifications":
          MessageLookupByLibrary.simpleMessage("Powiadomienia e-mail"),
      "explore": MessageLookupByLibrary.simpleMessage("Odkrywaj"),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
          "Śledzenie twarzy nie jest dostępne na tym urządzeniu."),
      "feedTagDetail": (Object a0) =>
          "Pod #${a0} nic jeszcze nie opublikowano.",
      "follow_author": MessageLookupByLibrary.simpleMessage("Obserwuj: {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Obserwujący"),
      "following": MessageLookupByLibrary.simpleMessage("Obserwowani"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Nie pamiętasz hasła?"),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Uzyskiwanie pomocy"),
      "googleContinue":
          MessageLookupByLibrary.simpleMessage("Kontynuuj z Google"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Zaloguj się przez Google"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google przekazuje zakończone logowanie z powrotem do Kyron przez link, na który odpowiadają tylko Android i iOS, więc na ${a0} przeglądarka nie miałaby dokąd go zwrócić.\\n\\nJeśli masz już konto Kyron przez Google, użyj opcji Kontynuuj z e-mailem z tym samym adresem i stuknij Nie pamiętasz hasła: otrzymasz link do ustawienia hasła.",
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
          "Logowanie przez Google wymaga aplikacji na telefon"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Zarejestruj się przez Google"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
          "Poradniki i odpowiedzi na częste pytania"),
      "handle": MessageLookupByLibrary.simpleMessage("nazwa użytkownika"),
      "helpAndSupport":
          MessageLookupByLibrary.simpleMessage("Pomoc i wsparcie"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Centrum pomocy"),
      "home": MessageLookupByLibrary.simpleMessage("Główna"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("W jednym zdaniu"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Twoje konto"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Otwórz społeczność"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Napisz post"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("Zobacz post"),
      "ins_act_profile": MessageLookupByLibrary.simpleMessage("Edytuj profil"),
      "ins_active": MessageLookupByLibrary.simpleMessage("Kiedy są aktywni"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("W twojej strefie czasowej."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Wiek"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "Spośród {known} osób, do których dotarłeś i które podały datę urodzenia."),
      "ins_chart": MessageLookupByLibrary.simpleMessage(
          "Osoby, do których dotarłeś, dzień po dniu"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Społeczności, w których są"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Kraje"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "Spośród {known} osób, do których dotarłeś i które mają kraj na profilu."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Ostatnie {days} dni"),
      "ins_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać statystyk"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Obserwujący"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "Żadna grupa nie jest jeszcze na tyle duża, by ją pokazać."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("Jak rosnąć"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Tematy, które obserwują"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Polubienia"),
      "ins_new": MessageLookupByLibrary.simpleMessage("Nowe"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("Nowi obserwujący"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "Żaden twój post nie dotarł do nikogo w tym okresie."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Nie obserwują cię"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Kraje to te, które ludzie wybrali na swoich profilach. Kyron nie zbiera niczyjego miasta ani płci, więc nie ma tu nic do pokazania."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Otwarcia"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "dotarł do {reach} · {likes} polubień · {replies} odpowiedzi"),
      "ins_reach":
          MessageLookupByLibrary.simpleMessage("Osoby, do których dotarłeś"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "Każda osoba liczy się raz: po raz pierwszy zobaczyła lub otworzyła któryś z twoich postów. Nowi obserwujący nadal cię obserwują; przestania obserwowania nie są liczone."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Odpowiedzi"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Udostępnienia"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Zapisy"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Kim są twoi odbiorcy, pokażemy, gdy {floor} osób zobaczy twoje posty w tym okresie. Przy mniejszej liczbie mogłoby to wskazać kogoś konkretnego."),
      "ins_small_title": MessageLookupByLibrary.simpleMessage("Za mało osób"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% z nich już cię obserwuje: twoje posty trafiają głównie do ludzi, którzy cię znają."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% z nich jeszcze cię nie obserwuje: twoje posty są odkrywane."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "Dotarłeś do {reach} osób, o {pct}% mniej niż w poprzednim okresie."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "W ostatnich {days} dniach dotarłeś do {reach} osób."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "Dotarłeś do {reach} osób, mniej więcej tyle co w poprzednim okresie."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "W ostatnich {days} dniach nikt nowy nie zobaczył twoich postów."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "Dotarłeś do {reach} osób, o {pct}% więcej niż w poprzednim okresie."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "Dotarłeś do {reach} osób, {times}× więcej niż w poprzednim okresie."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "Więcej z nich obserwuje {name} niż jakikolwiek inny temat."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Odbiorcy"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Przegląd"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "Ci, którzy znajdą twój post, przed obserwowaniem zaglądają na twój profil. Twarz lub logo mówi im, że ktoś tam jest."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Dodaj zdjęcie profilowe"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Powiedz w jednym wierszu, o czym piszesz, żeby obcy wiedział, co da mu obserwowanie cię."),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("Napisz bio"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} z twoich {total} postów nie miało tematu. Temat umieszcza post w kanale tematu i przed ludźmi, którzy go obserwują."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Dodawaj tematy do postów"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} osób odpowiedziało na twoje posty, a ty odpowiedziałeś na {answered}. Zależało im na tyle, by napisać: odpowiedź zmienia czytelnika w stałego bywalca."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Odpowiadaj na odpowiedzi"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Twoi odbiorcy są najaktywniejsi w {when}. Post opublikowany tuż przed tym ma kto przyjąć."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Publikuj, gdy są aktywni"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} osób, które cię nie obserwują, zobaczyło twoje posty, a {gained} zaczęło obserwować. Niech twoje bio i najnowsze posty mówią, czego mogą się po tobie spodziewać."),
      "ins_tip_convert_strangers_t": MessageLookupByLibrary.simpleMessage(
          "Zamień czytelników w obserwujących"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "Jeden post dotarł do {times}× więcej osób niż zwykle twoje pozostałe. Zobacz, co zrobił inaczej, i rób więcej tego."),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage(
          "Rób więcej tego, co zadziałało"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Wielu z tych, którzy widzą twoje posty, jest w {name}. Publikując tam, trafisz też do reszty."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Opublikuj w {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "Opublikowałeś {posts} razy w {days} dni. Każdy post to kolejna szansa, by cię znaleziono, a stały rytm utrzymuje cię w kanałach obserwujących."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Publikuj częściej"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "W ostatnich {days} dniach nic nie opublikowałeś. Bez posta nic do nikogo nie dociera."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Opublikuj coś"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Statystyki"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Najlepsze posty"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "W porównaniu z poprzednimi {days} dniami"),
      "interest_add":
          MessageLookupByLibrary.simpleMessage("Dodaj zainteresowanie"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
          "Przeciągnij, aby zmienić kolejność"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "Pasek mieści najwyżej pięć kart. Usuń jedną, aby dodać inną."),
      "interest_following": MessageLookupByLibrary.simpleMessage("Obserwowani"),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("Dla ciebie"),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "Hashtagi pojawiają się tutaj, gdy ludzie zaczynają ich używać."),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Teraz popularne"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Filmy"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Twoje karty"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("Zniknie dla was obojga."),
      "itWillBeRemoved":
          MessageLookupByLibrary.simpleMessage("Zostanie usunięty z wątku."),
      "join": MessageLookupByLibrary.simpleMessage("Dołącz"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Edytuj dalej"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Ekrany Kyron są w twoim języku. Jeśli jakieś słowo brzmi źle, napisz nam przez Wyślij opinię."),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "languages": MessageLookupByLibrary.simpleMessage("Języki"),
      "leave": MessageLookupByLibrary.simpleMessage("Opuść"),
      "leaveCommunity": (Object a0) => "Opuścić ${a0}?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Wpuść ponownie"),
      "literal1PageOpen":
          MessageLookupByLibrary.simpleMessage("1 otwarta strona"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Dodaj klip"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Dodaj GIF"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Dodaj hashtag"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Dodaj zdjęcie"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Dodaj ankietę"),
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Dodaj film"),
      "literaladdAnInterest":
          MessageLookupByLibrary.simpleMessage("Dodaj zainteresowanie"),
      "literaladdLabelAsATab": (Object a0) => "Dodaj ${a0} jako kartę",
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("Język aplikacji"),
      "literalappVersion":
          MessageLookupByLibrary.simpleMessage("Wersja aplikacji"),
      "literalblockAuthor": (Object a0) => "Zablokuj ${a0}",
      "literalblockAuthor2": (Object a0) => "Zablokować ${a0}?",
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("Zablokować to konto?"),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Anuluj odpowiedź"),
      "literalcheckAgain":
          MessageLookupByLibrary.simpleMessage("Sprawdź ponownie"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("Wybierz z galerii"),
      "literalclearCache":
          MessageLookupByLibrary.simpleMessage("Wyczyść pamięć podręczną"),
      "literalcloseAllPages":
          MessageLookupByLibrary.simpleMessage("Zamknij wszystkie strony"),
      "literalcloseTabLabel": (Object a0) => "Zamknij ${a0}",
      "literalcloseTheBrowser":
          MessageLookupByLibrary.simpleMessage("Zamknij przeglądarkę"),
      "literalcloseWidgetCommunityName": (Object a0) => "Zamknąć ${a0}?",
      "literalcontactSupport":
          MessageLookupByLibrary.simpleMessage("Skontaktuj się z pomocą"),
      "literalcontentLanguages":
          MessageLookupByLibrary.simpleMessage("Języki treści"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Kopiuj link"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("Kopiuj link do posta"),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Kopiuj tekst posta"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Kopiuj tekst"),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać społeczności"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("Nie udało się wczytać GIF-ów"),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać powiadomień"),
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać członków"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać tych postów"),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
              "Nie udało się wczytać tej rozmowy"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać tej listy"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać tego posta"),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać tej odpowiedzi"),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać popularnych tagów"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
              "Nie udało się wczytać twoich społeczności"),
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać twoich wiadomości"),
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
          "Nie udało się otworzyć tej społeczności"),
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
          "Nie udało się opublikować tej odpowiedzi."),
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("Nie udało się wyszukać"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Nie udało się wylogować: ${a0}",
      "literalcountPagesOpen": (Object a0) => "Otwarte strony: ${a0}",
      "literalcoverPhoto":
          MessageLookupByLibrary.simpleMessage("Zdjęcie w tle"),
      "literaldataSaver":
          MessageLookupByLibrary.simpleMessage("Oszczędzanie danych"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("Usuń post"),
      "literaldiscoverPeople":
          MessageLookupByLibrary.simpleMessage("Odkrywaj ludzi"),
      "literaldoNotReply":
          MessageLookupByLibrary.simpleMessage("Nie odpowiadaj"),
      "literaldraftSaved":
          MessageLookupByLibrary.simpleMessage("Zapisano wersję roboczą"),
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage("Nie można teraz wysłać opinii"),
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalfontSize":
          MessageLookupByLibrary.simpleMessage("Rozmiar czcionki"),
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF-y nie są skonfigurowane"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("Przekaż do innej aplikacji"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Ukryj hasło"),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Ukryj ten post"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "Ukrywa go i mówi nam, by pokazywać mniej podobnych"),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("Jak się zachowywać"),
      "literalindex1": (Object a0) => "${a0}",
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("Pisz dalej"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron nie odpowiedział"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literallabelDate": (Object a0) => "Data: \\${a0}",
      "literalleaveCommunityName": (Object a0) => "Opuścić ${a0}?",
      "literallensNameFaceLens": (Object a0) => "${a0}, filtr twarzy",
      "literallikedPosts":
          MessageLookupByLibrary.simpleMessage("Polubione posty"),
      "literallinkCopied":
          MessageLookupByLibrary.simpleMessage("Skopiowano link"),
      "literalmakeAModerator":
          MessageLookupByLibrary.simpleMessage("Ustaw jako moderatora"),
      "literalmuteAuthor": (Object a0) => "Wycisz ${a0}",
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("Wycisz ten wątek"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("Wycisz słowa lub tagi"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("Wyciszone i zablokowane konta"),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
          "Wyciszono. Nie otrzymasz powiadomień."),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "Żadna aplikacja na tym urządzeniu nie otwiera linków ${a0}.",
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
              "Żadna przeglądarka na tym urządzeniu nie otworzyła tego linku."),
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("Brak DID"),
      "literalnoDrafts":
          MessageLookupByLibrary.simpleMessage("Brak wersji roboczych"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("Brak zainteresowań"),
      "literalnoLikesYet":
          MessageLookupByLibrary.simpleMessage("Brak polubień"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("Brak wiadomości"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("Brak nowych obserwujących"),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage("Brak postów"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("Brak odpowiedzi"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("Brak udostępnień"),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
          "Żaden popularny tag nie pasuje"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Nikogo nie znaleziono"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("Nikt nie został usunięty"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("Nikogo tu jeszcze nie ma"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("Nie interesuje mnie to"),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Nic nie znaleziono"),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
          "Nic nie jest jeszcze popularne"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("Jeszcze nic nie zapisano"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("Brak wyników"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Nic nie wyciszono"),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
          "Na razie nie ma nic do obejrzenia"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("Brak nieprzeczytanych"),
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
          "Tylko właściciel może to zmienić"),
      "literalopenReply":
          MessageLookupByLibrary.simpleMessage("Otwórz odpowiedź"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Otwórz wiadomość od Kyron"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("Hasło i logowanie"),
      "literalpostInCommunityName": (Object a0) => "Opublikuj w ${a0}",
      "literalpostInWidgetCommunityName": (Object a0) => "Opublikuj w ${a0}",
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
              "Opublikuj z własnym komentarzem nad nim"),
      "literalprimaryLanguage":
          MessageLookupByLibrary.simpleMessage("Język główny"),
      "literalpushNotifications":
          MessageLookupByLibrary.simpleMessage("Powiadomienia push"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Odczytywanie…"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("Nagraj post głosowy"),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Nagraj ponownie"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("Usuń z moderatorów"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("Usuń ze społeczności"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("Usuń z zapisanych"),
      "literalremoveLabel": (Object a0) => "Usuń ${a0}",
      "literalremoveLanguageEnglishname": (Object a0) => "Usuń ${a0}",
      "literalremoveMemberDisplayname": (Object a0) => "Usunąć ${a0}?",
      "literalremoveThePoll":
          MessageLookupByLibrary.simpleMessage("Usuń ankietę"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("Usuń tę odpowiedź"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("Usuń tę rozmowę"),
      "literalremoveThisPoll":
          MessageLookupByLibrary.simpleMessage("Usuń tę ankietę"),
      "literalreportAuthor": (Object a0) => "Zgłoś ${a0}",
      "literalreportPost": MessageLookupByLibrary.simpleMessage("Zgłoś post"),
      "literalresendCode":
          MessageLookupByLibrary.simpleMessage("Wyślij kod ponownie"),
      "literalsavedPosts":
          MessageLookupByLibrary.simpleMessage("Zapisane posty"),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("Napisz coś"),
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Napisz coś do ${a0}",
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Wyszukiwanie nie powiodło się"),
      "literalsendAgain":
          MessageLookupByLibrary.simpleMessage("Wyślij ponownie"),
      "literalsendAgainInCooldownS": (Object a0) =>
          "Wyślij ponownie za ${a0} s",
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Wyślij opinię"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("Wyślij link"),
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Wysłano. To raport nr ${a0}.",
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("Ustaw hasło i kontynuuj"),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
          "Udostępnij dziennik pomocy technicznej"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("Udostępnij tę społeczność"),
      "literalshareThisPage":
          MessageLookupByLibrary.simpleMessage("Udostępnij tę stronę"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("Udostępnij ten profil"),
      "literalshareVia":
          MessageLookupByLibrary.simpleMessage("Udostępnij przez…"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("Udostępnij z cytatem"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("Pokazuj więcej takich postów"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Pokaż hasło"),
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Pokaż wyniki"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("Załóż społeczność"),
      "literalstartRecording":
          MessageLookupByLibrary.simpleMessage("Rozpocznij nagrywanie"),
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Zatrzymaj wczytywanie"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
              "Nie pokazuj tego posta ani odpowiedzi na niego"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Pasek relacji, elementy: ${a0}",
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Przełącz aparat"),
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("Oznacz kogoś"),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Zrób zdjęcie"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
              "Stuknij baner lub zdjęcie, aby je zmienić"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("Stuknij link w środku"),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
          "Stuknij, aby dodać zdjęcie i okładkę"),
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
              "Nie udało się. Spróbuj ponownie."),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
              "Nie udało się pobrać tego GIF-a."),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
              "Tego linku nie da się tu otworzyć."),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("Aparat jest zamknięty"),
      "literalthisCommunity":
          MessageLookupByLibrary.simpleMessage("Ta społeczność"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("Tej odpowiedzi już nie ma"),
      "literaltranslatePost":
          MessageLookupByLibrary.simpleMessage("Przetłumacz post"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Wyłącz dźwięk"),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Włącz dźwięk"),
      "literaluseOneOfOurs":
          MessageLookupByLibrary.simpleMessage("Użyj jednego z naszych"),
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
          "Kod weryfikacyjny wysłany ponownie."),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Weryfikacja nie powiodła się: ${a0}",
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Zweryfikuj e-mail"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
              "Widzowie, polubienia, zapisy i komentarze"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Co przechowuje Kyron"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("Co robiła ta aplikacja"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
              "Co zrobiłeś, czego się spodziewałeś, co się stało "),
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
          "To, co publikujesz, należy do ciebie"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Czy Kyron jest teraz dostępny"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Kto może odpowiadać"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("Kogo chcesz oznaczyć?"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
              "Obserwujesz już wszystkie popularne tagi"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("Jesteś na bieżąco"),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
          "Nie należysz do żadnej społeczności"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("Wylogowano."),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalyouHaveLeftCommunityName": (Object a0) => "Opuszczono ${a0}",
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("Jeszcze nic nie opublikowano"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Wczytaj więcej"),
      "logCleared":
          MessageLookupByLibrary.simpleMessage("Dziennik wyczyszczony"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Dziennik skopiowany"),
      "logIn": MessageLookupByLibrary.simpleMessage("Zaloguj się"),
      "logOut": MessageLookupByLibrary.simpleMessage("Wyloguj się"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Wylogować się?"),
      "login": MessageLookupByLibrary.simpleMessage("Logowanie"),
      "loginFailed": MessageLookupByLibrary.simpleMessage(
          "Logowanie nie powiodło się. Sprawdź dane logowania."),
      "manage": MessageLookupByLibrary.simpleMessage("Zarządzaj"),
      "menu": MessageLookupByLibrary.simpleMessage("Menu"),
      "message": MessageLookupByLibrary.simpleMessage("Wiadomość"),
      "messages": MessageLookupByLibrary.simpleMessage("Wiadomości"),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
          "Wszystkie rozmowy są na bieżąco."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "Otwórz czyjś profil i stuknij Wiadomość, aby rozpocząć rozmowę."),
      "mute": MessageLookupByLibrary.simpleMessage("Wycisz"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Wyciszeni i zablokowani"),
      "mutedWordsAndTags":
          MessageLookupByLibrary.simpleMessage("Wyciszone słowa i tagi"),
      "name": MessageLookupByLibrary.simpleMessage("Nazwa"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("Ekran <name>"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("Nowy adres e-mail"),
      "newPassword": MessageLookupByLibrary.simpleMessage("Nowe hasło"),
      "newPost": MessageLookupByLibrary.simpleMessage("Nowy post"),
      "normalised": (Object a0) => "#\\${a0}",
      "notNow": MessageLookupByLibrary.simpleMessage("Nie teraz"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
          "Nie wysłano. Stuknij, aby ponowić"),
      "nothingMatchesQuery": (Object a0) => "Nic w Kyron nie pasuje do „${a0}”",
      "nothingToCopy":
          MessageLookupByLibrary.simpleMessage("Nie ma czego kopiować"),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "Tutaj trafiają polubienia, odpowiedzi i nowi obserwujący."),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
          "Tutaj pojawiają się osoby, które cię obserwują."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "Gdy ktoś polubi twój post, zobaczysz to tutaj."),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
          "Tutaj trafiają odpowiedzi na twoje posty."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "Gdy ktoś udostępni twój post, zobaczysz to tutaj."),
      "notifications": MessageLookupByLibrary.simpleMessage("Powiadomienia"),
      "openInBrowser":
          MessageLookupByLibrary.simpleMessage("Otwórz w przeglądarce"),
      "or": MessageLookupByLibrary.simpleMessage("lub"),
      "pageNotFound":
          MessageLookupByLibrary.simpleMessage("Nie znaleziono strony"),
      "password": MessageLookupByLibrary.simpleMessage("Hasło"),
      "passwordTooShort":
          MessageLookupByLibrary.simpleMessage("Hasło jest za krótkie"),
      "pickYourInterests":
          MessageLookupByLibrary.simpleMessage("Wybierz swoje zainteresowania"),
      "post": MessageLookupByLibrary.simpleMessage("Opublikuj"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("Statystyki posta"),
      "postInCommunity": (Object a0) => "Opublikuj w ${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("Opublikuj, powiedz, pokaż."),
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Skopiowano tekst posta"),
      "privacyPolicy":
          MessageLookupByLibrary.simpleMessage("Polityka prywatności"),
      "profileUpdated":
          MessageLookupByLibrary.simpleMessage("Profil zaktualizowany"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Kraj"),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Wyświetlana nazwa"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Lokalizacja"),
      "profile_tap_to_change":
          MessageLookupByLibrary.simpleMessage("Stuknij, aby zmienić"),
      "profile_website":
          MessageLookupByLibrary.simpleMessage("Strona internetowa"),
      "pushNotifications":
          MessageLookupByLibrary.simpleMessage("Powiadomienia push"),
      "quote": MessageLookupByLibrary.simpleMessage("Cytuj"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Cytuj post"),
      "reachAPerson":
          MessageLookupByLibrary.simpleMessage("Porozmawiaj z człowiekiem"),
      "remove": MessageLookupByLibrary.simpleMessage("Usuń"),
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("Usunąć tę rozmowę?"),
      "removeMember": (Object a0) => "Usunąć ${a0}?",
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Usunąć tę wiadomość?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
          "Odpowiedzi, obserwacje i wzmianki"),
      "repliesPolicy": (Object a0) => "Odpowiedzi: ${a0}",
      "reply": MessageLookupByLibrary.simpleMessage("Odpowiedz"),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Każdy może reagować"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "Każdy nadal może zobaczyć, udostępnić i zacytować ten post."),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Każdy w Kyron może odpowiedzieć na ten post."),
      "reply_followers":
          MessageLookupByLibrary.simpleMessage("Osoby, które cię obserwują"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "Tylko osoby, które cię obserwują, mogą odpowiedzieć na ten post."),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("Osoby, o których wspominasz"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "Odpowiadać mogą tylko osoby @wspomniane w tym poście."),
      "reply_nobody":
          MessageLookupByLibrary.simpleMessage("Nikt nie może odpowiadać"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "Odpowiedzi są wyłączone. Ty nadal możesz odpowiedzieć."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Kto może odpowiadać?"),
      "report": MessageLookupByLibrary.simpleMessage("Zgłoś"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "Raport skopiowany. Wklej go do e-maila do pomocy technicznej."),
      "reportSent": MessageLookupByLibrary.simpleMessage("Zgłoszenie wysłane"),
      "repost": MessageLookupByLibrary.simpleMessage("Udostępnij dalej"),
      "reset": MessageLookupByLibrary.simpleMessage("Resetuj"),
      "resetPassword": MessageLookupByLibrary.simpleMessage("Zresetuj hasło"),
      "retry": MessageLookupByLibrary.simpleMessage("Ponów"),
      "save": MessageLookupByLibrary.simpleMessage("Zapisz"),
      "saveDraft":
          MessageLookupByLibrary.simpleMessage("Zapisz wersję roboczą"),
      "saySomething": (Object a0) => "Napisz coś do ${a0}",
      "search": MessageLookupByLibrary.simpleMessage("Szukaj"),
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
          "Szukaj po nazwie lub nazwie użytkownika"),
      "searchCommunities":
          MessageLookupByLibrary.simpleMessage("Szukaj społeczności"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Szukaj GIF-ów"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("Szukaj języków"),
      "searchTrendingTags":
          MessageLookupByLibrary.simpleMessage("Szukaj popularnych tagów"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
          "Alerty bezpieczeństwa i zmiany konta"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
          "Wybierz język interfejsu aplikacji."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "Wybierz języki, które mają zawierać twoje kanały. Jeśli nie wybierzesz żadnego, pokazane będą wszystkie."),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
          "Wybierz preferowany język tłumaczeń w swoim kanale."),
      "send": MessageLookupByLibrary.simpleMessage("Wyślij"),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Wyślij potwierdzenie"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Wyślij raport o błędzie"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Wyślij opinię"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Wyślij zgłoszenie"),
      "sendToSupport":
          MessageLookupByLibrary.simpleMessage("Wyślij do pomocy technicznej"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Stan usługi"),
      "settings": MessageLookupByLibrary.simpleMessage("Ustawienia"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
          "Udostępnij dziennik aplikacji pomocy technicznej"),
      "signInToKyron":
          MessageLookupByLibrary.simpleMessage("Zaloguj się do Kyron"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Zalogowano jako"),
      "signupFailed": (Object a0) => "Rejestracja nie powiodła się: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("Zostań"),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron jest na początku drogi, a najszybszy sposób, by dotrzeć do kogoś, kto naprawi problem, to zgłoszenie. Opisz, co robiłeś i co się stało."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "W aplikacji nie ma jeszcze skrzynki pomocy, więc ten ekran wskazuje miejsce, które naprawdę jest monitorowane, a nie formularz, który nigdzie nie trafia."),
      "systemLog": MessageLookupByLibrary.simpleMessage("Dziennik systemowy"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
          "Powiedz nam, czego brakuje lub co nie działa"),
      "terms": MessageLookupByLibrary.simpleMessage("Warunki"),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "Tekst, głos i wideo, ludzie, którzy je tworzą, i pokoje, w których rozmawiają."),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
          "Edytor nie ma przycisku Opublikuj"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Ciemny"),
      "theme_dark_detail":
          MessageLookupByLibrary.simpleMessage("Zawsze ciemny"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Przygaszony"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
          "Łagodniejszy ciemny, niebieskoszary zamiast czarnego"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Jasny"),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Zawsze jasny"),
      "theme_system": MessageLookupByLibrary.simpleMessage("Systemowy"),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
          "Zgodnie z jasnym lub ciemnym ustawieniem telefonu"),
      "translate": MessageLookupByLibrary.simpleMessage("Przetłumacz"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "Tłumaczenie jeszcze nie działa. Dziś nic w kanale nie jest tłumaczone; to ustawienie zostanie zapamiętane na później."),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "To zmienia słowa Kyron, części interfejsu rysowane przez samego Fluttera, daty i liczby oraz kierunek układu aplikacji dla języków pisanych od prawej do lewej."),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Spróbuj ponownie"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("Polityka prywatności"),
      "ui_about_terms_of_service":
          MessageLookupByLibrary.simpleMessage("Warunki korzystania z usługi"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Konto"),
      "ui_after": MessageLookupByLibrary.simpleMessage("Po"),
      "ui_app_device":
          MessageLookupByLibrary.simpleMessage("Aplikacja i urządzenie"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "Cytat miał ostrzec innych przed oszustwem."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Napisz, dlaczego uważasz, że decyzja była błędna: co oznaczał post, co zespół mógł przeoczyć albo dlaczego zasada tu nie pasuje. Przeczyta to ktoś inny niż osoba, która zdecydowała."),
      "ui_appeal_label":
          MessageLookupByLibrary.simpleMessage("Twoje odwołanie"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Napisz co najmniej \$count znaków. Od każdej decyzji możesz odwołać się raz."),
      "ui_appeal_send":
          MessageLookupByLibrary.simpleMessage("Wyślij odwołanie"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Odwołanie wysłane. Dostaniesz powiadomienie, gdy zapadnie decyzja."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Odwołanie w sprawie \$number"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Wygląd"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
          "Jasny, ciemny lub zgodny z ustawieniem telefonu"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Przed"),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "Żadne z was nie zobaczy drugiego w Kyron, a obserwacje między wami zostaną usunięte. Ta osoba nie zostanie powiadomiona."),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Zawierające"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("Do czego służy (opcjonalnie)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Tylko moderatorzy mogą pisać"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "Do ogłoszeń. Wszyscy w społeczności nadal mogą czytać i reagować."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Dodaj zdjęcie lub ankietę"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Zdjęcia i filmy"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Zamknij czat"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Nikt nie będzie mógł w nim czytać ani pisać. Tego nie da się cofnąć."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Zamknąć ten czat?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Skopiowano"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "Wiadomość zostaje usunięta dla wszystkich. Kyron zachowuje kopię do weryfikacji."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "Wiadomość zostaje usunięta dla wszystkich na czacie."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Edytuj czat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Edytuj"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("edytowano"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Edytujesz swoją wiadomość"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się otworzyć tego czatu."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Czaty"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("Dołącz do czatu"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Dołącz do społeczności, aby widzieć jej czaty i brać w nich udział."),
      "ui_cchat_joined":
          MessageLookupByLibrary.simpleMessage("Dołączyło: \$count"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Opuść czat"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Nadal możesz go czytać, dopóki jesteś w społeczności."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Tylko właściciel i moderatorzy mogą tu pisać."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Wycisz"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Bez powiadomień z tego czatu i bez liczenia go w Wiadomościach."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Nazwa czatu"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("Nowy czat"),
      "ui_cchat_none":
          MessageLookupByLibrary.simpleMessage("Nie ma jeszcze czatów."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "Nie ma jeszcze czatów. Otwórz jeden dla społeczności."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Czaty społeczności nie są szyfrowane end-to-end. Moderatorzy społeczności i Kyron mogą je czytać."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Przypnij na górze"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Dodaj odpowiedź"),
      "ui_cchat_poll_close":
          MessageLookupByLibrary.simpleMessage("Zamknij ankietę"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Zamknięta"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Wszyscy widzą, ile osób wybrało każdą odpowiedź, nigdy kto."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Pozwól wybrać kilka"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("Nowa ankieta"),
      "ui_cchat_poll_one":
          MessageLookupByLibrary.simpleMessage("Wybierz jedną"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Odpowiedź \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Ankieta: \$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("Pytanie"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Każda odpowiedź może być w ankiecie tylko raz."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Wybierz jedną lub więcej"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("Odpowiedzi: \$count"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Szukaj w tym czacie"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Szukaj w tym czacie"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Nic nie znaleziono."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "Nie możesz już widzieć tego czatu."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Tryb powolny"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "Ile trzeba czekać między wiadomościami. Nie dotyczy moderatorów."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 godzina"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("Minuty: \$n"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Tryb powolny: jedna wiadomość co \$seconds s"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Wyłączony"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("Sekundy: \$n"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "Możesz czytać i reagować jako widz. Dołącz, aby pisać."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "Ta wiadomość jest zbyt daleko wstecz, by ją pokazać."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Jeden z wybranych plików jest za duży, by go wysłać, i został pominięty."),
      "ui_cchat_unmute":
          MessageLookupByLibrary.simpleMessage("Wyłącz wyciszenie"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Odepnij"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Nagraj wiadomość głosową"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("Ty"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Społeczności"),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("Do czego służy? (opcjonalnie)"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Posty:"),
      "ui_content_display":
          MessageLookupByLibrary.simpleMessage("Treści i wyświetlanie"),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("Nie udało się wczytać kanału"),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać polubionych postów"),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać twojego profilu"),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać zapisanych postów"),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage(
          "Zdecentralizowany identyfikator"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnostyka"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Grupy"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("Brak grup"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Tu znajdziesz grupy, w których jesteś, i czaty społeczności, do których dołączasz."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "Możesz przypiąć maksymalnie \$count czatów. Najpierw odepnij jeden."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Przypięty"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Polubione"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Zapisane"),
      "ui_feed_empty":
          MessageLookupByLibrary.simpleMessage("Na razie nic tu nie ma"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "Obserwuj kilka kont, a ich posty pojawią się tutaj."),
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("Nic od obserwowanych osób"),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
          "Posty pojawią się tutaj, gdy ludzie zaczną je pisać."),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Słabnie"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Nie interesuje mnie"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Pokaż więcej takich"),
      "ui_feed_signal_removed":
          MessageLookupByLibrary.simpleMessage("Usunięto"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Sygnały Twojego kanału"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Stuknij w poście Pokaż więcej takich postów lub Nie interesuje mnie to, a pojawi się tutaj."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Na razie nic tu nie ma"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "Co Pokaż więcej i Nie interesuje mnie mówią Twoim kanałom"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "Kształtują Główną i Odkrywaj, głównie według tematu każdego posta. Każdy co miesiąc słabnie o połowę i po sześciu przestaje się liczyć. Usuń któryś, aby zatrzymać go teraz."),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
          "Tutaj pojawią się posty z klipami."),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("Brak filmów"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Opinie"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Znajdź ludzi w Kyron"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("Z konta"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Dodaj osoby"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Dodaj"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Dodaj nazwę grupy"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Odrzuć"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Wiadomości w tej grupie są szyfrowane end-to-end, jak każda inna rozmowa."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor dodaje: \$users"),
      "ui_group_event_admin": MessageLookupByLibrary.simpleMessage(
          "\$actor nadaje rolę admina: \$users"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor tworzy grupę"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor ustawia, że nowe osoby dołączają jako członkowie"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor ustawia, że nowe osoby dołączają jako widzowie"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor opuszcza grupę"),
      "ui_group_event_member": MessageLookupByLibrary.simpleMessage(
          "\$actor nadaje rolę członka: \$users"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor przekazuje własność: \$users"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor usuwa: \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor zmienia nazwę grupy na \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor nadaje rolę widza: \$users"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "Grupa może mieć najwyżej \$count osób."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Ręka podniesiona. Admini zostali powiadomieni."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("Chcą pisać: \$count"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Chcą pisać"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "Osoby dodane później dołączają jako widzowie"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Opuść grupę"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "Zniknie z Twojej listy i nie zobaczysz, co zostanie napisane później. Ktoś musiałby dodać Cię ponownie."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Opuścić tę grupę?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Pozwól pisać"),
      "ui_group_lower_hand": MessageLookupByLibrary.simpleMessage("Opuść rękę"),
      "ui_group_make_admin":
          MessageLookupByLibrary.simpleMessage("Nadaj rolę admina"),
      "ui_group_make_owner":
          MessageLookupByLibrary.simpleMessage("Przekaż własność"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Nadaj rolę widza"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("Członkowie: \$count"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Członkowie"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Nazwa grupy"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Najpierw nazwij grupę."),
      "ui_group_new":
          MessageLookupByLibrary.simpleMessage("Utwórz czat grupowy"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "Właściciel jest jeden. Pozostaniesz adminem."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Przekazać własność: \$name?"),
      "ui_group_raise_hand":
          MessageLookupByLibrary.simpleMessage("Podnieś rękę"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("Usuń z grupy"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Odbierz rolę admina"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "Nie należysz już do tej grupy."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Zmień nazwę"),
      "ui_group_role_admin":
          MessageLookupByLibrary.simpleMessage("Administrator"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Członek"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("Widz"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "Jako widz możesz tu czytać i reagować."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Widzowie mogą czytać, reagować i podnieść rękę, by poprosić o pisanie."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Sugerowane"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("Zobacz profil"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("Ty"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("Jesteś widzem"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Pomoc"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
          "Zanotowano. To pomaga dobierać to, co widzisz."),
      "ui_join": MessageLookupByLibrary.simpleMessage("Dołącz"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Dołączono"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Język"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Wybierz język"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Informacje prawne"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Polub"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("Polubione posty"),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Tutaj pojawiają się posty, które lubisz, od najnowszych."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Skopiowano link"),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Przestaniesz widzieć posty tej osoby. Nie zostanie powiadomiona."),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage("Brak polubień"),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
          "Żaden post nie pasuje do tych filtrów."),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("Nic jeszcze nie zapisano"),
      "ui_notif_account_update": MessageLookupByLibrary.simpleMessage(
          "Twoje konto zostało zaktualizowane"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Twoje odwołanie w sprawie \$number zostało przyjęte"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Ponownie rozpatrzyliśmy Twoje odwołanie w sprawie \$number i decyzja zostaje utrzymana"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage(
          "Twoje konto zostało zablokowane na stałe"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Sprawa \$number · \$rule"),
      "ui_notif_followed":
          MessageLookupByLibrary.simpleMessage("obserwuje Cię"),
      "ui_notif_liked":
          MessageLookupByLibrary.simpleMessage("polubił(a) Twój post"),
      "ui_notif_mentioned":
          MessageLookupByLibrary.simpleMessage("wspomniał(a) o Tobie"),
      "ui_notif_no_mentions":
          MessageLookupByLibrary.simpleMessage("Na razie brak wzmianek"),
      "ui_notif_no_mentions_detail": MessageLookupByLibrary.simpleMessage(
          "Gdy ktoś napisze Twój @login w poście lub odpowiedzi, zobaczysz to tutaj."),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Starsze"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Twoja wiadomość na czacie społeczności została usunięta"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Jedna z Twoich publikacji została usunięta"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Twój post został usunięty"),
      "ui_notif_removed_reply": MessageLookupByLibrary.simpleMessage(
          "Twoja odpowiedź została usunięta"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("odpowiedział(a) na Twój post"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "Podjęliśmy działania w sprawie Twojego zgłoszenia. Dziękujemy za informację."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "Sprawdziliśmy Twoje zgłoszenie i nie stwierdziliśmy naruszenia naszych zasad."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Zgłoszono za: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("udostępnił(a) Twój post"),
      "ui_notif_reversed": MessageLookupByLibrary.simpleMessage(
          "Cofnęliśmy decyzję w sprawie \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Twoje konto jest zawieszone"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Twoje konto jest zawieszone do \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("Wszystkie"),
      "ui_notif_tab_follows":
          MessageLookupByLibrary.simpleMessage("Obserwujący"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Polubienia"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("Wzmianki"),
      "ui_notif_tab_replies":
          MessageLookupByLibrary.simpleMessage("Odpowiedzi"),
      "ui_notif_this_week":
          MessageLookupByLibrary.simpleMessage("W tym tygodniu"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Dzisiaj"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage(
          "Twoje konto otrzymało ostrzeżenie"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Wczoraj"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("Zakończ"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("Pomiń"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("To zostało już otwarte."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Wygasło"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("Nie udało się tego otworzyć."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Otwiera się raz, potem zostaje usunięte z Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("Wyświetl raz"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Otwarte"),
      "ui_once_opened_by": MessageLookupByLibrary.simpleMessage(
          "Otwarte przez \$count z \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Tylko osoby, do których to wysłano, mogą to otworzyć, raz."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage(
          "Wyślij do jednorazowego wyświetlenia"),
      "ui_once_tap":
          MessageLookupByLibrary.simpleMessage("Dotknij, aby zobaczyć"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Wstrzymaj"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Odtwórz"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "Zostanie usunięty z twojego profilu i z kanałów wszystkich innych. Odpowiedzi znikną razem z nim."),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("Post usunięty"),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("Post ukryty"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("Skopiowano tekst posta"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Opublikowane między"),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "Ukryto. Pokażemy mniej podobnych."),
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Preferencje"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Prywatność"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage(
          "Chcesz coś dodać? (opcjonalnie)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "Dostaniesz powiadomienie, gdy zespół podejmie decyzję, a sprawę możesz śledzić w sekcji Twoje zgłoszenia."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "Jeśli nie chcesz też widzieć tej osoby, wycisz ją lub zablokuj w tym samym menu."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Ponowne zgłoszenie tego samego nie dodaje mu wagi: przechowujemy jedno zgłoszenie od osoby."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Twoje zgłoszenie nie jest udostępniane tej osobie. Zachowujemy kopię zgłoszonej treści, żeby można ją było sprawdzić nawet po usunięciu."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Twoje zgłoszenie zostało przyjęte i czeka na sprawdzenie. Nie mówimy tej osobie, kto je zgłosił."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("Zobacz swoje zgłoszenia"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Powiedz nam, co jest nie tak"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Dziękujemy za zgłoszenie"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("Co jest nie tak z \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "Co jest nie tak z tą wiadomością?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("Co jest nie tak z tym postem?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "Co jest nie tak z tą odpowiedzią?"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage(
          "Wiadomość na czacie społeczności"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("Post"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("Odpowiedź"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Podjęto działania"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("Konto"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Rozstrzygnięto \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("Bez naruszenia zasad"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać Twoich zgłoszeń"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "Twoje zgłoszenia z ostatnich 90 dni i to, co z nich wynikło. Dostajesz powiadomienie, gdy zespół podejmie decyzję. Nikt, kogo zgłaszasz, nie dowie się, kto go zgłosił."),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("Brak zgłoszeń"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "Gdy zgłosisz post, odpowiedź, wiadomość lub konto, pojawi się tutaj razem z tym, co z tego wynikło."),
      "ui_reports_pending":
          MessageLookupByLibrary.simpleMessage("W trakcie weryfikacji"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Zgłoszono \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "Twoje zgłoszenia i to, co z nich wynikło"),
      "ui_reports_title":
          MessageLookupByLibrary.simpleMessage("Twoje zgłoszenia"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Bezpieczeństwo dzieci"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Wszystko, co zagraża nieletnim lub ich seksualizuje."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Celowe nękanie, groźby lub niechciany kontakt."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Atakowanie ludzi za to, kim są."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Sprzedaż lub promowanie czegoś nielegalnego."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Podszywanie się pod kogoś innego."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Wykorzystuje Twoje dzieło lub znak towarowy bez zgody."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Wprowadzające w błąd twierdzenia o zdrowiu, wyborach lub wydarzeniach."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Zachęcanie do samookaleczeń lub ich pokazywanie."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Treści seksualne pokazywane bez ostrzeżenia."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "Żadne z powyższych. Powiedz nam, co jest nie tak."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Powtarzalna, wprowadzająca w błąd lub niechciana promocja."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Grożenie przemocą, gloryfikowanie jej lub nawoływanie do niej."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Nękanie lub zastraszanie"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Mowa nienawiści"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Nielegalne towary lub usługi"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Podszywanie się"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Własność intelektualna"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("Fałszywe informacje"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage(
          "Samobójstwo lub samookaleczenie"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Treści dla dorosłych"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Coś innego"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spam"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Przemoc lub groźby"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("Zapisane posty"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "Stuknij ikonę archiwum przy poście, aby go tu zachować. Tylko ty widzisz, co zapisujesz."),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
              "Szukaj po nazwie użytkownika lub wyświetlanej nazwie."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Wyczyść"),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
          "Przeszukaj wszystko, co opublikowano"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filtry"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Szukaj ludzi"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("Szukaj postów"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Ustawienia"),
      "ui_settings_app_device":
          MessageLookupByLibrary.simpleMessage("Aplikacja i urządzenie"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("Treści i wyświetlanie"),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Oszczędzanie danych"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("Powiedz nam, co myślisz"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("Przeglądaj artykuły pomocy"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("Wybierz język"),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
          "Kogo wyciszyłeś lub zablokowałeś"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("Preferencje powiadomień"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("Twój profil i dane kontaktowe"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
              "Aby wrócić do konta, musisz zalogować się ponownie."),
      "ui_settings_security":
          MessageLookupByLibrary.simpleMessage("Ustawienia bezpieczeństwa"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Potwierdź hasło"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("W jednym zdaniu"),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("Nowy adres e-mail"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("Nowe hasło"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("Co się stało"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
          "Uzyskaj pomoc od naszego zespołu"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Udostępnij"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("Cytuj"),
      "ui_share_send_message":
          MessageLookupByLibrary.simpleMessage("Wyślij w wiadomości"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("Do osób na Kyronie"),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Udostępnij ten post"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("Czego dotyczyło"),
      "ui_standing_account_banned": MessageLookupByLibrary.simpleMessage(
          "Twoje konto jest zablokowane na stałe"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("Odpowiedź, \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Odwołanie"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Odwołaj się od tej decyzji"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "Od tej decyzji nie można już się odwołać. Jeśli coś jest nie tak, skontaktuj się z pomocą."),
      "ui_standing_appeal_open": MessageLookupByLibrary.simpleMessage(
          "Odwołanie w trakcie rozpatrywania"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Odwołanie przyjęte"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Ktoś inny z zespołu przygląda się temu ponownie. Dostaniesz powiadomienie, gdy zapadnie decyzja."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "Jeśli uważasz, że to pomyłka, możesz do \$date poprosić o ponowne rozpatrzenie. Decyduje ktoś inny z zespołu."),
      "ui_standing_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "Po odwołaniu: decyzja zostaje utrzymana"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Sprawa \$number. Zasada: \$rule. Zespół napisał:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Usunięcie konta nie znosi blokady: nowe konto z tym samym adresem e-mail też będzie zablokowane."),
      "ui_standing_banned":
          MessageLookupByLibrary.simpleMessage("Zablokowane na stałe"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Działają już tylko ta strona, odwołania, pomoc i usunięcie konta."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Można się odwołać"),
      "ui_standing_case":
          MessageLookupByLibrary.simpleMessage("Sprawa \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Decyzja z \$date"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage(
          "Decyzje dotyczące Twojego konta"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Usuń konto"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("Zobacz szczegóły"),
      "ui_standing_details_appeal": MessageLookupByLibrary.simpleMessage(
          "Zobacz szczegóły i odwołaj się"),
      "ui_standing_ends":
          MessageLookupByLibrary.simpleMessage("Kończy się \$date"),
      "ui_standing_good":
          MessageLookupByLibrary.simpleMessage("Twoje konto jest w porządku"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Nic go nie ogranicza."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać statusu konta"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Wiadomość usunięta"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Nie podjęto żadnych decyzji dotyczących Twojego konta. Jeśli zespół kiedykolwiek usunie coś Twojego lub ograniczy Twoje konto, pojawi się to tutaj wraz z powodem i będzie można się odwołać."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Nie ma od czego się odwoływać: decyzję cofnięto."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Post usunięty"),
      "ui_standing_pull_to_check": MessageLookupByLibrary.simpleMessage(
          "Przeciągnij w dół, aby sprawdzić ponownie."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Przeczytaj zasady Kyron"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Odpowiedź usunięta"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Cofnięto"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Cofnięto \$date. Wszystko, co usunięto, wróciło, a żadne ograniczenie już nie obowiązuje."),
      "ui_standing_rule":
          MessageLookupByLibrary.simpleMessage("Zasada: \$rule"),
      "ui_standing_sign_out":
          MessageLookupByLibrary.simpleMessage("Wyloguj się"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Zawieszone"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "Możesz czytać, ale nie możesz publikować, odpowiadać, obserwować ani wysyłać wiadomości. Zgłaszanie, blokowanie i wyciszanie nadal działają."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Twoje konto jest zawieszone: możesz czytać, ale nie publikować."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Zawieszone do \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Twoje konto jest zawieszone do \$date: możesz czytać, ale nie publikować."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("Co napisał zespół"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("Status konta"),
      "ui_standing_warning":
          MessageLookupByLibrary.simpleMessage("Ostrzeżenie"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Dlaczego?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("Twoje słowa, \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Twoja wiadomość"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Twój post"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Twoja odpowiedź"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Warunki"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("ten post"),
      "ui_thread_muted":
          MessageLookupByLibrary.simpleMessage("Wątek wyciszony"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Spróbuj ponownie"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Wyłącz dźwięk"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Włącz dźwięk"),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("Co najmniej dwa znaki."),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Cofnij"),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "Słowa albo filtr: konto, zakres dat lub to, co zawiera post."),
      "undoRepost":
          MessageLookupByLibrary.simpleMessage("Cofnij udostępnienie"),
      "updatePassword":
          MessageLookupByLibrary.simpleMessage("Zaktualizuj hasło"),
      "useDifferentAddress":
          MessageLookupByLibrary.simpleMessage("Użyj innego adresu"),
      "username": MessageLookupByLibrary.simpleMessage("Nazwa użytkownika"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "Nazwa użytkownika musi być pisana małymi literami (a-z, 0-9, _)"),
      "video": MessageLookupByLibrary.simpleMessage("Wideo"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("Dołącz"),
      "voice_ready_attach":
          MessageLookupByLibrary.simpleMessage("Gotowe do dołączenia"),
      "voice_record_post":
          MessageLookupByLibrary.simpleMessage("Nagraj post głosowy"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("Nagrywanie…"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("Zatrzymaj"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("Co się stało"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "Co się stało i na co powinniśmy zwrócić uwagę?",
      ),
      "whatInPicture":
          MessageLookupByLibrary.simpleMessage("Co jest na tym zdjęciu?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("Do czego służy? (opcjonalnie)"),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
          "Co zrobiłeś, czego się spodziewałeś, co się stało"),
      "whatYouWereDoing":
          MessageLookupByLibrary.simpleMessage("Co robiłeś, gdy to się stało."),
      "ui_dm_you_replied":
          MessageLookupByLibrary.simpleMessage("Twoja odpowiedź"),
      "dmReplied": (Object a0) => "Odpowiedź od $a0",
      "ui_dm_attach":
          MessageLookupByLibrary.simpleMessage("Dodaj do wiadomości"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("Nowa wiadomość"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Jeszcze nic nie zostało powiedziane. Pomachanie to dobry początek."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Pomachaj"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("Nowe wiadomości"),
      "dmTyping": (Object a0) => "$a0 pisze",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Usuń swoją reakcję"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Ktoś"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Wiadomość"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Załącznik"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "Tej wiadomości nie można odczytać na tym urządzeniu."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Oczekiwanie na tę wiadomość. Może to chwilę potrwać."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Zaszyfrowana wiadomość"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Wiadomości są szyfrowane end-to-end"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Bez szyfrowania end-to-end"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Wysłano"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Wyświetlono"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Wysyłanie…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Zrób zdjęcie"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("Więcej opcji"),
      "ui_media_save":
          MessageLookupByLibrary.simpleMessage("Zapisz na urządzeniu"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Udostępnij"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Zapisywanie…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Zapisano w zdjęciach"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się zapisać. Spróbuj ponownie."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Pozwól Kyronowi dodawać do zdjęć, aby to zapisać."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("Wszystkie systemy działają"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Dostępność"),
      "ui_status_last_60":
          MessageLookupByLibrary.simpleMessage("Ostatnie 60 dni"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 dni temu"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Dziś"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Baza danych"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Logowanie"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Ostatnie incydenty"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "Brak incydentów w ostatnich 60 dniach."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Trwa"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("Brak danych"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Szczegóły"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron sprawdza się co 5 minut, gdy działa. W szary dzień nie było sprawdzeń."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Historia dostępności nie jest jeszcze dostępna."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Niektóre systemy mają problemy"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Nagraj wiadomość głosową"),
      "voice_ready_send":
          MessageLookupByLibrary.simpleMessage("Gotowe do wysłania"),
      "ui_dm_quote_gone":
          MessageLookupByLibrary.simpleMessage("Tej wiadomości już tu nie ma."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Przejdź do wiadomości"),
      "ui_dm_quote_voice":
          MessageLookupByLibrary.simpleMessage("Wiadomość głosowa"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Autor polubił"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Dodaj zdjęcie lub klip"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Multimedia"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Wiadomości głosowe"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Czat"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Tapeta"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Wycisz powiadomienia"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Przestań otrzymywać powiadomienia o tej rozmowie"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("Nie mogą już do Ciebie pisać"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("Brak"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Zdjęcie"),
      "ui_dm_unmuted":
          MessageLookupByLibrary.simpleMessage("Wyciszenie wyłączone."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się usunąć. Spróbuj ponownie."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profil"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Wyłącz wyciszenie"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Tu pojawiają się zdjęcia i klipy, które udostępniasz."),
      "ui_dm_info_see_all":
          MessageLookupByLibrary.simpleMessage("Zobacz wszystko"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Zdjęcia i klipy"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "Tak będzie wyglądał Twój czat."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Wygląda dobrze."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Mgła"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Zmierzch"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Szałwia"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Piasek"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Kropki"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Zastosuj"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("Obecna"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Wyślij bez podglądu"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Szukaj"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Opublikuj"),
      "ui_share_note":
          MessageLookupByLibrary.simpleMessage("Napisz wiadomość…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Wyślij"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Wysłano"),
      "ui_share_some_failed": MessageLookupByLibrary.simpleMessage(
          "Wysłano, ale nie do wszystkich."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wysłać. Spróbuj ponownie."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Obserwujący"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filtr"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("Wszystkie"),
      "ui_dm_filter_unread":
          MessageLookupByLibrary.simpleMessage("Nieprzeczytane"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Bez odpowiedzi"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Ukryte"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Nic nie jest ukryte"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Rozmowy usunięte z listy czekają tutaj, na wypadek gdybyś chciał je przywrócić."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "Trafia do Ukrytych. Druga osoba zachowuje swoją, a rozmowa wraca, jeśli któreś z was znowu napisze."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Przywróć"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Znowu na Twojej liście."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("Brak pasujących rozmów."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Nic na Ciebie nie czeka"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Każda rozmowa kończy się Twoim słowem."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Zdjęcie"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Zdjęcia"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Film"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("Jeszcze brak wiadomości"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("Ty:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Wczoraj"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Wiadomości"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Ustawienia wiadomości"),
      "ui_dm_settings_privacy":
          MessageLookupByLibrary.simpleMessage("Prywatność"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Potwierdzenia odczytu"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "Gdy to jest wyłączone, inni nie zobaczą, kiedy przeczytałeś ich wiadomości, a Ty nie zobaczysz, kiedy oni przeczytali Twoje."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Pokazuj, gdy piszesz"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "Osoba, do której piszesz, widzi, że piszesz."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Podglądy linków"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Twój telefon otwiera wysyłany link, aby utworzyć podgląd, więc strona widzi zapytanie Twojego telefonu. Serwer Kyron nigdy nie widzi linku."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Powiadomienia o wiadomościach"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Wiadomości są szyfrowane end-to-end. Kyron nie może ich czytać i nic tutaj tego nie zmienia."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("Do:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Ostatnie"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("Osoby"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Nikt o tej nazwie."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Wyślij powiadomienie testowe"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Serwer Kyron nie jest jeszcze skonfigurowany do wysyłania powiadomień, więc żadne nie może dotrzeć. Problem leży po naszej stronie, nie w Twoim telefonie."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "Ten telefon nie jest zarejestrowany do powiadomień. Sprawdź, czy powiadomienia Kyron są dozwolone w ustawieniach telefonu, i spróbuj ponownie."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "Nie udało się dostarczyć powiadomienia na ten telefon. Spróbuj ponownie za minutę."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Wysłano. Powinno dotrzeć w ciągu kilku sekund."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Powiadomienia działają."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("Jeszcze nie ma postów"),
      "ui_community_new":
          MessageLookupByLibrary.simpleMessage("Nowa społeczność"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Nazwa"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("Adres powstaje z nazwy."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("Ludzie znajdą ją pod adresem"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "Będziesz jej właścicielem. Zdjęcie, baner i moderatorów dodasz na jej stronie, gdy już powstanie."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Główna"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Posty społeczności na Głównej"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Posty z Twoich społeczności pojawiają się też na Głównej. Po wyłączeniu zostają tutaj, w Społecznościach, gdzie każda pokazuje, co nowego."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Twoja lista"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("Liczba nowych postów"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Pokazuj, ile postów jest nowych w każdej społeczności od czasu, gdy ostatnio ją otwierałeś."),
      "ui_community_settings_running": MessageLookupByLibrary.simpleMessage(
          "Społeczności, które prowadzisz"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Tu są społeczności, które zakładasz lub moderujesz."),
      "ui_community_role_owner":
          MessageLookupByLibrary.simpleMessage("Właściciel"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderator"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("Nowe posty"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Prowadzone przez Ciebie"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Ustawienia społeczności"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Odkrywaj"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("Żadna społeczność nie pasuje."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Nic nowego"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Każda społeczność jest taka, jak ją zostawiłeś."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("Nie prowadzisz jeszcze żadnej"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Nie ma już do czego dołączyć"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "Jesteś we wszystkich społecznościach na Kyronie. Załóż kolejną."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Spróbuj innego słowa albo załóż społeczność o tej nazwie."),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("Napisz post"),
      "ui_community_members":
          MessageLookupByLibrary.simpleMessage("Członkowie:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Opublikowano"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("Zobacz"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Otwórz"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Online"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Pokazuj, gdy jesteś online"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "Osoby, z którymi piszesz, widzą zieloną kropkę, gdy masz otwarty Kyron. Gdy to jest wyłączone, Ty też nie zobaczysz ich kropki."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Szukaj osób i postów"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage(
          "Społeczności, do których możesz dołączyć"),
      "ui_explore_grid_empty": MessageLookupByLibrary.simpleMessage(
          "Na razie nie ma tu nic do oglądania"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Tutaj pojawią się zdjęcia i klipy publikowane przez innych."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Obserwuj"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("Usuń konto"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "Spowoduje to trwałe usunięcie Twojego konta Kyron. Tej operacji nie można cofnąć."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Twój profil, posty, odpowiedzi, polubienia i udostępnienia"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Twoje wiadomości, także te wysłane innym, oraz zdjęcia i wiadomości głosowe w nich"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Twoi obserwujący, osoby, które obserwujesz, i Twoje ustawienia"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Założone przez Ciebie społeczności przejmie najdłużej działający moderator lub członek. Społeczność bez innych osób zostanie zamknięta."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Usunąć Twoje konto?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "Nie będzie można niczego odzyskać."),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("Twoje konto zostało usunięte."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Usunięte konto"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "To konto zostało usunięte, więc nie można już tu wysyłać wiadomości."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Rejestracja przez Google? Użyj zamiast tego „Sign in with Google”."),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać tego filtra."),
      "ar_could_not_record":
          MessageLookupByLibrary.simpleMessage("Nie udało się nagrać filmu."),
      "ar_lens_left_out": MessageLookupByLibrary.simpleMessage(
          "Nie udało się dodać filtra do tego filmu, więc zostanie opublikowany w oryginalnej postaci."),
      "ar_composer_full": MessageLookupByLibrary.simpleMessage(
          "Twój post ma już maksymalną liczbę załączników."),
      "ar_applying_lens":
          MessageLookupByLibrary.simpleMessage("Dodawanie filtra…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("Lampa błyskowa"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("Nagraj film"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("Zdjęcie"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("Wideo"),
      "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
          "Logowanie przez Google zostało anulowane."),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("PREZENTY"),
      "analytics_no_gifts_yet": MessageLookupByLibrary.simpleMessage(
          "Nikt jeszcze nie wysłał prezentu do tego posta."),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("Prezent"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("Prezenty"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("Monety"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("Nadawca"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("Nadawcy"),
      "analytics_test_coins": MessageLookupByLibrary.simpleMessage(
          "Monety testowe: nie można ich jeszcze wypłacić."),
      "ui_saved": MessageLookupByLibrary.simpleMessage("Zapisane"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("Posty"),
      "ui_saved_tab_comments":
          MessageLookupByLibrary.simpleMessage("Komentarze"),
      "ui_view_more_replies":
          MessageLookupByLibrary.simpleMessage("Zobacz więcej odpowiedzi"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("Edytowano"),
      "ui_more": MessageLookupByLibrary.simpleMessage("Więcej"),
      "ui_following": MessageLookupByLibrary.simpleMessage("Obserwowani"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("Najlepsze"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("Najnowsze"),
      "ui_sort_comments":
          MessageLookupByLibrary.simpleMessage("Sortuj komentarze: \$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage(
          "wysłał(a) prezent do Twojego posta"),
      "ui_notif_gift_comment": MessageLookupByLibrary.simpleMessage(
          "wysłał(a) \$gift do Twojego komentarza"),
      "ui_notif_gift_named": MessageLookupByLibrary.simpleMessage(
          "wysłał(a) \$gift do Twojego posta"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("Wyślij prezent"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("Edytuj post"),
      "ui_edit_post_left": MessageLookupByLibrary.simpleMessage(
          "Możesz go edytować jeszcze przez \$n min"),
      "ui_save": MessageLookupByLibrary.simpleMessage("Zapisz"),
      "ui_feed_tag_detail": MessageLookupByLibrary.simpleMessage(
          "Pod #\$tab nic jeszcze nie opublikowano."),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("Wybierz prezent"),
      "ui_gift_not_enough":
          MessageLookupByLibrary.simpleMessage("Za mało monet"),
      "ui_gift_test_notice": MessageLookupByLibrary.simpleMessage(
          "Monety testowe: nie można ich kupić i nie mają wartości pieniężnej."),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("Doładowanie: \$date."),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 moneta"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("Monety: \$count"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("Masz \$coins"),
      "ui_gift_send_named":
          MessageLookupByLibrary.simpleMessage("Wyślij \$gift"),
      "ui_gift_sent_named":
          MessageLookupByLibrary.simpleMessage("Wysłano \$gift"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("Spróbuj ponownie"),
      "ui_edit_post_detail":
          MessageLookupByLibrary.simpleMessage("Przez 15 minut od publikacji"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("Edytowano"),
      "ui_could_not_load_saved_comments": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać zapisanych komentarzy"),
      "ui_no_saved_comments":
          MessageLookupByLibrary.simpleMessage("Brak zapisanych komentarzy"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "Stuknij ikonę archiwum pod komentarzem, aby zachować go tutaj. Tylko Ty widzisz to, co zapisujesz."),
      "ui_replying_to":
          MessageLookupByLibrary.simpleMessage("Odpowiedź do \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("Kopiuj"),
      "ui_search": MessageLookupByLibrary.simpleMessage("Szukaj"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("Zaznacz wszystko"),
      "ui_gifts_count":
          MessageLookupByLibrary.simpleMessage("Prezenty: \$count"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 prezent"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać kolejnych postów."),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("Przypomnienia"),
      "ui_reminders_detail": MessageLookupByLibrary.simpleMessage(
          "Co nowego po twojej nieobecności i kiedy wrócą monety. Nigdy więcej niż jedno dziennie."),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("Prezenty"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("od 1 osoby"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("od \$count osób"),
      "ui_top_gifter":
          MessageLookupByLibrary.simpleMessage("Największy darczyńca"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage(
          "Nie udało się wczytać, kto wysłał prezenty."),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("Co nowego"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("Rozumiem"),
      "ui_check_in_thanks": MessageLookupByLibrary.simpleMessage(
          "Dziękujemy. Czytamy każdą odpowiedź."),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("Jak ci się podoba Kyron?"),
      "ui_check_in_detail": MessageLookupByLibrary.simpleMessage(
          "Dzień \$day twojego testu. Wystarczy jedno stuknięcie."),
      "ui_check_in_hint": MessageLookupByLibrary.simpleMessage(
          "Coś, co powinniśmy poprawić lub dodać? (opcjonalnie)"),
      "ui_send": MessageLookupByLibrary.simpleMessage("Wyślij"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("Nie teraz"),
      "ui_back_again_to_leave": MessageLookupByLibrary.simpleMessage(
          "Naciśnij ponownie Wstecz, aby opuścić Kyron"),
    };

final messageLookup = MessageLookup();
