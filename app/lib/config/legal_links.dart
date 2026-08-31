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

  /// Arguments for [Routes.webview].
  static const termsArguments = {'url': terms, 'title': termsTitle};
  static const privacyArguments = {'url': privacy, 'title': privacyTitle};
}
