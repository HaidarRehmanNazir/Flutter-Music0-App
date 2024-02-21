import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  //Playlist of Songs
  final List<Song> _playlist = [
    //song1
    Song(
        songName: 'Maharani',
        artistName: 'Karun',
        albumArtImagePath: 'assets/images/img1.jpg',
        audioPath: 'assets/audio/maharani.mp3'),

    //song2
    Song(
        songName: 'Guman',
        artistName: 'Tallah Anjum',
        albumArtImagePath: 'assets/images/img2.jpg',
        audioPath: 'assets/audio/guman.mp3'),

    //song3
    Song(
        songName: 'Yad',
        artistName: 'Asim Azhar and Young Stunners',
        albumArtImagePath: 'assets/images/img3.jpg',
        audioPath: 'assets/audio/yad.mp3'),

    //song4
    Song(
        songName: 'Stan',
        artistName: 'Eminem',
        albumArtImagePath: 'assets/images/img4.jpg',
        audioPath: 'assets/audio/stan.mp3'),
  ];
  //current song play list index
  int? _currentSongIndex;

  //AUDIO PLAYERS

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  //constructor
  PlaylistProvider() {
    listenToDuration();
  }
  //initialy not playing
  bool _isPlaying = false;
  //play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(AssetSource(path)); //play the new song

    _isPlaying = true;
    notifyListeners();
  }

  //pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playnextsong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < playlist.length - 1) {
        //go to the next song if it's no the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //if it's the last song loop back to the last song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async {
    //if more than 2 seconds have passed,restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    //if it's within firt 2 seconds of the song ,go to previous song
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //if it's the first song loop back to the last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //list to duration
  void listenToDuration() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playnextsong();
    });
  }
  //dispose audio player

  //GETTERS
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //SETTERS
  set currentSongIndex(int? newIndex) {
    //update current song index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play(); //play the song at the new index
    }
    //update Ui
    notifyListeners();
  }
}
