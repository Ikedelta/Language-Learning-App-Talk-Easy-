import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/leaderboard.dart';
import '../models/quiz.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update leaderboard when a quiz is completed
  Future<void> updateLeaderboard(QuizResult result, String username) async {
    final userRef = _firestore.collection('users').doc(result.userId);
    final userData = await userRef.get();

    if (!userData.exists) return;

    final language = userData.data()?['currentLanguage'] ?? 'English';
    final level = userData.data()?['currentLevel'] ?? 'Beginner';

    // Get existing leaderboard entry
    final leaderboardRef = _firestore
        .collection('leaderboard')
        .where('userId', isEqualTo: result.userId)
        .where('language', isEqualTo: language)
        .where('level', isEqualTo: level);

    final existingEntry = await leaderboardRef.get();

    if (existingEntry.docs.isEmpty) {
      // Create new entry
      await _firestore.collection('leaderboard').add(
            LeaderboardEntry(
              userId: result.userId,
              username: username,
              language: language,
              level: level,
              totalScore: result.score,
              quizzesCompleted: 1,
              averageScore: result.score.toDouble(),
              lastUpdated: DateTime.now(),
            ).toJson(),
          );
    } else {
      // Update existing entry
      final doc = existingEntry.docs.first;
      final currentData = doc.data();

      final newTotalScore = currentData['totalScore'] + result.score;
      final newQuizzesCompleted = currentData['quizzesCompleted'] + 1;
      final newAverageScore = newTotalScore / newQuizzesCompleted;

      await doc.reference.update({
        'totalScore': newTotalScore,
        'quizzesCompleted': newQuizzesCompleted,
        'averageScore': newAverageScore,
        'lastUpdated': DateTime.now().toIso8601String(),
      });
    }
  }

  // Get leaderboard for a specific language and level
  Stream<List<LeaderboardEntry>> getLeaderboard(
    String language,
    String level, {
    int limit = 50,
  }) {
    return _firestore
        .collection('leaderboard')
        .where('language', isEqualTo: language)
        .where('level', isEqualTo: level)
        .orderBy('totalScore', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => LeaderboardEntry.fromJson(doc.data()))
          .toList();
    });
  }

  // Get user's rank in a specific language and level
  Future<int> getUserRank(
    String userId,
    String language,
    String level,
  ) async {
    final snapshot = await _firestore
        .collection('leaderboard')
        .where('language', isEqualTo: language)
        .where('level', isEqualTo: level)
        .orderBy('totalScore', descending: true)
        .get();

    final entries = snapshot.docs
        .map((doc) => LeaderboardEntry.fromJson(doc.data()))
        .toList();

    final userIndex = entries.indexWhere((entry) => entry.userId == userId);
    return userIndex + 1; // Return 0 if user not found
  }

  // Get user's leaderboard statistics
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    final snapshot = await _firestore
        .collection('leaderboard')
        .where('userId', isEqualTo: userId)
        .get();

    if (snapshot.docs.isEmpty) {
      return {
        'totalQuizzes': 0,
        'averageScore': 0.0,
        'highestScore': 0,
        'languages': [],
      };
    }

    final entries = snapshot.docs
        .map((doc) => LeaderboardEntry.fromJson(doc.data()))
        .toList();

    final totalQuizzes = entries.fold<int>(
      0,
      (sum, entry) => sum + entry.quizzesCompleted,
    );

    final averageScore = entries.fold<double>(
          0,
          (sum, entry) => sum + entry.averageScore,
        ) /
        entries.length;

    final highestScore = entries.fold<int>(
      0,
      (max, entry) => entry.totalScore > max ? entry.totalScore : max,
    );

    final languages = entries.map((e) => e.language).toSet().toList();

    return {
      'totalQuizzes': totalQuizzes,
      'averageScore': averageScore,
      'highestScore': highestScore,
      'languages': languages,
    };
  }
}
