import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/music-splash.jpg',
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 20),
              Text(
                'S0 Music',
                style: GoogleFonts.aBeeZee(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Songs are the therapy of mind',
                style: GoogleFonts.aBeeZee(
                  color: const Color.fromARGB(255, 136, 136, 136),
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color.fromARGB(255, 69, 68, 68),
                  ),
                  child: Center(
                    child: Text(
                      'Enter',
                      style: GoogleFonts.aBeeZee(
                        color: Color.fromARGB(255, 164, 136, 0),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
