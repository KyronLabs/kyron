import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';
  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      'about': MessageLookupByLibrary.simpleMessage("关于"),
      'addAnAnswer': MessageLookupByLibrary.simpleMessage("添加答案"),
      'agreeAndContinue': MessageLookupByLibrary.simpleMessage("同意并继续"),
      'answerNumber': (Object i) => "第 $i 个答案",
      'arLens': MessageLookupByLibrary.simpleMessage("AR 镜头"),
      'attachSystemLog': MessageLookupByLibrary.simpleMessage("附加系统日志"),
      'aWordPhraseOrTag': MessageLookupByLibrary.simpleMessage("一个词、短语或 #tag"),
      'block': MessageLookupByLibrary.simpleMessage("拉黑"),
      'blockAuthor': (Object author) => "要拉黑 ${author} 吗？",
      'buildDetailsCopied': MessageLookupByLibrary.simpleMessage("构建详情已复制"),
      'bullet': MessageLookupByLibrary.simpleMessage("•"),
      'cancel': MessageLookupByLibrary.simpleMessage("取消"),
      'change': MessageLookupByLibrary.simpleMessage("更改"),
      'changeEmail': MessageLookupByLibrary.simpleMessage("更改邮箱"),
      'checkKyronReachable':
          MessageLookupByLibrary.simpleMessage("检查 Kyron 是否可访问"),
      'checkEmailConfirm':
          MessageLookupByLibrary.simpleMessage("请查收邮件以确认你的账户。"),
      'closeCommunity': (Object communityName) => "要关闭 ${communityName} 吗？",
      'closeIt': MessageLookupByLibrary.simpleMessage("关闭"),
      'closeThisCommunity': MessageLookupByLibrary.simpleMessage("关闭此社区"),
      'confirmPassword': MessageLookupByLibrary.simpleMessage("确认密码"),
      'contactSupport': MessageLookupByLibrary.simpleMessage("联系支持"),
      'continueWithEmail': MessageLookupByLibrary.simpleMessage("使用邮箱继续"),
      'copy': MessageLookupByLibrary.simpleMessage("复制"),
      'copyReportInstead': MessageLookupByLibrary.simpleMessage("改为复制报告"),
      'couldNotOpenGoogleSignIn': (Object error) => "无法打开 Google 登录。${error}",
      'couldNotSignOut': (Object error) => "无法退出：${error}",
      'couldNotTakePicture': MessageLookupByLibrary.simpleMessage("无法拍摄该照片。"),
      'create': MessageLookupByLibrary.simpleMessage("创建"),
      'createAccount': MessageLookupByLibrary.simpleMessage("创建账户"),
      'createYourAccount': MessageLookupByLibrary.simpleMessage("创建你的账户"),
      'createYourProfile': MessageLookupByLibrary.simpleMessage("创建你的个人资料"),
      'delete': MessageLookupByLibrary.simpleMessage("删除"),
      'deleteThisComment': MessageLookupByLibrary.simpleMessage("删除此评论？"),
      'deleteThisPost': MessageLookupByLibrary.simpleMessage("删除此帖子？"),
      'describeAttachment': MessageLookupByLibrary.simpleMessage("描述此附件"),
      'description': MessageLookupByLibrary.simpleMessage("描述"),
      'didCopied': MessageLookupByLibrary.simpleMessage("DID 已复制到剪贴板"),
      'done': MessageLookupByLibrary.simpleMessage("完成"),
      'drafts': MessageLookupByLibrary.simpleMessage("草稿"),
      'editProfile': MessageLookupByLibrary.simpleMessage("编辑资料"),
      'emailNotifications': MessageLookupByLibrary.simpleMessage("邮件通知"),
      'faceTrackingUnavailable':
          MessageLookupByLibrary.simpleMessage("此设备不支持人脸跟踪。"),
      'followers': MessageLookupByLibrary.simpleMessage("粉丝"),
      'following': MessageLookupByLibrary.simpleMessage("关注"),
      'forgotPassword': MessageLookupByLibrary.simpleMessage("忘记密码？"),
      'guidesAndAnswers': MessageLookupByLibrary.simpleMessage("指南与常见问题解答"),
      'handle': MessageLookupByLibrary.simpleMessage("用户名"),
      'helpCentre': MessageLookupByLibrary.simpleMessage("帮助中心"),
      'helpAndSupport': MessageLookupByLibrary.simpleMessage("帮助与支持"),
      'inOneLine': MessageLookupByLibrary.simpleMessage("一句话"),
      'itDisappearsForBoth': MessageLookupByLibrary.simpleMessage("你们双方都会看不到。"),
      'itWillBeRemoved': MessageLookupByLibrary.simpleMessage("它将从讨论串中移除。"),
      'keepEditing': MessageLookupByLibrary.simpleMessage("继续编辑"),
      'kyron': MessageLookupByLibrary.simpleMessage("Kyron"),
      'lagosDesign': MessageLookupByLibrary.simpleMessage("Lagos Design"),
      'leave': MessageLookupByLibrary.simpleMessage("离开"),
      'leaveCommunity': (Object communityName) => "要退出 ${communityName} 吗？",
      'letBackIn': MessageLookupByLibrary.simpleMessage("允许重新加入"),
      'loadMore': MessageLookupByLibrary.simpleMessage("加载更多"),
      'logCleared': MessageLookupByLibrary.simpleMessage("日志已清空"),
      'logCopied': MessageLookupByLibrary.simpleMessage("日志已复制"),
      'logIn': MessageLookupByLibrary.simpleMessage("登录"),
      'logOut': MessageLookupByLibrary.simpleMessage("退出登录"),
      'logOutQuestion': MessageLookupByLibrary.simpleMessage("退出登录？"),
      'message': MessageLookupByLibrary.simpleMessage("私信"),
      'mute': MessageLookupByLibrary.simpleMessage("静音"),
      'mutedAndBlocked': MessageLookupByLibrary.simpleMessage("已静音和已拉黑"),
      'mutedWordsAndTags': MessageLookupByLibrary.simpleMessage("已屏蔽的词和标签"),
      'name': MessageLookupByLibrary.simpleMessage("姓名"),
      'nameScreen': MessageLookupByLibrary.simpleMessage("<name> 页面"),
      'newEmailAddress': MessageLookupByLibrary.simpleMessage("新的邮箱地址"),
      'newPassword': MessageLookupByLibrary.simpleMessage("新密码"),
      'newPost': MessageLookupByLibrary.simpleMessage("新帖"),
      'nothingToCopy': MessageLookupByLibrary.simpleMessage("没有可复制的内容"),
      'notifications': MessageLookupByLibrary.simpleMessage("通知"),
      'notNow': MessageLookupByLibrary.simpleMessage("暂不"),
      'notSentTapRetry': MessageLookupByLibrary.simpleMessage("未发送。点按重试"),
      'openInBrowser': MessageLookupByLibrary.simpleMessage("在浏览器中打开"),
      'pageNotFound': MessageLookupByLibrary.simpleMessage("未找到页面"),
      'pickYourInterests': MessageLookupByLibrary.simpleMessage("选择你的兴趣"),
      'post': MessageLookupByLibrary.simpleMessage("发布"),
      'postAnalytics': MessageLookupByLibrary.simpleMessage("帖子数据"),
      'postInCommunity': (Object communityName) => "在 ${communityName} 中发帖",
      'postTextCopied': MessageLookupByLibrary.simpleMessage("帖子文本已复制"),
      'profileUpdated': MessageLookupByLibrary.simpleMessage("个人资料已更新"),
      'pushNotifications': MessageLookupByLibrary.simpleMessage("推送通知"),
      'quote': MessageLookupByLibrary.simpleMessage("引用"),
      'quotePost': MessageLookupByLibrary.simpleMessage("引用帖子"),
      'reachAPerson': MessageLookupByLibrary.simpleMessage("联系真人"),
      'remove': MessageLookupByLibrary.simpleMessage("移除"),
      'removeMember': (Object memberName) => "移除 ${memberName}？",
      'removeConversation': MessageLookupByLibrary.simpleMessage("移除此对话？"),
      'removeMessage': MessageLookupByLibrary.simpleMessage("移除此消息？"),
      'repliesFollowsMentions':
          MessageLookupByLibrary.simpleMessage("回复、关注与提及"),
      'reply': MessageLookupByLibrary.simpleMessage("回复"),
      'report': MessageLookupByLibrary.simpleMessage("举报"),
      'reportCopied':
          MessageLookupByLibrary.simpleMessage("报告已复制。粘贴到发送给支持的邮件中。"),
      'reportSent': MessageLookupByLibrary.simpleMessage("已发送报告"),
      'repost': MessageLookupByLibrary.simpleMessage("转发"),
      'reset': MessageLookupByLibrary.simpleMessage("重置"),
      'resetPassword': MessageLookupByLibrary.simpleMessage("重置你的密码"),
      'retry': MessageLookupByLibrary.simpleMessage("重试"),
      'save': MessageLookupByLibrary.simpleMessage("保存"),
      'saveDraft': MessageLookupByLibrary.simpleMessage("保存草稿"),
      'saySomething': (Object communityName) => "对 ${communityName} 说点什么",
      'searchByNameOrHandle': MessageLookupByLibrary.simpleMessage("按姓名或用户名搜索"),
      'searchCommunities': MessageLookupByLibrary.simpleMessage("搜索社区"),
      'searchGIFs': MessageLookupByLibrary.simpleMessage("搜索 GIF"),
      'searchLanguages': MessageLookupByLibrary.simpleMessage("搜索语言"),
      'searchTrendingTags': MessageLookupByLibrary.simpleMessage("搜索热门标签"),
      'securityAlerts': MessageLookupByLibrary.simpleMessage("安全提醒与账户变更"),
      'sendConfirmation': MessageLookupByLibrary.simpleMessage("发送确认"),
      'sendErrorReport': MessageLookupByLibrary.simpleMessage("发送错误报告"),
      'sendFeedback': MessageLookupByLibrary.simpleMessage("发送反馈"),
      'sendReport': MessageLookupByLibrary.simpleMessage("发送报告"),
      'sendToSupport': MessageLookupByLibrary.simpleMessage("发送给支持"),
      'serviceStatus': MessageLookupByLibrary.simpleMessage("服务状态"),
      'shareAppLog': MessageLookupByLibrary.simpleMessage("将应用日志分享给支持"),
      'signedInAs': MessageLookupByLibrary.simpleMessage("登录身份："),
      'signInToKyron': MessageLookupByLibrary.simpleMessage("登录 Kyron"),
      'signupFailed': (Object error) => "注册失败：${error}",
      'stay': MessageLookupByLibrary.simpleMessage("留下"),
      'systemLog': MessageLookupByLibrary.simpleMessage("系统日志"),
      'tellMissingBroken':
          MessageLookupByLibrary.simpleMessage("告诉我们缺了什么或哪里有问题"),
      'theComposerNoPostButton':
          MessageLookupByLibrary.simpleMessage("编辑器没有“发布”按钮"),
      'translate': MessageLookupByLibrary.simpleMessage("翻译"),
      'tryAgain': MessageLookupByLibrary.simpleMessage("重试"),
      'undoRepost': MessageLookupByLibrary.simpleMessage("撤销转发"),
      'updatePassword': MessageLookupByLibrary.simpleMessage("更新密码"),
      'useDifferentAddress': MessageLookupByLibrary.simpleMessage("使用其他地址"),
      'whatHappened': MessageLookupByLibrary.simpleMessage("发生了什么"),
      'whatHappenedAndLookAt':
          MessageLookupByLibrary.simpleMessage("发生了什么，需要我们查看哪些内容？"),
      'whatInPicture': MessageLookupByLibrary.simpleMessage("这张图片里有什么？"),
      'whatIsItFor': MessageLookupByLibrary.simpleMessage("用途是什么？（可选）"),
      'whatYouDid': MessageLookupByLibrary.simpleMessage("你做了什么、期望什么、实际发生了什么"),
      'whatYouWereDoing': MessageLookupByLibrary.simpleMessage("发生时你在做什么。"),
      'normalised': MessageLookupByLibrary.simpleMessage("#\\\$normalised"),
      'postItSayItShowIt': MessageLookupByLibrary.simpleMessage("发出来，说出来，秀出来。"),
      'textVoiceVideoPeopleRooms':
          MessageLookupByLibrary.simpleMessage("文字、语音与视频，创作它们的人，以及他们交流的房间。"),
      'alreadyOnKyron': MessageLookupByLibrary.simpleMessage("已经在 Kyron 上？"),
      'byContinuingAgreeTermsPrivacy':
          MessageLookupByLibrary.simpleMessage("继续即表示你同意我们的服务条款和隐私政策"),
      'googleSignInNeedsPhoneApp':
          MessageLookupByLibrary.simpleMessage("Google 登录需要手机应用"),
      'googleSignInDesktopExplanation': (Object platform) =>
          "Google 通过仅 Android 和 iOS 能响应的链接把完成的登录交回 Kyron，因此在 ${platform} 上，浏览器将无处可返回。\\n\\n如果你已经用 Google 在 Kyron 上有账户，请用相同地址选择“使用邮箱继续”，然后点“忘记密码”——我们会给你发一封设置密码的链接。",
      'loginFailed': MessageLookupByLibrary.simpleMessage("登录失败。请检查你的凭据。"),
      'email': MessageLookupByLibrary.simpleMessage("邮箱"),
      'password': MessageLookupByLibrary.simpleMessage("密码"),
      'login': MessageLookupByLibrary.simpleMessage("登录"),
      'or': MessageLookupByLibrary.simpleMessage("或"),
      'username': MessageLookupByLibrary.simpleMessage("用户名"),
      'usernameRule':
          MessageLookupByLibrary.simpleMessage("用户名必须为小写（a-z、0-9、_）"),
      'passwordTooShort': MessageLookupByLibrary.simpleMessage("密码过短"),
      'continueAction': MessageLookupByLibrary.simpleMessage("继续"),
      'bySigningUpAgreeTerms':
          MessageLookupByLibrary.simpleMessage("注册即表示你同意我们的"),
      'terms': MessageLookupByLibrary.simpleMessage("服务条款"),
      'and': MessageLookupByLibrary.simpleMessage("和"),
      'privacyPolicy': MessageLookupByLibrary.simpleMessage("隐私政策"),
      'googleSignIn': MessageLookupByLibrary.simpleMessage("使用 Google 登录"),
      'googleSignUp': MessageLookupByLibrary.simpleMessage("使用 Google 注册"),
      'googleContinue': MessageLookupByLibrary.simpleMessage("使用 Google 继续"),
      'byContinuingAgreeTerms':
          MessageLookupByLibrary.simpleMessage("继续即表示你同意我们的"),
      'literalwhetherKyronIsReachableRightNow':
          MessageLookupByLibrary.simpleMessage("Kyron 现在是否可达"),
      'literalwhatThisAppHasBeenDoing':
          MessageLookupByLibrary.simpleMessage("此应用最近在做什么"),
      'literalshareTheLogWithSupport':
          MessageLookupByLibrary.simpleMessage("将日志分享给支持"),
      'literalclearCache': MessageLookupByLibrary.simpleMessage("清除缓存"),
      'literalappVersion': MessageLookupByLibrary.simpleMessage("应用版本"),
      'literalreading': MessageLookupByLibrary.simpleMessage("读取中…"),
      'literalcheckAgain': MessageLookupByLibrary.simpleMessage("重新检查"),
      'literalkyronDidNotAnswer':
          MessageLookupByLibrary.simpleMessage("Kyron 未响应"),
      'literalnothingLoggedYet': MessageLookupByLibrary.simpleMessage("尚无日志"),
      'literalswitchCamera': MessageLookupByLibrary.simpleMessage("切换摄像头"),
      'literaltheCameraIsClosed':
          MessageLookupByLibrary.simpleMessage("摄像头已关闭"),
      'literaltakeAPicture': MessageLookupByLibrary.simpleMessage("拍照"),
      'literallensNameFaceLens': (dynamic lens) => "${lens.name}，人脸镜头",
      'literalcouldNotPostThatReply':
          MessageLookupByLibrary.simpleMessage("无法发布该回复。"),
      'literalcouldNotLoadThisReply':
          MessageLookupByLibrary.simpleMessage("无法加载此回复"),
      'literalthisReplyIsGone': MessageLookupByLibrary.simpleMessage("该回复已不存在"),
      'literaladdAPhoto': MessageLookupByLibrary.simpleMessage("添加照片"),
      'literaladdAClip': MessageLookupByLibrary.simpleMessage("添加短片"),
      'literalstartACommunity': MessageLookupByLibrary.simpleMessage("创建社区"),
      'literalcouldNotLoadYourCommunities':
          MessageLookupByLibrary.simpleMessage("无法加载你的社区"),
      'literalyouAreNotInAnyCommunities':
          MessageLookupByLibrary.simpleMessage("你尚未加入任何社区"),
      'literalcouldNotLoadCommunities':
          MessageLookupByLibrary.simpleMessage("无法加载社区"),
      'literalpostInWidgetCommunityName': (dynamic widget) =>
          "在 ${widget.community.name} 中发帖",
      'literalsaySomethingToWidgetCommunityName': (dynamic widget) =>
          "对 ${widget.community.name} 说点什么",
      'literaltagSomeone': MessageLookupByLibrary.simpleMessage("提及某人"),
      'literalcloseWidgetCommunityName': (dynamic widget) =>
          "要关闭 ${widget.community.name} 吗？",
      'literalonlyTheOwnerCanChangeThis':
          MessageLookupByLibrary.simpleMessage("只有所有者可以更改此项"),
      'literaltapTheBannerOrThePictureToChangeIt':
          MessageLookupByLibrary.simpleMessage("点按横幅或图片以更换"),
      'literalremoveMemberDisplayname': (dynamic member) =>
          "移除 ${member.displayName}？",
      'literalcouldNotLoadTheMembers':
          MessageLookupByLibrary.simpleMessage("无法加载成员列表"),
      'literalnobodyHereYet': MessageLookupByLibrary.simpleMessage("这里还没有人"),
      'literalmakeAModerator': MessageLookupByLibrary.simpleMessage("设为版主"),
      'literalremoveAsModerator': MessageLookupByLibrary.simpleMessage("取消版主"),
      'literalremoveFromCommunity':
          MessageLookupByLibrary.simpleMessage("从社区移除"),
      'literalcouldNotLoadThisList':
          MessageLookupByLibrary.simpleMessage("无法加载此列表"),
      'literalnobodyHasBeenRemoved':
          MessageLookupByLibrary.simpleMessage("尚未移除任何人"),
      'literalpostInCommunityName': (dynamic community) =>
          "在 ${community.name} 中发帖",
      'literalcouldNotOpenThisCommunity':
          MessageLookupByLibrary.simpleMessage("无法打开此社区"),
      'literalthisCommunity': MessageLookupByLibrary.simpleMessage("此社区"),
      'literalshareThisCommunity':
          MessageLookupByLibrary.simpleMessage("分享此社区"),
      'literalcopyLink': MessageLookupByLibrary.simpleMessage("复制链接"),
      'literallinkCopied': MessageLookupByLibrary.simpleMessage("链接已复制"),
      'literalleaveCommunityName': (dynamic community) =>
          "要退出 ${community.name} 吗？",
      'literalyouHaveLeftCommunityName': (dynamic community) =>
          "你已退出 ${community.name}",
      'literaladdAVideo': MessageLookupByLibrary.simpleMessage("添加视频"),
      'literaladdAGif': MessageLookupByLibrary.simpleMessage("添加 GIF"),
      'literalrecordAVoicePost': MessageLookupByLibrary.simpleMessage("录制语音帖"),
      'literalremoveThePoll': MessageLookupByLibrary.simpleMessage("移除投票"),
      'literaladdAPoll': MessageLookupByLibrary.simpleMessage("添加投票"),
      'literaladdAHashtag': MessageLookupByLibrary.simpleMessage("添加话题标签"),
      'literaldraftSaved': MessageLookupByLibrary.simpleMessage("草稿已保存"),
      'literalnoDrafts': MessageLookupByLibrary.simpleMessage("暂无草稿"),
      'literalcouldNotLoadTrending':
          MessageLookupByLibrary.simpleMessage("无法加载趋势"),
      'literalnothingIsTrendingYet':
          MessageLookupByLibrary.simpleMessage("暂时没有热点"),
      'literalcouldNotLoadTopics':
          MessageLookupByLibrary.simpleMessage("无法加载话题"),
      'literalnoTopicsYet': MessageLookupByLibrary.simpleMessage("暂无话题"),
      'literalcouldNotLoadSuggestions':
          MessageLookupByLibrary.simpleMessage("无法加载推荐"),
      'literalnobodyLeftToSuggest':
          MessageLookupByLibrary.simpleMessage("没有更多可推荐的人"),
      'literalyouExampleCom':
          MessageLookupByLibrary.simpleMessage("you@example.com"),
      'literalsendTheLink': MessageLookupByLibrary.simpleMessage("发送链接"),
      'literalopenTheMailFromKyron':
          MessageLookupByLibrary.simpleMessage("打开来自 Kyron 的邮件"),
      'literaltapTheLinkInsideIt':
          MessageLookupByLibrary.simpleMessage("点开其中的链接"),
      'literalsetAPasswordAndCarryOn':
          MessageLookupByLibrary.simpleMessage("设置密码并继续"),
      'literalsendAgainInCooldownS': (Object _cooldown) =>
          "在 ${_cooldown}s 后可重发",
      'literalsendAgain': MessageLookupByLibrary.simpleMessage("再次发送"),
      'literalnormalised': (Object normalised) => "#$normalised",
      'literalcouldNotLoadYourMessages':
          MessageLookupByLibrary.simpleMessage("无法加载你的消息"),
      'literalnothingUnread': MessageLookupByLibrary.simpleMessage("暂无未读"),
      'literalnoMessagesYet': MessageLookupByLibrary.simpleMessage("还没有消息"),
      'literalnothingMuted': MessageLookupByLibrary.simpleMessage("暂无被静音的内容"),
      'literalnoLikesYet': MessageLookupByLibrary.simpleMessage("还没有点赞"),
      'literalnoRepliesYet': MessageLookupByLibrary.simpleMessage("还没有回复"),
      'literalnoNewFollowers': MessageLookupByLibrary.simpleMessage("暂无新粉丝"),
      'literalnoRepostsYet': MessageLookupByLibrary.simpleMessage("还没有转发"),
      'literalyouAreAllCaughtUp':
          MessageLookupByLibrary.simpleMessage("你已全部看完"),
      'literalcouldNotLoadNotifications':
          MessageLookupByLibrary.simpleMessage("无法加载通知"),
      'literalcoverPhoto': MessageLookupByLibrary.simpleMessage("封面照片"),
      'literalchooseFromGallery': MessageLookupByLibrary.simpleMessage("从相册选择"),
      'literaluseOneOfOurs': MessageLookupByLibrary.simpleMessage("使用一张系统图片"),
      'literaltapToAddAPhotoAndACover':
          MessageLookupByLibrary.simpleMessage("点按添加头像和封面"),
      'literalnoInterestsYet': MessageLookupByLibrary.simpleMessage("暂无兴趣"),
      'literaldiscoverPeople': MessageLookupByLibrary.simpleMessage("发现用户"),
      'literalcancelReply': MessageLookupByLibrary.simpleMessage("取消回复"),
      'literalcouldNotLoadThisPost':
          MessageLookupByLibrary.simpleMessage("无法加载此帖子"),
      'literalshareThisProfile':
          MessageLookupByLibrary.simpleMessage("分享此个人资料"),
      'literalcouldNotLoadThesePosts':
          MessageLookupByLibrary.simpleMessage("无法加载这些帖子"),
      'literalyouHaveNotPostedYet':
          MessageLookupByLibrary.simpleMessage("你还没有发过帖"),
      'literalnoPostsYet': MessageLookupByLibrary.simpleMessage("暂无帖子"),
      'literalnothingToLookAtYet':
          MessageLookupByLibrary.simpleMessage("暂时没有可看的内容"),
      'literalkeepTyping': MessageLookupByLibrary.simpleMessage("继续输入"),
      'literalsearchFailed': MessageLookupByLibrary.simpleMessage("搜索失败"),
      'literalnothingMatched': MessageLookupByLibrary.simpleMessage("没有匹配项"),
      'literalcouldNotSignOutDescribeapierrorE': (Object describeApiError) =>
          "无法退出：${describeApiError}",
      'literalnoDidYet': MessageLookupByLibrary.simpleMessage("尚无 DID"),
      'literalpasswordLogin': MessageLookupByLibrary.simpleMessage("密码与登录"),
      'literalmutedAndBlockedAccounts':
          MessageLookupByLibrary.simpleMessage("已静音和已拉黑的账户"),
      'literalfontSize': MessageLookupByLibrary.simpleMessage("字体大小"),
      'literalpushNotifications': MessageLookupByLibrary.simpleMessage("推送通知"),
      'literaldataSaver': MessageLookupByLibrary.simpleMessage("省流量模式"),
      'literalcontactSupport': MessageLookupByLibrary.simpleMessage("联系支持"),
      'literalsendFeedback': MessageLookupByLibrary.simpleMessage("发送反馈"),
      'literalappLanguage': MessageLookupByLibrary.simpleMessage("应用语言"),
      'literalprimaryLanguage': MessageLookupByLibrary.simpleMessage("首选语言"),
      'literalcontentLanguages': MessageLookupByLibrary.simpleMessage("内容语言"),
      'literalremoveLanguageEnglishname': (dynamic language) =>
          "移除 ${language.englishName}",
      'literalsentItIsReportFiledNumber': (dynamic filed) =>
          "已发送。这是报告 #${filed.number}。",
      'literalfeedbackCannotBeSentRightNow':
          MessageLookupByLibrary.simpleMessage("当前无法发送反馈"),
      'literalwhatYouDidWhatYouExpectedWhatHappened':
          MessageLookupByLibrary.simpleMessage("你做了什么、期望什么、发生了什么 "),
      'literalverificationFailedDescribeapierrorE': (Object describeApiError) =>
          "验证失败：${describeApiError}",
      'literalverificationCodeResent':
          MessageLookupByLibrary.simpleMessage("已重新发送验证码。"),
      'literalverifyEmail': MessageLookupByLibrary.simpleMessage("验证邮箱"),
      'literalresendCode': MessageLookupByLibrary.simpleMessage("重发验证码"),
      'literalremoveThisConversation':
          MessageLookupByLibrary.simpleMessage("移除此对话"),
      'literalmutedYouWillNotBeNotified':
          MessageLookupByLibrary.simpleMessage("已静音。你将不会收到通知。"),
      'literalblockThisAccount': MessageLookupByLibrary.simpleMessage("拉黑此账户？"),
      'literalyouAreSignedOut': MessageLookupByLibrary.simpleMessage("你已退出登录。"),
      'literalcouldNotLoadThisConversation':
          MessageLookupByLibrary.simpleMessage("无法加载此对话"),
      'literalsaySomething': MessageLookupByLibrary.simpleMessage("说点什么"),
      'literalcopyText': MessageLookupByLibrary.simpleMessage("复制文本"),
      'literaldoNotReply': MessageLookupByLibrary.simpleMessage("请勿回复"),
      'literalremoveFromSaved': MessageLookupByLibrary.simpleMessage("从已保存中移除"),
      'literalturnSoundOn': MessageLookupByLibrary.simpleMessage("打开声音"),
      'literalturnSoundOff': MessageLookupByLibrary.simpleMessage("关闭声音"),
      'literalthatLinkIsNotOneThisCanOpen':
          MessageLookupByLibrary.simpleMessage("此链接无法在这里打开。"),
      'literalnoBrowserOnThisDeviceTookThatLink':
          MessageLookupByLibrary.simpleMessage("此设备上没有浏览器能处理该链接。"),
      'literalopenReply': MessageLookupByLibrary.simpleMessage("打开回复"),
      'literallabelCount': (Object label, Object count) => "$label，$count",
      'literalindex1': (dynamic index) => "${index + 1}",
      'literalfirstyearIndex': (dynamic _firstYear) => "${_firstYear}",
      'literalgifsAreNotSetUp':
          MessageLookupByLibrary.simpleMessage("GIF 功能尚未设置"),
      'literalcouldNotLoadGifs':
          MessageLookupByLibrary.simpleMessage("无法加载 GIF"),
      'literalnothingFound': MessageLookupByLibrary.simpleMessage("未找到任何内容"),
      'literalthatGifCouldNotBeDownloaded':
          MessageLookupByLibrary.simpleMessage("无法下载该 GIF。"),
      'literaladdAnInterest': MessageLookupByLibrary.simpleMessage("添加兴趣"),
      'literalcouldNotLoadTrendingTags':
          MessageLookupByLibrary.simpleMessage("无法加载热门标签"),
      'literalnoTrendingTagMatchesThat':
          MessageLookupByLibrary.simpleMessage("没有匹配的热门标签"),
      'literalyouAlreadyFollowEveryTrendingTag':
          MessageLookupByLibrary.simpleMessage("你已关注所有热门标签"),
      'literalremoveLabel': (Object label) => "移除 $label",
      'literaladdLabelAsATab': (Object label) => "将 $label 添加为标签页",
      'literalcouldNotSearch': MessageLookupByLibrary.simpleMessage("无法搜索"),
      'literalwhoDoYouWantToTag':
          MessageLookupByLibrary.simpleMessage("你想提及谁？"),
      'literalnobodyFound': MessageLookupByLibrary.simpleMessage("未找到任何人"),
      'literalshowPassword': MessageLookupByLibrary.simpleMessage("显示密码"),
      'literalhidePassword': MessageLookupByLibrary.simpleMessage("隐藏密码"),
      'literaltranslatePost': MessageLookupByLibrary.simpleMessage("翻译帖子"),
      'literalcopyPostText': MessageLookupByLibrary.simpleMessage("复制帖子文本"),
      'literalcopyLinkToPost': MessageLookupByLibrary.simpleMessage("复制帖子链接"),
      'literalshowMorePostsLikeThis':
          MessageLookupByLibrary.simpleMessage("显示更多类似的帖子"),
      'literalnotInterestedInThis':
          MessageLookupByLibrary.simpleMessage("对此不感兴趣"),
      'literalhidesItAndTellsUsToShowFewerLikeIt':
          MessageLookupByLibrary.simpleMessage("将其隐藏，并提示我们少展示类似内容"),
      'literalhideThisPost': MessageLookupByLibrary.simpleMessage("隐藏此帖子"),
      'literalmuteThisThread':
          MessageLookupByLibrary.simpleMessage("将此讨论串设为静音"),
      'literalstopSeeingThisPostAndRepliesToIt':
          MessageLookupByLibrary.simpleMessage("不再看到此帖及其回复"),
      'literalmuteWordsOrTags': MessageLookupByLibrary.simpleMessage("屏蔽词语或标签"),
      'literalviewersLikesSavesAndComments':
          MessageLookupByLibrary.simpleMessage("浏览、点赞、收藏和评论"),
      'literalwhoCanReply': MessageLookupByLibrary.simpleMessage("谁可以回复"),
      'literaldeletePost': MessageLookupByLibrary.simpleMessage("删除帖子"),
      'literalmuteAuthor': (Object author) => "静音 $author",
      'literalblockAuthor': (Object author) => "拉黑 $author",
      'literalreportPost': MessageLookupByLibrary.simpleMessage("举报帖子"),
      'literalreportAuthor': (Object author) => "举报 $author",
      'literalthatDidNotGoThroughTryAgain':
          MessageLookupByLibrary.simpleMessage("未成功发送。请重试。"),
      'literalblockAuthor2': (Object author) => "要拉黑 $author 吗？",
      'literalshowResults': MessageLookupByLibrary.simpleMessage("显示结果"),
      'literallabelDate': (Object label) => "\\\$label 日期",
      'literalshareVia': MessageLookupByLibrary.simpleMessage("通过…分享"),
      'literalhandItToAnotherApp':
          MessageLookupByLibrary.simpleMessage("交给其他应用处理"),
      'literalshareWithAQuote': MessageLookupByLibrary.simpleMessage("带引用分享"),
      'literalpostItWithYourOwnWordsAboveIt':
          MessageLookupByLibrary.simpleMessage("在上方加上你的话后发布"),
      'literalsavedPosts': MessageLookupByLibrary.simpleMessage("已保存的帖子"),
      'literallikedPosts': MessageLookupByLibrary.simpleMessage("点赞的帖子"),
      'literalstoriesRibbonStoriesLengthItems': (dynamic stories) =>
          "故事栏，共 ${stories.length} 项",
      'literalwhatYouPostIsYours':
          MessageLookupByLibrary.simpleMessage("你发布的内容归你所有"),
      'literalwhatKyronKeeps':
          MessageLookupByLibrary.simpleMessage("Kyron 保留哪些内容"),
      'literalhowToBehave': MessageLookupByLibrary.simpleMessage("行为规范"),
      'literalcloseTabLabel': (dynamic tab) => "关闭 ${tab.label}",
      'literal1PageOpen': MessageLookupByLibrary.simpleMessage("已打开 1 个页面"),
      'literalcountPagesOpen': (Object count) => "已打开 $count 个页面",
      'literalstopLoading': MessageLookupByLibrary.simpleMessage("停止加载"),
      'literalshareThisPage': MessageLookupByLibrary.simpleMessage("分享此页面"),
      'literalnoAppOnThisDeviceOpensUriSchemeLinks': (dynamic uri) =>
          "此设备上没有应用可打开 ${uri.scheme} 链接。",
      'literalcloseTheBrowser': MessageLookupByLibrary.simpleMessage("关闭浏览器"),
      'literalcloseAllPages': MessageLookupByLibrary.simpleMessage("关闭所有页面"),
      'literalremoveThisPoll': MessageLookupByLibrary.simpleMessage("移除此投票"),
      'literalremoveThisAnswer': MessageLookupByLibrary.simpleMessage("移除此答案"),
      'literalstartRecording': MessageLookupByLibrary.simpleMessage("开始录音"),
      'literalrecordAgain': MessageLookupByLibrary.simpleMessage("重新录制"),
      'home': MessageLookupByLibrary.simpleMessage("首页"),
      'explore': MessageLookupByLibrary.simpleMessage("发现"),
      'communities': MessageLookupByLibrary.simpleMessage("社区"),
      'messages': MessageLookupByLibrary.simpleMessage("消息"),
      'languages': MessageLookupByLibrary.simpleMessage("语言"),
      'selectAppLanguage': MessageLookupByLibrary.simpleMessage("选择用于应用界面的语言。"),
      'selectPrimaryLanguage':
          MessageLookupByLibrary.simpleMessage("选择你在信息流中偏好的翻译语言。"),
      'selectContentLanguages':
          MessageLookupByLibrary.simpleMessage("选择你希望订阅内容包含的语言。如未选择，将显示所有语言。"),
      'kyronWordsStillBeingTranslated':
          MessageLookupByLibrary.simpleMessage("Kyron 的文案仍在翻译中，所以目前大多数界面仍为英文。"),
      'hashtagsEmptyDetail':
          MessageLookupByLibrary.simpleMessage("当大家开始使用这些标签时，它们会出现在这里。"),
      'topicsEmptyDetail':
          MessageLookupByLibrary.simpleMessage("话题由 Kyron 设置，目前还没有。稍后再来看看。"),
      'peopleEmptyDetail':
          MessageLookupByLibrary.simpleMessage("你已关注 Kyron 会推荐的所有人。"),
      'communitiesEmptyDetail':
          MessageLookupByLibrary.simpleMessage("去“发现”找一个，或创建你自己的。"),
      'messagesCaughtUp': MessageLookupByLibrary.simpleMessage("所有会话都已同步。"),
      'messagesNoMessages':
          MessageLookupByLibrary.simpleMessage("打开某人的资料并点“私信”开始对话。"),
      'notificationLikesDetail':
          MessageLookupByLibrary.simpleMessage("有人给你的帖子点赞时，会显示在这里。"),
      'notificationRepliesDetail':
          MessageLookupByLibrary.simpleMessage("对你帖子的新回复会出现在这里。"),
      'notificationFollowersDetail':
          MessageLookupByLibrary.simpleMessage("关注你的人会出现在这里。"),
      'notificationRepostsDetail':
          MessageLookupByLibrary.simpleMessage("有人转发你时，会显示在这里。"),
      'notificationEmptyDetail':
          MessageLookupByLibrary.simpleMessage("点赞、回复和新粉丝抵达时会出现在这里。"),
      'gettingHelp': MessageLookupByLibrary.simpleMessage("获取帮助"),
      'send': MessageLookupByLibrary.simpleMessage("发送"),
      'close': MessageLookupByLibrary.simpleMessage("关闭"),
      'search': MessageLookupByLibrary.simpleMessage("搜索"),
      'settings': MessageLookupByLibrary.simpleMessage("设置"),
      'menu': MessageLookupByLibrary.simpleMessage("菜单"),
      'clear': MessageLookupByLibrary.simpleMessage("清除"),
      'manage': MessageLookupByLibrary.simpleMessage("管理"),
      'join': MessageLookupByLibrary.simpleMessage("加入"),
      'video': MessageLookupByLibrary.simpleMessage("视频"),
      'contentLanguagesNotFilteringYet': MessageLookupByLibrary.simpleMessage(
          "帖子目前尚未带有语言标注，因此暂时无法据此过滤你的信息流。你的选择会被保留，待其生效。"),
      'addMoreLanguages': MessageLookupByLibrary.simpleMessage("添加更多语言…"),
      'translationNotBuiltYet': MessageLookupByLibrary.simpleMessage(
          "翻译功能尚未上线。你信息流中的内容今天不会被翻译；我们会记住你的选择，待功能可用时生效。"),
      'supportEarlyExplanation': MessageLookupByLibrary.simpleMessage(
          "Kyron 仍处于早期阶段，最快联系到能真正解决问题的人的方式是提交 issue。请包含你在做什么以及实际发生了什么。"),
      'supportInboxNotYet': MessageLookupByLibrary.simpleMessage(
          "暂未提供应用内支持收件箱，所以此页面会指向真正有人看的地方，而不是一个没有人处理的表单。"),
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
      'ui_communities': MessageLookupByLibrary.simpleMessage("Communities"),
      'ui_settings': MessageLookupByLibrary.simpleMessage("Settings"),
      'ui_appearance': MessageLookupByLibrary.simpleMessage("Appearance"),
      'ui_language': MessageLookupByLibrary.simpleMessage("Language"),
      'ui_account': MessageLookupByLibrary.simpleMessage("Account"),
      'ui_content_display':
          MessageLookupByLibrary.simpleMessage("Content & Display"),
      'ui_app_device': MessageLookupByLibrary.simpleMessage("App & Device"),
      'ui_terms': MessageLookupByLibrary.simpleMessage("Terms"),
      'ui_privacy': MessageLookupByLibrary.simpleMessage("Privacy"),
      'ui_help': MessageLookupByLibrary.simpleMessage("Help"),
      'ui_feedback': MessageLookupByLibrary.simpleMessage("Feedback"),
      'ui_decentralized_id':
          MessageLookupByLibrary.simpleMessage("Decentralized ID"),
      'ui_find_people_on_kyron':
          MessageLookupByLibrary.simpleMessage("Find people on Kyron"),
      'ui_search_everything_posted':
          MessageLookupByLibrary.simpleMessage("Search everything posted"),
      'ui_search_by_handle_or_display_name':
          MessageLookupByLibrary.simpleMessage(
              "Search by handle or display name."),
      'ui_words_or_filter': MessageLookupByLibrary.simpleMessage(
          "Words, or a filter — an account, a date range, or what a post carries."),
      'ui_two_characters_or_more':
          MessageLookupByLibrary.simpleMessage("Two characters or more."),
      'ui_no_posts_match_filters':
          MessageLookupByLibrary.simpleMessage("No posts match those filters."),
      'ui_search_clear': MessageLookupByLibrary.simpleMessage("Clear"),
      'ui_search_filters': MessageLookupByLibrary.simpleMessage("Filters"),
      'ui_post_text_copied':
          MessageLookupByLibrary.simpleMessage("Post text copied"),
      'ui_link_copied': MessageLookupByLibrary.simpleMessage("Link copied"),
      'ui_interest_noted': MessageLookupByLibrary.simpleMessage(
          "Noted. This helps shape what you are shown."),
      'ui_posts_hidden': MessageLookupByLibrary.simpleMessage(
          "Hidden. We will show you fewer like it."),
      'ui_post_hidden': MessageLookupByLibrary.simpleMessage("Post hidden"),
      'ui_thread_muted': MessageLookupByLibrary.simpleMessage("Thread muted"),
      'ui_post_deleted': MessageLookupByLibrary.simpleMessage("Post deleted"),
      'ui_post_delete_detail': MessageLookupByLibrary.simpleMessage(
          "It is removed from your profile and from everyone else's feed. Replies to it go with it."),
      'ui_block_detail': MessageLookupByLibrary.simpleMessage(
          "Neither of you will see the other on Kyron, and any follow between you is removed. They are not told."),
      'ui_mute_detail': MessageLookupByLibrary.simpleMessage(
          "You will stop seeing their posts. They are not told."),
      'ui_about_terms_of_service':
          MessageLookupByLibrary.simpleMessage("Terms of Service"),
      'ui_about_privacy_policy':
          MessageLookupByLibrary.simpleMessage("Privacy Policy"),
      'ui_settings_profile_contact': MessageLookupByLibrary.simpleMessage(
          "Your profile and contact information"),
      'ui_settings_security':
          MessageLookupByLibrary.simpleMessage("Security settings"),
      'ui_settings_muted_blocked':
          MessageLookupByLibrary.simpleMessage("Who you have muted or blocked"),
      'ui_settings_content_display':
          MessageLookupByLibrary.simpleMessage("Content & Display"),
      'ui_settings_app_device':
          MessageLookupByLibrary.simpleMessage("App & Device"),
      'ui_settings_data_saver':
          MessageLookupByLibrary.simpleMessage("Data Saver"),
      'ui_settings_language_detail':
          MessageLookupByLibrary.simpleMessage("Choose your language"),
      'ui_settings_notifications_detail':
          MessageLookupByLibrary.simpleMessage("Notification preferences"),
      'ui_settings_help_articles':
          MessageLookupByLibrary.simpleMessage("Browse help articles"),
      'ui_settings_team_help':
          MessageLookupByLibrary.simpleMessage("Get help from our team"),
      'ui_settings_feedback_detail':
          MessageLookupByLibrary.simpleMessage("Tell us what you think"),
      'ui_could_not_load_profile':
          MessageLookupByLibrary.simpleMessage("Could not load your profile"),
      'ui_search_people': MessageLookupByLibrary.simpleMessage("Search people"),
      'ui_search_posts': MessageLookupByLibrary.simpleMessage("Search posts"),
      'ui_this_post': MessageLookupByLibrary.simpleMessage("this post"),
      'authorPostsHidden': (Object author) =>
          'You will not see posts from $author',
      'authorBlocked': (Object author) => '$author blocked',
      'nothingMatchesQuery': (Object what) =>
          'Nothing on Kyron matches "$what"',
      'repliesPolicy': (Object policy) => 'Replies: $policy',
      'ui_preferences': MessageLookupByLibrary.simpleMessage("Preferences"),
      'ui_appearance_detail': MessageLookupByLibrary.simpleMessage(
          "Light, dark, or whatever the phone is set to"),
      'ui_legal': MessageLookupByLibrary.simpleMessage("Legal"),
      'ui_diagnostics': MessageLookupByLibrary.simpleMessage("Diagnostics"),
      'ui_saved_posts': MessageLookupByLibrary.simpleMessage("Saved posts"),
      'ui_liked_posts': MessageLookupByLibrary.simpleMessage("Liked posts"),
      'ui_nothing_saved_yet':
          MessageLookupByLibrary.simpleMessage("Nothing saved yet"),
      'ui_no_likes_yet': MessageLookupByLibrary.simpleMessage("No likes yet"),
      'ui_saved_posts_detail': MessageLookupByLibrary.simpleMessage(
          "Tap the archive icon on any post to keep it here. Only you can see what you save."),
      'ui_liked_posts_detail': MessageLookupByLibrary.simpleMessage(
          "Posts you like show up here, most recent first."),
      'ui_could_not_load_saved_posts': MessageLookupByLibrary.simpleMessage(
          "Could not load your saved posts"),
      'ui_could_not_load_liked_posts': MessageLookupByLibrary.simpleMessage(
          "Could not load your liked posts"),
      'feedTagDetail': (Object tab) =>
          'Nothing has been posted under #$tab yet.',
      'ui_feed_following_empty': MessageLookupByLibrary.simpleMessage(
          "Nothing from the people you follow"),
      'ui_feed_videos_empty':
          MessageLookupByLibrary.simpleMessage("No videos yet"),
      'ui_feed_empty': MessageLookupByLibrary.simpleMessage("Nothing here yet"),
      'ui_feed_following_detail': MessageLookupByLibrary.simpleMessage(
          "Follow a few accounts and their posts will show up here."),
      'ui_feed_videos_detail': MessageLookupByLibrary.simpleMessage(
          "Posts carrying a clip will show up here."),
      'ui_feed_for_you_detail': MessageLookupByLibrary.simpleMessage(
          "Posts will show up here as people write them."),
      'ui_could_not_load_feed':
          MessageLookupByLibrary.simpleMessage("Could not load your feed"),
      'ui_share_this_post':
          MessageLookupByLibrary.simpleMessage("Share this post"),
      'analytics_distinct_people_not_opens':
          MessageLookupByLibrary.simpleMessage("不同的人数，而不是打开次数"),
      'analytics_engagement': MessageLookupByLibrary.simpleMessage("互动"),
      'analytics_posted': MessageLookupByLibrary.simpleMessage("发布时间"),
      'analytics_viewers': MessageLookupByLibrary.simpleMessage("查看者"),
      'analytics_likes': MessageLookupByLibrary.simpleMessage("喜欢"),
      'analytics_comments': MessageLookupByLibrary.simpleMessage("评论"),
      'analytics_saves': MessageLookupByLibrary.simpleMessage("收藏"),
      'analytics_no_viewers_yet':
          MessageLookupByLibrary.simpleMessage("还没有查看者"),
      'analytics_viewers_per_day':
          MessageLookupByLibrary.simpleMessage("每日查看者"),
      'analytics_nobody_opened_post':
          MessageLookupByLibrary.simpleMessage("还没有人打开过这篇帖子。"),
      'reply_who_can_reply': MessageLookupByLibrary.simpleMessage("谁可以回复？"),
      'reply_anyone_can_see':
          MessageLookupByLibrary.simpleMessage("任何人仍然可以查看、转发和引用这篇帖子。"),
      'reply_anyone': MessageLookupByLibrary.simpleMessage("任何人都可以互动"),
      'reply_anyone_detail':
          MessageLookupByLibrary.simpleMessage("Kyron 上的任何人都可以回复这篇帖子。"),
      'reply_followers': MessageLookupByLibrary.simpleMessage("关注你的人"),
      'reply_followers_detail':
          MessageLookupByLibrary.simpleMessage("只有关注你的人可以回复这篇帖子。"),
      'reply_mentioned': MessageLookupByLibrary.simpleMessage("你提到的人"),
      'reply_mentioned_detail':
          MessageLookupByLibrary.simpleMessage("只有你在这篇帖子中 @提到的人可以回复。"),
      'reply_nobody': MessageLookupByLibrary.simpleMessage("没有人可以回复"),
      'reply_nobody_detail':
          MessageLookupByLibrary.simpleMessage("回复已关闭，但你仍然可以回复。"),
      'interest_for_you': MessageLookupByLibrary.simpleMessage("为你推荐"),
      'interest_following': MessageLookupByLibrary.simpleMessage("关注"),
      'interest_videos': MessageLookupByLibrary.simpleMessage("视频"),
      'interest_your_tabs': MessageLookupByLibrary.simpleMessage("你的标签页"),
      'interest_drag_to_reorder':
          MessageLookupByLibrary.simpleMessage("拖动以重新排序"),
      'interest_add': MessageLookupByLibrary.simpleMessage("添加兴趣"),
      'interest_trending_now': MessageLookupByLibrary.simpleMessage("当前趋势"),
      'interest_five_tabs_limit':
          MessageLookupByLibrary.simpleMessage("标签栏最多容纳五个标签页。移除一个即可添加另一个。"),
      'interest_hashtags_detail':
          MessageLookupByLibrary.simpleMessage("人们开始使用某个话题标签后，它会显示在这里。"),
      'composer_placeholder_rattling':
          MessageLookupByLibrary.simpleMessage("你脑海中在想什么？"),
      'composer_placeholder_say':
          MessageLookupByLibrary.simpleMessage("说点只有你能说的话……"),
      'composer_placeholder_hot_take':
          MessageLookupByLibrary.simpleMessage("分享一个大胆的观点（或温和一点的）"),
      'composer_placeholder_signal':
          MessageLookupByLibrary.simpleMessage("这是你的信号——发出去吧"),
      'composer_placeholder_think':
          MessageLookupByLibrary.simpleMessage("输入、说话，或把想法说出来"),
      'profile_tap_to_change': MessageLookupByLibrary.simpleMessage("点击更改"),
      'profile_display_name': MessageLookupByLibrary.simpleMessage("显示名称"),
      'profile_bio': MessageLookupByLibrary.simpleMessage("简介"),
      'profile_location': MessageLookupByLibrary.simpleMessage("位置"),
      'profile_website': MessageLookupByLibrary.simpleMessage("网站"),
      'translation_description': MessageLookupByLibrary.simpleMessage(
          "Kyron 自己的文字仍在翻译中，因此大多数页面目前仍显示英文。现在会翻译 Flutter 绘制的界面、日期和数字，并支持从右向左语言的布局方向。"),
      'theme_system_detail':
          MessageLookupByLibrary.simpleMessage("跟随手机的浅色或深色设置"),
      'theme_light_detail': MessageLookupByLibrary.simpleMessage("始终使用浅色"),
      'theme_dark_detail': MessageLookupByLibrary.simpleMessage("始终使用深色"),
      'theme_dim_detail':
          MessageLookupByLibrary.simpleMessage("更柔和的深色，蓝灰色而不是黑色"),
      'theme_system': MessageLookupByLibrary.simpleMessage("系统"),
      'theme_light': MessageLookupByLibrary.simpleMessage("浅色"),
      'theme_dark': MessageLookupByLibrary.simpleMessage("深色"),
      'theme_dim': MessageLookupByLibrary.simpleMessage("柔和深色"),
    };
final messageLookup = MessageLookup();
