class LeaderboardEntry {
  final String userId;
  final String username;
  final String language;
  final String level;
  final int totalScore;
  final int quizzesCompleted;
  final double averageScore;
  final DateTime lastUpdated;

  LeaderboardEntry({
    required this.userId,
    required this.username,
    required this.language,
    required this.level,
    required this.totalScore,
    required this.quizzesCompleted,
    required this.averageScore,
    required this.lastUpdated,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'language': language,
        'level': level,
        'totalScore': totalScore,
        'quizzesCompleted': quizzesCompleted,
        'averageScore': averageScore,
        'lastUpdated': lastUpdated.toIso8601String(),
      };

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      LeaderboardEntry(
        userId: json['userId'],
        username: json['username'],
        language: json['language'],
        level: json['level'],
        totalScore: json['totalScore'],
        quizzesCompleted: json['quizzesCompleted'],
        averageScore: json['averageScore'].toDouble(),
        lastUpdated: DateTime.parse(json['lastUpdated']),
      );
}
