import 'package:meory/data/models/entry/entry_model.dart';

class HomeModel {
  final int totalEntries;
  final int masteredEntries;
  final int streak;
  final List<EntryModel> recentEntries;
  final double masteryRate;
  final int todayLearned;

  const HomeModel({
    this.totalEntries = 0,
    this.masteredEntries = 0,
    this.streak = 0,
    this.recentEntries = const [],
    this.masteryRate = 0.0,
    this.todayLearned = 0,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      totalEntries: json['totalEntries'] ?? 0,
      masteredEntries: json['masteredEntries'] ?? 0,
      streak: json['streak'] ?? 0,
      recentEntries:
          (json['recentEntries'] as List?)?.map((e) => EntryModel.fromJson(e)).toList() ?? [],
      masteryRate: json['masteryRate']?.toDouble() ?? 0.0,
      todayLearned: json['todayLearned'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEntries': totalEntries,
      'masteredEntries': masteredEntries,
      'streak': streak,
      'recentEntries': recentEntries.map((e) => e.toJson()).toList(),
      'masteryRate': masteryRate,
      'todayLearned': todayLearned,
    };
  }

  HomeModel copyWith({
    int? totalEntries,
    int? masteredEntries,
    int? streak,
    List<EntryModel>? recentEntries,
    double? masteryRate,
    int? todayLearned,
  }) {
    return HomeModel(
      totalEntries: totalEntries ?? this.totalEntries,
      masteredEntries: masteredEntries ?? this.masteredEntries,
      streak: streak ?? this.streak,
      recentEntries: recentEntries ?? this.recentEntries,
      masteryRate: masteryRate ?? this.masteryRate,
      todayLearned: todayLearned ?? this.todayLearned,
    );
  }

  bool get isEmpty =>
      totalEntries == 0 &&
      masteredEntries == 0 &&
      streak == 0 &&
      recentEntries.isEmpty &&
      masteryRate == 0.0 &&
      todayLearned == 0;
}
