class OnboardingModel {
  // STEP 1  –  mandatory
  String displayName = '';
  String bio          = '';
  String? localAvatarPath;      // gallery file
  String? localCoverPath;       // gallery file
  bool    useAIAvatar   = false;
  bool    useAICover    = false;

  // STEP 2  –  optional
  List<String> interests = [];

  // STEP 3  –  optional
  List<String> followedAccounts = [];

  bool get step1Complete => displayName.trim().isNotEmpty;
}
