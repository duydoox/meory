import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meory/presentations/utils/app_utils.dart';

class StatisticalDayModel {
  final String? id;
  final String? userId;
  final int? numberOfPlayed;
  final int? numberOfSuccess;
  final Timestamp? lastPlayedTime;
  final Timestamp? date;

  const StatisticalDayModel({
    this.id,
    this.userId,
    this.numberOfPlayed,
    this.numberOfSuccess,
    this.lastPlayedTime,
    this.date,
  });

  DateTime? get toDate => date?.toDate();

  get createId => '${userId}_${toDate?.year}_${toDate?.month}_${toDate?.day}';

  factory StatisticalDayModel.fromJson(Map<String, dynamic> json) {
    return StatisticalDayModel(
      id: json['id'],
      userId: json['userId'],
      numberOfPlayed: json['numberOfPlayed'],
      numberOfSuccess: json['numberOfSuccess'],
      lastPlayedTime: json['lastPlayedTime'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'numberOfPlayed': numberOfPlayed,
      'numberOfSuccess': numberOfSuccess,
      'lastPlayedTime': lastPlayedTime,
      'date': date,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return AppUtils.removeNullValues({
      'userId': userId,
      'numberOfPlayed': numberOfPlayed,
      'lastPlayedTime': lastPlayedTime,
      'date': date,
    });
  }

  StatisticalDayModel copyWith({
    String? id,
    String? userId,
    int? numberOfPlayed,
    int? numberOfSuccess,
    Timestamp? lastPlayedTime,
    Timestamp? date,
  }) {
    return StatisticalDayModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      numberOfPlayed: numberOfPlayed ?? this.numberOfPlayed,
      numberOfSuccess: numberOfSuccess ?? this.numberOfSuccess,
      lastPlayedTime: lastPlayedTime ?? this.lastPlayedTime,
      date: date ?? this.date,
    );
  }
}
