import 'package:flutter/material.dart';
import 'package:easy_talk/screens/auth/login_screen.dart';
import 'package:easy_talk/screens/settings/edit_profile_screen.dart';
import 'package:easy_talk/screens/settings/change_password_screen.dart';
import 'package:easy_talk/screens/settings/privacy_policy_screen.dart';
import 'package:easy_talk/screens/settings/terms_of_service_screen.dart';
import 'package:easy_talk/services/auth_service.dart';
import 'package:easy_talk/services/google_sign_in.dart';
import 'package:easy_talk/services/logger_service.dart';

class SettingsScreen extends StatefulWidget {
  final Function() toggleTheme;

  const SettingsScreen({
    super.key,
    required this.toggleTheme,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _authService = AuthService();
  final _googleSignInService = GoogleSignInService();
  bool _notifications = true;
  bool _soundEffects = true;
  String _selectedVoice = 'Default';

  Future<void> _signOut() async {
    try {
      Logger.debug('Starting sign out process');

      // Sign out from Google Sign In
      await _googleSignInService.signOut();

      // Sign out from Firebase Auth
      await _authService.signOut();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(toggleTheme: widget.toggleTheme),
          ),
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Sign out error', e, stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: ${e.toString()}'),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Settings'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildSection(
                  title: 'Appearance',
                  children: [
                    SwitchListTile(
                      title: const Text('Dark Mode'),
                      value: isDarkMode,
                      onChanged: (value) {
                        widget.toggleTheme();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Notifications',
                  children: [
                    SwitchListTile(
                      title: const Text('Push Notifications'),
                      value: _notifications,
                      onChanged: (value) {
                        setState(() {
                          _notifications = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Sound Effects'),
                      value: _soundEffects,
                      onChanged: (value) {
                        setState(() {
                          _soundEffects = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Voice',
                  children: [
                    ListTile(
                      title: const Text('Voice Selection'),
                      trailing: DropdownButton<String>(
                        value: _selectedVoice,
                        items: const [
                          DropdownMenuItem(
                            value: 'Default',
                            child: Text('Default'),
                          ),
                          DropdownMenuItem(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedVoice = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Account',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Edit Profile'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Change Password'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Sign Out'),
                      onTap: () {
                        _signOut();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'About',
                  children: [
                    const ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('Version'),
                      trailing: Text('1.0.0'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      title: const Text('Privacy Policy'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.gavel_outlined),
                      title: const Text('Terms of Service'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsOfServiceScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
