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
/// The addresses the published privacy policy names, so the app and the
/// policy never disagree. There used to be a Help Centre at help.kyron.so and
/// a support@kyron.so here: Kyron does not own kyron.so, so the one never
/// loaded and mail to the other went to whoever registers the name.
/// Everything else goes through the app, to the team's private inbox.
class SupportLinks {
  const SupportLinks._();

  /// Harassment, threats, illegal content: what cannot wait for a report.
  static const abuse = 'abuse@spidroid.com';

  /// Questions about what is kept about somebody, and requests to see it.
  static const privacy = 'privacy@spidroid.com';
}
