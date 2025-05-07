import 'package:flutter/material.dart';
import '../services/leaderboard_service.dart';
import '../models/leaderboard.dart';

class LeaderboardScreen extends StatefulWidget {
  final String language;
  final String level;

  const LeaderboardScreen({
    Key? key,
    required this.language,
    required this.level,
  }) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final LeaderboardService _leaderboardService = LeaderboardService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.language} ${widget.level} Leaderboard'),
      ),
      body: StreamBuilder<List<LeaderboardEntry>>(
        stream: _leaderboardService.getLeaderboard(
          widget.language,
          widget.level,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final entries = snapshot.data!;

          if (entries.isEmpty) {
            return const Center(
              child: Text('No entries yet. Be the first to complete a quiz!'),
            );
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return LeaderboardEntryCard(
                entry: entry,
                rank: index + 1,
              );
            },
          );
        },
      ),
    );
  }
}

class LeaderboardEntryCard extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;

  const LeaderboardEntryCard({
    Key? key,
    required this.entry,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRankColor(rank),
          child: Text(
            rank.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          entry.username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Quizzes: ${entry.quizzesCompleted} | Avg: ${entry.averageScore.toStringAsFixed(1)}%',
        ),
        trailing: Text(
          '${entry.totalScore} pts',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown[300]!;
      default:
        return Colors.blue;
    }
  }
}
