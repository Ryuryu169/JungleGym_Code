import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Settings/Settings.dart';
import '../Login/LoginPage.dart';
import '../Chats/rooms.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  User? _user;
  int currentIndex = 0;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

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
        title: const Text("Home Page"),
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
              }),
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
              }),
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
            icon: Icon(Icons.home),
            label: "Onigokko",
          ),
          BottomNavigationBarItem(
            activeIcon: TrackIcon(colorValue: Colors.white70),
            icon: TrackIcon(colorValue: Color(0x00aaaaaa)),
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
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
        ],
      ),
    );
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      _user = FirebaseAuth.instance.currentUser;
      if (_user?.uid == null) {
        if (kDebugMode) {
          print(_user?.uid);
        }
        if (!mounted) return;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

class TrackIcon extends StatelessWidget {
  final Color colorValue;
  const TrackIcon({super.key, required this.colorValue});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Image.asset(
        "assets/icons/wolf.png",
        height: 30,
        color: colorValue,
      ),
    );
  }
}