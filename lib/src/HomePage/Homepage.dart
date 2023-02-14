import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FirstPage/FirstJinrou.dart';
import '../FirstPage/FirstOnigo.dart';
import '../Settings/Settings.dart';
import '../Chats/rooms.dart';
import 'TrackIcon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("ホームページ", style: GoogleFonts.kiwiMaru()),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push<void>(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const SettingPage();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const double begin = 0.0;
                    const double end = 1.0;
                    final Animatable<double> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<double> doubleAnimation =
                        animation.drive(tween);
                    return FadeTransition(
                      opacity: doubleAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push<void>(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const RoomsPage();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const double begin = 0.0;
                    const double end = 1.0;
                    final Animatable<double> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<double> doubleAnimation =
                        animation.drive(tween);
                    return FadeTransition(
                      opacity: doubleAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[500],
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );

          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: "Onigokko",
          ),
          BottomNavigationBarItem(
            activeIcon: TrackIcon(colorValue: Colors.blue),
            icon: TrackIcon(colorValue: Colors.grey),
            label: "Jinrou",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.construction),
            label: "Coming soon",
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            currentIndex = page;
          });
        },
        children: <Widget>[
          const FirstTag(),
          const FirstJinrou(),
          Container(color: Colors.green),
        ],
      ),
    );
  }
}
