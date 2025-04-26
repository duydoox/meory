import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meory/presentations/utils/app_utils.dart';

class EntryModel {
  final String? id;
  final String? headword;
  final String? definition;
  final PartsOfSpeechE? partsOfSpeech;
  final String? pronunciation;
  final String? category;
  final Timestamp? createdAt;
  final String? userId;
  final int? numberOfPlayed;
  final int? numberOfSuccess;
  final Timestamp? lastPlayedTime;
  final bool? lastPlayedResult;
  final int? score;

  EntryModel({
    this.id,
    this.headword,
    this.definition,
    this.partsOfSpeech,
    this.pronunciation,
    this.category,
    this.userId,
    this.numberOfPlayed = 0,
    this.numberOfSuccess = 0,
    this.lastPlayedTime,
    this.lastPlayedResult = false,
    this.score = 0,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
      id: json['id'],
      headword: json['headword'],
      definition: json['definition'],
      partsOfSpeech:
          json['partsOfSpeech'] != null ? PartsOfSpeechE.values[json['partsOfSpeech']] : null,
      pronunciation: json['pronunciation'],
      category: json['category'],
      createdAt: json['createdAt'],
      userId: json['userId'],
      numberOfPlayed: json['numberOfPlayed'],
      numberOfSuccess: json['numberOfSuccess'],
      lastPlayedTime: json['lastPlayedTime'],
      lastPlayedResult: json['lastPlayedResult'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'headword': headword,
      'definition': definition,
      'partsOfSpeech': partsOfSpeech?.index,
      'pronunciation': pronunciation,
      'category': category,
      'createdAt': createdAt,
      'userId': userId,
      'numberOfPlayed': numberOfPlayed,
      'numberOfSuccess': numberOfSuccess,
      'lastPlayedTime': lastPlayedTime,
      'lastPlayedResult': lastPlayedResult,
      'score': score,
    };
  }

  Map<String, dynamic> toUpdate() {
    return AppUtils.removeNullValues({
      'headword': headword,
      'definition': definition,
      'partsOfSpeech': partsOfSpeech,
      'pronunciation': pronunciation,
      'category': category,
      'createdAt': createdAt,
      'userId': userId,
      'numberOfPlayed': numberOfPlayed,
      'numberOfSuccess': numberOfSuccess,
      'lastPlayedTime': lastPlayedTime,
      'lastPlayedResult': lastPlayedResult,
      'score': score,
    });
  }

  EntryModel copyWith({
    String? id,
    String? headword,
    String? definition,
    PartsOfSpeechE? partsOfSpeech,
    String? pronunciation,
    String? category,
    Timestamp? createdAt,
    String? userId,
    int? numberOfPlayed,
    int? numberOfSuccess,
    Timestamp? lastPlayedTime,
    bool? lastPlayedResult,
    int? score,
  }) {
    return EntryModel(
      id: id ?? this.id,
      headword: headword ?? this.headword,
      definition: definition ?? this.definition,
      partsOfSpeech: partsOfSpeech ?? this.partsOfSpeech,
      pronunciation: pronunciation ?? this.pronunciation,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      numberOfPlayed: numberOfPlayed ?? this.numberOfPlayed,
      numberOfSuccess: numberOfSuccess ?? this.numberOfSuccess,
      lastPlayedTime: lastPlayedTime ?? this.lastPlayedTime,
      lastPlayedResult: lastPlayedResult ?? this.lastPlayedResult,
      score: score ?? this.score,
    );
  }
}

enum PartsOfSpeechE {
  noun,
  verb,
  adjective,
  adverb,
  preposition,
  conjunction,
  pronoun,
  interjection,
}
