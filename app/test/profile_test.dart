import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/profile_model.dart';
import 'package:kyron_app/models/profile_summary.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/utils/format_count.dart';

void main() {
  group('CurrentUser.fromJson', () {
    test('keeps every stat the response carries', () {
      // followers was the only one it read. following and the post count
      // arrived in the same payload and were dropped, so the drawer and the
      // profile screen could not show them however they were written.
      final user = CurrentUser.fromJson(const {
        'user': {
          'id': 'u1',
          'name': 'Ada',
          'username': 'ada',
          'did': 'did:kyron:1',
          'kyronPoints': 42,
        },
        'profile': {
          'avatarUrl': 'https://example.test/a.png',
          'coverUrl': 'https://example.test/c.png',
          'bio': 'Building things',
          'location': 'London',
          'website': 'ada.example',
        },
        'stats': {'followers': 12, 'following': 34, 'posts': 5},
      });

      expect(user.followers, 12);
      expect(user.following, 34);
      expect(user.posts, 5);
      expect(user.bio, 'Building things');
      expect(user.location, 'London');
      expect(user.website, 'ada.example');
    });

    test('survives a response missing every optional block', () {
      final user = CurrentUser.fromJson(const {});

      expect(user.id, '');
      expect(user.followers, 0);
      expect(user.following, 0);
      expect(user.posts, 0);
      expect(user.avatarUrl, isNull);
    });

    test('display name prefers the name, then the handle', () {
      expect(
        CurrentUser.fromJson(const {
          'user': {'name': 'Ada', 'username': 'ada'}
        }).displayName,
        'Ada',
      );
      expect(
        CurrentUser.fromJson(const {
          'user': {'username': 'ada'}
        }).displayName,
        'ada',
      );
    });

    test('handle is null rather than a bare @ when none is set', () {
      expect(CurrentUser.fromJson(const {}).handle, isNull);
      expect(
        CurrentUser.fromJson(const {
          'user': {'username': '  '}
        }).handle,
        isNull,
      );
    });
  });

  group('ProfileModel', () {
    test('reads a public profile, follow state included', () {
      final profile = ProfileModel.fromJson(const {
        'user': {'id': 'u2', 'username': 'grace', 'kyronPoints': 7},
        'profile': {'bio': 'Compilers'},
        'stats': {
          'followers': 900,
          'following': 3,
          'posts': 11,
          'isFollowing': true,
        },
      });

      expect(profile.id, 'u2');
      expect(profile.isFollowing, isTrue);
      expect(profile.isOwnProfile, isFalse);
      expect(profile.followers, 900);
      expect(profile.following, 3);
    });

    test('your own profile is never marked as followed', () {
      final me = ProfileModel.fromCurrentUser(CurrentUser.fromJson(const {
        'user': {'id': 'me'},
        'stats': {'followers': 1, 'following': 2, 'posts': 3},
      }));

      expect(me.isOwnProfile, isTrue);
      expect(me.isFollowing, isFalse);
      expect(me.posts, 3);
    });

    test('copyWith moves the follow state and count together', () {
      const before = ProfileModel(
        id: 'u3',
        kyronPoints: 0,
        followers: 10,
        following: 0,
        posts: 0,
      );

      final after = before.copyWith(isFollowing: true, followers: 11);

      expect(after.followers, 11);
      expect(after.isFollowing, isTrue);
      // Everything else is carried, not reset.
      expect(after.id, 'u3');
    });
  });

  group('ProfileSummary.fromJson', () {
    test('reads a search result', () {
      final person = ProfileSummary.fromJson(const {
        'id': 'u4',
        'name': 'Grace',
        'username': 'grace',
        'avatarUrl': 'https://example.test/g.png',
        'followers': 5,
      });

      expect(person.displayName, 'Grace');
      expect(person.handle, '@grace');
      expect(person.followers, 5);
    });

    test('never invents a handle for an account without one', () {
      expect(ProfileSummary.fromJson(const {'id': 'u5'}).handle, isNull);
    });
  });

  group('Routes.usernameFromArguments', () {
    test('no arguments means your own profile', () {
      // The old route answered this case by inventing an account called
      // "@current" with the DID "did:plc:currentuser".
      expect(Routes.usernameFromArguments(null), isNull);
    });

    test('strips a leading @ and surrounding space', () {
      expect(Routes.usernameFromArguments(' @ada '), 'ada');
      expect(Routes.usernameFromArguments('ada'), 'ada');
    });

    test('reads a handle out of a map under either key', () {
      expect(Routes.usernameFromArguments({'username': 'ada'}), 'ada');
      expect(Routes.usernameFromArguments({'handle': '@ada'}), 'ada');
    });

    test('reads it off a ProfileModel', () {
      const profile = ProfileModel(
        id: 'u6',
        username: 'ada',
        kyronPoints: 0,
        followers: 0,
        following: 0,
        posts: 0,
      );
      expect(Routes.usernameFromArguments(profile), 'ada');
    });

    test('an empty handle is your own profile, not a lookup for ""', () {
      expect(Routes.usernameFromArguments(''), isNull);
      expect(Routes.usernameFromArguments('@'), isNull);
      expect(Routes.usernameFromArguments({'username': '  '}), isNull);
    });
  });

  group('formatCount', () {
    test('leaves small numbers alone', () {
      expect(formatCount(0), '0');
      expect(formatCount(999), '999');
    });

    test('abbreviates thousands and drops a trailing zero', () {
      expect(formatCount(1000), '1K');
      expect(formatCount(1234), '1.2K');
      expect(formatCount(12345), '12.3K');
    });

    test('abbreviates millions and billions', () {
      expect(formatCount(1500000), '1.5M');
      expect(formatCount(2000000000), '2B');
    });

    test('never renders a negative count', () {
      expect(formatCount(-5), '0');
    });
  });
}
