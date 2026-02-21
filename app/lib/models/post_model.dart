import 'package:flutter/material.dart';

enum PostMediaType { image, video, arLens, none }

class PostModel {
  final String id;
  final String creatorDid;
  final String creatorHandle;
  final String creatorAvatarUrl;
  final DateTime timestamp;
  final String caption;
  final PostMediaType mediaType;
  final String? mediaUrl;
  final String? communityTag;
  final int likes;
  final int comments;
  final int reposts;
  final int reach;
  final bool isLiked;
  final bool isBookmarked;
  final bool isFollowingCreator;
  final bool isSelfPost;
  final bool isLive;

  PostModel({
    required this.id,
    required this.creatorDid,
    required this.creatorHandle,
    required this.creatorAvatarUrl,
    required this.timestamp,
    required this.caption,
    this.mediaType = PostMediaType.none,
    this.mediaUrl,
    this.communityTag,
    required this.likes,
    required this.comments,
    required this.reposts,
    required this.reach,
    this.isLiked = false,
    this.isBookmarked = false,
    this.isFollowingCreator = false,
    this.isSelfPost = false,
    this.isLive = false,
  });

  String get displayTimestamp {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}