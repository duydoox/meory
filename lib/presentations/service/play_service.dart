import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meory/data/models/entry/entry_model.dart';

class PlayService {
  final int scoreIncreaseOnCorrect = 5;
  final int scoreDecreaseOnWrong = 20;
  final int scoreMax = 100;
  final int scoreMin = 0;

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

  /// lấy top 50 entry cần luyện nhất
  Future<List<EntryModel>> getTopImportantEntries(List<EntryModel> entries, [int take = 30]) async {
    entries.sort((a, b) {
      final aScore = _calculateImportanceScore(a);
      final bScore = _calculateImportanceScore(b);
      return bScore.compareTo(aScore);
    });

    return entries.take(take).toList();
  }

  double _calculateImportanceScore(EntryModel entry) {
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
