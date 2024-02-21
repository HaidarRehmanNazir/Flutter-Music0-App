import 'package:flutter/material.dart';
import 'package:music_app/screens/settings_screen.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //Logo
          DrawerHeader(
              child: Center(
            child: Icon(
              Icons.music_note,
              size: 40,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          )),

          //HomeTile
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              title: Text('HOME'),
              leading: Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
          ),

          //Setting Tile
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: ListTile(
              title: Text('SETTINGS'),
              leading: Icon(Icons.settings),
              onTap: () {
                //pop Drawer
                Navigator.pop(context);
                //Navigate to settings screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
