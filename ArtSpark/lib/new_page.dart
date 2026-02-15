import 'package:flutter/material.dart';
import 'package:ArtSpark/advance.dart';
import 'package:ArtSpark/beg.dart';
import 'package:ArtSpark/inter.dart';
import 'package:provider/provider.dart';
import 'level_notifier.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});
  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelNotifier>();
    bool intermediateVisible = levelState.isBeginnerCompleted;
    bool advancedVisible = levelState.isIntermediateCompleted;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Background image.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                    child: Text(
                      'Select an level',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: components(context, 'Beginner Level   ✏️',
                        [Color(0xFF40E0D0), Color(0xFF008000)], BegPage()),
                  ),
                  Visibility(
                    visible: intermediateVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: components(context, "Intermediate Level  🖌️",
                          [Color(0xFFFF007F), Color(0xFFFFD700)], InterPage()),
                    ),
                  ),
                  Visibility(
                    visible: advancedVisible,
                    child: components(context, 'Advanced Level    🎨',
                        [Color(0xFFFF416C), Color(0xFFFF4B2B)], AdvancePage()),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Container components(BuildContext context, String name,
      List<Color> gradientcolors, Widget page) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width / 1.15,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientcolors,
          begin: AlignmentGeometry.topRight,
          end: AlignmentGeometry.bottomRight,
        ),
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            },
            icon: Icon(Icons.arrow_forward_ios_sharp),
          )
        ],
      ),
    );
  }
}
