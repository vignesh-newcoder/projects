import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ArtSpark/level_notifier.dart';

class AdvancePage extends StatelessWidget {
  const AdvancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advance Level',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
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
                surfaceTintColor: Color.fromRGBO(254, 0, 0, 0.985),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Art is not what you see, but what you make others see.— Edgar Degas",
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
                surfaceTintColor: Color.fromRGBO(220, 20, 60, 0.85),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'At this stage, you’re no longer just learning techniques — you’re refining them, experimenting with your own style, and creating artwork that tells a story.',
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
                    'Stage 1: Advanced Anatomy & Realism',
                    'Study dynamic poses and facial expressions.',
                    'Study dynamic poses and facial expressions.',
                    'Exercise: Sketch a figure in motion (running, jumping, dancing).',
                  ),
                  cards(
                    context,
                    'Stage 2: Advanced Perspective & Environments',
                    'Master 3-point perspective and atmospheric depth.',
                    'Work on large scenes with multiple objects.',
                    'Exercise: Draw a dramatic cityscape or mountain landscape.',
                  ),
                  cards(
                    context,
                    'Stage 3: Color Mastery & Painting Techniques',
                    'Experiment with advanced color schemes (triadic, tetradic).',
                    'Use layering and blending for depth in digital/traditional art.',
                    'Exercise: Paint a still life with dramatic lighting and mood.',
                  ),
                  cards(
                    context,
                    'Stage 4: Storytelling & Composition',
                    'Learn how framing, lighting, and subject placement create stories.',
                    'Explore mood-driven compositions.',
                    'Exercise: Create an illustration that tells a short emotional story.',
                  ),
                  cards(
                    context,
                    'Stage 5: Personal Style Development',
                    'Experiment with different art styles (realism, abstract, impressionism).',
                    'Begin identifying and refining your unique artistic style.',
                    'Exercise: Redraw one of your beginner-level artworks in your new style.',
                  ),
                  cards(
                    context,
                    'Stage 6: Sketch your own',
                    'Combine everything you’ve learned: anatomy, perspective, shading, color, and storytelling.',
                    'Create a professional-quality artwork or portfolio piece',
                    'Exercise: Prepare a finished project (digital painting, canvas art, or detailed sketch series) and present it as your signature artwork.',
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      surfaceTintColor: Color.fromRGBO(220, 20, 60, 0.85),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Samples for Practice',
                                  style: GoogleFonts.carme(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Icon(Icons.forward),
                            ],
                          ),
                          drawings(context,
                              'assets/images/images_advance_01.jpg', 'camera'),
                          drawings(
                              context,
                              'assets/images/images_advance_02.jpg',
                              'Mountain'),
                          drawings(context,
                              'assets/images/images_advance_03.jpg', 'Jar'),
                          drawings(
                              context,
                              'assets/images/images_advance_04.jpg',
                              'Light house'),
                          drawings(
                              context,
                              'assets/images/images_advance_05.jpg',
                              'Umbrella'),
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
                  context.read<LevelNotifier>().markBeginnerCompleted();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color.fromRGBO(220, 20, 60, 1),
                      behavior: SnackBarBehavior.floating,
                      showCloseIcon: true,
                      closeIconColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      content: Text(
                          'The Advance Level is completed! Congratualtions a new artist has been born🎉.',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      duration: Duration(seconds: 10),
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
                        Color(0xFFDC143C),
                        Color(0xFF8B0000),
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
      surfaceTintColor: Color.fromRGBO(220, 20, 60, 0.85),
      elevation: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Text(
              heading,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
        surfaceTintColor: Color.fromRGBO(220, 20, 60, 0.85),
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
