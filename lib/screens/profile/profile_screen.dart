import 'package:flutter/material.dart';
import 'package:easy_talk/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _authService.currentUser;
    if (user != null) {
      final userData = await _authService.getUserData(user.uid);
      setState(() {
        _userData = userData.data() as Map<String, dynamic>?;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final user = _authService.currentUser;
    final fullName = _userData?['fullName'] ?? 'User';
    final email = user?.email ?? 'No email';
    final level = _userData?['level'] ?? 1;
    final xp = _userData?['xp'] ?? 0;
    final xpNeeded = 1000; // XP needed for next level
    final progress = (xp % xpNeeded) / xpNeeded;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: Navigate to edit profile screen
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    fullName[0].toUpperCase(),
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  fullName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 32),
                _ProgressSection(level: level, progress: progress, xp: xp),
                const SizedBox(height: 32),
                _StatsSection(userData: _userData),
                const SizedBox(height: 32),
                _AchievementsSection(userData: _userData),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final int level;
  final double progress;
  final int xp;

  const _ProgressSection({
    required this.level,
    required this.progress,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Learning Progress',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level $level',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${(progress * 100).toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$xp XP',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsSection extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const _StatsSection({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Statistics',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.timer,
                  label: 'Time Spent',
                  value: '${userData?['timeSpent'] ?? 0}h',
                ),
                _StatItem(
                  icon: Icons.chat,
                  label: 'Conversations',
                  value: '${userData?['conversations'] ?? 0}',
                ),
                _StatItem(
                  icon: Icons.star,
                  label: 'Streak',
                  value: '${userData?['streak'] ?? 0} days',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}

class _AchievementsSection extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const _AchievementsSection({required this.userData});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {
        'id': 'first_chat',
        'icon': Icons.emoji_events,
        'title': 'First Chat',
        'description': 'Complete your first conversation',
        'isUnlocked': userData?['achievements']?['first_chat'] ?? false,
      },
      {
        'id': 'thirty_minutes',
        'icon': Icons.timer,
        'title': '30 Minutes',
        'description': 'Practice for 30 minutes',
        'isUnlocked': userData?['achievements']?['thirty_minutes'] ?? false,
      },
      {
        'id': 'three_day_streak',
        'icon': Icons.star,
        'title': '3 Day Streak',
        'description': 'Practice for 3 days in a row',
        'isUnlocked': userData?['achievements']?['three_day_streak'] ?? false,
      },
      {
        'id': 'level_5',
        'icon': Icons.workspace_premium,
        'title': 'Level 5',
        'description': 'Reach level 5',
        'isUnlocked': (userData?['level'] ?? 0) >= 5,
      },
      {
        'id': 'conversation_master',
        'icon': Icons.chat_bubble,
        'title': 'Conversation Master',
        'description': 'Complete 10 conversations',
        'isUnlocked': (userData?['conversations'] ?? 0) >= 10,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Achievements',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: achievements
                .map((achievement) => _AchievementItem(
                      icon: achievement['icon'] as IconData,
                      title: achievement['title'] as String,
                      description: achievement['description'] as String,
                      isUnlocked: achievement['isUnlocked'] as bool,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isUnlocked;

  const _AchievementItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isUnlocked
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[400],
              size: 32,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
