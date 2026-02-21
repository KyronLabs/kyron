// lib/models/profile_model.dart
import 'package:flutter/material.dart';

class ProfileModel {
  final String did;
  final String handle;
  final String displayName;
  final String avatarUrl;
  final String? coverUrl;
  final int kyronPoints;
  final String? bio;
  final List<String> socials;
  final List<BadgeModel> badges;
  final int postsCount;
  final int repliesCount;
  final int mediaCount;
  final int likesCount;
  final bool isFollowing;
  final bool isVerified;
  final bool isOwnProfile;

  ProfileModel({
    required this.did,
    required this.handle,
    required this.displayName,
    required this.avatarUrl,
    this.coverUrl,
    required this.kyronPoints,
    this.bio,
    required this.socials,
    required this.badges,
    required this.postsCount,
    required this.repliesCount,
    required this.mediaCount,
    required this.likesCount,
    this.isFollowing = false,
    this.isVerified = false,
    this.isOwnProfile = false,
  });

  // Helper method to create a mock profile
  static ProfileModel mock() {
    return ProfileModel(
      did: 'did:plc:abcdef123456',
      handle: '@alice',
      displayName: 'Alice Johnson',
      avatarUrl: 'https://picsum.photos/300/300?random=1',
      coverUrl: 'https://picsum.photos/800/300?random=2',
      kyronPoints: 1042,
      bio: 'Building the user-owned feed. AR lenses, climate memes, and the occasional hot take. Founder @kyron.',
      socials: ['kyron.so', '@alice', 'alice@kyron.so'],
      badges: [
        BadgeModel(emoji: '👑', label: 'Creator', description: 'Content Creator'),
        BadgeModel(emoji: '✅', label: 'Verified', description: 'Verified Account'),
        BadgeModel(emoji: '⚡', label: '0G', description: 'Zero Gravity Member'),
        BadgeModel(emoji: '🏆', label: '1K Club', description: '1K Followers'),
      ],
      postsCount: 42,
      repliesCount: 128,
      mediaCount: 24,
      likesCount: 512,
      isFollowing: false,
      isVerified: true,
      isOwnProfile: false,
    );
  }
}

class BadgeModel {
  final String emoji;
  final String label;
  final String description;

  BadgeModel({
    required this.emoji,
    required this.label,
    required this.description,
  });
}