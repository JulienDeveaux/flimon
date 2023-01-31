import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flimon App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Simon game for Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyGameState();
}

class _MyGameState extends State<MyHomePage> {
  late ConfettiController _confettiController;
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  int soundId = -1;
  List<int> colors_game = [];
  List<int> colors_user = [];
  int maxPlayCount = 4;
  int greenShade = 500;
  int redShade = 500;
  int blueShade = 500;
  int yellowShade = 500;

  final TextStyle _textStyleDefault = const TextStyle(
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _startGame() async {
      if(soundId == -1) {
        soundId = await rootBundle.load("assets/buzz.mp3").then((ByteData soundData) {
          return pool.load(soundData);
        });
      }
      colors_game = [];
      colors_user = [];
      for(int i = 0; i < maxPlayCount; i++){
        greenShade = 500;
        blueShade = 500;
        redShade = 500;
        yellowShade = 500;
        await Future.delayed(const Duration(milliseconds: 50));
        setState(() {});
        int random = Random().nextInt(4);
        colors_game.add(random);
        switch (random) {
          case 0:
            greenShade = 900;
            break;
          case 1:
            blueShade = 900;
            break;
          case 2:
            redShade = 900;
            break;
          case 3:
            yellowShade = 800;
            break;
        }
        print("0green 1blue 2red 3yellow $colors_game $maxPlayCount");
        await pool.play(soundId);
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      }
      setState(() {
        greenShade = 500;
        blueShade = 500;
        redShade = 500;
        yellowShade = 500;
      });
  }

  Future<void> _checkWin() async {
    if(soundId == -1) {
      soundId = await rootBundle.load("assets/buzz.mp3").then((ByteData soundData) {
        return pool.load(soundData);
      });
    }
    await pool.play(soundId);
    bool win = true;
    if (colors_user.length == colors_game.length) {
      for (int i = 0; i < colors_user.length; i++) {
        if (colors_user[i] != colors_game[i]) {
          win = false;
          break;
        }
      }
      if (win) {
        print("Win");
        greenShade = 500;
        blueShade = 500;
        redShade = 500;
        yellowShade = 500;
        maxPlayCount++;
        _confettiController.play();
      } else {
        greenShade = 900;
        blueShade = 900;
        redShade = 900;
        yellowShade = 800;
        print("Loose");
      }
      setState(() {
      });
    }
  }

  void _redPush() {
    setState(() {
      greenShade = 500;
      blueShade = 500;
      redShade = 900;
      yellowShade = 500;
      colors_user.add(2);
      _checkWin();
    });
  }

  void _bluePush() {
    setState(() {
      greenShade = 500;
      blueShade = 900;
      redShade = 500;
      yellowShade = 500;
      colors_user.add(1);
      _checkWin();
    });
  }

  void _greenPush() {
    setState(() {
      greenShade = 900;
      blueShade = 500;
      redShade = 500;
      yellowShade = 500;
      colors_user.add(0);
      _checkWin();
    });
  }

  void _yellowPush() {
    setState(() {
      greenShade = 500;
      blueShade = 500;
      redShade = 500;
      yellowShade = 800;
      colors_user.add(3);
      _checkWin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          GestureDetector(
              onTap: () {
                _redPush();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    color: Colors.red[redShade],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(200),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                          spreadRadius: .0,
                          offset: Offset(0, 15))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      'Red button',
                      style: _textStyleDefault,
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                ),
              )),
          GestureDetector(
            onTap: () {
              _bluePush();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  color: Colors.blue[blueShade],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(200),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 20.0,
                        spreadRadius: .0,
                        offset: Offset(0, 15))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    'Blue button',
                    style: _textStyleDefault,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _greenPush();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  color: Colors.green[greenShade],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 20.0,
                        spreadRadius: .0,
                        offset: Offset(0, 15))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    'Green button',
                    style: _textStyleDefault,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _yellowPush();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  color: Colors.yellow[yellowShade],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(200),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 20.0,
                        spreadRadius: .0,
                        offset: Offset(0, 15))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    'Yellow button',
                    style: _textStyleDefault,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.001,
              maxBlastForce: 10,
              gravity: 0.3,
              numberOfParticles: 5,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startGame,
        tooltip: 'Start game',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
