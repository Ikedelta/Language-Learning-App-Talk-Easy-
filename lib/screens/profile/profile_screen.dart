import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_service.dart';
import '../../services/leaderboard_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final LeaderboardService _leaderboardService = LeaderboardService();
  bool _isLoading = true;
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _stats;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final userDoc = await _authService.getUserData(user.uid);
        final stats = await _leaderboardService.getUserStats(user.uid);

        if (mounted) {
          setState(() {
            _userData = userDoc.data() as Map<String, dynamic>?;
            _stats = stats;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 24),
                _buildStatsSection(),
                const SizedBox(height: 24),
                _buildAchievementsSection(),
                const SizedBox(height: 24),
                _buildLanguageProgressSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _userData?['photoURL'] != null
                ? NetworkImage(_userData!['photoURL'])
                : null,
            child: _userData?['photoURL'] == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            _userData?['fullName'] ?? 'User',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            _userData?['email'] ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildStatRow('Level', '${_userData?['level'] ?? 1}'),
            _buildStatRow('XP', '${_userData?['xp'] ?? 0}'),
            _buildStatRow('Time Spent', '${_userData?['timeSpent'] ?? 0} min'),
            _buildStatRow(
                'Conversations', '${_userData?['conversations'] ?? 0}'),
            _buildStatRow('Streak', '${_userData?['streak'] ?? 0} days'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    final achievements =
        _userData?['achievements'] as Map<String, dynamic>? ?? {};

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Achievements',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildAchievementItem(
              'First Chat',
              'Complete your first conversation',
              achievements['first_chat'] ?? false,
            ),
            _buildAchievementItem(
              '30 Minutes',
              'Practice for 30 minutes',
              achievements['thirty_minutes'] ?? false,
            ),
            _buildAchievementItem(
              '3-Day Streak',
              'Practice for 3 days in a row',
              achievements['three_day_streak'] ?? false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementItem(
      String title, String description, bool isUnlocked) {
    return ListTile(
      leading: Icon(
        isUnlocked ? Icons.emoji_events : Icons.emoji_events_outlined,
        color: isUnlocked ? Colors.amber : Colors.grey,
      ),
      title: Text(title),
      subtitle: Text(description),
      trailing: Icon(
        isUnlocked ? Icons.check_circle : Icons.lock,
        color: isUnlocked ? Colors.green : Colors.grey,
      ),
    );
  }

  Widget _buildLanguageProgressSection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Language Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildLanguageProgressItem(
              'Vocabulary',
              _stats?['totalWords'] ?? 0,
              _stats?['learnedWords'] ?? 0,
            ),
            _buildLanguageProgressItem(
              'Grammar',
              _stats?['totalLessons'] ?? 0,
              _stats?['completedLessons'] ?? 0,
            ),
            _buildLanguageProgressItem(
              'Quizzes',
              _stats?['totalQuizzes'] ?? 0,
              _stats?['completedQuizzes'] ?? 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageProgressItem(
    String label,
    int total,
    int completed,
  ) {
    final progress = total > 0 ? completed / total : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('$completed/$total'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
