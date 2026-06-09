import 'package:audioplayers/audioplayers.dart';
import 'cacheService.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _correctPlayer = AudioPlayer();
  final AudioPlayer _incorrectPlayer = AudioPlayer();
  final AudioPlayer _completePlayer = AudioPlayer();

  bool get isSoundEnabled => cacheService.isSoundEnabled();

  Future<void> setSoundEnabled(bool value) async {
    await cacheService.setSoundEnabled(value);
  }

  Future<void> playCorrect() async {
    if (!isSoundEnabled) return;
    await _correctPlayer.stop();
    await _correctPlayer.setSource(AssetSource('sounds/correct.wav'));
    await _correctPlayer.resume();
  }

  Future<void> playIncorrect() async {
    if (!isSoundEnabled) return;
    await _incorrectPlayer.stop();
    await _incorrectPlayer.setSource(AssetSource('sounds/incorrect.wav'));
    await _incorrectPlayer.resume();
  }

  Future<void> playComplete() async {
    if (!isSoundEnabled) return;
    await _completePlayer.stop();
    await _completePlayer.setSource(AssetSource('sounds/complete.wav'));
    await _completePlayer.resume();
  }

  void dispose() {
    _correctPlayer.dispose();
    _incorrectPlayer.dispose();
    _completePlayer.dispose();
  }
}