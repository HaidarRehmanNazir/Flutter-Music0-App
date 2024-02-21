import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/screens/song_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //get the playlist provider
  late final dynamic playlistprovider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get playlist provider
    playlistprovider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  //go to song
  void goToSong(int songindex) {
    //update current song index
    playlistprovider.currentSongIndex = songindex;

    //Navigate to song page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SongScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('PLAYLIST'),
        centerTitle: true,
      ),
      drawer: MyAppDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        //get the playlist
        final List<Song> playlist = value.playlist;

        //return listview UI
        return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              //get individual song
              final Song song = playlist[index];

              //return listtile UI
              return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtImagePath),
                  onTap: () {
                    return goToSong(index);
                  });
            });
      }),
    );
  }
}
