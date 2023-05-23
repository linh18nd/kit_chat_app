class Participants {
  final String userId;
  final String username;
  final String avatarUrl;

  Participants({
    required this.userId,
    required this.username,
    required this.avatarUrl,
  });

  factory Participants.fromJson(Map<String, dynamic> json) {
    return Participants(
      userId: json['userId'],
      username: json['username'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'avatarUrl': avatarUrl,
    };
  }
}
