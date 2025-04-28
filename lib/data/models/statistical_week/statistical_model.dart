import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticalModel {
  final int? streak;
  final Timestamp? lastPlayedTime;
  final int? numberOfPlayed;
  final int? numberOfSuccess;

  const StatisticalModel({
    this.streak = 0,
    this.lastPlayedTime,
    this.numberOfPlayed = 0,
    this.numberOfSuccess = 0,
  });

  factory StatisticalModel.fromJson(Map<String, dynamic> json) {
    return StatisticalModel(
      streak: json['streak'] ?? 0,
      lastPlayedTime: json['lastPlayedTime'],
      numberOfPlayed: json['numberOfPlayed'] ?? 0,
      numberOfSuccess: json['numberOfSuccess'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'streak': streak,
      'lastPlayedTime': lastPlayedTime,
      'numberOfPlayed': numberOfPlayed,
      'numberOfSuccess': numberOfSuccess,
    };
  }

  StatisticalModel copyWith({
    int? streak,
    Timestamp? lastPlayedTime,
    int? numberOfPlayed,
    int? numberOfSuccess,
  }) {
    return StatisticalModel(
      streak: streak ?? this.streak,
      lastPlayedTime: lastPlayedTime ?? this.lastPlayedTime,
      numberOfPlayed: numberOfPlayed ?? this.numberOfPlayed,
    );
  }
}
