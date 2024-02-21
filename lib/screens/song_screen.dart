import 'package:flutter/material.dart';
import 'package:music_app/components/neu_box.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});
  //converting duration into min sec
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        //get playlist
        final playlist = value.playlist;
        //get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];
        return SafeArea(
          child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //app bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //back button
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)),

                        //title
                        const Text('PLAYLIST'),

                        //Menu Button
                        IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                      ],
                    ),

                    //album artwork
                    NeuBox(
                        child: Column(
                      children: [
                        Container(
                            height: 350,
                            //image
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                currentSong.albumArtImagePath,
                                fit: BoxFit.cover,
                              ),
                            )),

                        //song and artist name and icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(currentSong.artistName),
                              ],
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    )),
                    const SizedBox(
                      height: 25,
                    ),

                    //song Duration progress
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //start time
                              Text(formatTime(value.currentDuration)),

                              //shuffle icon
                              const Icon(Icons.shuffle),

                              //repeat icon
                              const Icon(Icons.repeat),

                              //end time
                              Text(formatTime(value.totalDuration)),
                            ],
                          ),
                          //song duration progress
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 0)),
                            child: Slider(
                              min: 0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              value: value.currentDuration.inSeconds.toDouble(),
                              activeColor:
                                  const Color.fromARGB(255, 142, 46, 17),
                              onChanged: (double double) {
                                //when user sliding around
                              },
                              onChangeEnd: (double double) {
                                //when sliding finished
                                value.seek(Duration(seconds: double.toInt()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    //playback contraolls
                    Row(
                      children: [
                        //skip previous
                        Expanded(
                            child: GestureDetector(
                                onTap: value.playPreviousSong,
                                child: const NeuBox(
                                    child: Icon(Icons.skip_previous)))),
                        const SizedBox(width: 20),

                        //play pause
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                                onTap: value.pauseOrResume,
                                child: NeuBox(
                                    child: Icon(value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow)))),
                        const SizedBox(width: 20),

                        //skip forward
                        Expanded(
                            child: GestureDetector(
                                onTap: value.playnextsong,
                                child: const NeuBox(
                                    child: Icon(Icons.skip_next)))),
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
