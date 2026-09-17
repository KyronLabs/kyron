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
    };
final messageLookup = MessageLookup();
