import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';
  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
  "about": MessageLookupByLibrary.simpleMessage("关于"),
  "addAnAnswer": MessageLookupByLibrary.simpleMessage("添加答案"),
  "agreeAndContinue": MessageLookupByLibrary.simpleMessage("同意并继续"),
  "answerNumber": (Object a0) => "第 $a0 个答案",
  "arLens": MessageLookupByLibrary.simpleMessage("AR 镜头"),
  "attachSystemLog": MessageLookupByLibrary.simpleMessage("附加系统日志"),
  "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage("一个词、短语或 #tag"),
  "block": MessageLookupByLibrary.simpleMessage("拉黑"),
  "blockAuthor": (Object a0) => "要拉黑 $a0 吗？",
  "buildDetailsCopied": MessageLookupByLibrary.simpleMessage("构建详情已复制"),
  "bullet": MessageLookupByLibrary.simpleMessage("•"),
  "cancel": MessageLookupByLibrary.simpleMessage("取消"),
  "change": MessageLookupByLibrary.simpleMessage("更改"),
  "changeEmail": MessageLookupByLibrary.simpleMessage("更改邮箱"),
  "checkKyronReachable": MessageLookupByLibrary.simpleMessage("检查 Kyron 是否可访问"),
  "checkEmailConfirm": MessageLookupByLibrary.simpleMessage("请查收邮件以确认你的账户。"),
  "closeCommunity": (Object a0) => "要关闭 $a0 吗？",
  "closeIt": MessageLookupByLibrary.simpleMessage("关闭"),
  "closeThisCommunity": MessageLookupByLibrary.simpleMessage("关闭此社区"),
  "confirmPassword": MessageLookupByLibrary.simpleMessage("确认密码"),
  "contactSupport": MessageLookupByLibrary.simpleMessage("联系支持"),
  "continueWithEmail": MessageLookupByLibrary.simpleMessage("使用邮箱继续"),
  "copy": MessageLookupByLibrary.simpleMessage("复制"),
  "copyReportInstead": MessageLookupByLibrary.simpleMessage("改为复制报告"),
  "couldNotOpenGoogleSignIn": (Object a0) => "无法打开 Google 登录。$a0",
  "couldNotSignOut": (Object a0) => "无法退出：$a0",
  "couldNotTakePicture": MessageLookupByLibrary.simpleMessage("无法拍摄该照片。"),
  "create": MessageLookupByLibrary.simpleMessage("创建"),
  "createAccount": MessageLookupByLibrary.simpleMessage("创建账户"),
  "createYourAccount": MessageLookupByLibrary.simpleMessage("创建你的账户"),
  "createYourProfile": MessageLookupByLibrary.simpleMessage("创建你的个人资料"),
  "delete": MessageLookupByLibrary.simpleMessage("删除"),
  "deleteThisComment": MessageLookupByLibrary.simpleMessage("删除此评论？"),
  "deleteThisPost": MessageLookupByLibrary.simpleMessage("删除此帖子？"),
  "describeAttachment": MessageLookupByLibrary.simpleMessage("描述此附件"),
  "description": MessageLookupByLibrary.simpleMessage("描述"),
  "didCopied": MessageLookupByLibrary.simpleMessage("DID 已复制到剪贴板"),
  "done": MessageLookupByLibrary.simpleMessage("完成"),
  "drafts": MessageLookupByLibrary.simpleMessage("草稿"),
  "editProfile": MessageLookupByLibrary.simpleMessage("编辑资料"),
  "emailNotifications": MessageLookupByLibrary.simpleMessage("邮件通知"),
  "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
    "此设备不支持人脸跟踪。",
  ),
  "followers": MessageLookupByLibrary.simpleMessage("粉丝"),
  "following": MessageLookupByLibrary.simpleMessage("关注"),
  "forgotPassword": MessageLookupByLibrary.simpleMessage("忘记密码？"),
  "guidesAndAnswers": MessageLookupByLibrary.simpleMessage("指南与常见问题解答"),
  "handle": MessageLookupByLibrary.simpleMessage("用户名"),
  "helpCentre": MessageLookupByLibrary.simpleMessage("帮助中心"),
  "helpAndSupport": MessageLookupByLibrary.simpleMessage("帮助与支持"),
  "inOneLine": MessageLookupByLibrary.simpleMessage("一句话"),
  "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage("你们双方都会看不到。"),
  "itWillBeRemoved": MessageLookupByLibrary.simpleMessage("它将从讨论串中移除。"),
  "keepEditing": MessageLookupByLibrary.simpleMessage("继续编辑"),
  "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
  "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
  "leave": MessageLookupByLibrary.simpleMessage("离开"),
  "leaveCommunity": (Object a0) => "要退出 $a0 吗？",
  "letBackIn": MessageLookupByLibrary.simpleMessage("允许重新加入"),
  "loadMore": MessageLookupByLibrary.simpleMessage("加载更多"),
  "logCleared": MessageLookupByLibrary.simpleMessage("日志已清空"),
  "logCopied": MessageLookupByLibrary.simpleMessage("日志已复制"),
  "logIn": MessageLookupByLibrary.simpleMessage("登录"),
  "logOut": MessageLookupByLibrary.simpleMessage("退出登录"),
  "logOutQuestion": MessageLookupByLibrary.simpleMessage("退出登录？"),
  "message": MessageLookupByLibrary.simpleMessage("私信"),
  "mute": MessageLookupByLibrary.simpleMessage("静音"),
  "mutedAndBlocked": MessageLookupByLibrary.simpleMessage("已静音和已拉黑"),
  "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage("已屏蔽的词和标签"),
  "name": MessageLookupByLibrary.simpleMessage("姓名"),
  "nameScreen": MessageLookupByLibrary.simpleMessage("<name> 页面"),
  "newEmailAddress": MessageLookupByLibrary.simpleMessage("新的邮箱地址"),
  "newPassword": MessageLookupByLibrary.simpleMessage("新密码"),
  "newPost": MessageLookupByLibrary.simpleMessage("新帖"),
  "nothingToCopy": MessageLookupByLibrary.simpleMessage("没有可复制的内容"),
  "notifications": MessageLookupByLibrary.simpleMessage("通知"),
  "notNow": MessageLookupByLibrary.simpleMessage("暂不"),
  "notSentTapRetry": MessageLookupByLibrary.simpleMessage("未发送。点按重试"),
  "openInBrowser": MessageLookupByLibrary.simpleMessage("在浏览器中打开"),
  "pageNotFound": MessageLookupByLibrary.simpleMessage("未找到页面"),
  "pickYourInterests": MessageLookupByLibrary.simpleMessage("选择你的兴趣"),
  "post": MessageLookupByLibrary.simpleMessage("发布"),
  "postAnalytics": MessageLookupByLibrary.simpleMessage("帖子数据"),
  "postInCommunity": (Object a0) => "在 $a0 中发帖",
  "postTextCopied": MessageLookupByLibrary.simpleMessage("帖子文本已复制"),
  "profileUpdated": MessageLookupByLibrary.simpleMessage("个人资料已更新"),
  "pushNotifications": MessageLookupByLibrary.simpleMessage("推送通知"),
  "quote": MessageLookupByLibrary.simpleMessage("引用"),
  "quotePost": MessageLookupByLibrary.simpleMessage("引用帖子"),
  "reachAPerson": MessageLookupByLibrary.simpleMessage("联系真人"),
  "remove": MessageLookupByLibrary.simpleMessage("移除"),
  "removeMember": (Object a0) => "移除 $a0？",
  "removeConversation": MessageLookupByLibrary.simpleMessage("移除此对话？"),
  "removeMessage": MessageLookupByLibrary.simpleMessage("移除此消息？"),
  "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage("回复、关注与提及"),
  "reply": MessageLookupByLibrary.simpleMessage("回复"),
  "report": MessageLookupByLibrary.simpleMessage("举报"),
  "reportCopied": MessageLookupByLibrary.simpleMessage("报告已复制。粘贴到发送给支持的邮件中。"),
  "reportSent": MessageLookupByLibrary.simpleMessage("已发送报告"),
  "repost": MessageLookupByLibrary.simpleMessage("转发"),
  "reset": MessageLookupByLibrary.simpleMessage("重置"),
  "resetPassword": MessageLookupByLibrary.simpleMessage("重置你的密码"),
  "retry": MessageLookupByLibrary.simpleMessage("重试"),
  "save": MessageLookupByLibrary.simpleMessage("保存"),
  "saveDraft": MessageLookupByLibrary.simpleMessage("保存草稿"),
  "saySomething": (Object a0) => "对 $a0 说点什么",
  "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage("按姓名或用户名搜索"),
  "searchCommunities": MessageLookupByLibrary.simpleMessage("搜索社区"),
  "searchGIFs": MessageLookupByLibrary.simpleMessage("搜索 GIF"),
  "searchLanguages": MessageLookupByLibrary.simpleMessage("搜索语言"),
  "searchTrendingTags": MessageLookupByLibrary.simpleMessage("搜索热门标签"),
  "securityAlerts": MessageLookupByLibrary.simpleMessage("安全提醒与账户变更"),
  "sendConfirmation": MessageLookupByLibrary.simpleMessage("发送确认"),
  "sendErrorReport": MessageLookupByLibrary.simpleMessage("发送错误报告"),
  "sendFeedback": MessageLookupByLibrary.simpleMessage("发送反馈"),
  "sendReport": MessageLookupByLibrary.simpleMessage("发送报告"),
  "sendToSupport": MessageLookupByLibrary.simpleMessage("发送给支持"),
  "serviceStatus": MessageLookupByLibrary.simpleMessage("服务状态"),
  "shareAppLog": MessageLookupByLibrary.simpleMessage("将应用日志分享给支持"),
  "signedInAs": MessageLookupByLibrary.simpleMessage("登录身份："),
  "signInToKyron": MessageLookupByLibrary.simpleMessage("登录 Kyron"),
  "signupFailed": (Object a0) => "注册失败：$a0",
  "stay": MessageLookupByLibrary.simpleMessage("留下"),
  "systemLog": MessageLookupByLibrary.simpleMessage("系统日志"),
  "tellMissingBroken": MessageLookupByLibrary.simpleMessage("告诉我们缺了什么或哪里有问题"),
  "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
    "编辑器没有“发布”按钮",
  ),
  "translate": MessageLookupByLibrary.simpleMessage("翻译"),
  "tryAgain": MessageLookupByLibrary.simpleMessage("重试"),
  "undoRepost": MessageLookupByLibrary.simpleMessage("撤销转发"),
  "updatePassword": MessageLookupByLibrary.simpleMessage("更新密码"),
  "useDifferentAddress": MessageLookupByLibrary.simpleMessage("使用其他地址"),
  "whatHappened": MessageLookupByLibrary.simpleMessage("发生了什么"),
  "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
    "发生了什么，需要我们查看哪些内容？",
  ),
  "whatInPicture": MessageLookupByLibrary.simpleMessage("这张图片里有什么？"),
  "whatIsItFor": MessageLookupByLibrary.simpleMessage("用途是什么？（可选）"),
  "whatYouDid": MessageLookupByLibrary.simpleMessage("你做了什么、期望什么、实际发生了什么"),
  "whatYouWereDoing": MessageLookupByLibrary.simpleMessage("发生时你在做什么。"),
  "normalised": MessageLookupByLibrary.simpleMessage(r"#\$normalised"),
  "postItSayItShowIt": MessageLookupByLibrary.simpleMessage("发出来，说出来，秀出来。"),
  "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
    "文字、语音与视频，创作它们的人，以及他们交流的房间。",
  ),
  "alreadyOnKyron": MessageLookupByLibrary.simpleMessage("已经在 Kyron 上？"),
  "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
    "继续即表示你同意我们的服务条款和隐私政策",
  ),
  "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
    "Google 登录需要手机应用",
  ),
  "googleSignInDesktopExplanation": (Object a0) =>
      "Google 通过仅 Android 和 iOS 能响应的链接把完成的登录交回 Kyron，因此在 $a0 上，浏览器将无处可返回。\\n\\n如果你已经用 Google 在 Kyron 上有账户，请用相同地址选择“使用邮箱继续”，然后点“忘记密码”——我们会给你发一封设置密码的链接。",
  "loginFailed": MessageLookupByLibrary.simpleMessage("登录失败。请检查你的凭据。"),
  "email": MessageLookupByLibrary.simpleMessage("邮箱"),
  "password": MessageLookupByLibrary.simpleMessage("密码"),
  "login": MessageLookupByLibrary.simpleMessage("登录"),
  "or": MessageLookupByLibrary.simpleMessage("或"),
  "username": MessageLookupByLibrary.simpleMessage("用户名"),
  "usernameRule": MessageLookupByLibrary.simpleMessage("用户名必须为小写（a-z、0-9、_）"),
  "passwordTooShort": MessageLookupByLibrary.simpleMessage("密码过短"),
  "continueAction": MessageLookupByLibrary.simpleMessage("继续"),
  "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage("注册即表示你同意我们的"),
  "terms": MessageLookupByLibrary.simpleMessage("服务条款"),
  "and": MessageLookupByLibrary.simpleMessage("和"),
  "privacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
  "googleSignIn": MessageLookupByLibrary.simpleMessage("使用 Google 登录"),
  "googleSignUp": MessageLookupByLibrary.simpleMessage("使用 Google 注册"),
  "googleContinue": MessageLookupByLibrary.simpleMessage("使用 Google 继续"),
  "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage("继续即表示你同意我们的"),
  "literalwhetherKyronIsReachableRightNow":
      MessageLookupByLibrary.simpleMessage("Kyron 现在是否可达"),
  "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
    "此应用最近在做什么",
  ),
  "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
    "将日志分享给支持",
  ),
  "literalclearCache": MessageLookupByLibrary.simpleMessage("清除缓存"),
  "literalappVersion": MessageLookupByLibrary.simpleMessage("应用版本"),
  "literalreading": MessageLookupByLibrary.simpleMessage("读取中…"),
  "literalcheckAgain": MessageLookupByLibrary.simpleMessage("重新检查"),
  "literalkyronDidNotAnswer": MessageLookupByLibrary.simpleMessage("Kyron 未响应"),
  "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage("尚无日志"),
  "literalswitchCamera": MessageLookupByLibrary.simpleMessage("切换摄像头"),
  "literaltheCameraIsClosed": MessageLookupByLibrary.simpleMessage("摄像头已关闭"),
  "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("拍照"),
  "literallensNameFaceLens": (Object a0) => "$a0，人脸镜头",
  "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
    "无法发布该回复。",
  ),
  "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
    "无法加载此回复",
  ),
  "literalthisReplyIsGone": MessageLookupByLibrary.simpleMessage("该回复已不存在"),
  "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("添加照片"),
  "literaladdAClip": MessageLookupByLibrary.simpleMessage("添加短片"),
  "literalstartACommunity": MessageLookupByLibrary.simpleMessage("创建社区"),
  "literalcouldNotLoadYourCommunities": MessageLookupByLibrary.simpleMessage(
    "无法加载你的社区",
  ),
  "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
    "你尚未加入任何社区",
  ),
  "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
    "无法加载社区",
  ),
  "literalpostInWidgetCommunityName": (Object a0) => "在 $a0 中发帖",
  "literalsaySomethingToWidgetCommunityName": (Object a0) => "对 $a0 说点什么",
  "literaltagSomeone": MessageLookupByLibrary.simpleMessage("提及某人"),
  "literalcloseWidgetCommunityName": (Object a0) => "要关闭 $a0 吗？",
  "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
    "只有所有者可以更改此项",
  ),
  "literaltapTheBannerOrThePictureToChangeIt":
      MessageLookupByLibrary.simpleMessage("点按横幅或图片以更换"),
  "literalremoveMemberDisplayname": (Object a0) => "移除 $a0？",
  "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
    "无法加载成员列表",
  ),
  "literalnobodyHereYet": MessageLookupByLibrary.simpleMessage("这里还没有人"),
  "literalmakeAModerator": MessageLookupByLibrary.simpleMessage("设为版主"),
  "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage("取消版主"),
  "literalremoveFromCommunity": MessageLookupByLibrary.simpleMessage("从社区移除"),
  "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
    "无法加载此列表",
  ),
  "literalnobodyHasBeenRemoved": MessageLookupByLibrary.simpleMessage(
    "尚未移除任何人",
  ),
  "literalpostInCommunityName": (Object a0) => "在 $a0 中发帖",
  "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
    "无法打开此社区",
  ),
  "literalthisCommunity": MessageLookupByLibrary.simpleMessage("此社区"),
  "literalshareThisCommunity": MessageLookupByLibrary.simpleMessage("分享此社区"),
  "literalcopyLink": MessageLookupByLibrary.simpleMessage("复制链接"),
  "literallinkCopied": MessageLookupByLibrary.simpleMessage("链接已复制"),
  "literalleaveCommunityName": (Object a0) => "要退出 $a0 吗？",
  "literalyouHaveLeftCommunityName": (Object a0) => "你已退出 $a0",
  "literaladdAVideo": MessageLookupByLibrary.simpleMessage("添加视频"),
  "literaladdAGif": MessageLookupByLibrary.simpleMessage("添加 GIF"),
  "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage("录制语音帖"),
  "literalremoveThePoll": MessageLookupByLibrary.simpleMessage("移除投票"),
  "literaladdAPoll": MessageLookupByLibrary.simpleMessage("添加投票"),
  "literaladdAHashtag": MessageLookupByLibrary.simpleMessage("添加话题标签"),
  "literaldraftSaved": MessageLookupByLibrary.simpleMessage("草稿已保存"),
  "literalnoDrafts": MessageLookupByLibrary.simpleMessage("暂无草稿"),
  "literalcouldNotLoadTrending": MessageLookupByLibrary.simpleMessage("无法加载趋势"),
  "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage("暂时没有热点"),
  "literalcouldNotLoadTopics": MessageLookupByLibrary.simpleMessage("无法加载话题"),
  "literalnoTopicsYet": MessageLookupByLibrary.simpleMessage("暂无话题"),
  "literalcouldNotLoadSuggestions": MessageLookupByLibrary.simpleMessage(
    "无法加载推荐",
  ),
  "literalnobodyLeftToSuggest": MessageLookupByLibrary.simpleMessage(
    "没有更多可推荐的人",
  ),
  "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
    "you@example.com",
  ),
  "literalsendTheLink": MessageLookupByLibrary.simpleMessage("发送链接"),
  "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
    "打开来自 Kyron 的邮件",
  ),
  "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage("点开其中的链接"),
  "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
    "设置密码并继续",
  ),
  "literalsendAgainInCooldownS": (Object a0) => "在 ${a0}s 后可重发",
  "literalsendAgain": MessageLookupByLibrary.simpleMessage("再次发送"),
  "literalnormalised": (Object a0) => "#$a0",
  "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
    "无法加载你的消息",
  ),
  "literalnothingUnread": MessageLookupByLibrary.simpleMessage("暂无未读"),
  "literalnoMessagesYet": MessageLookupByLibrary.simpleMessage("还没有消息"),
  "literalnothingMuted": MessageLookupByLibrary.simpleMessage("暂无被静音的内容"),
  "literalnoLikesYet": MessageLookupByLibrary.simpleMessage("还没有点赞"),
  "literalnoRepliesYet": MessageLookupByLibrary.simpleMessage("还没有回复"),
  "literalnoNewFollowers": MessageLookupByLibrary.simpleMessage("暂无新粉丝"),
  "literalnoRepostsYet": MessageLookupByLibrary.simpleMessage("还没有转发"),
  "literalyouAreAllCaughtUp": MessageLookupByLibrary.simpleMessage("你已全部看完"),
  "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
    "无法加载通知",
  ),
  "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("封面照片"),
  "literalchooseFromGallery": MessageLookupByLibrary.simpleMessage("从相册选择"),
  "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage("使用一张系统图片"),
  "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
    "点按添加头像和封面",
  ),
  "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage("暂无兴趣"),
  "literaldiscoverPeople": MessageLookupByLibrary.simpleMessage("发现用户"),
  "literalcancelReply": MessageLookupByLibrary.simpleMessage("取消回复"),
  "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
    "无法加载此帖子",
  ),
  "literalshareThisProfile": MessageLookupByLibrary.simpleMessage("分享此个人资料"),
  "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
    "无法加载这些帖子",
  ),
  "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage("你还没有发过帖"),
  "literalnoPostsYet": MessageLookupByLibrary.simpleMessage("暂无帖子"),
  "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
    "暂时没有可看的内容",
  ),
  "literalkeepTyping": MessageLookupByLibrary.simpleMessage("继续输入"),
  "literalsearchFailed": MessageLookupByLibrary.simpleMessage("搜索失败"),
  "literalnothingMatched": MessageLookupByLibrary.simpleMessage("没有匹配项"),
  "literalcouldNotSignOutDescribeapierrorE": (Object a0) => "无法退出：$a0",
  "literalnoDidYet": MessageLookupByLibrary.simpleMessage("尚无 DID"),
  "literalpasswordLogin": MessageLookupByLibrary.simpleMessage("密码与登录"),
  "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
    "已静音和已拉黑的账户",
  ),
  "literalfontSize": MessageLookupByLibrary.simpleMessage("字体大小"),
  "literalpushNotifications": MessageLookupByLibrary.simpleMessage("推送通知"),
  "literaldataSaver": MessageLookupByLibrary.simpleMessage("省流量模式"),
  "literalcontactSupport": MessageLookupByLibrary.simpleMessage("联系支持"),
  "literalsendFeedback": MessageLookupByLibrary.simpleMessage("发送反馈"),
  "literalappLanguage": MessageLookupByLibrary.simpleMessage("应用语言"),
  "literalprimaryLanguage": MessageLookupByLibrary.simpleMessage("首选语言"),
  "literalcontentLanguages": MessageLookupByLibrary.simpleMessage("内容语言"),
  "literalremoveLanguageEnglishname": (Object a0) => "移除 $a0",
  "literalsentItIsReportFiledNumber": (Object a0) => "已发送。这是报告 #$a0。",
  "literalfeedbackCannotBeSentRightNow": MessageLookupByLibrary.simpleMessage(
    "当前无法发送反馈",
  ),
  "literalwhatYouDidWhatYouExpectedWhatHappened":
      MessageLookupByLibrary.simpleMessage("你做了什么、期望什么、发生了什么 "),
  "literalverificationFailedDescribeapierrorE": (Object a0) => "验证失败：$a0",
  "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
    "已重新发送验证码。",
  ),
  "literalverifyEmail": MessageLookupByLibrary.simpleMessage("验证邮箱"),
  "literalresendCode": MessageLookupByLibrary.simpleMessage("重发验证码"),
  "literalremoveThisConversation": MessageLookupByLibrary.simpleMessage(
    "移除此对话",
  ),
  "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
    "已静音。你将不会收到通知。",
  ),
  "literalblockThisAccount": MessageLookupByLibrary.simpleMessage("拉黑此账户？"),
  "literalyouAreSignedOut": MessageLookupByLibrary.simpleMessage("你已退出登录。"),
  "literalcouldNotLoadThisConversation": MessageLookupByLibrary.simpleMessage(
    "无法加载此对话",
  ),
  "literalsaySomething": MessageLookupByLibrary.simpleMessage("说点什么"),
  "literalcopyText": MessageLookupByLibrary.simpleMessage("复制文本"),
  "literaldoNotReply": MessageLookupByLibrary.simpleMessage("请勿回复"),
  "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage("从已保存中移除"),
  "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("打开声音"),
  "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("关闭声音"),
  "literalthatLinkIsNotOneThisCanOpen": MessageLookupByLibrary.simpleMessage(
    "此链接无法在这里打开。",
  ),
  "literalnoBrowserOnThisDeviceTookThatLink":
      MessageLookupByLibrary.simpleMessage("此设备上没有浏览器能处理该链接。"),
  "literalopenReply": MessageLookupByLibrary.simpleMessage("打开回复"),
  "literallabelCount": (Object a0, Object a1) => "$a0，$a1",
  "literalindex1": (Object a0) => "$a0",
  "literalfirstyearIndex": (Object a0) => "$a0",
  "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage("GIF 功能尚未设置"),
  "literalcouldNotLoadGifs": MessageLookupByLibrary.simpleMessage("无法加载 GIF"),
  "literalnothingFound": MessageLookupByLibrary.simpleMessage("未找到任何内容"),
  "literalthatGifCouldNotBeDownloaded": MessageLookupByLibrary.simpleMessage(
    "无法下载该 GIF。",
  ),
  "literaladdAnInterest": MessageLookupByLibrary.simpleMessage("添加兴趣"),
  "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
    "无法加载热门标签",
  ),
  "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
    "没有匹配的热门标签",
  ),
  "literalyouAlreadyFollowEveryTrendingTag":
      MessageLookupByLibrary.simpleMessage("你已关注所有热门标签"),
  "literalremoveLabel": (Object a0) => "移除 $a0",
  "literaladdLabelAsATab": (Object a0) => "将 $a0 添加为标签页",
  "literalcouldNotSearch": MessageLookupByLibrary.simpleMessage("无法搜索"),
  "literalwhoDoYouWantToTag": MessageLookupByLibrary.simpleMessage("你想提及谁？"),
  "literalnobodyFound": MessageLookupByLibrary.simpleMessage("未找到任何人"),
  "literalshowPassword": MessageLookupByLibrary.simpleMessage("显示密码"),
  "literalhidePassword": MessageLookupByLibrary.simpleMessage("隐藏密码"),
  "literaltranslatePost": MessageLookupByLibrary.simpleMessage("翻译帖子"),
  "literalcopyPostText": MessageLookupByLibrary.simpleMessage("复制帖子文本"),
  "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage("复制帖子链接"),
  "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
    "显示更多类似的帖子",
  ),
  "literalnotInterestedInThis": MessageLookupByLibrary.simpleMessage("对此不感兴趣"),
  "literalhidesItAndTellsUsToShowFewerLikeIt":
      MessageLookupByLibrary.simpleMessage("将其隐藏，并提示我们少展示类似内容"),
  "literalhideThisPost": MessageLookupByLibrary.simpleMessage("隐藏此帖子"),
  "literalmuteThisThread": MessageLookupByLibrary.simpleMessage("将此讨论串设为静音"),
  "literalstopSeeingThisPostAndRepliesToIt":
      MessageLookupByLibrary.simpleMessage("不再看到此帖及其回复"),
  "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage("屏蔽词语或标签"),
  "literalviewersLikesSavesAndComments": MessageLookupByLibrary.simpleMessage(
    "浏览、点赞、收藏和评论",
  ),
  "literalwhoCanReply": MessageLookupByLibrary.simpleMessage("谁可以回复"),
  "literaldeletePost": MessageLookupByLibrary.simpleMessage("删除帖子"),
  "literalmuteAuthor": (Object a0) => "静音 $a0",
  "literalblockAuthor": (Object a0) => "拉黑 $a0",
  "literalreportPost": MessageLookupByLibrary.simpleMessage("举报帖子"),
  "literalreportAuthor": (Object a0) => "举报 $a0",
  "literalthatDidNotGoThroughTryAgain": MessageLookupByLibrary.simpleMessage(
    "未成功发送。请重试。",
  ),
  "literalblockAuthor2": (Object a0) => "要拉黑 $a0 吗？",
  "literalshowResults": MessageLookupByLibrary.simpleMessage("显示结果"),
  "literallabelDate": MessageLookupByLibrary.simpleMessage(r"\$label 日期"),
  "literalshareVia": MessageLookupByLibrary.simpleMessage("通过…分享"),
  "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage("交给其他应用处理"),
  "literalshareWithAQuote": MessageLookupByLibrary.simpleMessage("带引用分享"),
  "literalpostItWithYourOwnWordsAboveIt": MessageLookupByLibrary.simpleMessage(
    "在上方加上你的话后发布",
  ),
  "literalsavedPosts": MessageLookupByLibrary.simpleMessage("已保存的帖子"),
  "literallikedPosts": MessageLookupByLibrary.simpleMessage("点赞的帖子"),
  "literalstoriesRibbonStoriesLengthItems": (Object a0) => "故事栏，共 $a0 项",
  "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
    "你发布的内容归你所有",
  ),
  "literalwhatKyronKeeps": MessageLookupByLibrary.simpleMessage("Kyron 保留哪些内容"),
  "literalhowToBehave": MessageLookupByLibrary.simpleMessage("行为规范"),
  "literalcloseTabLabel": (Object a0) => "关闭 $a0",
  "literal1PageOpen": MessageLookupByLibrary.simpleMessage("已打开 1 个页面"),
  "literalcountPagesOpen": (Object a0) => "已打开 $a0 个页面",
  "literalstopLoading": MessageLookupByLibrary.simpleMessage("停止加载"),
  "literalshareThisPage": MessageLookupByLibrary.simpleMessage("分享此页面"),
  "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
      "此设备上没有应用可打开 $a0 链接。",
  "literalcloseTheBrowser": MessageLookupByLibrary.simpleMessage("关闭浏览器"),
  "literalcloseAllPages": MessageLookupByLibrary.simpleMessage("关闭所有页面"),
  "literalremoveThisPoll": MessageLookupByLibrary.simpleMessage("移除此投票"),
  "literalremoveThisAnswer": MessageLookupByLibrary.simpleMessage("移除此答案"),
  "literalstartRecording": MessageLookupByLibrary.simpleMessage("开始录音"),
  "literalrecordAgain": MessageLookupByLibrary.simpleMessage("重新录制"),
  "home": MessageLookupByLibrary.simpleMessage("首页"),
  "explore": MessageLookupByLibrary.simpleMessage("发现"),
  "communities": MessageLookupByLibrary.simpleMessage("社区"),
  "messages": MessageLookupByLibrary.simpleMessage("消息"),
  "languages": MessageLookupByLibrary.simpleMessage("语言"),
  "selectAppLanguage": MessageLookupByLibrary.simpleMessage("选择用于应用界面的语言。"),
  "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
    "选择你在信息流中偏好的翻译语言。",
  ),
  "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
    "选择你希望订阅内容包含的语言。如未选择，将显示所有语言。",
  ),
  "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
    "Kyron 的文案仍在翻译中，所以目前大多数界面仍为英文。",
  ),
  "hashtagsEmptyDetail": MessageLookupByLibrary.simpleMessage(
    "当大家开始使用这些标签时，它们会出现在这里。",
  ),
  "topicsEmptyDetail": MessageLookupByLibrary.simpleMessage(
    "话题由 Kyron 设置，目前还没有。稍后再来看看。",
  ),
  "peopleEmptyDetail": MessageLookupByLibrary.simpleMessage(
    "你已关注 Kyron 会推荐的所有人。",
  ),
  "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
    "去“发现”找一个，或创建你自己的。",
  ),
  "messagesCaughtUp": MessageLookupByLibrary.simpleMessage("所有会话都已同步。"),
  "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
    "打开某人的资料并点“私信”开始对话。",
  ),
  "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
    "有人给你的帖子点赞时，会显示在这里。",
  ),
  "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
    "对你帖子的新回复会出现在这里。",
  ),
  "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
    "关注你的人会出现在这里。",
  ),
  "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
    "有人转发你时，会显示在这里。",
  ),
  "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
    "点赞、回复和新粉丝抵达时会出现在这里。",
  ),
  "gettingHelp": MessageLookupByLibrary.simpleMessage("获取帮助"),
  "send": MessageLookupByLibrary.simpleMessage("发送"),
  "close": MessageLookupByLibrary.simpleMessage("关闭"),
  "search": MessageLookupByLibrary.simpleMessage("搜索"),
  "settings": MessageLookupByLibrary.simpleMessage("设置"),
  "menu": MessageLookupByLibrary.simpleMessage("菜单"),
  "clear": MessageLookupByLibrary.simpleMessage("清除"),
  "manage": MessageLookupByLibrary.simpleMessage("管理"),
  "join": MessageLookupByLibrary.simpleMessage("加入"),
  "video": MessageLookupByLibrary.simpleMessage("视频"),
  "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
    "帖子目前尚未带有语言标注，因此暂时无法据此过滤你的信息流。你的选择会被保留，待其生效。",
  ),
  "addMoreLanguages": MessageLookupByLibrary.simpleMessage("添加更多语言…"),
  "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
    "翻译功能尚未上线。你信息流中的内容今天不会被翻译；我们会记住你的选择，待功能可用时生效。",
  ),
  "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
    "Kyron 仍处于早期阶段，最快联系到能真正解决问题的人的方式是提交 issue。请包含你在做什么以及实际发生了什么。",
  ),
  "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
    "暂未提供应用内支持收件箱，所以此页面会指向真正有人看的地方，而不是一个没有人处理的表单。",
  ),
  "ui_communities_screen_what_is_it_for_optional_39b687":
      MessageLookupByLibrary.simpleMessage("它是做什么的？（可选）"),
  "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
      MessageLookupByLibrary.simpleMessage("你需要重新登录才能回到你的帐户。"),
  "ui_settings_subscreens_new_email_address_dab96e":
      MessageLookupByLibrary.simpleMessage("新电子邮箱地址"),
  "ui_settings_subscreens_new_password_88c1bf":
      MessageLookupByLibrary.simpleMessage("新密码"),
  "ui_settings_subscreens_confirm_password_41d040":
      MessageLookupByLibrary.simpleMessage("确认密码"),
  "ui_settings_subscreens_in_one_line_06bdaf":
      MessageLookupByLibrary.simpleMessage("一行内"),
  "ui_settings_subscreens_what_happened_977dd8":
      MessageLookupByLibrary.simpleMessage("发生了什么"),
  "ui_onboard_step3_screen_skip_7b13d8": MessageLookupByLibrary.simpleMessage(
    "跳过",
  ),
  "ui_onboard_step3_screen_finish_5c0ad8": MessageLookupByLibrary.simpleMessage(
    "完成",
  ),
  "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
    "12 MB",
  ),
  "audit_about_subscreens_round_trip_64776b4c":
      MessageLookupByLibrary.simpleMessage("往返"),
  "audit_about_subscreens_token_verification_7934e1f2":
      MessageLookupByLibrary.simpleMessage("令牌验证"),
  "audit_about_subscreens_support_kyron_so_a3a84d0f":
      MessageLookupByLibrary.simpleMessage("support@kyron.so"),
  "audit_ar_lens_screen_try_again_cdec8872":
      MessageLookupByLibrary.simpleMessage("再试一次"),
  "audit_browser_engine_window_stop_39c04883":
      MessageLookupByLibrary.simpleMessage("window.stop();"),
  "audit_browser_sheet_try_again_44bc94ba":
      MessageLookupByLibrary.simpleMessage("再试一次"),
  "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
      MessageLookupByLibrary.simpleMessage("现在开始广播会把你放到一个没人能"),
  "audit_communities_screen_start_a_community_06c8ec4f":
      MessageLookupByLibrary.simpleMessage("创建社区"),
  "audit_communities_screen_what_is_it_for_optional_e7e82092":
      MessageLookupByLibrary.simpleMessage("它是做什么的？（可选）"),
  "audit_community_manage_screen_closing_it_f490fb09":
      MessageLookupByLibrary.simpleMessage("关闭它"),
  "audit_community_manage_screen_back_in_e495a750":
      MessageLookupByLibrary.simpleMessage("回来。"),
  "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
      MessageLookupByLibrary.simpleMessage("从此列表返回。"),
  "audit_community_screen_join_first_7798cafc":
      MessageLookupByLibrary.simpleMessage("先加入"),
  "audit_composer_screen_coming_soon_431fd23d":
      MessageLookupByLibrary.simpleMessage("即将推出"),
  "audit_composer_screen_posting_as_you_45d69932":
      MessageLookupByLibrary.simpleMessage("以你的身份发布"),
  "audit_drafts_screen_just_now_17a8d48a": MessageLookupByLibrary.simpleMessage(
    "刚刚",
  ),
  "audit_explore_screen_topic_1_83830b41": MessageLookupByLibrary.simpleMessage(
    "话题 1",
  ),
  "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
      MessageLookupByLibrary.simpleMessage("现在已在路上。"),
  "audit_forgot_password_screen_has_anything_65044193":
      MessageLookupByLibrary.simpleMessage("有任何东西。"),
  "audit_post_analytics_screen_viewers_per_day_5d881f10":
      MessageLookupByLibrary.simpleMessage("每天观看人数"),
  "audit_post_detail_screen_sublist_1_join_b0a5d508":
      MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
  "audit_report_screen_this_post_820d9740":
      MessageLookupByLibrary.simpleMessage("这条帖子"),
  "audit_report_screen_anything_to_add_optional_f0051fa4":
      MessageLookupByLibrary.simpleMessage("还有什么要补充吗？（可选）"),
  "audit_settings_screen_log_out_0b39bfb2":
      MessageLookupByLibrary.simpleMessage("退出登录"),
  "audit_settings_screen_your_account_bcdf27af":
      MessageLookupByLibrary.simpleMessage("你的账户"),
  "audit_settings_screen_did_plc_abc_825b4f49":
      MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
  "audit_settings_subscreens_confirm_password_f0e1f449":
      MessageLookupByLibrary.simpleMessage("确认密码"),
  "audit_settings_subscreens_not_now_e1657fa9":
      MessageLookupByLibrary.simpleMessage("现在不要"),
  "audit_create_fab_post_in_this_community_0a42daf2":
      MessageLookupByLibrary.simpleMessage("在此社区发布"),
  "audit_url_preview_its_own_8b362f95": MessageLookupByLibrary.simpleMessage(
    "它自己的。",
  ),
  "audit_empty_state_try_again_80ef48cd": MessageLookupByLibrary.simpleMessage(
    "再试一次",
  ),
  "audit_feed_canvas_for_you_aa3c510d": MessageLookupByLibrary.simpleMessage(
    "为你",
  ),
  "audit_google_button_not_bbd76526": MessageLookupByLibrary.simpleMessage(
    "，不是",
  ),
  "audit_inline_video_am_i_moving_4618f78c":
      MessageLookupByLibrary.simpleMessage("我在动吗？"),
  "audit_inline_video_turn_sound_on_83671c54":
      MessageLookupByLibrary.simpleMessage("打开声音"),
  "audit_inline_video_turn_sound_off_97714bbc":
      MessageLookupByLibrary.simpleMessage("关闭声音"),
  "audit_interest_tabs_for_you_7ef9e823": MessageLookupByLibrary.simpleMessage(
    "为你",
  ),
  "audit_interest_tabs_your_tabs_c3ba148f":
      MessageLookupByLibrary.simpleMessage("你的标签页"),
  "audit_media_tray_alt_784030d4": MessageLookupByLibrary.simpleMessage(
    "+ ALT",
  ),
  "audit_mention_picker_sheet_try_again_fd5d5dd7":
      MessageLookupByLibrary.simpleMessage("再试一次"),
  "audit_password_requirements_symbol_322aed1e":
      MessageLookupByLibrary.simpleMessage("符号 (!@#…)"),
  "audit_post_list_view_could_not_load_4dd86c79":
      MessageLookupByLibrary.simpleMessage("无法加载"),
  "audit_post_options_sheet_this_post_99bfa981":
      MessageLookupByLibrary.simpleMessage("此帖子"),
  "audit_post_text_a_b_780da9a1": MessageLookupByLibrary.simpleMessage("a#b"),
  "audit_search_filter_sheet_from_an_account_f6a22687":
      MessageLookupByLibrary.simpleMessage("来自某个账号"),
  "audit_skeleton_loading_18e82bcc": MessageLookupByLibrary.simpleMessage(
    "加载中…",
  ),
  "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
      MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
  "audit_story_pill_posting_bb613f87": MessageLookupByLibrary.simpleMessage(
    "发布中…",
  ),
  "audit_story_viewer_your_story_b706ecb4":
      MessageLookupByLibrary.simpleMessage("你的故事"),
  "audit_story_viewer_copy_story_link_2bd1546c":
      MessageLookupByLibrary.simpleMessage("复制故事链接"),
  "audit_story_viewer_3h_ago_174dc80d": MessageLookupByLibrary.simpleMessage(
    "3小时前",
  ),
  "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
      MessageLookupByLibrary.simpleMessage("你的帐户、你的帖子，以及你点击的内容，因此"),
  "audit_topic_picker_add_a_topic_25baaf8a":
      MessageLookupByLibrary.simpleMessage("添加话题"),
  "ui_communities": MessageLookupByLibrary.simpleMessage("社区"),
  "ui_settings": MessageLookupByLibrary.simpleMessage("设置"),
  "ui_appearance": MessageLookupByLibrary.simpleMessage("外观"),
  "ui_language": MessageLookupByLibrary.simpleMessage("语言"),
  "ui_account": MessageLookupByLibrary.simpleMessage("账户"),
  "ui_content_display": MessageLookupByLibrary.simpleMessage("内容与显示"),
  "ui_app_device": MessageLookupByLibrary.simpleMessage("应用与设备"),
  "ui_terms": MessageLookupByLibrary.simpleMessage("条款"),
  "ui_privacy": MessageLookupByLibrary.simpleMessage("隐私"),
  "ui_help": MessageLookupByLibrary.simpleMessage("帮助"),
  "ui_feedback": MessageLookupByLibrary.simpleMessage("反馈"),
  "ui_decentralized_id": MessageLookupByLibrary.simpleMessage("去中心化 ID"),
  "ui_find_people_on_kyron": MessageLookupByLibrary.simpleMessage(
    "在 Kyron 上查找用户",
  ),
  "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
    "搜索所有已发布内容",
  ),
  "ui_search_by_handle_or_display_name": MessageLookupByLibrary.simpleMessage(
    "按账号或显示名称搜索。",
  ),
  "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
    "关键词，或按筛选条件—账号、日期范围，或帖子的附带内容。",
  ),
  "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage("两个字符或更多。"),
  "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
    "没有帖子符合这些筛选条件。",
  ),
  "ui_search_clear": MessageLookupByLibrary.simpleMessage("清除"),
  "ui_search_filters": MessageLookupByLibrary.simpleMessage("筛选"),
  "ui_post_text_copied": MessageLookupByLibrary.simpleMessage("帖子文本已复制"),
  "ui_link_copied": MessageLookupByLibrary.simpleMessage("链接已复制"),
  "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
    "已记录。这有助于决定向你展示的内容。",
  ),
  "ui_posts_hidden": MessageLookupByLibrary.simpleMessage("已隐藏。我们会减少类似内容的展示。"),
  "ui_post_hidden": MessageLookupByLibrary.simpleMessage("帖子已隐藏"),
  "ui_thread_muted": MessageLookupByLibrary.simpleMessage("线程已静音"),
  "ui_post_deleted": MessageLookupByLibrary.simpleMessage("帖子已删除"),
  "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
    "它会从你的个人资料和其他所有人的动态中移除。对它的回复也会随之移除。",
  ),
  "ui_block_detail": MessageLookupByLibrary.simpleMessage(
    "你们双方都不会在 Kyron 上看到对方，双方之间的关注会被取消。对方不会收到通知。",
  ),
  "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
    "你将不再看到他们的帖子。对方不会收到通知。",
  ),
  "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage("服务条款"),
  "ui_about_privacy_policy": MessageLookupByLibrary.simpleMessage("隐私政策"),
  "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
    "你的个人资料和联系信息",
  ),
  "ui_settings_security": MessageLookupByLibrary.simpleMessage("安全设置"),
  "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
    "你已静音或屏蔽的人",
  ),
  "ui_settings_content_display": MessageLookupByLibrary.simpleMessage("内容与显示"),
  "ui_settings_app_device": MessageLookupByLibrary.simpleMessage("应用与设备"),
  "ui_settings_data_saver": MessageLookupByLibrary.simpleMessage("省流量"),
  "ui_settings_language_detail": MessageLookupByLibrary.simpleMessage("选择你的语言"),
  "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
    "通知偏好",
  ),
  "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage("浏览帮助文章"),
  "ui_settings_team_help": MessageLookupByLibrary.simpleMessage("向我们的团队寻求帮助"),
  "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
    "告诉我们你的想法",
  ),
  "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
    "无法加载你的个人资料",
  ),
  "ui_search_people": MessageLookupByLibrary.simpleMessage("搜索用户"),
  "ui_search_posts": MessageLookupByLibrary.simpleMessage("搜索帖子"),
  "ui_this_post": MessageLookupByLibrary.simpleMessage("这条帖子"),
  "authorPostsHidden": (Object a0) => "你将看不到来自 $a0 的帖子",
  "authorBlocked": (Object a0) => "$a0 已被屏蔽",
  "nothingMatchesQuery": (Object a0) => "Kyron 上没有匹配 \"$a0\" 的内容",
  "repliesPolicy": (Object a0) => "回复：$a0",
  "ui_preferences": MessageLookupByLibrary.simpleMessage("偏好设置"),
  "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
    "浅色、深色，或与手机设置相同",
  ),
  "ui_legal": MessageLookupByLibrary.simpleMessage("法律"),
  "ui_diagnostics": MessageLookupByLibrary.simpleMessage("诊断"),
  "ui_saved_posts": MessageLookupByLibrary.simpleMessage("已保存的帖子"),
  "ui_liked_posts": MessageLookupByLibrary.simpleMessage("已点赞的帖子"),
  "ui_nothing_saved_yet": MessageLookupByLibrary.simpleMessage("还没有保存任何内容"),
  "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage("还没有点赞"),
  "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
    "点击任何帖子的存档图标即可将其保存在这里。只有你能看到你保存的内容。",
  ),
  "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
    "你点赞的帖子会显示在这里，按时间倒序排列。",
  ),
  "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
    "无法加载你保存的帖子",
  ),
  "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
    "无法加载你点赞的帖子",
  ),
  "feedTagDetail": (Object a0) => "还没有人在 #$a0 下发布内容。",
  "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage("你关注的人暂无内容"),
  "ui_feed_videos_empty": MessageLookupByLibrary.simpleMessage("还没有视频"),
  "ui_feed_empty": MessageLookupByLibrary.simpleMessage("这里还没有内容"),
  "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
    "关注一些账号，他们的帖子会在这里显示。",
  ),
  "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
    "带有视频片段的帖子会显示在这里。",
  ),
  "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
    "人们发布时，帖子会出现在这里。",
  ),
  "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage("无法加载你的动态"),
  "ui_share_this_post": MessageLookupByLibrary.simpleMessage("分享此帖子"),
  "analytics_distinct_people_not_opens": MessageLookupByLibrary.simpleMessage(
    "不同的人数，而不是打开次数",
  ),
  "analytics_engagement": MessageLookupByLibrary.simpleMessage("互动"),
  "analytics_posted": MessageLookupByLibrary.simpleMessage("发布时间"),
  "analytics_viewers": MessageLookupByLibrary.simpleMessage("查看者"),
  "analytics_likes": MessageLookupByLibrary.simpleMessage("喜欢"),
  "analytics_comments": MessageLookupByLibrary.simpleMessage("评论"),
  "analytics_saves": MessageLookupByLibrary.simpleMessage("收藏"),
  "analytics_no_viewers_yet": MessageLookupByLibrary.simpleMessage("还没有查看者"),
  "analytics_viewers_per_day": MessageLookupByLibrary.simpleMessage("每日查看者"),
  "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
    "还没有人打开过这篇帖子。",
  ),
  "reply_who_can_reply": MessageLookupByLibrary.simpleMessage("谁可以回复？"),
  "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
    "任何人仍然可以查看、转发和引用这篇帖子。",
  ),
  "reply_anyone": MessageLookupByLibrary.simpleMessage("任何人都可以互动"),
  "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
    "Kyron 上的任何人都可以回复这篇帖子。",
  ),
  "reply_followers": MessageLookupByLibrary.simpleMessage("关注你的人"),
  "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
    "只有关注你的人可以回复这篇帖子。",
  ),
  "reply_mentioned": MessageLookupByLibrary.simpleMessage("你提到的人"),
  "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
    "只有你在这篇帖子中 @提到的人可以回复。",
  ),
  "reply_nobody": MessageLookupByLibrary.simpleMessage("没有人可以回复"),
  "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
    "回复已关闭，但你仍然可以回复。",
  ),
  "interest_for_you": MessageLookupByLibrary.simpleMessage("为你推荐"),
  "interest_following": MessageLookupByLibrary.simpleMessage("关注"),
  "interest_videos": MessageLookupByLibrary.simpleMessage("视频"),
  "interest_your_tabs": MessageLookupByLibrary.simpleMessage("你的标签页"),
  "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage("拖动以重新排序"),
  "interest_add": MessageLookupByLibrary.simpleMessage("添加兴趣"),
  "interest_trending_now": MessageLookupByLibrary.simpleMessage("当前趋势"),
  "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
    "标签栏最多容纳五个标签页。移除一个即可添加另一个。",
  ),
  "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
    "人们开始使用某个话题标签后，它会显示在这里。",
  ),
  "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
    "你脑海中在想什么？",
  ),
  "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
    "说点只有你能说的话……",
  ),
  "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
    "分享一个大胆的观点（或温和一点的）",
  ),
  "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
    "这是你的信号——发出去吧",
  ),
  "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
    "输入、说话，或把想法说出来",
  ),
  "profile_tap_to_change": MessageLookupByLibrary.simpleMessage("点击更改"),
  "profile_display_name": MessageLookupByLibrary.simpleMessage("显示名称"),
  "profile_bio": MessageLookupByLibrary.simpleMessage("简介"),
  "profile_location": MessageLookupByLibrary.simpleMessage("位置"),
  "profile_website": MessageLookupByLibrary.simpleMessage("网站"),
  "translation_description": MessageLookupByLibrary.simpleMessage(
    "Kyron 自己的文字仍在翻译中，因此大多数页面目前仍显示英文。现在会翻译 Flutter 绘制的界面、日期和数字，并支持从右向左语言的布局方向。",
  ),
  "theme_system_detail": MessageLookupByLibrary.simpleMessage("跟随手机的浅色或深色设置"),
  "theme_light_detail": MessageLookupByLibrary.simpleMessage("始终使用浅色"),
  "theme_dark_detail": MessageLookupByLibrary.simpleMessage("始终使用深色"),
  "theme_dim_detail": MessageLookupByLibrary.simpleMessage("更柔和的深色，蓝灰色而不是黑色"),
  "theme_system": MessageLookupByLibrary.simpleMessage("系统"),
  "theme_light": MessageLookupByLibrary.simpleMessage("浅色"),
  "theme_dark": MessageLookupByLibrary.simpleMessage("深色"),
  "theme_dim": MessageLookupByLibrary.simpleMessage("柔和深色"),
  "ui_like": MessageLookupByLibrary.simpleMessage("赞"),
  "ui_share": MessageLookupByLibrary.simpleMessage("分享"),
  "ui_joined": MessageLookupByLibrary.simpleMessage("已加入"),
  "ui_join": MessageLookupByLibrary.simpleMessage("加入"),
  "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("打开声音"),
  "ui_turn_sound_off": MessageLookupByLibrary.simpleMessage("关闭声音"),
  "ui_pause": MessageLookupByLibrary.simpleMessage("暂停"),
  "ui_play": MessageLookupByLibrary.simpleMessage("播放"),
  "ui_from_account": MessageLookupByLibrary.simpleMessage("来自账户"),
  "ui_posted_between": MessageLookupByLibrary.simpleMessage("发布于"),
  "ui_after": MessageLookupByLibrary.simpleMessage("之后"),
  "ui_before": MessageLookupByLibrary.simpleMessage("之前"),
  "ui_carrying": MessageLookupByLibrary.simpleMessage("包含"),
  'ui_communities_screen_what_is_it_for_optional_39b687':
      MessageLookupByLibrary.simpleMessage("它是做什么的？（可选）"),
  'ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001':
      MessageLookupByLibrary.simpleMessage("你需要重新登录才能回到你的帐户。"),
  'ui_settings_subscreens_new_email_address_dab96e':
      MessageLookupByLibrary.simpleMessage("新电子邮箱地址"),
  'ui_settings_subscreens_new_password_88c1bf':
      MessageLookupByLibrary.simpleMessage("新密码"),
  'ui_settings_subscreens_confirm_password_41d040':
      MessageLookupByLibrary.simpleMessage("确认密码"),
  'ui_settings_subscreens_in_one_line_06bdaf':
      MessageLookupByLibrary.simpleMessage("一行内"),
  'ui_settings_subscreens_what_happened_977dd8':
      MessageLookupByLibrary.simpleMessage("发生了什么"),
  'ui_onboard_step3_screen_skip_7b13d8': MessageLookupByLibrary.simpleMessage(
    "跳过",
  ),
  'ui_onboard_step3_screen_finish_5c0ad8': MessageLookupByLibrary.simpleMessage(
    "完成",
  ),
  'audit_about_screen_12_mb_e39721d6': MessageLookupByLibrary.simpleMessage(
    "12 MB",
  ),
  'audit_about_subscreens_round_trip_64776b4c':
      MessageLookupByLibrary.simpleMessage("往返"),
  'audit_about_subscreens_token_verification_7934e1f2':
      MessageLookupByLibrary.simpleMessage("令牌验证"),
  'audit_about_subscreens_support_kyron_so_a3a84d0f':
      MessageLookupByLibrary.simpleMessage("support@kyron.so"),
  'audit_ar_lens_screen_try_again_cdec8872':
      MessageLookupByLibrary.simpleMessage("再试一次"),
  'audit_browser_engine_window_stop_39c04883':
      MessageLookupByLibrary.simpleMessage("window.stop();"),
  'audit_browser_sheet_try_again_44bc94ba':
      MessageLookupByLibrary.simpleMessage("再试一次"),
  'audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b':
      MessageLookupByLibrary.simpleMessage("现在开始广播会把你放到一个没人能"),
  'audit_communities_screen_start_a_community_06c8ec4f':
      MessageLookupByLibrary.simpleMessage("创建社区"),
  'audit_communities_screen_what_is_it_for_optional_e7e82092':
      MessageLookupByLibrary.simpleMessage("它是做什么的？（可选）"),
  'audit_community_manage_screen_closing_it_f490fb09':
      MessageLookupByLibrary.simpleMessage("关闭它"),
  'audit_community_manage_screen_back_in_e495a750':
      MessageLookupByLibrary.simpleMessage("回来。"),
  'audit_community_manage_screen_back_in_from_this_list_9496a4fd':
      MessageLookupByLibrary.simpleMessage("从此列表返回。"),
  'audit_community_screen_join_first_7798cafc':
      MessageLookupByLibrary.simpleMessage("先加入"),
  'audit_composer_screen_coming_soon_431fd23d':
      MessageLookupByLibrary.simpleMessage("即将推出"),
  'audit_composer_screen_posting_as_you_45d69932':
      MessageLookupByLibrary.simpleMessage("以你的身份发布"),
  'audit_drafts_screen_just_now_17a8d48a': MessageLookupByLibrary.simpleMessage(
    "刚刚",
  ),
  'audit_explore_screen_topic_1_83830b41': MessageLookupByLibrary.simpleMessage(
    "话题 1",
  ),
  'audit_forgot_password_screen_its_way_to_it_now_271a6cea':
      MessageLookupByLibrary.simpleMessage("现在已在路上。"),
  'audit_forgot_password_screen_has_anything_65044193':
      MessageLookupByLibrary.simpleMessage("有任何东西。"),
  'audit_post_analytics_screen_viewers_per_day_5d881f10':
      MessageLookupByLibrary.simpleMessage("每天观看人数"),
  'audit_post_detail_screen_sublist_1_join_b0a5d508':
      MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
  'audit_report_screen_this_post_820d9740':
      MessageLookupByLibrary.simpleMessage("这条帖子"),
  'audit_report_screen_anything_to_add_optional_f0051fa4':
      MessageLookupByLibrary.simpleMessage("还有什么要补充吗？（可选）"),
  'audit_settings_screen_log_out_0b39bfb2':
      MessageLookupByLibrary.simpleMessage("退出登录"),
  'audit_settings_screen_your_account_bcdf27af':
      MessageLookupByLibrary.simpleMessage("你的账户"),
  'audit_settings_screen_did_plc_abc_825b4f49':
      MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
  'audit_settings_subscreens_confirm_password_f0e1f449':
      MessageLookupByLibrary.simpleMessage("确认密码"),
  'audit_settings_subscreens_not_now_e1657fa9':
      MessageLookupByLibrary.simpleMessage("现在不要"),
  'audit_create_fab_post_in_this_community_0a42daf2':
      MessageLookupByLibrary.simpleMessage("在此社区发布"),
  'audit_url_preview_its_own_8b362f95': MessageLookupByLibrary.simpleMessage(
    "它自己的。",
  ),
  'audit_empty_state_try_again_80ef48cd': MessageLookupByLibrary.simpleMessage(
    "再试一次",
  ),
  'audit_feed_canvas_for_you_aa3c510d': MessageLookupByLibrary.simpleMessage(
    "为你",
  ),
  'audit_google_button_not_bbd76526': MessageLookupByLibrary.simpleMessage(
    "，不是",
  ),
  'audit_inline_video_am_i_moving_4618f78c':
      MessageLookupByLibrary.simpleMessage("我在动吗？"),
  'audit_inline_video_turn_sound_on_83671c54':
      MessageLookupByLibrary.simpleMessage("打开声音"),
  'audit_inline_video_turn_sound_off_97714bbc':
      MessageLookupByLibrary.simpleMessage("关闭声音"),
  'audit_interest_tabs_for_you_7ef9e823': MessageLookupByLibrary.simpleMessage(
    "为你",
  ),
  'audit_interest_tabs_your_tabs_c3ba148f':
      MessageLookupByLibrary.simpleMessage("你的标签页"),
  'audit_media_tray_alt_784030d4': MessageLookupByLibrary.simpleMessage(
    "+ ALT",
  ),
  'audit_mention_picker_sheet_try_again_fd5d5dd7':
      MessageLookupByLibrary.simpleMessage("再试一次"),
  'audit_password_requirements_symbol_322aed1e':
      MessageLookupByLibrary.simpleMessage("符号 (!@#…)"),
  'audit_post_list_view_could_not_load_4dd86c79':
      MessageLookupByLibrary.simpleMessage("无法加载"),
  'audit_post_options_sheet_this_post_99bfa981':
      MessageLookupByLibrary.simpleMessage("此帖子"),
  'audit_post_text_a_b_780da9a1': MessageLookupByLibrary.simpleMessage("a#b"),
  'audit_search_filter_sheet_from_an_account_f6a22687':
      MessageLookupByLibrary.simpleMessage("来自某个账号"),
  'audit_skeleton_loading_18e82bcc': MessageLookupByLibrary.simpleMessage(
    "加载中…",
  ),
  'audit_sliding_drawer_content_kyron_v1_0_0_d696e73a':
      MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
  'audit_story_pill_posting_bb613f87': MessageLookupByLibrary.simpleMessage(
    "发布中…",
  ),
  'audit_story_viewer_your_story_b706ecb4':
      MessageLookupByLibrary.simpleMessage("你的故事"),
  'audit_story_viewer_copy_story_link_2bd1546c':
      MessageLookupByLibrary.simpleMessage("复制故事链接"),
  'audit_story_viewer_3h_ago_174dc80d': MessageLookupByLibrary.simpleMessage(
    "3小时前",
  ),
  'audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef':
      MessageLookupByLibrary.simpleMessage("你的帐户、你的帖子，以及你点击的内容，因此"),
  'audit_topic_picker_add_a_topic_25baaf8a':
      MessageLookupByLibrary.simpleMessage("添加话题"),
  'ui_communities': MessageLookupByLibrary.simpleMessage("社区"),
  'ui_settings': MessageLookupByLibrary.simpleMessage("设置"),
  'ui_appearance': MessageLookupByLibrary.simpleMessage("外观"),
  'ui_language': MessageLookupByLibrary.simpleMessage("语言"),
  'ui_account': MessageLookupByLibrary.simpleMessage("账户"),
  'ui_content_display': MessageLookupByLibrary.simpleMessage("内容与显示"),
  'ui_app_device': MessageLookupByLibrary.simpleMessage("应用与设备"),
  'ui_terms': MessageLookupByLibrary.simpleMessage("条款"),
  'ui_privacy': MessageLookupByLibrary.simpleMessage("隐私"),
  'ui_help': MessageLookupByLibrary.simpleMessage("帮助"),
  'ui_feedback': MessageLookupByLibrary.simpleMessage("反馈"),
  'ui_decentralized_id': MessageLookupByLibrary.simpleMessage("去中心化 ID"),
  'ui_find_people_on_kyron': MessageLookupByLibrary.simpleMessage(
    "在 Kyron 上查找用户",
  ),
  'ui_search_everything_posted': MessageLookupByLibrary.simpleMessage(
    "搜索所有已发布内容",
  ),
  'ui_search_by_handle_or_display_name': MessageLookupByLibrary.simpleMessage(
    "按账号或显示名称搜索。",
  ),
  'ui_words_or_filter': MessageLookupByLibrary.simpleMessage(
    "关键词，或按筛选条件—账号、日期范围，或帖子的附带内容。",
  ),
  'ui_two_characters_or_more': MessageLookupByLibrary.simpleMessage("两个字符或更多。"),
  'ui_no_posts_match_filters': MessageLookupByLibrary.simpleMessage(
    "没有帖子符合这些筛选条件。",
  ),
  'ui_search_clear': MessageLookupByLibrary.simpleMessage("清除"),
  'ui_search_filters': MessageLookupByLibrary.simpleMessage("筛选"),
  'ui_post_text_copied': MessageLookupByLibrary.simpleMessage("帖子文本已复制"),
  'ui_link_copied': MessageLookupByLibrary.simpleMessage("链接已复制"),
  'ui_interest_noted': MessageLookupByLibrary.simpleMessage(
    "已记录。这有助于决定向你展示的内容。",
  ),
  'ui_posts_hidden': MessageLookupByLibrary.simpleMessage("已隐藏。我们会减少类似内容的展示。"),
  'ui_post_hidden': MessageLookupByLibrary.simpleMessage("帖子已隐藏"),
  'ui_thread_muted': MessageLookupByLibrary.simpleMessage("线程已静音"),
  'ui_post_deleted': MessageLookupByLibrary.simpleMessage("帖子已删除"),
  'ui_post_delete_detail': MessageLookupByLibrary.simpleMessage(
    "它会从你的个人资料和其他所有人的动态中移除。对它的回复也会随之移除。",
  ),
  'ui_block_detail': MessageLookupByLibrary.simpleMessage(
    "你们双方都不会在 Kyron 上看到对方，双方之间的关注会被取消。对方不会收到通知。",
  ),
  'ui_mute_detail': MessageLookupByLibrary.simpleMessage(
    "你将不再看到他们的帖子。对方不会收到通知。",
  ),
  'ui_about_terms_of_service': MessageLookupByLibrary.simpleMessage("服务条款"),
  'ui_about_privacy_policy': MessageLookupByLibrary.simpleMessage("隐私政策"),
  'ui_settings_profile_contact': MessageLookupByLibrary.simpleMessage(
    "你的个人资料和联系信息",
  ),
  'ui_settings_security': MessageLookupByLibrary.simpleMessage("安全设置"),
  'ui_settings_muted_blocked': MessageLookupByLibrary.simpleMessage(
    "你已静音或屏蔽的人",
  ),
  'ui_settings_content_display': MessageLookupByLibrary.simpleMessage("内容与显示"),
  'ui_settings_app_device': MessageLookupByLibrary.simpleMessage("应用与设备"),
  'ui_settings_data_saver': MessageLookupByLibrary.simpleMessage("省流量"),
  'ui_settings_language_detail': MessageLookupByLibrary.simpleMessage("选择你的语言"),
  'ui_settings_notifications_detail': MessageLookupByLibrary.simpleMessage(
    "通知偏好",
  ),
  'ui_settings_help_articles': MessageLookupByLibrary.simpleMessage("浏览帮助文章"),
  'ui_settings_team_help': MessageLookupByLibrary.simpleMessage("向我们的团队寻求帮助"),
  'ui_settings_feedback_detail': MessageLookupByLibrary.simpleMessage(
    "告诉我们你的想法",
  ),
  'ui_could_not_load_profile': MessageLookupByLibrary.simpleMessage(
    "无法加载你的个人资料",
  ),
  'ui_search_people': MessageLookupByLibrary.simpleMessage("搜索用户"),
  'ui_search_posts': MessageLookupByLibrary.simpleMessage("搜索帖子"),
  'ui_this_post': MessageLookupByLibrary.simpleMessage("这条帖子"),
  'authorPostsHidden': (Object author) => 'You will not see posts from $author',
  'authorBlocked': (Object author) => '$author blocked',
  'nothingMatchesQuery': (Object what) => 'Nothing on Kyron matches "$what"',
  'repliesPolicy': (Object policy) => 'Replies: $policy',
  'ui_preferences': MessageLookupByLibrary.simpleMessage("偏好设置"),
  'ui_appearance_detail': MessageLookupByLibrary.simpleMessage(
    "浅色、深色，或与手机设置相同",
  ),
  'ui_legal': MessageLookupByLibrary.simpleMessage("法律"),
  'ui_diagnostics': MessageLookupByLibrary.simpleMessage("诊断"),
  'ui_saved_posts': MessageLookupByLibrary.simpleMessage("已保存的帖子"),
  'ui_liked_posts': MessageLookupByLibrary.simpleMessage("已点赞的帖子"),
  'ui_nothing_saved_yet': MessageLookupByLibrary.simpleMessage("还没有保存任何内容"),
  'ui_no_likes_yet': MessageLookupByLibrary.simpleMessage("还没有点赞"),
  'ui_saved_posts_detail': MessageLookupByLibrary.simpleMessage(
    "点击任何帖子的存档图标即可将其保存在这里。只有你能看到你保存的内容。",
  ),
  'ui_liked_posts_detail': MessageLookupByLibrary.simpleMessage(
    "你点赞的帖子会显示在这里，按时间倒序排列。",
  ),
  'ui_could_not_load_saved_posts': MessageLookupByLibrary.simpleMessage(
    "无法加载你保存的帖子",
  ),
  'ui_could_not_load_liked_posts': MessageLookupByLibrary.simpleMessage(
    "无法加载你点赞的帖子",
  ),
  'feedTagDetail': (Object tab) => 'Nothing has been posted under #$tab yet.',
  'ui_feed_following_empty': MessageLookupByLibrary.simpleMessage("你关注的人暂无内容"),
  'ui_feed_videos_empty': MessageLookupByLibrary.simpleMessage("还没有视频"),
  'ui_feed_empty': MessageLookupByLibrary.simpleMessage("这里还没有内容"),
  'ui_feed_following_detail': MessageLookupByLibrary.simpleMessage(
    "关注一些账号，他们的帖子会在这里显示。",
  ),
  'ui_feed_videos_detail': MessageLookupByLibrary.simpleMessage(
    "带有视频片段的帖子会显示在这里。",
  ),
  'ui_feed_for_you_detail': MessageLookupByLibrary.simpleMessage(
    "人们发布时，帖子会出现在这里。",
  ),
  'ui_could_not_load_feed': MessageLookupByLibrary.simpleMessage("无法加载你的动态"),
  'ui_share_this_post': MessageLookupByLibrary.simpleMessage("分享此帖子"),
  'ui_like': MessageLookupByLibrary.simpleMessage("赞"),
  'ui_share': MessageLookupByLibrary.simpleMessage("分享"),
  'ui_joined': MessageLookupByLibrary.simpleMessage("已加入"),
  'ui_join': MessageLookupByLibrary.simpleMessage("加入"),
  'ui_turn_sound_on': MessageLookupByLibrary.simpleMessage("打开声音"),
  'ui_turn_sound_off': MessageLookupByLibrary.simpleMessage("关闭声音"),
  'ui_pause': MessageLookupByLibrary.simpleMessage("暂停"),
  'ui_play': MessageLookupByLibrary.simpleMessage("播放"),
  'ui_from_account': MessageLookupByLibrary.simpleMessage("来自账户"),
  'ui_posted_between': MessageLookupByLibrary.simpleMessage("发布于"),
  'ui_after': MessageLookupByLibrary.simpleMessage("之后"),
  'ui_before': MessageLookupByLibrary.simpleMessage("之前"),
  'ui_carrying': MessageLookupByLibrary.simpleMessage("包含"),
};

final messageLookup = MessageLookup();
