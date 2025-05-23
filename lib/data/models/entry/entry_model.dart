import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/presentations/utils/app_utils.dart';

class EntryModel {
  final String? id;
  final String? headword;
  final String? definition;
  final PartsOfSpeechE? partsOfSpeech;
  final String? pronunciation;
  final String? category;
  final String? example;
  final String? note;
  final String? topic;
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
    this.example,
    this.note,
    this.topic,
    this.userId,
    this.numberOfPlayed = 0,
    this.numberOfSuccess = 0,
    this.lastPlayedTime,
    this.lastPlayedResult = false,
    this.score = 0,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  MasteryE get mastery {
    if (score == null) {
      return MasteryE.novice;
    }
    return MasteryE.fromScore(score!);
  }

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
      id: json['id'],
      headword: json['headword'],
      definition: json['definition'],
      partsOfSpeech: _getPartsOfSpeechFromValueOrIndex(json['partsOfSpeech']),
      pronunciation: json['pronunciation'],
      category: json['category'],
      example: json['example'],
      note: json['note'],
      topic: json['topic'],
      createdAt: json['createdAt'],
      userId: json['userId'],
      numberOfPlayed: json['numberOfPlayed'],
      numberOfSuccess: json['numberOfSuccess'],
      lastPlayedTime: json['lastPlayedTime'],
      lastPlayedResult: json['lastPlayedResult'],
      score: json['score'],
    );
  }

  static PartsOfSpeechE? _getPartsOfSpeechFromValueOrIndex(dynamic partsOfSpeech) {
    if (partsOfSpeech == null) {
      return null;
    } else if (partsOfSpeech is int &&
        partsOfSpeech >= 0 &&
        partsOfSpeech < PartsOfSpeechE.values.length) {
      return PartsOfSpeechE.values[partsOfSpeech];
    } else if (partsOfSpeech is String) {
      return PartsOfSpeechE.values.where((e) => e.name == partsOfSpeech).firstOrNull;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'headword': headword,
      'definition': definition,
      'partsOfSpeech': partsOfSpeech?.index,
      'pronunciation': pronunciation,
      'category': category,
      'example': example,
      'note': note,
      'topic': topic,
      'createdAt': createdAt,
      'userId': userId,
      'numberOfPlayed': numberOfPlayed,
      'numberOfSuccess': numberOfSuccess,
      'lastPlayedTime': lastPlayedTime,
      'lastPlayedResult': lastPlayedResult,
      'score': score,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return AppUtils.removeNullValues({
      'headword': headword,
      'definition': definition,
      'partsOfSpeech': partsOfSpeech?.index,
      'pronunciation': pronunciation,
      'category': category,
      'example': example,
      'note': note,
      'topic': topic,
      'createdAt': createdAt,
      'userId': userId,
      'numberOfPlayed': numberOfPlayed,
      'numberOfSuccess': numberOfSuccess,
      'lastPlayedTime': lastPlayedTime,
      'lastPlayedResult': lastPlayedResult,
      'score': score,
    });
  }

  Map<String, dynamic> toJsonAsk() {
    return AppUtils.removeNullValues({
      'headword': headword,
      'definition': definition,
      'partsOfSpeech': partsOfSpeech?.index,
      'pronunciation': pronunciation,
      'category': category,
      'topic': topic,
      'example': example,
    });
  }

  EntryModel copyWith({
    String? id,
    String? headword,
    String? definition,
    PartsOfSpeechE? partsOfSpeech,
    String? pronunciation,
    String? category,
    String? example,
    String? note,
    String? topic,
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
      example: example ?? this.example,
      note: note ?? this.note,
      topic: topic ?? this.topic,
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
  noun('N'),
  verb('V'),
  adjective('Adj'),
  adverb('Adv'),
  preposition('P'),
  conjunction('C'),
  pronoun('Pro'),
  interjection('I');

  const PartsOfSpeechE(this.short);
  final String short;
}

enum MasteryE {
  novice(-1000),
  intermediate(1),
  advanced(40),
  expert(70),
  master(90);

  const MasteryE(this.mark);

  final int mark;

  static MasteryE fromScore(int score) {
    if (score >= MasteryE.master.mark) {
      return MasteryE.master;
    } else if (score >= MasteryE.expert.mark) {
      return MasteryE.expert;
    } else if (score >= MasteryE.advanced.mark) {
      return MasteryE.advanced;
    } else if (score >= MasteryE.intermediate.mark) {
      return MasteryE.intermediate;
    }
    return MasteryE.novice;
  }

  Color getColor(AppTheme theme) {
    switch (this) {
      case MasteryE.novice:
        return theme.colors.red;
      case MasteryE.intermediate:
        return theme.colors.orange;
      case MasteryE.advanced:
        return theme.colors.yellow;
      case MasteryE.expert:
        return theme.colors.green;
      case MasteryE.master:
        return theme.colors.green;
    }
  }
}
