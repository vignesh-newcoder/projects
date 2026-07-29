import 'package:flutter/material.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:servicehub/pages/History/currentdata.dart';
import 'package:servicehub/pages/History/pastdata.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int selectedOption = 0;
  final PageController pg = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ServiceHub"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SegmentedButtonSlide(
            entries: [
              SegmentedButtonSlideEntry(
                label: 'Past',
              ),
              SegmentedButtonSlideEntry(
                label: 'Current',
              )
            ],
            selectedEntry: selectedOption,
            onChange: (int p) {
              setState(() {
                selectedOption = p;
              });
              pg.animateToPage(p, duration: Duration(milliseconds: 2), curve: Curves.easeOut);
            },
            slideShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(1),
                blurRadius: 10,
                spreadRadius: 5,
              )
            ],
            selectedTextStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            unselectedTextStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            hoverTextStyle: const TextStyle(
              color: Colors.grey,
            ),
            margin: const EdgeInsets.all(20),
            height: 38,
            borderRadius: BorderRadius.circular(70),
            colors: SegmentedButtonSlideColors(
              barColor: Colors.black,
              backgroundSelectedColor: Colors.white,
            ),
            padding: EdgeInsets.all(5),
          ),
          Expanded(
            child: PageView(
              controller: pg,
              onPageChanged: (index) {
                setState(() {
                  selectedOption = index;
                });
              },
              children: [
                PastData(),
                CurrentData(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
