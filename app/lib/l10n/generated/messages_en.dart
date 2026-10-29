import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';
  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      "about": MessageLookupByLibrary.simpleMessage("About"),
      "addAnAnswer": MessageLookupByLibrary.simpleMessage("Add an answer"),
      "agreeAndContinue": MessageLookupByLibrary.simpleMessage(
        "Agree and continue",
      ),
      "answerNumber": (Object a0) => "Answer $a0",
      "arLens": MessageLookupByLibrary.simpleMessage("AR Lens"),
      "attachSystemLog": MessageLookupByLibrary.simpleMessage(
        "Attach the system log",
      ),
      "aWordPhraseOrTag": MessageLookupByLibrary.simpleMessage(
        "A word, phrase or #tag",
      ),
      "block": MessageLookupByLibrary.simpleMessage("Block"),
      "blockAuthor": (Object a0) => "Block $a0?",
      "buildDetailsCopied": MessageLookupByLibrary.simpleMessage(
        "Build details copied",
      ),
      "bullet": MessageLookupByLibrary.simpleMessage("•"),
      "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
      "change": MessageLookupByLibrary.simpleMessage("Change"),
      "changeEmail": MessageLookupByLibrary.simpleMessage("Change Email"),
      "checkKyronReachable": MessageLookupByLibrary.simpleMessage(
        "Check whether Kyron is reachable",
      ),
      "checkEmailConfirm": MessageLookupByLibrary.simpleMessage(
        "Check your email to confirm your account.",
      ),
      "closeCommunity": (Object a0) => "Close $a0?",
      "closeIt": MessageLookupByLibrary.simpleMessage("Close it"),
      "closeThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Close this community",
      ),
      "confirmPassword":
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      "contactSupport": MessageLookupByLibrary.simpleMessage("Contact support"),
      "continueWithEmail": MessageLookupByLibrary.simpleMessage(
        "Continue with email",
      ),
      "copy": MessageLookupByLibrary.simpleMessage("Copy"),
      "copyReportInstead": MessageLookupByLibrary.simpleMessage(
        "Copy report instead",
      ),
      "couldNotOpenGoogleSignIn": (Object a0) =>
          "Could not open Google sign-in. $a0",
      "couldNotSignOut": (Object a0) => "Could not sign out: $a0",
      "couldNotTakePicture": MessageLookupByLibrary.simpleMessage(
        "Could not take that picture.",
      ),
      "country_helper": MessageLookupByLibrary.simpleMessage(
          "Shown on your profile and under your posts."),
      "country_no_match":
          MessageLookupByLibrary.simpleMessage("No country matches “{query}”."),
      "country_none":
          MessageLookupByLibrary.simpleMessage("Don't show a country"),
      "country_search":
          MessageLookupByLibrary.simpleMessage("Search countries"),
      "country_shown": MessageLookupByLibrary.simpleMessage(
          "Shown on your profile and under your posts. When you see someone's posts, your country is counted in their Insights, only in groups of five or more and never by name."),
      "country_suggested":
          MessageLookupByLibrary.simpleMessage("From your phone's settings"),
      "create": MessageLookupByLibrary.simpleMessage("Create"),
      "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
      "createYourAccount": MessageLookupByLibrary.simpleMessage(
        "Create your account",
      ),
      "createYourProfile": MessageLookupByLibrary.simpleMessage(
        "Create your profile",
      ),
      "delete": MessageLookupByLibrary.simpleMessage("Delete"),
      "deleteThisComment": MessageLookupByLibrary.simpleMessage(
        "Delete this comment?",
      ),
      "deleteThisPost":
          MessageLookupByLibrary.simpleMessage("Delete this post?"),
      "describeAttachment": MessageLookupByLibrary.simpleMessage(
        "Describe this attachment",
      ),
      "description": MessageLookupByLibrary.simpleMessage("Description"),
      "didCopied":
          MessageLookupByLibrary.simpleMessage("DID copied to clipboard"),
      "done": MessageLookupByLibrary.simpleMessage("Done"),
      "drafts": MessageLookupByLibrary.simpleMessage("Drafts"),
      "editProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
      "emailNotifications": MessageLookupByLibrary.simpleMessage(
        "Email notifications",
      ),
      "faceTrackingUnavailable": MessageLookupByLibrary.simpleMessage(
        "Face tracking is not available on this device.",
      ),
      "follow_author": MessageLookupByLibrary.simpleMessage("Follow {name}"),
      "followers": MessageLookupByLibrary.simpleMessage("Followers"),
      "following": MessageLookupByLibrary.simpleMessage("Following"),
      "forgotPassword":
          MessageLookupByLibrary.simpleMessage("Forgot password?"),
      "guidesAndAnswers": MessageLookupByLibrary.simpleMessage(
        "Guides and answers to common questions",
      ),
      "handle": MessageLookupByLibrary.simpleMessage("handle"),
      "helpCentre": MessageLookupByLibrary.simpleMessage("Help Centre"),
      "helpAndSupport": MessageLookupByLibrary.simpleMessage("Help & Support"),
      "inOneLine": MessageLookupByLibrary.simpleMessage("In one line"),
      "ins_account": MessageLookupByLibrary.simpleMessage("Your account"),
      "ins_act_community":
          MessageLookupByLibrary.simpleMessage("Open the community"),
      "ins_act_post": MessageLookupByLibrary.simpleMessage("Write a post"),
      "ins_act_post_open": MessageLookupByLibrary.simpleMessage("See the post"),
      "ins_act_profile":
          MessageLookupByLibrary.simpleMessage("Edit your profile"),
      "ins_active":
          MessageLookupByLibrary.simpleMessage("When they are around"),
      "ins_active_note":
          MessageLookupByLibrary.simpleMessage("In your time zone."),
      "ins_ages": MessageLookupByLibrary.simpleMessage("Ages"),
      "ins_ages_note": MessageLookupByLibrary.simpleMessage(
          "From the {known} people reached who gave a birthday."),
      "ins_chart":
          MessageLookupByLibrary.simpleMessage("People reached each day"),
      "ins_communities":
          MessageLookupByLibrary.simpleMessage("Communities they are in"),
      "ins_countries": MessageLookupByLibrary.simpleMessage("Countries"),
      "ins_countries_note": MessageLookupByLibrary.simpleMessage(
          "From the {known} people reached who have a country on their profile."),
      "ins_days": MessageLookupByLibrary.simpleMessage("Last {days} days"),
      "ins_failed":
          MessageLookupByLibrary.simpleMessage("Insights could not load"),
      "ins_followers": MessageLookupByLibrary.simpleMessage("Followers"),
      "ins_group_small": MessageLookupByLibrary.simpleMessage(
          "No group is large enough to show yet."),
      "ins_grow": MessageLookupByLibrary.simpleMessage("How to grow"),
      "ins_interests":
          MessageLookupByLibrary.simpleMessage("Topics they follow"),
      "ins_likes": MessageLookupByLibrary.simpleMessage("Likes"),
      "ins_new": MessageLookupByLibrary.simpleMessage("New"),
      "ins_new_followers":
          MessageLookupByLibrary.simpleMessage("New followers"),
      "ins_no_posts_reached": MessageLookupByLibrary.simpleMessage(
          "None of your posts reached anyone in this period."),
      "ins_non_followers":
          MessageLookupByLibrary.simpleMessage("Not following you"),
      "ins_not_collected_city": MessageLookupByLibrary.simpleMessage(
          "Countries are the ones people chose on their profiles. Kyron does not collect anyone's city or gender, so there is nothing to show for them."),
      "ins_opens": MessageLookupByLibrary.simpleMessage("Opens"),
      "ins_post_line": MessageLookupByLibrary.simpleMessage(
          "{reach} reached · {likes} likes · {replies} replies"),
      "ins_reach": MessageLookupByLibrary.simpleMessage("People reached"),
      "ins_reach_note": MessageLookupByLibrary.simpleMessage(
          "People reached counts each person once: shown or opening one of your posts for the first time. New followers still follow you; unfollows are not counted."),
      "ins_replies": MessageLookupByLibrary.simpleMessage("Replies"),
      "ins_reposts": MessageLookupByLibrary.simpleMessage("Reposts"),
      "ins_saves": MessageLookupByLibrary.simpleMessage("Saves"),
      "ins_small": MessageLookupByLibrary.simpleMessage(
          "Who your audience is shows once {floor} people have seen your posts in this period. Any fewer, and it could point at someone."),
      "ins_small_title":
          MessageLookupByLibrary.simpleMessage("Not enough people yet"),
      "ins_sum_mostly_followers": MessageLookupByLibrary.simpleMessage(
          "{pct}% of them already follow you: your posts mostly reach people who know you."),
      "ins_sum_mostly_strangers": MessageLookupByLibrary.simpleMessage(
          "{pct}% of them do not follow you yet: your posts are being found."),
      "ins_sum_reach_down_pct": MessageLookupByLibrary.simpleMessage(
          "You reached {reach} people, {pct}% fewer than the period before."),
      "ins_sum_reach_first": MessageLookupByLibrary.simpleMessage(
          "You reached {reach} people in the last {days} days."),
      "ins_sum_reach_flat": MessageLookupByLibrary.simpleMessage(
          "You reached {reach} people, about as many as the period before."),
      "ins_sum_reach_none": MessageLookupByLibrary.simpleMessage(
          "Nobody new saw your posts in the last {days} days."),
      "ins_sum_reach_up_pct": MessageLookupByLibrary.simpleMessage(
          "You reached {reach} people, {pct}% more than the period before."),
      "ins_sum_reach_up_times": MessageLookupByLibrary.simpleMessage(
          "You reached {reach} people, {times}× as many as the period before."),
      "ins_sum_top_interest": MessageLookupByLibrary.simpleMessage(
          "More of them follow {name} than any other topic."),
      "ins_tab_audience": MessageLookupByLibrary.simpleMessage("Audience"),
      "ins_tab_overview": MessageLookupByLibrary.simpleMessage("Overview"),
      "ins_tip_add_avatar": MessageLookupByLibrary.simpleMessage(
          "People who find one of your posts look at your profile before they follow. A face or a logo tells them somebody is there."),
      "ins_tip_add_avatar_t":
          MessageLookupByLibrary.simpleMessage("Add a profile picture"),
      "ins_tip_add_bio": MessageLookupByLibrary.simpleMessage(
          "Say in a line what you post about, so a stranger knows what following you gets them."),
      "ins_tip_add_bio_t": MessageLookupByLibrary.simpleMessage("Write a bio"),
      "ins_tip_add_topics": MessageLookupByLibrary.simpleMessage(
          "{without} of your {total} posts had no topic. A topic puts a post in that topic's feed and in front of the people who follow it."),
      "ins_tip_add_topics_t":
          MessageLookupByLibrary.simpleMessage("Add topics to your posts"),
      "ins_tip_answer_comments": MessageLookupByLibrary.simpleMessage(
          "{received} people replied to your posts and you answered {answered}. They already cared enough to write: an answer turns a reader into a regular."),
      "ins_tip_answer_comments_t":
          MessageLookupByLibrary.simpleMessage("Answer your replies"),
      "ins_tip_best_time": MessageLookupByLibrary.simpleMessage(
          "Your audience is most active on {when}. A post put up just before then has people there to meet it."),
      "ins_tip_best_time_t":
          MessageLookupByLibrary.simpleMessage("Post when they are around"),
      "ins_tip_convert_strangers": MessageLookupByLibrary.simpleMessage(
          "{reached} people who do not follow you saw your posts, and {gained} followed. Make your bio and your newest posts say what they can expect from you."),
      "ins_tip_convert_strangers_t":
          MessageLookupByLibrary.simpleMessage("Turn readers into followers"),
      "ins_tip_more_like_top": MessageLookupByLibrary.simpleMessage(
          "One post reached {times}× as many people as your others usually do. Look at what it did differently, and do more of that."),
      "ins_tip_more_like_top_t":
          MessageLookupByLibrary.simpleMessage("Do more of what worked"),
      "ins_tip_post_in_community": MessageLookupByLibrary.simpleMessage(
          "Many of the people who see your posts are in {name}. Posting there puts you in front of the rest of it."),
      "ins_tip_post_in_community_t":
          MessageLookupByLibrary.simpleMessage("Post in {name}"),
      "ins_tip_post_more": MessageLookupByLibrary.simpleMessage(
          "You posted {posts} times in {days} days. Every post is another chance to be found, and a steady rhythm keeps you in your followers' feeds."),
      "ins_tip_post_more_t":
          MessageLookupByLibrary.simpleMessage("Post more often"),
      "ins_tip_post_something": MessageLookupByLibrary.simpleMessage(
          "You have not posted in the last {days} days. Nothing reaches anyone without a post."),
      "ins_tip_post_something_t":
          MessageLookupByLibrary.simpleMessage("Post something"),
      "ins_title": MessageLookupByLibrary.simpleMessage("Insights"),
      "ins_top_posts": MessageLookupByLibrary.simpleMessage("Top posts"),
      "ins_vs_before": MessageLookupByLibrary.simpleMessage(
          "Against the {days} days before"),
      "itDisappearsForBoth": MessageLookupByLibrary.simpleMessage(
        "It disappears for both of you.",
      ),
      "itWillBeRemoved": MessageLookupByLibrary.simpleMessage(
        "It will be removed from the thread.",
      ),
      "keepEditing": MessageLookupByLibrary.simpleMessage("Keep editing"),
      "kyron": MessageLookupByLibrary.simpleMessage("Kyron"),
      "lagosDesign": MessageLookupByLibrary.simpleMessage("Lagos Design"),
      "leave": MessageLookupByLibrary.simpleMessage("Leave"),
      "leaveCommunity": (Object a0) => "Leave $a0?",
      "letBackIn": MessageLookupByLibrary.simpleMessage("Let back in"),
      "loadMore": MessageLookupByLibrary.simpleMessage("Load more"),
      "logCleared": MessageLookupByLibrary.simpleMessage("Log cleared"),
      "logCopied": MessageLookupByLibrary.simpleMessage("Log copied"),
      "logIn": MessageLookupByLibrary.simpleMessage("Log in"),
      "logOut": MessageLookupByLibrary.simpleMessage("Log Out"),
      "logOutQuestion": MessageLookupByLibrary.simpleMessage("Log Out?"),
      "message": MessageLookupByLibrary.simpleMessage("Message"),
      "mute": MessageLookupByLibrary.simpleMessage("Mute"),
      "mutedAndBlocked":
          MessageLookupByLibrary.simpleMessage("Muted and blocked"),
      "mutedWordsAndTags": MessageLookupByLibrary.simpleMessage(
        "Muted words and tags",
      ),
      "name": MessageLookupByLibrary.simpleMessage("Name"),
      "nameScreen": MessageLookupByLibrary.simpleMessage("<name> Screen"),
      "newEmailAddress":
          MessageLookupByLibrary.simpleMessage("New email address"),
      "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
      "newPost": MessageLookupByLibrary.simpleMessage("New post"),
      "nothingToCopy": MessageLookupByLibrary.simpleMessage("Nothing to copy"),
      "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
      "notNow": MessageLookupByLibrary.simpleMessage("Not now"),
      "notSentTapRetry": MessageLookupByLibrary.simpleMessage(
        "Not sent. Tap to try again",
      ),
      "openInBrowser": MessageLookupByLibrary.simpleMessage("Open in browser"),
      "pageNotFound": MessageLookupByLibrary.simpleMessage("Page not found"),
      "pickYourInterests": MessageLookupByLibrary.simpleMessage(
        "Pick your interests",
      ),
      "post": MessageLookupByLibrary.simpleMessage("Post"),
      "postAnalytics": MessageLookupByLibrary.simpleMessage("Post analytics"),
      "postInCommunity": (Object a0) => "Post in $a0",
      "postTextCopied":
          MessageLookupByLibrary.simpleMessage("Post text copied"),
      "profileUpdated": MessageLookupByLibrary.simpleMessage("Profile updated"),
      "profile_country": MessageLookupByLibrary.simpleMessage("Country"),
      "pushNotifications": MessageLookupByLibrary.simpleMessage(
        "Push notifications",
      ),
      "quote": MessageLookupByLibrary.simpleMessage("Quote"),
      "quotePost": MessageLookupByLibrary.simpleMessage("Quote post"),
      "reachAPerson": MessageLookupByLibrary.simpleMessage("Reach a person"),
      "remove": MessageLookupByLibrary.simpleMessage("Remove"),
      "removeMember": (Object a0) => "Remove $a0?",
      "removeConversation": MessageLookupByLibrary.simpleMessage(
        "Remove this conversation?",
      ),
      "removeMessage":
          MessageLookupByLibrary.simpleMessage("Remove this message?"),
      "repliesFollowsMentions": MessageLookupByLibrary.simpleMessage(
        "Replies, follows and mentions",
      ),
      "reply": MessageLookupByLibrary.simpleMessage("Reply"),
      "report": MessageLookupByLibrary.simpleMessage("Report"),
      "reportCopied": MessageLookupByLibrary.simpleMessage(
        "Report copied. Paste it into an email to support.",
      ),
      "reportSent": MessageLookupByLibrary.simpleMessage("Report sent"),
      "repost": MessageLookupByLibrary.simpleMessage("Repost"),
      "reset": MessageLookupByLibrary.simpleMessage("Reset"),
      "resetPassword":
          MessageLookupByLibrary.simpleMessage("Reset your password"),
      "retry": MessageLookupByLibrary.simpleMessage("Retry"),
      "save": MessageLookupByLibrary.simpleMessage("Save"),
      "saveDraft": MessageLookupByLibrary.simpleMessage("Save draft"),
      "saySomething": (Object a0) => "Say something to $a0",
      "searchByNameOrHandle": MessageLookupByLibrary.simpleMessage(
        "Search by name or handle",
      ),
      "searchCommunities": MessageLookupByLibrary.simpleMessage(
        "Search communities",
      ),
      "searchGIFs": MessageLookupByLibrary.simpleMessage("Search GIFs"),
      "searchLanguages":
          MessageLookupByLibrary.simpleMessage("Search languages"),
      "searchTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Search trending tags",
      ),
      "securityAlerts": MessageLookupByLibrary.simpleMessage(
        "Security alerts and account changes",
      ),
      "sendConfirmation":
          MessageLookupByLibrary.simpleMessage("Send confirmation"),
      "sendErrorReport":
          MessageLookupByLibrary.simpleMessage("Send error report"),
      "sendFeedback": MessageLookupByLibrary.simpleMessage("Send feedback"),
      "sendReport": MessageLookupByLibrary.simpleMessage("Send report"),
      "sendToSupport": MessageLookupByLibrary.simpleMessage("Send to support"),
      "serviceStatus": MessageLookupByLibrary.simpleMessage("Service status"),
      "shareAppLog": MessageLookupByLibrary.simpleMessage(
        "Share the app log with support",
      ),
      "signedInAs": MessageLookupByLibrary.simpleMessage("Signed in as"),
      "signInToKyron": MessageLookupByLibrary.simpleMessage("Sign in to Kyron"),
      "signupFailed": (Object a0) => "Signup failed: $a0",
      "stay": MessageLookupByLibrary.simpleMessage("Stay"),
      "systemLog": MessageLookupByLibrary.simpleMessage("System log"),
      "tellMissingBroken": MessageLookupByLibrary.simpleMessage(
        "Tell us what is missing or broken",
      ),
      "theComposerNoPostButton": MessageLookupByLibrary.simpleMessage(
        "The composer has no Post button",
      ),
      "translate": MessageLookupByLibrary.simpleMessage("Translate"),
      "tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
      "ui_appeal_hint": MessageLookupByLibrary.simpleMessage(
          "I was quoting the scam to warn people about it."),
      "ui_appeal_intro": MessageLookupByLibrary.simpleMessage(
          "Say why you think the decision was wrong: what the post meant, what the team may have missed, or why the rule does not fit. Somebody other than whoever decided reads it."),
      "ui_appeal_label": MessageLookupByLibrary.simpleMessage("Your appeal"),
      "ui_appeal_rules": MessageLookupByLibrary.simpleMessage(
          "Write at least \$count characters. You can appeal each decision once."),
      "ui_appeal_send": MessageLookupByLibrary.simpleMessage("Send appeal"),
      "ui_appeal_sent": MessageLookupByLibrary.simpleMessage(
          "Appeal sent. You will get a notification when it is decided."),
      "ui_appeal_title":
          MessageLookupByLibrary.simpleMessage("Appeal case \$number"),
      "ui_cchat_about":
          MessageLookupByLibrary.simpleMessage("What it is for (optional)"),
      "ui_cchat_announcements":
          MessageLookupByLibrary.simpleMessage("Only moderators can write"),
      "ui_cchat_announcements_detail": MessageLookupByLibrary.simpleMessage(
          "For announcements. Everyone in the community can still read and react."),
      "ui_cchat_attach":
          MessageLookupByLibrary.simpleMessage("Add a photo or a poll"),
      "ui_cchat_attach_gallery":
          MessageLookupByLibrary.simpleMessage("Photos and videos"),
      "ui_cchat_close": MessageLookupByLibrary.simpleMessage("Close chat"),
      "ui_cchat_close_detail": MessageLookupByLibrary.simpleMessage(
          "Nobody will be able to read or write in it. This cannot be undone."),
      "ui_cchat_close_title":
          MessageLookupByLibrary.simpleMessage("Close this chat?"),
      "ui_cchat_copied": MessageLookupByLibrary.simpleMessage("Copied"),
      "ui_cchat_delete_other": MessageLookupByLibrary.simpleMessage(
          "It is taken down for everyone. Kyron keeps a copy for review."),
      "ui_cchat_delete_own": MessageLookupByLibrary.simpleMessage(
          "It is taken down for everyone in the chat."),
      "ui_cchat_edit": MessageLookupByLibrary.simpleMessage("Edit chat"),
      "ui_cchat_edit_message": MessageLookupByLibrary.simpleMessage("Edit"),
      "ui_cchat_edited": MessageLookupByLibrary.simpleMessage("edited"),
      "ui_cchat_editing":
          MessageLookupByLibrary.simpleMessage("Editing your message"),
      "ui_cchat_failed":
          MessageLookupByLibrary.simpleMessage("Could not open this chat."),
      "ui_cchat_heading": MessageLookupByLibrary.simpleMessage("Chats"),
      "ui_cchat_join": MessageLookupByLibrary.simpleMessage("Join chat"),
      "ui_cchat_join_community": MessageLookupByLibrary.simpleMessage(
          "Join the community to see and take part in its chats."),
      "ui_cchat_joined": MessageLookupByLibrary.simpleMessage("\$count joined"),
      "ui_cchat_leave": MessageLookupByLibrary.simpleMessage("Leave chat"),
      "ui_cchat_leave_detail": MessageLookupByLibrary.simpleMessage(
          "You can still read it while you are in the community."),
      "ui_cchat_moderators_only": MessageLookupByLibrary.simpleMessage(
          "Only the owner and moderators can write here."),
      "ui_cchat_mute": MessageLookupByLibrary.simpleMessage("Mute"),
      "ui_cchat_mute_detail": MessageLookupByLibrary.simpleMessage(
          "No notifications from it, and it is left out of the Messages count."),
      "ui_cchat_name": MessageLookupByLibrary.simpleMessage("Chat name"),
      "ui_cchat_new": MessageLookupByLibrary.simpleMessage("New chat"),
      "ui_cchat_none": MessageLookupByLibrary.simpleMessage("No chats yet."),
      "ui_cchat_none_mod": MessageLookupByLibrary.simpleMessage(
          "No chats yet. Open one for the community."),
      "ui_cchat_not_encrypted": MessageLookupByLibrary.simpleMessage(
          "Community chats are not end-to-end encrypted. The community's moderators and Kyron can read them."),
      "ui_cchat_pin": MessageLookupByLibrary.simpleMessage("Pin to the top"),
      "ui_cchat_poll_add":
          MessageLookupByLibrary.simpleMessage("Add an answer"),
      "ui_cchat_poll_close": MessageLookupByLibrary.simpleMessage("Close poll"),
      "ui_cchat_poll_closed": MessageLookupByLibrary.simpleMessage("Closed"),
      "ui_cchat_poll_detail": MessageLookupByLibrary.simpleMessage(
          "Everyone sees how many chose each answer, never who."),
      "ui_cchat_poll_multiple":
          MessageLookupByLibrary.simpleMessage("Let people choose several"),
      "ui_cchat_poll_new": MessageLookupByLibrary.simpleMessage("New poll"),
      "ui_cchat_poll_one": MessageLookupByLibrary.simpleMessage("Choose one"),
      "ui_cchat_poll_option":
          MessageLookupByLibrary.simpleMessage("Answer \$n"),
      "ui_cchat_poll_preview":
          MessageLookupByLibrary.simpleMessage("Poll: \$question"),
      "ui_cchat_poll_question":
          MessageLookupByLibrary.simpleMessage("Question"),
      "ui_cchat_poll_repeated": MessageLookupByLibrary.simpleMessage(
          "Each answer can be in a poll once."),
      "ui_cchat_poll_several":
          MessageLookupByLibrary.simpleMessage("Choose one or more"),
      "ui_cchat_poll_voters":
          MessageLookupByLibrary.simpleMessage("\$count answered"),
      "ui_cchat_search":
          MessageLookupByLibrary.simpleMessage("Search this chat"),
      "ui_cchat_search_hint":
          MessageLookupByLibrary.simpleMessage("Search this chat"),
      "ui_cchat_search_none":
          MessageLookupByLibrary.simpleMessage("Nothing found."),
      "ui_cchat_shut": MessageLookupByLibrary.simpleMessage(
          "You cannot see this chat any more."),
      "ui_cchat_slow": MessageLookupByLibrary.simpleMessage("Slow mode"),
      "ui_cchat_slow_detail": MessageLookupByLibrary.simpleMessage(
          "How long people wait between messages. Not moderators."),
      "ui_cchat_slow_hour": MessageLookupByLibrary.simpleMessage("1 hour"),
      "ui_cchat_slow_minutes":
          MessageLookupByLibrary.simpleMessage("\$n minutes"),
      "ui_cchat_slow_mode": MessageLookupByLibrary.simpleMessage(
          "Slow mode: one message every \$seconds seconds"),
      "ui_cchat_slow_off": MessageLookupByLibrary.simpleMessage("Off"),
      "ui_cchat_slow_seconds":
          MessageLookupByLibrary.simpleMessage("\$n seconds"),
      "ui_cchat_spectator": MessageLookupByLibrary.simpleMessage(
          "You can read and react as a spectator. Join to write."),
      "ui_cchat_too_far": MessageLookupByLibrary.simpleMessage(
          "That message is too far back to show."),
      "ui_cchat_too_large": MessageLookupByLibrary.simpleMessage(
          "Something you picked is too large to send and was left out."),
      "ui_cchat_unmute": MessageLookupByLibrary.simpleMessage("Unmute"),
      "ui_cchat_unpin": MessageLookupByLibrary.simpleMessage("Unpin"),
      "ui_cchat_voice":
          MessageLookupByLibrary.simpleMessage("Record a voice note"),
      "ui_cchat_you": MessageLookupByLibrary.simpleMessage("You"),
      "ui_community_posts": MessageLookupByLibrary.simpleMessage("Posts:"),
      "ui_dm_groups": MessageLookupByLibrary.simpleMessage("Groups"),
      "ui_dm_groups_none": MessageLookupByLibrary.simpleMessage("No groups"),
      "ui_dm_groups_none_detail": MessageLookupByLibrary.simpleMessage(
          "Groups you are in, and the community chats you join, are listed here."),
      "ui_dm_pin_limit": MessageLookupByLibrary.simpleMessage(
          "You can pin up to \$count chats. Unpin one first."),
      "ui_dm_pinned": MessageLookupByLibrary.simpleMessage("Pinned"),
      "ui_drawer_liked": MessageLookupByLibrary.simpleMessage("Liked"),
      "ui_drawer_saved": MessageLookupByLibrary.simpleMessage("Saved"),
      "ui_feed_signal_fading": MessageLookupByLibrary.simpleMessage("Fading"),
      "ui_feed_signal_less":
          MessageLookupByLibrary.simpleMessage("Not interested"),
      "ui_feed_signal_more":
          MessageLookupByLibrary.simpleMessage("Show more like this"),
      "ui_feed_signal_removed": MessageLookupByLibrary.simpleMessage("Removed"),
      "ui_feed_signals":
          MessageLookupByLibrary.simpleMessage("Your feed signals"),
      "ui_feed_signals_empty": MessageLookupByLibrary.simpleMessage(
          "Tap Show more posts like this or Not interested in this on a post, and it shows up here."),
      "ui_feed_signals_empty_title":
          MessageLookupByLibrary.simpleMessage("Nothing here yet"),
      "ui_feed_signals_help": MessageLookupByLibrary.simpleMessage(
          "What Show more and Not interested are telling your feeds"),
      "ui_feed_signals_intro": MessageLookupByLibrary.simpleMessage(
          "These shape Home and Explore, mostly by what each post was about. Each one fades by half every month and stops counting after six. Remove one to stop it now."),
      "ui_group_add": MessageLookupByLibrary.simpleMessage("Add people"),
      "ui_group_add_action": MessageLookupByLibrary.simpleMessage("Add"),
      "ui_group_add_name":
          MessageLookupByLibrary.simpleMessage("Add group name"),
      "ui_group_dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
      "ui_group_e2ee": MessageLookupByLibrary.simpleMessage(
          "Messages in this group are end-to-end encrypted, like any other conversation."),
      "ui_group_event_added":
          MessageLookupByLibrary.simpleMessage("\$actor added \$users"),
      "ui_group_event_admin":
          MessageLookupByLibrary.simpleMessage("\$actor made \$users an admin"),
      "ui_group_event_created":
          MessageLookupByLibrary.simpleMessage("\$actor created the group"),
      "ui_group_event_join_member": MessageLookupByLibrary.simpleMessage(
          "\$actor set new people to join as members"),
      "ui_group_event_join_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor set new people to join as spectators"),
      "ui_group_event_left":
          MessageLookupByLibrary.simpleMessage("\$actor left"),
      "ui_group_event_member":
          MessageLookupByLibrary.simpleMessage("\$actor made \$users a member"),
      "ui_group_event_owner": MessageLookupByLibrary.simpleMessage(
          "\$actor made \$users the owner"),
      "ui_group_event_removed":
          MessageLookupByLibrary.simpleMessage("\$actor removed \$users"),
      "ui_group_event_renamed": MessageLookupByLibrary.simpleMessage(
          "\$actor renamed the group \$title"),
      "ui_group_event_spectator": MessageLookupByLibrary.simpleMessage(
          "\$actor made \$users a spectator"),
      "ui_group_full": MessageLookupByLibrary.simpleMessage(
          "A group can have at most \$count people."),
      "ui_group_hand_raised": MessageLookupByLibrary.simpleMessage(
          "Hand raised. The admins have been told."),
      "ui_group_hands":
          MessageLookupByLibrary.simpleMessage("\$count asking to write"),
      "ui_group_hands_heading":
          MessageLookupByLibrary.simpleMessage("Asking to write"),
      "ui_group_join_spectators": MessageLookupByLibrary.simpleMessage(
          "People added later join as spectators"),
      "ui_group_leave": MessageLookupByLibrary.simpleMessage("Leave group"),
      "ui_group_leave_detail": MessageLookupByLibrary.simpleMessage(
          "It leaves your list, and you will not see what is said after. Somebody would have to add you again."),
      "ui_group_leave_title":
          MessageLookupByLibrary.simpleMessage("Leave this group?"),
      "ui_group_let_write":
          MessageLookupByLibrary.simpleMessage("Let them write"),
      "ui_group_lower_hand": MessageLookupByLibrary.simpleMessage("Lower hand"),
      "ui_group_make_admin": MessageLookupByLibrary.simpleMessage("Make admin"),
      "ui_group_make_owner": MessageLookupByLibrary.simpleMessage("Make owner"),
      "ui_group_make_spectator":
          MessageLookupByLibrary.simpleMessage("Make spectator"),
      "ui_group_member_count":
          MessageLookupByLibrary.simpleMessage("\$count members"),
      "ui_group_members": MessageLookupByLibrary.simpleMessage("Members"),
      "ui_group_name": MessageLookupByLibrary.simpleMessage("Group name"),
      "ui_group_name_first":
          MessageLookupByLibrary.simpleMessage("Name the group first."),
      "ui_group_new": MessageLookupByLibrary.simpleMessage("Create group chat"),
      "ui_group_owner_detail": MessageLookupByLibrary.simpleMessage(
          "There is one owner. You will stay on as an admin."),
      "ui_group_owner_title":
          MessageLookupByLibrary.simpleMessage("Make \$name the owner?"),
      "ui_group_raise_hand": MessageLookupByLibrary.simpleMessage("Raise hand"),
      "ui_group_remove":
          MessageLookupByLibrary.simpleMessage("Remove from group"),
      "ui_group_remove_admin":
          MessageLookupByLibrary.simpleMessage("Remove as admin"),
      "ui_group_removed": MessageLookupByLibrary.simpleMessage(
          "You are no longer in this group."),
      "ui_group_rename": MessageLookupByLibrary.simpleMessage("Rename"),
      "ui_group_role_admin": MessageLookupByLibrary.simpleMessage("Admin"),
      "ui_group_role_member": MessageLookupByLibrary.simpleMessage("Member"),
      "ui_group_role_spectator":
          MessageLookupByLibrary.simpleMessage("Spectator"),
      "ui_group_spectator_note": MessageLookupByLibrary.simpleMessage(
          "You can read and react here as a spectator."),
      "ui_group_spectators_detail": MessageLookupByLibrary.simpleMessage(
          "Spectators can read, react and raise a hand to ask to write."),
      "ui_group_suggested": MessageLookupByLibrary.simpleMessage("Suggested"),
      "ui_group_view_profile":
          MessageLookupByLibrary.simpleMessage("View profile"),
      "ui_group_you": MessageLookupByLibrary.simpleMessage("you"),
      "ui_group_you_spectate":
          MessageLookupByLibrary.simpleMessage("You are a spectator"),
      "ui_language_detail":
          MessageLookupByLibrary.simpleMessage("Choose your language"),
      "ui_notif_account_update":
          MessageLookupByLibrary.simpleMessage("Your account was updated"),
      "ui_notif_appeal_accepted": MessageLookupByLibrary.simpleMessage(
          "Your appeal on case \$number was accepted"),
      "ui_notif_appeal_upheld": MessageLookupByLibrary.simpleMessage(
          "We looked at your appeal on case \$number again, and the decision stands"),
      "ui_notif_banned":
          MessageLookupByLibrary.simpleMessage("Your account has been banned"),
      "ui_notif_case":
          MessageLookupByLibrary.simpleMessage("Case \$number · \$rule"),
      "ui_notif_followed": MessageLookupByLibrary.simpleMessage("followed you"),
      "ui_notif_liked": MessageLookupByLibrary.simpleMessage("liked your post"),
      "ui_notif_older": MessageLookupByLibrary.simpleMessage("Older"),
      "ui_notif_removed_message": MessageLookupByLibrary.simpleMessage(
          "Your message in a community chat was removed"),
      "ui_notif_removed_other": MessageLookupByLibrary.simpleMessage(
          "Something you posted was removed"),
      "ui_notif_removed_post":
          MessageLookupByLibrary.simpleMessage("Your post was removed"),
      "ui_notif_removed_reply":
          MessageLookupByLibrary.simpleMessage("Your reply was removed"),
      "ui_notif_replied":
          MessageLookupByLibrary.simpleMessage("replied to your post"),
      "ui_notif_report_actioned": MessageLookupByLibrary.simpleMessage(
          "We acted on something you reported. Thank you for telling us."),
      "ui_notif_report_dismissed": MessageLookupByLibrary.simpleMessage(
          "We looked at something you reported and did not find that it broke our rules."),
      "ui_notif_reported_for":
          MessageLookupByLibrary.simpleMessage("Reported for: \$reason"),
      "ui_notif_reposted":
          MessageLookupByLibrary.simpleMessage("reposted your post"),
      "ui_notif_reversed":
          MessageLookupByLibrary.simpleMessage("We reversed case \$number"),
      "ui_notif_suspended":
          MessageLookupByLibrary.simpleMessage("Your account is suspended"),
      "ui_notif_suspended_until": MessageLookupByLibrary.simpleMessage(
          "Your account is suspended until \$date"),
      "ui_notif_tab_all": MessageLookupByLibrary.simpleMessage("All"),
      "ui_notif_tab_follows": MessageLookupByLibrary.simpleMessage("Follows"),
      "ui_notif_tab_likes": MessageLookupByLibrary.simpleMessage("Likes"),
      "ui_notif_tab_replies": MessageLookupByLibrary.simpleMessage("Replies"),
      "ui_notif_this_week": MessageLookupByLibrary.simpleMessage("This week"),
      "ui_notif_today": MessageLookupByLibrary.simpleMessage("Today"),
      "ui_notif_warned":
          MessageLookupByLibrary.simpleMessage("Your account has a warning"),
      "ui_notif_yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
      "ui_once_already":
          MessageLookupByLibrary.simpleMessage("This has already been opened."),
      "ui_once_expired": MessageLookupByLibrary.simpleMessage("Expired"),
      "ui_once_failed":
          MessageLookupByLibrary.simpleMessage("This could not be opened."),
      "ui_once_hint": MessageLookupByLibrary.simpleMessage(
          "Opens once, then it is deleted from Kyron."),
      "ui_once_label": MessageLookupByLibrary.simpleMessage("View once"),
      "ui_once_opened": MessageLookupByLibrary.simpleMessage("Opened"),
      "ui_once_opened_by":
          MessageLookupByLibrary.simpleMessage("Opened by \$count of \$total"),
      "ui_once_own": MessageLookupByLibrary.simpleMessage(
          "Only the people you sent this to can open it, once."),
      "ui_once_send": MessageLookupByLibrary.simpleMessage("Send view once"),
      "ui_once_tap": MessageLookupByLibrary.simpleMessage("Tap to view"),
      "ui_report_add":
          MessageLookupByLibrary.simpleMessage("Anything to add? (optional)"),
      "ui_report_follow_up": MessageLookupByLibrary.simpleMessage(
          "You get a notification when the team decides, and you can follow it in Your reports."),
      "ui_report_mute_block": MessageLookupByLibrary.simpleMessage(
          "If you also want to stop seeing them, mute or block them from the same menu."),
      "ui_report_once": MessageLookupByLibrary.simpleMessage(
          "Reporting the same thing twice does not add weight to it: we keep one report per person."),
      "ui_report_private": MessageLookupByLibrary.simpleMessage(
          "Your report is not shared with them. We keep a copy of what you reported, so it can still be reviewed if it is deleted."),
      "ui_report_received": MessageLookupByLibrary.simpleMessage(
          "Your report has been received and is queued for review. We do not tell them who reported it."),
      "ui_report_see_reports":
          MessageLookupByLibrary.simpleMessage("See your reports"),
      "ui_report_tell_us":
          MessageLookupByLibrary.simpleMessage("Tell us what is wrong"),
      "ui_report_thanks":
          MessageLookupByLibrary.simpleMessage("Thanks for telling us"),
      "ui_report_what_account":
          MessageLookupByLibrary.simpleMessage("What is wrong with \$name?"),
      "ui_report_what_message": MessageLookupByLibrary.simpleMessage(
          "What is wrong with this message?"),
      "ui_report_what_post":
          MessageLookupByLibrary.simpleMessage("What is wrong with this post?"),
      "ui_report_what_reply": MessageLookupByLibrary.simpleMessage(
          "What is wrong with this reply?"),
      "ui_reports_a_message":
          MessageLookupByLibrary.simpleMessage("A community chat message"),
      "ui_reports_a_post": MessageLookupByLibrary.simpleMessage("A post"),
      "ui_reports_a_reply": MessageLookupByLibrary.simpleMessage("A reply"),
      "ui_reports_actioned":
          MessageLookupByLibrary.simpleMessage("Action taken"),
      "ui_reports_an_account":
          MessageLookupByLibrary.simpleMessage("An account"),
      "ui_reports_decided_on":
          MessageLookupByLibrary.simpleMessage("Decided \$date"),
      "ui_reports_dismissed":
          MessageLookupByLibrary.simpleMessage("No rule broken"),
      "ui_reports_failed": MessageLookupByLibrary.simpleMessage(
          "Your reports could not be loaded"),
      "ui_reports_intro": MessageLookupByLibrary.simpleMessage(
          "What you reported in the last 90 days, and what came of it. You get a notification when the team decides. Nobody you report is told who reported them."),
      "ui_reports_none":
          MessageLookupByLibrary.simpleMessage("Nothing reported"),
      "ui_reports_none_detail": MessageLookupByLibrary.simpleMessage(
          "When you report a post, a reply, a message or an account, it is listed here with what came of it."),
      "ui_reports_pending": MessageLookupByLibrary.simpleMessage("In review"),
      "ui_reports_sent_on":
          MessageLookupByLibrary.simpleMessage("Reported \$date"),
      "ui_reports_settings_help": MessageLookupByLibrary.simpleMessage(
          "What you reported, and what came of it"),
      "ui_reports_title": MessageLookupByLibrary.simpleMessage("Your reports"),
      "ui_rule_child_safety":
          MessageLookupByLibrary.simpleMessage("Child safety"),
      "ui_rule_detail_child_safety": MessageLookupByLibrary.simpleMessage(
          "Anything endangering or sexualising a minor."),
      "ui_rule_detail_harassment": MessageLookupByLibrary.simpleMessage(
          "Targeted abuse, threats, or unwanted contact."),
      "ui_rule_detail_hate": MessageLookupByLibrary.simpleMessage(
          "Attacks on people for who they are."),
      "ui_rule_detail_illegal_goods": MessageLookupByLibrary.simpleMessage(
          "Selling or promoting something unlawful."),
      "ui_rule_detail_impersonation": MessageLookupByLibrary.simpleMessage(
          "Pretending to be someone else."),
      "ui_rule_detail_intellectual_property":
          MessageLookupByLibrary.simpleMessage(
              "Uses your work or trademark without permission."),
      "ui_rule_detail_misinformation": MessageLookupByLibrary.simpleMessage(
          "Misleading claims about health, elections, or events."),
      "ui_rule_detail_self_harm": MessageLookupByLibrary.simpleMessage(
          "Encouraging or depicting self-harm."),
      "ui_rule_detail_sexual_content": MessageLookupByLibrary.simpleMessage(
          "Sexual content shown without warning."),
      "ui_rule_detail_something_else": MessageLookupByLibrary.simpleMessage(
          "None of the above. Tell us what is wrong."),
      "ui_rule_detail_spam": MessageLookupByLibrary.simpleMessage(
          "Repetitive, misleading, or unwanted promotion."),
      "ui_rule_detail_violence": MessageLookupByLibrary.simpleMessage(
          "Threatening, glorifying, or inciting harm."),
      "ui_rule_harassment":
          MessageLookupByLibrary.simpleMessage("Harassment or bullying"),
      "ui_rule_hate": MessageLookupByLibrary.simpleMessage("Hate speech"),
      "ui_rule_illegal_goods":
          MessageLookupByLibrary.simpleMessage("Illegal goods or services"),
      "ui_rule_impersonation":
          MessageLookupByLibrary.simpleMessage("Impersonation"),
      "ui_rule_intellectual_property":
          MessageLookupByLibrary.simpleMessage("Intellectual property"),
      "ui_rule_misinformation":
          MessageLookupByLibrary.simpleMessage("False information"),
      "ui_rule_self_harm":
          MessageLookupByLibrary.simpleMessage("Suicide or self-harm"),
      "ui_rule_sexual_content":
          MessageLookupByLibrary.simpleMessage("Adult content"),
      "ui_rule_something_else":
          MessageLookupByLibrary.simpleMessage("Something else"),
      "ui_rule_spam": MessageLookupByLibrary.simpleMessage("Spam"),
      "ui_rule_violence":
          MessageLookupByLibrary.simpleMessage("Violence or threats"),
      "ui_standing_about":
          MessageLookupByLibrary.simpleMessage("What it was about"),
      "ui_standing_account_banned":
          MessageLookupByLibrary.simpleMessage("Your account is banned"),
      "ui_standing_answer":
          MessageLookupByLibrary.simpleMessage("The answer, on \$date:"),
      "ui_standing_appeal": MessageLookupByLibrary.simpleMessage("Appeal"),
      "ui_standing_appeal_button":
          MessageLookupByLibrary.simpleMessage("Appeal this decision"),
      "ui_standing_appeal_closed": MessageLookupByLibrary.simpleMessage(
          "This decision can no longer be appealed. If something is wrong, contact support."),
      "ui_standing_appeal_open":
          MessageLookupByLibrary.simpleMessage("Appeal under review"),
      "ui_standing_appeal_overturned":
          MessageLookupByLibrary.simpleMessage("Appeal accepted"),
      "ui_standing_appeal_pending": MessageLookupByLibrary.simpleMessage(
          "Somebody else on the team is looking at it again. You will get a notification when it is decided."),
      "ui_standing_appeal_until": MessageLookupByLibrary.simpleMessage(
          "If you think this was a mistake, you can ask for it to be looked at again until \$date. Somebody else on the team decides."),
      "ui_standing_appeal_upheld":
          MessageLookupByLibrary.simpleMessage("Appealed: the decision stands"),
      "ui_standing_ban_case": MessageLookupByLibrary.simpleMessage(
          "Case \$number. Rule: \$rule. The team said:"),
      "ui_standing_ban_note": MessageLookupByLibrary.simpleMessage(
          "Deleting your account does not lift a ban: a new account at the same email address starts banned too."),
      "ui_standing_banned": MessageLookupByLibrary.simpleMessage("Banned"),
      "ui_standing_banned_detail": MessageLookupByLibrary.simpleMessage(
          "Only this page, appeals, support and deleting your account still work."),
      "ui_standing_can_appeal":
          MessageLookupByLibrary.simpleMessage("Can be appealed"),
      "ui_standing_case": MessageLookupByLibrary.simpleMessage("Case \$number"),
      "ui_standing_decided":
          MessageLookupByLibrary.simpleMessage("Decided \$date"),
      "ui_standing_decisions":
          MessageLookupByLibrary.simpleMessage("Decisions about your account"),
      "ui_standing_delete_account":
          MessageLookupByLibrary.simpleMessage("Delete your account"),
      "ui_standing_details":
          MessageLookupByLibrary.simpleMessage("See details"),
      "ui_standing_details_appeal":
          MessageLookupByLibrary.simpleMessage("See details and appeal"),
      "ui_standing_ends": MessageLookupByLibrary.simpleMessage("Ends \$date"),
      "ui_standing_good": MessageLookupByLibrary.simpleMessage(
          "Your account is in good standing"),
      "ui_standing_good_detail":
          MessageLookupByLibrary.simpleMessage("Nothing is restricting it."),
      "ui_standing_load_failed": MessageLookupByLibrary.simpleMessage(
          "Account status could not be loaded"),
      "ui_standing_message_removed":
          MessageLookupByLibrary.simpleMessage("Message removed"),
      "ui_standing_nothing_decided": MessageLookupByLibrary.simpleMessage(
          "Nothing has been decided about your account. If the team ever removes something of yours or restricts your account, it is listed here with the reason, and you can appeal it."),
      "ui_standing_nothing_to_appeal": MessageLookupByLibrary.simpleMessage(
          "Nothing to appeal: the decision was reversed."),
      "ui_standing_post_removed":
          MessageLookupByLibrary.simpleMessage("Post removed"),
      "ui_standing_pull_to_check":
          MessageLookupByLibrary.simpleMessage("Pull down to check again."),
      "ui_standing_read_rules":
          MessageLookupByLibrary.simpleMessage("Read Kyron's rules"),
      "ui_standing_reply_removed":
          MessageLookupByLibrary.simpleMessage("Reply removed"),
      "ui_standing_reversed": MessageLookupByLibrary.simpleMessage("Reversed"),
      "ui_standing_reversed_on": MessageLookupByLibrary.simpleMessage(
          "Reversed on \$date. Anything it removed is back, and nothing it restricted still applies."),
      "ui_standing_rule": MessageLookupByLibrary.simpleMessage("Rule: \$rule"),
      "ui_standing_sign_out": MessageLookupByLibrary.simpleMessage("Sign out"),
      "ui_standing_suspended":
          MessageLookupByLibrary.simpleMessage("Suspended"),
      "ui_standing_suspended_detail": MessageLookupByLibrary.simpleMessage(
          "You can read, but not post, reply, follow or message. Reporting, blocking and muting still work."),
      "ui_standing_suspended_toast": MessageLookupByLibrary.simpleMessage(
          "Your account is suspended: you can read, but not post."),
      "ui_standing_suspended_until":
          MessageLookupByLibrary.simpleMessage("Suspended until \$date"),
      "ui_standing_suspended_until_toast": MessageLookupByLibrary.simpleMessage(
          "Your account is suspended until \$date: you can read, but not post."),
      "ui_standing_team_said":
          MessageLookupByLibrary.simpleMessage("What the team said"),
      "ui_standing_title":
          MessageLookupByLibrary.simpleMessage("Account status"),
      "ui_standing_warning": MessageLookupByLibrary.simpleMessage("Warning"),
      "ui_standing_why": MessageLookupByLibrary.simpleMessage("Why?"),
      "ui_standing_you_wrote":
          MessageLookupByLibrary.simpleMessage("You wrote, on \$date:"),
      "ui_standing_your_message":
          MessageLookupByLibrary.simpleMessage("Your message"),
      "ui_standing_your_post":
          MessageLookupByLibrary.simpleMessage("Your post"),
      "ui_standing_your_reply":
          MessageLookupByLibrary.simpleMessage("Your reply"),
      "ui_try_again": MessageLookupByLibrary.simpleMessage("Try again"),
      "ui_undo": MessageLookupByLibrary.simpleMessage("Undo"),
      "undoRepost": MessageLookupByLibrary.simpleMessage("Undo repost"),
      "updatePassword": MessageLookupByLibrary.simpleMessage("Update password"),
      "useDifferentAddress": MessageLookupByLibrary.simpleMessage(
        "Use a different address",
      ),
      "whatHappened": MessageLookupByLibrary.simpleMessage("What happened"),
      "whatHappenedAndLookAt": MessageLookupByLibrary.simpleMessage(
        "What happened, and what should we look at?",
      ),
      "whatInPicture": MessageLookupByLibrary.simpleMessage(
        "What is in this picture?",
      ),
      "whatIsItFor": MessageLookupByLibrary.simpleMessage(
        "What is it for? (optional)",
      ),
      "whatYouDid": MessageLookupByLibrary.simpleMessage(
        "What you did, what you expected, what happened",
      ),
      "whatYouWereDoing": MessageLookupByLibrary.simpleMessage(
        "What you were doing when it happened.",
      ),
      "normalised": MessageLookupByLibrary.simpleMessage(r"#\$normalised"),
      "postItSayItShowIt": MessageLookupByLibrary.simpleMessage(
        "Post it, say it, show it.",
      ),
      "textVoiceVideoPeopleRooms": MessageLookupByLibrary.simpleMessage(
        "Text, voice and video, the people who make them, and the rooms they talk in.",
      ),
      "alreadyOnKyron":
          MessageLookupByLibrary.simpleMessage("Already on Kyron?"),
      "byContinuingAgreeTermsPrivacy": MessageLookupByLibrary.simpleMessage(
        "By continuing you agree to our Terms and Privacy Policy",
      ),
      "googleSignInNeedsPhoneApp": MessageLookupByLibrary.simpleMessage(
        "Google sign-in needs the phone app",
      ),
      "googleSignInDesktopExplanation": (Object a0) =>
          "Google hands the finished sign-in back to Kyron over a link only Android and iOS answer, so on $a0 the browser would have nowhere to return it to.\\n\\nIf you already have a Kyron account through Google, use Continue with email with that same address and tap Forgot password — it will mail you a link to set one.",
      "loginFailed": MessageLookupByLibrary.simpleMessage(
        "Login failed. Please check your credentials.",
      ),
      "email": MessageLookupByLibrary.simpleMessage("Email"),
      "password": MessageLookupByLibrary.simpleMessage("Password"),
      "login": MessageLookupByLibrary.simpleMessage("Login"),
      "or": MessageLookupByLibrary.simpleMessage("or"),
      "username": MessageLookupByLibrary.simpleMessage("Username"),
      "usernameRule": MessageLookupByLibrary.simpleMessage(
        "Username must be lowercase (a-z, 0-9, _)",
      ),
      "passwordTooShort": MessageLookupByLibrary.simpleMessage(
        "Password too short",
      ),
      "continueAction": MessageLookupByLibrary.simpleMessage("Continue"),
      "bySigningUpAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "By signing up you agree to our",
      ),
      "terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "and": MessageLookupByLibrary.simpleMessage("and"),
      "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
      "googleSignIn":
          MessageLookupByLibrary.simpleMessage("Sign in with Google"),
      "googleSignUp":
          MessageLookupByLibrary.simpleMessage("Sign up with Google"),
      "googleContinue": MessageLookupByLibrary.simpleMessage(
        "Continue with Google",
      ),
      "byContinuingAgreeTerms": MessageLookupByLibrary.simpleMessage(
        "By continuing you agree to our",
      ),
      "literalwhetherKyronIsReachableRightNow":
          MessageLookupByLibrary.simpleMessage(
        "Whether Kyron is reachable right now",
      ),
      "literalwhatThisAppHasBeenDoing": MessageLookupByLibrary.simpleMessage(
        "What this app has been doing",
      ),
      "literalshareTheLogWithSupport": MessageLookupByLibrary.simpleMessage(
        "Share the log with support",
      ),
      "literalclearCache": MessageLookupByLibrary.simpleMessage("Clear cache"),
      "literalappVersion": MessageLookupByLibrary.simpleMessage("App version"),
      "literalreading": MessageLookupByLibrary.simpleMessage("Reading…"),
      "literalcheckAgain": MessageLookupByLibrary.simpleMessage("Check again"),
      "literalkyronDidNotAnswer": MessageLookupByLibrary.simpleMessage(
        "Kyron did not answer",
      ),
      "literalnothingLoggedYet": MessageLookupByLibrary.simpleMessage(
        "Nothing logged yet",
      ),
      "literalswitchCamera":
          MessageLookupByLibrary.simpleMessage("Switch camera"),
      "literaltheCameraIsClosed": MessageLookupByLibrary.simpleMessage(
        "The camera is closed",
      ),
      "literaltakeAPicture":
          MessageLookupByLibrary.simpleMessage("Take a picture"),
      "literallensNameFaceLens": (Object a0) => "$a0, face lens",
      "literalcouldNotPostThatReply": MessageLookupByLibrary.simpleMessage(
        "Could not post that reply.",
      ),
      "literalcouldNotLoadThisReply": MessageLookupByLibrary.simpleMessage(
        "Could not load this reply",
      ),
      "literalthisReplyIsGone": MessageLookupByLibrary.simpleMessage(
        "This reply is gone",
      ),
      "literaladdAPhoto": MessageLookupByLibrary.simpleMessage("Add a photo"),
      "literaladdAClip": MessageLookupByLibrary.simpleMessage("Add a clip"),
      "literalstartACommunity": MessageLookupByLibrary.simpleMessage(
        "Start a community",
      ),
      "literalcouldNotLoadYourCommunities":
          MessageLookupByLibrary.simpleMessage(
        "Could not load your communities",
      ),
      "literalyouAreNotInAnyCommunities": MessageLookupByLibrary.simpleMessage(
        "You are not in any communities",
      ),
      "literalcouldNotLoadCommunities": MessageLookupByLibrary.simpleMessage(
        "Could not load communities",
      ),
      "literalpostInWidgetCommunityName": (Object a0) => "Post in $a0",
      "literalsaySomethingToWidgetCommunityName": (Object a0) =>
          "Say something to $a0",
      "literaltagSomeone": MessageLookupByLibrary.simpleMessage("Tag someone"),
      "literalcloseWidgetCommunityName": (Object a0) => "Close $a0?",
      "literalonlyTheOwnerCanChangeThis": MessageLookupByLibrary.simpleMessage(
        "Only the owner can change this",
      ),
      "literaltapTheBannerOrThePictureToChangeIt":
          MessageLookupByLibrary.simpleMessage(
        "Tap the banner or the picture to change it",
      ),
      "literalremoveMemberDisplayname": (Object a0) => "Remove $a0?",
      "literalcouldNotLoadTheMembers": MessageLookupByLibrary.simpleMessage(
        "Could not load the members",
      ),
      "literalnobodyHereYet": MessageLookupByLibrary.simpleMessage(
        "Nobody here yet",
      ),
      "literalmakeAModerator": MessageLookupByLibrary.simpleMessage(
        "Make a moderator",
      ),
      "literalremoveAsModerator": MessageLookupByLibrary.simpleMessage(
        "Remove as moderator",
      ),
      "literalremoveFromCommunity": MessageLookupByLibrary.simpleMessage(
        "Remove from community",
      ),
      "literalcouldNotLoadThisList": MessageLookupByLibrary.simpleMessage(
        "Could not load this list",
      ),
      "literalnobodyHasBeenRemoved": MessageLookupByLibrary.simpleMessage(
        "Nobody has been removed",
      ),
      "literalpostInCommunityName": (Object a0) => "Post in $a0",
      "literalcouldNotOpenThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Could not open this community",
      ),
      "literalthisCommunity": MessageLookupByLibrary.simpleMessage(
        "This community",
      ),
      "literalshareThisCommunity": MessageLookupByLibrary.simpleMessage(
        "Share this community",
      ),
      "literalcopyLink": MessageLookupByLibrary.simpleMessage("Copy link"),
      "literallinkCopied": MessageLookupByLibrary.simpleMessage("Link copied"),
      "literalleaveCommunityName": (Object a0) => "Leave $a0?",
      "literalyouHaveLeftCommunityName": (Object a0) => "You have left $a0",
      "literaladdAVideo": MessageLookupByLibrary.simpleMessage("Add a video"),
      "literaladdAGif": MessageLookupByLibrary.simpleMessage("Add a GIF"),
      "literalrecordAVoicePost": MessageLookupByLibrary.simpleMessage(
        "Record a voice post",
      ),
      "literalremoveThePoll": MessageLookupByLibrary.simpleMessage(
        "Remove the poll",
      ),
      "literaladdAPoll": MessageLookupByLibrary.simpleMessage("Add a poll"),
      "literaladdAHashtag":
          MessageLookupByLibrary.simpleMessage("Add a hashtag"),
      "literaldraftSaved": MessageLookupByLibrary.simpleMessage("Draft saved"),
      "literalnoDrafts": MessageLookupByLibrary.simpleMessage("No drafts"),
      "literalnothingIsTrendingYet": MessageLookupByLibrary.simpleMessage(
        "Nothing is trending yet",
      ),
      "literalyouExampleCom": MessageLookupByLibrary.simpleMessage(
        "you@example.com",
      ),
      "literalsendTheLink":
          MessageLookupByLibrary.simpleMessage("Send the link"),
      "literalopenTheMailFromKyron": MessageLookupByLibrary.simpleMessage(
        "Open the mail from Kyron",
      ),
      "literaltapTheLinkInsideIt": MessageLookupByLibrary.simpleMessage(
        "Tap the link inside it",
      ),
      "literalsetAPasswordAndCarryOn": MessageLookupByLibrary.simpleMessage(
        "Set a password and carry on",
      ),
      "literalsendAgainInCooldownS": (Object a0) => "Send again in ${a0}s",
      "literalsendAgain": MessageLookupByLibrary.simpleMessage("Send again"),
      "literalnormalised": (Object a0) => "#$a0",
      "literalcouldNotLoadYourMessages": MessageLookupByLibrary.simpleMessage(
        "Could not load your messages",
      ),
      "literalnothingUnread": MessageLookupByLibrary.simpleMessage(
        "Nothing unread",
      ),
      "literalnoMessagesYet": MessageLookupByLibrary.simpleMessage(
        "No messages yet",
      ),
      "literalnothingMuted":
          MessageLookupByLibrary.simpleMessage("Nothing muted"),
      "literalnoLikesYet": MessageLookupByLibrary.simpleMessage("No likes yet"),
      "literalnoRepliesYet":
          MessageLookupByLibrary.simpleMessage("No replies yet"),
      "literalnoNewFollowers": MessageLookupByLibrary.simpleMessage(
        "No new followers",
      ),
      "literalnoRepostsYet":
          MessageLookupByLibrary.simpleMessage("No reposts yet"),
      "literalyouAreAllCaughtUp": MessageLookupByLibrary.simpleMessage(
        "You are all caught up",
      ),
      "literalcouldNotLoadNotifications": MessageLookupByLibrary.simpleMessage(
        "Could not load notifications",
      ),
      "literalcoverPhoto": MessageLookupByLibrary.simpleMessage("Cover photo"),
      "literalchooseFromGallery": MessageLookupByLibrary.simpleMessage(
        "Choose from gallery",
      ),
      "literaluseOneOfOurs": MessageLookupByLibrary.simpleMessage(
        "Use one of ours",
      ),
      "literaltapToAddAPhotoAndACover": MessageLookupByLibrary.simpleMessage(
        "Tap to add a photo and a cover",
      ),
      "literalnoInterestsYet": MessageLookupByLibrary.simpleMessage(
        "No interests yet",
      ),
      "literaldiscoverPeople": MessageLookupByLibrary.simpleMessage(
        "Discover people",
      ),
      "literalcancelReply":
          MessageLookupByLibrary.simpleMessage("Cancel reply"),
      "literalcouldNotLoadThisPost": MessageLookupByLibrary.simpleMessage(
        "Could not load this post",
      ),
      "literalshareThisProfile": MessageLookupByLibrary.simpleMessage(
        "Share this profile",
      ),
      "literalcouldNotLoadThesePosts": MessageLookupByLibrary.simpleMessage(
        "Could not load these posts",
      ),
      "literalyouHaveNotPostedYet": MessageLookupByLibrary.simpleMessage(
        "You have not posted yet",
      ),
      "literalnoPostsYet": MessageLookupByLibrary.simpleMessage("No posts yet"),
      "literalnothingToLookAtYet": MessageLookupByLibrary.simpleMessage(
        "Nothing to look at yet",
      ),
      "literalkeepTyping": MessageLookupByLibrary.simpleMessage("Keep typing"),
      "literalsearchFailed":
          MessageLookupByLibrary.simpleMessage("Search failed"),
      "literalnothingMatched": MessageLookupByLibrary.simpleMessage(
        "Nothing matched",
      ),
      "literalcouldNotSignOutDescribeapierrorE": (Object a0) =>
          "Could not sign out: $a0",
      "literalnoDidYet": MessageLookupByLibrary.simpleMessage("No DID yet"),
      "literalpasswordLogin": MessageLookupByLibrary.simpleMessage(
        "Password & Login",
      ),
      "literalmutedAndBlockedAccounts": MessageLookupByLibrary.simpleMessage(
        "Muted and blocked accounts",
      ),
      "literalfontSize": MessageLookupByLibrary.simpleMessage("Font Size"),
      "literalpushNotifications": MessageLookupByLibrary.simpleMessage(
        "Push Notifications",
      ),
      "literaldataSaver": MessageLookupByLibrary.simpleMessage("Data Saver"),
      "literalcontactSupport": MessageLookupByLibrary.simpleMessage(
        "Contact Support",
      ),
      "literalsendFeedback":
          MessageLookupByLibrary.simpleMessage("Send Feedback"),
      "literalappLanguage":
          MessageLookupByLibrary.simpleMessage("App language"),
      "literalprimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Primary language",
      ),
      "literalcontentLanguages": MessageLookupByLibrary.simpleMessage(
        "Content languages",
      ),
      "literalremoveLanguageEnglishname": (Object a0) => "Remove $a0",
      "literalsentItIsReportFiledNumber": (Object a0) =>
          "Sent. It is report #$a0.",
      "literalfeedbackCannotBeSentRightNow":
          MessageLookupByLibrary.simpleMessage(
        "Feedback cannot be sent right now",
      ),
      "literalwhatYouDidWhatYouExpectedWhatHappened":
          MessageLookupByLibrary.simpleMessage(
        "What you did, what you expected, what happened ",
      ),
      "literalverificationFailedDescribeapierrorE": (Object a0) =>
          "Verification failed: $a0",
      "literalverificationCodeResent": MessageLookupByLibrary.simpleMessage(
        "Verification code resent.",
      ),
      "literalverifyEmail":
          MessageLookupByLibrary.simpleMessage("Verify Email"),
      "literalresendCode": MessageLookupByLibrary.simpleMessage("Resend code"),
      "literalremoveThisConversation": MessageLookupByLibrary.simpleMessage(
        "Remove this conversation",
      ),
      "literalmutedYouWillNotBeNotified": MessageLookupByLibrary.simpleMessage(
        "Muted. You will not be notified.",
      ),
      "literalblockThisAccount": MessageLookupByLibrary.simpleMessage(
        "Block this account?",
      ),
      "literalyouAreSignedOut": MessageLookupByLibrary.simpleMessage(
        "You are signed out.",
      ),
      "literalcouldNotLoadThisConversation":
          MessageLookupByLibrary.simpleMessage(
        "Could not load this conversation",
      ),
      "literalsaySomething":
          MessageLookupByLibrary.simpleMessage("Say something"),
      "literalcopyText": MessageLookupByLibrary.simpleMessage("Copy text"),
      "literaldoNotReply": MessageLookupByLibrary.simpleMessage("Do not reply"),
      "literalremoveFromSaved": MessageLookupByLibrary.simpleMessage(
        "Remove from saved",
      ),
      "literalturnSoundOn":
          MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "literalturnSoundOff":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "literalthatLinkIsNotOneThisCanOpen":
          MessageLookupByLibrary.simpleMessage(
        "That link is not one this can open.",
      ),
      "literalnoBrowserOnThisDeviceTookThatLink":
          MessageLookupByLibrary.simpleMessage(
        "No browser on this device took that link.",
      ),
      "literalopenReply": MessageLookupByLibrary.simpleMessage("Open reply"),
      "literallabelCount": (Object a0, Object a1) => "$a0, $a1",
      "literalindex1": (Object a0) => "$a0",
      "literalfirstyearIndex": (Object a0) => "$a0",
      "literalgifsAreNotSetUp": MessageLookupByLibrary.simpleMessage(
        "GIFs are not set up",
      ),
      "literalcouldNotLoadGifs": MessageLookupByLibrary.simpleMessage(
        "Could not load GIFs",
      ),
      "literalnothingFound":
          MessageLookupByLibrary.simpleMessage("Nothing found"),
      "literalthatGifCouldNotBeDownloaded":
          MessageLookupByLibrary.simpleMessage(
        "That GIF could not be downloaded.",
      ),
      "literaladdAnInterest": MessageLookupByLibrary.simpleMessage(
        "Add an interest",
      ),
      "literalcouldNotLoadTrendingTags": MessageLookupByLibrary.simpleMessage(
        "Could not load trending tags",
      ),
      "literalnoTrendingTagMatchesThat": MessageLookupByLibrary.simpleMessage(
        "No trending tag matches that",
      ),
      "literalyouAlreadyFollowEveryTrendingTag":
          MessageLookupByLibrary.simpleMessage(
        "You already follow every trending tag",
      ),
      "literalremoveLabel": (Object a0) => "Remove $a0",
      "literaladdLabelAsATab": (Object a0) => "Add $a0 as a tab",
      "literalcouldNotSearch": MessageLookupByLibrary.simpleMessage(
        "Could not search",
      ),
      "literalwhoDoYouWantToTag": MessageLookupByLibrary.simpleMessage(
        "Who do you want to tag?",
      ),
      "literalnobodyFound":
          MessageLookupByLibrary.simpleMessage("Nobody found"),
      "literalshowPassword":
          MessageLookupByLibrary.simpleMessage("Show password"),
      "literalhidePassword":
          MessageLookupByLibrary.simpleMessage("Hide password"),
      "literaltranslatePost": MessageLookupByLibrary.simpleMessage(
        "Translate post",
      ),
      "literalcopyPostText":
          MessageLookupByLibrary.simpleMessage("Copy post text"),
      "literalcopyLinkToPost": MessageLookupByLibrary.simpleMessage(
        "Copy link to post",
      ),
      "literalshowMorePostsLikeThis": MessageLookupByLibrary.simpleMessage(
        "Show more posts like this",
      ),
      "literalnotInterestedInThis": MessageLookupByLibrary.simpleMessage(
        "Not interested in this",
      ),
      "literalhidesItAndTellsUsToShowFewerLikeIt":
          MessageLookupByLibrary.simpleMessage(
        "Hides it, and tells us to show fewer like it",
      ),
      "literalhideThisPost":
          MessageLookupByLibrary.simpleMessage("Hide this post"),
      "literalmuteThisThread": MessageLookupByLibrary.simpleMessage(
        "Mute this thread",
      ),
      "literalstopSeeingThisPostAndRepliesToIt":
          MessageLookupByLibrary.simpleMessage(
        "Stop seeing this post and replies to it",
      ),
      "literalmuteWordsOrTags": MessageLookupByLibrary.simpleMessage(
        "Mute words or tags",
      ),
      "literalviewersLikesSavesAndComments":
          MessageLookupByLibrary.simpleMessage(
        "Viewers, likes, saves and comments",
      ),
      "literalwhoCanReply":
          MessageLookupByLibrary.simpleMessage("Who can reply"),
      "literaldeletePost": MessageLookupByLibrary.simpleMessage("Delete post"),
      "literalmuteAuthor": (Object a0) => "Mute $a0",
      "literalblockAuthor": (Object a0) => "Block $a0",
      "literalreportPost": MessageLookupByLibrary.simpleMessage("Report post"),
      "literalreportAuthor": (Object a0) => "Report $a0",
      "literalthatDidNotGoThroughTryAgain":
          MessageLookupByLibrary.simpleMessage(
        "That did not go through. Try again.",
      ),
      "literalblockAuthor2": (Object a0) => "Block $a0?",
      "literalshowResults":
          MessageLookupByLibrary.simpleMessage("Show results"),
      "literallabelDate": MessageLookupByLibrary.simpleMessage(r"\$label date"),
      "literalshareVia": MessageLookupByLibrary.simpleMessage("Share via…"),
      "literalhandItToAnotherApp": MessageLookupByLibrary.simpleMessage(
        "Hand it to another app",
      ),
      "literalshareWithAQuote": MessageLookupByLibrary.simpleMessage(
        "Share with a quote",
      ),
      "literalpostItWithYourOwnWordsAboveIt":
          MessageLookupByLibrary.simpleMessage(
        "Post it with your own words above it",
      ),
      "literalsavedPosts": MessageLookupByLibrary.simpleMessage("Saved posts"),
      "literallikedPosts": MessageLookupByLibrary.simpleMessage("Liked posts"),
      "literalstoriesRibbonStoriesLengthItems": (Object a0) =>
          "Stories ribbon, $a0 items",
      "literalwhatYouPostIsYours": MessageLookupByLibrary.simpleMessage(
        "What you post is yours",
      ),
      "literalwhatKyronKeeps": MessageLookupByLibrary.simpleMessage(
        "What Kyron keeps",
      ),
      "literalhowToBehave":
          MessageLookupByLibrary.simpleMessage("How to behave"),
      "literalcloseTabLabel": (Object a0) => "Close $a0",
      "literal1PageOpen": MessageLookupByLibrary.simpleMessage("1 page open"),
      "literalcountPagesOpen": (Object a0) => "$a0 pages open",
      "literalstopLoading":
          MessageLookupByLibrary.simpleMessage("Stop loading"),
      "literalshareThisPage": MessageLookupByLibrary.simpleMessage(
        "Share this page",
      ),
      "literalnoAppOnThisDeviceOpensUriSchemeLinks": (Object a0) =>
          "No app on this device opens $a0 links.",
      "literalcloseTheBrowser": MessageLookupByLibrary.simpleMessage(
        "Close the browser",
      ),
      "literalcloseAllPages": MessageLookupByLibrary.simpleMessage(
        "Close all pages",
      ),
      "literalremoveThisPoll": MessageLookupByLibrary.simpleMessage(
        "Remove this poll",
      ),
      "literalremoveThisAnswer": MessageLookupByLibrary.simpleMessage(
        "Remove this answer",
      ),
      "literalstartRecording": MessageLookupByLibrary.simpleMessage(
        "Start recording",
      ),
      "literalrecordAgain":
          MessageLookupByLibrary.simpleMessage("Record again"),
      "home": MessageLookupByLibrary.simpleMessage("Home"),
      "explore": MessageLookupByLibrary.simpleMessage("Explore"),
      "communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "messages": MessageLookupByLibrary.simpleMessage("Messages"),
      "languages": MessageLookupByLibrary.simpleMessage("Languages"),
      "selectAppLanguage": MessageLookupByLibrary.simpleMessage(
        "Select which language to use for the app's user interface.",
      ),
      "selectPrimaryLanguage": MessageLookupByLibrary.simpleMessage(
        "Select your preferred language for translations in your feed.",
      ),
      "selectContentLanguages": MessageLookupByLibrary.simpleMessage(
        "Select which languages you want your subscribed feeds to include. If none are selected, all languages will be shown.",
      ),
      "kyronWordsStillBeingTranslated": MessageLookupByLibrary.simpleMessage(
        "Kyron's words are still being translated, so most screens stay in English for now.",
      ),
      "communitiesEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Find one on Discover, or start your own.",
      ),
      "messagesCaughtUp": MessageLookupByLibrary.simpleMessage(
        "Every conversation is caught up.",
      ),
      "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
        "Open somebody's profile and tap Message to start a conversation.",
      ),
      "notificationLikesDetail": MessageLookupByLibrary.simpleMessage(
        "When somebody likes one of your posts, it shows up here.",
      ),
      "notificationRepliesDetail": MessageLookupByLibrary.simpleMessage(
        "Replies to your posts land here.",
      ),
      "notificationFollowersDetail": MessageLookupByLibrary.simpleMessage(
        "People who follow you show up here.",
      ),
      "notificationRepostsDetail": MessageLookupByLibrary.simpleMessage(
        "When somebody reposts you, it shows up here.",
      ),
      "notificationEmptyDetail": MessageLookupByLibrary.simpleMessage(
        "Likes, replies and new followers land here as they arrive.",
      ),
      "gettingHelp": MessageLookupByLibrary.simpleMessage("Getting help"),
      "send": MessageLookupByLibrary.simpleMessage("Send"),
      "close": MessageLookupByLibrary.simpleMessage("Close"),
      "search": MessageLookupByLibrary.simpleMessage("Search"),
      "settings": MessageLookupByLibrary.simpleMessage("Settings"),
      "menu": MessageLookupByLibrary.simpleMessage("Menu"),
      "clear": MessageLookupByLibrary.simpleMessage("Clear"),
      "manage": MessageLookupByLibrary.simpleMessage("Manage"),
      "join": MessageLookupByLibrary.simpleMessage("Join"),
      "video": MessageLookupByLibrary.simpleMessage("Video"),
      "contentLanguagesNotFilteringYet": MessageLookupByLibrary.simpleMessage(
        "Posts do not carry a language yet, so this does not filter your feed today. Your choice is kept for when they do.",
      ),
      "addMoreLanguages": MessageLookupByLibrary.simpleMessage(
        "Add more languages…",
      ),
      "translationNotBuiltYet": MessageLookupByLibrary.simpleMessage(
        "Translation is not built yet. Nothing in your feed is translated today; this is remembered for when it is.",
      ),
      "supportEarlyExplanation": MessageLookupByLibrary.simpleMessage(
        "Kyron is early, and the fastest way to reach someone who can actually fix a problem is to open an issue. Include what you were doing and what happened instead.",
      ),
      "supportInboxNotYet": MessageLookupByLibrary.simpleMessage(
        "There is no in-app support inbox yet, so this screen points at the place that is actually monitored rather than at a form that goes nowhere.",
      ),
      "ui_communities_screen_what_is_it_for_optional_39b687":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001":
          MessageLookupByLibrary.simpleMessage(
        "You will need to sign in again to get back to your account.",
      ),
      "ui_settings_subscreens_new_email_address_dab96e":
          MessageLookupByLibrary.simpleMessage("New email address"),
      "ui_settings_subscreens_new_password_88c1bf":
          MessageLookupByLibrary.simpleMessage("New password"),
      "ui_settings_subscreens_confirm_password_41d040":
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      "ui_settings_subscreens_in_one_line_06bdaf":
          MessageLookupByLibrary.simpleMessage("In one line"),
      "ui_settings_subscreens_what_happened_977dd8":
          MessageLookupByLibrary.simpleMessage("What happened"),
      "ui_onboard_step3_screen_skip_7b13d8":
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
      "ui_onboard_step3_screen_finish_5c0ad8":
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      "audit_about_screen_12_mb_e39721d6": MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
      "audit_about_subscreens_round_trip_64776b4c":
          MessageLookupByLibrary.simpleMessage("Round trip"),
      "audit_about_subscreens_token_verification_7934e1f2":
          MessageLookupByLibrary.simpleMessage("TOKEN VERIFICATION"),
      "audit_about_subscreens_support_kyron_so_a3a84d0f":
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      "audit_ar_lens_screen_try_again_cdec8872":
          MessageLookupByLibrary.simpleMessage("Try again"),
      "audit_browser_engine_window_stop_39c04883":
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      "audit_browser_sheet_try_again_44bc94ba":
          MessageLookupByLibrary.simpleMessage("Try again"),
      "audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b":
          MessageLookupByLibrary.simpleMessage(
        "Starting a broadcast now would put you in a room nobody could",
      ),
      "audit_communities_screen_start_a_community_06c8ec4f":
          MessageLookupByLibrary.simpleMessage("Start a community"),
      "audit_communities_screen_what_is_it_for_optional_e7e82092":
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      "audit_community_manage_screen_closing_it_f490fb09":
          MessageLookupByLibrary.simpleMessage("Closing it"),
      "audit_community_manage_screen_back_in_e495a750":
          MessageLookupByLibrary.simpleMessage("back in."),
      "audit_community_manage_screen_back_in_from_this_list_9496a4fd":
          MessageLookupByLibrary.simpleMessage("back in from this list."),
      "audit_community_screen_join_first_7798cafc":
          MessageLookupByLibrary.simpleMessage("join first"),
      "audit_composer_screen_coming_soon_431fd23d":
          MessageLookupByLibrary.simpleMessage("coming soon"),
      "audit_composer_screen_posting_as_you_45d69932":
          MessageLookupByLibrary.simpleMessage("Posting as you"),
      "audit_drafts_screen_just_now_17a8d48a":
          MessageLookupByLibrary.simpleMessage(
        "Just now",
      ),
      "audit_explore_screen_topic_1_83830b41":
          MessageLookupByLibrary.simpleMessage(
        "Topic 1",
      ),
      "audit_forgot_password_screen_its_way_to_it_now_271a6cea":
          MessageLookupByLibrary.simpleMessage("its way to it now."),
      "audit_forgot_password_screen_has_anything_65044193":
          MessageLookupByLibrary.simpleMessage("has anything."),
      "audit_post_analytics_screen_viewers_per_day_5d881f10":
          MessageLookupByLibrary.simpleMessage("VIEWERS PER DAY"),
      "audit_post_detail_screen_sublist_1_join_b0a5d508":
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      "audit_report_screen_this_post_820d9740":
          MessageLookupByLibrary.simpleMessage("this post"),
      "audit_report_screen_anything_to_add_optional_f0051fa4":
          MessageLookupByLibrary.simpleMessage("Anything to add? (optional)"),
      "audit_settings_screen_log_out_0b39bfb2":
          MessageLookupByLibrary.simpleMessage("Log Out"),
      "audit_settings_screen_your_account_bcdf27af":
          MessageLookupByLibrary.simpleMessage("Your account"),
      "audit_settings_screen_did_plc_abc_825b4f49":
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      "audit_settings_subscreens_confirm_password_f0e1f449":
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      "audit_settings_subscreens_not_now_e1657fa9":
          MessageLookupByLibrary.simpleMessage("not now"),
      "audit_create_fab_post_in_this_community_0a42daf2":
          MessageLookupByLibrary.simpleMessage("post in this community"),
      "audit_url_preview_its_own_8b362f95":
          MessageLookupByLibrary.simpleMessage(
        "its own.",
      ),
      "audit_empty_state_try_again_80ef48cd":
          MessageLookupByLibrary.simpleMessage(
        "Try again",
      ),
      "audit_feed_canvas_for_you_aa3c510d":
          MessageLookupByLibrary.simpleMessage(
        "For You",
      ),
      "audit_google_button_not_bbd76526": MessageLookupByLibrary.simpleMessage(
        ", not",
      ),
      "audit_inline_video_am_i_moving_4618f78c":
          MessageLookupByLibrary.simpleMessage("am I moving"),
      "audit_inline_video_turn_sound_on_83671c54":
          MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "audit_inline_video_turn_sound_off_97714bbc":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "audit_interest_tabs_for_you_7ef9e823":
          MessageLookupByLibrary.simpleMessage(
        "For You",
      ),
      "audit_interest_tabs_your_tabs_c3ba148f":
          MessageLookupByLibrary.simpleMessage("Your tabs"),
      "audit_media_tray_alt_784030d4": MessageLookupByLibrary.simpleMessage(
        "+ ALT",
      ),
      "audit_mention_picker_sheet_try_again_fd5d5dd7":
          MessageLookupByLibrary.simpleMessage("Try again"),
      "audit_password_requirements_symbol_322aed1e":
          MessageLookupByLibrary.simpleMessage("Symbol (!@#…)"),
      "audit_post_list_view_could_not_load_4dd86c79":
          MessageLookupByLibrary.simpleMessage("could not load"),
      "audit_post_options_sheet_this_post_99bfa981":
          MessageLookupByLibrary.simpleMessage("this post"),
      "audit_post_text_a_b_780da9a1":
          MessageLookupByLibrary.simpleMessage("a#b"),
      "audit_search_filter_sheet_from_an_account_f6a22687":
          MessageLookupByLibrary.simpleMessage("From an account"),
      "audit_skeleton_loading_18e82bcc": MessageLookupByLibrary.simpleMessage(
        "Loading…",
      ),
      "audit_sliding_drawer_content_kyron_v1_0_0_d696e73a":
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      "audit_story_pill_posting_bb613f87": MessageLookupByLibrary.simpleMessage(
        "Posting…",
      ),
      "audit_story_viewer_your_story_b706ecb4":
          MessageLookupByLibrary.simpleMessage("Your Story"),
      "audit_story_viewer_copy_story_link_2bd1546c":
          MessageLookupByLibrary.simpleMessage("Copy story link"),
      "audit_story_viewer_3h_ago_174dc80d":
          MessageLookupByLibrary.simpleMessage(
        "3h ago",
      ),
      "audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef":
          MessageLookupByLibrary.simpleMessage(
        "Your account, your posts, and what you tap on so",
      ),
      "audit_topic_picker_add_a_topic_25baaf8a":
          MessageLookupByLibrary.simpleMessage("Add a topic"),
      "ui_communities": MessageLookupByLibrary.simpleMessage("Communities"),
      "ui_settings": MessageLookupByLibrary.simpleMessage("Settings"),
      "ui_appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
      "ui_language": MessageLookupByLibrary.simpleMessage("Language"),
      "ui_account": MessageLookupByLibrary.simpleMessage("Account"),
      "ui_content_display": MessageLookupByLibrary.simpleMessage(
        "Content & Display",
      ),
      "ui_app_device": MessageLookupByLibrary.simpleMessage("App & Device"),
      "ui_terms": MessageLookupByLibrary.simpleMessage("Terms"),
      "ui_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_help": MessageLookupByLibrary.simpleMessage("Help"),
      "ui_feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
      "ui_decentralized_id": MessageLookupByLibrary.simpleMessage(
        "Decentralized ID",
      ),
      "ui_find_people_on_kyron": MessageLookupByLibrary.simpleMessage(
        "Find people on Kyron",
      ),
      "ui_search_everything_posted": MessageLookupByLibrary.simpleMessage(
        "Search everything posted",
      ),
      "ui_search_by_handle_or_display_name":
          MessageLookupByLibrary.simpleMessage(
        "Search by handle or display name.",
      ),
      "ui_words_or_filter": MessageLookupByLibrary.simpleMessage(
        "Words, or a filter — an account, a date range, or what a post carries.",
      ),
      "ui_two_characters_or_more": MessageLookupByLibrary.simpleMessage(
        "Two characters or more.",
      ),
      "ui_no_posts_match_filters": MessageLookupByLibrary.simpleMessage(
        "No posts match those filters.",
      ),
      "ui_search_clear": MessageLookupByLibrary.simpleMessage("Clear"),
      "ui_search_filters": MessageLookupByLibrary.simpleMessage("Filters"),
      "ui_post_text_copied": MessageLookupByLibrary.simpleMessage(
        "Post text copied",
      ),
      "ui_link_copied": MessageLookupByLibrary.simpleMessage("Link copied"),
      "ui_interest_noted": MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      "ui_posts_hidden": MessageLookupByLibrary.simpleMessage(
        "Hidden. We will show you fewer like it.",
      ),
      "ui_post_hidden": MessageLookupByLibrary.simpleMessage("Post hidden"),
      "ui_thread_muted": MessageLookupByLibrary.simpleMessage("Thread muted"),
      "ui_post_deleted": MessageLookupByLibrary.simpleMessage("Post deleted"),
      "ui_post_delete_detail": MessageLookupByLibrary.simpleMessage(
        "It is removed from your profile and from everyone else's feed. Replies to it go with it.",
      ),
      "ui_block_detail": MessageLookupByLibrary.simpleMessage(
        "Neither of you will see the other on Kyron, and any follow between you is removed. They are not told.",
      ),
      "ui_mute_detail": MessageLookupByLibrary.simpleMessage(
        "You will stop seeing their posts. They are not told.",
      ),
      "ui_about_terms_of_service": MessageLookupByLibrary.simpleMessage(
        "Terms of Service",
      ),
      "ui_about_privacy_policy": MessageLookupByLibrary.simpleMessage(
        "Privacy Policy",
      ),
      "ui_settings_profile_contact": MessageLookupByLibrary.simpleMessage(
        "Your profile and contact information",
      ),
      "ui_settings_security": MessageLookupByLibrary.simpleMessage(
        "Security settings",
      ),
      "ui_settings_muted_blocked": MessageLookupByLibrary.simpleMessage(
        "Who you have muted or blocked",
      ),
      "ui_settings_content_display": MessageLookupByLibrary.simpleMessage(
        "Content & Display",
      ),
      "ui_settings_app_device": MessageLookupByLibrary.simpleMessage(
        "App & Device",
      ),
      "ui_settings_data_saver":
          MessageLookupByLibrary.simpleMessage("Data Saver"),
      "ui_settings_language_detail": MessageLookupByLibrary.simpleMessage(
        "Choose your language",
      ),
      "ui_settings_notifications_detail": MessageLookupByLibrary.simpleMessage(
        "Notification preferences",
      ),
      "ui_settings_help_articles": MessageLookupByLibrary.simpleMessage(
        "Browse help articles",
      ),
      "ui_settings_team_help": MessageLookupByLibrary.simpleMessage(
        "Get help from our team",
      ),
      "ui_settings_feedback_detail": MessageLookupByLibrary.simpleMessage(
        "Tell us what you think",
      ),
      "ui_could_not_load_profile": MessageLookupByLibrary.simpleMessage(
        "Could not load your profile",
      ),
      "ui_search_people": MessageLookupByLibrary.simpleMessage("Search people"),
      "ui_search_posts": MessageLookupByLibrary.simpleMessage("Search posts"),
      "ui_this_post": MessageLookupByLibrary.simpleMessage("this post"),
      "authorPostsHidden": (Object a0) => "You will not see posts from $a0",
      "authorBlocked": (Object a0) => "$a0 blocked",
      "nothingMatchesQuery": (Object a0) => "Nothing on Kyron matches \"$a0\"",
      "repliesPolicy": (Object a0) => "Replies: $a0",
      "ui_preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
      "ui_appearance_detail": MessageLookupByLibrary.simpleMessage(
        "Light, dark, or whatever the phone is set to",
      ),
      "ui_legal": MessageLookupByLibrary.simpleMessage("Legal"),
      "ui_diagnostics": MessageLookupByLibrary.simpleMessage("Diagnostics"),
      "ui_saved_posts": MessageLookupByLibrary.simpleMessage("Saved posts"),
      "ui_liked_posts": MessageLookupByLibrary.simpleMessage("Liked posts"),
      "ui_nothing_saved_yet": MessageLookupByLibrary.simpleMessage(
        "Nothing saved yet",
      ),
      "ui_no_likes_yet": MessageLookupByLibrary.simpleMessage("No likes yet"),
      "ui_saved_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Tap the archive icon on any post to keep it here. Only you can see what you save.",
      ),
      "ui_liked_posts_detail": MessageLookupByLibrary.simpleMessage(
        "Posts you like show up here, most recent first.",
      ),
      "ui_could_not_load_saved_posts": MessageLookupByLibrary.simpleMessage(
        "Could not load your saved posts",
      ),
      "ui_could_not_load_liked_posts": MessageLookupByLibrary.simpleMessage(
        "Could not load your liked posts",
      ),
      "feedTagDetail": (Object a0) => "Nothing has been posted under #$a0 yet.",
      "ui_feed_following_empty": MessageLookupByLibrary.simpleMessage(
        "Nothing from the people you follow",
      ),
      "ui_feed_videos_empty":
          MessageLookupByLibrary.simpleMessage("No videos yet"),
      "ui_feed_empty": MessageLookupByLibrary.simpleMessage("Nothing here yet"),
      "ui_feed_following_detail": MessageLookupByLibrary.simpleMessage(
        "Follow a few accounts and their posts will show up here.",
      ),
      "ui_feed_videos_detail": MessageLookupByLibrary.simpleMessage(
        "Posts carrying a clip will show up here.",
      ),
      "ui_feed_for_you_detail": MessageLookupByLibrary.simpleMessage(
        "Posts will show up here as people write them.",
      ),
      "ui_could_not_load_feed": MessageLookupByLibrary.simpleMessage(
        "Could not load your feed",
      ),
      "ui_share_this_post":
          MessageLookupByLibrary.simpleMessage("Share this post"),
      "analytics_distinct_people_not_opens":
          MessageLookupByLibrary.simpleMessage(
        "Distinct people, not opens",
      ),
      "analytics_engagement":
          MessageLookupByLibrary.simpleMessage("Engagement"),
      "analytics_posted": MessageLookupByLibrary.simpleMessage("Posted"),
      "analytics_viewers": MessageLookupByLibrary.simpleMessage("Viewers"),
      "analytics_likes": MessageLookupByLibrary.simpleMessage("Likes"),
      "analytics_comments": MessageLookupByLibrary.simpleMessage("Comments"),
      "analytics_saves": MessageLookupByLibrary.simpleMessage("Saves"),
      "analytics_no_viewers_yet": MessageLookupByLibrary.simpleMessage(
        "No viewers yet",
      ),
      "analytics_viewers_per_day": MessageLookupByLibrary.simpleMessage(
        "VIEWERS PER DAY",
      ),
      "analytics_nobody_opened_post": MessageLookupByLibrary.simpleMessage(
        "Nobody has opened this post yet.",
      ),
      "reply_who_can_reply":
          MessageLookupByLibrary.simpleMessage("Who can reply?"),
      "reply_anyone_can_see": MessageLookupByLibrary.simpleMessage(
        "Anyone can still see, repost and quote this post.",
      ),
      "reply_anyone":
          MessageLookupByLibrary.simpleMessage("Anyone can interact"),
      "reply_anyone_detail": MessageLookupByLibrary.simpleMessage(
        "Anyone on Kyron can reply to this post.",
      ),
      "reply_followers": MessageLookupByLibrary.simpleMessage(
        "People who follow you",
      ),
      "reply_followers_detail": MessageLookupByLibrary.simpleMessage(
        "Only people who follow you can reply to this post.",
      ),
      "reply_mentioned":
          MessageLookupByLibrary.simpleMessage("People you mention"),
      "reply_mentioned_detail": MessageLookupByLibrary.simpleMessage(
        "Only the people you @mention in this post can reply.",
      ),
      "reply_nobody": MessageLookupByLibrary.simpleMessage("Nobody can reply"),
      "reply_nobody_detail": MessageLookupByLibrary.simpleMessage(
        "Replies are turned off. You can still reply.",
      ),
      "interest_for_you": MessageLookupByLibrary.simpleMessage("For You"),
      "interest_following": MessageLookupByLibrary.simpleMessage("Following"),
      "interest_videos": MessageLookupByLibrary.simpleMessage("Videos"),
      "interest_your_tabs": MessageLookupByLibrary.simpleMessage("Your tabs"),
      "interest_drag_to_reorder": MessageLookupByLibrary.simpleMessage(
        "Drag to reorder",
      ),
      "interest_add": MessageLookupByLibrary.simpleMessage("Add an interest"),
      "interest_trending_now":
          MessageLookupByLibrary.simpleMessage("Trending now"),
      "interest_five_tabs_limit": MessageLookupByLibrary.simpleMessage(
        "Five tabs is the most the strip holds. Remove one to add another.",
      ),
      "interest_hashtags_detail": MessageLookupByLibrary.simpleMessage(
        "Hashtags turn up here as people start using them.",
      ),
      "composer_placeholder_rattling": MessageLookupByLibrary.simpleMessage(
        "What's rattling around your head?",
      ),
      "composer_placeholder_say": MessageLookupByLibrary.simpleMessage(
        "Say something only you can say…",
      ),
      "composer_placeholder_hot_take": MessageLookupByLibrary.simpleMessage(
        "Drop a hot take (or a warm one)",
      ),
      "composer_placeholder_signal": MessageLookupByLibrary.simpleMessage(
        "This is your signal — send it",
      ),
      "composer_placeholder_think": MessageLookupByLibrary.simpleMessage(
        "Type, speak, or think-out-loud",
      ),
      "profile_tap_to_change": MessageLookupByLibrary.simpleMessage(
        "Tap to change",
      ),
      "profile_display_name":
          MessageLookupByLibrary.simpleMessage("Display name"),
      "profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
      "profile_location": MessageLookupByLibrary.simpleMessage("Location"),
      "profile_website": MessageLookupByLibrary.simpleMessage("Website"),
      "translation_description": MessageLookupByLibrary.simpleMessage(
        "Kyron's own words are still being translated, so most screens stay in English for now. What this changes today: the parts of the interface Flutter draws itself, dates and numbers, and the direction the app lays out in for right-to-left languages.",
      ),
      "theme_system_detail": MessageLookupByLibrary.simpleMessage(
        "Follow the phone’s own light or dark setting",
      ),
      "theme_light_detail":
          MessageLookupByLibrary.simpleMessage("Always light"),
      "theme_dark_detail": MessageLookupByLibrary.simpleMessage("Always dark"),
      "theme_dim_detail": MessageLookupByLibrary.simpleMessage(
        "A softer dark, blue-grey rather than black",
      ),
      "theme_system": MessageLookupByLibrary.simpleMessage("System"),
      "theme_light": MessageLookupByLibrary.simpleMessage("Light"),
      "theme_dark": MessageLookupByLibrary.simpleMessage("Dark"),
      "theme_dim": MessageLookupByLibrary.simpleMessage("Dim"),
      "ui_like": MessageLookupByLibrary.simpleMessage("Like"),
      "ui_share": MessageLookupByLibrary.simpleMessage("Share"),
      "ui_joined": MessageLookupByLibrary.simpleMessage("Joined"),
      "ui_join": MessageLookupByLibrary.simpleMessage("Join"),
      "ui_turn_sound_on": MessageLookupByLibrary.simpleMessage("Turn sound on"),
      "ui_turn_sound_off":
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      "ui_pause": MessageLookupByLibrary.simpleMessage("Pause"),
      "ui_play": MessageLookupByLibrary.simpleMessage("Play"),
      "ui_from_account":
          MessageLookupByLibrary.simpleMessage("From an account"),
      "ui_posted_between":
          MessageLookupByLibrary.simpleMessage("Posted between"),
      "ui_after": MessageLookupByLibrary.simpleMessage("After"),
      "ui_before": MessageLookupByLibrary.simpleMessage("Before"),
      "ui_carrying": MessageLookupByLibrary.simpleMessage("Carrying"),
      'ui_communities_screen_what_is_it_for_optional_39b687':
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      'ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001':
          MessageLookupByLibrary.simpleMessage(
        "You will need to sign in again to get back to your account.",
      ),
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
          MessageLookupByLibrary.simpleMessage(
        "Skip",
      ),
      'ui_onboard_step3_screen_finish_5c0ad8':
          MessageLookupByLibrary.simpleMessage(
        "Finish",
      ),
      'audit_about_screen_12_mb_e39721d6': MessageLookupByLibrary.simpleMessage(
        "12 MB",
      ),
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
        "Starting a broadcast now would put you in a room nobody could",
      ),
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
          MessageLookupByLibrary.simpleMessage(
        "Just now",
      ),
      'audit_explore_screen_topic_1_83830b41':
          MessageLookupByLibrary.simpleMessage(
        "Topic 1",
      ),
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
          MessageLookupByLibrary.simpleMessage(
        "its own.",
      ),
      'audit_empty_state_try_again_80ef48cd':
          MessageLookupByLibrary.simpleMessage(
        "Try again",
      ),
      'audit_feed_canvas_for_you_aa3c510d':
          MessageLookupByLibrary.simpleMessage(
        "For You",
      ),
      'audit_google_button_not_bbd76526': MessageLookupByLibrary.simpleMessage(
        ", not",
      ),
      'audit_inline_video_am_i_moving_4618f78c':
          MessageLookupByLibrary.simpleMessage("am I moving"),
      'audit_inline_video_turn_sound_on_83671c54':
          MessageLookupByLibrary.simpleMessage("Turn sound on"),
      'audit_inline_video_turn_sound_off_97714bbc':
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      'audit_interest_tabs_for_you_7ef9e823':
          MessageLookupByLibrary.simpleMessage(
        "For You",
      ),
      'audit_interest_tabs_your_tabs_c3ba148f':
          MessageLookupByLibrary.simpleMessage("Your tabs"),
      'audit_media_tray_alt_784030d4': MessageLookupByLibrary.simpleMessage(
        "+ ALT",
      ),
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
      'audit_skeleton_loading_18e82bcc': MessageLookupByLibrary.simpleMessage(
        "Loading…",
      ),
      'audit_sliding_drawer_content_kyron_v1_0_0_d696e73a':
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      'audit_story_pill_posting_bb613f87': MessageLookupByLibrary.simpleMessage(
        "Posting…",
      ),
      'audit_story_viewer_your_story_b706ecb4':
          MessageLookupByLibrary.simpleMessage("Your Story"),
      'audit_story_viewer_copy_story_link_2bd1546c':
          MessageLookupByLibrary.simpleMessage("Copy story link"),
      'audit_story_viewer_3h_ago_174dc80d':
          MessageLookupByLibrary.simpleMessage(
        "3h ago",
      ),
      'audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef':
          MessageLookupByLibrary.simpleMessage(
        "Your account, your posts, and what you tap on so",
      ),
      'audit_topic_picker_add_a_topic_25baaf8a':
          MessageLookupByLibrary.simpleMessage("Add a topic"),
      'ui_communities': MessageLookupByLibrary.simpleMessage("Communities"),
      'ui_settings': MessageLookupByLibrary.simpleMessage("Settings"),
      'ui_appearance': MessageLookupByLibrary.simpleMessage("Appearance"),
      'ui_language': MessageLookupByLibrary.simpleMessage("Language"),
      'ui_account': MessageLookupByLibrary.simpleMessage("Account"),
      'ui_content_display': MessageLookupByLibrary.simpleMessage(
        "Content & Display",
      ),
      'ui_app_device': MessageLookupByLibrary.simpleMessage("App & Device"),
      'ui_terms': MessageLookupByLibrary.simpleMessage("Terms"),
      'ui_privacy': MessageLookupByLibrary.simpleMessage("Privacy"),
      'ui_help': MessageLookupByLibrary.simpleMessage("Help"),
      'ui_feedback': MessageLookupByLibrary.simpleMessage("Feedback"),
      'ui_decentralized_id': MessageLookupByLibrary.simpleMessage(
        "Decentralized ID",
      ),
      'ui_find_people_on_kyron': MessageLookupByLibrary.simpleMessage(
        "Find people on Kyron",
      ),
      'ui_search_everything_posted': MessageLookupByLibrary.simpleMessage(
        "Search everything posted",
      ),
      'ui_search_by_handle_or_display_name':
          MessageLookupByLibrary.simpleMessage(
        "Search by handle or display name.",
      ),
      'ui_words_or_filter': MessageLookupByLibrary.simpleMessage(
        "Words, or a filter — an account, a date range, or what a post carries.",
      ),
      'ui_two_characters_or_more': MessageLookupByLibrary.simpleMessage(
        "Two characters or more.",
      ),
      'ui_no_posts_match_filters': MessageLookupByLibrary.simpleMessage(
        "No posts match those filters.",
      ),
      'ui_search_clear': MessageLookupByLibrary.simpleMessage("Clear"),
      'ui_search_filters': MessageLookupByLibrary.simpleMessage("Filters"),
      'ui_post_text_copied': MessageLookupByLibrary.simpleMessage(
        "Post text copied",
      ),
      'ui_link_copied': MessageLookupByLibrary.simpleMessage("Link copied"),
      'ui_interest_noted': MessageLookupByLibrary.simpleMessage(
        "Noted. This helps shape what you are shown.",
      ),
      'ui_posts_hidden': MessageLookupByLibrary.simpleMessage(
        "Hidden. We will show you fewer like it.",
      ),
      'ui_post_hidden': MessageLookupByLibrary.simpleMessage("Post hidden"),
      'ui_thread_muted': MessageLookupByLibrary.simpleMessage("Thread muted"),
      'ui_post_deleted': MessageLookupByLibrary.simpleMessage("Post deleted"),
      'ui_post_delete_detail': MessageLookupByLibrary.simpleMessage(
        "It is removed from your profile and from everyone else's feed. Replies to it go with it.",
      ),
      'ui_block_detail': MessageLookupByLibrary.simpleMessage(
        "Neither of you will see the other on Kyron, and any follow between you is removed. They are not told.",
      ),
      'ui_mute_detail': MessageLookupByLibrary.simpleMessage(
        "You will stop seeing their posts. They are not told.",
      ),
      'ui_about_terms_of_service': MessageLookupByLibrary.simpleMessage(
        "Terms of Service",
      ),
      'ui_about_privacy_policy': MessageLookupByLibrary.simpleMessage(
        "Privacy Policy",
      ),
      'ui_settings_profile_contact': MessageLookupByLibrary.simpleMessage(
        "Your profile and contact information",
      ),
      'ui_settings_security': MessageLookupByLibrary.simpleMessage(
        "Security settings",
      ),
      'ui_settings_muted_blocked': MessageLookupByLibrary.simpleMessage(
        "Who you have muted or blocked",
      ),
      'ui_settings_content_display': MessageLookupByLibrary.simpleMessage(
        "Content & Display",
      ),
      'ui_settings_app_device': MessageLookupByLibrary.simpleMessage(
        "App & Device",
      ),
      'ui_settings_data_saver':
          MessageLookupByLibrary.simpleMessage("Data Saver"),
      'ui_settings_language_detail': MessageLookupByLibrary.simpleMessage(
        "Choose your language",
      ),
      'ui_settings_notifications_detail': MessageLookupByLibrary.simpleMessage(
        "Notification preferences",
      ),
      'ui_settings_help_articles': MessageLookupByLibrary.simpleMessage(
        "Browse help articles",
      ),
      'ui_settings_team_help': MessageLookupByLibrary.simpleMessage(
        "Get help from our team",
      ),
      'ui_settings_feedback_detail': MessageLookupByLibrary.simpleMessage(
        "Tell us what you think",
      ),
      'ui_could_not_load_profile': MessageLookupByLibrary.simpleMessage(
        "Could not load your profile",
      ),
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
        "Light, dark, or whatever the phone is set to",
      ),
      'ui_legal': MessageLookupByLibrary.simpleMessage("Legal"),
      'ui_diagnostics': MessageLookupByLibrary.simpleMessage("Diagnostics"),
      'ui_saved_posts': MessageLookupByLibrary.simpleMessage("Saved posts"),
      'ui_liked_posts': MessageLookupByLibrary.simpleMessage("Liked posts"),
      'ui_nothing_saved_yet': MessageLookupByLibrary.simpleMessage(
        "Nothing saved yet",
      ),
      'ui_no_likes_yet': MessageLookupByLibrary.simpleMessage("No likes yet"),
      'ui_saved_posts_detail': MessageLookupByLibrary.simpleMessage(
        "Tap the archive icon on any post to keep it here. Only you can see what you save.",
      ),
      'ui_liked_posts_detail': MessageLookupByLibrary.simpleMessage(
        "Posts you like show up here, most recent first.",
      ),
      'ui_could_not_load_saved_posts': MessageLookupByLibrary.simpleMessage(
        "Could not load your saved posts",
      ),
      'ui_could_not_load_liked_posts': MessageLookupByLibrary.simpleMessage(
        "Could not load your liked posts",
      ),
      'feedTagDetail': (Object tab) =>
          'Nothing has been posted under #$tab yet.',
      'ui_feed_following_empty': MessageLookupByLibrary.simpleMessage(
        "Nothing from the people you follow",
      ),
      'ui_feed_videos_empty':
          MessageLookupByLibrary.simpleMessage("No videos yet"),
      'ui_feed_empty': MessageLookupByLibrary.simpleMessage("Nothing here yet"),
      'ui_feed_following_detail': MessageLookupByLibrary.simpleMessage(
        "Follow a few accounts and their posts will show up here.",
      ),
      'ui_feed_videos_detail': MessageLookupByLibrary.simpleMessage(
        "Posts carrying a clip will show up here.",
      ),
      'ui_feed_for_you_detail': MessageLookupByLibrary.simpleMessage(
        "Posts will show up here as people write them.",
      ),
      'ui_could_not_load_feed': MessageLookupByLibrary.simpleMessage(
        "Could not load your feed",
      ),
      'ui_share_this_post':
          MessageLookupByLibrary.simpleMessage("Share this post"),
      'ui_like': MessageLookupByLibrary.simpleMessage("Like"),
      'ui_share': MessageLookupByLibrary.simpleMessage("Share"),
      'ui_joined': MessageLookupByLibrary.simpleMessage("Joined"),
      'ui_join': MessageLookupByLibrary.simpleMessage("Join"),
      'ui_turn_sound_on': MessageLookupByLibrary.simpleMessage("Turn sound on"),
      'ui_turn_sound_off':
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      'ui_pause': MessageLookupByLibrary.simpleMessage("Pause"),
      'ui_play': MessageLookupByLibrary.simpleMessage("Play"),
      'ui_from_account':
          MessageLookupByLibrary.simpleMessage("From an account"),
      'ui_posted_between':
          MessageLookupByLibrary.simpleMessage("Posted between"),
      'ui_after': MessageLookupByLibrary.simpleMessage("After"),
      'ui_before': MessageLookupByLibrary.simpleMessage("Before"),
      'ui_carrying': MessageLookupByLibrary.simpleMessage("Carrying"),
      "ui_dm_you_replied": MessageLookupByLibrary.simpleMessage("You replied"),
      "dmReplied": (Object a0) => "$a0 replied",
      "ui_dm_attach": MessageLookupByLibrary.simpleMessage("Add to message"),
      "ui_dm_new": MessageLookupByLibrary.simpleMessage("New message"),
      "ui_dm_starter": MessageLookupByLibrary.simpleMessage(
          "Nothing said yet. A wave is a good start."),
      "ui_dm_wave": MessageLookupByLibrary.simpleMessage("👋  Wave"),
      "ui_dm_new_messages":
          MessageLookupByLibrary.simpleMessage("New messages"),
      "dmTyping": (Object a0) => "$a0 is typing",
      "ui_dm_reaction_remove":
          MessageLookupByLibrary.simpleMessage("Remove your reaction"),
      "ui_dm_someone": MessageLookupByLibrary.simpleMessage("Someone"),
      "ui_dm_quote_message": MessageLookupByLibrary.simpleMessage("Message"),
      "ui_dm_quote_attachment":
          MessageLookupByLibrary.simpleMessage("Attachment"),
      "ui_dm_unreadable": MessageLookupByLibrary.simpleMessage(
          "This message cannot be read on this device."),
      "ui_dm_waiting": MessageLookupByLibrary.simpleMessage(
          "Waiting for this message. This may take a while."),
      "ui_dm_preview_sealed":
          MessageLookupByLibrary.simpleMessage("Encrypted message"),
      "ui_dm_e2ee_notice": MessageLookupByLibrary.simpleMessage(
          "Messages are end-to-end encrypted"),
      "ui_dm_not_encrypted":
          MessageLookupByLibrary.simpleMessage("Not end-to-end encrypted"),
      "ui_dm_sent": MessageLookupByLibrary.simpleMessage("Sent"),
      "ui_dm_seen": MessageLookupByLibrary.simpleMessage("Seen"),
      "ui_dm_sending": MessageLookupByLibrary.simpleMessage("Sending…"),
      "ui_dm_take_photo": MessageLookupByLibrary.simpleMessage("Take a photo"),
      "ui_media_more": MessageLookupByLibrary.simpleMessage("More options"),
      "ui_media_save": MessageLookupByLibrary.simpleMessage("Save to device"),
      "ui_media_share": MessageLookupByLibrary.simpleMessage("Share"),
      "ui_media_saving": MessageLookupByLibrary.simpleMessage("Saving…"),
      "ui_media_saved":
          MessageLookupByLibrary.simpleMessage("Saved to your photos"),
      "ui_media_save_failed":
          MessageLookupByLibrary.simpleMessage("Could not save it. Try again."),
      "ui_media_save_denied": MessageLookupByLibrary.simpleMessage(
          "Allow Kyron to add to your photos to save this."),
      "ui_status_all_ok":
          MessageLookupByLibrary.simpleMessage("All systems operational"),
      "ui_status_uptime": MessageLookupByLibrary.simpleMessage("Uptime"),
      "ui_status_last_60": MessageLookupByLibrary.simpleMessage("Last 60 days"),
      "ui_status_60_days_ago":
          MessageLookupByLibrary.simpleMessage("60 days ago"),
      "ui_status_today": MessageLookupByLibrary.simpleMessage("Today"),
      "ui_status_api": MessageLookupByLibrary.simpleMessage("API"),
      "ui_status_database": MessageLookupByLibrary.simpleMessage("Database"),
      "ui_status_auth": MessageLookupByLibrary.simpleMessage("Sign-in"),
      "ui_status_incidents":
          MessageLookupByLibrary.simpleMessage("Recent incidents"),
      "ui_status_no_incidents": MessageLookupByLibrary.simpleMessage(
          "No incidents in the last 60 days."),
      "ui_status_ongoing": MessageLookupByLibrary.simpleMessage("Ongoing"),
      "ui_status_no_data": MessageLookupByLibrary.simpleMessage("No data"),
      "ui_status_details": MessageLookupByLibrary.simpleMessage("Details"),
      "ui_status_footnote": MessageLookupByLibrary.simpleMessage(
          "Kyron checks itself every 5 minutes while it is running. A grey day had no checks."),
      "ui_status_unavailable": MessageLookupByLibrary.simpleMessage(
          "Uptime history is not available yet."),
      "ui_status_degraded": MessageLookupByLibrary.simpleMessage(
          "Some systems are having problems"),
      "ui_dm_voice":
          MessageLookupByLibrary.simpleMessage("Record a voice note"),
      "voice_ready_send": MessageLookupByLibrary.simpleMessage("Ready to send"),
      "ui_dm_quote_gone": MessageLookupByLibrary.simpleMessage(
          "That message is no longer here."),
      "ui_dm_quote_open":
          MessageLookupByLibrary.simpleMessage("Go to the message"),
      "ui_dm_quote_voice": MessageLookupByLibrary.simpleMessage("Voice note"),
      "ui_liked_by_author":
          MessageLookupByLibrary.simpleMessage("Liked by the author"),
      "ui_add_photo_or_clip":
          MessageLookupByLibrary.simpleMessage("Add a photo or clip"),
      "ui_dm_info_media": MessageLookupByLibrary.simpleMessage("Media"),
      "ui_dm_info_voice_notes":
          MessageLookupByLibrary.simpleMessage("Voice notes"),
      "ui_dm_info_chat": MessageLookupByLibrary.simpleMessage("Chat"),
      "ui_dm_info_wallpaper": MessageLookupByLibrary.simpleMessage("Wallpaper"),
      "ui_dm_info_mute_row":
          MessageLookupByLibrary.simpleMessage("Mute notifications"),
      "ui_dm_info_mute_detail": MessageLookupByLibrary.simpleMessage(
          "Stop being notified about this conversation"),
      "ui_dm_info_block_detail": MessageLookupByLibrary.simpleMessage(
          "They can no longer message you"),
      "ui_dm_wallpaper_none": MessageLookupByLibrary.simpleMessage("None"),
      "ui_dm_wallpaper_photo": MessageLookupByLibrary.simpleMessage("Photo"),
      "ui_dm_unmuted": MessageLookupByLibrary.simpleMessage("Unmuted."),
      "ui_dm_remove_failed": MessageLookupByLibrary.simpleMessage(
          "Could not remove it. Try again."),
      "ui_dm_info_profile": MessageLookupByLibrary.simpleMessage("Profile"),
      "ui_dm_unmute": MessageLookupByLibrary.simpleMessage("Unmute"),
      "ui_dm_info_no_media": MessageLookupByLibrary.simpleMessage(
          "Photos and clips you share show up here."),
      "ui_dm_info_see_all": MessageLookupByLibrary.simpleMessage("See all"),
      "ui_dm_media_tab":
          MessageLookupByLibrary.simpleMessage("Photos and clips"),
      "ui_dm_wallpaper_sample_theirs": MessageLookupByLibrary.simpleMessage(
          "This is how your chat will look."),
      "ui_dm_wallpaper_sample_mine":
          MessageLookupByLibrary.simpleMessage("Looks good."),
      "ui_wallpaper_mist": MessageLookupByLibrary.simpleMessage("Mist"),
      "ui_wallpaper_dusk": MessageLookupByLibrary.simpleMessage("Dusk"),
      "ui_wallpaper_sage": MessageLookupByLibrary.simpleMessage("Sage"),
      "ui_wallpaper_sand": MessageLookupByLibrary.simpleMessage("Sand"),
      "ui_wallpaper_dots": MessageLookupByLibrary.simpleMessage("Dots"),
      "ui_dm_wallpaper_apply": MessageLookupByLibrary.simpleMessage("Apply"),
      "ui_dm_wallpaper_current":
          MessageLookupByLibrary.simpleMessage("Current"),
      "ui_dm_link_card_remove":
          MessageLookupByLibrary.simpleMessage("Send without the preview"),
      "ui_share_search": MessageLookupByLibrary.simpleMessage("Search"),
      "ui_share_post": MessageLookupByLibrary.simpleMessage("Post"),
      "ui_share_note": MessageLookupByLibrary.simpleMessage("Write a message…"),
      "ui_share_send": MessageLookupByLibrary.simpleMessage("Send"),
      "ui_share_sent": MessageLookupByLibrary.simpleMessage("Sent"),
      "ui_share_some_failed":
          MessageLookupByLibrary.simpleMessage("Sent, but not to everybody."),
      "ui_share_failed": MessageLookupByLibrary.simpleMessage(
          "That could not be sent. Try again."),
      "ui_follower_one": MessageLookupByLibrary.simpleMessage("Follower"),
      "ui_dm_filter": MessageLookupByLibrary.simpleMessage("Filter"),
      "ui_dm_filter_all": MessageLookupByLibrary.simpleMessage("All"),
      "ui_dm_filter_unread": MessageLookupByLibrary.simpleMessage("Unread"),
      "ui_dm_filter_unanswered":
          MessageLookupByLibrary.simpleMessage("Unanswered"),
      "ui_dm_hidden": MessageLookupByLibrary.simpleMessage("Hidden"),
      "ui_dm_hidden_none":
          MessageLookupByLibrary.simpleMessage("Nothing hidden"),
      "ui_dm_hidden_none_detail": MessageLookupByLibrary.simpleMessage(
          "Conversations you remove from your list wait here, in case you want them back."),
      "ui_dm_hide_detail": MessageLookupByLibrary.simpleMessage(
          "It moves to Hidden. The other person keeps theirs, and it comes back if either of you writes again."),
      "ui_dm_restore": MessageLookupByLibrary.simpleMessage("Put back"),
      "ui_dm_restored":
          MessageLookupByLibrary.simpleMessage("Back in your list."),
      "ui_dm_search_none":
          MessageLookupByLibrary.simpleMessage("No conversations match."),
      "ui_dm_unanswered_none":
          MessageLookupByLibrary.simpleMessage("Nothing waiting on you"),
      "ui_dm_unanswered_none_detail": MessageLookupByLibrary.simpleMessage(
          "Every conversation ends on your word."),
      "ui_dm_preview_photo": MessageLookupByLibrary.simpleMessage("Photo"),
      "ui_dm_preview_photos": MessageLookupByLibrary.simpleMessage("Photos"),
      "ui_dm_preview_video": MessageLookupByLibrary.simpleMessage("Video"),
      "ui_dm_preview_gif": MessageLookupByLibrary.simpleMessage("GIF"),
      "ui_dm_preview_none":
          MessageLookupByLibrary.simpleMessage("No messages yet"),
      "ui_dm_you_prefix": MessageLookupByLibrary.simpleMessage("You:"),
      "ui_dm_yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
      "ui_dm_settings": MessageLookupByLibrary.simpleMessage("Messages"),
      "ui_dm_settings_open":
          MessageLookupByLibrary.simpleMessage("Message settings"),
      "ui_dm_settings_privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
      "ui_dm_read_receipts":
          MessageLookupByLibrary.simpleMessage("Read receipts"),
      "ui_dm_read_receipts_detail": MessageLookupByLibrary.simpleMessage(
          "When this is off, people won't see when you've read their messages, and you won't see when they've read yours."),
      "ui_dm_typing_setting":
          MessageLookupByLibrary.simpleMessage("Show when you're typing"),
      "ui_dm_typing_setting_detail": MessageLookupByLibrary.simpleMessage(
          "The person you are writing to sees that you are writing."),
      "ui_dm_link_previews":
          MessageLookupByLibrary.simpleMessage("Link previews"),
      "ui_dm_link_previews_detail": MessageLookupByLibrary.simpleMessage(
          "Your phone opens a link you send to make its preview, so the site sees your phone ask. Kyron's server never sees the link."),
      "ui_dm_settings_notifications":
          MessageLookupByLibrary.simpleMessage("Notifications for messages"),
      "ui_dm_settings_e2ee": MessageLookupByLibrary.simpleMessage(
          "Messages are end-to-end encrypted. Kyron cannot read them, and nothing here changes that."),
      "ui_dm_new_to": MessageLookupByLibrary.simpleMessage("To:"),
      "ui_dm_new_recent": MessageLookupByLibrary.simpleMessage("Recent"),
      "ui_dm_new_people": MessageLookupByLibrary.simpleMessage("People"),
      "ui_dm_new_nobody":
          MessageLookupByLibrary.simpleMessage("Nobody by that name."),
      "ui_push_test":
          MessageLookupByLibrary.simpleMessage("Send a test notification"),
      "ui_push_test_off": MessageLookupByLibrary.simpleMessage(
          "Kyron's server is not set up to send notifications yet, so none can arrive. This is on our side, not your phone."),
      "ui_push_test_no_device": MessageLookupByLibrary.simpleMessage(
          "This phone is not registered for notifications. Check that notifications are allowed for Kyron in your phone's settings, then try again."),
      "ui_push_test_rejected": MessageLookupByLibrary.simpleMessage(
          "The notification could not be delivered to this phone. Try again in a minute."),
      "ui_push_test_sent": MessageLookupByLibrary.simpleMessage(
          "Sent. It should arrive in a few seconds."),
      "ui_push_working":
          MessageLookupByLibrary.simpleMessage("Notifications are working."),
      "ui_community_no_posts":
          MessageLookupByLibrary.simpleMessage("No posts yet"),
      "ui_community_new": MessageLookupByLibrary.simpleMessage("New community"),
      "ui_community_name": MessageLookupByLibrary.simpleMessage("Name"),
      "ui_community_address_hint": MessageLookupByLibrary.simpleMessage(
          "Its address is made from the name."),
      "ui_community_address":
          MessageLookupByLibrary.simpleMessage("People will find it at"),
      "ui_community_new_detail": MessageLookupByLibrary.simpleMessage(
          "You will own it. A picture, a banner and moderators can be added from its page once it exists."),
      "ui_community_settings_home":
          MessageLookupByLibrary.simpleMessage("Home"),
      "ui_community_in_home":
          MessageLookupByLibrary.simpleMessage("Community posts in Home"),
      "ui_community_in_home_detail": MessageLookupByLibrary.simpleMessage(
          "Posts from your communities also appear in Home. Off, they stay here in Communities, where each one shows what is new."),
      "ui_community_settings_list":
          MessageLookupByLibrary.simpleMessage("Your list"),
      "ui_community_counts":
          MessageLookupByLibrary.simpleMessage("New-post counts"),
      "ui_community_counts_detail": MessageLookupByLibrary.simpleMessage(
          "Show how many posts are new in each community since you last opened it."),
      "ui_community_settings_running":
          MessageLookupByLibrary.simpleMessage("Communities you run"),
      "ui_community_running_none_detail": MessageLookupByLibrary.simpleMessage(
          "Communities you start, or moderate, are listed here."),
      "ui_community_role_owner": MessageLookupByLibrary.simpleMessage("Owner"),
      "ui_community_role_moderator":
          MessageLookupByLibrary.simpleMessage("Moderator"),
      "ui_community_filter_new":
          MessageLookupByLibrary.simpleMessage("New posts"),
      "ui_community_filter_running":
          MessageLookupByLibrary.simpleMessage("Yours to run"),
      "ui_community_settings_open":
          MessageLookupByLibrary.simpleMessage("Community settings"),
      "ui_community_discover": MessageLookupByLibrary.simpleMessage("Discover"),
      "ui_community_search_none":
          MessageLookupByLibrary.simpleMessage("No communities match."),
      "ui_community_new_none":
          MessageLookupByLibrary.simpleMessage("Nothing new"),
      "ui_community_new_none_detail": MessageLookupByLibrary.simpleMessage(
          "Every community is as you left it."),
      "ui_community_running_none":
          MessageLookupByLibrary.simpleMessage("You run none yet"),
      "ui_community_discover_none":
          MessageLookupByLibrary.simpleMessage("Nothing left to join"),
      "ui_community_discover_none_detail": MessageLookupByLibrary.simpleMessage(
          "You are in every community on Kyron. Start another one."),
      "ui_community_discover_search_detail":
          MessageLookupByLibrary.simpleMessage(
              "Try a different word, or start a community by that name."),
      "ui_community_write":
          MessageLookupByLibrary.simpleMessage("Write a post"),
      "ui_community_members": MessageLookupByLibrary.simpleMessage("Members:"),
      "ui_toast_posted": MessageLookupByLibrary.simpleMessage("Posted"),
      "ui_toast_view": MessageLookupByLibrary.simpleMessage("View"),
      "ui_toast_open": MessageLookupByLibrary.simpleMessage("Open"),
      "ui_dm_online": MessageLookupByLibrary.simpleMessage("Online"),
      "ui_dm_show_online":
          MessageLookupByLibrary.simpleMessage("Show when you're online"),
      "ui_dm_show_online_detail": MessageLookupByLibrary.simpleMessage(
          "People you message see a green dot while you have Kyron open. When this is off, you won't see theirs either."),
      "ui_explore_search":
          MessageLookupByLibrary.simpleMessage("Search people and posts"),
      "ui_explore_communities":
          MessageLookupByLibrary.simpleMessage("Communities to join"),
      "ui_explore_grid_empty":
          MessageLookupByLibrary.simpleMessage("Nothing to look at yet"),
      "ui_explore_grid_empty_detail": MessageLookupByLibrary.simpleMessage(
          "Photos and clips people post will show up here."),
      "ui_follow": MessageLookupByLibrary.simpleMessage("Follow"),
      "ui_delete_account":
          MessageLookupByLibrary.simpleMessage("Delete account"),
      "ui_delete_account_intro": MessageLookupByLibrary.simpleMessage(
          "This permanently deletes your Kyron account. It can't be undone."),
      "ui_delete_account_posts": MessageLookupByLibrary.simpleMessage(
          "Your profile, posts, replies, likes and reposts"),
      "ui_delete_account_messages": MessageLookupByLibrary.simpleMessage(
          "Your messages, including the ones you sent to other people, and the photos and voice notes in them"),
      "ui_delete_account_people": MessageLookupByLibrary.simpleMessage(
          "Your followers, the people you follow, and your settings"),
      "ui_delete_account_communities": MessageLookupByLibrary.simpleMessage(
          "Communities you started go to their longest-serving moderator or member. One with nobody else in it is closed."),
      "ui_delete_account_confirm_title":
          MessageLookupByLibrary.simpleMessage("Delete your account?"),
      "ui_delete_account_confirm_detail": MessageLookupByLibrary.simpleMessage(
          "You won't be able to get any of it back."),
      "ui_delete_account_done": MessageLookupByLibrary.simpleMessage(
          "Your account has been deleted."),
      "ui_dm_deleted_account":
          MessageLookupByLibrary.simpleMessage("Deleted account"),
      "ui_dm_deleted_account_detail": MessageLookupByLibrary.simpleMessage(
          "This account has been deleted, so messages can no longer be sent here."),
      "ui_login_google_hint": MessageLookupByLibrary.simpleMessage(
          "Signed up with Google? Use Sign in with Google instead."),
    };

final messageLookup = MessageLookup();
