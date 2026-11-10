import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "about": MessageLookupByLibrary.simpleMessage("关于"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("添加答案"),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage("同意并继续"),
      "answerNumber": (Object a0) => "第 ${a0} 个答案",
      "arLens": MessageLookupByLibrary.simpleMessage("AR 镜头"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage("附加系统日志"),
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage("一个词、短语或 #tag"),
      "block": MessageLookupByLibrary.simpleMessage("拉黑"),
      "blockAuthor": (Object a0) => "要拉黑 ${a0} 吗？",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage("构建详情已复制"),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "cancel": MessageLookupByLibrary.simpleMessage("取消"),
      "change": MessageLookupByLibrary.simpleMessage("更改"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("更改邮箱"),
      "checkKyronReachable":
          MessageLookupByLibrary.simpleMessage("检查 Kyron 是否可访问"),
      "checkEmailConfirm":
          MessageLookupByLibrary.simpleMessage("请查收邮件以确认你的账户。"),
      "closeCommunity": (Object a0) => "要关闭 ${a0} 吗？",
      "closeIt": MessageLookupByLibrary.simpleMessage("关闭"),
      "closeThisCommunity": MessageLookupByLibrary.simpleMessage("关闭此社区"),
      "confirmPassword": MessageLookupByLibrary.simpleMessage("确认密码"),
      "contactSupport": MessageLookupByLibrary.simpleMessage("联系支持"),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage("使用邮箱继续"),
      "copy": MessageLookupByLibrary.simpleMessage("复制"),
      "copyReportInstead": MessageLookupByLibrary.simpleMessage("改为复制报告"),
      "couldNotOpenGoogleSignIn": (Object a0) => "无法打开 Google 登录。${a0}",
      "couldNotSignOut": (Object a0) => "无法退出：${a0}",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage("无法拍摄该照片。"),
      "country_helper": MessageLookupByLibrary.simpleMessage("显示在你的个人资料和帖子下方。"),
      "country_no_match":
          MessageLookupByLibrary.simpleMessage("没有与“{query}”匹配的国家/地区。"),
      "country_none": MessageLookupByLibrary.simpleMessage("不显示国家/地区"),
      "country_search": MessageLookupByLibrary.simpleMessage("搜索国家/地区"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "显示在你的个人资料和帖子下方。你看到某人的帖子时，你的国家/地区会计入对方的数据洞察，仅以五人或以上的群组统计，绝不显示你的名字。"),
      "country_suggested": MessageLookupByLibrary.simpleMessage("来自你手机的设置"),
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
      "follow_author": MessageLookupByLibrary.simpleMessage("关注 {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("粉丝"),
      "following": MessageLookupByLibrary.simpleMessage("关注"),
      "forgotPassword": MessageLookupByLibrary.simpleMessage("忘记密码？"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage("指南与常见问题解答"),
      "handle": MessageLookupByLibrary.simpleMessage("用户名"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("帮助中心"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("帮助与支持"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("一句话"),
      "ins_account": MessageLookupByLibrary.simpleMessage("你的账号"),
      "ins_act_community": MessageLookupByLibrary.simpleMessage("打开社区"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("写帖子"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("查看帖子"),
      "ins_act_profile": MessageLookupByLibrary.simpleMessage("编辑个人资料"),
      "ins_active": MessageLookupByLibrary.simpleMessage("他们什么时候在"),
      "ins_active_note": MessageLookupByLibrary.simpleMessage("按你的时区显示。"),
      "ins_ages": MessageLookupByLibrary.simpleMessage("年龄"),
      "ins_ages_note":
          MessageLookupByLibrary.simpleMessage("来自填写了生日的 {known} 位被触达者。"),
      "ins_chart": MessageLookupByLibrary.simpleMessage("每日触达人数"),
      "ins_communities": MessageLookupByLibrary.simpleMessage("他们所在的社区"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("国家/地区"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "来自在个人资料中填写了国家/地区的 {known} 位触达用户。"),
      "ins_days": MessageLookupByLibrary.simpleMessage("过去 {days} 天"),
      "ins_failed": MessageLookupByLibrary.simpleMessage("无法加载数据洞察"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("关注者"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage("还没有大到可以显示的群体。"),
      "ins_grow": MessageLookupByLibrary.simpleMessage("如何增长"),
      "ins_interests": MessageLookupByLibrary.simpleMessage("他们关注的话题"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("赞"),
      "ins_new": MessageLookupByLibrary.simpleMessage("新"),
      "ins_new_followers": MessageLookupByLibrary.simpleMessage("新关注者"),
      "ins_no_posts_reached":
          MessageLookupByLibrary.simpleMessage("这段时间里，你的帖子没有触达任何人。"),
      "ins_non_followers": MessageLookupByLibrary.simpleMessage("未关注你的人"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "国家/地区是用户在个人资料中自行选择的。Kyron 不收集任何人的城市或性别，因此没有相关内容可显示。"),
      "ins_opens": MessageLookupByLibrary.simpleMessage("打开次数"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "触达 {reach} · {likes} 个赞 · {replies} 条回复"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("触达人数"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "每个人只计算一次：第一次看到或打开你的某条帖子。新关注者是现在仍在关注你的人；取消关注不计入。"),
      "ins_replies": MessageLookupByLibrary.simpleMessage("回复"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("转发"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("收藏"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "这段时间里有 {floor} 人看过你的帖子后，才会显示你的受众是谁。少于这个数，可能会指向某个具体的人。"),
      "ins_small_title": MessageLookupByLibrary.simpleMessage("人数还不够"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "其中 {pct}% 已经关注你：你的帖子主要触达认识你的人。"),
      "ins_sum_mostly_strangers":
          MessageLookupByLibrary.simpleMessage("其中 {pct}% 还没有关注你：你的帖子正在被发现。"),
      "ins_sum_reach_down_pct":
          MessageLookupByLibrary.simpleMessage("你触达了 {reach} 人，比上一时段少 {pct}%。"),
      "ins_sum_reach_first":
          MessageLookupByLibrary.simpleMessage("过去 {days} 天你触达了 {reach} 人。"),
      "ins_sum_reach_flat":
          MessageLookupByLibrary.simpleMessage("你触达了 {reach} 人，与上一时段差不多。"),
      "ins_sum_reach_none":
          MessageLookupByLibrary.simpleMessage("过去 {days} 天里，没有新的人看到你的帖子。"),
      "ins_sum_reach_up_pct":
          MessageLookupByLibrary.simpleMessage("你触达了 {reach} 人，比上一时段多 {pct}%。"),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "你触达了 {reach} 人，是上一时段的 {times}×。"),
      "ins_sum_top_interest":
          MessageLookupByLibrary.simpleMessage("他们中关注 {name} 的人比关注其他任何话题的都多。"),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("受众"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("概览"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "发现你帖子的人会在关注前先看你的主页。一张脸或一个标志能告诉他们这里有人。"),
      "ins_tip_add_avatar_t": MessageLookupByLibrary.simpleMessage("添加头像"),
      "ins_tip_add_bio":
          MessageLookupByLibrary.simpleMessage("用一句话说明你发什么内容，让陌生人知道关注你能得到什么。"),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("写一段简介"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "你的 {total} 条帖子中有 {without} 条没有话题。话题会把帖子放进该话题的信息流，并展示给关注该话题的人。"),
      "ins_tip_add_topics_t": MessageLookupByLibrary.simpleMessage("给帖子加上话题"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "有 {received} 人回复了你的帖子，你回复了其中 {answered} 条。他们在意到愿意写下来：一句回复能让读者成为常客。"),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("回复你的评论"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "你的受众在{when}最活跃。在那之前不久发的帖子会有人接着看。"),
      "ins_tip_best_time_t": MessageLookupByLibrary.simpleMessage("在他们在的时候发帖"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} 位未关注你的人看到了你的帖子，其中 {gained} 人关注了你。让你的简介和最新帖子说明大家能从你这里期待什么。"),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("把读者变成关注者"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "有一条帖子触达的人数是你其他帖子通常的 {times}×。看看它做了什么不同的事，然后多做一些。"),
      "ins_tip_more_like_top_t": MessageLookupByLibrary.simpleMessage("多做有效的事"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "看到你帖子的人中，很多都在 {name}。在那里发帖能让其余成员也看到你。"),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("在 {name} 发帖"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "你在 {days} 天里发了 {posts} 次帖。每条帖子都是被发现的又一次机会，稳定的节奏能让你留在关注者的信息流里。"),
      "ins_tip_post_more_t": MessageLookupByLibrary.simpleMessage("更频繁地发帖"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "过去 {days} 天你没有发帖。没有帖子，什么都传达不到任何人。"),
      "ins_tip_post_something_t": MessageLookupByLibrary.simpleMessage("发点什么"),
      "ins_title": MessageLookupByLibrary.simpleMessage("数据洞察"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("热门帖子"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage("与前 {days} 天相比"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage("你们双方都会看不到。"),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage("它将从讨论串中移除。"),
      "keepEditing": MessageLookupByLibrary.simpleMessage("继续编辑"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "leave": MessageLookupByLibrary.simpleMessage("离开"),
      "leaveCommunity": (Object a0) => "要退出 ${a0} 吗？",
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
      "postInCommunity": (Object a0) => "在 ${a0} 中发帖",
      "postTextCopied": MessageLookupByLibrary.simpleMessage("帖子文本已复制"),
      "profileUpdated": MessageLookupByLibrary.simpleMessage("个人资料已更新"),
      "profile_country": MessageLookupByLibrary.simpleMessage("国家/地区"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage("推送通知"),
      "quote": MessageLookupByLibrary.simpleMessage("引用"),
      "quotePost": MessageLookupByLibrary.simpleMessage("引用帖子"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("联系真人"),
      "remove": MessageLookupByLibrary.simpleMessage("移除"),
      "removeMember": (Object a0) => "移除 ${a0}？",
      "removeConversation": MessageLookupByLibrary.simpleMessage("移除此对话？"),
      "removeMessage": MessageLookupByLibrary.simpleMessage("移除此消息？"),
      "repliesFollowsMentions":
          MessageLookupByLibrary.simpleMessage("回复、关注与提及"),
      "reply": MessageLookupByLibrary.simpleMessage("回复"),
      "report": MessageLookupByLibrary.simpleMessage("举报"),
      "reportCopied":
          MessageLookupByLibrary.simpleMessage("报告已复制。粘贴到发送给支持的邮件中。"),
      "reportSent": MessageLookupByLibrary.simpleMessage("已发送报告"),
      "repost": MessageLookupByLibrary.simpleMessage("转发"),
      "reset": MessageLookupByLibrary.simpleMessage("重置"),
      "resetPassword": MessageLookupByLibrary.simpleMessage("重置你的密码"),
      "retry": MessageLookupByLibrary.simpleMessage("重试"),
      "save": MessageLookupByLibrary.simpleMessage("保存"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("保存草稿"),
      "saySomething": (Object a0) => "对 ${a0} 说点什么",
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
      "signupFailed": (Object a0) => "注册失败：${a0}",
      "stay": MessageLookupByLibrary.simpleMessage("留下"),
      "systemLog": MessageLookupByLibrary.simpleMessage("系统日志"),
      "tellMissingBroken":
          MessageLookupByLibrary.simpleMessage("告诉我们缺了什么或哪里有问题"),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
        "编辑器没有“发布”按钮",
      ),
      "translate": MessageLookupByLibrary.simpleMessage("翻译"),
      "tryAgain": MessageLookupByLibrary.simpleMessage("重试"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage("我引用这个骗局是为了提醒大家。"),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "说明你为什么认为这个决定是错的：帖子本来的意思、团队可能忽略了什么，或者为什么这条规则不适用。阅读它的人不是做出决定的人。"),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("你的申诉"),
      "ui_appeal_rules":
          MessageLookupByLibrary.simpleMessage("至少写 \$count 个字符。每个决定只能申诉一次。"),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("提交申诉"),
      "ui_appeal_sent":
          MessageLookupByLibrary.simpleMessage("申诉已提交。有结果时你会收到通知。"),
      "ui_appeal_title": MessageLookupByLibrary.simpleMessage("申诉案件 \$number"),
      "ui_cchat_about": MessageLookupByLibrary.simpleMessage("用途（可选）"),
      "ui_cchat_announcements": MessageLookupByLibrary.simpleMessage("仅版主可以发言"),
      "ui_cchat_announcements_detail":
          MessageLookupByLibrary.simpleMessage("用于公告。社区中的所有人仍可阅读并回应。"),
      "ui_cchat_attach": MessageLookupByLibrary.simpleMessage("添加照片或投票"),
      "ui_cchat_attach_gallery": MessageLookupByLibrary.simpleMessage("照片和视频"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("关闭聊天"),
      "ui_cchat_close_detail":
          MessageLookupByLibrary.simpleMessage("之后任何人都无法在其中阅读或发言。此操作无法撤销。"),
      "ui_cchat_close_title": MessageLookupByLibrary.simpleMessage("要关闭这个聊天吗？"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("已复制"),
      "ui_cchat_delete_other":
          MessageLookupByLibrary.simpleMessage("该消息会对所有人删除。Kyron 会保留一份副本以供审核。"),
      "ui_cchat_delete_own":
          MessageLookupByLibrary.simpleMessage("该消息会对聊天中的所有人删除。"),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("编辑聊天"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("编辑"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("已编辑"),
      "ui_cchat_editing": MessageLookupByLibrary.simpleMessage("正在编辑你的消息"),
      "ui_cchat_failed": MessageLookupByLibrary.simpleMessage("无法打开这个聊天。"),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("聊天"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("加入聊天"),
      "ui_cchat_join_community":
          MessageLookupByLibrary.simpleMessage("加入社区即可查看并参与其聊天。"),
      "ui_cchat_joined": MessageLookupByLibrary.simpleMessage("\$count 人已加入"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("退出聊天"),
      "ui_cchat_leave_detail":
          MessageLookupByLibrary.simpleMessage("只要你还在社区中，就仍然可以阅读它。"),
      "ui_cchat_moderators_only":
          MessageLookupByLibrary.simpleMessage("只有所有者和版主可以在这里发言。"),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("静音"),
      "ui_cchat_mute_detail":
          MessageLookupByLibrary.simpleMessage("不会收到它的通知，也不计入“消息”的数量。"),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("聊天名称"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("新建聊天"),
      "ui_cchat_none": MessageLookupByLibrary.simpleMessage("还没有聊天。"),
      "ui_cchat_none_mod":
          MessageLookupByLibrary.simpleMessage("还没有聊天。为社区开一个吧。"),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "社区聊天未采用端到端加密。社区的版主和 Kyron 可以阅读这些内容。"),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("置顶"),
      "ui_cchat_poll_add": MessageLookupByLibrary.simpleMessage("添加选项"),
      "ui_cchat_poll_close": MessageLookupByLibrary.simpleMessage("结束投票"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("已结束"),
      "ui_cchat_poll_detail":
          MessageLookupByLibrary.simpleMessage("所有人都能看到每个选项有多少人选，但看不到是谁。"),
      "ui_cchat_poll_multiple": MessageLookupByLibrary.simpleMessage("允许多选"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("新建投票"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("选择一项"),
      "ui_cchat_poll_option": MessageLookupByLibrary.simpleMessage("选项 \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("投票：\$question"),
      "ui_cchat_poll_question": MessageLookupByLibrary.simpleMessage("问题"),
      "ui_cchat_poll_repeated":
          MessageLookupByLibrary.simpleMessage("同一投票中每个选项只能出现一次。"),
      "ui_cchat_poll_several": MessageLookupByLibrary.simpleMessage("选择一项或多项"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count 人已回答"),
      "ui_cchat_search": MessageLookupByLibrary.simpleMessage("在此聊天中搜索"),
      "ui_cchat_search_hint": MessageLookupByLibrary.simpleMessage("在此聊天中搜索"),
      "ui_cchat_search_none": MessageLookupByLibrary.simpleMessage("未找到任何内容。"),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage("你已无法查看这个聊天。"),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("慢速模式"),
      "ui_cchat_slow_detail":
          MessageLookupByLibrary.simpleMessage("每条消息之间需要等待多久。不适用于版主。"),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 小时"),
      "ui_cchat_slow_minutes": MessageLookupByLibrary.simpleMessage("\$n 分钟"),
      "ui_cchat_slow_mode":
          MessageLookupByLibrary.simpleMessage("慢速模式：每 \$seconds 秒一条消息"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("关闭"),
      "ui_cchat_slow_seconds": MessageLookupByLibrary.simpleMessage("\$n 秒"),
      "ui_cchat_spectator":
          MessageLookupByLibrary.simpleMessage("你可以作为旁观者阅读和回应。加入后即可发言。"),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage("该消息太久远，无法显示。"),
      "ui_cchat_too_large":
          MessageLookupByLibrary.simpleMessage("你选择的某个文件太大，无法发送，已被略去。"),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("取消静音"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("取消置顶"),
      "ui_cchat_voice": MessageLookupByLibrary.simpleMessage("录制语音消息"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("你"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("帖子："),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("群组"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("没有群组"),
      "ui_dm_groups_none_detail":
          MessageLookupByLibrary.simpleMessage("你所在的群组和你加入的社区聊天会显示在这里。"),
      "ui_dm_pin_limit":
          MessageLookupByLibrary.simpleMessage("最多可以置顶 \$count 个聊天。请先取消置顶一个。"),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("已置顶"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("已点赞"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("已保存"),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("正在减弱"),
      "ui_feed_signal_less": MessageLookupByLibrary.simpleMessage("不感兴趣"),
      "ui_feed_signal_more": MessageLookupByLibrary.simpleMessage("显示更多类似内容"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("已移除"),
      "ui_feed_signals": MessageLookupByLibrary.simpleMessage("你的信息流信号"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "在帖子上点按“显示更多类似帖子”或“对此不感兴趣”，它就会出现在这里。"),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("这里还没有内容"),
      "ui_feed_signals_help":
          MessageLookupByLibrary.simpleMessage("“显示更多”和“不感兴趣”在告诉你的信息流什么"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "它们塑造首页和探索，主要依据每条帖子的主题。每个信号每月减弱一半，六个月后不再计入。移除一个即可立即停止。"),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("添加成员"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("添加"),
      "ui_group_add_name": MessageLookupByLibrary.simpleMessage("添加群组名称"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("忽略"),
      "ui_group_e2ee":
          MessageLookupByLibrary.simpleMessage("此群组中的消息与其他对话一样经过端到端加密。"),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor 添加了 \$users"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor 将 \$users 设为管理员"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor 创建了群组"),
      "ui_group_event_join_member":
          MessageLookupByLibrary.simpleMessage("\$actor 设置新成员以成员身份加入"),
      "ui_group_event_join_spectator":
          MessageLookupByLibrary.simpleMessage("\$actor 设置新成员以旁观者身份加入"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor 退出了群组"),
      "ui_group_event_member":
          MessageLookupByLibrary.simpleMessage("\$actor 将 \$users 设为成员"),
      "ui_group_event_owner":
          MessageLookupByLibrary.simpleMessage("\$actor 将 \$users 设为群主"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor 移除了 \$users"),
      "ui_group_event_renamed":
          MessageLookupByLibrary.simpleMessage("\$actor 将群组重命名为 \$title"),
      "ui_group_event_spectator":
          MessageLookupByLibrary.simpleMessage("\$actor 将 \$users 设为旁观者"),
      "ui_group_full":
          MessageLookupByLibrary.simpleMessage("一个群组最多可有 \$count 人。"),
      "ui_group_hand_raised":
          MessageLookupByLibrary.simpleMessage("已举手。已通知管理员。"),
      "ui_group_hands": MessageLookupByLibrary.simpleMessage("\$count 人请求发言"),
      "ui_group_hands_heading": MessageLookupByLibrary.simpleMessage("请求发言"),
      "ui_group_join_spectators":
          MessageLookupByLibrary.simpleMessage("之后加入的人以旁观者身份加入"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("退出群组"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "它会从你的列表中消失，你将看不到之后的内容。需要有人重新添加你。"),
      "ui_group_leave_title": MessageLookupByLibrary.simpleMessage("要退出此群组吗？"),
      "ui_group_let_write": MessageLookupByLibrary.simpleMessage("允许发言"),
      "ui_group_lower_hand": MessageLookupByLibrary.simpleMessage("放下手"),
      "ui_group_make_admin": MessageLookupByLibrary.simpleMessage("设为管理员"),
      "ui_group_make_owner": MessageLookupByLibrary.simpleMessage("设为群主"),
      "ui_group_make_spectator": MessageLookupByLibrary.simpleMessage("设为旁观者"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count 位成员"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("成员"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("群组名称"),
      "ui_group_name_first": MessageLookupByLibrary.simpleMessage("请先为群组命名。"),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("创建群聊"),
      "ui_group_owner_detail":
          MessageLookupByLibrary.simpleMessage("群主只有一位。你将继续担任管理员。"),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("要将 \$name 设为群主吗？"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("举手"),
      "ui_group_remove": MessageLookupByLibrary.simpleMessage("移出群组"),
      "ui_group_remove_admin": MessageLookupByLibrary.simpleMessage("取消管理员"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage("你已不在此群组中。"),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("重命名"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("管理员"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("成员"),
      "ui_group_role_spectator": MessageLookupByLibrary.simpleMessage("旁观者"),
      "ui_group_spectator_note":
          MessageLookupByLibrary.simpleMessage("作为旁观者，你可以在这里阅读和回应。"),
      "ui_group_spectators_detail":
          MessageLookupByLibrary.simpleMessage("旁观者可以阅读、回应，并举手请求发言。"),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("建议"),
      "ui_group_view_profile": MessageLookupByLibrary.simpleMessage("查看个人资料"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("你"),
      "ui_group_you_spectate": MessageLookupByLibrary.simpleMessage("你是旁观者"),
      "ui_language_detail": MessageLookupByLibrary.simpleMessage("选择你的语言"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("你的账号已更新"),
      "ui_notif_appeal_accepted":
          MessageLookupByLibrary.simpleMessage("你对案件 \$number 的申诉已被接受"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "我们重新审核了你对案件 \$number 的申诉，原决定维持不变"),
      "ui_notif_banned": MessageLookupByLibrary.simpleMessage("你的账号已被永久封禁"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("案件 \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("关注了你"),
      "ui_notif_liked": MessageLookupByLibrary.simpleMessage("赞了你的帖子"),
      "ui_notif_mentioned": MessageLookupByLibrary.simpleMessage("提到了你"),
      "ui_notif_no_mentions": MessageLookupByLibrary.simpleMessage("还没有人提到你"),
      "ui_notif_no_mentions_detail":
          MessageLookupByLibrary.simpleMessage("当有人在帖子或回复中写下你的 @用户名 时，会显示在这里。"),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("更早"),
      "ui_notif_removed_message":
          MessageLookupByLibrary.simpleMessage("你在社区聊天中的消息已被移除"),
      "ui_notif_removed_other":
          MessageLookupByLibrary.simpleMessage("你发布的内容已被移除"),
      "ui_notif_removed_post": MessageLookupByLibrary.simpleMessage("你的帖子已被移除"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("你的回复已被移除"),
      "ui_notif_replied": MessageLookupByLibrary.simpleMessage("回复了你的帖子"),
      "ui_notif_report_actioned":
          MessageLookupByLibrary.simpleMessage("我们已对你举报的内容采取措施。感谢你告诉我们。"),
      "ui_notif_report_dismissed":
          MessageLookupByLibrary.simpleMessage("我们审核了你举报的内容，未发现其违反我们的规则。"),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("举报理由：\$reason"),
      "ui_notif_reposted": MessageLookupByLibrary.simpleMessage("转发了你的帖子"),
      "ui_notif_reversed":
          MessageLookupByLibrary.simpleMessage("我们撤销了案件 \$number 的决定"),
      "ui_notif_suspended": MessageLookupByLibrary.simpleMessage("你的账号已被暂停"),
      "ui_notif_suspended_until":
          MessageLookupByLibrary.simpleMessage("你的账号已被暂停至 \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("全部"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("关注"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("赞"),
      "ui_notif_tab_mentions": MessageLookupByLibrary.simpleMessage("提及"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("回复"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("本周"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("今天"),
      "ui_notif_warned": MessageLookupByLibrary.simpleMessage("你的账号收到了一次警告"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("昨天"),
      "ui_once_already": MessageLookupByLibrary.simpleMessage("此内容已被打开过。"),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("已过期"),
      "ui_once_failed": MessageLookupByLibrary.simpleMessage("无法打开。"),
      "ui_once_hint":
          MessageLookupByLibrary.simpleMessage("只能打开一次，之后会从 Kyron 删除。"),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("仅看一次"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("已打开"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("\$total 人中有 \$count 人已打开"),
      "ui_once_own":
          MessageLookupByLibrary.simpleMessage("只有你发送的对象可以打开，且只能打开一次。"),
      "ui_once_send": MessageLookupByLibrary.simpleMessage("以仅看一次的方式发送"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("点按查看"),
      "ui_report_add": MessageLookupByLibrary.simpleMessage("还有要补充的吗？（可选）"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "团队作出决定后你会收到通知，也可以在“你的举报”中查看进展。"),
      "ui_report_mute_block":
          MessageLookupByLibrary.simpleMessage("如果你也不想再看到对方，可以在同一菜单中将其静音或屏蔽。"),
      "ui_report_once":
          MessageLookupByLibrary.simpleMessage("重复举报同一内容不会增加分量：每人只保留一份举报。"),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "你的举报不会告知对方。我们会保留你举报内容的副本，即使内容被删除也能审核。"),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "你的举报已收到，正在排队等待审核。我们不会告诉对方是谁举报的。"),
      "ui_report_see_reports": MessageLookupByLibrary.simpleMessage("查看你的举报"),
      "ui_report_tell_us": MessageLookupByLibrary.simpleMessage("告诉我们哪里有问题"),
      "ui_report_thanks": MessageLookupByLibrary.simpleMessage("感谢你告诉我们"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("\$name 有什么问题？"),
      "ui_report_what_message":
          MessageLookupByLibrary.simpleMessage("这条消息有什么问题？"),
      "ui_report_what_post": MessageLookupByLibrary.simpleMessage("这个帖子有什么问题？"),
      "ui_report_what_reply":
          MessageLookupByLibrary.simpleMessage("这条回复有什么问题？"),
      "ui_reports_a_message": MessageLookupByLibrary.simpleMessage("一条社区聊天消息"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("一篇帖子"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("一条回复"),
      "ui_reports_actioned": MessageLookupByLibrary.simpleMessage("已采取措施"),
      "ui_reports_an_account": MessageLookupByLibrary.simpleMessage("一个账号"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("\$date 作出决定"),
      "ui_reports_dismissed": MessageLookupByLibrary.simpleMessage("未违反规则"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage("无法加载你的举报"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "你在过去 90 天内举报的内容及处理结果。团队作出决定时你会收到通知。被你举报的人永远不会得知是谁举报了他们。"),
      "ui_reports_none": MessageLookupByLibrary.simpleMessage("没有举报"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "当你举报帖子、回复、消息或账号时，它会和处理结果一起显示在这里。"),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("审核中"),
      "ui_reports_sent_on": MessageLookupByLibrary.simpleMessage("\$date 举报"),
      "ui_reports_settings_help":
          MessageLookupByLibrary.simpleMessage("你举报的内容及处理结果"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("你的举报"),
      "ui_rule_child_safety": MessageLookupByLibrary.simpleMessage("儿童安全"),
      "ui_rule_detail_child_safety":
          MessageLookupByLibrary.simpleMessage("任何危害未成年人或将其性化的内容。"),
      "ui_rule_detail_harassment":
          MessageLookupByLibrary.simpleMessage("针对性的辱骂、威胁或不受欢迎的联系。"),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage("因身份而攻击他人。"),
      "ui_rule_detail_illegal_goods":
          MessageLookupByLibrary.simpleMessage("销售或宣传违法的东西。"),
      "ui_rule_detail_impersonation":
          MessageLookupByLibrary.simpleMessage("冒充他人。"),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage("未经许可使用你的作品或商标。"),
      "ui_rule_detail_misinformation":
          MessageLookupByLibrary.simpleMessage("关于健康、选举或事件的误导性说法。"),
      "ui_rule_detail_self_harm":
          MessageLookupByLibrary.simpleMessage("鼓励或展示自残。"),
      "ui_rule_detail_sexual_content":
          MessageLookupByLibrary.simpleMessage("未加警告就展示的色情内容。"),
      "ui_rule_detail_something_else":
          MessageLookupByLibrary.simpleMessage("以上都不是。告诉我们哪里有问题。"),
      "ui_rule_detail_spam":
          MessageLookupByLibrary.simpleMessage("重复、误导或不受欢迎的推广。"),
      "ui_rule_detail_violence":
          MessageLookupByLibrary.simpleMessage("威胁、美化或煽动暴力。"),
      "ui_rule_harassment": MessageLookupByLibrary.simpleMessage("骚扰或霸凌"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("仇恨言论"),
      "ui_rule_illegal_goods": MessageLookupByLibrary.simpleMessage("非法商品或服务"),
      "ui_rule_impersonation": MessageLookupByLibrary.simpleMessage("冒充他人"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("知识产权"),
      "ui_rule_misinformation": MessageLookupByLibrary.simpleMessage("虚假信息"),
      "ui_rule_self_harm": MessageLookupByLibrary.simpleMessage("自杀或自残"),
      "ui_rule_sexual_content": MessageLookupByLibrary.simpleMessage("成人内容"),
      "ui_rule_something_else": MessageLookupByLibrary.simpleMessage("其他"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("垃圾信息"),
      "ui_rule_violence": MessageLookupByLibrary.simpleMessage("暴力或威胁"),
      "ui_share_quote": MessageLookupByLibrary.simpleMessage("引用"),
      "ui_share_send_message": MessageLookupByLibrary.simpleMessage("通过私信发送"),
      "ui_share_send_message_detail":
          MessageLookupByLibrary.simpleMessage("发给 Kyron 上的人"),
      "ui_standing_about": MessageLookupByLibrary.simpleMessage("涉及的内容"),
      "ui_standing_account_banned":
          MessageLookupByLibrary.simpleMessage("你的账号已被永久封禁"),
      "ui_standing_answer": MessageLookupByLibrary.simpleMessage("答复，\$date："),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("申诉"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("对此决定提出申诉"),
      "ui_standing_appeal_closed":
          MessageLookupByLibrary.simpleMessage("此决定已无法申诉。如有问题，请联系客服。"),
      "ui_standing_appeal_open": MessageLookupByLibrary.simpleMessage("申诉审核中"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("申诉已通过"),
      "ui_standing_appeal_pending":
          MessageLookupByLibrary.simpleMessage("团队中的其他人正在重新审核。有结果时你会收到通知。"),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "如果你认为这是错误，可以在 \$date 之前请求重新审核。由团队中的其他人决定。"),
      "ui_standing_appeal_upheld":
          MessageLookupByLibrary.simpleMessage("已申诉：维持原决定"),
      "ui_standing_ban_case":
          MessageLookupByLibrary.simpleMessage("案件 \$number。规则：\$rule。团队写道："),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "删除账号不会解除封禁：使用同一邮箱地址的新账号同样会被封禁。"),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("永久封禁"),
      "ui_standing_banned_detail":
          MessageLookupByLibrary.simpleMessage("只有此页面、申诉、客服和删除账号仍可使用。"),
      "ui_standing_can_appeal": MessageLookupByLibrary.simpleMessage("可申诉"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("案件 \$number"),
      "ui_standing_decided": MessageLookupByLibrary.simpleMessage("决定于 \$date"),
      "ui_standing_decisions": MessageLookupByLibrary.simpleMessage("关于你账号的决定"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("删除你的账号"),
      "ui_standing_details": MessageLookupByLibrary.simpleMessage("查看详情"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("查看详情并申诉"),
      "ui_standing_ends": MessageLookupByLibrary.simpleMessage("结束于 \$date"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage("你的账号状态良好"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("没有任何限制。"),
      "ui_standing_load_failed":
          MessageLookupByLibrary.simpleMessage("无法加载账号状态"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("消息已移除"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "尚未对你的账号做出任何决定。如果团队移除了你的内容或限制了你的账号，会连同原因显示在这里，你也可以申诉。"),
      "ui_standing_nothing_to_appeal":
          MessageLookupByLibrary.simpleMessage("无需申诉：此决定已撤销。"),
      "ui_standing_post_removed": MessageLookupByLibrary.simpleMessage("帖子已移除"),
      "ui_standing_pull_to_check":
          MessageLookupByLibrary.simpleMessage("下拉以重新检查。"),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("阅读 Kyron 的规则"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("回复已移除"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("已撤销"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "已于 \$date 撤销。被移除的内容已恢复，所有限制均已解除。"),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("规则：\$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("退出登录"),
      "ui_standing_suspended": MessageLookupByLibrary.simpleMessage("已暂停"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "你可以浏览，但不能发帖、回复、关注或发消息。举报、屏蔽和静音仍然可用。"),
      "ui_standing_suspended_toast":
          MessageLookupByLibrary.simpleMessage("你的账号已被暂停：可以浏览，但不能发帖。"),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("暂停至 \$date"),
      "ui_standing_suspended_until_toast":
          MessageLookupByLibrary.simpleMessage("你的账号已被暂停至 \$date：可以浏览，但不能发帖。"),
      "ui_standing_team_said": MessageLookupByLibrary.simpleMessage("团队的说明"),
      "ui_standing_title": MessageLookupByLibrary.simpleMessage("账号状态"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("警告"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("为什么？"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("你于 \$date 写道："),
      "ui_standing_your_message": MessageLookupByLibrary.simpleMessage("你的消息"),
      "ui_standing_your_post": MessageLookupByLibrary.simpleMessage("你的帖子"),
      "ui_standing_your_reply": MessageLookupByLibrary.simpleMessage("你的回复"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("重试"),
      "ui_undo": MessageLookupByLibrary.simpleMessage("撤销"),
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
      "normalised": (Object a0) => "#\\${a0}",
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
          "Google 通过仅 Android 和 iOS 能响应的链接把完成的登录交回 Kyron，因此在 ${a0} 上，浏览器将无处可返回。\\n\\n如果你已经用 Google 在 Kyron 上有账户，请用相同地址选择“使用邮箱继续”，然后点“忘记密码”——我们会给你发一封设置密码的链接。",
      "loginFailed": MessageLookupByLibrary.simpleMessage("登录失败。请检查你的凭据。"),
      "email": MessageLookupByLibrary.simpleMessage("邮箱"),
      "password": MessageLookupByLibrary.simpleMessage("密码"),
      "login": MessageLookupByLibrary.simpleMessage("登录"),
      "or": MessageLookupByLibrary.simpleMessage("或"),
      "username": MessageLookupByLibrary.simpleMessage("用户名"),
      "usernameRule":
          MessageLookupByLibrary.simpleMessage("用户名必须为小写（a-z、0-9、_）"),
      "passwordTooShort": MessageLookupByLibrary.simpleMessage("密码过短"),
      "continueAction": MessageLookupByLibrary.simpleMessage("继续"),
      "bySigningUpAgreeTerms":
          MessageLookupByLibrary.simpleMessage("注册即表示你同意我们的"),
      "terms": MessageLookupByLibrary.simpleMessage("服务条款"),
      "and": MessageLookupByLibrary.simpleMessage("和"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
      "googleSignIn": MessageLookupByLibrary.simpleMessage("使用 Google 登录"),
      "googleSignUp": MessageLookupByLibrary.simpleMessage("使用 Google 注册"),
      "googleContinue": MessageLookupByLibrary.simpleMessage("使用 Google 继续"),
      "byContinuingAgreeTerms":
          MessageLookupByLibrary.simpleMessage("继续即表示你同意我们的"),
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
      "literalkyronDidNotAnswer":
          MessageLookupByLibrary.simpleMessage("Kyron 未响应"),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage("尚无日志"),
      "literalswitchCamera": MessageLookupByLibrary.simpleMessage("切换摄像头"),
      "literaltheCameraIsClosed":
          MessageLookupByLibrary.simpleMessage("摄像头已关闭"),
      "literaltakeAPicture": MessageLookupByLibrary.simpleMessage("拍照"),
      "literallensNameFaceLens": (Object a0) => "${a0}，人脸镜头",
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
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
        "无法加载你的社区",
      ),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
        "你尚未加入任何社区",
      ),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
        "无法加载社区",
      ),
      "literalpostInWidgetCommunityName": (Object a0) => "在 ${a0} 中发帖",
      "literalsaySomethingToWidgetCommunityName": (Object a0) => "对 ${a0} 说点什么",
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("提及某人"),
      "literalcloseWidgetCommunityName": (Object a0) => "要关闭 ${a0} 吗？",
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
        "只有所有者可以更改此项",
      ),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage("点按横幅或图片以更换"),
      "literalremoveMemberDisplayname": (Object a0) => "移除 ${a0}？",
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
        "无法加载成员列表",
      ),
      "literalnobodyHereYet": MessageLookupByLibrary.simpleMessage("这里还没有人"),
      "literalmakeAModerator": MessageLookupByLibrary.simpleMessage("设为版主"),
      "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage("取消版主"),
      "literalremoveFromCommunity":
          MessageLookupByLibrary.simpleMessage("从社区移除"),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
        "无法加载此列表",
      ),
      "literalnobodyHasBeenRemoved": MessageLookupByLibrary.simpleMessage(
        "尚未移除任何人",
      ),
      "literalpostInCommunityName": (Object a0) => "在 ${a0} 中发帖",
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
        "无法打开此社区",
      ),
      "literalthisCommunity": MessageLookupByLibrary.simpleMessage("此社区"),
      "literalshareThisCommunity":
          MessageLookupByLibrary.simpleMessage("分享此社区"),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("复制链接"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("链接已复制"),
      "literalleaveCommunityName": (Object a0) => "要退出 ${a0} 吗？",
      "literalyouHaveLeftCommunityName": (Object a0) => "你已退出 ${a0}",
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("添加视频"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("添加 GIF"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage("录制语音帖"),
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage("移除投票"),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("添加投票"),
      "literaladdAHashtag": MessageLookupByLibrary.simpleMessage("添加话题标签"),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage("草稿已保存"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("暂无草稿"),
      "literalnothingIsTrendingYet":
          MessageLookupByLibrary.simpleMessage("暂时没有热点"),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalsendTheLink": MessageLookupByLibrary.simpleMessage("发送链接"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
        "打开来自 Kyron 的邮件",
      ),
      "literaltapTheLinkInsideIt":
          MessageLookupByLibrary.simpleMessage("点开其中的链接"),
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
        "设置密码并继续",
      ),
      "literalsendAgainInCooldownS": (Object a0) => "在 ${a0}s 后可重发",
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("再次发送"),
      "literalnormalised": (Object a0) => "#${a0}",
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
      "literalyouAreAllCaughtUp":
          MessageLookupByLibrary.simpleMessage("你已全部看完"),
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
      "literalshareThisProfile":
          MessageLookupByLibrary.simpleMessage("分享此个人资料"),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
        "无法加载这些帖子",
      ),
      "literalyouHaveNotPostedYet":
          MessageLookupByLibrary.simpleMessage("你还没有发过帖"),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage("暂无帖子"),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
        "暂时没有可看的内容",
      ),
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("继续输入"),
      "literalsearchFailed": MessageLookupByLibrary.simpleMessage("搜索失败"),
      "literalnothingMatched": MessageLookupByLibrary.simpleMessage("没有匹配项"),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) => "无法退出：${a0}",
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
      "literalremoveLanguageEnglishname": (Object a0) => "移除 ${a0}",
      "literalsentItIsReportFiledNumber": (Object a0) => "已发送。这是报告 #${a0}。",
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
        "当前无法发送反馈",
      ),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage("你做了什么、期望什么、发生了什么 "),
      "literalverificationFailedDescribeapierrorE": (Object a0) => "验证失败：${a0}",
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
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
        "无法加载此对话",
      ),
      "literalsaySomething": MessageLookupByLibrary.simpleMessage("说点什么"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("复制文本"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("请勿回复"),
      "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage("从已保存中移除"),
      "literalturnSoundOn": MessageLookupByLibrary.simpleMessage("打开声音"),
      "literalturnSoundOff": MessageLookupByLibrary.simpleMessage("关闭声音"),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
        "此链接无法在这里打开。",
      ),
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage("此设备上没有浏览器能处理该链接。"),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("打开回复"),
      "literallabelCount": (Object a0, Object a1) => "${a0}，${a1}",
      "literalindex1": (Object a0) => "${a0}",
      "literalfirstyearIndex": (Object a0) => "${a0}",
      "literalgifsAreNotSetUp":
          MessageLookupByLibrary.simpleMessage("GIF 功能尚未设置"),
      "literalcouldNotLoadGifs":
          MessageLookupByLibrary.simpleMessage("无法加载 GIF"),
      "literalnothingFound": MessageLookupByLibrary.simpleMessage("未找到任何内容"),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
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
      "literalremoveLabel": (Object a0) => "移除 ${a0}",
      "literaladdLabelAsATab": (Object a0) => "将 ${a0} 添加为标签页",
      "literalcouldNotSearch": MessageLookupByLibrary.simpleMessage("无法搜索"),
      "literalwhoDoYouWantToTag":
          MessageLookupByLibrary.simpleMessage("你想提及谁？"),
      "literalnobodyFound": MessageLookupByLibrary.simpleMessage("未找到任何人"),
      "literalshowPassword": MessageLookupByLibrary.simpleMessage("显示密码"),
      "literalhidePassword": MessageLookupByLibrary.simpleMessage("隐藏密码"),
      "literaltranslatePost": MessageLookupByLibrary.simpleMessage("翻译帖子"),
      "literalcopyPostText": MessageLookupByLibrary.simpleMessage("复制帖子文本"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage("复制帖子链接"),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
        "显示更多类似的帖子",
      ),
      "literalnotInterestedInThis":
          MessageLookupByLibrary.simpleMessage("对此不感兴趣"),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage("将其隐藏，并提示我们少展示类似内容"),
      "literalhideThisPost": MessageLookupByLibrary.simpleMessage("隐藏此帖子"),
      "literalmuteThisThread":
          MessageLookupByLibrary.simpleMessage("将此讨论串设为静音"),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage("不再看到此帖及其回复"),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage("屏蔽词语或标签"),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
        "浏览、点赞、收藏和评论",
      ),
      "literalwhoCanReply": MessageLookupByLibrary.simpleMessage("谁可以回复"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("删除帖子"),
      "literalmuteAuthor": (Object a0) => "静音 ${a0}",
      "literalblockAuthor": (Object a0) => "拉黑 ${a0}",
      "literalreportPost": MessageLookupByLibrary.simpleMessage("举报帖子"),
      "literalreportAuthor": (Object a0) => "举报 ${a0}",
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
        "未成功发送。请重试。",
      ),
      "literalblockAuthor2": (Object a0) => "要拉黑 ${a0} 吗？",
      "literalshowResults": MessageLookupByLibrary.simpleMessage("显示结果"),
      "literallabelDate": (Object a0) => "\\${a0} 日期",
      "literalshareVia": MessageLookupByLibrary.simpleMessage("通过…分享"),
      "literalhandItToAnotherApp":
          MessageLookupByLibrary.simpleMessage("交给其他应用处理"),
      "literalshareWithAQuote": MessageLookupByLibrary.simpleMessage("带引用分享"),
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
        "在上方加上你的话后发布",
      ),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage("已保存的帖子"),
      "literallikedPosts": MessageLookupByLibrary.simpleMessage("点赞的帖子"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) => "故事栏，共 ${a0} 项",
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
        "你发布的内容归你所有",
      ),
      "literalwhatKyronKeeps":
          MessageLookupByLibrary.simpleMessage("Kyron 保留哪些内容"),
      "literalhowToBehave": MessageLookupByLibrary.simpleMessage("行为规范"),
      "literalcloseTabLabel": (Object a0) => "关闭 ${a0}",
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("已打开 1 个页面"),
      "literalcountPagesOpen": (Object a0) => "已打开 ${a0} 个页面",
      "literalstopLoading": MessageLookupByLibrary.simpleMessage("停止加载"),
      "literalshareThisPage": MessageLookupByLibrary.simpleMessage("分享此页面"),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "此设备上没有应用可打开 ${a0} 链接。",
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
          "Kyron 的界面已使用你的语言。如果某个词读起来不对，请通过“发送反馈”告诉我们。"),
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
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "跳过",
      ),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
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
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage(
        "刚刚",
      ),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage(
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
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage(
        "它自己的。",
      ),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage(
        "再试一次",
      ),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage(
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
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage(
        "为你",
      ),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("你的标签页"),
      "audit_media_tray_alt_784030d4":
          MessageLookupByLibrary.simpleMessage("+ 替代文本"),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("再试一次"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("符号 (!@#…)"),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("无法加载"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("此帖子"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
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
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage(
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
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
        "按账号或显示名称搜索。",
      ),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
        "关键词，或按筛选条件—账号、日期范围，或帖子的附带内容。",
      ),
      "ui_two_characters_or_more":
          MessageLookupByLibrary.simpleMessage("两个字符或更多。"),
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
      "ui_posts_hidden":
          MessageLookupByLibrary.simpleMessage("已隐藏。我们会减少类似内容的展示。"),
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
      "ui_settings_content_display":
          MessageLookupByLibrary.simpleMessage("内容与显示"),
      "ui_settings_app_device": MessageLookupByLibrary.simpleMessage("应用与设备"),
      "ui_settings_data_saver": MessageLookupByLibrary.simpleMessage("省流量"),
      "ui_settings_language_detail":
          MessageLookupByLibrary.simpleMessage("选择你的语言"),
      "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
        "通知偏好",
      ),
      "ui_settings_help_articles":
          MessageLookupByLibrary.simpleMessage("浏览帮助文章"),
      "ui_settings_team_help":
          MessageLookupByLibrary.simpleMessage("向我们的团队寻求帮助"),
      "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
        "告诉我们你的想法",
      ),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
        "无法加载你的个人资料",
      ),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("搜索用户"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("搜索帖子"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("这条帖子"),
      "authorPostsHidden": (Object a0) => "你将看不到来自 ${a0} 的帖子",
      "authorBlocked": (Object a0) => "${a0} 已被屏蔽",
      "nothingMatchesQuery": (Object a0) => "Kyron 上没有匹配 \"${a0}\" 的内容",
      "repliesPolicy": (Object a0) => "回复：${a0}",
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
      "feedTagDetail": (Object a0) => "还没有人在 #${a0} 下发布内容。",
      "ui_feed_following_empty":
          MessageLookupByLibrary.simpleMessage("你关注的人暂无内容"),
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
      "ui_could_not_load_feed":
          MessageLookupByLibrary.simpleMessage("无法加载你的动态"),
      "ui_share_this_post": MessageLookupByLibrary.simpleMessage("分享此帖子"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
        "不同的人数，而不是打开次数",
      ),
      "analytics_engagement": MessageLookupByLibrary.simpleMessage("互动"),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("发布时间"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("查看者"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("喜欢"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("评论"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("收藏"),
      "analytics_no_viewers_yet":
          MessageLookupByLibrary.simpleMessage("还没有查看者"),
      "analytics_viewers_per_day":
          MessageLookupByLibrary.simpleMessage("每日查看者"),
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
      "interest_drag_to_reorder":
          MessageLookupByLibrary.simpleMessage("拖动以重新排序"),
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
          "这会更改 Kyron 自身的文字、由 Flutter 自行绘制的界面部分、日期和数字，以及从右到左书写的语言中应用的布局方向。"),
      "theme_system_detail":
          MessageLookupByLibrary.simpleMessage("跟随手机的浅色或深色设置"),
      "theme_light_detail": MessageLookupByLibrary.simpleMessage("始终使用浅色"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("始终使用深色"),
      "theme_dim_detail":
          MessageLookupByLibrary.simpleMessage("更柔和的深色，蓝灰色而不是黑色"),
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
      "create_text_post": MessageLookupByLibrary.simpleMessage("文字帖"),
      "create_voice_post": MessageLookupByLibrary.simpleMessage("语音帖"),
      "create_ar_lens": MessageLookupByLibrary.simpleMessage("AR 镜头"),
      "create_go_live": MessageLookupByLibrary.simpleMessage("开始直播"),
      "voice_record_post": MessageLookupByLibrary.simpleMessage("录制语音帖"),
      "voice_recording": MessageLookupByLibrary.simpleMessage("录音中…"),
      "voice_ready_attach": MessageLookupByLibrary.simpleMessage("准备附加"),
      "voice_stop": MessageLookupByLibrary.simpleMessage("停止"),
      "voice_attach": MessageLookupByLibrary.simpleMessage("附加"),
      "draft_close_composer_detail": MessageLookupByLibrary.simpleMessage(
        "在编辑器中写下内容后关闭，就会为你提供草稿。",
      ),
      "draft_poll_empty": MessageLookupByLibrary.simpleMessage("尚未填写问题的投票"),
      "draft_quote_empty": MessageLookupByLibrary.simpleMessage("尚未填写内容的引用"),
      "draft_nothing_empty": MessageLookupByLibrary.simpleMessage("还没有内容"),
      "draft_just_now": MessageLookupByLibrary.simpleMessage("刚刚"),
      "draft_minutes_ago":
          MessageLookupByLibrary.simpleMessage("{minutes} 分钟前"),
      "draft_hours_ago": MessageLookupByLibrary.simpleMessage("{hours} 小时前"),
      "draft_days_ago": MessageLookupByLibrary.simpleMessage("{days} 天前"),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("你回复了"),
      "dmReplied": (Object a0) => "$a0 回复了",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("添加到消息"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("新消息"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage("还没有说过话。挥个手是个好开始。"),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  挥手"),
      "ui_dm_new_messages": MessageLookupByLibrary.simpleMessage("新消息"),
      "dmTyping": (Object a0) => "$a0 正在输入",
      "ui_dm_reaction_remove": MessageLookupByLibrary.simpleMessage("移除你的回应"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("某人"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("消息"),
      "ui_dm_quote_attachment": MessageLookupByLibrary.simpleMessage("附件"),
      "ui_dm_unreadable":
          MessageLookupByLibrary.simpleMessage("无法在此设备上阅读这条消息。"),
      "ui_dm_waiting":
          MessageLookupByLibrary.simpleMessage("正在等待这条消息。这可能需要一些时间。"),
      "ui_dm_preview_sealed": MessageLookupByLibrary.simpleMessage("加密消息"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage("消息已端到端加密"),
      "ui_dm_not_encrypted": MessageLookupByLibrary.simpleMessage("未端到端加密"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("已发送"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("已读"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("正在发送…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("拍照"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("更多选项"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("保存到设备"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("分享"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("正在保存…"),
      "ui_media_saved": MessageLookupByLibrary.simpleMessage("已保存到你的照片"),
      "ui_media_save_failed": MessageLookupByLibrary.simpleMessage("无法保存，请重试。"),
      "ui_media_save_denied":
          MessageLookupByLibrary.simpleMessage("请允许 Kyron 添加到你的照片以保存此内容。"),
      "ui_status_all_ok": MessageLookupByLibrary.simpleMessage("所有系统运行正常"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("正常运行时间"),
      "ui_status_last_60": MessageLookupByLibrary.simpleMessage("过去 60 天"),
      "ui_status_60_days_ago": MessageLookupByLibrary.simpleMessage("60 天前"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("今天"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("数据库"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("登录"),
      "ui_status_incidents": MessageLookupByLibrary.simpleMessage("近期事件"),
      "ui_status_no_incidents":
          MessageLookupByLibrary.simpleMessage("过去 60 天内没有事件。"),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("进行中"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("无数据"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("详细信息"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron 运行期间每 5 分钟自检一次。灰色的日子没有检查记录。"),
      "ui_status_unavailable":
          MessageLookupByLibrary.simpleMessage("暂无正常运行时间记录。"),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage("部分系统出现问题"),
      "ui_dm_voice": MessageLookupByLibrary.simpleMessage("录制语音消息"),
      "voice_ready_send": MessageLookupByLibrary.simpleMessage("准备发送"),
      "ui_dm_quote_gone": MessageLookupByLibrary.simpleMessage("该消息已不在。"),
      "ui_dm_quote_open": MessageLookupByLibrary.simpleMessage("前往该消息"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("语音消息"),
      "ui_liked_by_author": MessageLookupByLibrary.simpleMessage("作者已点赞"),
      "ui_add_photo_or_clip": MessageLookupByLibrary.simpleMessage("添加照片或短片"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("媒体"),
      "ui_dm_info_voice_notes": MessageLookupByLibrary.simpleMessage("语音消息"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("聊天"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("壁纸"),
      "ui_dm_info_mute_row": MessageLookupByLibrary.simpleMessage("关闭通知"),
      "ui_dm_info_mute_detail":
          MessageLookupByLibrary.simpleMessage("不再接收此对话的通知"),
      "ui_dm_info_block_detail":
          MessageLookupByLibrary.simpleMessage("对方将无法再给你发消息"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("无"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("照片"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("已取消静音。"),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage("无法移除，请重试。"),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("个人资料"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("取消静音"),
      "ui_dm_info_no_media":
          MessageLookupByLibrary.simpleMessage("你分享的照片和短片会显示在这里。"),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("查看全部"),
      "ui_dm_media_tab": MessageLookupByLibrary.simpleMessage("照片和短片"),
      "ui_dm_wallpaper_sample_theirs":
          MessageLookupByLibrary.simpleMessage("聊天效果如下。"),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("看起来不错。"),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("薄雾"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("黄昏"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("鼠尾草"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("沙"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("圆点"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("应用"),
      "ui_dm_wallpaper_current": MessageLookupByLibrary.simpleMessage("当前"),
      "ui_dm_link_card_remove": MessageLookupByLibrary.simpleMessage("不带预览发送"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("搜索"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("发帖"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("写条消息…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("发送"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("已发送"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("已发送，但有人没收到。"),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage("无法发送。请重试。"),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("粉丝"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("筛选"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("全部"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("未读"),
      "ui_dm_filter_unanswered": MessageLookupByLibrary.simpleMessage("未回复"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("已隐藏"),
      "ui_dm_hidden_none": MessageLookupByLibrary.simpleMessage("没有隐藏的对话"),
      "ui_dm_hidden_none_detail":
          MessageLookupByLibrary.simpleMessage("你从列表中移除的对话会在这里等着，以防你想找回。"),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "它会移到已隐藏。对方保留自己的对话，你们任何一方再发消息时它就会回来。"),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("放回"),
      "ui_dm_restored": MessageLookupByLibrary.simpleMessage("已回到你的列表。"),
      "ui_dm_search_none": MessageLookupByLibrary.simpleMessage("没有匹配的对话。"),
      "ui_dm_unanswered_none": MessageLookupByLibrary.simpleMessage("没有在等你回复的"),
      "ui_dm_unanswered_none_detail":
          MessageLookupByLibrary.simpleMessage("每段对话都以你的话结束。"),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("照片"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("照片"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("视频"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none": MessageLookupByLibrary.simpleMessage("还没有消息"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("你："),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("昨天"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("消息"),
      "ui_dm_settings_open": MessageLookupByLibrary.simpleMessage("消息设置"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("隐私"),
      "ui_dm_read_receipts": MessageLookupByLibrary.simpleMessage("已读回执"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "关闭后，别人看不到你何时读了他们的消息，你也看不到他们何时读了你的。"),
      "ui_dm_typing_setting": MessageLookupByLibrary.simpleMessage("显示你正在输入"),
      "ui_dm_typing_setting_detail":
          MessageLookupByLibrary.simpleMessage("你正在写信的人会看到你在输入。"),
      "ui_dm_link_previews": MessageLookupByLibrary.simpleMessage("链接预览"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "你的手机会打开你发送的链接来生成预览，因此网站会看到你手机的请求。Kyron 的服务器从不会看到链接。"),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("消息通知"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "消息采用端到端加密。Kyron 无法读取，这里的任何设置都不会改变这一点。"),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("收件人："),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("最近"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("用户"),
      "ui_dm_new_nobody": MessageLookupByLibrary.simpleMessage("没有叫这个名字的人。"),
      "ui_push_test": MessageLookupByLibrary.simpleMessage("发送测试通知"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron 的服务器尚未配置发送通知，因此不会有通知送达。问题在我们这边，不在你的手机。"),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "此手机未注册通知。请在手机设置中确认已允许 Kyron 的通知，然后重试。"),
      "ui_push_test_rejected":
          MessageLookupByLibrary.simpleMessage("无法将通知送达此手机。请一分钟后重试。"),
      "ui_push_test_sent":
          MessageLookupByLibrary.simpleMessage("已发送。几秒钟内应该会到达。"),
      "ui_push_working": MessageLookupByLibrary.simpleMessage("通知运行正常。"),
      "ui_community_no_posts": MessageLookupByLibrary.simpleMessage("还没有帖子"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("新建社区"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("名称"),
      "ui_community_address_hint":
          MessageLookupByLibrary.simpleMessage("地址由名称生成。"),
      "ui_community_address": MessageLookupByLibrary.simpleMessage("访问地址："),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "你将是社区的所有者。社区创建后，可以在它的页面添加图片、横幅和版主。"),
      "ui_community_settings_home": MessageLookupByLibrary.simpleMessage("首页"),
      "ui_community_in_home": MessageLookupByLibrary.simpleMessage("在首页显示社区帖子"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "你所在社区的帖子也会出现在首页。关闭后，它们只留在社区里，每个社区都会显示有什么新内容。"),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("你的列表"),
      "ui_community_counts": MessageLookupByLibrary.simpleMessage("新帖子数量"),
      "ui_community_counts_detail":
          MessageLookupByLibrary.simpleMessage("显示自你上次打开以来，每个社区有多少新帖子。"),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("你管理的社区"),
      "ui_community_running_none_detail":
          MessageLookupByLibrary.simpleMessage("你创建或担任版主的社区会列在这里。"),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("所有者"),
      "ui_community_role_moderator": MessageLookupByLibrary.simpleMessage("版主"),
      "ui_community_filter_new": MessageLookupByLibrary.simpleMessage("新帖子"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("我管理的"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("社区设置"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("发现"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("没有匹配的社区。"),
      "ui_community_new_none": MessageLookupByLibrary.simpleMessage("没有新内容"),
      "ui_community_new_none_detail":
          MessageLookupByLibrary.simpleMessage("每个社区都和你上次离开时一样。"),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("你还没有管理任何社区"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("没有可以加入的社区了"),
      "ui_community_discover_none_detail":
          MessageLookupByLibrary.simpleMessage("你已加入 Kyron 上的所有社区。再创建一个吧。"),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage("换个词试试，或者用这个名称创建一个社区。"),
      "ui_community_write": MessageLookupByLibrary.simpleMessage("发帖"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("成员："),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("已发布"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("查看"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("打开"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("在线"),
      "ui_dm_show_online": MessageLookupByLibrary.simpleMessage("显示你在线"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "和你聊天的人在你打开 Kyron 时会看到一个绿点。关闭后，你也看不到他们的。"),
      "ui_explore_search": MessageLookupByLibrary.simpleMessage("搜索用户和帖子"),
      "ui_explore_communities": MessageLookupByLibrary.simpleMessage("可加入的社区"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("暂时没有可看的内容"),
      "ui_explore_grid_empty_detail":
          MessageLookupByLibrary.simpleMessage("大家发布的照片和短片会显示在这里。"),
      "ui_follow": MessageLookupByLibrary.simpleMessage("关注"),
      "ui_delete_account": MessageLookupByLibrary.simpleMessage("删除账号"),
      "ui_delete_account_intro":
          MessageLookupByLibrary.simpleMessage("这会永久删除你的 Kyron 账号，且无法撤销。"),
      "ui_delete_account_posts":
          MessageLookupByLibrary.simpleMessage("你的个人资料、帖子、回复、赞和转发"),
      "ui_delete_account_messages":
          MessageLookupByLibrary.simpleMessage("你的消息（包括你发给别人的消息），以及其中的照片和语音消息"),
      "ui_delete_account_people":
          MessageLookupByLibrary.simpleMessage("你的粉丝、你关注的人和你的设置"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "你创建的社区将移交给加入最久的版主或成员。没有其他人的社区将被关闭。"),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("要删除你的账号吗？"),
      "ui_delete_account_confirm_detail":
          MessageLookupByLibrary.simpleMessage("删除后将无法恢复任何内容。"),
      "ui_delete_account_done":
          MessageLookupByLibrary.simpleMessage("你的账号已删除。"),
      "ui_dm_deleted_account": MessageLookupByLibrary.simpleMessage("已删除的账号"),
      "ui_dm_deleted_account_detail":
          MessageLookupByLibrary.simpleMessage("此账号已删除，因此无法再在这里发送消息。"),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "是用 Google 注册的吗？请改用“使用 Google 登录”。"),
      "ar_lens_not_loaded": MessageLookupByLibrary.simpleMessage("无法加载该滤镜。"),
      "ar_could_not_record": MessageLookupByLibrary.simpleMessage("无法录制视频。"),
      "ar_lens_left_out":
          MessageLookupByLibrary.simpleMessage("无法将滤镜添加到此视频，因此将按原样发布。"),
      "ar_composer_full":
          MessageLookupByLibrary.simpleMessage("你的帖子已达到附件数量上限。"),
      "ar_applying_lens": MessageLookupByLibrary.simpleMessage("正在添加滤镜…"),
      "ar_flash": MessageLookupByLibrary.simpleMessage("闪光灯"),
      "ar_record_video": MessageLookupByLibrary.simpleMessage("录制视频"),
      "ar_mode_photo": MessageLookupByLibrary.simpleMessage("照片"),
      "ar_mode_video": MessageLookupByLibrary.simpleMessage("视频"),
      "googleSignInCancelled":
          MessageLookupByLibrary.simpleMessage("已取消 Google 登录。"),
      "analytics_gifts": MessageLookupByLibrary.simpleMessage("礼物"),
      "analytics_no_gifts_yet":
          MessageLookupByLibrary.simpleMessage("还没有人给这条帖子送礼物。"),
      "analytics_gift": MessageLookupByLibrary.simpleMessage("礼物"),
      "analytics_gifts_label": MessageLookupByLibrary.simpleMessage("礼物"),
      "analytics_coins": MessageLookupByLibrary.simpleMessage("金币"),
      "analytics_sender": MessageLookupByLibrary.simpleMessage("赠送者"),
      "analytics_senders": MessageLookupByLibrary.simpleMessage("赠送者"),
      "analytics_test_coins":
          MessageLookupByLibrary.simpleMessage("测试金币：暂时无法提现。"),
      "ui_saved": MessageLookupByLibrary.simpleMessage("已收藏"),
      "ui_saved_tab_posts": MessageLookupByLibrary.simpleMessage("帖子"),
      "ui_saved_tab_comments": MessageLookupByLibrary.simpleMessage("评论"),
      "ui_view_more_replies": MessageLookupByLibrary.simpleMessage("查看更多回复"),
      "ui_edited": MessageLookupByLibrary.simpleMessage("已编辑"),
      "ui_more": MessageLookupByLibrary.simpleMessage("更多"),
      "ui_following": MessageLookupByLibrary.simpleMessage("关注中"),
      "ui_sort_top": MessageLookupByLibrary.simpleMessage("热门"),
      "ui_sort_recent": MessageLookupByLibrary.simpleMessage("最新"),
      "ui_sort_comments": MessageLookupByLibrary.simpleMessage("评论排序：\$order"),
      "ui_notif_gift": MessageLookupByLibrary.simpleMessage("给你的帖子送了一份礼物"),
      "ui_notif_gift_comment":
          MessageLookupByLibrary.simpleMessage("给你的评论送了 \$gift"),
      "ui_notif_gift_named":
          MessageLookupByLibrary.simpleMessage("给你的帖子送了 \$gift"),
      "ui_gift_title": MessageLookupByLibrary.simpleMessage("送礼物"),
      "ui_edit_post": MessageLookupByLibrary.simpleMessage("编辑帖子"),
      "ui_edit_post_left":
          MessageLookupByLibrary.simpleMessage("你还可以编辑 \$n 分钟"),
      "ui_save": MessageLookupByLibrary.simpleMessage("保存"),
      "ui_feed_tag_detail":
          MessageLookupByLibrary.simpleMessage("#\$tab 下还没有任何帖子。"),
      "ui_gift_pick": MessageLookupByLibrary.simpleMessage("选择一份礼物"),
      "ui_gift_not_enough": MessageLookupByLibrary.simpleMessage("金币不足"),
      "ui_gift_test_notice":
          MessageLookupByLibrary.simpleMessage("测试金币：无法购买，也没有现金价值。"),
      "ui_gift_refills_on":
          MessageLookupByLibrary.simpleMessage("将于 \$date 补充。"),
      "ui_gift_one_coin": MessageLookupByLibrary.simpleMessage("1 枚金币"),
      "ui_gift_coins": MessageLookupByLibrary.simpleMessage("\$count 枚金币"),
      "ui_gift_balance": MessageLookupByLibrary.simpleMessage("你有 \$coins"),
      "ui_gift_send_named": MessageLookupByLibrary.simpleMessage("赠送 \$gift"),
      "ui_gift_sent_named": MessageLookupByLibrary.simpleMessage("已送出 \$gift"),
      "ui_retry": MessageLookupByLibrary.simpleMessage("重试"),
      "ui_edit_post_detail": MessageLookupByLibrary.simpleMessage("发布后 15 分钟内"),
      "ui_post_edited": MessageLookupByLibrary.simpleMessage("已编辑"),
      "ui_could_not_load_saved_comments":
          MessageLookupByLibrary.simpleMessage("无法加载你收藏的评论"),
      "ui_no_saved_comments": MessageLookupByLibrary.simpleMessage("没有收藏的评论"),
      "ui_no_saved_comments_detail": MessageLookupByLibrary.simpleMessage(
          "点按评论下方的存档图标即可将其保存在这里。只有你能看到你收藏的内容。"),
      "ui_replying_to": MessageLookupByLibrary.simpleMessage("回复 \$name"),
      "ui_copy": MessageLookupByLibrary.simpleMessage("复制"),
      "ui_search": MessageLookupByLibrary.simpleMessage("搜索"),
      "ui_select_all": MessageLookupByLibrary.simpleMessage("全选"),
      "ui_gifts_count": MessageLookupByLibrary.simpleMessage("\$count 份礼物"),
      "ui_gifts_count_one": MessageLookupByLibrary.simpleMessage("1 份礼物"),
      "ui_feed_more_failed": MessageLookupByLibrary.simpleMessage("无法加载更多帖子。"),
      "ui_reminders": MessageLookupByLibrary.simpleMessage("提醒"),
      "ui_reminders_detail":
          MessageLookupByLibrary.simpleMessage("离开一段时间后有什么新内容，以及金币回来时。每天最多一条。"),
      "ui_gifts_title": MessageLookupByLibrary.simpleMessage("礼物"),
      "ui_gifts_from_one": MessageLookupByLibrary.simpleMessage("来自 1 个人"),
      "ui_gifts_from_people":
          MessageLookupByLibrary.simpleMessage("来自 \$count 个人"),
      "ui_top_gifter": MessageLookupByLibrary.simpleMessage("最佳送礼者"),
      "ui_gifts_load_failed": MessageLookupByLibrary.simpleMessage("无法加载送礼人。"),
      "ui_whats_new": MessageLookupByLibrary.simpleMessage("新功能"),
      "ui_whats_new_version":
          MessageLookupByLibrary.simpleMessage("Kyron \$version"),
      "ui_got_it": MessageLookupByLibrary.simpleMessage("知道了"),
      "ui_check_in_thanks":
          MessageLookupByLibrary.simpleMessage("谢谢。我们会读每一条回复。"),
      "ui_check_in_title":
          MessageLookupByLibrary.simpleMessage("目前觉得 Kyron 怎么样？"),
      "ui_check_in_detail":
          MessageLookupByLibrary.simpleMessage("你的测试第 \$day 天。点一下就好。"),
      "ui_check_in_hint":
          MessageLookupByLibrary.simpleMessage("有什么需要我们修复或添加的吗？（可选）"),
      "ui_send": MessageLookupByLibrary.simpleMessage("发送"),
      "ui_not_now": MessageLookupByLibrary.simpleMessage("以后再说"),
      "ui_back_again_to_leave":
          MessageLookupByLibrary.simpleMessage("再按一次返回键退出 Kyron"),
      "ui_confirm_its_you_title":
          MessageLookupByLibrary.simpleMessage("确认是你本人"),
      "ui_confirm_its_you_password":
          MessageLookupByLibrary.simpleMessage("输入密码以删除你的账号。"),
      "ui_confirm_its_you_google":
          MessageLookupByLibrary.simpleMessage("请再次使用 Google 登录以删除你的账号。"),
      "ui_confirm_its_you_failed":
          MessageLookupByLibrary.simpleMessage("没有成功。请检查后重试。"),
      "ui_browser_leave_title":
          MessageLookupByLibrary.simpleMessage("此页面想要打开另一个应用"),
      "ui_browser_leave_detail":
          MessageLookupByLibrary.simpleMessage("它请求打开一个 {scheme} 链接。"),
      "ui_about_build": MessageLookupByLibrary.simpleMessage("版本信息"),
      "ui_about_cache_size":
          MessageLookupByLibrary.simpleMessage("已缓存的图片和文件共 {size}"),
      "ui_about_freed": MessageLookupByLibrary.simpleMessage("已释放 {size}"),
      "ui_about_measuring": MessageLookupByLibrary.simpleMessage("正在计算…"),
      "ui_about_nothing_to_clear":
          MessageLookupByLibrary.simpleMessage("没有可清除的内容"),
      "ui_about_storage": MessageLookupByLibrary.simpleMessage("存储"),
      "ui_about_version": MessageLookupByLibrary.simpleMessage("版本 {version}"),
      "ui_blocked_tab": MessageLookupByLibrary.simpleMessage("已屏蔽"),
      "ui_composer_posting_as_you":
          MessageLookupByLibrary.simpleMessage("以你的身份发布"),
      "ui_composer_uploads_failed":
          MessageLookupByLibrary.simpleMessage("这些附件没有上传成功。点按一个重试，或将其移除。"),
      "ui_email_change_failed":
          MessageLookupByLibrary.simpleMessage("无法更改你的邮箱，请重试。"),
      "ui_email_changes_after_link":
          MessageLookupByLibrary.simpleMessage("点按我们发送的链接后，你的邮箱地址才会更改。"),
      "ui_email_check_link":
          MessageLookupByLibrary.simpleMessage("请查看 {email} 中的确认链接。"),
      "ui_email_enter": MessageLookupByLibrary.simpleMessage("请输入邮箱地址。"),
      "ui_email_invalid": MessageLookupByLibrary.simpleMessage("这看起来不像邮箱地址。"),
      "ui_email_same": MessageLookupByLibrary.simpleMessage("这已经是你的邮箱地址了。"),
      "ui_feedback_bug_hint":
          MessageLookupByLibrary.simpleMessage("你做了什么，你期望什么，以及实际发生了什么。"),
      "ui_feedback_idea_example":
          MessageLookupByLibrary.simpleMessage("让我可以把一条帖子置顶到个人资料"),
      "ui_feedback_idea_hint":
          MessageLookupByLibrary.simpleMessage("你想要什么，以及它能让你做到什么。"),
      "ui_feedback_idea_label": MessageLookupByLibrary.simpleMessage("什么会有帮助"),
      "ui_feedback_kind_bug": MessageLookupByLibrary.simpleMessage("问题"),
      "ui_feedback_kind_idea": MessageLookupByLibrary.simpleMessage("想法"),
      "ui_feedback_kind_question": MessageLookupByLibrary.simpleMessage("疑问"),
      "ui_feedback_privacy": MessageLookupByLibrary.simpleMessage(
          "只有 Kyron 团队会阅读这些内容。它会随你的账号一起发送，以便我们通过邮件回复你，并了解你使用的应用版本。删除账号时它也会被删除。"),
      "ui_feedback_question_example":
          MessageLookupByLibrary.simpleMessage("怎样屏蔽一个词？"),
      "ui_feedback_question_hint":
          MessageLookupByLibrary.simpleMessage("你想做什么，以及卡在了哪里。"),
      "ui_feedback_question_label":
          MessageLookupByLibrary.simpleMessage("你的问题"),
      "ui_feedback_unreachable": MessageLookupByLibrary.simpleMessage(
          "无法连接到 Kyron。请检查网络连接后重试。你还没有写任何内容，所以不会丢失任何东西。"),
      "ui_log_clear": MessageLookupByLibrary.simpleMessage("清除"),
      "ui_log_empty_detail":
          MessageLookupByLibrary.simpleMessage("失败的请求和其他值得注意的事件会显示在这里。"),
      "ui_muted_tab": MessageLookupByLibrary.simpleMessage("已静音"),
      "ui_muted_words_empty": MessageLookupByLibrary.simpleMessage(
          "在上方添加一个词或标签。包含它的帖子将不会出现在你的动态中。"),
      "ui_muted_words_intro": MessageLookupByLibrary.simpleMessage(
          "包含以下任意内容的帖子都不会出现在你的动态中。匹配不区分大小写，而且一个词也会匹配更长的词，所以“spoiler”也会匹配“spoilers”。"),
      "ui_nobody_blocked": MessageLookupByLibrary.simpleMessage("没有屏蔽任何人"),
      "ui_nobody_blocked_detail": MessageLookupByLibrary.simpleMessage(
          "屏蔽后你们会互相看不到对方。在对方的个人资料菜单中屏蔽他人。"),
      "ui_nobody_muted": MessageLookupByLibrary.simpleMessage("没有静音任何人"),
      "ui_nobody_muted_detail": MessageLookupByLibrary.simpleMessage(
          "静音一个账号会隐藏其帖子，且不会通知对方。在对方的个人资料或帖子菜单中静音他人。"),
      "ui_password": MessageLookupByLibrary.simpleMessage("密码"),
      "ui_password_mismatch": MessageLookupByLibrary.simpleMessage("两次输入不一致。"),
      "ui_password_other_devices":
          MessageLookupByLibrary.simpleMessage("你会在此设备上保持登录，其他设备将被退出登录。"),
      "ui_password_too_short":
          MessageLookupByLibrary.simpleMessage("请至少使用 8 个字符。"),
      "ui_password_update_failed":
          MessageLookupByLibrary.simpleMessage("无法更新你的密码，请重试。"),
      "ui_password_updated": MessageLookupByLibrary.simpleMessage("密码已更新。"),
      "ui_profile_did_copied": MessageLookupByLibrary.simpleMessage("已复制 DID"),
      "ui_profile_empty_likes":
          MessageLookupByLibrary.simpleMessage("你点赞的帖子会保存在这里，只有你能看到。"),
      "ui_profile_empty_media_mine":
          MessageLookupByLibrary.simpleMessage("你还没有发布任何照片或视频。"),
      "ui_profile_empty_media_other":
          MessageLookupByLibrary.simpleMessage("{name} 还没有发布任何照片或视频。"),
      "ui_profile_empty_posts_mine":
          MessageLookupByLibrary.simpleMessage("你发布的所有内容都会显示在这里。"),
      "ui_profile_empty_posts_other":
          MessageLookupByLibrary.simpleMessage("{name} 还没有发布任何内容。"),
      "ui_profile_load_failed_mine":
          MessageLookupByLibrary.simpleMessage("无法加载你的个人资料"),
      "ui_profile_load_failed_other":
          MessageLookupByLibrary.simpleMessage("无法加载 @{handle}"),
      "ui_pw_rule_length": MessageLookupByLibrary.simpleMessage("至少 8 个字符"),
      "ui_pw_rule_lower": MessageLookupByLibrary.simpleMessage("小写字母 (a–z)"),
      "ui_pw_rule_number": MessageLookupByLibrary.simpleMessage("至少一个数字"),
      "ui_pw_rule_symbol": MessageLookupByLibrary.simpleMessage("符号 (!@#…)"),
      "ui_pw_rule_upper": MessageLookupByLibrary.simpleMessage("大写字母 (A–Z)"),
      "ui_report_entries": MessageLookupByLibrary.simpleMessage(
          "最近 {count} 条记录。发送前可在“关于 › 系统日志”中查看。"),
      "ui_report_privacy": MessageLookupByLibrary.simpleMessage(
          "只有 Kyron 团队会阅读这些内容。它会随你的账号一起发送，以便我们跟进。如果你想确切了解会一起发送什么，请先在“关于 › 系统日志”中查看日志。"),
      "ui_report_sent": MessageLookupByLibrary.simpleMessage("已发送，谢谢。"),
      "ui_report_sent_number":
          MessageLookupByLibrary.simpleMessage("已发送，谢谢。报告编号为 #{number}。"),
      "ui_report_what_went_wrong":
          MessageLookupByLibrary.simpleMessage("出了什么问题？"),
      "ui_settings_about_help":
          MessageLookupByLibrary.simpleMessage("版本、政策、状态和系统日志"),
      "ui_settings_autoplay_help":
          MessageLookupByLibrary.simpleMessage("滚动时不自动播放视频"),
      "ui_settings_did_help": MessageLookupByLibrary.simpleMessage("你的去中心化标识符"),
      "ui_settings_moderation": MessageLookupByLibrary.simpleMessage("内容审核"),
      "ui_settings_moderation_help":
          MessageLookupByLibrary.simpleMessage("等待审核的举报和申诉"),
      "ui_settings_muted_words_help":
          MessageLookupByLibrary.simpleMessage("不让包含这些内容的帖子出现在你的动态中"),
      "ui_settings_not_signed_in": MessageLookupByLibrary.simpleMessage("未登录"),
      "ui_settings_notifications_help":
          MessageLookupByLibrary.simpleMessage("通知偏好"),
      "ui_settings_privacy_safety":
          MessageLookupByLibrary.simpleMessage("隐私与安全"),
      "ui_settings_standing_help":
          MessageLookupByLibrary.simpleMessage("关于你账号的决定以及申诉"),
      "ui_settings_text_size_help":
          MessageLookupByLibrary.simpleMessage("调整文字大小"),
      "ui_settings_your_account": MessageLookupByLibrary.simpleMessage("你的账号"),
      "ui_soon_lens_detail": MessageLookupByLibrary.simpleMessage(
          "录制和发布 AR 滤镜的功能仍在开发中。你拍摄的任何内容目前都无法保存，所以相机保持关闭。"),
      "ui_soon_lens_heading": MessageLookupByLibrary.simpleMessage("滤镜功能尚未就绪"),
      "ui_soon_lens_title": MessageLookupByLibrary.simpleMessage("AR 滤镜"),
      "ui_soon_live_detail": MessageLookupByLibrary.simpleMessage(
          "直播需要一台 Kyron 目前还没有运行的媒体服务器。现在开始直播会把你放进一个没人能加入的房间。录制语音帖子现在已经可用。"),
      "ui_soon_live_heading": MessageLookupByLibrary.simpleMessage("直播功能尚未就绪"),
      "ui_soon_live_title": MessageLookupByLibrary.simpleMessage("开始直播"),
      "ui_soon_poll_detail": MessageLookupByLibrary.simpleMessage(
          "投票需要一个地方来保存选项和统计票数。这部分还没有完成，所以现在发布的投票会丢失所有回答。"),
      "ui_soon_poll_heading": MessageLookupByLibrary.simpleMessage("投票功能尚未就绪"),
      "ui_soon_poll_title": MessageLookupByLibrary.simpleMessage("投票"),
      "ui_soon_write_instead": MessageLookupByLibrary.simpleMessage("改为发布文字帖子"),
      "ui_status_check_again": MessageLookupByLibrary.simpleMessage("再次检查"),
      "ui_status_detail": MessageLookupByLibrary.simpleMessage("详情"),
      "ui_status_mirror": MessageLookupByLibrary.simpleMessage("镜像表"),
      "ui_status_not_right":
          MessageLookupByLibrary.simpleMessage("Kyron 有响应，但有些地方不对劲。"),
      "ui_status_round_trip": MessageLookupByLibrary.simpleMessage("往返时间"),
      "ui_support_ask": MessageLookupByLibrary.simpleMessage("提问"),
      "ui_support_ask_detail":
          MessageLookupByLibrary.simpleMessage("关于你的账号，或某个功能如何使用"),
      "ui_support_by_email": MessageLookupByLibrary.simpleMessage("通过邮件"),
      "ui_support_crash_detail":
          MessageLookupByLibrary.simpleMessage("如果 Kyron 崩溃了：会一并发送应用日志"),
      "ui_support_in_app": MessageLookupByLibrary.simpleMessage("在应用内"),
      "ui_support_intro": MessageLookupByLibrary.simpleMessage(
          "在这里给 Kyron 团队写信。它会私下送达我们，并附带你的账号，我们会回复到账号上的邮箱地址。"),
      "ui_support_no_mail":
          MessageLookupByLibrary.simpleMessage("没有打开任何邮件应用。已复制 {address}。"),
      "ui_support_privacy": MessageLookupByLibrary.simpleMessage("隐私与你的数据"),
      "ui_support_report": MessageLookupByLibrary.simpleMessage("报告问题"),
      "ui_support_report_detail":
          MessageLookupByLibrary.simpleMessage("有东西坏了或者不像应该的那样工作"),
      "ui_support_report_hint": MessageLookupByLibrary.simpleMessage(
          "要举报帖子或账号，请使用其上的菜单：这样我们就能确切知道你指的是哪一个。"),
      "ui_support_safety": MessageLookupByLibrary.simpleMessage("安全与滥用"),
      "ui_support_status_detail":
          MessageLookupByLibrary.simpleMessage("Kyron 是对所有人都宕机了，还是只有你"),
      "ui_text_size_large": MessageLookupByLibrary.simpleMessage("大"),
      "ui_text_size_larger": MessageLookupByLibrary.simpleMessage("更大"),
      "ui_text_size_medium": MessageLookupByLibrary.simpleMessage("中"),
      "ui_text_size_preview":
          MessageLookupByLibrary.simpleMessage("Kyron 是一个说值得一读的话的地方。"),
      "ui_text_size_small": MessageLookupByLibrary.simpleMessage("小"),
      "ui_theme_dark_detail": MessageLookupByLibrary.simpleMessage("始终深色"),
      "ui_theme_dim": MessageLookupByLibrary.simpleMessage("暗淡"),
      "ui_theme_dim_detail":
          MessageLookupByLibrary.simpleMessage("更柔和的深色，蓝灰色而不是黑色"),
      "ui_theme_light_detail": MessageLookupByLibrary.simpleMessage("始终浅色"),
      "ui_theme_system_detail":
          MessageLookupByLibrary.simpleMessage("跟随手机自身的浅色或深色设置"),
      "ui_unblock": MessageLookupByLibrary.simpleMessage("取消屏蔽"),
      "ui_unmute": MessageLookupByLibrary.simpleMessage("取消静音"),
      "ui_verify_about": MessageLookupByLibrary.simpleMessage("你是谁"),
      "ui_verify_about_help":
          MessageLookupByLibrary.simpleMessage("用你自己的话说说审核人员应该知道什么。"),
      "ui_verify_about_hint":
          MessageLookupByLibrary.simpleMessage("我在这里和我自己的网站上写关于鸟类的文章。"),
      "ui_verify_add_link": MessageLookupByLibrary.simpleMessage("添加另一个链接"),
      "ui_verify_again":
          MessageLookupByLibrary.simpleMessage("你可以从 {date} 起再次申请。"),
      "ui_verify_ask": MessageLookupByLibrary.simpleMessage("申请认证"),
      "ui_verify_before": MessageLookupByLibrary.simpleMessage("申请之前"),
      "ui_verify_cat_creator": MessageLookupByLibrary.simpleMessage("创作者"),
      "ui_verify_cat_journalist": MessageLookupByLibrary.simpleMessage("记者"),
      "ui_verify_cat_org": MessageLookupByLibrary.simpleMessage("组织或品牌"),
      "ui_verify_cat_other": MessageLookupByLibrary.simpleMessage("其他"),
      "ui_verify_cat_public": MessageLookupByLibrary.simpleMessage("公众人物"),
      "ui_verify_denied":
          MessageLookupByLibrary.simpleMessage("第 {number} 号申请未获批准"),
      "ui_verify_done": MessageLookupByLibrary.simpleMessage("你已通过认证"),
      "ui_verify_edit_profile":
          MessageLookupByLibrary.simpleMessage("编辑你的个人资料"),
      "ui_verify_email_enter_code":
          MessageLookupByLibrary.simpleMessage("输入 6 位验证码"),
      "ui_verify_email_resend_in":
          MessageLookupByLibrary.simpleMessage("{seconds} 秒后可重新发送验证码"),
      "ui_verify_email_sent_to":
          MessageLookupByLibrary.simpleMessage("我们已发送到 {email}"),
      "ui_verify_email_verify": MessageLookupByLibrary.simpleMessage("验证"),
      "ui_verify_hero": MessageLookupByLibrary.simpleMessage("在 Kyron 上获得认证"),
      "ui_verify_hero_1": MessageLookupByLibrary.simpleMessage("获得"),
      "ui_verify_hero_2": MessageLookupByLibrary.simpleMessage("认证"),
      "ui_verify_hero_3": MessageLookupByLibrary.simpleMessage("在 Kyron 上。"),
      "ui_verify_intro": MessageLookupByLibrary.simpleMessage(
          "认证徽章表示 Kyron 团队的某位成员核实过这个账号就是它声称的那个人。它不会带来额外的曝光，也不出售。"),
      "ui_verify_keeps": MessageLookupByLibrary.simpleMessage(
          "只要你的名字不变，徽章就会保留。更改名字后，徽章会被取消，直到有人核实新名字。"),
      "ui_verify_link_first": MessageLookupByLibrary.simpleMessage("我们可以核实的地方"),
      "ui_verify_link_more": MessageLookupByLibrary.simpleMessage("另一个链接"),
      "ui_verify_links_help": MessageLookupByLibrary.simpleMessage(
          "一个表明这个 Kyron 账号属于你的网站或其他个人资料：在上面放上你的 Kyron 名字，或你个人资料的链接。Kyron 从不要求提供身份证件。"),
      "ui_verify_load_failed":
          MessageLookupByLibrary.simpleMessage("无法加载你的认证状态"),
      "ui_verify_need_ticks":
          MessageLookupByLibrary.simpleMessage("上面每一项都需要打勾后才能申请。"),
      "ui_verify_req_age":
          MessageLookupByLibrary.simpleMessage("账号注册至少 {days} 天"),
      "ui_verify_req_bio": MessageLookupByLibrary.simpleMessage("一段说明你是谁的简介"),
      "ui_verify_req_name": MessageLookupByLibrary.simpleMessage("个人资料上有你的名字"),
      "ui_verify_req_photo": MessageLookupByLibrary.simpleMessage("一张头像"),
      "ui_verify_req_standing":
          MessageLookupByLibrary.simpleMessage("最近 {days} 天内没有任何违规记录"),
      "ui_verify_sent": MessageLookupByLibrary.simpleMessage("已发送。会有人工查看。"),
      "ui_verify_since": MessageLookupByLibrary.simpleMessage("自 {date} 起。"),
      "ui_verify_step_ask": MessageLookupByLibrary.simpleMessage("申请"),
      "ui_verify_step_ask_detail":
          MessageLookupByLibrary.simpleMessage("你是谁，以及一个\n能证明的链接"),
      "ui_verify_step_badge": MessageLookupByLibrary.simpleMessage("认证徽章"),
      "ui_verify_step_badge_detail":
          MessageLookupByLibrary.simpleMessage("显示在你的名字旁，\n无处不在"),
      "ui_verify_step_check": MessageLookupByLibrary.simpleMessage("由人工\n审核"),
      "ui_verify_step_check_detail":
          MessageLookupByLibrary.simpleMessage("团队成员\n查看你的链接"),
      "ui_verify_title": MessageLookupByLibrary.simpleMessage("认证"),
      "ui_verify_waiting":
          MessageLookupByLibrary.simpleMessage("第 {number} 号申请正在由人工处理"),
      "ui_verify_waiting_detail": MessageLookupByLibrary.simpleMessage(
          "{date} 已发送，类别为{category}。有结果时你会收到通知。"),
      "ui_verify_withdraw": MessageLookupByLibrary.simpleMessage("撤回申请"),
      "ui_verify_withdrawn": MessageLookupByLibrary.simpleMessage("申请已撤回。"),
      "ui_voice_finish_failed":
          MessageLookupByLibrary.simpleMessage("无法完成录音：{error}"),
      "ui_voice_limit": MessageLookupByLibrary.simpleMessage("最长十分钟。"),
      "ui_voice_listening": MessageLookupByLibrary.simpleMessage("正在聆听…"),
      "ui_voice_no_mic": MessageLookupByLibrary.simpleMessage(
          "Kyron 需要麦克风权限才能录音。你可以在设备设置中授予权限。"),
      "ui_voice_start_failed":
          MessageLookupByLibrary.simpleMessage("无法开始录音：{error}"),
      "ui_2fa_title": MessageLookupByLibrary.simpleMessage("两步登录"),
      "ui_2fa_help": MessageLookupByLibrary.simpleMessage("员工工具的验证器代码"),
      "ui_2fa_intro": MessageLookupByLibrary.simpleMessage(
          "员工工具除了登录外还要求输入验证器应用中的代码，这样仅凭被盗的密码无法使用它们。"),
      "ui_2fa_on": MessageLookupByLibrary.simpleMessage("两步登录已开启。"),
      "ui_2fa_remove": MessageLookupByLibrary.simpleMessage("移除"),
      "ui_2fa_set_up": MessageLookupByLibrary.simpleMessage("设置"),
      "ui_2fa_scan": MessageLookupByLibrary.simpleMessage(
          "用验证器应用扫描此码，或输入下方的密钥。如果可以，请添加到两个应用中：丢失唯一的应用意味着需要请支持团队将其移除。"),
      "ui_2fa_key": MessageLookupByLibrary.simpleMessage("设置密钥"),
      "ui_2fa_copied": MessageLookupByLibrary.simpleMessage("已复制设置密钥"),
      "ui_2fa_confirm": MessageLookupByLibrary.simpleMessage("确认"),
      "ui_2fa_failed": MessageLookupByLibrary.simpleMessage("无法开始设置。请重试。"),
      "ui_2fa_wrong":
          MessageLookupByLibrary.simpleMessage("该代码无效。请检查手机上的时间后重试。"),
      "ui_2fa_code": MessageLookupByLibrary.simpleMessage("6 位代码"),
      "ui_2fa_enter": MessageLookupByLibrary.simpleMessage("输入验证器应用中的代码"),
      "ui_2fa_verify": MessageLookupByLibrary.simpleMessage("验证"),
      "ui_password_breached": MessageLookupByLibrary.simpleMessage(
          "此密码曾出现在数据泄露中，因此是攻击者最先尝试的密码之一。请换一个。"),
    };

final messageLookup = MessageLookup();
