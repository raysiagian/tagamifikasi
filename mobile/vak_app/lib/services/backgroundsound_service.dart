import 'package:audioplayers/audioplayers.dart';

class BackgroundSoundService {
  static final BackgroundSoundService _instance = BackgroundSoundService._internal();
  factory BackgroundSoundService() => _instance;

  final AudioPlayer _audioPlayer = AudioPlayer();

  BackgroundSoundService._internal();

  Future<void> init() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('audio/Upbeat Happy Cooking by Infraction [No Copyright Music] Happy Foods.mp3'));
  }

  void pause() => _audioPlayer.pause();
  void resume() => _audioPlayer.resume();
  void stop() => _audioPlayer.stop();
}
