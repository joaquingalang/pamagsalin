import 'package:audioplayers/audioplayers.dart';

class PlaylistPlayer {
  final AudioPlayer _player = AudioPlayer();
  final List<String> _filePaths;
  int _currentIndex = 0;

  PlaylistPlayer(this._filePaths) {
    _player.onPlayerComplete.listen((event) {
      _playNext();
    });
  }

  Future<void> play() async {
    if (_filePaths.isEmpty) return;

    _currentIndex = 0;
    await _player.play(DeviceFileSource(_filePaths[_currentIndex]));
  }

  Future<void> _playNext() async {
    _currentIndex++;
    if (_currentIndex < _filePaths.length) {
      print('Path ${_currentIndex + 1}: ${_filePaths[_currentIndex]}');
      await _player.play(DeviceFileSource(_filePaths[_currentIndex]));
    } else {
      print("Playlist finished");
    }
  }

  void stop() {
    _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}
