import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "about": MessageLookupByLibrary.simpleMessage("정보"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("답변 추가"),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage("동의하고 계속"),
      "answerNumber": (Object a0) => "답변 ${a0}",
      "arLens": MessageLookupByLibrary.simpleMessage("AR 렌즈"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage("시스템 로그 첨부"),
      "aWordPhraseOrTag":
          MessageLookupByLibrary.simpleMessage("단어, 문구 또는 #tag"),
      "block": MessageLookupByLibrary.simpleMessage("차단"),
      "blockAuthor": (Object a0) => "${a0} 차단하시겠어요?",
      "buildDetailsCopied":
          MessageLookupByLibrary.simpleMessage("빌드 정보가 복사되었습니다"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "cancel": MessageLookupByLibrary.simpleMessage("취소"),
      "change": MessageLookupByLibrary.simpleMessage("변경"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("이메일 변경"),
      "checkKyronReachable":
          MessageLookupByLibrary.simpleMessage("Kyron에 연결 가능한지 확인"),
      "checkEmailConfirm":
          MessageLookupByLibrary.simpleMessage("계정을 확인하려면 이메일을 확인하세요."),
      "closeCommunity": (Object a0) => "${a0}을(를) 닫으시겠어요?",
      "closeIt": MessageLookupByLibrary.simpleMessage("닫기"),
      "closeThisCommunity": MessageLookupByLibrary.simpleMessage("이 커뮤니티 닫기"),
      "confirmPassword": MessageLookupByLibrary.simpleMessage("비밀번호 확인"),
      "contactSupport": MessageLookupByLibrary.simpleMessage("지원팀에 문의"),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage("이메일로 계속하기"),
      "copy": MessageLookupByLibrary.simpleMessage("복사"),
      "copyReportInstead": MessageLookupByLibrary.simpleMessage("대신 보고서 복사"),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Google 로그인 창을 열 수 없습니다. ${a0}",
      "couldNotSignOut": (Object a0) => "로그아웃할 수 없습니다: ${a0}",
      "couldNotTakePicture":
          MessageLookupByLibrary.simpleMessage("사진을 찍을 수 없습니다."),
      "create": MessageLookupByLibrary.simpleMessage("만들기"),
      "createAccount": MessageLookupByLibrary.simpleMessage("계정 생성"),
      "createYourAccount": MessageLookupByLibrary.simpleMessage("계정을 생성하세요"),
      "createYourProfile": MessageLookupByLibrary.simpleMessage("프로필을 만드세요"),
      "delete": MessageLookupByLibrary.simpleMessage("삭제"),
      "deleteThisComment":
          MessageLookupByLibrary.simpleMessage("이 댓글을 삭제하시겠어요?"),
      "deleteThisPost": MessageLookupByLibrary.simpleMessage("이 게시물을 삭제하시겠어요?"),
      "describeAttachment":
          MessageLookupByLibrary.simpleMessage("이 첨부파일을 설명하세요"),
      "description": MessageLookupByLibrary.simpleMessage("설명"),
      "didCopied": MessageLookupByLibrary.simpleMessage("DID가 클립보드에 복사되었습니다"),
      "done": MessageLookupByLibrary.simpleMessage("완료"),
      "drafts": MessageLookupByLibrary.simpleMessage("초안"),
      "editProfile": MessageLookupByLibrary.simpleMessage("프로필 편집"),
      "emailNotifications": MessageLookupByLibrary.simpleMessage("이메일 알림"),
      "faceTrackingUnavailable":
          MessageLookupByLibrary.simpleMessage("이 기기에서는 얼굴 추적을 사용할 수 없습니다."),
      "followers": MessageLookupByLibrary.simpleMessage("팔로워"),
      "following": MessageLookupByLibrary.simpleMessage("팔로잉"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage("비밀번호를 잊으셨나요?"),
      "guidesAndAnswers":
          MessageLookupByLibrary.simpleMessage("자주 묻는 질문에 대한 가이드와 답변"),
      "handle": MessageLookupByLibrary.simpleMessage("핸들"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("도움말 센터"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("도움말 및 지원"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("한 줄로"),
      "itDisappearsForBoth":
          MessageLookupByLibrary.simpleMessage("둘 모두에게서 사라집니다."),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage("스레드에서 삭제됩니다."),
      "keepEditing": MessageLookupByLibrary.simpleMessage("계속 편집"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "leave": MessageLookupByLibrary.simpleMessage("나가기"),
      "leaveCommunity": (Object a0) => "${a0}에서 나가시겠어요?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("다시 들어오게 허용"),
      "loadMore": MessageLookupByLibrary.simpleMessage("더 불러오기"),
      "logCleared": MessageLookupByLibrary.simpleMessage("로그가 지워졌습니다"),
      "logCopied": MessageLookupByLibrary.simpleMessage("로그가 복사되었습니다"),
      "logIn": MessageLookupByLibrary.simpleMessage("로그인"),
      "logOut": MessageLookupByLibrary.simpleMessage("로그아웃"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("로그아웃하시겠어요?"),
      "message": MessageLookupByLibrary.simpleMessage("메시지"),
      "mute": MessageLookupByLibrary.simpleMessage("음소거"),
      "mutedAndBlocked": MessageLookupByLibrary.simpleMessage("음소거 및 차단됨"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage("음소거된 단어 및 태그"),
      "name": MessageLookupByLibrary.simpleMessage("이름"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> 화면"),
      "newEmailAddress": MessageLookupByLibrary.simpleMessage("새 이메일 주소"),
      "newPassword": MessageLookupByLibrary.simpleMessage("새 비밀번호"),
      "newPost": MessageLookupByLibrary.simpleMessage("새 게시물"),
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("복사할 내용이 없습니다"),
      "notifications": MessageLookupByLibrary.simpleMessage("알림"),
      "notNow": MessageLookupByLibrary.simpleMessage("나중에"),
      "notSentTapRetry":
          MessageLookupByLibrary.simpleMessage("전송되지 않았습니다. 다시 시도하려면 탭하세요."),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("브라우저에서 열기"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("페이지를 찾을 수 없습니다"),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage("관심사를 선택하세요"),
      "post": MessageLookupByLibrary.simpleMessage("게시"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("게시물 통계"),
      "postInCommunity": (Object a0) => "${a0}에 게시",
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("게시물 텍스트가 복사되었습니다"),
      "profileUpdated": MessageLookupByLibrary.simpleMessage("프로필이 업데이트되었습니다"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage("푸시 알림"),
      "quote": MessageLookupByLibrary.simpleMessage("인용"),
      "quotePost": MessageLookupByLibrary.simpleMessage("게시물 인용"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("사람에게 연락하기"),
      "remove": MessageLookupByLibrary.simpleMessage("제거"),
      "removeMember": (Object a0) => "${a0}을(를) 제거하시겠어요?",
      "removeConversation":
          MessageLookupByLibrary.simpleMessage("이 대화를 삭제하시겠어요?"),
      "removeMessage": MessageLookupByLibrary.simpleMessage("이 메시지를 삭제하시겠어요?"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("답글, 팔로우 및 멘션"),
      "reply": MessageLookupByLibrary.simpleMessage("답글"),
      "report": MessageLookupByLibrary.simpleMessage("신고"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
          "신고가 복사되었습니다. 지원팀에 보낼 이메일에 붙여넣으세요."),
      "reportSent": MessageLookupByLibrary.simpleMessage("신고가 전송되었습니다"),
      "repost": MessageLookupByLibrary.simpleMessage("다시 게시"),
      "reset": MessageLookupByLibrary.simpleMessage("재설정"),
      "resetPassword": MessageLookupByLibrary.simpleMessage("비밀번호 재설정"),
      "retry": MessageLookupByLibrary.simpleMessage("다시 시도"),
      "save": MessageLookupByLibrary.simpleMessage("저장"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("초안 저장"),
      "saySomething": (Object a0) => "${a0}에 메시지를 남겨보세요",
      "searchByNameOrHandle":
          MessageLookupByLibrary.simpleMessage("이름 또는 사용자명으로 검색"),
      "searchCommunities": MessageLookupByLibrary.simpleMessage("커뮤니티 검색"),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("GIF 검색"),
      "searchLanguages": MessageLookupByLibrary.simpleMessage("언어 검색"),
      "searchTrendingTags": MessageLookupByLibrary.simpleMessage("인기 태그 검색"),
      "securityAlerts": MessageLookupByLibrary.simpleMessage("보안 경고 및 계정 변경사항"),
      "sendConfirmation": MessageLookupByLibrary.simpleMessage("확인 전송"),
      "sendErrorReport": MessageLookupByLibrary.simpleMessage("오류 보고서 전송"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("피드백 보내기"),
      "sendReport": MessageLookupByLibrary.simpleMessage("보고서 전송"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("지원팀에 보내기"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("서비스 상태"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage("앱 로그를 지원팀과 공유"),
      "signedInAs": MessageLookupByLibrary.simpleMessage("로그인된 사용자:"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Kyron에 로그인"),
      "signupFailed": (Object a0) => "가입 실패: ${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("머물기"),
      "systemLog": MessageLookupByLibrary.simpleMessage("시스템 로그"),
      "tellMissingBroken":
          MessageLookupByLibrary.simpleMessage("빠졌거나 고장난 부분을 알려주세요"),
      "theComposerNoPostButton":
          MessageLookupByLibrary.simpleMessage("작성기에는 '게시' 버튼이 없습니다"),
      "translate": MessageLookupByLibrary.simpleMessage("번역"),
      "tryAgain": MessageLookupByLibrary.simpleMessage("다시 시도"),
      "undoRepost": MessageLookupByLibrary.simpleMessage("리포스트 취소"),
      "updatePassword": MessageLookupByLibrary.simpleMessage("비밀번호 업데이트"),
      "useDifferentAddress": MessageLookupByLibrary.simpleMessage("다른 주소 사용"),
      "whatHappened": MessageLookupByLibrary.simpleMessage("무슨 일이 있었나요?"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
          "무슨 일이 있었는지, 무엇을 확인하길 원하시는지 알려주세요"),
      "whatInPicture": MessageLookupByLibrary.simpleMessage("이 사진에 무엇이 있나요?"),
      "whatIsItFor":
          MessageLookupByLibrary.simpleMessage("무엇을 위한 것인가요? (선택 사항)"),
      "whatYouDid":
          MessageLookupByLibrary.simpleMessage("당신이 한 일, 기대한 것, 실제로 일어난 일"),
      "whatYouWereDoing":
          MessageLookupByLibrary.simpleMessage("문제가 발생했을 때 어떤 작업을 하고 있었는지."),
      "normalised": (Object a0) => "#\\${a0}",
      "postItSayItShowIt":
          MessageLookupByLibrary.simpleMessage("게시하고, 말하고, 보여주세요."),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
          "텍스트·음성·비디오, 이를 만드는 사람들, 그리고 그들이 대화하는 방들."),
      "alreadyOnKyron": MessageLookupByLibrary.simpleMessage("이미 Kyron에 계신가요?"),
      "byContinuingAgreeTermsPrivacy":
          MessageLookupByLibrary.simpleMessage("계속하면 약관 및 개인정보 처리방침에 동의하게 됩니다"),
      "googleSignInNeedsPhoneApp":
          MessageLookupByLibrary.simpleMessage("Google 로그인을 위해서는 휴대폰 앱이 필요합니다"),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google가 완료된 로그인 정보를 Kyron에 전달할 때 Android와 iOS만 응답하는 링크를 사용합니다. 따라서 ${a0}에서는 브라우저가 반환할 곳이 없습니다.\\n\\n이미 동일한 Google 계정으로 Kyron 계정이 있다면, 동일한 주소로 이메일로 계속하기를 사용한 뒤 '비밀번호 재설정'을 탭하세요 — 비밀번호 설정 링크를 이메일로 보내드립니다.",
      "loginFailed":
          MessageLookupByLibrary.simpleMessage("로그인에 실패했습니다. 자격 증명을 확인하세요."),
      "email": MessageLookupByLibrary.simpleMessage("이메일"),
      "password": MessageLookupByLibrary.simpleMessage("비밀번호"),
      "login": MessageLookupByLibrary.simpleMessage("로그인"),
      "or": MessageLookupByLibrary.simpleMessage("또는"),
      "username": MessageLookupByLibrary.simpleMessage("사용자 이름"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
          "사용자 이름은 소문자(a-z), 숫자(0-9), 밑줄(_)만 사용할 수 있습니다"),
      "passwordTooShort": MessageLookupByLibrary.simpleMessage("비밀번호가 너무 짧습니다"),
      "continueAction": MessageLookupByLibrary.simpleMessage("계속"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage("가입하면 당사의"),
      "terms": MessageLookupByLibrary.simpleMessage("약관"),
      "and": MessageLookupByLibrary.simpleMessage("및"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("개인정보 처리방침"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("Google로 로그인"),
      "googleSignUp": MessageLookupByLibrary.simpleMessage("Google로 가입"),
      "googleContinue": MessageLookupByLibrary.simpleMessage("Google로 계속하기"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("계속하면 당사의"),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage("Kyron에 지금 접속 가능한지 여부"),
      "literalwhatThisAppHasBeenDoing":
          MessageLookupByLibrary.simpleMessage("이 앱이 수행한 작업"),
      "literalshareTheLogWithSupport":
          MessageLookupByLibrary.simpleMessage("로그를 지원팀과 공유"),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("캐시 지우기"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("앱 버전"),
      "literalreading": MessageLookupByLibrary.simpleMessage("읽는 중…"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("다시 확인"),
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron이 응답하지 않았습니다"),
      "literalnothingLoggedYet":
          MessageLookupByLibrary.simpleMessage("아직 기록이 없습니다"),
      "literalswitchCamera": MessageLookupByLibrary.simpleMessage("카메라 전환"),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("카메라가 꺼져 있습니다"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("사진 찍기"),
      "literallensNameFaceLens": (Object a0) => "${a0}, 페이스 렌즈",
      "literalcouldNotPostThatReply":
          MessageLookupByLibrary.simpleMessage("답글을 게시할 수 없습니다."),
      "literalcouldNotLoadThisReply":
          MessageLookupByLibrary.simpleMessage("이 답글을 불러올 수 없습니다"),
      "literalthisReplyIsGone":
          MessageLookupByLibrary.simpleMessage("이 답글이 사라졌습니다"),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("사진 추가"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("클립 추가"),
      "literalstartACommunity":
          MessageLookupByLibrary.simpleMessage("커뮤니티 만들기"),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage("내 커뮤니티를 불러올 수 없습니다"),
      "literalyouAreNotInAnyCommunities":
          MessageLookupByLibrary.simpleMessage("참여 중인 커뮤니티가 없습니다"),
      "literalcouldNotLoadCommunities":
          MessageLookupByLibrary.simpleMessage("커뮤니티를 불러올 수 없습니다"),
      "literalpostInWidgetCommunityName": (Object a0) => "${a0}에 게시",
      "literalsaySomethingToWidgetCommunityName": (Object a0) => "${a0}에 말하기",
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("사람 태그"),
      "literalcloseWidgetCommunityName": (Object a0) => "${a0}을(를) 닫으시겠어요?",
      "literalonlyTheOwnerCanChangeThis":
          MessageLookupByLibrary.simpleMessage("이 항목은 소유자만 변경할 수 있습니다"),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage("배너나 사진을 탭하여 변경하세요"),
      "literalremoveMemberDisplayname": (Object a0) => "${a0}을(를) 제거하시겠어요?",
      "literalcouldNotLoadTheMembers":
          MessageLookupByLibrary.simpleMessage("멤버를 불러올 수 없습니다"),
      "literalnobodyHereYet":
          MessageLookupByLibrary.simpleMessage("아직 아무도 없습니다"),
      "literalmakeAModerator": MessageLookupByLibrary.simpleMessage("관리자로 지정"),
      "literalremoveAsModerator":
          MessageLookupByLibrary.simpleMessage("모더레이터 해제"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("커뮤니티에서 제거"),
      "literalcouldNotLoadThisList":
          MessageLookupByLibrary.simpleMessage("이 목록을 불러올 수 없습니다"),
      "literalnobodyHasBeenRemoved":
          MessageLookupByLibrary.simpleMessage("제거된 사람이 없습니다"),
      "literalpostInCommunityName": (Object a0) => "${a0}에 게시",
      "literalcouldNotOpenThisCommunity":
          MessageLookupByLibrary.simpleMessage("이 커뮤니티를 열 수 없습니다"),
      "literalthisCommunity": MessageLookupByLibrary.simpleMessage("이 커뮤니티"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("이 커뮤니티를 공유하기"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("링크 복사"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("링크가 복사되었습니다"),
      "literalleaveCommunityName": (Object a0) => "${a0}에서 나가시겠어요?",
      "literalyouHaveLeftCommunityName": (Object a0) => "${a0}에서 나가셨습니다",
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("동영상 추가"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("GIF 추가"),
      "literalrecordAVoicePost":
          MessageLookupByLibrary.simpleMessage("음성 게시물 녹음"),
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage("설문 제거"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("설문 추가"),
      "literaladdAHashtag": MessageLookupByLibrary.simpleMessage("해시태그 추가"),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage("임시 저장됨"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("저장된 초안이 없습니다"),
      "literalcouldNotLoadTrending":
          MessageLookupByLibrary.simpleMessage("인기 항목을 불러올 수 없습니다"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("아직 인기 있는 항목이 없습니다"),
      "literalcouldNotLoadTopics":
          MessageLookupByLibrary.simpleMessage("주제를 불러올 수 없습니다"),
      "literalnoTopicsYet": MessageLookupByLibrary.simpleMessage("아직 주제가 없습니다"),
      "literalcouldNotLoadSuggestions":
          MessageLookupByLibrary.simpleMessage("추천을 불러올 수 없습니다"),
      "literalnobodyLeftToSuggest":
          MessageLookupByLibrary.simpleMessage("추천할 사람이 더 이상 없습니다"),
      "literalyouExampleCom":
          MessageLookupByLibrary.simpleMessage("you@example.com"),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("링크 보내기"),
      "literalopenTheMailFromKyron":
          MessageLookupByLibrary.simpleMessage("Kyron에서 온 메일 열기"),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("메일 내 링크를 탭하세요"),
      "literalsetAPasswordAndCarryOn":
          MessageLookupByLibrary.simpleMessage("비밀번호를 설정하고 계속하기"),
      "literalsendAgainInCooldownS": (Object a0) => "다시 보내기 ${a0}초 후",
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("다시 보내기"),
      "literalnormalised": (Object a0) => "#${a0}",
      "literalcouldNotLoadYourMessages":
          MessageLookupByLibrary.simpleMessage("메시지를 불러올 수 없습니다"),
      "literalnothingUnread":
          MessageLookupByLibrary.simpleMessage("읽지 않은 항목이 없습니다"),
      "literalnoMessagesYet":
          MessageLookupByLibrary.simpleMessage("아직 메시지가 없습니다"),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("뮤트된 항목이 없습니다"),
      "literalnoLikesYet": MessageLookupByLibrary.simpleMessage("아직 좋아요가 없습니다"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("아직 답글이 없습니다"),
      "literalnoNewFollowers":
          MessageLookupByLibrary.simpleMessage("새로운 팔로워가 없습니다"),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("아직 리포스트가 없습니다"),
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("모든 항목을 확인했습니다"),
      "literalcouldNotLoadNotifications":
          MessageLookupByLibrary.simpleMessage("알림을 불러올 수 없습니다"),
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("커버 사진"),
      "literalchooseFromGallery":
          MessageLookupByLibrary.simpleMessage("갤러리에서 선택"),
      "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage("제공된 사진 사용"),
      "literaltapToAddAPhotoAndACover":
          MessageLookupByLibrary.simpleMessage("사진과 커버를 추가하려면 탭하세요"),
      "literalnoInterestsYet":
          MessageLookupByLibrary.simpleMessage("아직 관심사가 없습니다"),
      "literaldiscoverPeople": MessageLookupByLibrary.simpleMessage("사람 찾아보기"),
      "literalcancelReply": MessageLookupByLibrary.simpleMessage("답글 취소"),
      "literalcouldNotLoadThisPost":
          MessageLookupByLibrary.simpleMessage("게시물을 불러올 수 없습니다"),
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("이 프로필 공유"),
      "literalcouldNotLoadThesePosts":
          MessageLookupByLibrary.simpleMessage("게시물을 불러올 수 없습니다"),
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("아직 게시물을 올리지 않았습니다"),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage("아직 게시물이 없습니다"),
      "literalnothingToLookAtYet":
          MessageLookupByLibrary.simpleMessage("아직 볼 항목이 없습니다"),
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("계속 입력하세요"),
      "literalsearchFailed": MessageLookupByLibrary.simpleMessage("검색에 실패했습니다"),
      "literalnothingMatched":
          MessageLookupByLibrary.simpleMessage("일치하는 항목이 없습니다"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "로그아웃할 수 없습니다: ${a0}",
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("아직 DID가 없습니다"),
      "literalpasswordLogin":
          MessageLookupByLibrary.simpleMessage("비밀번호 및 로그인"),
      "literalmutedAndBlockedAccounts":
          MessageLookupByLibrary.simpleMessage("뮤트 및 차단된 계정"),
      "literalfontSize": MessageLookupByLibrary.simpleMessage("글꼴 크기"),
      "literalpushNotifications": MessageLookupByLibrary.simpleMessage("푸시 알림"),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("데이터 절약 모드"),
      "literalcontactSupport": MessageLookupByLibrary.simpleMessage("지원팀에 문의"),
      "literalsendFeedback": MessageLookupByLibrary.simpleMessage("피드백 보내기"),
      "literalappLanguage": MessageLookupByLibrary.simpleMessage("앱 언어"),
      "literalprimaryLanguage": MessageLookupByLibrary.simpleMessage("기본 언어"),
      "literalcontentLanguages": MessageLookupByLibrary.simpleMessage("콘텐츠 언어"),
      "literalremoveLanguageEnglishname": (Object a0) => "언어 제거: ${a0}",
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "전송되었습니다. 신고 번호 #${a0}입니다.",
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage("지금은 피드백을 보낼 수 없습니다"),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage("한 일, 기대한 결과, 실제로 일어난 일"),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "인증 실패: ${a0}",
      "literalverificationCodeResent":
          MessageLookupByLibrary.simpleMessage("인증 코드 재전송됨."),
      "literalverifyEmail": MessageLookupByLibrary.simpleMessage("이메일 인증"),
      "literalresendCode": MessageLookupByLibrary.simpleMessage("코드 재전송"),
      "literalremoveThisConversation":
          MessageLookupByLibrary.simpleMessage("이 대화 삭제"),
      "literalmutedYouWillNotBeNotified":
          MessageLookupByLibrary.simpleMessage("뮤트됨. 알림을 받지 않습니다."),
      "literalblockThisAccount":
          MessageLookupByLibrary.simpleMessage("이 계정을 차단하시겠습니까?"),
      "literalyouAreSignedOut":
          MessageLookupByLibrary.simpleMessage("로그아웃되었습니다."),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage("이 대화를 불러올 수 없습니다"),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("무엇이라도 말해 보세요"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("텍스트 복사"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("답장하지 않음"),
      "literalremoveFromSaved":
          MessageLookupByLibrary.simpleMessage("저장된 항목에서 제거"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("소리 켜기"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("소리 끄기"),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage("그 링크는 여기서 열 수 없습니다."),
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage("이 기기에는 해당 링크를 처리할 브라우저가 없습니다."),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("답글 열기"),
      "literallabelCount": (Object a0, Object a1) => "${a0}, ${a1}",
      "literalindex1": (Object a0) => "${a0}",
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF가 설정되어 있지 않습니다"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("GIF를 불러올 수 없습니다"),
      "literalnothingFound": MessageLookupByLibrary.simpleMessage("찾을 수 없습니다"),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage("해당 GIF를 다운로드할 수 없습니다."),
      "literaladdAnInterest": MessageLookupByLibrary.simpleMessage("관심사 추가"),
      "literalcouldNotLoadTrendingTags":
          MessageLookupByLibrary.simpleMessage("트렌딩 태그를 불러올 수 없습니다"),
      "literalnoTrendingTagMatchesThat":
          MessageLookupByLibrary.simpleMessage("해당하는 트렌딩 태그가 없습니다"),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage("이미 모든 트렌딩 태그를 팔로우하고 있습니다"),
      "literalremoveLabel": (Object a0) => "${a0} 제거",
      "literaladdLabelAsATab": (Object a0) => "${a0}을 탭으로 추가",
      "literalcouldNotSearch":
          MessageLookupByLibrary.simpleMessage("검색할 수 없습니다"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("누구를 태그하시겠습니까?"),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("아무도 찾지 못했습니다"),
      "literalshowPassword": MessageLookupByLibrary.simpleMessage("비밀번호 표시"),
      "literalhidePassword": MessageLookupByLibrary.simpleMessage("비밀번호 숨기기"),
      "literaltranslatePost": MessageLookupByLibrary.simpleMessage("게시물 번역"),
      "literalcopyPostText": MessageLookupByLibrary.simpleMessage("게시물 텍스트 복사"),
      "literalcopyLinkToPost":
          MessageLookupByLibrary.simpleMessage("게시물 링크 복사"),
      "literalshowMorePostsLikeThis":
          MessageLookupByLibrary.simpleMessage("이와 비슷한 게시물 더 보기"),
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("관심 없음"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
              "이 게시물을 숨기고 비슷한 게시물을 덜 보여 달라고 알립니다"),
      "literalhideThisPost": MessageLookupByLibrary.simpleMessage("이 게시물 숨기기"),
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("이 스레드 음소거"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage("이 게시물과 그에 대한 답글 보기 중단"),
      "literalmuteWordsOrTags":
          MessageLookupByLibrary.simpleMessage("단어 또는 태그 음소거"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage("조회자, 좋아요, 저장 및 댓글"),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("누가 답글을 달 수 있나요?"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("게시물 삭제"),
      "literalmuteAuthor": (Object a0) => "${a0} 음소거",
      "literalblockAuthor": (Object a0) => "${a0} 차단",
      "literalreportPost": MessageLookupByLibrary.simpleMessage("게시물 신고"),
      "literalreportAuthor": (Object a0) => "${a0} 신고",
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage("전송되지 않았습니다. 다시 시도하세요."),
      "literalblockAuthor2": (Object a0) => "${a0} 차단하시겠습니까?",
      "literalshowResults": MessageLookupByLibrary.simpleMessage("결과 보기"),
      "literallabelDate": (Object a0) => "${a0} 날짜",
      "literalshareVia": MessageLookupByLibrary.simpleMessage("공유하기…"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("다른 앱으로 전달"),
      "literalshareWithAQuote":
          MessageLookupByLibrary.simpleMessage("인용과 함께 공유"),
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage("위에 직접 작성한 문구를 덧붙여 게시하기"),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage("저장된 게시물"),
      "literallikedPosts": MessageLookupByLibrary.simpleMessage("좋아요한 게시물"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "스토리 리본, ${a0}개 항목",
      "literalwhatYouPostIsYours":
          MessageLookupByLibrary.simpleMessage("당신이 올린 게시물은 당신의 것입니다"),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kyron이 보관하는 것"),
      "literalhowToBehave": MessageLookupByLibrary.simpleMessage("행동 지침"),
      "literalcloseTabLabel": (Object a0) => "${a0} 닫기",
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("페이지 1개 열림"),
      "literalcountPagesOpen": (Object a0) => "${a0}개 페이지 열림",
      "literalstopLoading": MessageLookupByLibrary.simpleMessage("로딩 중지"),
      "literalshareThisPage": MessageLookupByLibrary.simpleMessage("이 페이지 공유"),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "${a0} 링크를 열 수 있는 앱이 이 기기에 없습니다.",
      "literalcloseTheBrowser": MessageLookupByLibrary.simpleMessage("브라우저 닫기"),
      "literalcloseAllPages": MessageLookupByLibrary.simpleMessage("모든 페이지 닫기"),
      "literalremoveThisPoll": MessageLookupByLibrary.simpleMessage("이 설문 삭제"),
      "literalremoveThisAnswer":
          MessageLookupByLibrary.simpleMessage("이 응답 삭제"),
      "literalstartRecording": MessageLookupByLibrary.simpleMessage("녹음 시작"),
      "literalrecordAgain": MessageLookupByLibrary.simpleMessage("다시 녹음"),
      "home": MessageLookupByLibrary.simpleMessage("홈"),
      "explore": MessageLookupByLibrary.simpleMessage("둘러보기"),
      "communities": MessageLookupByLibrary.simpleMessage("커뮤니티"),
      "messages": MessageLookupByLibrary.simpleMessage("메시지"),
      "languages": MessageLookupByLibrary.simpleMessage("언어"),
      "selectAppLanguage":
          MessageLookupByLibrary.simpleMessage("앱 사용자 인터페이스에 사용할 언어를 선택하세요."),
      "selectPrimaryLanguage":
          MessageLookupByLibrary.simpleMessage("피드 번역에 사용할 선호 언어를 선택하세요."),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
          "구독한 피드에 포함되길 원하는 언어를 선택하세요. 선택된 항목이 없으면 모든 언어가 표시됩니다."),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
          "Kyron의 문구는 아직 번역 중이라 대부분의 화면은 당분간 영어로 표시됩니다."),
      "hashtagsEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "사람들이 해시태그를 사용하기 시작하면 여기에 나타납니다."),
      "topicsEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "주제는 Kyron에서 설정합니다. 현재는 항목이 없습니다. 나중에 다시 확인하세요."),
      "peopleEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "여기에 Kyron이 넣을 사람들은 이미 모두 팔로우하고 있습니다."),
      "communitiesEmptyDetail":
          MessageLookupByLibrary.simpleMessage("둘러보기에서 찾거나 직접 커뮤니티를 시작하세요."),
      "messagesCaughtUp":
          MessageLookupByLibrary.simpleMessage("모든 대화가 최신 상태입니다."),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
          "누군가의 프로필을 열고 '메시지'를 눌러 대화를 시작하세요."),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
          "다른 사람이 당신의 게시물을 좋아하면 여기 표시됩니다."),
      "notificationRepliesDetail":
          MessageLookupByLibrary.simpleMessage("게시물에 대한 답글이 여기로 옵니다."),
      "notificationFollowersDetail":
          MessageLookupByLibrary.simpleMessage("당신을 팔로우한 사람들은 여기 표시됩니다."),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
          "다른 사람이 당신의 게시물을 리포스트하면 여기 표시됩니다."),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
          "좋아요, 답글 및 새로운 팔로워가 도착하면 여기에 표시됩니다."),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("도움 받기"),
      "send": MessageLookupByLibrary.simpleMessage("보내기"),
      "close": MessageLookupByLibrary.simpleMessage("닫기"),
      "search": MessageLookupByLibrary.simpleMessage("검색"),
      "settings": MessageLookupByLibrary.simpleMessage("설정"),
      "menu": MessageLookupByLibrary.simpleMessage("메뉴"),
      "clear": MessageLookupByLibrary.simpleMessage("지우기"),
      "manage": MessageLookupByLibrary.simpleMessage("관리"),
      "join": MessageLookupByLibrary.simpleMessage("가입"),
      "video": MessageLookupByLibrary.simpleMessage("동영상"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
          "게시물에 아직 언어 정보가 없어 오늘은 피드를 필터링하지 않습니다. 언어 선택은 추후 게시물에 언어가 표시될 때까지 저장됩니다."),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage("언어 추가…"),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
          "번역 기능이 아직 구축되지 않았습니다. 오늘은 피드에 번역된 항목이 없으며, 번역이 가능해지면 이 설정이 적용됩니다."),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
          "Kyron은 초기 단계여서 문제를 실제로 해결할 수 있는 사람에게 가장 빨리 도달하는 방법은 이슈를 여는 것입니다. 어떤 작업을 했고 대신 어떤 일이 발생했는지 포함하세요."),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
          "앱 내 지원 인박스는 아직 없으므로, 이 화면은 효과 없는 양식 대신 실제로 모니터링되는 곳을 안내합니다."),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("용도는 무엇인가요? (선택 사항)"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage("계정으로 돌아가려면 다시 로그인해야 합니다."),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("새 이메일 주소"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("새 비밀번호"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("비밀번호 확인"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("한 줄로"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("무슨 일이 있었나요?"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage("건너뛰기"),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage("완료"),
      "audit_about_screen_12_mb_e39721d6":
          MessageLookupByLibrary.simpleMessage("12 MB"),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("왕복"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("토큰 검증"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("다시 시도"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("다시 시도"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
              "지금 방송을 시작하면 아무도 참여할 수 없는 방에 있게 됩니다"),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("커뮤니티 만들기"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("무엇을 위한 것인가요? (선택사항)"),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("종료 중"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("다시."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("이 목록에서 다시."),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("먼저 가입"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("곧 제공됩니다"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("당신으로 게시 중"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage("방금"),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage("주제 1"),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("지금 전송 중입니다."),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("무언가 있나요."),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("일일 시청자 수"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join(\", \")"),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("이 게시물"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("추가할 내용이 있나요? (선택사항)"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("로그아웃"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("계정"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("비밀번호 확인"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("나중에"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("이 커뮤니티에 게시"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage("자체입니다."),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage("다시 시도"),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage("맞춤"),
      "audit_google_button_not_bbd76526":
          MessageLookupByLibrary.simpleMessage(", 아니고"),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("내가 움직이고 있나요?"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("소리 켜기"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("소리 끄기"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage("맞춤"),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("내 탭"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("다시 시도"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("기호 (!@#…)"),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("불러올 수 없음"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("이 게시물"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("계정에서"),
      "audit_skeleton_loading_18e82bcc":
          MessageLookupByLibrary.simpleMessage("로딩 중…"),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87":
          MessageLookupByLibrary.simpleMessage("게시 중…"),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("내 스토리"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("스토리 링크 복사"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage("3시간 전"),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage("귀하의 계정, 게시물, 그리고 탭하는 항목"),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("주제 추가"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("커뮤니티"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("설정"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("모양"),
      "ui_language": MessageLookupByLibrary.simpleMessage("언어"),
      "ui_account": MessageLookupByLibrary.simpleMessage("계정"),
      "ui_content_display": MessageLookupByLibrary.simpleMessage("콘텐츠 및 표시"),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("앱 및 기기"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("약관"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("개인정보"),
      "ui_help": MessageLookupByLibrary.simpleMessage("도움말"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("피드백"),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage("탈중앙화 ID"),
      "ui_find_people_on_kyron":
          MessageLookupByLibrary.simpleMessage("Kyron에서 사람 찾기"),
      "ui_search_everything_posted":
          MessageLookupByLibrary.simpleMessage("게시된 모든 항목 검색"),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage("핸들이나 표시 이름으로 검색하세요."),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
          "단어나 필터 — 계정, 날짜 범위, 또는 게시물이 담고 있는 것."),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("두 글자 이상."),
      "ui_no_posts_match_filters":
          MessageLookupByLibrary.simpleMessage("해당 필터에 일치하는 게시물이 없습니다."),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("지우기"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("필터"),
      "ui_post_text_copied":
          MessageLookupByLibrary.simpleMessage("게시물 텍스트가 복사되었습니다."),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("링크가 복사되었습니다."),
      "ui_interest_noted":
          MessageLookupByLibrary.simpleMessage("확인했습니다. 이는 보여지는 콘텐츠에 반영됩니다."),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
          "숨김 처리되었습니다. 이와 비슷한 게시물을 덜 보여드립니다."),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("게시물 숨김"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("스레드 음소거"),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("게시물 삭제됨"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
          "해당 게시물은 귀하의 프로필과 다른 모든 사용자의 피드에서 제거됩니다. 그에 대한 답글도 함께 삭제됩니다."),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
          "둘 다 Kyron에서 서로를 볼 수 없게 되며, 두 사람 간의 팔로우도 제거됩니다. 상대방에게는 통보되지 않습니다."),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
          "해당 사용자의 게시물이 보이지 않게 됩니다. 상대방에게는 알리지 않습니다."),
      "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage("이용약관"),
      "ui_about_privacy_policy":
          MessageLookupByLibrary.simpleMessage("개인정보처리방침"),
      "ui_settings_profile_contact":
          MessageLookupByLibrary.simpleMessage("프로필 및 연락처 정보"),
      "ui_settings_security": MessageLookupByLibrary.simpleMessage("보안 설정"),
      "ui_settings_muted_blocked":
          MessageLookupByLibrary.simpleMessage("음소거하거나 차단한 사용자"),
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("콘텐츠 및 표시"),
      "ui_settings_app_device": MessageLookupByLibrary.simpleMessage("앱 및 기기"),
      "ui_settings_data_saver": MessageLookupByLibrary.simpleMessage("데이터 절약"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("언어 선택"),
      "ui_settings_notifications_detail":
          MessageLookupByLibrary.simpleMessage("알림 환경설정"),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("도움말 문서 찾아보기"),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage("팀에 도움 요청"),
      "ui_settings_feedback_detail":
          MessageLookupByLibrary.simpleMessage("의견을 들려주세요"),
      "ui_could_not_load_profile":
          MessageLookupByLibrary.simpleMessage("프로필을 불러올 수 없습니다"),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("사용자 검색"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("게시물 검색"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("이 게시물"),
      "authorPostsHidden": (Object a0) => "이제 ${a0}의 게시물을 보지 않습니다.",
      "authorBlocked": (Object a0) => "${a0} 차단됨",
      "nothingMatchesQuery": (Object a0) =>
          "Kyron에서 \"${a0}\"와(과) 일치하는 항목이 없습니다.",
      "repliesPolicy": (Object a0) => "답글: ${a0}",
      "ui_preferences": MessageLookupByLibrary.simpleMessage("환경설정"),
      "ui_appearance_detail":
          MessageLookupByLibrary.simpleMessage("밝음, 어둠, 또는 휴대폰 설정에 따름"),
      "ui_legal": MessageLookupByLibrary.simpleMessage("법적 고지"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("진단"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("저장한 게시물"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("좋아요한 게시물"),
      "ui_nothing_saved_yet":
          MessageLookupByLibrary.simpleMessage("아직 저장된 항목이 없습니다"),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage("아직 좋아요가 없습니다"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
          "게시물의 보관 아이콘을 탭하면 여기에 보관됩니다. 저장한 항목은 본인만 볼 수 있습니다."),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
          "좋아요한 게시물이 여기에 표시됩니다. 가장 최근 항목이 먼저 표시됩니다."),
      "ui_could_not_load_saved_posts":
          MessageLookupByLibrary.simpleMessage("저장한 게시물을 불러올 수 없습니다"),
      "ui_could_not_load_liked_posts":
          MessageLookupByLibrary.simpleMessage("좋아요한 게시물을 불러올 수 없습니다"),
      "feedTagDetail": (Object a0) => "#${a0}에 아직 게시물이 없습니다.",
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("팔로우한 사람들의 게시물이 없습니다"),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("아직 동영상이 없습니다"),
      "ui_feed_empty": MessageLookupByLibrary.simpleMessage("아직 여기에 게시물이 없습니다"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
          "몇몇 계정을 팔로우하면 그들의 게시물이 여기에 표시됩니다."),
      "ui_feed_videos_detail":
          MessageLookupByLibrary.simpleMessage("클립이 포함된 게시물이 여기에 표시됩니다."),
      "ui_feed_for_you_detail":
          MessageLookupByLibrary.simpleMessage("사람들이 게시물을 작성하면 여기에 표시됩니다."),
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("피드를 불러올 수 없습니다"),
      "ui_share_this_post": MessageLookupByLibrary.simpleMessage("이 게시물 공유하기"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage("중복되지 않은 사용자 수(오픈 수 아님)"),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("참여"),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("게시됨"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("조회자"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("좋아요"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("댓글"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("저장"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("아직 조회자가 없습니다."),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("일별 조회자"),
      "analytics_nobody_opened_post":
          MessageLookupByLibrary.simpleMessage("아직 이 게시물을 연 사람이 없습니다."),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("누가 답글을 달 수 있나요?"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
          "누구나 이 게시물을 보고 리포스트하고 인용할 수 있습니다."),
      "reply_anyone": MessageLookupByLibrary.simpleMessage("누구나 상호작용 가능"),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
          "Kyron의 누구든 이 게시물에 답글을 달 수 있습니다."),
      "reply_followers": MessageLookupByLibrary.simpleMessage("당신을 팔로우하는 사람들"),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
          "오직 당신을 팔로우하는 사람들만 이 게시물에 답글을 달 수 있습니다."),
      "reply_mentioned": MessageLookupByLibrary.simpleMessage("당신이 언급한 사람들"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
          "이 게시물에서 당신이 @mention한 사람들만 답글을 달 수 있습니다."),
      "reply_nobody": MessageLookupByLibrary.simpleMessage("아무도 답글을 달 수 없음"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
          "답글이 꺼져 있습니다. 본인은 계속 답글을 달 수 있습니다."),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("추천"),
      "interest_following": MessageLookupByLibrary.simpleMessage("팔로잉"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("동영상"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("내 탭"),
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("드래그하여 순서 변경"),
      "interest_add": MessageLookupByLibrary.simpleMessage("관심사 추가"),
      "interest_trending_now": MessageLookupByLibrary.simpleMessage("지금 인기"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
          "스트립에는 최대 다섯 개의 탭만 표시됩니다. 추가하려면 하나를 제거하세요."),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
          "사람들이 해시태그를 사용하기 시작하면 여기에 나타납니다."),
      "composer_placeholder_rattling":
          MessageLookupByLibrary.simpleMessage("머릿속을 맴도는 생각이 뭐예요?"),
      "composer_placeholder_say":
          MessageLookupByLibrary.simpleMessage("당신만이 할 수 있는 말을 해보세요…"),
      "composer_placeholder_hot_take":
          MessageLookupByLibrary.simpleMessage("핫테이크를 남겨보세요(또는 온건한 의견도 괜찮아요)"),
      "composer_placeholder_signal":
          MessageLookupByLibrary.simpleMessage("이건 당신의 신호입니다 — 보내보세요."),
      "composer_placeholder_think":
          MessageLookupByLibrary.simpleMessage("입력, 말하거나 소리 내어 생각하기"),
      "profile_tap_to_change": MessageLookupByLibrary.simpleMessage("탭하여 변경"),
      "profile_display_name": MessageLookupByLibrary.simpleMessage("표시 이름"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("소개"),
      "profile_location": MessageLookupByLibrary.simpleMessage("위치"),
      "profile_website": MessageLookupByLibrary.simpleMessage("웹사이트"),
      "translation_description": MessageLookupByLibrary.simpleMessage(
          "Kyron의 자체 문구는 아직 번역 중이라 대부분의 화면은 당분간 영어로 유지됩니다. 이번 변경으로 적용되는 항목: Flutter가 그리는 인터페이스 일부, 날짜와 숫자, 그리고 오른쪽에서 왼쪽으로 읽는 언어에 대한 앱 레이아웃 방향입니다."),
      "theme_system_detail":
          MessageLookupByLibrary.simpleMessage("휴대폰의 라이트 또는 다크 설정을 따름"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("항상 밝게"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("항상 어둡게"),
      "theme_dim_detail":
          MessageLookupByLibrary.simpleMessage("검정 대신 블루그레이 색상의 더 부드러운 다크"),
      "theme_system": MessageLookupByLibrary.simpleMessage("시스템"),
      "theme_light": MessageLookupByLibrary.simpleMessage("라이트"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("다크"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("은은한"),
      "ui_like": MessageLookupByLibrary.simpleMessage("좋아요"),
      "ui_share": MessageLookupByLibrary.simpleMessage("공유"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("가입함"),
      "ui_join": MessageLookupByLibrary.simpleMessage("가입"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("소리 켜기"),
      "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("소리 끄기"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("일시정지"),
      "ui_play": MessageLookupByLibrary.simpleMessage("재생"),
      "ui_from_account": MessageLookupByLibrary.simpleMessage("계정에서"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("다음 기간 사이에 게시됨"),
      "ui_after": MessageLookupByLibrary.simpleMessage("이후"),
      "ui_before": MessageLookupByLibrary.simpleMessage("이전"),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("휴대 중"),
      "create_text_post": MessageLookupByLibrary.simpleMessage("텍스트 게시글"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("음성 게시글"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR 렌즈"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("라이브 시작"),
      "voice_record_post": MessageLookupByLibrary.simpleMessage("음성 게시글 녹음"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("녹음 중…"),
      "voice_ready_attach": MessageLookupByLibrary.simpleMessage("첨부 준비 완료"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("중지"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("첨부"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
          "작성 중인 상태로 작성기를 닫으면 초안을 제안받게 됩니다."),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage("질문이 없는 설문"),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage("아직 내용이 없는 인용"),
      "draft_nothing_empty":
          MessageLookupByLibrary.simpleMessage("아직 작성된 내용이 없음"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("방금"),
      "draft_minutes_ago": MessageLookupByLibrary.simpleMessage("{minutes}분 전"),
      "draft_hours_ago": MessageLookupByLibrary.simpleMessage("{hours}시간 전"),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days}일 전"),
    };

final messageLookup = MessageLookup();
