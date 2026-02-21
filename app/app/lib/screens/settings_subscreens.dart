import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../routes.dart';

// Stub screens for Settings sub-routes
class SettingsChangeEmailScreen extends StatelessWidget {
  const SettingsChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Navigator.pop(context)),
        title: const Text('Change Email'),
      ),
      body: const Center(child: Text('Change Email Screen')),
    );
  }
}

class SettingsBlockedUsersScreen extends StatelessWidget {
  const SettingsBlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Navigator.pop(context)),
        title: const Text('Blocked Users'),
      ),
      body: const Center(child: Text('Blocked Users Screen')),
    );
  }
}

class SettingsPasswordLoginScreen extends StatelessWidget {
  const SettingsPasswordLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Navigator.pop(context)),
        title: const Text('Password & Login'),
      ),
      body: const Center(child: Text('Password & Login Screen')),
    );
  }
}

class SettingsFontSizeScreen extends StatelessWidget {
  const SettingsFontSizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Navigator.pop(context)),
        title: const Text('Font Size'),
      ),
      body: const Center(child: Text('Font Size Screen')),
    );
  }
}

class SettingsLanguageScreen extends StatelessWidget {
  const SettingsLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Navigator.pop(context)),
        title: const Text('Language'),
      ),
      body: const Center(child: Text('Language Screen')),
    );
  }
}

class SettingsNotificationsScreen extends StatelessWidget {
  const SettingsNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Navigator.pop(context)),
        title: const Text('Push Notifications'),
      ),
      body: const Center(child: Text('Notifications Screen')),
    );
  }
}

class SettingsContactSupportScreen extends StatelessWidget {
  const SettingsContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Navigator.pop(context)),
        title: const Text('Contact Support'),
      ),
      body: const Center(child: Text('Contact Support Screen')),
    );
  }
}

class SettingsFeedbackScreen extends StatelessWidget {
  const SettingsFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Navigator.pop(context)),
        title: const Text('Send Feedback'),
      ),
      body: const Center(child: Text('Send Feedback Screen')),
    );
  }
}