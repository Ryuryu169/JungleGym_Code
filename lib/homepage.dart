import 'package:flutter/material.dart';

void main(){
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("ホームページ"),
      ),
      body: Column(
          children: [
            Container(
              padding:  EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: const Text("通知"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary:  Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return NoticePage();
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              final double begin = 0.0;
                              final double end = 1.0;
                              final Animatable<double> tween = Tween(
                                  begin: begin, end: end)
                                  .chain(CurveTween(curve: Curves.easeInOut));
                              final Animation<double> doubleAnimation = animation
                                  .drive(tween);
                              return FadeTransition(
                                opacity: doubleAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: const Text("フレンド"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary:  Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return FriendPage();
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              final double begin = 0.0;
                              final double end = 1.0;
                              final Animatable<double> tween = Tween(
                                  begin: begin, end: end)
                                  .chain(CurveTween(curve: Curves.easeInOut));
                              final Animation<double> doubleAnimation = animation
                                  .drive(tween);
                              return FadeTransition(
                                opacity: doubleAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: const Text("設定"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary:  Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return SettingPage();
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              final double begin = 0.0;
                              final double end = 1.0;
                              final Animatable<double> tween = Tween(
                                  begin: begin, end: end)
                                  .chain(CurveTween(curve: Curves.easeInOut));
                              final Animation<double> doubleAnimation = animation
                                  .drive(tween);
                              return FadeTransition(
                                opacity: doubleAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ]
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(150, 20, 30, 20),
              child:Column(
                  children: [
                    Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('鬼ごっこ'),
                                Text('必要人数:2人以上'),
                              ],
                            ),
                            Container(
                              width: 50,
                            ),
                            IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return OnigokkoPage();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        final Offset begin = Offset(0.0, 1.0); // 下から上
// final Offset begin = Offset(0.0, -1.0); // 上から下
                                        final Offset end = Offset.zero;
                                        final Animatable<Offset> tween = Tween(begin: begin, end: end)
                                            .chain(CurveTween(curve: Curves.easeInOut));
                                        final Animation<Offset> offsetAnimation = animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                            ),
                          ],
                        )
                    ),
                    Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('comingsoon?!'),
                                Text('????????????'),
                              ],
                            ),
                            Container(
                              width: 50,
                            ),
                            IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return HatenaPage();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        final Offset begin = Offset(0.0, 1.0); // 下から上
// final Offset begin = Offset(0.0, -1.0); // 上から下
                                        final Offset end = Offset.zero;
                                        final Animatable<Offset> tween = Tween(begin: begin, end: end)
                                            .chain(CurveTween(curve: Curves.easeInOut));
                                        final Animation<Offset> offsetAnimation = animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                            ),
                          ],
                        )
                    ),
                    Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('comingsoon?!'),
                                Text('????????????'),
                              ],
                            ),
                            Container(
                              width: 50,
                            ),
                            IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return HatenaPage();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        final Offset begin = Offset(0.0, 1.0); // 下から上
// final Offset begin = Offset(0.0, -1.0); // 上から下
                                        final Offset end = Offset.zero;
                                        final Animatable<Offset> tween = Tween(begin: begin, end: end)
                                            .chain(CurveTween(curve: Curves.easeInOut));
                                        final Animation<Offset> offsetAnimation = animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                            ),
                          ],
                        )
                    ),
                    Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('comingsoon?!'),
                                Text('????????????'),
                              ],
                            ),
                            Container(
                              width: 50,
                            ),
                            IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return HatenaPage();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        final Offset begin = Offset(0.0, 1.0); // 下から上
// final Offset begin = Offset(0.0, -1.0); // 上から下
                                        final Offset end = Offset.zero;
                                        final Animatable<Offset> tween = Tween(begin: begin, end: end)
                                            .chain(CurveTween(curve: Curves.easeInOut));
                                        final Animation<Offset> offsetAnimation = animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                            ),
                          ],
                        )
                    ),
                    Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('comingsoon?!'),
                                Text('????????????'),
                              ],
                            ),
                            Container(
                              width: 50,
                            ),
                            IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return HatenaPage();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        final Offset begin = Offset(0.0, 1.0); // 下から上
// final Offset begin = Offset(0.0, -1.0); // 上から下
                                        final Offset end = Offset.zero;
                                        final Animatable<Offset> tween = Tween(begin: begin, end: end)
                                            .chain(CurveTween(curve: Curves.easeInOut));
                                        final Animation<Offset> offsetAnimation = animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                            ),
                          ],
                        )
                    ),
                    Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('comingsoon?!'),
                                Text('????????????'),
                              ],
                            ),
                            Container(
                              width: 50,
                            ),
                            IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return HatenaPage();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        final Offset begin = Offset(0.0, 1.0); // 下から上
// final Offset begin = Offset(0.0, -1.0); // 上から下
                                        final Offset end = Offset.zero;
                                        final Animatable<Offset> tween = Tween(begin: begin, end: end)
                                            .chain(CurveTween(curve: Curves.easeInOut));
                                        final Animation<Offset> offsetAnimation = animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                            ),
                          ],
                        )
                    ),
                  ]
              ),
            ),
          ]
      ),
    );
  }
}

class NoticePage extends StatelessWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("通知"),
      ),
      body: Column(),
    );
  }
}

class FriendPage extends StatelessWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("フレンドリスト"),
      ),
      body: Column(),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("設定"),
      ),
      body: Column(),
    );
  }
}

class OnigokkoPage extends StatelessWidget {
  const OnigokkoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("鬼ごっこ"),
      ),
      body: Column(),
    );
  }
}

class HatenaPage extends StatelessWidget {
  const HatenaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("comingsoon"),
      ),
      body: Column(),
    );
  }
}






