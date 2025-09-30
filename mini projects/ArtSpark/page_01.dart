import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'level_notifier.dart';

class BegPage extends StatelessWidget {
  const BegPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beginner Level',
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
                surfaceTintColor: Color.fromRGBO(0, 128, 128, 0.6),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Welcome to Your Creative Journey Every masterpiece begins with a single line. Here, you are not expected to be perfect — you are encouraged to be yourself. Take each stroke as a step forward, each color as a story, and each mistake as a lesson that shapes your art.',
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
                surfaceTintColor: Color.fromRGBO(0, 128, 128, 0.6),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Every artist was first an amateur. — Ralph Waldo Emerson",
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
                    'Stage 1: Lines & Control',
                    'Practice straight lines, curves, spirals.',
                    ' Focus on smooth movement, not perfection.',
                    'Exercise: fill a page with lines of varying length and thickness.',
                  ),
                  cards(
                    context,
                    'Stage 2: Basic Shapes',
                    'Learn circles, squares, rectangles, triangles.',
                    'Practice creating shapes freehand without a ruler.',
                    'Exercise: draw each shape 10 times in different sizes.',
                  ),
                  cards(
                    context,
                    'Stage 3: Combining Shapes',
                    'Combine shapes to create objects (cup, house, apple).',
                    'Learn to see objects as a combination of simple forms.',
                    'Exercise: draw at least 3 different objects by combining shapes.',
                  ),
                  cards(
                    context,
                    'Stage 4: 3D Forms',
                    'Turn shapes into forms: cube, sphere, cylinder, cone.',
                    'Practice adding depth to shapes with shading.',
                    'Exercise: draw a cube and sphere with a single light source.',
                  ),
                  cards(
                    context,
                    'Stage 5: Light & Shadow',
                    'Understand light direction and shadows.',
                    'Practice shading techniques (hatching, cross-hatching, blending).',
                    'Exercise: shade a sphere and a cube.',
                  ),
                  cards(
                    context,
                    'Stage 6: Your own sketch',
                    'Combine all beginner skills.',
                    'Draw a simple still life (cup + apple + bottle).',
                    'Exercise: complete a clean sketch with shading and perspective.',
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      surfaceTintColor: Color.fromRGBO(12, 255, 255, 0.942),
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
                          drawings(context, 'assets/images/image1.jpg', 'Moon'),
                          drawings(
                              context, 'assets/images/images2.jpg', 'Bear'),
                          drawings(
                              context, 'assets/images/images3.jpg', 'Mail'),
                          drawings(
                              context, 'assets/images/images4.jpg', 'Star'),
                          drawings(
                              context, 'assets/images/images5.jpg', 'bread'),
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
                      backgroundColor: const Color.fromARGB(255, 19, 243, 172),
                      behavior: SnackBarBehavior.floating,
                      showCloseIcon: true,
                      closeIconColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      content: Text(
                        'Beginner Level Completed! Intermediate Unlocked 🎉.',
                        style: TextStyle(color: Colors.black),
                      ),
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
                      colors: [Color(0xFF00FFD7), Color(0xFF007A65)],
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
      surfaceTintColor: Color.fromRGBO(0, 128, 128, 0.6),
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
        surfaceTintColor: Color.fromRGBO(0, 128, 128, 0.6),
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
