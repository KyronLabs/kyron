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
      'confirmPassword':
          MessageLookupByLibrary.simpleMessage('Confirm password'),
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
      'deleteThisPost':
          MessageLookupByLibrary.simpleMessage('Delete this post?'),
      'describeAttachment': MessageLookupByLibrary.simpleMessage(
        'Describe this attachment',
      ),
      'description': MessageLookupByLibrary.simpleMessage('Description'),
      'didCopied':
          MessageLookupByLibrary.simpleMessage('DID copied to clipboard'),
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
      'forgotPassword':
          MessageLookupByLibrary.simpleMessage('Forgot password?'),
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
      'mutedAndBlocked':
          MessageLookupByLibrary.simpleMessage('Muted and blocked'),
      'mutedWordsAndTags': MessageLookupByLibrary.simpleMessage(
        'Muted words and tags',
      ),
      'name': MessageLookupByLibrary.simpleMessage('Name'),
      'nameScreen': MessageLookupByLibrary.simpleMessage('<name> Screen'),
      'newEmailAddress':
          MessageLookupByLibrary.simpleMessage('New email address'),
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
      'postTextCopied':
          MessageLookupByLibrary.simpleMessage('Post text copied'),
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
      'removeMessage':
          MessageLookupByLibrary.simpleMessage('Remove this message?'),
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
      'resetPassword':
          MessageLookupByLibrary.simpleMessage('Reset your password'),
      'retry': MessageLookupByLibrary.simpleMessage('Retry'),
      'save': MessageLookupByLibrary.simpleMessage('Save'),
      'saveDraft': MessageLookupByLibrary.simpleMessage('Save draft'),
      'saySomething': (Object communityName) =>
          'Say something to $communityName',
      'searchByNameOrHandle': MessageLookupByLibrary.simpleMessage(
        'Search by name or handle',
      ),
      'searchCommunities': MessageLookupByLibrary.simpleMessage(
        'Search communities',
      ),
      'searchGIFs': MessageLookupByLibrary.simpleMessage('Search GIFs'),
      'searchLanguages':
          MessageLookupByLibrary.simpleMessage('Search languages'),
      'searchTrendingTags': MessageLookupByLibrary.simpleMessage(
        'Search trending tags',
      ),
      'securityAlerts': MessageLookupByLibrary.simpleMessage(
        'Security alerts and account changes',
      ),
      'sendConfirmation':
          MessageLookupByLibrary.simpleMessage('Send confirmation'),
      'sendErrorReport':
          MessageLookupByLibrary.simpleMessage('Send error report'),
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
      'alreadyOnKyron':
          MessageLookupByLibrary.simpleMessage('Already on Kyron?'),
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
      'googleSignIn':
          MessageLookupByLibrary.simpleMessage('Sign in with Google'),
      'googleSignUp':
          MessageLookupByLibrary.simpleMessage('Sign up with Google'),
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
      'literalswitchCamera':
          MessageLookupByLibrary.simpleMessage('Switch camera'),
      'literaltheCameraIsClosed': MessageLookupByLibrary.simpleMessage(
        'The camera is closed',
      ),
      'literaltakeAPicture':
          MessageLookupByLibrary.simpleMessage('Take a picture'),
      'literallensNameFaceLens': (dynamic lens) => '${lens.name}, face lens',
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
      'literalcouldNotLoadYourCommunities':
          MessageLookupByLibrary.simpleMessage(
        'Could not load your communities',
      ),
      'literalyouAreNotInAnyCommunities': MessageLookupByLibrary.simpleMessage(
        'You are not in any communities',
      ),
      'literalcouldNotLoadCommunities': MessageLookupByLibrary.simpleMessage(
        'Could not load communities',
      ),
      'literalpostInWidgetCommunityName': (dynamic widget) =>
          'Post in ${widget.community.name}',
      'literalsaySomethingToWidgetCommunityName': (dynamic widget) =>
          'Say something to ${widget.community.name}',
      'literaltagSomeone': MessageLookupByLibrary.simpleMessage('Tag someone'),
      'literalcloseWidgetCommunityName': (dynamic widget) =>
          'Close ${widget.community.name}?',
      'literalonlyTheOwnerCanChangeThis': MessageLookupByLibrary.simpleMessage(
        'Only the owner can change this',
      ),
      'literaltapTheBannerOrThePictureToChangeIt':
          MessageLookupByLibrary.simpleMessage(
        'Tap the banner or the picture to change it',
      ),
      'literalremoveMemberDisplayname': (dynamic member) =>
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
      'literalpostInCommunityName': (dynamic community) =>
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
      'literalleaveCommunityName': (dynamic community) =>
          'Leave ${community.name}?',
      'literalyouHaveLeftCommunityName': (dynamic community) =>
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
      'literaladdAHashtag':
          MessageLookupByLibrary.simpleMessage('Add a hashtag'),
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
      'literalnoTopicsYet':
          MessageLookupByLibrary.simpleMessage('No topics yet'),
      'literalcouldNotLoadSuggestions': MessageLookupByLibrary.simpleMessage(
        'Could not load suggestions',
      ),
      'literalnobodyLeftToSuggest': MessageLookupByLibrary.simpleMessage(
        'Nobody left to suggest',
      ),
      'literalyouExampleCom': MessageLookupByLibrary.simpleMessage(
        'you@example.com',
      ),
      'literalsendTheLink':
          MessageLookupByLibrary.simpleMessage('Send the link'),
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
      'literalnothingMuted':
          MessageLookupByLibrary.simpleMessage('Nothing muted'),
      'literalnoLikesYet': MessageLookupByLibrary.simpleMessage('No likes yet'),
      'literalnoRepliesYet':
          MessageLookupByLibrary.simpleMessage('No replies yet'),
      'literalnoNewFollowers': MessageLookupByLibrary.simpleMessage(
        'No new followers',
      ),
      'literalnoRepostsYet':
          MessageLookupByLibrary.simpleMessage('No reposts yet'),
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
      'literalcancelReply':
          MessageLookupByLibrary.simpleMessage('Cancel reply'),
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
      'literalsearchFailed':
          MessageLookupByLibrary.simpleMessage('Search failed'),
      'literalnothingMatched': MessageLookupByLibrary.simpleMessage(
        'Nothing matched',
      ),
      'literalcouldNotSignOutDescribeapierrorE': (Object describeApiError) =>
          'Could not sign out: $describeApiError',
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
      'literalsendFeedback':
          MessageLookupByLibrary.simpleMessage('Send Feedback'),
      'literalappLanguage':
          MessageLookupByLibrary.simpleMessage('App language'),
      'literalprimaryLanguage': MessageLookupByLibrary.simpleMessage(
        'Primary language',
      ),
      'literalcontentLanguages': MessageLookupByLibrary.simpleMessage(
        'Content languages',
      ),
      'literalremoveLanguageEnglishname': (dynamic language) =>
          'Remove ${language.englishName}',
      'literalsentItIsReportFiledNumber': (dynamic filed) =>
          'Sent. It is report #${filed.number}.',
      'literalfeedbackCannotBeSentRightNow':
          MessageLookupByLibrary.simpleMessage(
        'Feedback cannot be sent right now',
      ),
      'literalwhatYouDidWhatYouExpectedWhatHappened':
          MessageLookupByLibrary.simpleMessage(
        'What you did, what you expected, what happened ',
      ),
      'literalverificationFailedDescribeapierrorE': (Object describeApiError) =>
          'Verification failed: $describeApiError',
      'literalverificationCodeResent': MessageLookupByLibrary.simpleMessage(
        'Verification code resent.',
      ),
      'literalverifyEmail':
          MessageLookupByLibrary.simpleMessage('Verify Email'),
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
      'literalcouldNotLoadThisConversation':
          MessageLookupByLibrary.simpleMessage(
        'Could not load this conversation',
      ),
      'literalsaySomething':
          MessageLookupByLibrary.simpleMessage('Say something'),
      'literalcopyText': MessageLookupByLibrary.simpleMessage('Copy text'),
      'literaldoNotReply': MessageLookupByLibrary.simpleMessage('Do not reply'),
      'literalremoveFromSaved': MessageLookupByLibrary.simpleMessage(
        'Remove from saved',
      ),
      'literalturnSoundOn':
          MessageLookupByLibrary.simpleMessage('Turn sound on'),
      'literalturnSoundOff':
          MessageLookupByLibrary.simpleMessage('Turn sound off'),
      'literalthatLinkIsNotOneThisCanOpen':
          MessageLookupByLibrary.simpleMessage(
        'That link is not one this can open.',
      ),
      'literalnoBrowserOnThisDeviceTookThatLink':
          MessageLookupByLibrary.simpleMessage(
        'No browser on this device took that link.',
      ),
      'literalopenReply': MessageLookupByLibrary.simpleMessage('Open reply'),
      'literallabelCount': (Object label, Object count) => '$label, $count',
      'literalindex1': (dynamic index) => '${index + 1}',
      'literalfirstyearIndex': (dynamic _firstYear) => '$_firstYear',
      'literalgifsAreNotSetUp': MessageLookupByLibrary.simpleMessage(
        'GIFs are not set up',
      ),
      'literalcouldNotLoadGifs': MessageLookupByLibrary.simpleMessage(
        'Could not load GIFs',
      ),
      'literalnothingFound':
          MessageLookupByLibrary.simpleMessage('Nothing found'),
      'literalthatGifCouldNotBeDownloaded':
          MessageLookupByLibrary.simpleMessage(
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
      'literalnobodyFound':
          MessageLookupByLibrary.simpleMessage('Nobody found'),
      'literalshowPassword':
          MessageLookupByLibrary.simpleMessage('Show password'),
      'literalhidePassword':
          MessageLookupByLibrary.simpleMessage('Hide password'),
      'literaltranslatePost': MessageLookupByLibrary.simpleMessage(
        'Translate post',
      ),
      'literalcopyPostText':
          MessageLookupByLibrary.simpleMessage('Copy post text'),
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
      'literalhideThisPost':
          MessageLookupByLibrary.simpleMessage('Hide this post'),
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
      'literalviewersLikesSavesAndComments':
          MessageLookupByLibrary.simpleMessage(
        'Viewers, likes, saves and comments',
      ),
      'literalwhoCanReply':
          MessageLookupByLibrary.simpleMessage('Who can reply'),
      'literaldeletePost': MessageLookupByLibrary.simpleMessage('Delete post'),
      'literalmuteAuthor': (Object author) => 'Mute $author',
      'literalblockAuthor': (Object author) => 'Block $author',
      'literalreportPost': MessageLookupByLibrary.simpleMessage('Report post'),
      'literalreportAuthor': (Object author) => 'Report $author',
      'literalthatDidNotGoThroughTryAgain':
          MessageLookupByLibrary.simpleMessage(
        'That did not go through. Try again.',
      ),
      'literalblockAuthor2': (Object author) => 'Block $author?',
      'literalshowResults':
          MessageLookupByLibrary.simpleMessage('Show results'),
      'literallabelDate': (Object label) => '\\$label date',
      'literalshareVia': MessageLookupByLibrary.simpleMessage('Share via…'),
      'literalhandItToAnotherApp': MessageLookupByLibrary.simpleMessage(
        'Hand it to another app',
      ),
      'literalshareWithAQuote': MessageLookupByLibrary.simpleMessage(
        'Share with a quote',
      ),
      'literalpostItWithYourOwnWordsAboveIt':
          MessageLookupByLibrary.simpleMessage(
        'Post it with your own words above it',
      ),
      'literalsavedPosts': MessageLookupByLibrary.simpleMessage('Saved posts'),
      'literallikedPosts': MessageLookupByLibrary.simpleMessage('Liked posts'),
      'literalstoriesRibbonStoriesLengthItems': (dynamic stories) =>
          'Stories ribbon, ${stories.length} items',
      'literalwhatYouPostIsYours': MessageLookupByLibrary.simpleMessage(
        'What you post is yours',
      ),
      'literalwhatKyronKeeps': MessageLookupByLibrary.simpleMessage(
        'What Kyron keeps',
      ),
      'literalhowToBehave':
          MessageLookupByLibrary.simpleMessage('How to behave'),
      'literalcloseTabLabel': (dynamic tab) => 'Close ${tab.label}',
      'literal1PageOpen': MessageLookupByLibrary.simpleMessage('1 page open'),
      'literalcountPagesOpen': (Object count) => '$count pages open',
      'literalstopLoading':
          MessageLookupByLibrary.simpleMessage('Stop loading'),
      'literalshareThisPage': MessageLookupByLibrary.simpleMessage(
        'Share this page',
      ),
      'literalnoAppOnThisDeviceOpensUriSchemeLinks': (dynamic uri) =>
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
      'literalrecordAgain':
          MessageLookupByLibrary.simpleMessage('Record again'),
      'home': MessageLookupByLibrary.simpleMessage("Home"),
      'explore': MessageLookupByLibrary.simpleMessage("Explore"),
      'communities': MessageLookupByLibrary.simpleMessage("Communities"),
      'messages': MessageLookupByLibrary.simpleMessage("Messages"),
      'languages': MessageLookupByLibrary.simpleMessage("Languages"),
      'selectAppLanguage': MessageLookupByLibrary.simpleMessage(
          "Select which language to use for the app's user interface."),
      'selectPrimaryLanguage': MessageLookupByLibrary.simpleMessage(
          "Select your preferred language for translations in your feed."),
      'selectContentLanguages': MessageLookupByLibrary.simpleMessage(
          "Select which languages you want your subscribed feeds to include. If none are selected, all languages will be shown."),
      'kyronWordsStillBeingTranslated': MessageLookupByLibrary.simpleMessage(
          "Kyron's words are still being translated, so most screens stay in English for now."),
      'hashtagsEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Hashtags turn up here as people start using them."),
      'topicsEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Topics are set up by Kyron, and there are none right now. Check back soon."),
      'peopleEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "You already follow everyone Kyron would put here."),
      'communitiesEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Find one on Discover, or start your own."),
      'messagesCaughtUp': MessageLookupByLibrary.simpleMessage(
          "Every conversation is caught up."),
      'messagesNoMessages': MessageLookupByLibrary.simpleMessage(
          "Open somebody's profile and tap Message to start a conversation."),
      'notificationLikesDetail': MessageLookupByLibrary.simpleMessage(
          "When somebody likes one of your posts, it shows up here."),
      'notificationRepliesDetail': MessageLookupByLibrary.simpleMessage(
          "Replies to your posts land here."),
      'notificationFollowersDetail': MessageLookupByLibrary.simpleMessage(
          "People who follow you show up here."),
      'notificationRepostsDetail': MessageLookupByLibrary.simpleMessage(
          "When somebody reposts you, it shows up here."),
      'notificationEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Likes, replies and new followers land here as they arrive."),
      'gettingHelp': MessageLookupByLibrary.simpleMessage("Getting help"),
      'send': MessageLookupByLibrary.simpleMessage("Send"),
      'close': MessageLookupByLibrary.simpleMessage("Close"),
      'search': MessageLookupByLibrary.simpleMessage("Search"),
      'settings': MessageLookupByLibrary.simpleMessage("Settings"),
      'menu': MessageLookupByLibrary.simpleMessage("Menu"),
      'clear': MessageLookupByLibrary.simpleMessage("Clear"),
      'manage': MessageLookupByLibrary.simpleMessage("Manage"),
      'join': MessageLookupByLibrary.simpleMessage("Join"),
      'video': MessageLookupByLibrary.simpleMessage("Video"),
      'contentLanguagesNotFilteringYet': MessageLookupByLibrary.simpleMessage(
          "Posts do not carry a language yet, so this does not filter your feed today. Your choice is kept for when they do."),
      'addMoreLanguages':
          MessageLookupByLibrary.simpleMessage("Add more languages…"),
      'translationNotBuiltYet': MessageLookupByLibrary.simpleMessage(
          "Translation is not built yet. Nothing in your feed is translated today; this is remembered for when it is."),
      'supportEarlyExplanation': MessageLookupByLibrary.simpleMessage(
          "Kyron is early, and the fastest way to reach someone who can actually fix a problem is to open an issue. Include what you were doing and what happened instead."),
      'supportInboxNotYet': MessageLookupByLibrary.simpleMessage(
          "There is no in-app support inbox yet, so this screen points at the place that is actually monitored rather than at a form that goes nowhere."),
      'ui_communities_screen_what_is_it_for_optional_39b687':
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      'ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001':
          MessageLookupByLibrary.simpleMessage(
              "You will need to sign in again to get back to your account."),
      'ui_settings_subscreens_new_email_address_dab96e':
          MessageLookupByLibrary.simpleMessage("New email address"),
      'ui_settings_subscreens_new_password_88c1bf':
          MessageLookupByLibrary.simpleMessage("New password"),
      'ui_settings_subscreens_confirm_password_41d040':
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      'ui_settings_subscreens_in_one_line_06bdaf':
          MessageLookupByLibrary.simpleMessage("In one line"),
      'ui_settings_subscreens_what_happened_977dd8':
          MessageLookupByLibrary.simpleMessage("What happened"),
      'ui_onboard_step3_screen_skip_7b13d8':
          MessageLookupByLibrary.simpleMessage("Skip"),
      'ui_onboard_step3_screen_finish_5c0ad8':
          MessageLookupByLibrary.simpleMessage("Finish"),
      'audit_about_screen_12_mb_e39721d6':
          MessageLookupByLibrary.simpleMessage("12 MB"),
      'audit_about_subscreens_round_trip_64776b4c':
          MessageLookupByLibrary.simpleMessage("Round trip"),
      'audit_about_subscreens_token_verification_7934e1f2':
          MessageLookupByLibrary.simpleMessage("TOKEN VERIFICATION"),
      'audit_about_subscreens_support_kyron_so_a3a84d0f':
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      'audit_ar_lens_screen_try_again_cdec8872':
          MessageLookupByLibrary.simpleMessage("Try again"),
      'audit_browser_engine_window_stop_39c04883':
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      'audit_browser_sheet_try_again_44bc94ba':
          MessageLookupByLibrary.simpleMessage("Try again"),
      'audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b':
          MessageLookupByLibrary.simpleMessage(
              "Starting a broadcast now would put you in a room nobody could"),
      'audit_communities_screen_start_a_community_06c8ec4f':
          MessageLookupByLibrary.simpleMessage("Start a community"),
      'audit_communities_screen_what_is_it_for_optional_e7e82092':
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      'audit_community_manage_screen_closing_it_f490fb09':
          MessageLookupByLibrary.simpleMessage("Closing it"),
      'audit_community_manage_screen_back_in_e495a750':
          MessageLookupByLibrary.simpleMessage("back in."),
      'audit_community_manage_screen_back_in_from_this_list_9496a4fd':
          MessageLookupByLibrary.simpleMessage("back in from this list."),
      'audit_community_screen_join_first_7798cafc':
          MessageLookupByLibrary.simpleMessage("join first"),
      'audit_composer_screen_coming_soon_431fd23d':
          MessageLookupByLibrary.simpleMessage("coming soon"),
      'audit_composer_screen_posting_as_you_45d69932':
          MessageLookupByLibrary.simpleMessage("Posting as you"),
      'audit_drafts_screen_just_now_17a8d48a':
          MessageLookupByLibrary.simpleMessage("Just now"),
      'audit_explore_screen_topic_1_83830b41':
          MessageLookupByLibrary.simpleMessage("Topic 1"),
      'audit_forgot_password_screen_its_way_to_it_now_271a6cea':
          MessageLookupByLibrary.simpleMessage("its way to it now."),
      'audit_forgot_password_screen_has_anything_65044193':
          MessageLookupByLibrary.simpleMessage("has anything."),
      'audit_post_analytics_screen_viewers_per_day_5d881f10':
          MessageLookupByLibrary.simpleMessage("VIEWERS PER DAY"),
      'audit_post_detail_screen_sublist_1_join_b0a5d508':
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      'audit_report_screen_this_post_820d9740':
          MessageLookupByLibrary.simpleMessage("this post"),
      'audit_report_screen_anything_to_add_optional_f0051fa4':
          MessageLookupByLibrary.simpleMessage("Anything to add? (optional)"),
      'audit_settings_screen_log_out_0b39bfb2':
          MessageLookupByLibrary.simpleMessage("Log Out"),
      'audit_settings_screen_your_account_bcdf27af':
          MessageLookupByLibrary.simpleMessage("Your account"),
      'audit_settings_screen_did_plc_abc_825b4f49':
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      'audit_settings_subscreens_confirm_password_f0e1f449':
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      'audit_settings_subscreens_not_now_e1657fa9':
          MessageLookupByLibrary.simpleMessage("not now"),
      'audit_create_fab_post_in_this_community_0a42daf2':
          MessageLookupByLibrary.simpleMessage("post in this community"),
      'audit_url_preview_its_own_8b362f95':
          MessageLookupByLibrary.simpleMessage("its own."),
      'audit_empty_state_try_again_80ef48cd':
          MessageLookupByLibrary.simpleMessage("Try again"),
      'audit_feed_canvas_for_you_aa3c510d':
          MessageLookupByLibrary.simpleMessage("For You"),
      'audit_google_button_not_bbd76526':
          MessageLookupByLibrary.simpleMessage(", not"),
      'audit_inline_video_am_i_moving_4618f78c':
          MessageLookupByLibrary.simpleMessage("am I moving"),
      'audit_inline_video_turn_sound_on_83671c54':
          MessageLookupByLibrary.simpleMessage("Turn sound on"),
      'audit_inline_video_turn_sound_off_97714bbc':
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      'audit_interest_tabs_for_you_7ef9e823':
          MessageLookupByLibrary.simpleMessage("For You"),
      'audit_interest_tabs_your_tabs_c3ba148f':
          MessageLookupByLibrary.simpleMessage("Your tabs"),
      'audit_media_tray_alt_784030d4':
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      'audit_mention_picker_sheet_try_again_fd5d5dd7':
          MessageLookupByLibrary.simpleMessage("Try again"),
      'audit_password_requirements_symbol_322aed1e':
          MessageLookupByLibrary.simpleMessage("Symbol (!@#…)"),
      'audit_post_list_view_could_not_load_4dd86c79':
          MessageLookupByLibrary.simpleMessage("could not load"),
      'audit_post_options_sheet_this_post_99bfa981':
          MessageLookupByLibrary.simpleMessage("this post"),
      'audit_post_text_a_b_780da9a1':
          MessageLookupByLibrary.simpleMessage("a#b"),
      'audit_search_filter_sheet_from_an_account_f6a22687':
          MessageLookupByLibrary.simpleMessage("From an account"),
      'audit_skeleton_loading_18e82bcc':
          MessageLookupByLibrary.simpleMessage("Loading…"),
      'audit_sliding_drawer_content_kyron_v1_0_0_d696e73a':
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      'audit_story_pill_posting_bb613f87':
          MessageLookupByLibrary.simpleMessage("Posting…"),
      'audit_story_viewer_your_story_b706ecb4':
          MessageLookupByLibrary.simpleMessage("Your Story"),
      'audit_story_viewer_copy_story_link_2bd1546c':
          MessageLookupByLibrary.simpleMessage("Copy story link"),
      'audit_story_viewer_3h_ago_174dc80d':
          MessageLookupByLibrary.simpleMessage("3h ago"),
      'audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef':
          MessageLookupByLibrary.simpleMessage(
              "Your account, your posts, and what you tap on so"),
      'audit_topic_picker_add_a_topic_25baaf8a':
          MessageLookupByLibrary.simpleMessage("Add a topic"),
    };

final messageLookup = MessageLookup();
