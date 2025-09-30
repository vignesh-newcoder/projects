import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ArtSpark/level_notifier.dart';

class InterPage extends StatelessWidget {
  const InterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Intermediate level',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 10.0,
                surfaceTintColor: Color.fromRGBO(65, 105, 225, 0.6),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Welcome back! We're thrilled you've mastered the basics and are ready to advance your skills. This Intermediate section is where you stop just drawing what you see and start drawing what you know.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
              child: Card(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 10.0,
                surfaceTintColor: Color.fromRGBO(65, 105, 225, 0.6),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "If I could say it in words, there would be no reason to paint.— Edward Hopper",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  cards(
                    context,
                    'Stage 1: Observation & Gesture',
                    'Practice gesture sketches (30s–2min) to capture quick poses.',
                    'Focus on movement and flow, not details.',
                    'Exercise: Do 5 gesture drawings (30s–2min each).',
                  ),
                  cards(
                    context,
                    'Stage 2:  Proportions & Figures',
                    'Learn basic human proportions (head-to-body ratio).',
                    'Practice blocky/mannequin figures.',
                    'Exercise: Draw a standing figure using simple blocks.',
                  ),
                  cards(
                    context,
                    'Stage 3: Perspective & Space',
                    'Review 1-point and 2-point perspective.',
                    'Practice drawing rooms, streets, or boxes.',
                    'Exercise: Sketch a simple street with buildings.',
                  ),
                  cards(
                    context,
                    'Stage 4: Shading & Texture',
                    'Learn light source basics and shading values.',
                    'Try smooth shading + hatching for textures.',
                    'Exercise: Shade a sphere and cube with 2 pencils.',
                  ),
                  cards(
                    context,
                    'Stage 5: Composition & Mini Project',
                    'Learn rule of thirds and focal points.',
                    'Make thumbnail sketches to test layouts.',
                    'Exercise: Create a small still life using perspective + shading.',
                  ),
                  cards(
                    context,
                    'Stage 6: Your own sketch',
                    'Learn rule of thirds and focal points.',
                    'Combine skills into a finished piece.',
                    'Exercise: Draw a still life (cup, fruit, book) with perspective + shading.',
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      surfaceTintColor: Color.fromRGBO(65, 105, 225, 0.6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Samples for Practice',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Icon(Icons.forward),
                            ],
                          ),
                          drawings(context, 'assets/images/images_inter_01.jpg',
                              'Cup'),
                          drawings(context, 'assets/images/images_inter_02.jpg',
                              'Mobile'),
                          drawings(context, 'assets/images/images_inter_03.jpg',
                              'Boat'),
                          drawings(context, 'assets/images/images_inter_04.jpg',
                              'Whale'),
                          drawings(context, 'assets/images/images_inter_05.jpg',
                              'Sun Set'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextButton(
                onPressed: () {
                  context.read<LevelNotifier>().markIntermediateCompleted();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color.fromARGB(255, 91, 152, 226),
                      behavior: SnackBarBehavior.floating,
                      showCloseIcon: true,
                      closeIconColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      content: Text(
                          'Intermediate Level is Completed! Advance Level is unlocked 🎉.',
                          style: TextStyle(color: Colors.black)),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.95,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 30, 153, 235),
                        Color(0xFF6dd5ed)
                      ],
                      begin: AlignmentGeometry.topRight,
                      end: AlignmentGeometry.bottomRight,
                    ),
                  ),
                  child: Text(
                    'Completed',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.antonio(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cards(BuildContext context, String heading, String content1, content2,
      content3) {
    return Card(
      surfaceTintColor: Color.fromRGBO(65, 105, 225, 0.6),
      elevation: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Text(
              heading,
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Divider(color: Colors.black87),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
            child: Text(
              '◾  $content1',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
            child: Text(
              '◾  $content2',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
            child: Text(
              '◾  $content3',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawings(BuildContext context, String path, String name) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Card(
        surfaceTintColor: Color.fromRGBO(65, 105, 225, 0.6),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 249, 249, 249), width: 2.0),
        ),
        elevation: 10.0,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                height: 220,
                width: 250,
                path,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  name,
                  style: GoogleFonts.ruda(
                      fontWeight: FontWeight.normal, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
