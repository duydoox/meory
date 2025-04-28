import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticalWeekModel {
  final String? id;
  final String? userId;
  final int? numberOfPlayed;
  final int? numberOfSuccess;
  final int? score;
  final Timestamp? lastPlayedTime;
  final int? year;
  final int? month;
  final int? week;

  const StatisticalWeekModel({
    this.id,
    this.userId,
    this.numberOfPlayed,
    this.numberOfSuccess,
    this.score,
    this.lastPlayedTime,
    this.year,
    this.month,
    this.week,
  });

  get createId => 'Statistical_$year/$month/$week';

  factory StatisticalWeekModel.fromJson(Map<String, dynamic> json) {
    return StatisticalWeekModel(
      id: json['id'],
      userId: json['userId'],
      numberOfPlayed: json['numberOfPlayed'],
      numberOfSuccess: json['numberOfSuccess'],
      score: json['score'],
      lastPlayedTime: json['lastPlayedTime'],
      year: json['year'],
      month: json['month'],
      week: json['week'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'numberOfPlayed': numberOfPlayed,
      'numberOfSuccess': numberOfSuccess,
      'score': score,
      'lastPlayedTime': lastPlayedTime,
      'year': year,
      'month': month,
      'week': week,
    };
  }

  StatisticalWeekModel copyWith({
    String? id,
    String? userId,
    int? numberOfPlayed,
    int? numberOfSuccess,
    int? score,
    Timestamp? lastPlayedTime,
    int? streak,
    int? year,
    int? month,
    int? week,
  }) {
    return StatisticalWeekModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      numberOfPlayed: numberOfPlayed ?? this.numberOfPlayed,
      numberOfSuccess: numberOfSuccess ?? this.numberOfSuccess,
      score: score ?? this.score,
      lastPlayedTime: lastPlayedTime ?? this.lastPlayedTime,
      year: year ?? this.year,
      month: month ?? this.month,
      week: week ?? this.week,
    );
  }
}
