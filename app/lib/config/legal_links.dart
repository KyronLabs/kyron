// lib/config/legal_links.dart

/// Where the published terms and privacy policy live.
///
/// The same two URLs were written out by hand on the welcome, sign-in and
/// sign-up screens. Moving the documents meant finding all six copies, and the
/// drawer's own "Terms" and "Privacy" links pointed at routes that did not
/// exist at all.
class LegalLinks {
  const LegalLinks._();

  static const terms =
      'https://kyron-terms-and-privacy.onrender.com/terms.html';
  static const privacy =
      'https://kyron-terms-and-privacy.onrender.com/privacy.html';

  static const termsTitle = 'Terms of Service';
  static const privacyTitle = 'Privacy Policy';
}

/// Where to write, outside the app.
///
/// The address the published terms and privacy policy name, so the app and
/// the policy never disagree. There used to be a Help Centre at help.kyron.so
/// and a support@kyron.so here: Kyron does not own kyron.so, so the one never
/// loaded and mail to the other went to whoever registers the name. Then
/// abuse@ and privacy@spidroid.com, which the published pages no longer name.
///
/// One inbox, read by the person who runs Kyron. The subject line is what
/// sorts it -- the same subjects the published pages ask for.
class SupportLinks {
  const SupportLinks._();

  static const email = 'spidroidtechnologiesinc@gmail.com';

  /// Harassment, threats, illegal content: what cannot wait for a report.
  static const abuse = email;
  static const abuseSubject = 'Abuse';

  /// Questions about what is kept about somebody, and requests to see it.
  static const privacy = email;
  static const privacySubject = 'Privacy';
}
