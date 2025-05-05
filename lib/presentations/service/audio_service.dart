import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();

  AudioService._internal();

  final player = AudioPlayer();

  // Factory constructor to return the singleton instance
  factory AudioService() {
    return _instance;
  }

  // Method to play audio
  Future<void> play(AudioType audioType) async {
    await player.setSource(AssetSource('audios/${audioType.name}.mp3'));
    await player.resume();
  }
}

enum AudioType {
  ting,
  wrong,
  none,
}
