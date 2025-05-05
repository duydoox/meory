import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isIOS => !kIsWeb && Platform.isIOS;

  Future<void> init() async {
    await _flutterTts.awaitSpeakCompletion(true);

    if (isAndroid) {
      final engines = await _flutterTts.getEngines;
      if (engines.isNotEmpty) {
        await _flutterTts.setEngine(engines.first);
      }
      await _getDefaultEngine();
      await _getDefaultVoice();
    }

    if (isIOS) {
      await _flutterTts.setSharedInstance(true);
    }

    await _flutterTts.setLanguage("en");
    await _flutterTts.setSpeechRate(0.5); // Speed of speech
    await _flutterTts.setVolume(1.0); // Volume
    await _flutterTts.setPitch(1.0); // Pitch of voice

    _flutterTts.setStartHandler(() {
      _isPlaying = true;
      debugPrint("TTS started");
    });

    _flutterTts.setCompletionHandler(() {
      _isPlaying = false;
      debugPrint("TTS completed");
    });

    _flutterTts.setErrorHandler((msg) {
      _isPlaying = false;
      debugPrint("TTS error: $msg");
    });
  }

  Future<void> _getDefaultEngine() async {
    var engine = await _flutterTts.getDefaultEngine;
    if (engine != null) {
      debugPrint('engine success');
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await _flutterTts.getDefaultVoice;
    if (voice != null) {
      debugPrint('voice success');
    }
  }

  Future<void> speak(String text) async {
    if (_isPlaying) {
      await stop();
    }

    _isPlaying = true;
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    _isPlaying = false;
    await _flutterTts.stop();
  }

  Future<void> pause() async {
    _isPlaying = false;
    await _flutterTts.pause();
  }

  Future<void> setLanguage(String language) async {
    await _flutterTts.setLanguage(language);
  }

  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  Future<List<String>> getLanguages() async {
    final languages = await _flutterTts.getLanguages;
    return languages.cast<String>();
  }

  bool get isPlaying => _isPlaying;

  void dispose() {
    _flutterTts.stop();
  }
}
