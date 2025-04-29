import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meory/data/models/entry/entry_model.dart';

class PlayService {
  final int scoreIncreaseOnCorrect = 5;
  final int scoreDecreaseOnWrong = 20;
  final int scoreMax = 100;
  final int scoreMin = -100;

  updateEntryResult(EntryModel entry, bool result) {
    return entry.copyWith(
      numberOfPlayed: entry.numberOfPlayed! + 1,
      lastPlayedResult: result,
      lastPlayedTime: Timestamp.now(),
      score: result
          ? (entry.score! + scoreIncreaseOnCorrect).clamp(scoreMin, scoreMax)
          : (entry.score! - scoreDecreaseOnWrong).clamp(scoreMin, scoreMax),
      numberOfSuccess: result ? entry.numberOfSuccess! + 1 : entry.numberOfSuccess,
    );
  }

  Future<List<EntryModel>> getRandomEntry(
    List<EntryModel> entries, {
    EntryModel? defaultEntry,
    int take = 4,
  }) async {
    final random = Random();
    final picked = <EntryModel>{};
    int count = 200;

    final noneEntries = List.generate(
        max(take - entries.length, 0),
        (index) => EntryModel(
              id: index.toString(),
              headword: 'none ${index + 1}',
              definition: ' ' * index,
            ));

    final finalEntries = [...entries, ...noneEntries];

    if (defaultEntry != null) {
      picked.add(defaultEntry);
    }

    while (picked.length < take && picked.length < finalEntries.length - 1 && count > 0) {
      count--;
      final entry = finalEntries[random.nextInt(finalEntries.length)];
      final existed = picked.any((e) => e.id == entry.id);
      if (entry.id != defaultEntry?.id && !existed) {
        picked.add(entry);
      }
    }

    if (picked.length < take) {
      picked.addAll(List.generate(
        take - picked.length,
        (index) => EntryModel(),
      ));
    }

    return picked.toList()..shuffle(random);
  }

  /// lấy top 50 entry cần luyện nhất
  List<EntryModel> getTopImportantEntries(List<EntryModel> entries, {int take = 30}) {
    entries.sort((a, b) {
      final aScore = calculateImportanceScore(a);
      final bScore = calculateImportanceScore(b);
      return bScore.compareTo(aScore);
    });
    final originalList = entries.take(take).toList();
    List<EntryModel> result = [];

    // Chia danh sách thành các nhóm con có kích thước 10
    // Trộn các nhóm con
    final random = Random();
    for (int i = 0; i < originalList.length; i += 10) {
      int end = (i + 10 < originalList.length) ? i + 10 : originalList.length;
      List<EntryModel> sublist = originalList.sublist(i, end);
      sublist.shuffle(random);
      result.addAll(sublist);
    }

    return result;
  }

  double calculateImportanceScore(EntryModel entry) {
    final now = DateTime.now();
    final lastPlayed =
        entry.lastPlayedTime?.toDate() ?? DateTime.now().add(const Duration(days: -100));
    final daysSinceLastPlayed = now.difference(lastPlayed).inMinutes / 60 / 60 / 24;

    // Tỉ lệ chơi sai
    double failureRate = 1.0;
    if (entry.numberOfPlayed != null &&
        entry.numberOfPlayed != 0 &&
        entry.numberOfSuccess != null) {
      failureRate = (entry.numberOfPlayed! - entry.numberOfSuccess!) / entry.numberOfPlayed!;
    }

    // Các trọng số:
    const weightScore = 0.5; // Trọng số cho điểm số (0 - 100 điểm)
    const weightLastPlayed = 0.4; // Trọng số cho thời gian đã chơi gần nhất đến hiện tại (ngày)
    const weightPlayedTimes = 0.05; // Trọng số cho số lần đã chơi (lần)
    const weightFailureRate = 0.05; // Trọng số cho tỉ lệ chơi sai (%)

    final importanceScore = (100 - (entry.score ?? 0)) * weightScore +
        (daysSinceLastPlayed) * weightLastPlayed +
        (100 - (entry.numberOfPlayed ?? 0)).clamp(-100, 100) * weightPlayedTimes +
        (failureRate * 100) * weightFailureRate;

    return importanceScore;
  }
}
