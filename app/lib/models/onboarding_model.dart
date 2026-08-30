class OnboardingModel {
  // STEP 1  –  mandatory
  String displayName = '';
  String bio = '';
  String? localAvatarPath; // gallery file
  String? localCoverPath; // gallery file

  /// A default cover picked with "Randomise": already in storage, so it is a
  /// URL rather than a file. Mutually exclusive with [localCoverPath] -- the
  /// setters below keep whichever the user chose last and clear the other.
  String? remoteCoverUrl;

  void chooseLocalCover(String path) {
    localCoverPath = path;
    remoteCoverUrl = null;
  }

  void chooseRemoteCover(String url) {
    remoteCoverUrl = url;
    localCoverPath = null;
  }

  bool get hasCover => localCoverPath != null || remoteCoverUrl != null;
  bool useAIAvatar = false;
  bool useAICover = false;

  // STEP 2  –  optional
  List<String> interests = [];

  // STEP 3  –  optional
  List<String> followedAccounts = [];

  bool get step1Complete => displayName.trim().isNotEmpty;
}
