import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';
  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
  'about': MessageLookupByLibrary.simpleMessage('About'),
  'addAnAnswer': MessageLookupByLibrary.simpleMessage('Add an answer'),
  'agreeAndContinue': MessageLookupByLibrary.simpleMessage(
    'Agree and continue',
  ),
  'answerNumber': (Object i) => 'Answer $i',
  'arLens': MessageLookupByLibrary.simpleMessage('AR Lens'),
  'attachSystemLog': MessageLookupByLibrary.simpleMessage(
    'Attach the system log',
  ),
  'aWordPhraseOrTag': MessageLookupByLibrary.simpleMessage(
    'A word, phrase or #tag',
  ),
  'block': MessageLookupByLibrary.simpleMessage('Block'),
  'blockAuthor': (Object author) => 'Block $author?',
  'buildDetailsCopied': MessageLookupByLibrary.simpleMessage(
    'Build details copied',
  ),
  'bullet': MessageLookupByLibrary.simpleMessage('•'),
  'cancel': MessageLookupByLibrary.simpleMessage('Cancel'),
  'change': MessageLookupByLibrary.simpleMessage('Change'),
  'changeEmail': MessageLookupByLibrary.simpleMessage('Change Email'),
  'checkKyronReachable': MessageLookupByLibrary.simpleMessage(
    'Check whether Kyron is reachable',
  ),
  'checkEmailConfirm': MessageLookupByLibrary.simpleMessage(
    'Check your email to confirm your account.',
  ),
  'closeCommunity': (Object communityName) => 'Close $communityName?',
  'closeIt': MessageLookupByLibrary.simpleMessage('Close it'),
  'closeThisCommunity': MessageLookupByLibrary.simpleMessage(
    'Close this community',
  ),
  'confirmPassword': MessageLookupByLibrary.simpleMessage('Confirm password'),
  'contactSupport': MessageLookupByLibrary.simpleMessage('Contact support'),
  'continueWithEmail': MessageLookupByLibrary.simpleMessage(
    'Continue with email',
  ),
  'copy': MessageLookupByLibrary.simpleMessage('Copy'),
  'copyReportInstead': MessageLookupByLibrary.simpleMessage(
    'Copy report instead',
  ),
  'couldNotOpenGoogleSignIn': (Object error) =>
      'Could not open Google sign-in. $error',
  'couldNotSignOut': (Object error) => 'Could not sign out: $error',
  'couldNotTakePicture': MessageLookupByLibrary.simpleMessage(
    'Could not take that picture.',
  ),
  'create': MessageLookupByLibrary.simpleMessage('Create'),
  'createAccount': MessageLookupByLibrary.simpleMessage('Create account'),
  'createYourAccount': MessageLookupByLibrary.simpleMessage(
    'Create your account',
  ),
  'createYourProfile': MessageLookupByLibrary.simpleMessage(
    'Create your profile',
  ),
  'delete': MessageLookupByLibrary.simpleMessage('Delete'),
  'deleteThisComment': MessageLookupByLibrary.simpleMessage(
    'Delete this comment?',
  ),
  'deleteThisPost': MessageLookupByLibrary.simpleMessage('Delete this post?'),
  'describeAttachment': MessageLookupByLibrary.simpleMessage(
    'Describe this attachment',
  ),
  'description': MessageLookupByLibrary.simpleMessage('Description'),
  'didCopied': MessageLookupByLibrary.simpleMessage('DID copied to clipboard'),
  'done': MessageLookupByLibrary.simpleMessage('Done'),
  'drafts': MessageLookupByLibrary.simpleMessage('Drafts'),
  'editProfile': MessageLookupByLibrary.simpleMessage('Edit profile'),
  'emailNotifications': MessageLookupByLibrary.simpleMessage(
    'Email notifications',
  ),
  'faceTrackingUnavailable': MessageLookupByLibrary.simpleMessage(
    'Face tracking is not available on this device.',
  ),
  'followers': MessageLookupByLibrary.simpleMessage('Followers'),
  'following': MessageLookupByLibrary.simpleMessage('Following'),
  'forgotPassword': MessageLookupByLibrary.simpleMessage('Forgot password?'),
  'guidesAndAnswers': MessageLookupByLibrary.simpleMessage(
    'Guides and answers to common questions',
  ),
  'handle': MessageLookupByLibrary.simpleMessage('handle'),
  'helpCentre': MessageLookupByLibrary.simpleMessage('Help Centre'),
  'helpAndSupport': MessageLookupByLibrary.simpleMessage('Help & Support'),
  'inOneLine': MessageLookupByLibrary.simpleMessage('In one line'),
  'itDisappearsForBoth': MessageLookupByLibrary.simpleMessage(
    'It disappears for both of you.',
  ),
  'itWillBeRemoved': MessageLookupByLibrary.simpleMessage(
    'It will be removed from the thread.',
  ),
  'keepEditing': MessageLookupByLibrary.simpleMessage('Keep editing'),
  'kyron': MessageLookupByLibrary.simpleMessage('Kyron'),
  'lagosDesign': MessageLookupByLibrary.simpleMessage('Lagos Design'),
  'leave': MessageLookupByLibrary.simpleMessage('Leave'),
  'leaveCommunity': (Object communityName) => 'Leave $communityName?',
  'letBackIn': MessageLookupByLibrary.simpleMessage('Let back in'),
  'loadMore': MessageLookupByLibrary.simpleMessage('Load more'),
  'logCleared': MessageLookupByLibrary.simpleMessage('Log cleared'),
  'logCopied': MessageLookupByLibrary.simpleMessage('Log copied'),
  'logIn': MessageLookupByLibrary.simpleMessage('Log in'),
  'logOut': MessageLookupByLibrary.simpleMessage('Log Out'),
  'logOutQuestion': MessageLookupByLibrary.simpleMessage('Log Out?'),
  'message': MessageLookupByLibrary.simpleMessage('Message'),
  'mute': MessageLookupByLibrary.simpleMessage('Mute'),
  'mutedAndBlocked': MessageLookupByLibrary.simpleMessage('Muted and blocked'),
  'mutedWordsAndTags': MessageLookupByLibrary.simpleMessage(
    'Muted words and tags',
  ),
  'name': MessageLookupByLibrary.simpleMessage('Name'),
  'nameScreen': MessageLookupByLibrary.simpleMessage('<name> Screen'),
  'newEmailAddress': MessageLookupByLibrary.simpleMessage('New email address'),
  'newPassword': MessageLookupByLibrary.simpleMessage('New password'),
  'newPost': MessageLookupByLibrary.simpleMessage('New post'),
  'nothingToCopy': MessageLookupByLibrary.simpleMessage('Nothing to copy'),
  'notifications': MessageLookupByLibrary.simpleMessage('Notifications'),
  'notNow': MessageLookupByLibrary.simpleMessage('Not now'),
  'notSentTapRetry': MessageLookupByLibrary.simpleMessage(
    'Not sent. Tap to try again',
  ),
  'openInBrowser': MessageLookupByLibrary.simpleMessage('Open in browser'),
  'pageNotFound': MessageLookupByLibrary.simpleMessage('Page not found'),
  'pickYourInterests': MessageLookupByLibrary.simpleMessage(
    'Pick your interests',
  ),
  'post': MessageLookupByLibrary.simpleMessage('Post'),
  'postAnalytics': MessageLookupByLibrary.simpleMessage('Post analytics'),
  'postInCommunity': (Object communityName) => 'Post in $communityName',
  'postTextCopied': MessageLookupByLibrary.simpleMessage('Post text copied'),
  'profileUpdated': MessageLookupByLibrary.simpleMessage('Profile updated'),
  'pushNotifications': MessageLookupByLibrary.simpleMessage(
    'Push notifications',
  ),
  'quote': MessageLookupByLibrary.simpleMessage('Quote'),
  'quotePost': MessageLookupByLibrary.simpleMessage('Quote post'),
  'reachAPerson': MessageLookupByLibrary.simpleMessage('Reach a person'),
  'remove': MessageLookupByLibrary.simpleMessage('Remove'),
  'removeMember': (Object memberName) => 'Remove $memberName?',
  'removeConversation': MessageLookupByLibrary.simpleMessage(
    'Remove this conversation?',
  ),
  'removeMessage': MessageLookupByLibrary.simpleMessage('Remove this message?'),
  'repliesFollowsMentions': MessageLookupByLibrary.simpleMessage(
    'Replies, follows and mentions',
  ),
  'reply': MessageLookupByLibrary.simpleMessage('Reply'),
  'report': MessageLookupByLibrary.simpleMessage('Report'),
  'reportCopied': MessageLookupByLibrary.simpleMessage(
    'Report copied. Paste it into an email to support.',
  ),
  'reportSent': MessageLookupByLibrary.simpleMessage('Report sent'),
  'repost': MessageLookupByLibrary.simpleMessage('Repost'),
  'reset': MessageLookupByLibrary.simpleMessage('Reset'),
  'resetPassword': MessageLookupByLibrary.simpleMessage('Reset your password'),
  'retry': MessageLookupByLibrary.simpleMessage('Retry'),
  'save': MessageLookupByLibrary.simpleMessage('Save'),
  'saveDraft': MessageLookupByLibrary.simpleMessage('Save draft'),
  'saySomething': (Object communityName) => 'Say something to $communityName',
  'searchByNameOrHandle': MessageLookupByLibrary.simpleMessage(
    'Search by name or handle',
  ),
  'searchCommunities': MessageLookupByLibrary.simpleMessage(
    'Search communities',
  ),
  'searchGIFs': MessageLookupByLibrary.simpleMessage('Search GIFs'),
  'searchLanguages': MessageLookupByLibrary.simpleMessage('Search languages'),
  'searchTrendingTags': MessageLookupByLibrary.simpleMessage(
    'Search trending tags',
  ),
  'securityAlerts': MessageLookupByLibrary.simpleMessage(
    'Security alerts and account changes',
  ),
  'sendConfirmation': MessageLookupByLibrary.simpleMessage('Send confirmation'),
  'sendErrorReport': MessageLookupByLibrary.simpleMessage('Send error report'),
  'sendFeedback': MessageLookupByLibrary.simpleMessage('Send feedback'),
  'sendReport': MessageLookupByLibrary.simpleMessage('Send report'),
  'sendToSupport': MessageLookupByLibrary.simpleMessage('Send to support'),
  'serviceStatus': MessageLookupByLibrary.simpleMessage('Service status'),
  'shareAppLog': MessageLookupByLibrary.simpleMessage(
    'Share the app log with support',
  ),
  'signedInAs': MessageLookupByLibrary.simpleMessage('Signed in as'),
  'signInToKyron': MessageLookupByLibrary.simpleMessage('Sign in to Kyron'),
  'signupFailed': (Object error) => 'Signup failed: $error',
  'stay': MessageLookupByLibrary.simpleMessage('Stay'),
  'systemLog': MessageLookupByLibrary.simpleMessage('System log'),
  'tellMissingBroken': MessageLookupByLibrary.simpleMessage(
    'Tell us what is missing or broken',
  ),
  'theComposerNoPostButton': MessageLookupByLibrary.simpleMessage(
    'The composer has no Post button',
  ),
  'translate': MessageLookupByLibrary.simpleMessage('Translate'),
  'tryAgain': MessageLookupByLibrary.simpleMessage('Try again'),
  'undoRepost': MessageLookupByLibrary.simpleMessage('Undo repost'),
  'updatePassword': MessageLookupByLibrary.simpleMessage('Update password'),
  'useDifferentAddress': MessageLookupByLibrary.simpleMessage(
    'Use a different address',
  ),
  'whatHappened': MessageLookupByLibrary.simpleMessage('What happened'),
  'whatHappenedAndLookAt': MessageLookupByLibrary.simpleMessage(
    'What happened, and what should we look at?',
  ),
  'whatInPicture': MessageLookupByLibrary.simpleMessage(
    'What is in this picture?',
  ),
  'whatIsItFor': MessageLookupByLibrary.simpleMessage(
    'What is it for? (optional)',
  ),
  'whatYouDid': MessageLookupByLibrary.simpleMessage(
    'What you did, what you expected, what happened',
  ),
  'whatYouWereDoing': MessageLookupByLibrary.simpleMessage(
    'What you were doing when it happened.',
  ),
  'normalised': MessageLookupByLibrary.simpleMessage('#\\\$normalised'),
  'postItSayItShowIt': MessageLookupByLibrary.simpleMessage(
    'Post it, say it, show it.',
  ),
  'textVoiceVideoPeopleRooms': MessageLookupByLibrary.simpleMessage(
    'Text, voice and video, the people who make them, and the rooms they talk in.',
  ),
  'alreadyOnKyron': MessageLookupByLibrary.simpleMessage('Already on Kyron?'),
  'byContinuingAgreeTermsPrivacy': MessageLookupByLibrary.simpleMessage(
    'By continuing you agree to our Terms and Privacy Policy',
  ),
  'byContinuingAgreeTerms': MessageLookupByLibrary.simpleMessage(
    'By continuing you agree to our',
  ),
  'googleSignInNeedsPhoneApp': MessageLookupByLibrary.simpleMessage(
    'Google sign-in needs the phone app',
  ),
  'googleSignInDesktopExplanation': (Object platform) =>
      'Google hands the finished sign-in back to Kyron over a link only Android and iOS answer, so on ${platform} the browser would have nowhere to return it to.\n\nIf you already have a Kyron account through Google, use Continue with email with that same address and tap Forgot password — it will mail you a link to set one.'
          .replaceAll(r'${platform}', platform.toString()),
  'loginFailed': MessageLookupByLibrary.simpleMessage(
    'Login failed. Please check your credentials.',
  ),
  'email': MessageLookupByLibrary.simpleMessage('Email'),
  'password': MessageLookupByLibrary.simpleMessage('Password'),
  'login': MessageLookupByLibrary.simpleMessage('Login'),
  'or': MessageLookupByLibrary.simpleMessage('or'),
  'username': MessageLookupByLibrary.simpleMessage('Username'),
  'usernameRule': MessageLookupByLibrary.simpleMessage(
    'Username must be lowercase (a-z, 0-9, _)',
  ),
  'passwordTooShort': MessageLookupByLibrary.simpleMessage(
    'Password too short',
  ),
  'continueAction': MessageLookupByLibrary.simpleMessage('Continue'),
  'bySigningUpAgreeTerms': MessageLookupByLibrary.simpleMessage(
    'By signing up you agree to our',
  ),
  'terms': MessageLookupByLibrary.simpleMessage('Terms'),
  'and': MessageLookupByLibrary.simpleMessage('and'),
  'privacyPolicy': MessageLookupByLibrary.simpleMessage('Privacy Policy'),
  'googleSignIn': MessageLookupByLibrary.simpleMessage('Sign in with Google'),
  'googleSignUp': MessageLookupByLibrary.simpleMessage('Sign up with Google'),
  'googleContinue': MessageLookupByLibrary.simpleMessage(
    'Continue with Google',
  ),
  'literalwhetherKyronIsReachableRightNow':
      MessageLookupByLibrary.simpleMessage(
        'Whether Kyron is reachable right now',
      ),
  'literalwhatThisAppHasBeenDoing': MessageLookupByLibrary.simpleMessage(
    'What this app has been doing',
  ),
  'literalshareTheLogWithSupport': MessageLookupByLibrary.simpleMessage(
    'Share the log with support',
  ),
  'literalclearCache': MessageLookupByLibrary.simpleMessage('Clear cache'),
  'literalappVersion': MessageLookupByLibrary.simpleMessage('App version'),
  'literalreading': MessageLookupByLibrary.simpleMessage('Reading…'),
  'literalcheckAgain': MessageLookupByLibrary.simpleMessage('Check again'),
  'literalkyronDidNotAnswer': MessageLookupByLibrary.simpleMessage(
    'Kyron did not answer',
  ),
  'literalnothingLoggedYet': MessageLookupByLibrary.simpleMessage(
    'Nothing logged yet',
  ),
  'literalswitchCamera': MessageLookupByLibrary.simpleMessage('Switch camera'),
  'literaltheCameraIsClosed': MessageLookupByLibrary.simpleMessage(
    'The camera is closed',
  ),
  'literaltakeAPicture': MessageLookupByLibrary.simpleMessage('Take a picture'),
  'literallensNameFaceLens': (Object lens) => '${lens.name}, face lens',
  'literalcouldNotPostThatReply': MessageLookupByLibrary.simpleMessage(
    'Could not post that reply.',
  ),
  'literalcouldNotLoadThisReply': MessageLookupByLibrary.simpleMessage(
    'Could not load this reply',
  ),
  'literalthisReplyIsGone': MessageLookupByLibrary.simpleMessage(
    'This reply is gone',
  ),
  'literaladdAPhoto': MessageLookupByLibrary.simpleMessage('Add a photo'),
  'literaladdAClip': MessageLookupByLibrary.simpleMessage('Add a clip'),
  'literalstartACommunity': MessageLookupByLibrary.simpleMessage(
    'Start a community',
  ),
  'literalcouldNotLoadYourCommunities': MessageLookupByLibrary.simpleMessage(
    'Could not load your communities',
  ),
  'literalyouAreNotInAnyCommunities': MessageLookupByLibrary.simpleMessage(
    'You are not in any communities',
  ),
  'literalcouldNotLoadCommunities': MessageLookupByLibrary.simpleMessage(
    'Could not load communities',
  ),
  'literalpostInWidgetCommunityName': (Object widget) =>
      'Post in ${widget.community.name}',
  'literalsaySomethingToWidgetCommunityName': (Object widget) =>
      'Say something to ${widget.community.name}',
  'literaltagSomeone': MessageLookupByLibrary.simpleMessage('Tag someone'),
  'literalcloseWidgetCommunityName': (Object widget) =>
      'Close ${widget.community.name}?',
  'literalonlyTheOwnerCanChangeThis': MessageLookupByLibrary.simpleMessage(
    'Only the owner can change this',
  ),
  'literaltapTheBannerOrThePictureToChangeIt':
      MessageLookupByLibrary.simpleMessage(
        'Tap the banner or the picture to change it',
      ),
  'literalremoveMemberDisplayname': (Object member) =>
      'Remove ${member.displayName}?',
  'literalcouldNotLoadTheMembers': MessageLookupByLibrary.simpleMessage(
    'Could not load the members',
  ),
  'literalnobodyHereYet': MessageLookupByLibrary.simpleMessage(
    'Nobody here yet',
  ),
  'literalmakeAModerator': MessageLookupByLibrary.simpleMessage(
    'Make a moderator',
  ),
  'literalremoveAsModerator': MessageLookupByLibrary.simpleMessage(
    'Remove as moderator',
  ),
  'literalremoveFromCommunity': MessageLookupByLibrary.simpleMessage(
    'Remove from community',
  ),
  'literalcouldNotLoadThisList': MessageLookupByLibrary.simpleMessage(
    'Could not load this list',
  ),
  'literalnobodyHasBeenRemoved': MessageLookupByLibrary.simpleMessage(
    'Nobody has been removed',
  ),
  'literalpostInCommunityName': (Object community) =>
      'Post in ${community.name}',
  'literalcouldNotOpenThisCommunity': MessageLookupByLibrary.simpleMessage(
    'Could not open this community',
  ),
  'literalthisCommunity': MessageLookupByLibrary.simpleMessage(
    'This community',
  ),
  'literalshareThisCommunity': MessageLookupByLibrary.simpleMessage(
    'Share this community',
  ),
  'literalcopyLink': MessageLookupByLibrary.simpleMessage('Copy link'),
  'literallinkCopied': MessageLookupByLibrary.simpleMessage('Link copied'),
  'literalleaveCommunityName': (Object community) => 'Leave ${community.name}?',
  'literalyouHaveLeftCommunityName': (Object community) =>
      'You have left ${community.name}',
  'literaladdAVideo': MessageLookupByLibrary.simpleMessage('Add a video'),
  'literaladdAGif': MessageLookupByLibrary.simpleMessage('Add a GIF'),
  'literalrecordAVoicePost': MessageLookupByLibrary.simpleMessage(
    'Record a voice post',
  ),
  'literalremoveThePoll': MessageLookupByLibrary.simpleMessage(
    'Remove the poll',
  ),
  'literaladdAPoll': MessageLookupByLibrary.simpleMessage('Add a poll'),
  'literaladdAHashtag': MessageLookupByLibrary.simpleMessage('Add a hashtag'),
  'literaldraftSaved': MessageLookupByLibrary.simpleMessage('Draft saved'),
  'literalnoDrafts': MessageLookupByLibrary.simpleMessage('No drafts'),
  'literalcouldNotLoadTrending': MessageLookupByLibrary.simpleMessage(
    'Could not load trending',
  ),
  'literalnothingIsTrendingYet': MessageLookupByLibrary.simpleMessage(
    'Nothing is trending yet',
  ),
  'literalcouldNotLoadTopics': MessageLookupByLibrary.simpleMessage(
    'Could not load topics',
  ),
  'literalnoTopicsYet': MessageLookupByLibrary.simpleMessage('No topics yet'),
  'literalcouldNotLoadSuggestions': MessageLookupByLibrary.simpleMessage(
    'Could not load suggestions',
  ),
  'literalnobodyLeftToSuggest': MessageLookupByLibrary.simpleMessage(
    'Nobody left to suggest',
  ),
  'literalyouExampleCom': MessageLookupByLibrary.simpleMessage(
    'you@example.com',
  ),
  'literalsendTheLink': MessageLookupByLibrary.simpleMessage('Send the link'),
  'literalopenTheMailFromKyron': MessageLookupByLibrary.simpleMessage(
    'Open the mail from Kyron',
  ),
  'literaltapTheLinkInsideIt': MessageLookupByLibrary.simpleMessage(
    'Tap the link inside it',
  ),
  'literalsetAPasswordAndCarryOn': MessageLookupByLibrary.simpleMessage(
    'Set a password and carry on',
  ),
  'literalsendAgainInCooldownS': (Object _cooldown) =>
      'Send again in ${_cooldown}s',
  'literalsendAgain': MessageLookupByLibrary.simpleMessage('Send again'),
  'literalnormalised': (Object normalised) => '#$normalised',
  'literalcouldNotLoadYourMessages': MessageLookupByLibrary.simpleMessage(
    'Could not load your messages',
  ),
  'literalnothingUnread': MessageLookupByLibrary.simpleMessage(
    'Nothing unread',
  ),
  'literalnoMessagesYet': MessageLookupByLibrary.simpleMessage(
    'No messages yet',
  ),
  'literalnothingMuted': MessageLookupByLibrary.simpleMessage('Nothing muted'),
  'literalnoLikesYet': MessageLookupByLibrary.simpleMessage('No likes yet'),
  'literalnoRepliesYet': MessageLookupByLibrary.simpleMessage('No replies yet'),
  'literalnoNewFollowers': MessageLookupByLibrary.simpleMessage(
    'No new followers',
  ),
  'literalnoRepostsYet': MessageLookupByLibrary.simpleMessage('No reposts yet'),
  'literalyouAreAllCaughtUp': MessageLookupByLibrary.simpleMessage(
    'You are all caught up',
  ),
  'literalcouldNotLoadNotifications': MessageLookupByLibrary.simpleMessage(
    'Could not load notifications',
  ),
  'literalcoverPhoto': MessageLookupByLibrary.simpleMessage('Cover photo'),
  'literalchooseFromGallery': MessageLookupByLibrary.simpleMessage(
    'Choose from gallery',
  ),
  'literaluseOneOfOurs': MessageLookupByLibrary.simpleMessage(
    'Use one of ours',
  ),
  'literaltapToAddAPhotoAndACover': MessageLookupByLibrary.simpleMessage(
    'Tap to add a photo and a cover',
  ),
  'literalnoInterestsYet': MessageLookupByLibrary.simpleMessage(
    'No interests yet',
  ),
  'literaldiscoverPeople': MessageLookupByLibrary.simpleMessage(
    'Discover people',
  ),
  'literalcancelReply': MessageLookupByLibrary.simpleMessage('Cancel reply'),
  'literalcouldNotLoadThisPost': MessageLookupByLibrary.simpleMessage(
    'Could not load this post',
  ),
  'literalshareThisProfile': MessageLookupByLibrary.simpleMessage(
    'Share this profile',
  ),
  'literalcouldNotLoadThesePosts': MessageLookupByLibrary.simpleMessage(
    'Could not load these posts',
  ),
  'literalyouHaveNotPostedYet': MessageLookupByLibrary.simpleMessage(
    'You have not posted yet',
  ),
  'literalnoPostsYet': MessageLookupByLibrary.simpleMessage('No posts yet'),
  'literalnothingToLookAtYet': MessageLookupByLibrary.simpleMessage(
    'Nothing to look at yet',
  ),
  'literalkeepTyping': MessageLookupByLibrary.simpleMessage('Keep typing'),
  'literalsearchFailed': MessageLookupByLibrary.simpleMessage('Search failed'),
  'literalnothingMatched': MessageLookupByLibrary.simpleMessage(
    'Nothing matched',
  ),
  'literalcouldNotSignOutDescribeapierrorE': (Object describeApiError) =>
      'Could not sign out: ${describeApiError(e)}',
  'literalnoDidYet': MessageLookupByLibrary.simpleMessage('No DID yet'),
  'literalpasswordLogin': MessageLookupByLibrary.simpleMessage(
    'Password & Login',
  ),
  'literalmutedAndBlockedAccounts': MessageLookupByLibrary.simpleMessage(
    'Muted and blocked accounts',
  ),
  'literalfontSize': MessageLookupByLibrary.simpleMessage('Font Size'),
  'literalpushNotifications': MessageLookupByLibrary.simpleMessage(
    'Push Notifications',
  ),
  'literaldataSaver': MessageLookupByLibrary.simpleMessage('Data Saver'),
  'literalcontactSupport': MessageLookupByLibrary.simpleMessage(
    'Contact Support',
  ),
  'literalsendFeedback': MessageLookupByLibrary.simpleMessage('Send Feedback'),
  'literalappLanguage': MessageLookupByLibrary.simpleMessage('App language'),
  'literalprimaryLanguage': MessageLookupByLibrary.simpleMessage(
    'Primary language',
  ),
  'literalcontentLanguages': MessageLookupByLibrary.simpleMessage(
    'Content languages',
  ),
  'literalremoveLanguageEnglishname': (Object language) =>
      'Remove ${language.englishName}',
  'literalsentItIsReportFiledNumber': (Object filed) =>
      'Sent. It is report #${filed.number}.',
  'literalfeedbackCannotBeSentRightNow': MessageLookupByLibrary.simpleMessage(
    'Feedback cannot be sent right now',
  ),
  'literalwhatYouDidWhatYouExpectedWhatHappened':
      MessageLookupByLibrary.simpleMessage(
        'What you did, what you expected, what happened ',
      ),
  'literalverificationFailedDescribeapierrorE': (Object describeApiError) =>
      'Verification failed: ${describeApiError(e)}',
  'literalverificationCodeResent': MessageLookupByLibrary.simpleMessage(
    'Verification code resent.',
  ),
  'literalverifyEmail': MessageLookupByLibrary.simpleMessage('Verify Email'),
  'literalresendCode': MessageLookupByLibrary.simpleMessage('Resend code'),
  'literalremoveThisConversation': MessageLookupByLibrary.simpleMessage(
    'Remove this conversation',
  ),
  'literalmutedYouWillNotBeNotified': MessageLookupByLibrary.simpleMessage(
    'Muted. You will not be notified.',
  ),
  'literalblockThisAccount': MessageLookupByLibrary.simpleMessage(
    'Block this account?',
  ),
  'literalyouAreSignedOut': MessageLookupByLibrary.simpleMessage(
    'You are signed out.',
  ),
  'literalcouldNotLoadThisConversation': MessageLookupByLibrary.simpleMessage(
    'Could not load this conversation',
  ),
  'literalsaySomething': MessageLookupByLibrary.simpleMessage('Say something'),
  'literalcopyText': MessageLookupByLibrary.simpleMessage('Copy text'),
  'literaldoNotReply': MessageLookupByLibrary.simpleMessage('Do not reply'),
  'literalremoveFromSaved': MessageLookupByLibrary.simpleMessage(
    'Remove from saved',
  ),
  'literalturnSoundOn': MessageLookupByLibrary.simpleMessage('Turn sound on'),
  'literalturnSoundOff': MessageLookupByLibrary.simpleMessage('Turn sound off'),
  'literalthatLinkIsNotOneThisCanOpen': MessageLookupByLibrary.simpleMessage(
    'That link is not one this can open.',
  ),
  'literalnoBrowserOnThisDeviceTookThatLink':
      MessageLookupByLibrary.simpleMessage(
        'No browser on this device took that link.',
      ),
  'literalopenReply': MessageLookupByLibrary.simpleMessage('Open reply'),
  'literallabelCount': (Object label, Object count) => '$label, $count',
  'literalindex1': (Object index) => '${index + 1}',
  'literalfirstyearIndex': (Object _firstYear) => '${_firstYear + index}',
  'literalgifsAreNotSetUp': MessageLookupByLibrary.simpleMessage(
    'GIFs are not set up',
  ),
  'literalcouldNotLoadGifs': MessageLookupByLibrary.simpleMessage(
    'Could not load GIFs',
  ),
  'literalnothingFound': MessageLookupByLibrary.simpleMessage('Nothing found'),
  'literalthatGifCouldNotBeDownloaded': MessageLookupByLibrary.simpleMessage(
    'That GIF could not be downloaded.',
  ),
  'literaladdAnInterest': MessageLookupByLibrary.simpleMessage(
    'Add an interest',
  ),
  'literalcouldNotLoadTrendingTags': MessageLookupByLibrary.simpleMessage(
    'Could not load trending tags',
  ),
  'literalnoTrendingTagMatchesThat': MessageLookupByLibrary.simpleMessage(
    'No trending tag matches that',
  ),
  'literalyouAlreadyFollowEveryTrendingTag':
      MessageLookupByLibrary.simpleMessage(
        'You already follow every trending tag',
      ),
  'literalremoveLabel': (Object label) => 'Remove $label',
  'literaladdLabelAsATab': (Object label) => 'Add $label as a tab',
  'literalcouldNotSearch': MessageLookupByLibrary.simpleMessage(
    'Could not search',
  ),
  'literalwhoDoYouWantToTag': MessageLookupByLibrary.simpleMessage(
    'Who do you want to tag?',
  ),
  'literalnobodyFound': MessageLookupByLibrary.simpleMessage('Nobody found'),
  'literalshowPassword': MessageLookupByLibrary.simpleMessage('Show password'),
  'literalhidePassword': MessageLookupByLibrary.simpleMessage('Hide password'),
  'literaltranslatePost': MessageLookupByLibrary.simpleMessage(
    'Translate post',
  ),
  'literalcopyPostText': MessageLookupByLibrary.simpleMessage('Copy post text'),
  'literalcopyLinkToPost': MessageLookupByLibrary.simpleMessage(
    'Copy link to post',
  ),
  'literalshowMorePostsLikeThis': MessageLookupByLibrary.simpleMessage(
    'Show more posts like this',
  ),
  'literalnotInterestedInThis': MessageLookupByLibrary.simpleMessage(
    'Not interested in this',
  ),
  'literalhidesItAndTellsUsToShowFewerLikeIt':
      MessageLookupByLibrary.simpleMessage(
        'Hides it, and tells us to show fewer like it',
      ),
  'literalhideThisPost': MessageLookupByLibrary.simpleMessage('Hide this post'),
  'literalmuteThisThread': MessageLookupByLibrary.simpleMessage(
    'Mute this thread',
  ),
  'literalstopSeeingThisPostAndRepliesToIt':
      MessageLookupByLibrary.simpleMessage(
        'Stop seeing this post and replies to it',
      ),
  'literalmuteWordsOrTags': MessageLookupByLibrary.simpleMessage(
    'Mute words or tags',
  ),
  'literalviewersLikesSavesAndComments': MessageLookupByLibrary.simpleMessage(
    'Viewers, likes, saves and comments',
  ),
  'literalwhoCanReply': MessageLookupByLibrary.simpleMessage('Who can reply'),
  'literaldeletePost': MessageLookupByLibrary.simpleMessage('Delete post'),
  'literalmuteAuthor': (Object author) => 'Mute $author',
  'literalblockAuthor': (Object author) => 'Block $author',
  'literalreportPost': MessageLookupByLibrary.simpleMessage('Report post'),
  'literalreportAuthor': (Object author) => 'Report $author',
  'literalthatDidNotGoThroughTryAgain': MessageLookupByLibrary.simpleMessage(
    'That did not go through. Try again.',
  ),
  'literalblockAuthor2': (Object author) => 'Block $author?',
  'literalshowResults': MessageLookupByLibrary.simpleMessage('Show results'),
  'literallabelDate': (Object label) => '\\$label date',
  'literalshareVia': MessageLookupByLibrary.simpleMessage('Share via…'),
  'literalhandItToAnotherApp': MessageLookupByLibrary.simpleMessage(
    'Hand it to another app',
  ),
  'literalshareWithAQuote': MessageLookupByLibrary.simpleMessage(
    'Share with a quote',
  ),
  'literalpostItWithYourOwnWordsAboveIt': MessageLookupByLibrary.simpleMessage(
    'Post it with your own words above it',
  ),
  'literalsavedPosts': MessageLookupByLibrary.simpleMessage('Saved posts'),
  'literallikedPosts': MessageLookupByLibrary.simpleMessage('Liked posts'),
  'literalstoriesRibbonStoriesLengthItems': (Object stories) =>
      'Stories ribbon, ${stories.length} items',
  'literalwhatYouPostIsYours': MessageLookupByLibrary.simpleMessage(
    'What you post is yours',
  ),
  'literalwhatKyronKeeps': MessageLookupByLibrary.simpleMessage(
    'What Kyron keeps',
  ),
  'literalhowToBehave': MessageLookupByLibrary.simpleMessage('How to behave'),
  'literalcloseTabLabel': (Object tab) => 'Close ${tab.label}',
  'literal1PageOpen': MessageLookupByLibrary.simpleMessage('1 page open'),
  'literalcountPagesOpen': (Object count) => '$count pages open',
  'literalstopLoading': MessageLookupByLibrary.simpleMessage('Stop loading'),
  'literalshareThisPage': MessageLookupByLibrary.simpleMessage(
    'Share this page',
  ),
  'literalnoAppOnThisDeviceOpensUriSchemeLinks': (Object uri) =>
      'No app on this device opens ${uri.scheme} links.',
  'literalcloseTheBrowser': MessageLookupByLibrary.simpleMessage(
    'Close the browser',
  ),
  'literalcloseAllPages': MessageLookupByLibrary.simpleMessage(
    'Close all pages',
  ),
  'literalremoveThisPoll': MessageLookupByLibrary.simpleMessage(
    'Remove this poll',
  ),
  'literalremoveThisAnswer': MessageLookupByLibrary.simpleMessage(
    'Remove this answer',
  ),
  'literalstartRecording': MessageLookupByLibrary.simpleMessage(
    'Start recording',
  ),
  'literalrecordAgain': MessageLookupByLibrary.simpleMessage('Record again'),
};

final messageLookup = MessageLookup();
